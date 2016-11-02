package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.ListenAndServe(":8080", nil)
  fmt.Println("listening on port 8080..")
}
