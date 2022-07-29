/// This is a sample DeepSee data model.<br/>
/// This cube represents a model for the fictional "HoleFoods" corporation.
/// It is based on the classes within the HoleFoods package.<br/>
/// To create data for this model, the easiest thing to do is to
/// use the BuildData method within the <class>HoleFoods.Utils</class> class:<br/>
/// From the command line:<br/>
/// <example language="cache">
/// Do ##class(HoleFoods.Utils).BuildData(1000000,1,1)
/// </example>
/// The first argument is the number of records to create, 
/// the second argument indicates that index building should be done in parallel,
/// the third is a verbose flag; if true, then progress is displayed as the data is built.
Class HoleFoods.Cube Extends %DeepSee.CubeDefinition [ DependsOn = (HoleFoods.Transaction, HoleFoods.KPIAction) ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="HoleFoods" disabled="false" abstract="false" sourceClass="HoleFoods.Transaction" actionClass="HoleFoods.KPIAction" buildRestriction="Actual=1" caption="HoleFoods Sales" nullReplacement="Missing Value" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" defaultListing="Listing" precompute="0" disableListingGroups="false">
  <dimension name="Comments" disabled="false" hasAll="false" type="computed" dimensionClass="SQL" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Comments" disabled="false" factName="MxComment" list="false" useDisplayValue="false" useAsFilter="true" hidden="false">
        <member name="Complaints" disabled="false" spec="WHERE $$$FACT %CONTAINSTERM(&apos;complained&apos;) OR $$$FACT %CONTAINSTERM(&apos;ranted&apos;)">
        </member>
        <member name="Compliments" disabled="false" spec="WHERE $$$FACT %CONTAINSTERM(&apos;happy&apos;)">
        </member>
      </level>
    </hierarchy>
  </dimension>
  <dimension name="DateOfSale" displayName="Date Of Sale" disabled="false" hasAll="true" allDisplayName="All Sales Dates" sourceProperty="DateOfSale" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="Actual" disabled="false" hidden="false">
      <level name="YearSold" disabled="false" timeFunction="Year" list="false" useDisplayValue="false" useAsFilter="true" hidden="false">
      </level>
      <level name="MonthSold" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="false" useAsFilter="true" hidden="false">
      </level>
      <level name="DaySold" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="false" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="WeekNumber" disabled="false" timeFunction="WeekNumber" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Product" disabled="false" hasAll="true" allDisplayName="All Products" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="P1" disabled="false" hidden="false">
      <level name="Product Category" disabled="false" sourceProperty="Product.Category" list="false" useDisplayValue="false" useAsFilter="true" hidden="false">
      </level>
      <level name="Product Name" disabled="false" sourceProperty="Product" list="false" useDisplayValue="false" dependsOn="[Outlet].[H1].[Region],[DateOfSale].[Actual].[YearSold]" useAsFilter="true" hidden="false">
        <property name="Name" disabled="false" sourceProperty="Product.Name" hidden="false" isName="true" isDescription="false" isReference="true" useDisplayValue="false">
        </property>
        <property name="UnitPrice" displayName="Unit Price" disabled="false" sourceProperty="Product.Price" hidden="false" isName="false" isDescription="false" isReference="false" useDisplayValue="false">
        </property>
        <property name="PriceSquared" disabled="false" sourceExpression="%source.Product.Price*%source.Product.Price" hidden="false" isName="false" isDescription="false" isReference="false" useDisplayValue="false">
        </property>
        <property name="SKU" disabled="false" sourceProperty="Product.SKU" hidden="false" isName="false" isDescription="true" isReference="false" useDisplayValue="false">
        </property>
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Outlet" disabled="false" hasAll="true" allDisplayName="All Outlets" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Region" disabled="false" sourceProperty="Outlet.Country.Region.Name" list="false" useDisplayValue="false" useAsFilter="true" hidden="false">
      </level>
      <level name="Country" disabled="false" sourceProperty="Outlet.Country.Name" list="false" useDisplayValue="false" useAsFilter="true" hidden="false">
      </level>
      <level name="City" disabled="false" sourceProperty="Outlet" list="false" useDisplayValue="false" useAsFilter="true" hidden="false">
        <property name="Name" disabled="false" sourceProperty="Outlet.City" hidden="false" isName="true" isDescription="false" isReference="false" useDisplayValue="false">
        </property>
        <property name="Population" disabled="false" sourceProperty="Outlet.Population" hidden="false" isName="false" isDescription="false" isReference="false" useDisplayValue="false">
        </property>
        <property name="Latitude" disabled="false" sourceProperty="Outlet.Latitude" hidden="false" isName="false" isDescription="false" isReference="false" useDisplayValue="false">
        </property>
        <property name="Longitude" disabled="false" sourceProperty="Outlet.Longitude" hidden="false" isName="false" isDescription="false" isReference="false" useDisplayValue="false">
        </property>
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Channel" disabled="false" hasAll="true" allDisplayName="All Channels" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Channel Name" disabled="false" sourceProperty="Channel" list="false" nullReplacement="No Channel" useDisplayValue="false" useAsFilter="true" hidden="false">
        <property name="Name" disabled="false" sourceProperty="Channel" hidden="false" isName="true" isDescription="false" isReference="false" useDisplayValue="true">
        </property>
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Discount" disabled="false" hasAll="true" allDisplayName="All Discount Types" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Discount Type" disabled="false" sourceProperty="Discount" list="false" rangeExpression="(,0]:None;(0,0.2):1-19%;[0.2,0.5):20-49%;[0.5,1]:50%+;" useDisplayValue="false" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="UnitsPerTransaction" displayName="Units Per Transaction" disabled="false" hasAll="true" allDisplayName="All Units Per Transaction" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="UnitsSold" disabled="false" sourceProperty="UnitsSold" list="false" useDisplayValue="false" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <measure name="Amount Sold" displayName="Revenue" disabled="false" sourceProperty="AmountOfSale" aggregate="SUM" hidden="false" searchable="false" formatString="$#,###.##">
  </measure>
  <measure name="Units Sold" disabled="false" sourceProperty="UnitsSold" aggregate="SUM" hidden="false" searchable="true">
  </measure>
  <measure name="Max Units" disabled="false" sourceProperty="UnitsSold" aggregate="MAX" hidden="false" searchable="false">
  </measure>
  <measure name="Big Sale Count" disabled="false" sourceExpression="$S(%source.UnitsSold=&quot;&quot;:&quot;&quot;,%source.UnitsSold&gt;5:1,1:0)" type="boolean" hidden="false" searchable="false">
  </measure>
  <measure name="Comment" disabled="false" sourceProperty="Comment" factName="MxComment" type="text" hidden="false" searchable="false">
  </measure>
  <index name="MxUnitsSold" disabled="false" properties="MxUnitsSold" type="bitmap">
  </index>
  <index name="MxAmountSold" disabled="false" properties="MxAmountOfSale" type="bitmap">
  </index>
  <calculatedMember name="Pct Sold" disabled="false" dimension="Measures" valueExpression="Product.CurrentMember/Product.CurrentMember.Parent" formatString="###.##%" hidden="false">
  </calculatedMember>
  <calculatedMember name="North" disabled="false" dimension="MyRegion" valueExpression="%OR({Outlet.[Boston],Outlet.[New York]})" hidden="false">
  </calculatedMember>
  <calculatedMember name="South" disabled="false" dimension="MyRegion" valueExpression="%OR({Outlet.[Atlanta],Outlet.[Paris]})" hidden="false">
  </calculatedMember>
  <calculatedMember name="West" disabled="false" dimension="MyRegion" valueExpression="%OR({Outlet.[Chicago],Outlet.[Tokyo]})" hidden="false">
  </calculatedMember>
  <calculatedMember name="5 year avg growth" displayName="5 Year Avg Growth" disabled="false" dimension="Measures" valueExpression="(DateOfSale.YearSold.[NOW]-DateOfSale.YearSold.[NOW-4])/(DateOfSale.YearSold.[NOW-4]*5)" formatString="###.##%" hidden="false">
  </calculatedMember>
  <calculatedMember name="Growth over last period" displayName="Growth Over Last Period" disabled="false" dimension="Measures" valueExpression="(DateOfSale.CurrentMember-DateOfSale.CurrentMember.Lag(1))/DateOfSale.CurrentMember.Lag(1)" formatString="###.##%" hidden="false">
  </calculatedMember>
  <calculatedMember name="Product percent of total" displayName="Product Percent of Total" disabled="false" dimension="Measures" valueExpression="Product.CurrentMember/Product.[All Product].%ALL" formatString="###.##%" hidden="false">
  </calculatedMember>
  <calculatedMember name="Median Revenue" displayName="Median Revenue" description="This calculated member demos the sample median plugin" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;%DeepSee.Median&quot;,&quot;MEDIAN&quot;,1,&quot;%measure&quot;,&quot;Amount Sold&quot;,&quot;%CONTEXT&quot;)" formatString="$#,#.##" hidden="false">
  </calculatedMember>
  <calculatedMember name="90th Percentile Revenue" displayName="90th Percentile Revenue" description="This calculated member demos the sample percentile plugin" disabled="false" dimension="Measures" valueExpression="%KPI(&quot;%DeepSee.Percentile&quot;,&quot;PERCENTILE&quot;,1,&quot;%measure&quot;,&quot;Amount Sold&quot;,&quot;%percentile&quot;,&quot;90&quot;,&quot;%CONTEXT&quot;)" formatString="$#,#.##" hidden="false">
  </calculatedMember>
  <namedSet name="Top Cities" disabled="false" setExpression="HEAD(Outlet.City.Members,3)">
  </namedSet>
  <namedSet name="Last 5 Years" disabled="false" setExpression="DateOfSale.YearSold.[NOW-4]:[NOW]">
  </namedSet>
  <namedSet name="Current Year " disabled="false" setExpression="DateOfSale.YearSold.[NOW]">
  </namedSet>
  <listing name="ListingX" disabled="false" listingType="table" sql="SELECT ID,UnitsSold,Outlet-&gt;City FROM $$$SOURCE WHERE $$$RESTRICT">
  </listing>
  <listing name="Listing" disabled="false" listingType="table" fieldList="%ID,DateOfSale,Outlet-&gt;City,%EXTERNAL(Channel) Channel,Product-&gt;Name Product,UnitsSold,AmountOfSale Revenue,(Discount*100)||&apos;%&apos; Discount,Comment" orderBy="DateOfSale,%ID">
  </listing>
  <listing name="Listing By Date" disabled="false" listingType="table" fieldList="%ID,DateOfSale" orderBy="DateOfSale,%ID">
  </listing>
  <listing name="Listing By Product" disabled="false" listingType="table" fieldList="%ID,Product-&gt;Name Product" orderBy="Product-&gt;Name,%ID">
  </listing>
  <listing name="Customer Info" disabled="false" listingType="map" fieldList="%ID,Outlet-&gt;City &quot;Store Location&quot;,Outlet-&gt;Country-&gt;Name Country,Product-&gt;Name Product,ZipCode &quot;Customer ZipCode&quot;,Latitude,Longitude">
  </listing>
  <listingField name="ID" disabled="false" fieldExpression="%ID">
  </listingField>
  <listingField name="Channel" disabled="false" fieldExpression="%EXTERNAL(Channel) Channel">
  </listingField>
  <listingField name="City" disabled="false" fieldExpression="Outlet-&gt;City">
  </listingField>
  <listingField name="Comment" disabled="false" fieldExpression="Comment">
  </listingField>
  <listingField name="Country" disabled="false" fieldExpression="Outlet-&gt;Country-&gt;Name Country">
  </listingField>
  <listingField name="Date Of Sale" disabled="false" fieldExpression="DateOfSale">
  </listingField>
  <listingField name="Latitude" disabled="false" fieldExpression="Latitude">
  </listingField>
  <listingField name="Longitude" disabled="false" fieldExpression="Longitude">
  </listingField>
  <listingField name="Product" disabled="false" fieldExpression="Product-&gt;Name Product">
  </listingField>
  <listingField name="Product Category" disabled="false" fieldExpression="Product-&gt;Category">
  </listingField>
  <listingField name="Revenue" disabled="false" fieldExpression="AmountOfSale Revenue">
  </listingField>
  <listingField name="Units Sold" disabled="false" fieldExpression="UnitsSold">
  </listingField>
  <listingField name="ZIP Code" disabled="false" fieldExpression="ZipCode">
  </listingField>
</cube>
}

Parameter DOMAIN = "HOLEFOODS";

}

