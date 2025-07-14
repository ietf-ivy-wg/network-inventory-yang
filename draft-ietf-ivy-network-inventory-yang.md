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

This document defines a base YANG data model for network inventory. The scope of this base model is set to
be application- and technology-agnostic. The base data model can be augmented with application- and technology-specific details.

--- middle

# Introduction

This document defines a base network inventory
YANG data model that is application- and technology-agnostic.  The
base data model can be augmented to describe application- and technology-specific information.
Please note that the usage of term "network inventory", in the context of this I-D, is to indicate that it is
describing "network-wide" scope inventory information.

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

Network Inventory is a collection of data for network devices and their components managed by a specific management system.
Per the definition of {{?RFC8969}}, the network inventory model is a network model.

This document defines one YANG module "ietf-network-inventory" in {{ni-yang}}.

This base data model is application- and technology-agnostic (that is, valid for IP/MPLS, optical, and
microwave networks as well as optical local loops, access networks, core networks, data centers, etc.) and can be augmented to
include required application- and technology-specific inventory details together with specific hardware or software component's attributes.

The YANG data model defined in the document is scoped to cover the common use cases for Inventory but at network-wide level, covering both hardware and base software information.

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

> Editors' Note: The chassis and port definition below needs to be moved to iana-hardware update

Chassis:
: A field replaceable equipment with a particular structural format and dimensions.
A chassis can include spaces to take cards (called slots).
: Elsewhere, a chassis can be called shelf, sub-rack, etc.

Port:
: A component where networking traffic can be received and/or transmitted, e.g., by attaching networking cables.
: In case of pluggable ports, the port may be empty when no transceiver module is plugged in.

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
: A pluggable equipment with a particular structural format and dimensions which can be inserted into one or more slots (or sub-slots). A card can have spaces to take other cards (called sub-slots).
: Elsewhere, a card can be called board, module, circuit pack, etc..

Slot:
: A space in a chassis that can be equipped with one card, which may be chosen from a limited range of types of cards. A slot can be subdivided into smaller spaces (called sub-slots).

Physical interface:
: An interface associated to a physical port. A physical interface is always in the lowest layer of the interface stack.

Logical interface:
: An interface which is not associated to a physical port.

> Editors' Note: check whether the definitions of physical and logical interfaces can be replaced by a normative reference to {{!RFC8343}}

Breakout Port:
: A port is usually associated with a single physical interface. A breakout port is a port which is broken down and associated into multiple physical interfaces. Those physical interfaces can have the same or different speeds and the same or different number of breakout channels.

Trunk Port:
: A trunk port is a port which is associated with one and only physical interface.

Port Breakout:
: The configuration of a breakout port.

> Note that interface channelization, when an interface (e.g., an Ethernet interface) is configured to support multiple logical sub-interfaces (e.g., VLAN interfaces), is different than port breakout and outside the scope of inventory models.

Breakout channel:
: An abstraction of the atomic resource elements into which a breakout port can be broken down: a physical interface can be associated with one or more breakout channels but no more than one physical interface can be associated with one breakout channel.
: The physical elements abstracted as breakout channels are implementation specific.
{{port-examples}} provides some examples of breakout ports configurations and implementations.

Container:
: A hardware component class that is capable of containing one or more removable physical entities (e.g., a slot in a chassis is containing a board).

Transceiver:
: A transceiver represents a transmitter/receiver (Tx/Rx) pair which is transmitting and receiving a signal from the media.
: This definition generalizes the transceiver definition in {{?I-D.ietf-ccamp-optical-impairment-topology-yang}} to model also non optical transceivers (e.g., electrical transceivers).

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

# YANG Data Model for Network Inventory Overview

The base network inventory model, defined in this document, provides a list of network elements and of network element components:

~~~~ ascii-art
  +--rw network-inventory
     +--rw network-elements
        +--rw network-element* [ne-id]
           +--rw ne-id                 string
           ...
           +--rw components
              +--rw component* [component-id]
                 +--rw component-id                        string
                 ...
~~~~
{:#fig-overall title="Overall Tree Structure"}

The network-inventory top level container has been defined to support reporting other types of network inventory objects, besides the network elements and network element components.

These additional types of network inventory objects can be defined, together with the associated YANG data model and the rationale for managing them as part of the network inventory, in other documents providing application- and technology-specific companion augmentation data models, such as
{{?I-D.ietf-ivy-network-inventory-location}}

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
{:#fig-nec-tree title="Common Attributes Between Network Elements and Components Subtree"}

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
{:#fig-ne-tree title="Network Elements Subtree"}

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
{:#fig-comp-tree title="Components Subtree"}

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
{{?I-D.ietf-ivy-network-inventory-software}}.

### Breakout ports {#ports}

The model defines the 'breakout-channels' presence container to indicate whether the port, which contains the transceiver module, can be configured as a breakout port or not.

The breakout channels represent the capability of the port to support port breakout, independently on how the port is configured (trunk or breakout).

It is assumed that a port which supports port breakout can be configured either as a trunk port or as a breakout port.

Reporting whether a port, which supports port breakout, is configured as a trunk or as a breakout port, is outside the scope of the base network inventory model. The model providing the mapping between the topology and the inventory models should provide sufficient information to identify how the port is configured and, in case of breakout configuration, which breakout channel is associated with which Link Termination Point (LTP), abstracting a device physical interface within the topology model.

## Changes Since RFC 8348

This document re-defines some attributes listed in {{!RFC8348}}, based on some integration experience for network inventory data.

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
sourcecode-markers="true" sourcecode-name="ietf-network-inventory@2025-02-03.yang"}

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
| subcomponents              |                          |                          |
| chassis                    |                          |                          |
| port                       |                          |                          |
| power-supply               |                          | TBD                      |
| fan                        |                          | Fan is considered as a specific board. And no need to define as a single component  |
| fabric                     |                          | TBD                      |
| storage                    |                          | For Optical and IP technology, no need to manage storage on network element |
| cpu                        |                          | For Optical and IP technology, no need to manage CPU on network element  |
| integrated-circuit         |                          |                          |
| backplane                  |                          | Backplane is considered as a part of board. And no need to define as a single component  |
| software-module            |                          | TBD                      |
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

Considering that relational databases are widely used by traditional OSS systems and also by some network controllers, the inventory objects are most likely to be saved in different tables. With the model defined in current draft, when doing a full synchronization, network controller needs to convert all inventory objects of each NE into component objects and combine them together into a single list, and then construct a response and send to OSS or MDSC. The OSS or MDSC needs to classify the component list and divide them into different groups, in order to save them in different tables. The combining-regrouping steps are impacting the network controller & OSS/MDSC processing, which may result in efficiency/scalability limitations in large scale networks.

An alternative YANG model structure, which defines the inventory objects directly, instead of defining generic components, has also been analyzed. However, also with this model, there still could be some scalability limitations when synchronizing full inventory resources in large scale of networks. This scalability limitation is caused by the limited transmission capabilities of HTTP protocol. We think that this scalability limitation should be solved at protocol level rather than data model level.

The model proposed by this draft is designed to be as generic as possible so to cover future special types of inventory objects that could be used in other technologies, that have not been identified yet. If the inventory objects were to be defined directly with fixed hierarchical relationships in YANG model, this new type of inventory objects needs to be manually defined, which is not a backward compatible change and therefore is not an acceptable approach for implementation. With a generic model, it is only needed to augment a new component class and extend some specific attributes for this new inventory component class, which is more flexible. We consider that this generic data model, enabling a flexible and backward compatible approach for other technologies, represents the main scope of this draft. Solution description to efficiency/scalability limitations mentioned above is considered as out-of-scope.

# Examples of ports, transceivers and port breakouts {#port-examples}

This appendix provides some examples of ports, transceivers and port breakouts implementations and how they can be modelled using the "ietf-network-inventory" model defined in {{ni-yang}}.

{{fig-board}} shows an example of a single board which contains three type of ports:

1. An integrated port (non pluggable). This port can be of any type (e.g., optical or electrical), single-channel or multi-channel but not supporting breakouts;
1. An empty port;
1. A pluggable port

~~~~ aasvg
{::include figures/board-example.txt}
~~~~
{:#fig-board title="Example of a board with different types of ports"}

{{fig-single-channel}} describes an implementation of a single channel optical pluggable trunk port (e.g., a 100G-LR port configured as a single 100GE interface)

~~~~ aasvg
{::include figures/single-channel-port-example.txt}
~~~~
{:#fig-single-channel title="Example of a single channel optical pluggable port"}

{{fig-wdm-multi-channel}} describes an implementation of a Wavelength-Division Multiplexing (WDM) based multi-channel optical pluggable trunk port (e.g., a 400G-LR4 port configured as a single 400GE interface).

~~~~ aasvg
{::include figures/wdm-multi-channel-port-example.txt}
~~~~
{:#fig-wdm-multi-channel title="Example of a WDM multi-channel optical pluggable port"}

In this example, since breakout is not supported, the four WDM channels cannot be modelled as breakout channels and are not relevant from inventory management perspective.

{{fig-mpo-trunk}} describes an implementation of a Multi-Fiber Push-on (MPO) trunk port (e.g., 400G-DR4 port configured as a single 400GE interface).

~~~~ aasvg
{::include figures/mpo-trunk-port-example.txt}
~~~~
{:#fig-mpo-trunk title="Example of a MPO trunk port"}

If this MPO port cannot support breakouts, the four line channels cannot be modelled as breakout channels and are not relevant from inventory management perspective. From a network inventory perspective, there is no difference between single-channel ports and MPO trunk ports which do not support port breakouts.

Instead, the MPO port can support breakouts, the four line channels are reported as breakout channels because, as describe in {{ports}}, the breakout channels represent the capability of the port to support breakout, independently on how the port is configured (trunk or breakout).

{{fig-mpo-breakout}} describes an implementation of a MPO breakout port (e.g., 400G-DR4 port configured as 4x100GE interfaces).

~~~~ aasvg
{::include figures/mpo-breakout-port-example.txt}
~~~~
{:#fig-mpo-breakout title="Example of a MPO breakout port"}

In this example, the four line channels are reported as breakout channels because the port shall support breakout in order to be configured as a breakout port.

## JSON Examples

This appendix contains an example of an instance data tree in JSON encoding {{?RFC7951}}, instantiating the "ietf-network-inventory" model to describe a single board, as shown in {{fig-board}}, with seven different types of ports, transceivers and breakouts configurations:

1. An integrated port (non pluggable), as shown in {{fig-board}};
1. An empty port, as shown in {{fig-board}};
1. A single channel optical pluggable port, as shown in {{fig-board}} and {{fig-single-channel}};
1. A WDM based multi-channel optical pluggable port, as shown in {{fig-board}} and {{fig-wdm-multi-channel}};
1. An MPO trunk port, as shown in {{fig-board}} and {{fig-mpo-trunk}}, which does not support port breakouts;
1. An MPO trunk port, as shown in {{fig-board}} and {{fig-mpo-trunk}}, which can not support port breakouts but it has been configured as a trunk port,
1. An MPO breakout port, as shown in {{fig-board}} and {{fig-mpo-breakout}}.

Note: as described in {{ports}}, reporting whether an MPO port is configured as a trunk or as a breakout port, is outside the scope of the base network inventory model.

~~~~ ascii-art
{::include-fold json/ports-transceivers-breakouts-examples.json}
~~~~

# Example of multi-chassis network elements {#multi-chassis-examples}

This appendix provides some examples of multi-chassis network elements and how they can be modelled using the "ietf-network-inventory" model defined in {{ni-yang}}.

Multi-chassis network elements are network elements composed by two or more chassis interconnected, in principle, with any topology.

Stacked switches are an example of multi-chassis which consist of multiple standalone switches that are interconnected through dedicated stack ports and cables and managed as a single logical unit. Stacked switch:
- are connected using a daisy-chain or a ring topology
- are managed using a single IP Address
- synchronized software-upgrade
- use Priority/MAC-Addr(s) decide Master/Members selection and communication.

{{fig-daisy-chain-stacked}} and {{fig-ring-stacked}} describe two examples of stacked switch with three stacked switches (pizza boxes) connected in a daisy-chain or ring topology.

~~~~ aasvg
{::include figures/multichassis-daisy-example.txt}
~~~~
{:#fig-daisy-chain-stacked title="Example of a stacked switch in a daisy chain topology"}

~~~~ aasvg
{::include figures/multichassis-ring-example.txt}
~~~~
{:#fig-ring-stacked title="Example of a stacked switch in a ring topology"}

Using the base network inventory model, each stackable switch can be modelled as a chassis within the same network element, which models the stacked switch. The stack ports are modelled like other ports. The stack cables are not reported using the base network inventory model but can be reported using the passive network inventory model under definition in {{?I-D.ygb-ivy-passive-network-inventory}}.

Cascaded switches are another example of multi-chassis which consist of multiple standalone switches that are interconnected and managed as a single logical unit. Cascaded switch:
- are usually connected in a tree topology
- are managed using a single IP Address
- the root of the tree is configured as Master.

{{fig-tree-cascaded}} describe an example of cascaded switch with three chassis connected in a tree topology.

~~~~ aasvg
{::include figures/multichassis-hierarchical-example.txt}
~~~~
{:#fig-tree-cascaded title="Example of a cascaded switch in a tree topology"}

Using the base network inventory model each interconnected switch can be modelled as a chassis within the same network element, which models the cascaded switch. The ports used to interconnect the different chassis are normal (traffic) ports and modelled like other ports. The interconnecting cables are not reported using the base network inventory model but can be reported using the passive network inventory model under definition in {{?I-D.ygb-ivy-passive-network-inventory}}.

## JSON Examples

This appendix contains an example of an instance data tree in JSON encoding {{?RFC7951}}, instantiating the "ietf-network-inventory" model to describe the three examples of multi-chassis NEs, as shown in xxx, yyy and zzz.

> Note: the base inventory model allows reporting only the chassis and ports configuration. Reporting the link between the chassis of the same NE is outside the scope of the base inventory model. The YANG data model under definition in {{?I-D.ygb-ivy-passive-network-inventory}} as an augmentation of the base inventory model can be used to provide this additional information.

~~~~ ascii-art
{::include-fold json/multi-chassis-examples.json}
~~~~

{: numbered="false"}

# Acknowledgments

The authors of this document would like to thank the authors of {{?I-D.ietf-teas-actn-poi-applicability}} for having identified the gap and requirements to trigger this work.

This document was prepared using kramdown.
