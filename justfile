# compile and run main
cr *ARGS:
	nim c -o:bin/nnotes -r src/nnotes.nim {{ARGS}}

# runs the compiled exe if there is one
run *ARGS: 
	./bin/nnotes {{ARGS}}

# clean all build artifacts
clean:
	rm bin/*  


