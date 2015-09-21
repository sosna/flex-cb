# Introduction #

As mentioned in the GettingStarted page, the code is organized into 3 layers:

  1. The data access layer, that extracts statistical data and metadata out of an SDMX data source (currently SDMX-ML files).
  1. The information model layer, that converts the extracted data to the various artifacts defined in the SDMX information model.
  1. The MVC layer, that provides views displaying the objects of the SDMX information model in various ways (charts, tables, etc).

This library covers the third layer, i.e. displaying the data in various ways. This library follows the Model-View-Controller (MVC) design pattern.

# The main components #

The FlexCB code is organized around the following concepts:
  1. SDMX service: An SDMX service is an ActionScript component that offers a set of SDMX-related services such as the possibility to retrieve and display statistical data and metadata. Each of these SDMX Services follows the Model-View-Controller design pattern. Therefore, they will be made of components that fulfill the contracts defined in interfaces such as ISDMXServiceController, ISDMXServiceModel and ISDMXServiceView.
  1. SDMX source: A repository containing SDMX data and metadata. This can be a simple SDMX-ML file published on a web server but could also be a full-fledged SDMX SOAP or Restful web service.
  1. SDMX provider: An ActionScript component that, upon request from an SDMX service controller, extracts statistical data and metadata out of an SDMX source. SDMX metadata providers retrieve metadata, while SDMX data providers retrieve statistical data. Access to the SDMX providers is controlled by SDMX Dao factories (following the Factory design pattern).

So, in summary, a FlexCB application is typically made of an SDMX service and SDMX (data & metadata) providers (whose access to is controlled by SDMX DAO factories) and is used to connect to an SDMX source of your choice.

The SDMX provider is covered by the FlexCB\_SDMXFramework library, while the FlexCB\_MVCFramework covers the SDMX service functionality.

# The packages #

## The controller package (eu.ecb.core.controller) ##
The Flex-CB controllers offer a standard set of operations that an SDMX service will support (like a dictionary of all the features of an application). It executes actions as requested by users of the application via views. It will, for instance, instruct an SDMX provider to query an SDMX source. Most of the time the model will be modified to reflect those actions. The Controllers currently available in Flex-CB are listed below:

  1. IController: Base interface that defines the basic behavior of controllers in an MVC design pattern. Concrete implementation: BaseController.
  1. ISDMXServiceController: Contract to be fullfilled by controllers of applications offering a set of SDMX services. Extends IController. Methods defined in the interface allow you to: a) Supply the SDMX DAO factories that will manage the access to the SDMX data and metadata providers; b) Supply the SDMX sources to be used by the SDMX data and metadata providers; c) Instructs the SDMX providers to perform operations such as fetching data or structural metadata. Concrete implementation: BaseSDMXServiceController.
  1. ISDMXViewController: Contract to be fullfilled by controllers that react to actions performed by the user on views (e.g.: dragging a period slider). Extends ISDMXServiceController. Concrete implementation: BaseSDMXViewController.

## The event package (eu.ecb.core.event) ##

The event package contains the events that can be dispatched by the library classes. For example, a ProgressEventMessage will be dispatched when operations are being performed.

## The model package (eu.ecb.core.model) ##

The Flex-CB models store in memory the statistical data and metadata retrieved from the SDMX source. They can also store items needed by the views. The models have no dependencies on the views or the controllers, but simply encapsulate the data access layer. They use the observer pattern to notify the interested components of changes happening in the model. The Models currently available in Flex-CB are listed below:
  1. IModel: Marker interface to indicate that the components acts as a Flex-CB model.
  1. ISDMXServiceModel: Contract to be fullfilled by models of applications offering a set of SDMX compliant services. The model offers accessors to the various collections of data and structural metadata. Extends IModel. Concrete implementation: BaseSDMXServiceModel.
  1. ISDMXViewModel: Contract to be fulfilled by models that react to actions performed by the user on views. Compared to the ISDMXServiceModel, this interface adds methods to access data optimized for certain views (such as filtered datasets) as well as methods to modify data, following actions performed by the users in views (like dragging a thumb of a period slider).

## The util package (eu.ecb.core.util) ##

The util package contains various utility classes such as formatters, validators or various helper components (for strings, colors).

## The view package (eu.ecb.core.view) ##

The Flex-CB views display the statistical data and metadata stored in the model in various ways (charts, tables, etc). Quite often, one of these views will play the role of a mediator and will centralize all communications between the controller and the various views. Flex-CB views are organized as follows:
  1. IView: Marker interface to indicate that the components acts as a Flex-CB view.
  1. ISDMXServiceView: Contract to be fullfilled by views of applications offering a set of SDMX compliant services. Extends IView. Concrete implementation: BaseSDMXServiceView.
  1. ISDMXView: Contract to be implemented by views supporting advanced visual representations of SDMX data. Compared to the ISDMXServiceView, this interface offers to possibility to retrieve  data optimized for certain views (such as filtered datasets, periods for filtering, etc). Extends ISDMXServiceView. Concrete implementation: BaseSDMXView.
  1. ISDMXComposite: Interface, inspired by the Composite pattern, to be implemented by views which hold other views. This is the case of views that act as mediators but there might be other examples. Extends IView. Concrete implementation: BaseSDMXViewComposite (Implements both ISDMXComposite and ISDMXView).
  1. ISDMXMediator: Interface to be implemented by views which play the role of a mediator. Mediators centralize all communications between the controller, the model and the various views. Because mediators contain views, they extend the ISDMXComposite interface. Concrete implementation: BaseSDMXMediator.

# Examples #

The following shows how the key components of the library are working together.

```
// Instantiates the model to be used by this application
var model:ISDMXViewModel = new BaseSDMXViewModel();

// Instantiates the controller to be used by this application.
// We also pass the SDMX-ML data file containing the data to be visualized 
// as well as the SDMX-ML structure file needed to interpret the data
var controller:ISDMXViewController = new BaseSDMXViewController(model);

// Sets the SDMX data and metadata source to be used by the controller;
controller.dataSource = new URLRequest(dataFile);
controller.structureSource = new URLRequest(dsdFile);

// Instantiates the view to be used by this application. This view plays
// the role of a mediator but other views can be freely selected.
var view:ISDMXMediator = new BasicDataPanel(model, controller);

// Adds the view to the stage
addChild(view);

// Instructs the constructor to fetch the data
controller.fetchData();
```