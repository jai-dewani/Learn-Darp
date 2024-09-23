using System.Text.Json.Serialization;
using Dapr;
using System;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

// Dapr will send serialized event object vs. being raw CloudEvent
app.UseCloudEvents();

// needed for Dapr pub/sub routing
app.MapSubscribeHandler();

if (app.Environment.IsDevelopment()) {app.UseDeveloperExceptionPage();}

// Dapr subscription in [Topic] routes orders topic to this route
app.MapPost("/myNewOrders", [Topic("azureorderpubsub", "myNewOrders")] ([FromBody] int i) => {
    Console.WriteLine("Subscriber myNewOrders: " + i);
    return Results.Ok(i);
});
await app.RunAsync();

public record Order([property: JsonPropertyName("orderId")] int OrderId);
