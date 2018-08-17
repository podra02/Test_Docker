
FROM microsoft/aspnetcore:2.0 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/aspnetcore-build:2.0 AS build
WORKDIR /src
COPY MvcMovie.csproj MvcMovie/
RUN dotnet restore MvcMovie/MvcMovie.csproj
WORKDIR /src/MvcMovie
COPY . .
RUN dotnet build MvcMovie.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish MvcMovie.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "MvcMovie.dll"]
