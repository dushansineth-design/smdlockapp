// lib/config.dart
/// Put the IP that your ESP32 is actually using (from Serial Monitor).
/// If you use the ESP32 Access Point mode, the typical AP IP is 192.168.4.1.
/// If you use WiFi STA (ESP connected to router), use the STA IP shown, e.g. 192.168.1.23
const String esp32Ip = '192.168.4.1'; // <- CHANGE this to the IP shown in Serial Monitor
const int esp32Port = 80;             // ESP32 default HTTP port is usually 80
const bool useDoorsEndpoint = false;  // set true if your ESP32 provides GET /doors (JSON)