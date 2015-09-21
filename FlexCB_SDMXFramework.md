# Introduction #

As mentioned in the [GettingStarted](GettingStarted.md) page, the code is organized into 3 layers:
  1. The data access layer, that extracts statistical data and metadata out of an SDMX data source (currently SDMX-ML files).
  1. The information model layer, that converts the extracted data to the various artifacts defined in the SDMX information model.
  1. The MVC layer, that provides views displaying the objects of the SDMX information model in various ways (charts, tables, etc).

This library covers the first two layers, i.e. extracting statistical data and metadata out of an SDMX data source, and storing in memory the extracted data as objects of the SDMX information model. It contains both the actual code as well as the unit tests covering it.

Before describing the various packages that make up this library, let's give a brief overview of SDMX, from a developer's perspective.

# A brief overview of SDMX #

The [Statistical Data and Metadata Exchange](http://www.sdmx.org) initiative is sponsored by seven institutions (the BIS, the ECB, Eurostat, the IMF, the OECD, the UN and the World Bank) to foster standards for the exchange of statistical information. The first version of the standard is an ISO technical specification (ISO/Technical Specification 17369:2005). It offers an information model for the representation of statistical data and metadata, as well as several formats to represent this model (SDMX-EDI and several SDMX-ML formats). It also proposes a standard way of implementing web services, including the use of registries.

## The SDMX information model in a nutshell ##

The list below tells you what you need to know about the SDMX information model in order to start using this library. However, to get a better understanding of the standard, we advise you to read the documentation and the user guide published on the [SDMX web site](http://www.sdmx.org).

  1. **Descriptor concepts**: In order to make sense of some statistical data, we need to know the concepts associated with them. For example, on its own the figure 1.2953 is pretty meaningless, but if we know that this is an exchange rate for the US dollar against the euro on 23 November 2006, it starts to make more sense.
  1. **Packaging structure**: Statistical data can be grouped together at the following levels: the _observation level_ (the measurement of some phenomenon); the _series level_ (the measurement of some phenomenon over time, usually at regular intervals); the _group level_ (a group of series – a well-known example being the sibling group, a set of series which are identical, except for the fact that they are measured with different frequencies); and the _dataset level_ (made up of several groups, to cover a specific statistical domain for instance). The descriptor concepts mentioned in point 1 can be attached at various levels in this hierarchy.
  1. **Dimensions and attributes**: There are two types of descriptor concept: _dimensions_, which both identify and describe the data, and _attributes_, which are purely descriptive.
  1. **Keys**: Dimensions are grouped into keys, which allow the identification of a particular set of data (a series, for example). The key values are attached at the series level and given in a fixed sequence. Conventionally, frequency is the first descriptor concept and the other concepts are assigned an order for that particular dataset. Partial keys can be attached to groups.
  1. **Code lists**: Every possible value for a dimension is defined in a code list. Each value on that list is given a language-independent abbreviation (code) and a language-specific description. Attributes are represented sometimes by codes, and sometimes by free-text values.
  1. **Data Structure Definitions**: A Data Structure Definition (also known as a key family) specifies a set of _concepts_, which _describe_ and _identify_ a set of data. It tells us which concepts are _dimensions_ (identification and description) and which are _attributes_ (just description), and it gives the _attachment level_ for each of these concepts on the basis of the packaging structure (dataset, group, series or observation), as well as their status (mandatory or conditional). It also specifies which _code lists_ provide possible values for the dimensions and gives possible values for the attributes, either as code lists or free text fields.

## The various SDMX-ML formats ##

SDMX-ML supports various use cases and, therefore, defines several XML formats. Currently, the library offers support for the following formats:

  1. The Structural Definition format (SDMX-ML Structure format): This format is used to define, among others, the structure (concepts, code lists, dimensions, attributes, etc.) of the data structure definitions.
  1. The data formats (SDMX-ML Compact Data, SDMX-ML Generic Data and SDMX-ML Utility formats): These formats are used to define the data files. Out of the 4 SDMX-ML Data formats, only the SDMX-ML Cross-sectional Data format is currently not supported.

Now that we know the basics, let's briefly describe the packages that make up the library.

# The packages #

The library contains 4 main packages. The most important ones are the **model** package (AS3 representation of the SDMX information model) and the **stores** packages (readers for the SDMX-ML files). The **event** package contains the events dispatched by library classes, while the **util** package contains a few utility classes (validators, etc).

## The event package (org.sdmx.event) ##

The event package contains the events that can be dispatched by the library classes. For example, events will be dispatched when an SDMX-ML file has been fetched and successfully parsed, and these can be captured by application controllers.

## The model package (org.sdmx.model) ##

The model package contains the representation, in AS3, of the SDMX information model. In order to better understand the classes defined in the package, it is recommended to read section 02 document (information model) of the [SDMX Standards package](http://sdmx.org/docs/2_0/SDMX_2_0%20SECTION_02_InformationModel.pdf).

### The base package (org.sdmx.model.base) ###

The base package contains the building blocks upon which the other layers of the model package are built. This includes abstract classes that are inherited by concrete implementations (e.g.: IdentifiableArtefact, MaintainableArtefact), classes that are used by other classes (e.g.: InternationalString), as well as the patterns used in other layers (e.g.: item scheme pattern, which is used by all collections such as code lists and concept schemes, or the structure pattern which is used in the data structure definition).

### The reporting package (org.sdmx.model.reporting) ###

The reporting package contains two subpackages: dataset and provisioning.

The dataset package contains the classes needed to represent statistical data. This includes data set, group, time series and observations, as well as the attribute values (coded and uncoded). In a nutshell, this package defines the objects that will be extracted out of an SDMX-ML Data file (in the compact, generic or utility formats).

The provisioning package links many of the artefacts of the SDMX information model and is key in an SDMX registry scenario. It defines classes like provision agreements (which data is reported by a data provider, following a predefined release calendar, etc.), potential data sources (simple ones like XML files posted on a web site or more complex one like an SDMX SOAP API), as well as constraints that apply to a set of data (for example, a data structure definition might define that, for a certain dimension, 150 codes would be valid. However, the provision agreement could specify that, out of the 150 possible codes, only 5 will be reported by that specific data provider. These 5 codes should be expressed as constraints attached to the provision agreement).

### The structure package (org.sdmx.model.structure) ###

The structure package contains many of the classes that are represented in the SDMX-ML Structure format. Not all the classes have been implemented (for example, there is no support for processes or reporting taxonomies), but the classes needed for the data structure definition, as well as a few other important classes (e.g.: categories and category schemes) are available.

Most of the subpackages in the structure package are related to collections of items and therefore will follow the item scheme pattern. This is the case of the category package (which typically represents a hierarchy of economic concepts to which statistical data and metadata are attached), the code package (the code lists and the codes used by the dimensions and coded attributes in the data structure definition), the concept package (the concepts used in the data structure definition) and the organisation package (organizations participating in the exchange of statistical data and metadata, either as data provider, data consumer or maintenance agency).

The key family package follows the structure pattern and contains the classes needed to define a data structure definition. This includes the dimensions, the groups, the measures and the attributes (coded and uncoded). It also includes the classes that defines the flows of data that will be reported by data providers (dataflow definitions).

## The stores package (org.sdmx.stores) ##

The stores package contains the data providers that will extract SDMX data and metadata out of SDMX data sources. Currently only plain SDMX-ML data files are supported as data sources (the xml package). However, there is not reason for such a limitation and, in the future, support for other types of data sources (e.g.: a local SQLite database or an SDMX web service) could be added. In order to make the data sources interchangeable at run time, all data providers should implement the contracts defined in the api package.

### The api package (org.sdmx.stores.api) ###

The api package defines the contracts to be implemented by the various data providers, so as to make them interchangeable at run time. This package distinguishes between an SDMX data source (a "repository" containing SDMX data and metadata, such as SDMX-ML files hosted on a web site) and an SDMX data provider (a class that, upon request from a controller, will communicate with the SDMX data source to retrieve statistical data and metadata).

The package defines the contract to be followed by the providers of statistical data (IDataProvider), by the providers of the statistical metadata (IMaintainableArtefactProvider) and by the factories that will control access to the various data and metadata providers (ISDMXDaoProvider).

### The xml package (org.sdmx.stores.xml) ###

The xml package contains the data providers that will return data and metadata out of SDMX-ML data sources. Currently, the package offers support for retrieving structural metadata out of an SDMX-ML Structure file and for retrieving data out of an SDMX-ML Compact data file, an SDMX-ML Generic data file or an SDMX-ML Utility data file. Support for the other SDMX-ML formats (e.g.: the SDMX-ML Cross-section data format) is planned for a future release of the library. In order to better understand the differences between the various SDMX-ML formats, it is recommended to read the section 03 document (SDMX-ML) of the [SDMX Standards package](http://sdmx.org/docs/2_0/SDMX_2_0_SECTION_03A_SDMX_ML.pdf)

## The util package (org.sdmx.util) ##

The util package contains various utility classes related to date handling, data downloads over HTTP and input validation.

# Examples #

The following shows how a data structure definition file can be processed. The code is not sequential: as the process is event-based, various methods should handle the different events, but the important parts have been summarized below. For examples of production code performing a similar activity, please refer to the eu.ecb.core.controller.BaseSDMXServiceController class.

```
// Intantiates the factory that controls the access to the classes that will connect to an SDMX data source
var factory:ISDMXDaoFactory = new SDMXMLDaoFactory();

// Add the method that will handle the event indicating that the factory is ready to be used
factory.addEventListener(BaseSDMXDaoFactory.INIT_READY, handleStructureFactoryReady);

// Pass the SDMX data source to the factory
factory.sourceURL = "data/dsd.xml";

// Once the factory is ready to be used, we can start interacting with the data source.
// First, we need to get the class that will perform the query against the SDMX data source
var provider:IMaintainableArtefactProvider = factory.getKeyFamilyDAO();

// Add the method that will handle the event indicating that the desired key family has been retrieved from the data source.
provider.addEventListener(BaseSDMXDaoFactory.KEY_FAMILIES_EVENT, handleKeyFamily);

// Retrieves from the data source the version "2.0" of the data structure definition "ECB_EXR1" maintained by the ECB.
provider.getMaintainableArtefact("ECB_EXR1", "ECB", "2.0");

// In the handleKeyFamily method, an SDMXDataEvent will be received, containing the key family mentioned above. 
// The retrieved data could now, for instance, be passed to the application model
var model:ISDMXServiceModel = new BaseSDMXServiceModel();
model.keyFamilies = event.data as KeyFamilies;
```