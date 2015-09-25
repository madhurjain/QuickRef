##### Setup WiFi

```sh
sudo vim /etc/wpa_supplicant/wpa_supplicant.conf
```

add to last

```
network={
  ssid="your_wifi_ssid"
  psk="your_wifi_password"
}
```

restart wifi network interface

```sh
sudo ifdown wlan0
sudo ifup wlan0
```

##### Static IP

```sh
sudo vim /etc/network/interfaces
```

```
auto wlan0
 
iface lo inet loopback
iface eth0 inet dhcp
 
allow-hotplug wlan0
iface wlan0 inet static
address 192.168.1.155
netmask 255.255.255.0
gateway 192.168.1.1
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp
```


##### LIRC

```sh
sudo apt-get install lirc
```

##### Load LIRC Driver for RaspberryPi GPIO

```sh
sudo vim /etc/modules
```

```
lirc_dev
lirc_rpi gpio_in_pin=23 gpio_out_pin=22
```