#FROM microsoft/dotnet:2.0-sdk AS build
#WORKDIR /app
#
#COPY *.sln .
#COPY ConsoleApp/*.csproj ./ConsoleApp/
#COPY Utils/*.csproj ./Utils/
#COPY Tests/*.csproj ./Tests/
#RUN dotnet restore
#
#COPY ConsoleApp/. ./ConsoleApp/
#COPY Utils/. ./Utils/
#COPY Tests/. ./Tests/
#
#RUN dotnet build
#
#FROM build AS testrunner
#WORKDIR /app/Tests
#ENTRYPOINT ["dotnet", "test","--logger:trx"]
#
#FROM build AS test
#WORKDIR /app/Tests
#RUN dotnet test
#
#FROM test AS publish
#WORKDIR /app/ConsoleApp
#RUN dotnet publish -o out
#
#FROM microsoft/dotnet:2.0-runtime AS runtime
#WORKDIR /app
#COPY --from=publish /app/ConsoleApp/out ./
#ENTRYPOINT ["dotnet", "ConsoleApp.dll"]
#


# Build stage
FROM microsoft/dotnet:2.0-sdk AS build-env

WORKDIR /app

# restore
COPY ConsoleApp/ConsoleApp.csproj ./ConsoleApp/
RUN dotnet restore ConsoleApp/ConsoleApp.csproj
COPY Utils/Utils.csproj ./Utils/
RUN dotnet restore Utils/Utils.csproj
COPY Tests/Tests.csproj ./Tests/
RUN dotnet restore Tests/Tests.csproj

# copy src
COPY . .

# test
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test Tests/Tests.csproj

# publish
RUN dotnet publish ConsoleApp/ConsoleApp.csproj -o /publish

# Runtime stage
FROM microsoft/dotnet:2.0-runtime 
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "ConsoleApp.dll"]
