gen-all:
	make gen-dart-target
	make gen-python-target
	make gen-go-target

gen-dart:
	if [ ! -d "gen" ]; then \
			mkdir gen; \
	fi

	if [ ! -d "gen/dart" ]; then \
			mkdir gen/dart; \
	fi

	if [ ! -d "gen/dart/lib" ]; then \
			mkdir gen/dart/lib; \
	fi
	
	protoc \
		-I ./ \
		--dart_out=grpc:./gen/dart/lib \
		./*.proto

gen-dart-target:	
	dart pub global activate protoc_plugin  
	protoc \
		-I ./ \
		--dart_out=grpc:../fitness/api/lib \
		./*.proto

gen-python:
	python3 -m grpc_tools.protoc -I./ --python_out=./gen/python --grpc_python_out=./gen/python ./*.proto

gen-python-target:
	python3 -m grpc_tools.protoc -I./ --python_out=../pose/src/api --grpc_python_out=../pose/src/api ./*.proto

gen-go-target:
	protoc \
		-I./ \
		--go_out ../hiit/api \
		--go-grpc_out ../hiit/api \
		--go_opt paths=source_relative \
		--go-grpc_opt paths=source_relative \
		./*.proto