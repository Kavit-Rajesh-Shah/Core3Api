FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /build
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS final
ENV ASPNETCORE_URLS=http://*:8080
ENV message=Hellotestin
WORKDIR /app
COPY --from=build /app .
USER 1001
EXPOSE 8080
ENTRYPOINT ["dotnet", "Core3Api.dll"]
