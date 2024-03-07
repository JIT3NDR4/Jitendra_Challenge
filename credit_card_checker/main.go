// To Run: > go run main.go
package main

import (
	"fmt"
	"regexp"
	"strings"
)

func checkContinuous(cc_number string) bool {
	n := len(cc_number)
	if n < 16 {
		return false
	}
	for i := 0; i < n-4; i++ {
		if cc_number[i] == cc_number[i+1] && cc_number[i] == cc_number[i+2] && cc_number[i] == cc_number[i+3] {
			return false
		}
	}

	return true
}

func match(cc_number string) bool {
	r1 := regexp.MustCompile(`^[4-6][0-9]{3}-?[0-9]{4}-?[0-9]{4}-?[0-9]{4}`)
	match1 := r1.Match([]byte(cc_number))
	tmp := strings.ReplaceAll(cc_number, "-", "")
	if match1 && checkContinuous(tmp) {
		return true
	}
	return false
}

func main() {
	test_cc := []string{
		"4123456789123456",          // Valid
		"5123-4567-8912-3456",       //Valid
		"61234-567-8912-3456",       // Invalid
		"4123356789123456",          //Valid
		"5133-3367-8912-3456",       // Invalid
		"5123 - 3567 - 8912 - 3456", // Invalid
	}
	for _, cc := range test_cc {
		if match(cc) {
			fmt.Println("valid")
		} else {
			fmt.Println("Invalid")
		}
	}
}
