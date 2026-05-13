using DotNetEnv;
using System.Diagnostics;
using System.Reflection;

Debugger.Launch();

#if DEBUG
//Load .env file
string path = "";
if (!string.IsNullOrEmpty(Assembly.GetExecutingAssembly().Location))
    path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), ".env");

Env.Load(path);
#endif

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Configuration.AddEnvironmentVariables();

//TODO RK Extend
var v = Environment.GetEnvironmentVariable("POSTGRES_PASSWORD");

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
