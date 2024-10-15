# Multi State Store Counter
This is a state full counter application that runs a counter, stores the value in a state store to ensure persistence. 

There are two state store 
- Redis 
- SQL lite

This sample application is to show that Dapr State store can connect to both NoSQL and SQL based data stores. 

*NOTE: Dapr only allows for saving and retriving values in a key/value pair format, even for SQL based data stores*


### Run the console application in the local machine with Dapr and the application in separate runtime. 
```
dapr run --app-id DaprCounter dotnet run
```
