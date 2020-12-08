Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4952D23B6
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 07:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgLHGkW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 01:40:22 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44392 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLHGkV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 01:40:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B86dNWS078398;
        Tue, 8 Dec 2020 00:39:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607409563;
        bh=fMmCqJRwhs4bIWwJI7KnWGQ9VZ3xD70RmS1sgZEkN7Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dsS4aHRIVqg3eA4qAK//vYdKYC999s1H+OwueCOFyWj4frKQsq+AhLExXLTtKSgGi
         mUpNuTbFLtow58OF6r08UY5ZAx4ye72WbBD7Bi/cn92a/ToXYG7AB72C8nxlWM8p0x
         ZlWGHF3mLj1xCWbE49/rFgsNx+SQvQseMdrn8p7Q=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B86dNad026563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 00:39:23 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 00:39:23 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 00:39:23 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B86dKVZ127732;
        Tue, 8 Dec 2020 00:39:20 -0600
Subject: Re: [PATCH v2 10/19] dt-bindings: dma: ti: Add document for K3 BCDMA
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
 <20201117105656.5236-11-peter.ujfalusi@ti.com>
 <20201207194201.GA680126@robh.at.kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <9681053b-c67b-be08-3fab-bc293ca5a21a@ti.com>
Date:   Tue, 8 Dec 2020 08:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207194201.GA680126@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

On 07/12/2020 21.42, Rob Herring wrote:
> On Tue, Nov 17, 2020 at 12:56:47PM +0200, Peter Ujfalusi wrote:
>> New binding document for
>> Texas Instruments K3 Block Copy DMA (BCDMA).
>>
>> BCDMA is introduced as part of AM64.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 175 ++++++++++++++++++
>>  1 file changed, 175 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> new file mode 100644
>> index 000000000000..c6d76641ebec
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> @@ -0,0 +1,175 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/ti/k3-bcdma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments K3 DMSS BCDMA Device Tree Bindings
>> +
>> +maintainers:
>> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
>> +
>> +description: |
>> +  The Block Copy DMA (BCDMA) is intended to perform similar functions as the TR
>> +  mode channels of K3 UDMA-P.
>> +  BCDMA includes block copy channels and Split channels.
>> +
>> +  Block copy channels mainly used for memory to memory transfers, but with
>> +  optional triggers a block copy channel can service peripherals by accessing
>> +  directly to memory mapped registers or area.
>> +
>> +  Split channels can be used to service PSI-L based peripherals.
>> +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
>> +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
>> +  legacy peripheral.
>> +
>> +  PDMAs can be configured via BCDMA split channel's peer registers to match with
>> +  the configuration of the legacy peripheral.
>> +
>> +allOf:
>> +  - $ref: /schemas/dma/dma-controller.yaml#
>> +
>> +properties:
>> +  "#dma-cells":
>> +    const: 3
>> +    description: |
>> +      cell 1: type of the BCDMA channel to be used to service the peripheral:
>> +        0 - split channel
>> +        1 - block copy channel using global trigger 1
>> +        2 - block copy channel using global trigger 2
>> +        3 - block copy channel using local trigger
>> +
>> +      cell 2: parameter for the channel:
>> +        if cell 1 is 0 (split channel):
>> +          PSI-L thread ID of the remote (to BCDMA) end.
>> +          Valid ranges for thread ID depends on the data movement direction:
>> +          for source thread IDs (rx): 0 - 0x7fff
>> +          for destination thread IDs (tx): 0x8000 - 0xffff
>> +
>> +          Please refer to the device documentation for the PSI-L thread map and
>> +          also the PSI-L peripheral chapter for the correct thread ID.
>> +        if cell 1 is 1 or 2 (block copy channel using global trigger):
>> +          Unused, ignored
>> +
>> +          The trigger must be configured for the channel externally to BCDMA,
>> +          channels using global triggers should not be requested directly, but
>> +          via DMA event router.
>> +        if cell 1 is 3 (block copy channel using local trigger):
>> +          bchan number of the locally triggered channel
>> +
>> +      cell 3: ASEL value for the channel
>> +
>> +  compatible:
>> +    enum:
>> +      - ti,am64-dmss-bcdma
> 
> Typically, we put 'compatible' first.

OK.

>> +  "#address-cells":
>> +    const: 2
>> +
>> +  "#size-cells":
>> +    const: 2
> 
> These apply to child nodes, but you don't have any.

True, I forgot to remove these.

>> +
>> +  reg:
>> +    maxItems: 5
>> +
>> +  reg-names:
>> +    items:
>> +      - const: gcfg
>> +      - const: bchanrt
>> +      - const: rchanrt
>> +      - const: tchanrt
>> +      - const: ringrt
>> +
>> +  msi-parent: true
>> +
>> +  ti,asel:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: ASEL value for non slave channels
>> +
>> +  ti,sci-rm-range-bchan:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: |
>> +      Array of BCDMA block-copy channel resource subtypes for resource
>> +      allocation for this host
>> +    minItems: 1
>> +    # Should be enough
>> +    maxItems: 255
>> +    items:
>> +      maximum: 0x3f
>> +
>> +  ti,sci-rm-range-tchan:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: |
>> +      Array of BCDMA split tx channel resource subtypes for resource allocation
>> +      for this host
>> +    minItems: 1
>> +    # Should be enough
>> +    maxItems: 255
>> +    items:
>> +      maximum: 0x3f
>> +
>> +  ti,sci-rm-range-rchan:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: |
>> +      Array of BCDMA split rx channel resource subtypes for resource allocation
>> +      for this host
>> +    minItems: 1
>> +    # Should be enough
>> +    maxItems: 255
>> +    items:
>> +      maximum: 0x3f
>> +
>> +required:
>> +  - compatible
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - "#dma-cells"
>> +  - reg
>> +  - reg-names
>> +  - msi-parent
>> +  - ti,sci
>> +  - ti,sci-dev-id
>> +  - ti,sci-rm-range-bchan
>> +  - ti,sci-rm-range-tchan
>> +  - ti,sci-rm-range-rchan
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |+
>> +    cbass_main {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        main_dmss {
>> +            compatible = "simple-mfd";
>> +            #address-cells = <2>;
>> +            #size-cells = <2>;
>> +            dma-ranges;
>> +            ranges;
>> +
>> +            ti,sci-dev-id = <25>;
>> +
>> +            main_bcdma: dma-controller@485c0100 {
>> +                compatible = "ti,am64-dmss-bcdma";
>> +                #address-cells = <2>;
>> +                #size-cells = <2>;
>> +
>> +                reg = <0x0 0x485c0100 0x0 0x100>,
>> +                      <0x0 0x4c000000 0x0 0x20000>,
>> +                      <0x0 0x4a820000 0x0 0x20000>,
>> +                      <0x0 0x4aa40000 0x0 0x20000>,
>> +                      <0x0 0x4bc00000 0x0 0x100000>;
>> +                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
>> +                msi-parent = <&inta_main_dmss>;
>> +                #dma-cells = <3>;
>> +
>> +                ti,sci = <&dmsc>;
>> +                ti,sci-dev-id = <26>;
>> +
>> +                ti,sci-rm-range-bchan = <0x20>; /* BLOCK_COPY_CHAN */
>> +                ti,sci-rm-range-rchan = <0x21>; /* SPLIT_TR_RX_CHAN */
>> +                ti,sci-rm-range-tchan = <0x22>; /* SPLIT_TR_TX_CHAN */
>> +            };
>> +        };
>> +    };
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
