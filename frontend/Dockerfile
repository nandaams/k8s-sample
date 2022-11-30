FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY frontend.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=build /app .

# add LogMonitor.exe, manually moved the file to /bin to be ignored
WORKDIR /LogMonitor
COPY bin/LogMonitor.exe ./LogMonitor.exe
COPY LogMonitorConfig.json ./LogMonitorConfig.json

ENTRYPOINT ["C:\\LogMonitor\\LogMonitor.exe", "dotnet C:\\app\\frontend.dll"]
