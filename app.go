package main

import (
	"fmt"
	"net/http"
)

func handler(rw http.ResponseWriter, req *http.Request) {
	resp, _ := http.Get("http://www.google.com")
	fmt.Fprintf(rw, "hi, you requestet: %s", req.URL.Path[1:], resp)
}

// FileServer  --> Dateien rausgeben
// routePath's --> spezifisch reagieren
func main() {
	http.HandleFunc("/helloworld", handler)
	http.Handle("/", http.FileServer(http.Dir("public/")))

	http.ListenAndServe(":8080", nil)
	fmt.Println("listening on port 8080..")
}
