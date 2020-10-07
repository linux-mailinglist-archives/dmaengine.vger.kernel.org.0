Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA8285B93
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgJGJI4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 05:08:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56168 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJGJI4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Oct 2020 05:08:56 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09798meo128250;
        Wed, 7 Oct 2020 04:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602061728;
        bh=Yq8eK6r2Xypqm1GMf8LGZkAc+AgJ4YBZZ9RXWFTos5c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w3Af0OQx/1B34zi13Ytd+YW+fZ4X0hPvQIrfeRRHt+tT5Ia6eCgYzalIh+wXXHmLs
         dzhaq8edZAJXREPITlSHmEEqTyxaHZGW0KyMt7zxdlIvcbmvgfhVhp8Ns5qbnDfCJi
         U3FV5Ud5eqdile2h33VRsJfd24c25Ubo6VDJGfEE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09798mlj087707
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Oct 2020 04:08:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 7 Oct
 2020 04:08:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 7 Oct 2020 04:08:48 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09798jMh049524;
        Wed, 7 Oct 2020 04:08:45 -0500
Subject: Re: [PATCH 09/18] dt-bindings: dma: ti: Add document for K3 BCDMA
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <vigneshr@ti.com>, <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-10-peter.ujfalusi@ti.com>
 <20201006192909.GA2679155@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <bc054ef7-dcd7-dde2-13f8-4900a33b1377@ti.com>
Date:   Wed, 7 Oct 2020 12:09:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201006192909.GA2679155@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 06/10/2020 22.29, Rob Herring wrote:
> On Wed, Sep 30, 2020 at 12:14:03PM +0300, Peter Ujfalusi wrote:
>> New binding document for
>> Texas Instruments K3 Block Copy DMA (BCDMA).
>>
>> BCDMA is introduced as part of AM64.
>>

...

> 
>> +  ti,sci:
>> +    description: phandle to TI-SCI compatible System controller node
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  ti,sci-dev-id:
>> +    description: TI-SCI device id of BCDMA
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> 
> We have a common definition for these.

Yes, in arm/keystone/ti,k3-sci-common.yaml, but I could not get to use
that as reference.

I can not list it under the topmost allOf and drop the ti,sci and
ti,sci-dev-id like this:

allOf:
  - $ref: /schemas/dma/dma-controller.yaml#
  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#

It results:
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
  DTEX    Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dts
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
  DTC     Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml
Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml:
dma-controller@485c0100: 'ti,sci', 'ti,sci-dev-id' do not match any of
the regexes: 'pinctrl-[0-9]+'
        From schema: Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml

If I remove the "additionalProperties: false" from the schema file, then
it compiles fine.

> 
>> +
>> +  ti,asel:
>> +    description: ASEL value for non slave channels
>> +    allOf:
> 
> You no longer need 'allOf' here.

OK, I changed it in all instances.

> 
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  ti,sci-rm-range-bchan:
>> +    description: |
>> +      Array of BCDMA block-copy channel resource subtypes for resource
>> +      allocation for this host
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    # Should be enough
>> +    maxItems: 255
> 
> Are there constraints for the individual elements?

In practice the subtype ID is 6bits number.
Should I add limits to individual elements?

>> +
>> +  ti,sci-rm-range-tchan:
>> +    description: |
>> +      Array of BCDMA split tx channel resource subtypes for resource allocation
>> +      for this host
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    # Should be enough
>> +    maxItems: 255
>> +
>> +  ti,sci-rm-range-rchan:
>> +    description: |
>> +      Array of BCDMA split rx channel resource subtypes for resource allocation
>> +      for this host
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    # Should be enough
>> +    maxItems: 255
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
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |+
>> +    cbass_main {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        main_dmss {
>> +            compatible = "simple-mfd";
> 
> IMO, if it is memory-mapped, then you should be using 'simple-bus'.

We had the same discussion when I introduced the k3-udma binding and we
have concluded on the simple-mfd as DMSS is not a bus, but contains
different peripherals.

> 
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
