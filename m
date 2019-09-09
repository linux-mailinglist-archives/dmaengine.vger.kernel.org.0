Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74790AD2EC
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2019 08:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfIIGAM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 02:00:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40686 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfIIGAL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 02:00:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x896037P018182;
        Mon, 9 Sep 2019 01:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568008803;
        bh=pnXFM66Qh5N+U8iCAu7F+S6mhz0Xw9FlLW/1OOH/KqA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T4LyxrSNjZr1Ub1b8n0itm1xg7t6MGXisYTFMXwfdt6RGEddUfQvsGqHbFT1vZbdD
         zlan87HDVIrS9oWl0PInuP7bs9VL1x7q85siOIaaUOrexYW33nf8xZjZ+K+22TNJ9G
         16mR1jNIcV60O4BC3q68VR/DNtdaBrR2youe0mrc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x89602fj074302
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Sep 2019 01:00:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 9 Sep
 2019 01:00:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 9 Sep 2019 01:00:00 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x895xwnh059683;
        Mon, 9 Sep 2019 00:59:58 -0500
Subject: Re: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-2-peter.ujfalusi@ti.com>
 <20190908120642.GK2672@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <26072f6f-e099-9cd6-6cca-0175870c0c30@ti.com>
Date:   Mon, 9 Sep 2019 09:00:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190908120642.GK2672@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/09/2019 15.06, Vinod Koul wrote:
> On 06-09-19, 17:18, Peter Ujfalusi wrote:
>> On systems where multiple DMA controllers available, none Slave (for example
> 
> On systems with multiple DMA controllers, non Slave...

Sure.

>> memcpy operation) users can not be described in DT as there is no device
>> involved from the DMA controller's point of view, DMA binding is not usable.
>> However in these systems still a peripheral might need to be serviced by or
>> it is better to serviced by specific DMA controller.
>> When a memcpy is used to/from a memory mapped region for example a DMA in the
>> same domain can perform better.
>> For generic software modules doing mem 2 mem operations it also matter that
>> they will get a channel from a controller which is faster in DDR to DDR mode
>> rather then from the first controller happen to be loaded.
>>
>> This property is inherited, so it may be specified in a device node or in any
>> of its parent nodes.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../devicetree/bindings/dma/dma-domain.yaml   | 59 +++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/dma-domain.yaml b/Documentation/devicetree/bindings/dma/dma-domain.yaml
>> new file mode 100644
>> index 000000000000..c2f182f30081
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/dma-domain.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/dma-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: DMA Domain Controller Definition
>> +
>> +maintainers:
>> +  - Vinod Koul <vkoul@kernel.org>
>> +
>> +allOf:
>> +  - $ref: "dma-controller.yaml#"
>> +
>> +description:
>> +  On systems where multiple DMA controllers available, none Slave (for example
>> +  memcpy operation) users can not be described in DT as there is no device
>> +  involved from the DMA controller's point of view, DMA binding is not usable.
>> +  However in these systems still a peripheral might need to be serviced by or
>> +  it is better to serviced by specific DMA controller.
>> +  When a memcpy is used to/from a memory mapped region for example a DMA in the
>> +  same domain can perform better.
>> +  For generic software modules doing mem 2 mem operations it also matter that
>> +  they will get a channel from a controller which is faster in DDR to DDR mode
>> +  rather then from the first controller happen to be loaded.
>> +
>> +  This property is inherited, so it may be specified in a device node or in any
>> +  of its parent nodes.
>> +
>> +properties:
>> +  $dma-domain-controller:
>> +    $ref: /schemas/types.yaml#definitions/phandle
>> +    description:
>> +      phande to the DMA controller node which should be used for the device or
>> +      domain.
>> +
>> +examples:
>> +  - |
>> +    / {
>> +        model = "Texas Instruments K3 AM654 SoC";
>> +        compatible = "ti,am654";
>> +        interrupt-parent = <&gic500>;
>> +        /* For modules without device, DDR to DDR is faster on main UDMAP */
>> +        dma-domain-controller = <&main_udmap>;
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ...
>> +    };
>> +
>> +    &cbass_main {
>> +        /* For modules within MAIN domain, use main UDMAP */
>> +        dma-domain-controller = <&main_udmap>;
>> +    };
>> +
>> +    &cbass_mcu {
>> +        /* For modules within MCU domain, use mcu UDMAP */
>> +        dma-domain-controller = <&mcu_udmap>;
> 
> perhaps add the example of main_udmap and mcu_udmap as well

I can populate the tree with the main/mcu_udmap and on MCU I can also
add the OSPI node.
The idea is to specify the dma controller to be used for non slave
channels on every device on MAIN/MCU domain.
UDMAPs do not need this property specified, it is needed for clients.

> 
>> +    };
>> +...
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
