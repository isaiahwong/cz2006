gen-all:
	make gen-dart-target
	make gen-python-target

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
	protoc \
		-I ./ \
		--dart_out=grpc:../fitness/api/lib \
		./*.proto

gen-python:
	python3 -m grpc_tools.protoc -I./ --python_out=./gen/python --grpc_python_out=./gen/python ./*.proto

gen-python-target:
	python3 -m grpc_tools.protoc -I./ --python_out=../pose/src/api --grpc_python_out=../pose/src/api ./*.proto
		