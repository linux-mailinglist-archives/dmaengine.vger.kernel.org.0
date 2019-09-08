Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E323ACB5E
	for <lists+dmaengine@lfdr.de>; Sun,  8 Sep 2019 09:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfIHHrc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Sep 2019 03:47:32 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45764 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfIHHrb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 8 Sep 2019 03:47:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x887lKwH083411;
        Sun, 8 Sep 2019 02:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567928840;
        bh=gP3eQGqN9/b/uDO3D0RrZ66L4DLutSPefbQYEw6wx+8=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=aTRn/KHGLmrCFCANZmKVBihu6pYfsumq9Hh6wYivP+u4ChGdfHexIiEo5fa58TWVY
         yNCzxHha1h9NtC/nbxc3fDjdXmsu9i0HYXIGztZGt4teoyfMzY9gyvevw5FQricc84
         ADFbE+eE31UF8hXuRlBr8B2OmOnD8dM0mGVQ+1Zc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x887lK39107092;
        Sun, 8 Sep 2019 02:47:20 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 8 Sep
 2019 02:47:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sun, 8 Sep 2019 02:47:19 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x887lHgB119116;
        Sun, 8 Sep 2019 02:47:17 -0500
Subject: Re: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-2-peter.ujfalusi@ti.com>
Message-ID: <961d30ea-d707-1120-7ecf-f51c11c41891@ti.com>
Date:   Sun, 8 Sep 2019 10:47:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906141816.24095-2-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 06/09/2019 17.18, Peter Ujfalusi wrote:
> On systems where multiple DMA controllers available, none Slave (for example
> memcpy operation) users can not be described in DT as there is no device
> involved from the DMA controller's point of view, DMA binding is not usable.
> However in these systems still a peripheral might need to be serviced by or
> it is better to serviced by specific DMA controller.
> When a memcpy is used to/from a memory mapped region for example a DMA in the
> same domain can perform better.
> For generic software modules doing mem 2 mem operations it also matter that
> they will get a channel from a controller which is faster in DDR to DDR mode
> rather then from the first controller happen to be loaded.
> 
> This property is inherited, so it may be specified in a device node or in any
> of its parent nodes.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/dma-domain.yaml   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma-domain.yaml b/Documentation/devicetree/bindings/dma/dma-domain.yaml
> new file mode 100644
> index 000000000000..c2f182f30081
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/dma-domain.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/dma-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DMA Domain Controller Definition
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +description:
> +  On systems where multiple DMA controllers available, none Slave (for example
> +  memcpy operation) users can not be described in DT as there is no device
> +  involved from the DMA controller's point of view, DMA binding is not usable.
> +  However in these systems still a peripheral might need to be serviced by or
> +  it is better to serviced by specific DMA controller.
> +  When a memcpy is used to/from a memory mapped region for example a DMA in the
> +  same domain can perform better.
> +  For generic software modules doing mem 2 mem operations it also matter that
> +  they will get a channel from a controller which is faster in DDR to DDR mode
> +  rather then from the first controller happen to be loaded.
> +
> +  This property is inherited, so it may be specified in a device node or in any
> +  of its parent nodes.
> +
> +properties:
> +  $dma-domain-controller:

or domain-dma-controller?

> +    $ref: /schemas/types.yaml#definitions/phandle
> +    description:
> +      phande to the DMA controller node which should be used for the device or
> +      domain.
> +
> +examples:
> +  - |
> +    / {
> +        model = "Texas Instruments K3 AM654 SoC";
> +        compatible = "ti,am654";
> +        interrupt-parent = <&gic500>;
> +        /* For modules without device, DDR to DDR is faster on main UDMAP */
> +        dma-domain-controller = <&main_udmap>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ...
> +    };
> +
> +    &cbass_main {
> +        /* For modules within MAIN domain, use main UDMAP */
> +        dma-domain-controller = <&main_udmap>;
> +    };
> +
> +    &cbass_mcu {
> +        /* For modules within MCU domain, use mcu UDMAP */
> +        dma-domain-controller = <&mcu_udmap>;
> +    };
> +...
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
