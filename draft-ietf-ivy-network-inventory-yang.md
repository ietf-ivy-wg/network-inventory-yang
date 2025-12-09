---
title: "A Base YANG Data Model for Network Inventory"
abbrev: "Network Inventory YANG"
category: std

docname: draft-ietf-ivy-network-inventory-yang-latest
submissiontype: IETF  # also: "independent", "editorial", "IAB", or "IRTF"
number:
date:
consensus: true
v: 3
# area: AREA
# workgroup: IVY Working Group
keyword:
 - next generation
 - unicorn
 - sparkling distributed ledger
venue:
#  group: WG
#  type: Working Group
#  mail: WG@example.com
#  arch: https://example.com/WG
  github: "ietf-ivy-wg/network-inventory-yang"
  latest: "https://ietf-ivy-wg.github.io/network-inventory-yang/draft-ietf-ivy-network-inventory-yang.html"

author:
  -
    name: Chaode Yu
    org: Huawei Technologies
    email: yuchaode@huawei.com
  -
    name: Sergio Belotti
    org: Nokia
    email: sergio.belotti@nokia.com
  -
    ins: J-F. Bouquier
    name: Jean-Francois Bouquier
    org: Vodafone
    email: jeff.bouquier@vodafone.com
  -
    name: Fabio Peruzzini
    org: FiberCop
    email: fabio.peruzzini@fibercop.com
  -
    name: Phil Bedard
    org: Cisco
    email: phbedard@cisco.com

contributor:
  -
    name: Italo Busi
    org: Huawei Technologies
    email: italo.busi@huawei.com
  -
    name: Aihua Guo
    org: Futurewei Technologies
    email: aihuaguo.ietf@gmail.com
  -
    name: Victor Lopez
    org: Nokia
    email: victor.lopez@nokia.com
  -
    name: Bo Wu
    org: Huawei Technologies
    email: lana.wubo@huawei.com
  -
    name: Chenfang Zhang
    org: China Unicom
    email: zhangcf80@chinaunicom.cn
  -
    name: Oscar Gonzalez de Dios
    ins: O. Gonzalez de Dios
    org: Telefonica
    email: oscar.gonzalezdedios@telefonica.com
  -
    name: Nigel Davis
    org: Ciena
    email: ndavis@ciena.com

normative:
  TMF_SD2-20:
    title: SD2-20_Equipment Model
    author:
      org: TM Forum
    date:  May 2008
    seriesinfo: TMF MTOSI 4.0, Network Resource Fulfilment (NRF), SD2-20
    target: https://www.tmforum.org/resources/suite/mtosi-4-0/

  IANA_ENTITY_MIB:
    title: IANA-ENTITY-MIB
    author:
      org: IANA
    target: https://www.iana.org/assignments/ianaentity-mib/ianaentity-mib.xhtml

  IANA_HW_YANG:
    title: iana-hardware YANG Module
    author:
      org: IANA
    target: https://www.iana.org/assignments/iana-hardware/iana-hardware.xhtml

informative:

--- abstract

This document defines a base YANG data model for reporting network inventory. The scope of this base model is set to
be application- and technology-agnostic. The base data model can be augmented with application- and technology-specific details.

--- middle

# Introduction {#intro}

This document defines a base YANG data model for reporting network inventory
that is application- and technology-agnostic.  The
base data model can be augmented to describe application- and technology-specific information.
Please note that the usage of term "network inventory", in the context of this I-D, is to indicate that it is
describing "network-wide" scope inventory information.

Network Inventory is a collection of data for network devices and their components managed by a specific management system.

Network inventory is a fundamental functional block in the overall network
management which was specified many years ago. Network inventory management is a critical
part for ensuring that the network remains healthy (e.g., auditing to identify faulty elements), well-planned (e.g., identify assets to upgrade or to decommission), and maintained appropriately to meet the performance objectives. Also, network inventory
management allows operators to keep track of which devices are deployed in their networks, including relevant embedded software and
hardware versions.

Exposing standard interfaces to retrieve network elements capabilities as maintained in an inventory are key enablers for many applications. For example, {{?I-D.ietf-teas-actn-poi-applicability}} identifies a gap about the lack of YANG data models that could be used at Abstraction and Control of TE Networks (ACTN) Multi-Domain Service Coordinator-Provisioning Network Controller Interface (MPI) level to report whole or partial network hardware inventory information available at domain controller level towards
upper layer systems (e.g., Multi-Domain Service Coordinator (MDSC) or Operations Support Systems (OSS) layers).

It is key for operators to coordinate with the industry towards the use of a
standard YANG data model for Network Inventory data instead
of using vendors proprietary APIs.

{{!RFC8348}} defines a YANG data model for the management of the hardware on a single server and therefore it is more applicable to the domain controller towards the network elements rather than at the northbound interface of a network controller (e.g., toward an application or another hierarchical network controller). However, the YANG data model defined in {{!RFC8348}} has been used as a reference for defining the YANG network inventory data model presented in this document.

Per the definition of {{?RFC8969}}, the YANG data model defined in {{!RFC8348}} is a device model while the YANG data model defined in this document is a network model.

This document defines one YANG module "ietf-network-inventory" in {{ni-yang}}.

This base data model is application- and technology-agnostic (that is, valid for IP/MPLS, optical, and
microwave networks as well as optical local loops, access networks, core networks, data centers, etc.) and can be augmented to
include required application- and technology-specific inventory details together with specific hardware or software component's attributes.

The YANG data model defined in the document is scoped to cover the common use cases for Inventory but at network-wide level, covering both hardware and base software information.

The YANG data model defined in this document conforms to the Network Management Datastore Architecture {{!RFC8342}}.

## Editorial Note (To be removed by RFC Editor)

  > Note to the RFC Editor: This section is to be removed prior to publication.

   This document contains placeholder values that need to be replaced
   with finalized values at the time of publication.  This note
   summarizes all of the substitutions that are needed.

   Please apply the following replacements:

   *  XXXX --> the assigned RFC number for this I-D

# Terminology and Notations

## Requirements Notations

{::boilerplate bcp14}

## Terminology

The following terms are defined in {{!RFC7950}} and are not redefined here:

- server
- augment
- data model
- data node

The following terms are defined in {{!RFC6241}} and are not redefined here:

- configuration data
- state data

The following terms are defined in {{!RFC8342}} and are not redefined here:

- applied configuration

The following terms are defined in the description statements of the corresponding YANG identities, defined in {{IANA_HW_YANG}}, and are not redefined here:

- backplane
- battery
- cpu
- fan
- module
- power supply
- sensor
- stack
- storage device

Chassis:
: A field replaceable equipment with a particular structural format and dimensions.
A chassis can, but does not need to, include spaces (called slots) to take cards.
: Elsewhere, a chassis can be called shelf, sub-rack, stand-alone unit, etc.

Port:
: A component where networking traffic can be received and/or transmitted, e.g., by attaching networking cables.
: In case of pluggable ports, the port may be empty when no pluggable module is plugged in.

Also, the document makes use of the following terms:

Network Inventory:
: A collection of data for network elements and their components with network-wide scope, managed by a specific management system.

Physical Network Element:
: An implementation or application specific group of components (e.g., hardware components).

Network Element:
: The generalization of the physical network element definition.

Hardware Component:
: The generalization of the hardware components defined in {{IANA_HW_YANG}} (e.g., backplane, battery, container, cpu, chassis, fan, module, port, power supply, sensor, stack, and storage device components).
: The list of hardware components can be extended in future versions of {{IANA_ENTITY_MIB}} (and, consequently, of ({{IANA_HW_YANG}}).

Component:
: The generalization of the hardware component definition to include other inventory objects which can be managed, from an inventory perspective, like hardware components.

Card:
: A pluggable equipment with a particular structural format and dimensions which can be inserted into one or more slots (or sub-slots). A card can have spaces (called sub-slots) to take other cards.
: Elsewhere, a card can be called board, module, circuit pack, etc..

Slot:
: A space in a chassis that can be equipped with one card, which may be chosen from a limited range of types of cards. A slot can be subdivided into smaller spaces that can also be part of a Card (called sub-slots).

Container:
: A hardware component class that is capable of containing one or more removable physical entities (e.g., a slot in a chassis is containing a board).

## Tree Diagrams

The meanings of the symbols in the YANG tree diagrams are defined in {{?RFC8340}}.

## YANG Prefixes

  {{tab-prefixes}} list the prefixes of the modules that are used in this document.

| Prefix | YANG Module                     | Reference     |
| ------ | ------------------------------- | ------------- |
| inet   | ietf-inet-types                 | {{Section 4 of !RFC6991}}  |
| yang   | ietf-yang-types                 | {{Section 3 of !RFC6991}}  |
| ianahw | iana-hardware                   | {{IANA_HW_YANG}} |
| nwi    | ietf-network-inventory          | RFC XXXX      |
{:#tab-prefixes title="Prefixes and corresponding YANG modules"}

# YANG Data Model for Network Inventory Overview {#overview}

The base network inventory model, defined in this document, provides a list of network elements and of network element components:

The network-inventory top level container has been defined to support reporting other types of network inventory objects, besides the network elements and network element components.

These additional types of network inventory objects can be defined, together with the associated YANG data model and the rationale for managing them as part of the network inventory, in other documents providing application- and technology-specific companion augmentation data models, such as
{{?I-D.ietf-ivy-network-inventory-location}}.

The network element definition is generalized to support physical
network elements and other types of components' groups that can be managed as physical network elements from an
inventory perspective.

Physical network elements are usually devices such as hosts, gateways, terminal servers, and the like, which have management agents responsible for performing the network management functions requested by the network management stations ({{?RFC1157}}).

The "ne-type" is defined as a YANG identity to describe the type of the network element. This document defines only the "physical-network-element" identity.

Other types of network elements can be defined in other documents, together with the associated YANG identity and the rationale for managing them as network elements from an inventory perspective.

The component definition is also generalized to support any types of
component inventory objects that can be managed as hardware components from an inventory perspective.

The data model for components defined in this document uses a list of components within each network element.

Different types of components can be distinguished by the class of component. The component "class" is defined as a union between the hardware class identity, defined in "iana-hardware", and the "non-hardware" identity, defined in this document.

Other types of components can be defined in other documents, together with the associated YANG identity and the rationale for managing them as components from an inventory perspective.

The identity definition of additional types of "ne-type" and "non-
hardware" identity of component are outside the scope of this
document and could be defined in application- and technology-specific companion augmentation data models, such as
{{?I-D.ietf-ivy-network-inventory-software}}.

In {{!RFC8348}}, rack, chassis, slot, sub-slot, board and port are defined as components of network elements with generic attributes.

While {{!RFC8348}} is used to manage the hardware of a single server (e.g., a network element), the Network Inventory YANG data model is used to retrieve the base inventory information that a controller discovers from all the network elements with network-wide scope under its control.

However, the YANG data model defined in {{!RFC8348}} has been used as a reference for defining the YANG network inventory data model. This approach can simplify the implementation of this inventory model when the controller uses the YANG data model defined in {{!RFC8348}} to retrieve the hardware  from the network elements under its control.

## Common attributes for inventory object {#common-attributes}

For all the inventory objects, there are some common attributes, such as:

uuid:
: The Universally Unique Identifier (UUID) of the inventory object, assigned by the server. Such identifiers are widely implemented with systems and guaranteed to be globally unique.

name:
: A human-readable label information of the inventory object, which could be assigned by the server. It could also be present on a Graphical User Interface (GUI).

alias:
: A human-readable label information of the inventory object, provided by a network operator. It could also be present on a GUI instead as well as the name.

description:
: A human-readable description of the inventory object, provided by a network operator or by the server. The description provides more detailed information to prompt users when performing maintenance operations etc.

### Common attributes for network elements and components

To be consistent with the component definition, some of the attributes defined in {{!RFC8348}} for components are reused for network elements, such as:

mfg-name:
: The name of the manufacturer of the entity (component or network element).

product-name:
: The vendor-specific and human-interpretable string describing the entity (component or network element) type.
: It is expected that vendors assign unique product names to different entities within the scope of the vendor.

Other software-related attributes are defined in {{sw-inventory}} and applicable to network elements and components.

## Network Element

In addition to the common attributes defined for network elements and components in {{common-attributes}}, the following attributes are defined for the network elements:

ne-id:
: The identifier that uniquely identifies the NE within the network, assigned by the server since the network elements cannot guaranteed that their local  identifier is unique within the network.
: The ne-id should be assigned such that the same network element will always be identified through the same identifier, even if the network elements get disconnected from the network controller. Mechanisms to ensure this (e.g., checking the mfg-name, product-name, management IP address, physical location) are implementation specific and outside the scope of standardization.

ne-type:
: The type of network element (e.g., physical network element). See {{overview}} for the definition of NE types.

product-rev:
: A vendor-specific product revision string for the network-element.

## Components {#ne-component}

The YANG data model for network inventory mainly follows the same approach of {{!RFC8348}} and reports the network hardware inventory as a list of components with different types (e.g., chassis, module, and port).

In addition to the common attributes defined for network elements and components in {{common-attributes}}, the following attributes are defined for the network elements:

component-id:
: The identifier that uniquely identifies the component within the NE. It can be assigned by the NE or by the server.

class:
: The type of component (e.g., chassis, module, port). See {{overview}} for the definition of component types.

hardware-rev:
: The vendor-specific hardware revision string for the component.
: The preferred value is the hardware revision identifier actually printed on the component itself (if present).

mfg-date:
: The date of manufacturing of the component.

part-number:
: The vendor-specific part number of the component type.
: It is expected that vendors assign unique part numbers to different component types within the scope of the vendor.

serial-number:
: The vendor-specific serial number of the the component instance.
: It is expected that vendors assign unique serial numbers to different component instances at least within the scope of the part-number.

asset-id:
: An asset tracking identifier for the component, provided by a network operator.

is-fru:
: Indicates whether or not a component is considered a 'field-replaceable unit' by the vendor.

For state data like "admin-state", "oper-state", and so on, this document considers that they are related to device hardware management, not network inventory. Therefore, they are outside of the scope of this document. Same for the sensor-data, they should be defined in some other performance monitoring data models instead of the inventory data model.

### Hardware Components

Based on TMF classification in {{TMF_SD2-20}}, hardware components can be divided into two groups, holder group and equipment group. The holder group contains rack, chassis, slot, sub-slot while the equipment group contains network-element, board and port.

{{fig-hw-inventory-object-relationship}} describes the relationship between typical inventory objects in a physical network element.

~~~~ aasvg
                            +-----------------+
                            | network element |
                            +-----------------+
                                    ||
                                    ||
                                    ||
                                    ||1:M
                                    ||
                                    ||
                                    ||
                                    \/
                              +-------------+
                              |   chassis/  |---+
                              | sub-chassis |<--|
                              +-------------+
                                    ||
                     ______1:N______||_____1:M_______
                     ||------------------ ---------||
                     \/                            \/
              +--------------+               +-----------+
          +---|     slot     |               |   board   |
          |-->|  /sub-slot   |               |           |
              +--------------+               +-----------+
                                                   ||
                                                   ||1:N
                                                   \/
                                             +-----------+
                                             |    port   |
                                             +-----------+
~~~~
{:#fig-hw-inventory-object-relationship title="Relationship between typical inventory objects in physical network elements"}

The "iana-hardware" module {{IANA_HW_YANG}} defines YANG identities for
the hardware component types in the IANA-maintained "IANA-ENTITY-MIB"
registry.

Some of the definitions taken from {{!RFC8348}} are based on the ENTITY-MIB {{!RFC6933}}.

Additional attributes of specific hardware, such as CPU,
storage, port, or power supply are defined in the hardware extension.

### Software Components {#sw-inventory}

This document defines a "software-rev" list for NEs and components, which provide
basic software attributes for network elements and components.

The scope of the list is to provide information about the software modules configured to be active
on the related entity (network element or component).

The model supports scenarios where multiple software modules can be configured to be active on the entity. For example, on a network element an Operating System and an Application software modules can be configured to be active; in the same way, on a component like a circuit pack a boot-loader, a firmware
and one or more FPGA software modules can be configured to be active.

For each software module, configured to be active, the name and version information is provided.

The management of inactive/standby software
modules and of the software upgrade or downgrade life-cycle are outside the scope of the base inventory model and can be addressed in other models which augment the base inventory model such as the model under definition in {{?I-D.ietf-ivy-network-inventory-software}}.


The software and hardware components share the same attributes of the
component and have similar replaceable requirements. Generally, the
device also has other software data, for example, one or more
software patch information.

The software components lifecycle  (like activation, deactivation, installation, storage, removal, etc.) is
outside the scope of this document and defined in other documents such as
{{?I-D.ietf-ivy-network-inventory-software}}.

## Changes Since RFC 8348

This document re-defines some attributes listed in {{!RFC8348}}, based on some integration experience for network inventory data.

### Part Number

According to the description in {{!RFC8348}}, the attribute named "model-name" under the component, is preferred to have a customer-visible part number value. "Model-name" is not straightforward to understand and we suggest to rename it as "part-number" directly.

### Component identifiers

There are some use cases where the name of the components are assigned and changed by the operator. In these cases, the assigned names are also not guaranteed to be always unique.

In order to support these use cases, this model is not aligned with {{!RFC8348}} in defining the component name as the key for the component list.

Instead the name is defined as an optional attribute and the component-id is defined as the key for the component list (in alignment with the approach followed for the network-element list).

# Network Inventory Tree Diagram {#ni-tree}

{{fig-ni-tree}} below shows the tree diagram of the YANG data model defined in module "ietf-network-inventory" ({{ni-yang}}).

~~~~ ascii-art
{::include-fold yang/ietf-network-inventory.tree}
~~~~
{:#fig-ni-tree title="Network inventory tree diagram"
artwork-name="ietf-network-inventory.tree"}

# YANG Data Model for Network Inventory {#ni-yang}

~~~~ yang
{::include yang/ietf-network-inventory.yang}
~~~~
{:#fig-ni-yang title="Network inventory YANG module"
sourcecode-markers="true" sourcecode-name="ietf-network-inventory@2025-10-07.yang"}

# Operational Considerations

The network inventory YANG data model defined in the document is intended to report the actual inventory data that a network controller knows of the network elements and components actually installed within the network. Therefore, this data model provides a read-only perspective of the network inventory information.

As outlined in {{intro}}, per the definition of {{?RFC8969}}, the network inventory model is a network model.

This information can be provided by a network controller to an higher level hierarchical network controller, to an Inventory OSS or to any other type of application which needs to discover the network inventory information.

For example, in the context of ACTN, the network inventory YANG data model can be used at the MPI interfaces, as defined in {{?RFC8453}}, or on an interface, not defined in {{?RFC8453}} between the MDSC and the Inventory OSS.

The information in the model is populated by controller by reading it from the devices using the device model supported by the devices. This model does not constraint the device models used on the device: the YANG data model defined in {{!RFC8348}} is an option but other options (e.g., vendor specific interfaces or YANG data models) are also allowed. In case some information is not provided by the device, the network controller SHALL omit this information unless this information is known by other sources of information (e.g., through local configuration within the network controller).

In case of hierarchical controllers, a hierarchical network controller can also collect the network inventory information from its lower level network controllers using this YANG data model (or other mechanisms which are outside the scope of this document) and report the combined network inventory information to an an higher level network controller, to an Inventory OSS or to any other type of application which needs to discover the network inventory information.

# Security Considerations

This section is modeled after the template described in {{Section 3.7
of ?I-D.ietf-netmod-rfc8407bis}}.

The "ietf-network-inventory" YANG module defines a data model that is
designed to be accessed via YANG-based management protocols, such as
NETCONF {{?RFC6241}} and RESTCONF {{?RFC8040}}. These YANG-based management
protocols (1) have to use a secure transport layer (e.g., SSH {{?RFC4252}}, TLS {{?RFC8446}},
and QUIC {{?RFC9000}}) and (2) have to use mutual authentication.

The Network Configuration Access Control Model (NACM) {{!RFC8341}}
provides the means to restrict access for particular NETCONF or
RESTCONF users to a preconfigured subset of all available NETCONF or
RESTCONF protocol operations and content.

Some of the readable data nodes in this YANG module may be considered
sensitive or vulnerable in some network environments.  It is thus
important to control read access (e.g., via get, get-config, or
notification) to these data nodes.

Specifically, the following subtrees and data nodes have particular sensitivities/vulnerabilities:

- "/nwi:network-elements"

> This subtree reports the inventory information for all the network elements and their hardware components deployed within the network as well as of the software modules being active on these network elements and components. Unauthorized access to this subtree can disclose this information. A malicious attacker can use this information to perform targeted attacks to network elements, hardware components or software modules with known vulnerabilities.

Modules that use the groupings that are defined in this document
should identify the corresponding security considerations. For example, reusing the 'component-attributes' grouping may expose sensitive information.

# IANA Considerations

IANA is requested to register the following URI in the "ns"
registry within the "IETF XML Registry" group {{?RFC3688}}:

~~~~
      URI: urn:ietf:params:xml:ns:ietf-network-inventory
      Registrant Contact: The IESG
      XML: N/A; the requested URI is an XML namespace.
~~~~

IANA is requested to register the following YANG module in the "YANG
Module Names" registry {{!RFC6020}} within the "YANG Parameters"
registry group.

~~~~
      name:         ietf-network-inventory
      namespace:    urn:ietf:params:xml:ns:yang:ietf-network-inventory
      prefix:       nwi
      reference:    RFC XXXX
~~~~

--- back

# Comparison With Openconfig-platform Data Model

Since more and more devices can be managed by domain controller through OpenConfig, to ensure that our inventory data model can cover these devices' inventory data, we have compared our inventory data model with the "openconfig-platform" model which is the data model used to manage inventory information in OpenConfig.

Openconfig-platform data model is NE-level and uses a generic component concept to describe its inner devices and containers, which is similar to "ietf-hardware" model in {{?RFC8348}}. Since we have also reused the component concept of {{?RFC8348}} in our inventory data model, we can compare the component's attributes between "openconfig-platform" and our model directly , which is stated below:

| Attributes in oc-platform  | Attributes in our model  | remark                   |
| -------------------------- | ------------------------ | ------------------------ |
| name                       | name                     |                          |
| type                       | class                    |                          |
| id                         | uuid                     |                          |
| location                   | location                 |                          |
| description                | description              |                          |
| mfg-name                   | mfg-name                 |                          |
| mfg-date                   | mfg-date                 |                          |
| hardware-version           | hardware-rev             |                          |
| firmware-version           | firmware-rev             |                          |
| software-version           | software-rev             |                          |
| serial-no                  | serial-num               |                          |
| part-no                    | part-number              |                          |
| clei-code                  |                          | Not defined even in RFC-8348 at device level  |
| removable                  | is-fru                   |                          |
| oper-status                |                          | state data               |
| empty                      | contained-child?         | If there is no contained child, it is empty.  |
| parent                     | parent-references        |                          |
| redundant-role             |                          | functional information, may be part of future augmentation |
| last-switchover-reason     |                          | state data               |
| last-switchover-time       |                          | state data               |
| last-reboot-reason         |                          | state data               |
| last-reboot-time           |                          | state data               |
| switchover-ready           |                          | state data               |
| temperature                |                          | performance data         |
| memory                     |                          | performance data         |
| allocated-power            |                          | state/performance data   |
| used-power                 |                          | state/performance data   |
| pcie                       |                          | alarm  data              |
| properties                 |                          | Generic properties can be handled as part of "description" |
| subcomponents              |                          |                          |
| chassis                    |                          |                          |
| port                       |                          |                          |
| power-supply               |                          | Power supply is considered as a specific board. And no need to define as a single component |
| fan                        |                          | Fan is considered as a specific board. And no need to define as a single component  |
| fabric                     |                          | Fabric is considered as a specific board. And no need to define as a single component  |
| storage                    |                          | Technology specific      |
| cpu                        |                          | Technology specific      |
| integrated-circuit         |                          |                          |
| backplane                  |                          | Backplane is considered as a part of board. And no need to define as a single component  |
| software-module            |                          | managed in the software-rev list |
| controller-card            |                          | Controller card is considered as a specific functional board. And no need to define as a single component  |
{:#tab-oc title="Comparison between openconfig platform and inventory data models"}

As it mentioned in {{ne-component}} that state data and performance data are out of scope of our data model, it is same for alarm data and it should be defined in some other alarm data models separately. And for some component specific structures in "openconfig-platform", we consider some of them can be contained by our existing structure, such as fan, backplane, and controller-card, while some others do not need to be included in this network inventory model like storage and cpu.

Mostly, our inventory data model can cover the attributes from OpenConfig.

# Terminology of Container

Within this document , with the term "container" we consider an hardware component class capable of containing one or more removable physical entities, e.g. a slot in a chassis is containing a board.

| terminology of IVY base model  |terminology in other model  |
| ------------------------------ | -------------------------- |
| container                      | holder                     |
{:#tab-term title="terminology mapping"}

# Efficiency Issue

During  the integration with OSS in some operators, some efficiency/scalability concerns have been discovered when synchronizing network inventory data for big networks.  More discussions are needed to address these concerns.

Considering that relational databases are widely used by traditional OSS systems and also by some network controllers, the inventory objects are most likely to be saved in different tables. With the model defined in this document, when doing a full synchronization, network controller needs to convert all inventory objects of each NE into component objects and combine them together into a single list, and then construct a response and send to OSS or MDSC. The OSS or MDSC needs to classify the component list and divide them into different groups, in order to save them in different tables. The combining-regrouping steps are impacting the network controller & OSS/MDSC processing, which may result in efficiency/scalability limitations in large scale networks.

An alternative YANG model structure, which defines the inventory objects directly, instead of defining generic components, has also been analyzed. However, also with this model, there still could be some scalability limitations when synchronizing full inventory resources in large scale of networks. This scalability limitation is caused by the limited transmission capabilities of HTTP protocol. We think that this scalability limitation should be solved at protocol level rather than data model level.

The model proposed by this document is designed to be as generic as possible so to cover future special types of inventory objects that could be used in other technologies, that have not been identified yet. If the inventory objects were to be defined directly with fixed hierarchical relationships in YANG model, this new type of inventory objects needs to be manually defined, which is not a backward compatible change and therefore is not an acceptable approach for implementation. With a generic model, it is only needed to augment a new component class and extend some specific attributes for this new inventory component class, which is more flexible. We consider that this generic data model, enabling a flexible and backward compatible approach for other technologies, represents the main scope of this document. Solution description to efficiency/scalability limitations mentioned above is considered as out-of-scope.

# Examples of ports {#port-examples}

This appendix provides some examples of port implementations and how they can be modelled using the "ietf-network-inventory" module defined in {{ni-yang}}.

{{fig-board}} shows an example of a single board which contains three type of ports:

1. An integrated port (non pluggable);
1. An empty port;
1. A pluggable port

~~~~ aasvg
{::include figures/board-example.txt}
~~~~
{:#fig-board title="Example of a board with different types of ports"}

## JSON Examples

This appendix contains an example of an instance data tree in JSON encoding {{?RFC7951}}, instantiating the "ietf-network-inventory" module to describe the three types of ports on a single board, as shown in {{fig-board}}.

~~~~ ascii-art
{::include-fold json/port-examples.json}
~~~~

# Example of multi-chassis network elements {#multi-chassis-examples}

This appendix provides some examples of multi-chassis network elements and how they can be modelled using the "ietf-network-inventory" module defined in {{ni-yang}}.

Multi-chassis network elements are network elements composed by two or more chassis interconnected, in principle, with any topology.

Stacked switches are an example of multi-chassis which consist of multiple standalone switches that are interconnected through dedicated stack ports and cables and managed as a single logical unit. Stacked switch:
- are connected using a daisy-chain or a ring topology
- are managed using a single IP Address
- synchronized software-upgrade
- use Priority/MAC-Addr(s) to decide Master/Members selection and communication.

{{fig-daisy-chain-stacked}} and {{fig-ring-stacked}} describe two examples of stacked switch with three stacked switches (pizza boxes) connected in a daisy-chain or ring topology.

~~~~ aasvg
{::include figures/multichassis-daisy-example.txt}
~~~~
{:#fig-daisy-chain-stacked title="Example of a stacked switch in a daisy chain topology"}

~~~~ aasvg
{::include figures/multichassis-ring-example.txt}
~~~~
{:#fig-ring-stacked title="Example of a stacked switch in a ring topology"}

Using the base network inventory YANG data model, each stackable switch can be modelled as a chassis within the same network element, which models the stacked switch. The stack ports are modelled like other ports. The stack cables are not reported using the base network inventory YANG data model but can be reported using the passive network inventory YANG data model under definition in {{?I-D.ygb-ivy-passive-network-inventory}}.

Cascaded switches are another example of multi-chassis which consist of multiple standalone switches that are interconnected and managed as a single logical unit. Cascaded switch:
- are usually connected in a tree topology
- are managed using a single IP Address
- the root of the tree is configured as Master.

{{fig-tree-cascaded}} describe an example of cascaded switch with three chassis connected in a tree topology.

~~~~ aasvg
{::include figures/multichassis-hierarchical-example.txt}
~~~~
{:#fig-tree-cascaded title="Example of a cascaded switch in a tree topology"}

Using the base network inventory YANG data model each interconnected switch can be modelled as a chassis within the same network element, which models the cascaded switch. The ports used to interconnect the different chassis are normal (traffic) ports and modelled like other ports. The interconnecting cables are not reported using the base network inventory YANG data model but can be reported using the passive network inventory model under definition in {{?I-D.ygb-ivy-passive-network-inventory}}.

## JSON Examples

This appendix contains an example of an instance data tree in JSON encoding {{?RFC7951}}, instantiating the "ietf-network-inventory" model to describe the three examples of multi-chassis NEs, as shown in {{fig-daisy-chain-stacked}}, {{fig-ring-stacked}} and {{fig-tree-cascaded}}.

> Note: the base inventory model allows reporting only the chassis and ports configuration. Reporting the link between the chassis of the same NE is outside the scope of the base inventory model. The YANG data model under definition in {{?I-D.ygb-ivy-passive-network-inventory}} as an augmentation of the base inventory YANG data model can be used to provide this additional information.

~~~~ ascii-art
{::include-fold json/multi-chassis-examples.json}
~~~~

# Example of non-modular network elements {#non-modular-examples}

This appendix provides some examples of non-modular network elements and how they can be modelled using the "ietf-network-inventory" module defined in {{ni-yang}}.

Non-modular network elements (also known as "pizza boxes") are network elements composed by a single chassis as a self-contained system. A non-modular network element does not have any slots to take cards so it cannot take any non-field replaceable modules other than pluggable ports.

Using the base network inventory YANG data model a non-modular network element can be modelled as a network element containing only one chassis and ports (as child components of the chassis).

Reporting the single chassis component within a non-modular network element is required because the chassis component is the type of component which provides the physical characteristics of the network element chassis (the network element is defined just as an assembly of components) and its location, using the network inventory YANG data model under definition in {{?I-D.ietf-ivy-network-inventory-location}}.

## JSON Examples

This appendix contains an example of an instance data tree in JSON encoding {{?RFC7951}}, instantiating the "ietf-network-inventory" module to describe an example of a non-modular network element.

~~~~ ascii-art
{::include-fold json/pizza-box-example.json}
~~~~

{: numbered="false"}

# Acknowledgments

The authors of this document would like to thank the authors of {{?I-D.ietf-teas-actn-poi-applicability}} for having identified the gap and requirements to trigger this work.

This document was prepared using kramdown.
