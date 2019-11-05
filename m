Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7337AEFA74
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 11:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfKEKHp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 05:07:45 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37000 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbfKEKHo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Nov 2019 05:07:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5A7Vup112247;
        Tue, 5 Nov 2019 04:07:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572948451;
        bh=LsXaOljCeEErTM259LMjfKeSQkzg3HSZwuOAzuYzJvA=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=bw4Woh86XGFEmqYWTHDlxwrB/9dPZ5L923zsg+Yqw1DfMxhxSxiNFYzXoJKL9Boru
         KBnxq9TG0yDDI31HjKBDYNt8DM1nwybGq6wst08REvdPtbqVwGh1cGHUnhGTzQJOXm
         skDad47XGwXdu5ZuC9xOUYqIq2BfkMyxpaQ6i/6M=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA5A7Vq1087250
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 04:07:31 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 5 Nov
 2019 04:07:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 5 Nov 2019 04:07:13 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5A7PNI113538;
        Tue, 5 Nov 2019 04:07:25 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 08/15] dt-bindings: dma: ti: Add document for K3 UDMA
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-9-peter.ujfalusi@ti.com> <20191105021900.GA17829@bogus>
Message-ID: <fc1ea525-54f1-ff1a-7e1c-61b54f5be862@ti.com>
Date:   Tue, 5 Nov 2019 12:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105021900.GA17829@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 05/11/2019 4.19, Rob Herring wrote:
> On Fri, Nov 01, 2019 at 10:41:28AM +0200, Peter Ujfalusi wrote:
>> New binding document for
>> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
>>
>> UDMA-P is introduced as part of the K3 architecture and can be found in
>> AM654 and j721e.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Rob,
>>
>> can you give me some hint on how to fix these two warnings from dt_binding_check:
>>
>>   DTC     Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
>> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dts:23.13-72: Warning (ranges_format): /example-0/interconnect@30800000:ranges: "ranges" property has invalid length (24 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 2)
>>   CHECK   Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
> 
> The default #address-cells is 1 for examples. So you need to 
> either override it or change ranges parent address size.

wrapping the cbass_main_navss inside:
cbass_main {
    #address-cells = <2>;
    #size-cells = <2>;
    ...
};

fixes it.

>>
>> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml: interconnect@30800000: $nodename:0: 'interconnect@30800000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 
> Use 'bus' for the node name of 'simple-bus'.

I took the navss node from the upstream dts (I'm going to fix it there
as well).
It has simple-bus for the navss, which is not quite right as NAVSS is
not a bus, but a big subsystem with multiple components (UDMAP, ringacc,
INTA, INTR, timers, etc).

What about to change the binding doc to simple-mfd like this

cbass_main_navss: navss@30800000 {
    compatible = "simple-mfd";
    #address-cells = <2>;
    #size-cells = <2>;
    ...
};

and fix up the DT when I got to the point when I can send the patches to
enable DMA for am654 and j721e?
>>
>>  .../devicetree/bindings/dma/ti/k3-udma.yaml   | 190 ++++++++++++++++++
>>  1 file changed, 190 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
>> new file mode 100644
>> index 000000000000..e00fe3b2364e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
>> @@ -0,0 +1,190 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license new bindings:
> 
> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

OK.

>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/ti/k3-udma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments K3 NAVSS Unified DMA Device Tree Bindings
>> +
>> +maintainers:
>> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
>> +
>> +description: |
>> +  The UDMA-P is intended to perform similar (but significantly upgraded)
>> +  functions as the packet-oriented DMA used on previous SoC devices. The UDMA-P
>> +  module supports the transmission and reception of various packet types.
>> +  The UDMA-P is architected to facilitate the segmentation and reassembly of
>> +  SoC DMA data structure compliant packets to/from smaller data blocks that are
>> +  natively compatible with the specific requirements of each connected
>> +  peripheral.
>> +  Multiple Tx and Rx channels are provided within the DMA which allow multiple
>> +  segmentation or reassembly operations to be ongoing. The DMA controller
>> +  maintains state information for each of the channels which allows packet
>> +  segmentation and reassembly operations to be time division multiplexed between
>> +  channels in order to share the underlying DMA hardware. An external DMA
>> +  scheduler is used to control the ordering and rate at which this multiplexing
>> +  occurs for Transmit operations. The ordering and rate of Receive operations
>> +  is indirectly controlled by the order in which blocks are pushed into the DMA
>> +  on the Rx PSI-L interface.
>> +
>> +  The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
>> +  channels. Channels in the UDMA-P can be configured to be either Packet-Based
>> +  or Third-Party channels on a channel by channel basis.
>> +
>> +  All transfers within NAVSS is done between PSI-L source and destination
>> +  threads.
>> +  The peripherals serviced by UDMA can be PSI-L native (sa2ul, cpsw, etc) or
>> +  legacy, non PSI-L native peripherals. In the later case a special, small PDMA
>> +  is tasked to act as a bridge between the PSI-L fabric and the legacy
>> +  peripheral.
>> +
>> +  PDMAs can be configured via UDMAP peer registers to match with the
>> +  configuration of the legacy peripheral.
>> +
>> +allOf:
>> +  - $ref: "../dma-controller.yaml#"
>> +
>> +properties:
>> +  "#dma-cells":
>> +    const: 1
>> +    description: |
>> +      The cell is the PSI-L  thread ID of the remote (to UDMAP) end.
>> +      Valid ranges for thread ID depends on the data movement direction:
>> +      for source thread IDs (rx): 0 - 0x7fff
>> +      for destination thread IDs (tx): 0x8000 - 0xffff
>> +
>> +      PLease refer to the device documentation for the PSI-L thread map and also
>> +      the PSI-L peripheral chapter for the correct thread ID.
>> +
>> +  compatible:
>> +    oneOf:
>> +      - const: ti,am654-navss-main-udmap
>> +      - const: ti,am654-navss-mcu-udmap
>> +      - const: ti,j721e-navss-main-udmap
>> +      - const: ti,j721e-navss-mcu-udmap
> 
> enum works better than oneOf+const. Better error messages.

Like this:
  compatible:
    oneOf:
      - description: for AM654
        items:
          - enum:
              - ti,am654-navss-main-udmap
              - ti,am654-navss-mcu-udmap

      - description: for J721E
        items:
          - enum:
              - ti,j721e-navss-main-udmap
              - ti,j721e-navss-mcu-udmap


> 
>> +
>> +  reg:
>> +    maxItems: 3
>> +
>> +  reg-names:
>> +   items:
>> +     - const: gcfg
>> +     - const: rchanrt
>> +     - const: tchanrt
>> +
>> +  msi-parent: true
>> +
>> +  ti,sci:
>> +    description: |
> 
> Doesn't need to be a literal block (can drop the '|').

OK

> 
>> +      phandle to TI-SCI compatible System controller node
>> +    maxItems: 1
> 
> Drop this, not an array.
> 
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  ti,sci-dev-id:
>> +    description: |
>> +      TI-SCI device id of UDMAP
>> +    maxItems: 1
> 
> Drop this.
> 
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  ti,ringacc:
>> +    description: |
>> +      phandle to the ring accelerator node
>> +    maxItems: 1
> 
> Drop this.
> 
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  ti,sci-rm-range-tchan:
>> +    description: |
>> +      Array of UDMA tchan resource subtypes for resource allocation for this
>> +      host
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    items:
>> +      minItems: 1
>> +      # Should be enough
>> +      maxItems: 255
> 
> These should not be under 'items'. Drop 'items'.
> 
> Any constraints on the values of the array elements? 

The subtype is usually smaller than 30 for the current K3 device
line-up, but I would not set an upper limit, it all depends on system
firmware for the given family member.

I'll drop the items for the rm-ranges

> 
>> +
>> +  ti,sci-rm-range-rchan:
>> +    description: |
>> +      Array of UDMA rchan resource subtypes for resource allocation for this
>> +      host
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    items:
>> +      minItems: 1
>> +      # Should be enough
>> +      maxItems: 255
> 
> Same here.
> 
>> +
>> +  ti,sci-rm-range-rflow:
>> +    description: |
>> +      Array of UDMA rflow resource subtypes for resource allocation for this
>> +      host
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    items:
>> +      minItems: 1
>> +      # Should be enough
>> +      maxItems: 255
> 
> And here.
> 
>> +
>> +required:
>> +  - compatible
>> +  - "#dma-cells"
>> +  - reg
>> +  - reg-names
>> +  - msi-parent
>> +  - ti,sci
>> +  - ti,sci-dev-id
>> +  - ti,ringacc
>> +  - ti,sci-rm-range-tchan
>> +  - ti,sci-rm-range-rchan
>> +  - ti,sci-rm-range-rflow

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
