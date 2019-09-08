Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD06ACC89
	for <lists+dmaengine@lfdr.de>; Sun,  8 Sep 2019 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfIHMHw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Sep 2019 08:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbfIHMHv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 8 Sep 2019 08:07:51 -0400
Received: from localhost (unknown [122.182.221.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E13218AC;
        Sun,  8 Sep 2019 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567944470;
        bh=FQIOzMKN32+D7EXQBVmHC45HY6/y00at8hGjE4IjboU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hj/S8W0Iw2hthBawZ0Uqi9DFTpTMB0Do4oHMemh6k/LXiFOcQ9x5LM3RWgJD4OU94
         kf0+kE+gyDCgsb9mbppiRJUabFKuyu95v1ag1Ik+2cdyrdeT+gUxYgLrwa1sWoYTxK
         ZWaShKc+sdLCZuZXVa6oBWesMWrw6X7e5elNOg6E=
Date:   Sun, 8 Sep 2019 17:36:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
Message-ID: <20190908120642.GK2672@vkoul-mobl>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906141816.24095-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-09-19, 17:18, Peter Ujfalusi wrote:
> On systems where multiple DMA controllers available, none Slave (for example

On systems with multiple DMA controllers, non Slave...

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

perhaps add the example of main_udmap and mcu_udmap as well

> +    };
> +...
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
