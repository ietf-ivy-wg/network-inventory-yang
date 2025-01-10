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
    org: TIM
    email: fabio.peruzzini@telecomitalia.it
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

  IANA_YANG:
    title: iana-hardware YANG Module
    author:
      org: IANA
    target: https://www.iana.org/assignments/iana-hardware/iana-hardware.xhtml

informative:

--- abstract

This document defines a base YANG data model for network inventory. The scope of this base model is set to
be application- and technology-agnostic. However, the data model is designed with appropriate provisions to ease
future augmentations with application-specific and technology-specific details.

--- middle

# Introduction

This document defines a base network inventory
YANG data model that is application- and technology-agnostic.  The
base data model can be augmented to describe application-specific or
technology-specific information.

Network inventory is a fundamental functional block in the overall network
management which was specified many years ago. Network inventory management is a critical
part for ensuring that the network remains healthy (e.g., auditing to identify faulty elements), well-planned (e.g., identify assets to upgrade or to decommission), and maintained appropriately to meet the performance objectives. Also, network inventory
management allows operators to keep track of which devices are deployed in their networks, including relevant embedded software and
hardware versions.

Exposing standards interfaces to retrieve and query network elements capabilities as recorded in an inventory are key enablers for many applications that consume network inventory data. From that standpoint and given the emergence of standard data models and their deployment by operators, the conventional function of inventory management is also required to be defined as a data model.

For example, {{?I-D.ietf-teas-actn-poi-applicability}} identifies a gap about the lack of a YANG data model that could be used at Abstraction and Control of TE Networks (ACTN) Multi-Domain Service Coordinator-Provisioning Network Controller Interface (MPI) level to report whole or partial network hardware
inventory information available at domain controller level towards
upper layer systems (e.g., Multi-Domain Service Coordinator (MDSC) or Operations Support Systems (OSS) layers).

It is key for operators to coordinate with the industry towards the use of a
standard YANG data model for Network Inventory data instead
of using vendors proprietary APIs.

{{!RFC8348}} defines a YANG data model for the management of the hardware on a single server and therefore it is more applicable to the domain controller towards the network elements rather than at the northbound interface of a network controller (e.g., toward an application or another hierarchical network controller). However, the YANG data model defined in {{!RFC8348}} has been used as a reference for defining the YANG network inventory data model presented in this document.

Network Inventory is a collection of data for network devices and their components managed by a specific management system.
Per the definition of {{?RFC8969}}, the network inventory model is a network model.

This document defines one YANG module "ietf-network-inventory" in {{ni-yang}}.

This base data model is technology-agnostic (that is, valid for IP/MPLS, optical, and
microwave networks in particular) and can be augmented to
include required technology-specific inventory details together with specific hardware or software component's attributes.

The YANG data model defined in the document is scoped to cover the common requirements for both hardware and software (but with base functions) use cases for Network Inventory.

{{ni-augment}} provides a set of considerations for future extensions of hardware, software, entitlement, and inventory topology mapping.

The YANG data model defined in this document conforms to the Network Management Datastore Architecture {{!RFC8342}}.

The YANG data model defined in the document is intended to only report actual inventory data which includes both applied configuration data and state data of the network elements and components actually installed within the network.

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
- client
- server
- augment
- data model
- data node

The following terms are defined in {{!RFC6241}} and are not redefined here:
- configuration data
- state data

The following terms are defined in {{!RFC8342}} and are not redefined here:
- applied configuration

The following terms are defined in {{IANA_YANG}} and are not redefined here:
- backplane
- battery
- container
- cpu
- chassis
- fan
- module
- port
- power supply
- sensor
- stack
- storage device

> Note that the definition of port component in {{IANA_YANG}} needs to be refined in future version of this document.

> TBD: Recap the concept of chassis/slot/component/board/... in {{TMF_SD2-20}}.

Also, the document makes use of the following terms:

Network Inventory:
: A collection of data for network elements and their components managed by a specific management system.

Physical Network Element:
: An implementation or application specific group of components (e.g., hardware components).

Network Element:
: The generalization of the physical network element definition.

Hardware Component:
: The generalization of the hardware components defined in {{IANA_YANG}} (e.g., backplane, battery, container, cpu, chassis, fan, module, port, power supply, sensor, stack and storage device components).
: The list of hardware components can be extended in future versions of {{IANA_YANG}}.

Component:
: The generalization of the hardware component definition to include other inventory objects which can be managed, from an inventory perspective, like hardware components.

Slot:
: A holder of the board.

Board/Card:
: A pluggable equipment can be inserted into one or several slots (or sub-slots) and can afford a specific transmission function independently.

## Tree Diagrams

The meanings of the symbols in the YANG tree diagrams are defined in {{?RFC8340}}.

## YANG Prefixes

  {{tab-prefixes}} list the prefixes of the modules that are used in this document.

| Prefix | YANG Module                     | Reference     |
| ------ | ------------------------------- | ------------- |
| inet   | ietf-inet-types                 | {{Section 4 of !RFC6991}}  |
| yang   | ietf-yang-types                 | {{Section 3 of !RFC6991}}  |
| ianahw | iana-hardware                   | {{IANA_YANG}} |
| nwi    | ietf-network-inventory          | RFC XXXX      |
{: #tab-prefixes title="Prefixes and corresponding YANG modules"}

# YANG Data Model for Network Inventory Overview

The network element definition is generalized to support physical
network elements and other types of components' groups that can be managed as physical network elements from an
inventory perspective.

Physical network elements are usually devices such as hosts, gateways, terminal servers, and the like, which have management agents responsible for performing the network management functions requested by the network management stations ({?RFC1157}).

The data model for network elements defined in this document uses a flat list of network elements.

The "ne-type" is defined as a YANG identity to describe the type of the network element. This document defines only the "physical-network-element" identity.

Other types of network elements can be defined in other documents, together with the associated YANG identity and the rationale for managing them as network elements from an inventory perspective.

The component definition is also generalized to support any types of
component inventory objects that can be managed as hardware components from an inventory perspective.

The data model for components defined in this document uses a list of components within each network element.

Different types of components can be distinguished by the class of component. The component "class" is defined as a union between the hardware class identity, defined in "iana-hardware", and the "non-hardware" identity, defined in this document.

Other types of components can be defined in other documents, together with the associated YANG identity and the rationale for managing them as components from an inventory perspective.

Attributes related to specific class of component can be found in the component-specific-info structure.

The identity definition of additional types of "ne-type" and "non-
hardware" identity of component are outside the scope of this
document and could be defined in application-specific or technology-
specific companion augmentation data models, such as
{{?I-D.wzwb-ivy-network-inventory-software}}.

In {{!RFC8348}}, rack, chassis, slot, sub-slot, board and port are defined as components of network elements with generic attributes.

While {{!RFC8348}} is used to manage the hardware of a single server (e.g., a network element), the Network Inventory YANG data model is used to retrieve the base network inventory information that a controller discovers from all the network elements under its control.

However, the YANG data model defined in {{!RFC8348}} has been used as a reference for defining the YANG network inventory data model. This approach can simplify the implementation of this network inventory model when the controller uses the YANG data model defined in {{!RFC8348}} to retrieve the hardware  from the network elements under its control.

~~~~ ascii-art
  +--rw network-elements
     +--rw network-element* [ne-id]
        +--rw ne-id            string
        ...
        +--rw components
           +--rw component* [component-id]
              +--rw component-id            string
              ...
~~~~
{: #fig-overall title="Overall Tree Structure"}

## Common Design for All Inventory Objects {#common-attributes}

For all the inventory objects, there are some common attributes {{fig-nec-tree}}. Such as:

Identifier:
: The UUID format is used. Such identifiers are widely implemented with systems. It is guaranteed to be globally unique.

Name:
: A human-readable label information which could be used to present on a GUI. This name is suggested to be provided by a server.

Alias:
: A human-readable label information which could be modified by user. It could also be present on a GUI instead of name.

Description:
: A human-readable information which could be also input by a user. The description provides more detailed information to prompt users when performing maintenance operations.

~~~~ ascii-art
  +--rw network-elements
     +--rw network-element* [ne-id]
        +--rw ne-id            string
        +--rw ne-type?         identityref
        +--rw uuid?            yang:uuid
        +--rw name?            string
        +--rw description?     string
        +--rw alias?           string
        ...
        +--rw components
           +--rw component* [component-id]
              +--rw component-id            string
              +--rw uuid?                   yang:uuid
              +--rw name?                   string
              +--rw description?            string
              +--rw alias?                  string
              +--rw class                   union
              ...
~~~~
{: #fig-nec-tree title="Common Attributes Between Network Elements and Components Subtree"}

## Network Element

To be consistent with the component definition, some of the
attributes defined in {{!RFC8348}} for components are reused for network
elements as shown in {{fig-ne-tree}}.

~~~~ ascii-art
  +--rw network-elements
     +--rw network-element* [ne-id]
        ...
        +--rw hardware-rev?    string
        +--rw software-rev?    string
        +--rw mfg-name?        string
        +--rw mfg-date?        yang:date-and-time
        +--rw part-number?     string
        +--rw serial-number?   string
        +--rw product-name?    string
        ...
~~~~
{: #fig-ne-tree title="Network Elements Subtree"}

> Not all the attributes defined in {{?RFC8348}} are applicable for network element. And there could also be some missing attributes which are not recognized by {{?RFC8348}}. More extensions could be introduced in later revisions after the missing attributes are fully discussed.

## Components {#ne-component}

The YANG data model for network inventory mainly follows the same approach of {{!RFC8348}} and reports the network hardware inventory as a list of components with different types (e.g., chassis, module, and port).

The component definition ({{fig-comp-tree}}) is generalized to both hardware components
and non-hardware components (e.g., software components).

~~~~ ascii-art
  +--rw components
      +--rw component* [component-id]
        +--rw component-id            string
        +--rw uuid?                   yang:uuid
        +--rw name?                   string
        +--rw description?            string
        +--rw alias?                  string
        +--rw class                   union
        +--rw child-component-ref
        +--rw parent-rel-pos?         int32
        +--rw parent-component-ref
        +--rw hardware-rev?           string
        +--rw firmware-rev?           string
        +--rw software-rev?           string
        +--rw serial-num?             string
        +--rw mfg-name?               string
        +--rw part-number?            string
        +--rw asset-id?               string
        +--rw is-fru?                 boolean
        +--rw mfg-date?               yang:date-and-time
        +--rw uri*                    inet:uri
~~~~
{: #fig-comp-tree title="Components Subtree"}

For state data like "admin-state", "oper-state", and so on, this document considers that they are related to device hardware management, not network inventory. Therefore, they are outside of the scope of this document. Same for the sensor-data, they should be defined in some other performance monitoring data models instead of the inventory data model.

### Hardware Components

Based on TMF classification in {{TMF_SD2-20}}, hardware components can be divided into two groups, holder group and equipment group. The holder group contains rack, chassis, slot, sub-slot while the equipment group contains network-element, board and port.

{{fig-hw-inventory-object-relationship}} describes the relationship between typical inventory objects in a physical network element.

~~~~ ascii-art
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
{: #fig-hw-inventory-object-relationship title="Relationship between typical inventory objects in physical network elements"}

The "iana-hardware" module {{IANA_YANG}} defines YANG identities for
the hardware component types in the IANA-maintained "IANA-ENTITY-MIB"
registry.

Some of the definitions taken from {{!RFC8348}} are based on the ENTITY-MIB {{!RFC6933}}.

Additional attributes of specific hardware, such as CPU,
storage, port, or power supply are defined in the hardware extension.

### Software Components

This document defines "software-rev" of NEs and components, which are
basic software attributes of a Network Element.

The software and hardware components share the same attributes of the
component and have similar replaceable requirements. Generally, the
device also has other software data, for example, one or more
software patch information.

The software components of other
classes, such as platform software, BIOS, bootloader, and software
patch information, are outside the scope of this document and defined other documents such as
{{?I-D.wzwb-ivy-network-inventory-software}}.

## Changes Since RFC 8348

This document re-defines some attributes listed in {{!RFC8348}}, based on some integration experience for network wide inventory data.

### New Parent Identifiers' Reference

{{!RFC8348}} provides a "parent-ref" attribute, which was an identifier reference to its parent component. When the MDSC or OSS systems want to find this component's grandparent or higher level component in the hierarchy, they need to retrieve this parent-ref step by step. To reduce this iterative work, this document provides a list of hierarchical parent components' identifier references.

~~~~ ascii-art
  +--ro components
     +--ro component* [component-id]
        ...
        +--ro parent-component-references
        |   +--ro component-reference* [index]
        |      +--ro index    uint8
        |      +--ro class?   -> ../../../class
        |      +--ro uuid?    -> ../../../uuid
        ...
~~~~

The hierarchical components' identifier could be found by the "component-reference" list. The "index" attribute is used to order the list by the hierarchical relationship from topmost component (with the "index" set to 0) to bottom component.

### Component-Specific Info Design

According to the management requirements from operators, some important attributes are not defined in {{!RFC8348}}. These attributes could be component-specific and are not suitable to be defined under the component list node. Instead, they can be defined by augmenting the component-specific info container for the attributes applicable to HW e.g. boards/slot components only. Other component-specific attributes, such as SW-specific-info, may be defined in companion augmentation data models, such as
{{?I-D.wzwb-ivy-network-inventory-software}} and are out of the scope of this model.

~~~~ ascii-art
+--rw components
   +--rw component* [component-id]
      +--rw component-id            string
      ...
      +--ro chassis-specific-info
      +--ro slot-specific-info
      +--ro board-specific-info
      +--ro port-specific-info
      ...
~~~~

### Part Number

According to the description in {{!RFC8348}}, the attribute named "model-name" under the component, is preferred to have a customer-visible part number value. "Model-name" is not straightforward to understand and we suggest to rename it as "part-number" directly.

~~~~ ascii-art
  +--ro components
     +--ro component* [component-id]
        ...
        +--ro part-number?           string
        ...
~~~~

### Component identifiers

There are some use cases where the name of the components are assigned and changed by the operator. In these cases, the assigned names are also not guaranteed to be always unique.

In order to support these use cases, this model is not aligned with {{!RFC8348}} in defining the component name as the key for the component list.

Instead the name is defined as an optional attribute and the component-id is defined as the key for the component list (in alignment with the approach followed for the network-element list).

{: #ni-augment}

# Extending Network Inventory

This document defines the basic network inventory attributes
applicable to typical network scenarios.  For finer-grained and
specific management scenarios, the relationship between this model
and other models is illustrated in Figure 4.

~~~~ ascii-art
             +-------------------------+
             |                         |
             | Base Network Inventory  |
             |                         |
             +------------+------------+
                          |
       +------------------+-------------------+
       |                  |                   |
+------V------+    +------V------      +------V------    +-------------+
|             |    |             |     |             |   |             |
| Hardware    |    |  Software   |     |             |   |  Inventory  |
| Extensions  |    |  Extensions |     | Entitlement |   |  Topology   |
| e.g. Power  |    |  e.g.       |     |             |   |  Mapping    |
| supply unit |    |  SW patch   |     |             |   |             |
+-------------+    +-------------+     +-------------+   +-------------+
~~~~

{: #ni-tree}

# Network Inventory Tree Diagram

{{fig-ni-tree}} below shows the tree diagram of the YANG data model defined in module "ietf-network-inventory" ({{ni-yang}}).

~~~~ ascii-art
{::include ./ietf-network-inventory.tree}
~~~~
{: #fig-ni-tree title="Network inventory tree diagram"
artwork-name="ietf-network-inventory.tree"}

{: #ni-yang}

# YANG Data Model for Network Inventory

~~~~ yang
{::include ./ietf-network-inventory.yang}
~~~~
{: #fig-ni-yang title="Network inventory YANG module"
sourcecode-markers="true" sourcecode-name="ietf-network-inventory@2024-10-02.yang"}

# Manageability Considerations

  \<Add any manageability considerations>

# Security Considerations

  \<Add any security considerations>

# IANA Considerations

  \<Add any IANA considerations>

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
| clei-code                  |                          | TBD                      |
| removable                  | is-fru                   |                          |
| oper-status                |                          | state data               |
| empty                      | contained-child?         | If there is no contained child, it is empty.  |
| parent                     | parent-references        |                          |
| redundant-role             |                          | TBD                      |
| last-switchover-reason     |                          | state data               |
| last-switchover-time       |                          | state data               |
| last-reboot-reason         |                          | state data               |
| last-reboot-time           |                          | state data               |
| switchover-ready           |                          | state data               |
| temperature                |                          | performance data         |
| memory                     |                          | performance data         |
| allocated-power            |                          | TBD                      |
| used-power                 |                          | TBD                      |
| pcie                       |                          | alarm  data              |
| properties                 |                          | TBD                      |
| subcomponents              | contained-child          |                          |
| chassis                    | chassis-specific-info    |                          |
| port                       | port-specific-info       |                          |
| power-supply               |                          | TBD                      |
| fan                        |                          | Fan is considered as a specific board. And no need to define as a single component  |
| fabric                     |                          | TBD                      |
| storage                    |                          | For Optical and IP technology, no need to manage storage on network element |
| cpu                        |                          | For Optical and IP technology, no need to manage CPU on network element  |
| integrated-circuit         | board-specific-info      |                          |
| backplane                  |                          | Backplane is considered as a part of board. And no need to define as a single component  |
| software-module            |                          | TBD                      |
| controller-card            |                          | Controller card is considered as a specific functional board. And no need to define as a single component  |
{: #tab-oc title="Comparison between openconfig platform and inventory data models"}

As it mentioned in {{ne-component}} that state data and performance data are out of scope of our data model, it is same for alarm data and it should be defined in some other alarm data models separately. And for some component specific structures in "openconfig-platform", we consider some of them can be contained by our existing structure, such as fan, backplane, and controller-card, while some others do not need to be included in this network inventory model like storage and cpu.

Mostly, our inventory data model can cover the attributes from OpenConfig.

# Efficiency Issue

During  the integration with OSS in some operators, some efficiency/scalability concerns have been discovered when synchronizing network inventory data for big networks.  More discussions are needed to address these concerns.

Considering that relational databases are widely used by traditional OSS systems and also by some network controllers, the inventory objects are most likely to be saved in different tables. With the model defined in current draft, when doing a full synchronization, network controller needs to convert all inventory objects of each NE into component objects and combine them together into a single list, and then construct a response and send to OSS or MDSC. The OSS or MDSC needs to classify the component list and divide them into different groups, in order to save them in different tables. The combining-regrouping steps are impacting the network controller & OSS/MDSC processing, which may result in efficiency/scalability limitations in large scale networks.

An alternative YANG model structure, which defines the inventory objects directly, instead of defining generic components, has also been analyzed. However, also with this model, there still could be some scalability limitations when synchronizing full inventory resources in large scale of networks. This scalability limitation is caused by the limited transmission capabilities of HTTP protocol. We think that this scalability limitation should be solved at protocol level rather than data model level.

The model proposed by this draft is designed to be as generic as possible so to cover future special types of inventory objects that could be used in other technologies, that have not been identified yet. If the inventory objects were to be defined directly with fixed hierarchical relationships in YANG model, this new type of inventory objects needs to be manually defined, which is not a backward compatible change and therefore is not an acceptable approach for implementation. With a generic model, it is only needed to augment a new component class and extend some specific attributes for this new inventory component class, which is more flexible. We consider that this generic data model, enabling a flexible and backward compatible approach for other technologies, represents the main scope of this draft. Solution description to efficiency/scalability limitations mentioned above is considered as out-of-scope.

{: numbered="false"}

# Acknowledgments

The authors of this document would like to thank the authors of {{?I-D.ietf-teas-actn-poi-applicability}} for having identified the gap and requirements to trigger this work.

This document was prepared using kramdown.
