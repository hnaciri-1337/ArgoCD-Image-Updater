const http = require("http");

const PORT = 1337;

const message = process.env.MESSAGE || "IoT Playground - v2.0.1";

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end(`${message}\n`);
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
