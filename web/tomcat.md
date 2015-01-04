# eclipseへのTomcat初期設定など

## environments

```
Tomcat: v8.0.15
eclipse: v4.4.1
Java: v1.7.0_72
```

## 1. Preference -> Tomcat

```.sh
# Tomcat Home
/usr/local/Cellar/tomcat/8.0.15

# Context
Server.xml
```

## 2. Preference -> Server -> Runtime Environments -> Add

```.sh
# Name
Apache Tomcat v8.0

# installation Directory
/usr/local/Cellar/tomcat/8.0.15/libexec
```
