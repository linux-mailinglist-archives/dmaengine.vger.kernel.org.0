Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460F42E8D55
	for <lists+dmaengine@lfdr.de>; Sun,  3 Jan 2021 17:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbhACQ71 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 3 Jan 2021 11:59:27 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:37311 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbhACQ71 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 3 Jan 2021 11:59:27 -0500
Received: by mail-il1-f178.google.com with SMTP id k8so23191896ilr.4;
        Sun, 03 Jan 2021 08:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J8WEkyhenkl8kYp/bvB9MXeFoGWEOBF4fz0r9rccQxI=;
        b=f5repF/1nXZGKbStW/jGAwzO7vMRRUvE6mLLFtstbKchd3cQvP9L+8J3ciAgDCfxcU
         V54gpe07RWvsjm8fJDWFwdvxnCl+NBTuTCBZq54sKXG9lyepKzF3Z2Qx/wQVb04WmzAs
         0cYQSz3k+pJZ+uIrtWhU2B6vsVXoUAo1LsjVjNtA7QAdz+oE9Es/HurDh5iT0zdo3jDK
         SvwA2nPQ8WNsrx48x25LWkRbky4uNfa9n85qSXYxZF9tSqhV2QrOWvxNg8EW3zsgka4h
         zRC/0ED0SiD+PYvALVj3Yh+liJphBwDW4zYsN93L9UhXbuwSO6yV/rXvNkEhR6RkQe9q
         o6TQ==
X-Gm-Message-State: AOAM533GuClUYA+8+gGBWqSEu13pL/yc0j7gPLnaAtCfw1nJ+EF1Zw1U
        edKM/obPAPss4fTCprbEYg==
X-Google-Smtp-Source: ABdhPJyS+VI5YSOn0FBVtRBwA0IsJCJFN4Xr13kqCrchuR9n5xvQZZih3qMOLRBS/P13N6oiBbZtLg==
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id h10mr68652565ili.141.1609693125817;
        Sun, 03 Jan 2021 08:58:45 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r10sm39086113ilo.34.2021.01.03.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:58:44 -0800 (PST)
Received: (nullmailer pid 4046180 invoked by uid 1000);
        Sun, 03 Jan 2021 16:58:42 -0000
Date:   Sun, 3 Jan 2021 09:58:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     EastL Lee <EastL.Lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, vkoul@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, cc.hwang@mediatek.com
Subject: Re: [PATCH v8 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
Message-ID: <20210103165842.GA4024251@robh.at.kernel.org>
References: <1608715847-28956-1-git-send-email-EastL.Lee@mediatek.com>
 <1608715847-28956-2-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608715847-28956-2-git-send-email-EastL.Lee@mediatek.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Dec 23, 2020 at 05:30:44PM +0800, EastL Lee wrote:
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6779 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-cqdma.yaml         | 104 +++++++++++++++++++++

Use compatible string for filename:

mediatek,cqdma.yaml

>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> new file mode 100644
> index 0000000..a76a263
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/mtk-cqdma.yaml#

Don't forget to update this.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Command-Queue DMA controller Device Tree Binding
> +
> +maintainers:
> +  - EastL Lee <EastL.Lee@mediatek.com>
> +
> +description:
> +  MediaTek Command-Queue DMA controller (CQDMA) on Mediatek SoC
> +  is dedicated to memory-to-memory transfer through queue based
> +  descriptor management.
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt6765-cqdma
> +          - mediatek,mt6779-cqdma
> +      - const: mediatek,cqdma
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 5
> +    description:
> +        A base address of MediaTek Command-Queue DMA controller,
> +        a channel will have a set of base address.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 5
> +    description:
> +        A interrupt number of MediaTek Command-Queue DMA controller,
> +        one interrupt number per dma-channels.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: cqdma
> +
> +  dma-channel-mask:
> +    description:
> +       For DMA capability, We will know the addressing capability of
> +       MediaTek Command-Queue DMA controller through dma-channel-mask.
> +      minimum: 1
> +      maximum: 63

Indentation is wrong here so this has no effect.

A mask of 63 is 6 channels...

> +
> +  dma-channels:
> +    description:
> +      Number of DMA channels supported by MediaTek Command-Queue DMA
> +      controller, support up to five.
> +      minimum: 1
> +      maximum: 5

Same here.

Do you really need both dma-channels and dma-channel-mask? You should be 
able to get one from the other.

> +
> +  dma-requests:
> +    description:
> +      Number of DMA request (virtual channel) supported by MediaTek
> +      Command-Queue DMA controller, support up to 32.
> +      minimum: 1
> +      maximum: 32

And here.

You are missing '#dma-cells' also.

> +
> +required:
> +  - "#dma-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dma-channel-mask
> +  - dma-channels
> +  - dma-requests
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt6779-clk.h>
> +    cqdma: dma-controller@10212000 {
> +        compatible = "mediatek,mt6779-cqdma";

This should fail validation because it doesn't match the schema. You ran 
'make dt_binding_check', right?

> +        reg = <0x10212000 0x80>,
> +            <0x10212080 0x80>,
> +            <0x10212100 0x80>;
> +        interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>,
> +            <GIC_SPI 140 IRQ_TYPE_LEVEL_LOW>,
> +            <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&infracfg_ao CLK_INFRA_CQ_DMA>;
> +        clock-names = "cqdma";
> +        dma-channel-mask = <63>;

6 channels or...

> +        dma-channels = <3>;

3?

> +        dma-requests = <32>;
> +        #dma-cells = <1>;
> +    };
> +
> +...
> -- 
> 1.9.1
> 
