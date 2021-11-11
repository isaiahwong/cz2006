# Folder Structure
```
api     # contains protobuf definitions
fitness # SoFit Flutter client application
hiit    # SoFit HIIT Backend Server
pose    # SoFit PoseNet Server
```

# Running SoFit Client
In order to run the SoFit Client, flutter SDK has to be installed. Either `XCode` or `android studio` has to be installed to run SoFit. 
[Flutter install](https://flutter.dev/docs/get-started/install)

# iOS instructions on running flutter 

## Running the application on iPhone
```
# In root directory
$ cd fitness
$ # Enable provisioning profile for your device
$ open ios/Runner.xcworkspace 
$ flutter run --release
```

# Running SoFit PoseNet and HIIT Backend

## HIIT Backend
In order to run HIIT backend, go has to be installed. [Install here](https://golang.org/dl/)
```
$ cd hiit && go run main.go
```

## PoseNet 
It is recommended that you run PoseNet server on a virtualenv
```
$ cd pose
$ python3 -m venv pose_env
$ source pose_env/bin/activate
$ pip3 freeze > requirements.txt
$ cd src
$ make 
```

## Docker Compose
It is recommended that you build the image locally as the hosted image is not up to date.
### Caveats
 PoseNet has not been optimised to run on containers and hence the performance is not satisfactory. 
```
$ cd pose
$ make build
$ cd ../hiit
$ make build
$ cd ../ && docker-compose up
```



