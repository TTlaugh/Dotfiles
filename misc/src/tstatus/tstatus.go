package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strings"
	"sync"
)

type color struct {
    RED, GREEN, BOLD, RESET string
}
var cols = color {
    RED   : "\033[31m",
    GREEN : "\033[32m",
    BOLD  : "\033[1m",
    RESET : "\033[m",
}
func ping(ip string) bool {
    err := exec.Command("ping", "-W", "1", "-c", "1", ip).Run()
    if err != nil { return false }
    return true
}
func getStatus(ip, dns string, out chan<- string, waitgroup *sync.WaitGroup) {
    defer waitgroup.Done()
    var statusColor string
    if ping(ip) {
        statusColor=fmt.Sprint(cols.BOLD, cols.GREEN)
    } else {
        statusColor=fmt.Sprint(cols.BOLD, cols.RED)
    }
    out <- fmt.Sprintf("%s%s %s\t%s\n", statusColor, cols.RESET, ip, dns)
}

func main() {
    ch := make(chan string)
    var waitgroup sync.WaitGroup

    jsonOutput, _ := exec.Command("tailscale", "status", "--json").CombinedOutput()
    var payload map[string]interface{}
    _ = json.Unmarshal(jsonOutput, &payload)
    peers := payload["Peer"].(map[string]interface{})
    for nodeKey := range peers {
        nodeData := peers[nodeKey].(map[string]interface{})
        ip4      := nodeData["TailscaleIPs"].([]interface{})[0].(string)
        dns      := nodeData["DNSName"].(string)

        waitgroup.Add(1)
        go getStatus(ip4, dns, ch, &waitgroup)
    }

    go func() {
        waitgroup.Wait()
        close(ch)
    }()

    var strbuilder strings.Builder
    for eachResult := range ch {
        strbuilder.WriteString(eachResult)
    }
    fmt.Fprint(os.Stdout, strbuilder.String())
}

