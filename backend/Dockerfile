FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY backend.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=build /app .

# Install LogMonitor.exe
RUN mkdir C:\LogMonitor
# RUN curl -o C:\LogMonitor\LogMonitor.exe https://github.com/microsoft/windows-container-tools/releases/download/v1.2/LogMonitor.exe
# RUN curl -o C:\LogMonitor\LogMonitorConfig.json https://raw.githubusercontent.com/microsoft/windows-container-tools/main/LogMonitor/src/LogMonitor/sample-config-files/IIS/LogMonitorConfig.json
COPY LogMonitor/ /LogMonitor

ENTRYPOINT ["C:\\LogMonitor\\LogMonitor.exe", "dotnet", "backend.dll"]
# ENTRYPOINT ["dotnet", "backend.dll"]
