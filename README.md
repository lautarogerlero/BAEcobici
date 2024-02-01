# Análisis de viajes Ecobici

Este proyecto consiste en la estracción de datos sobre los usuarios, estaciones y viajes de la aplicación Ecobici en el año 2023 y el análisis de los mismos

## Descripción

El proyecto esta compuesto principalmente por un proceso ETL y un reporte de Power BI. El proceso ETL se puede ejecutar utilizando la librería Pandas, con el archivo "ecobici_pandas", o utilizando la librería PySpark, con el archivo `ecobici_pyspark`. La diferencia radica en que PySpark funciona mejor para el manejo de grandes volúmenes de datos gracias al procesamiento distribuido, mientras que Pandas es más eficiente para volúmenes más pequeños. En este proyecto la diferencia entre los tiempos de ejecución de ambos scripts no es significativa.  
Ambos scripts extraen los datos de los usuarios desde los archivos ubicados en la carpeta `usuarios`, los datos de las estaciones desde el archivo `nuevas-estaciones-bicicletas-publicas` y los datos de los viajes desde el archivo `trips_2023`. De esta forma crean 3 dataframes, uno con la información de los usuarios, otro con la de las estaciones y el último con la de los viajes, y se aplican una serie de transformaciones para dejar los dataframes listos para la carga de datos.  
En la última etapa del proceso ETL, los datos de cada dataframe son cargados en la tabla correspondiente de una base de datos de PostgreSQL.
Finalmente, el reporte de Power BI se alimenta de los datos de la base de datos, realizando consultas específicas para crear las tablas con las que se arman las visualizaciones.

## Requisitos Generales:

1. **PostgreSQL:**
   - Tener PostgreSQL instalado con los drivers `pgJBDC` para PySpark y `psqlODBC` para Pandas.
   - Crear una base de datos donde se cargarán los datos en el proceso ETL.

2. **Python:**
   - Tener cualquier version de Python 3.6 en adelante.

3. **Power BI:**
   - Tener Power BI instalado.

4. **Archivo `config.json`:**
   - Crear un archivo llamado `config.json` en la misma carpeta donde se encuentran los scripts, con el siguiente formato:

     ```json
     {
         "DB_USER": "usuario",
         "DB_PASSWORD": "contraseña",
         "DB_HOST": "host",
         "DB_DATABASE": "database",
         "DB_PORT": "port"
     }
     ```

5. **Librerías de Python:**
   - Tener instaladas las siguientes librerías en Python:
     - `pandas`
     - `psycopg2`
     - `sqlalchemy`
     - `pyspark`

6. **Archivos:**
   - Descargar [trips_2023](https://drive.google.com/file/d/1HKD_gaHDbeC54NTdoF50-fHtnjroVLVh/view?usp=sharing), descomprimirlo y guardar el archivo en la carpeta que contiene los scripts
   - Respetar la ubicación de los archivos en la carpeta para que los scripts los puedan encontrar sin problemas. La carpeta `usuarios`, luego de ser descomprimida, debe quedar al mismo nivel que los scripts y contener los archivos correspondientes a los usuarios. El archivo `nuevas-estaciones-bicicletas-publicas` debe estar al mismo nivel que los scripts, al igual que el archivo `trips_2023` luego de ser descomprimido.

## Requisitos Específicos para PySpark:

1. **Java:**
   - Instalar [Java JDK](https://www.oracle.com/ar/java/technologies/downloads/#jdk21-windows)
 

2. **Apache Spark:**
   - Instalar [Apache Spark](https://spark.apache.org/downloads.html)
   - Crear la carpeta `SPARK` donde se desee y guardar los archivos extraidos de la carpeta zip descargada

3. **Winutils Hadoop:**
   - Descargar el winutils correspondiente a la versión de Hadoop instalada con Spark, para eso se puede buscar en este [Repositorio](https://github.com/kontext-tech/winutils/tree/master) la carpeta de la versión instalada, entrar a bin y descargar el ejecutable
   - Crear la carpeta `HADOOP/bin` donde se desee y guardar ahi el ejecutable extraido

4. **PostgreSQL:**
   - Buscar la carpeta `pgJDBC` dentro de la carpeta `PostgreSQL`, copiar el jar file y pegarlo en la carpeta `SPARK/jars` para que PySpark pueda usar el driver para conectarse a la base de datos

5. **Variables de entorno:**
   - Crear la variable de entorno "HADOOP_HOME" con la ruta de la carpeta `HADOOP`
   - Crear la variable de entorno "JAVA_HOME" con la ruta de la carpeta `Java\jdk`
   - Crear la variable de entorno "SPARK_HOME" con la ruta de la carpeta `SPARK`
   - Editar la variable "path" agregando "%JAVA_HOME%\bin", "%HADOOP_HOME%\bin" y "%SPARK_HOME%\bin"
