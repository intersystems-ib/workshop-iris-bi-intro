Intro to Analytics using InterSystems BI feature in InterSystems IRIS. You can find more information in the [documentation](https://docs.intersystems.com/iris20221/csp/docbook/DocBook.UI.Page.cls?KEY=PAGE_bi)

# Setup
Build image
```
docker-compose build
```

Run container
```
docker-compose up -d
```

# Overview
## (a). Pareto Chart for Product and Category
* Go to [Management Portal](http://localhost:52773/csp/sys/UtilHome.csp)
* Go to *Analytics > USER namespace > User Portal*  and open **Pareto Chart for Product and Category** dashboard.
* Change some filters. Widgets are linked.
* Go back clicking on **Home** link.

## (b). Drill options
* Go to *Analytics > USER namespace > User Portal*  and open **Drill options** dashboard.
* Drill-down through data.
* Go back clicking on **Home** link.

## (c). Date filter demo
* Go to *Analytics > USER namespace > User Portal*  and open **Date filter demo** dashboard.
* Change filters and chart type.
* Click on *Show detail listing* button to list the actual fact tables that have been computed for a cell value.

## (d). Analyzer
* Go back to [Management Portal](http://localhost:52773/csp/sys/UtilHome.csp) or click on *Menu > Management Portal*. 
* Go to *Analytics > USER namespace > Analyzer*
* Drag & drop "Product" into Rows.
* Drag & drop "Region" into Columns.
* Drag & drop "Product Name" into "Product Category"
* Try some quick graphical representation.
* Include "Revenue" measure.
* Click on one cell and get the detailed listing.

## (e). Architect
* Go back to [Management Portal](http://localhost:52773/csp/sys/UtilHome.csp)
* Go to *Analytics > USER namespace > Architect*.
* Click Open > *HoleFoods Sales* Cube.
* Have a look at the **Source Class**
* Review different defined dimensions, measures and listings.
* You could re-build the whole cube if you want from here.
* In the *Tools* tab you can access to *Analyzer* tool.
* In VS Code, open the source class.
* In *Explorer > SQL* run a query to see the contents of the source class.
```
select * from HoleFoods.SalesTransaction
```

## (f). Add new data and synchronize
* In a [WebTerminal](http://localhost:52773/terminal/) session, add some new additional rows:
```
do ##class(HoleFoods.Utils).AddData(1000,1,1)
```
* Check in *Explorer > SQL* the number of rows
* Check in *Analytics > Analyzer* the actual number of records.
* Instead a full cube build you are going to synchronize only the new data, run:
```
do ##class(%DeepSee.Utils).%SynchronizeCube("HoleFoods")
```
* Check again in *Analytics > Analyzer* the number of records after the synchronization.


TODO:

Add a new query + dashboard

Business Intelligence REST API
https://docs.intersystems.com/iris20221/csp/docbook/DocBook.UI.Page.cls?KEY=D2CLIENT_rest_api

Community package: DSW
http://localhost:52773/dsw/index.html#/USER 
