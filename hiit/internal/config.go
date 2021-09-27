package internal

import (
	"fmt"
	"strconv"
	"time"

	"github.com/joho/godotenv"
)

// EnvConfig Application wide env configurations
//
// AppEnv specifies if the app is in `development` or `production`
// Host specifies host address or dns
// Port specifies the port the server will run on
// DBUri
// DBName
// DBUser
// DBPassword
type EnvConfig struct {
	AppEnv           string
	Production       bool
	Host             string
	Address          string
	SecureAddress    string
	CertFile         string
	KeyFile          string
	DBUri            string
	DBName           string
	DBUser           string
	DBPassword       string
	DBTimeout        time.Duration
	DBInitialTimeout time.Duration
	ServiceTimeout   time.Duration
	RedisAddr        string
	RedisPassword    string
}

// LoadEnv loads environment variables for Application
func LoadEnv() *EnvConfig {
	err := godotenv.Load()
	if err != nil {
		fmt.Printf(".env not loaded: %v\n", err)
	}

	// Convert to int
	sec, err := strconv.ParseInt(MapEnvWithDefaults("DB_TIMEOUT", "10"), 10, 64)
	if err != nil {
		fmt.Printf("Error parsing DB_TIMEOUT: %v\nWill fallback to default value", err)
		sec = 10
	}
	dBTimeout := time.Duration(sec) * time.Second

	sec, err = strconv.ParseInt(MapEnvWithDefaults("DB_INITIAL_TIMEOUT", "10"), 10, 64)
	if err != nil {
		fmt.Printf("Error parsing DB_INITIAL_TIMEOUT: %v\nWill fallback to default value", err)
		sec = 10
	}
	initialTimeout := time.Duration(sec) * time.Second

	sec, err = strconv.ParseInt(MapEnvWithDefaults("SERVICE_TIMEOUT", "60"), 10, 64)
	if err != nil {
		fmt.Printf("Error parsing SERVICE_TIMEOUT: %v\nWill fallback to default value", err)
		sec = 60
	}
	serviceTimeout := time.Duration(sec) * time.Second

	return &EnvConfig{
		AppEnv:           MapEnvWithDefaults("APP_ENV", "development"),
		Production:       MapEnvWithDefaults("APP_ENV", "development") == "production",
		Address:          MapEnvWithDefaults("ADDRESS", ":50051"),
		SecureAddress:    MapEnvWithDefaults("SECURE_ADDRESS", ":50052"),
		KeyFile:          MapEnvWithDefaults("CERT_FILE", "/go/bin/cert/server.key"),
		CertFile:         MapEnvWithDefaults("KEY_FILE", "/go/bin/cert/server.crt"),
		DBUri:            MapEnvWithDefaults("DB_URI", "mongodb://localhost:27017"),
		DBName:           MapEnvWithDefaults("DB_NAME", "profile"),
		DBUser:           MapEnvWithDefaults("MONGO_USERNAME", ""),
		DBPassword:       MapEnvWithDefaults("MONGO_PASSWORD", ""),
		DBTimeout:        dBTimeout,
		DBInitialTimeout: initialTimeout,
		ServiceTimeout:   serviceTimeout,
		RedisAddr:        MapEnvWithDefaults("REDIS_ADDR", "localhost:6379"),
		RedisPassword:    MapEnvWithDefaults("REDIS_PASSWORD", ""),
	}
}
