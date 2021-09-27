package internal

import (
	"context"
	"fmt"
	"math/rand"
	"os"
	"os/signal"
	"regexp"
	"strings"
	"sync"
	"syscall"
	"time"

	"github.com/sirupsen/logrus"
	"google.golang.org/grpc/metadata"
)

func NewLogrusLogger() *logrus.Logger {
	log := logrus.New()

	logrus.Trace()

	// Log as JSON instead of the default ASCII formatter.
	// log.SetFormatter(&logrus.JSONFormatter{})

	// Output to stdout instead of the default stderr
	// Can be any io.Writer, see below for File example
	log.SetOutput(os.Stdout)

	// Only log the warning severity or above.
	log.SetLevel(logrus.InfoLevel)
	// log.SetReportCaller(true)

	return log
}

type ErrorChannel struct {
	C      chan error
	closed bool
	mutex  sync.Mutex
}

func NewErrorChannel() *ErrorChannel {
	return &ErrorChannel{C: make(chan error)}
}

func (ec *ErrorChannel) Close() {
	ec.mutex.Lock()
	defer ec.mutex.Unlock()
	if !ec.closed {
		close(ec.C)
		ec.closed = true
	}
}

func (ec *ErrorChannel) IsClosed() bool {
	ec.mutex.Lock()
	defer ec.mutex.Unlock()
	return ec.closed
}

// MapEnvWithDefaults returns a default value if the environment
// variable is empty
func MapEnvWithDefaults(envKey string, defaults string) string {
	v := os.Getenv(envKey)
	if v == "" {
		return defaults
	}
	return v
}

// GetMetadataValue is a helper function that returns value stored in metadata
func GetMetadataValue(ctx context.Context, key string) string {
	mdC, ok := metadata.FromIncomingContext(ctx)
	if ok {
		if len(mdC.Get(key)) > 0 {
			return mdC.Get(key)[0]
		}
	}
	return ""
}

func GetMetadata(ctx context.Context) map[string]string {
	m := make(map[string]string)
	mdC, ok := metadata.FromIncomingContext(ctx)
	if ok && mdC.Len() > 0 {
		for k, v := range mdC {
			if len(mdC.Get(k)) > 0 {
				m[k] = v[0]
			}
		}
	}
	return m
}

const letterBytes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
const (
	letterIdxBits = 6                    // 6 bits to represent a letter index
	letterIdxMask = 1<<letterIdxBits - 1 // All 1-bits, as many as letterIdxBits
	letterIdxMax  = 63 / letterIdxBits   // # of letter indices fitting in 63 bits
)

func RandStringBytesMaskImprSrcSB(n int) string {
	var src = rand.NewSource(time.Now().UnixNano())
	sb := strings.Builder{}
	sb.Grow(n)
	// A src.Int63() generates 63 random bits, enough for letterIdxMax characters!
	for i, cache, remain := n-1, src.Int63(), letterIdxMax; i >= 0; {
		if remain == 0 {
			cache, remain = src.Int63(), letterIdxMax
		}
		if idx := int(cache & letterIdxMask); idx < len(letterBytes) {
			sb.WriteByte(letterBytes[idx])
			i--
		}
		cache >>= letterIdxBits
		remain--
	}

	return sb.String()
}

func TrimSpacesSlice(strs []string) (_strs []string) {
	for _, str := range strs {
		_strs = append(_strs, regexp.MustCompile(`\s+`).ReplaceAllString(str, " "))
	}
	return
}

func TrimSpaces(str string) string {
	space := regexp.MustCompile(`\s+`)
	return space.ReplaceAllString(str, " ")
}

// image formats and magic numbers
var magicTable = map[string]string{
	"\xff\xd8\xff":      "image/jpeg",
	"\x89PNG\r\n\x1a\n": "image/png",
	"GIF87a":            "image/gif",
	"GIF89a":            "image/gif",
}

// MimeFromIncipit returns the mime type of an image file from its first few
// bytes or the empty string if the file does not look like a known file type
func MimeFromIncipit(incipit []byte) string {
	for magic, mime := range magicTable {
		if strings.HasPrefix(string(incipit), magic) {
			return mime
		}
	}
	return ""
}

var magicTableExt = map[string]string{
	"\xff\xd8\xff":      ".jpeg",
	"\x89PNG\r\n\x1a\n": ".png",
	"GIF87a":            ".gif",
	"GIF89a":            ".gif",
}

func ExtFromIncipit(incipit []byte) string {
	incipitStr := []byte(incipit)
	for magic, mime := range magicTableExt {
		if strings.HasPrefix(string(incipitStr), magic) {
			return mime
		}
	}
	return ""
}

// SignalContext which listens for a signal term which then
// cancels any operations with current context
func SignalContext(ctx context.Context) context.Context {
	ctx, cancel := context.WithCancel(ctx)

	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)

	go func() {
		<-sigs
		signal.Stop(sigs)
		close(sigs)

		// breaks line for trailing ^C
		fmt.Println()
		cancel()
	}()

	return ctx
}
