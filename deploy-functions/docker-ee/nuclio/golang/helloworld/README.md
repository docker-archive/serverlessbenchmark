

```
nuctl deploy my-function \
	--path . \
	--runtime golang \
	--handler main.go:M \
	--namespace nuclio
```
