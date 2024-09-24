## Reason 
This was a sample project created to test out pub-sub methodology using dapr. 

## Contents
This project contains 
- Checkout: A console application publishing events 
- Order-Processor: A webapp subscribing to the events

# Ways to run the project

# Docker 
-> Create docker images for both `order-processor` and `checkout` by running the following commands

### Checkout
- `cd checkout`
- `docker build -t <docker-image-name> -f Dockerfile .`

### Order Processor 
- `cd order-processor`
- `docker build -t <docker-image-name> -f Dockerfile .`

-> Create containers by running them with `dapr` context

### Checkout
- `cd checkout`
- `dapr run --app-id checkout --app-port 7008 --resources-path ../components/ -- dotnet run --urls http://localhost:7008`

### Order Processor
- `cd checkout` 
- `dapr run --app-id order-processor --app-port 7006 --resources-path ../components/ -- dotnet run  --urls http://localhost:7006`

# Run both the applications together directly  
`dapr run -f .`

Expected output 

```
== APP - checkout-sdk == Published data: Order { OrderId = 1 }
== APP - order-processor == Subscriber received : Order { OrderId = 1 }
== APP - checkout-sdk == Published data: Order { OrderId = 2 }
== APP - order-processor == Subscriber received : Order { OrderId = 2 }
== APP - checkout-sdk == Published data: Order { OrderId = 3 }
== APP - order-processor == Subscriber received : Order { OrderId = 3 }
== APP - checkout-sdk == Published data: Order { OrderId = 4 }
== APP - order-processor == Subscriber received : Order { OrderId = 4 }
== APP - checkout-sdk == Published data: Order { OrderId = 5 }
== APP - order-processor == Subscriber received : Order { OrderId = 5 }
== APP - checkout-sdk == Published data: Order { OrderId = 6 }
== APP - order-processor == Subscriber received : Order { OrderId = 6 }
== APP - checkout-sdk == Published data: Order { OrderId = 7 }
== APP - order-processor == Subscriber received : Order { OrderId = 7 }
== APP - checkout-sdk == Published data: Order { OrderId = 8 }
== APP - order-processor == Subscriber received : Order { OrderId = 8 }
== APP - checkout-sdk == Published data: Order { OrderId = 9 }
== APP - order-processor == Subscriber received : Order { OrderId = 9 }
== APP - checkout-sdk == Published data: Order { OrderId = 10 }
== APP - order-processor == Subscriber received : Order { OrderId = 10 }
```

## Run a single app at a time with Dapr (Optional)

An alternative to running all or multiple applications at once is to run single apps one-at-a-time using multiple `dapr run .. -- dotnet run` commands.  This next section covers how to do this. 

### Run Dotnet message subscriber with Dapr

1. Run the Dotnet subscriber app with Dapr: 

```bash
cd ./order-processor
dapr run --app-id order-processor --resources-path ../../../components/ --app-port 7006 -- dotnet run
```

### Run Dotnet message publisher with Dapr

1. Run the Dotnet publisher app with Dapr: 

   
```bash
cd ./checkout
dapr run --app-id checkout-sdk --resources-path ../../../components/ -- dotnet run
```