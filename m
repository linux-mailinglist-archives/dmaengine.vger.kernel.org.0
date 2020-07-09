Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2563021A970
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2020 22:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgGIU7T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jul 2020 16:59:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36025 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgGIU7S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jul 2020 16:59:18 -0400
Received: by mail-io1-f67.google.com with SMTP id y2so3825941ioy.3;
        Thu, 09 Jul 2020 13:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=59KG2c36B73L5TCxEaW5iyr7aT9GnhJz2toja/ityzo=;
        b=A1DDDAX8Of3VAYBaf5twc9L3XAzTOwb8mXv8uAzBCMGPIAuz7djXDfiiweblJOExEA
         kPUbdFROFs7zMbzXJQRskMPGTuo9r2RYTePoC938ZqEzIj9e2yPYJucnQKWtzOJ5Rs0e
         r14HuxWiZ/Kvg95r0FACgJQCkKCt03d/xUd/omx8m4k+pmMB17b4idrkVJzi+qHXvTji
         m3DX6qgsSBc5y2wqsxXLT7SP0EdbovAt9QfUZM9jYqMSd5Jfc4Bno6Ug+DKS9EDij/w2
         m7j81Q8Di84WXWOngb/VaQ5Gt4dx50TLwHrdMeUUCfod2M/5sO/zliVjNPU81l8iuxVi
         ScdA==
X-Gm-Message-State: AOAM5337FGLQV5VppFRuB+Qpjt6U9OCctpV1r4plx0bIYI1p6K69xziu
        +XjP7a/VfPcTszb9Go906g==
X-Google-Smtp-Source: ABdhPJz1XtipgZZTRvbo4upYYiZEu374WcNQ5YcX9yvzP6F343WQAYYz7MPsvmWiJt7sYOukO69ulw==
X-Received: by 2002:a05:6638:2591:: with SMTP id s17mr23248116jat.23.1594328357549;
        Thu, 09 Jul 2020 13:59:17 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id h11sm2372624ilh.69.2020.07.09.13.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:59:16 -0700 (PDT)
Received: (nullmailer pid 875925 invoked by uid 1000);
        Thu, 09 Jul 2020 20:59:15 -0000
Date:   Thu, 9 Jul 2020 14:59:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     EastL Lee <EastL.Lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, vkoul@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, cc.hwang@mediatek.com
Subject: Re: [PATCH v6 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
Message-ID: <20200709205915.GA865123@bogus>
References: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
 <1593673564-4425-2-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593673564-4425-2-git-send-email-EastL.Lee@mediatek.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 02, 2020 at 03:06:01PM +0800, EastL Lee wrote:
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6779 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-cqdma.yaml         | 113 +++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> new file mode 100644
> index 0000000..83ed742
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/mtk-cqdma.yaml#
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
> +  "#dma-cells":
> +    minimum: 1
> +    maximum: 255
> +    description:
> +      Used to provide DMA controller specific information.

No, for a specific binding like this, it should be 1 defined value.

> +
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt6765-cqdma
> +      - const: mediatek,mt6779-cqdma
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
> +    $ref: /schemas/types.yaml#definitions/uint32

Alreay has a type, don't redefine it here.

> +    description:
> +       For DMA capability, We will know the addressing capability of
> +       MediaTek Command-Queue DMA controller through dma-channel-mask.

This sounds like the kernel's DMA masks which is not what this property 
is.

> +    items:
> +      minItems: 1
> +      maxItems: 63

An array of 63 elements?

I think you want:

minimum: 1
maximum: 63

Or:

enum: [ 1, 3, 7, 0xf, 0x1f, 0x3f ]

(Though if this works, then just 'dma-channels' is enough.)

> +
> +  dma-channels:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Number of DMA channels supported by MediaTek Command-Queue DMA
> +      controller, support up to five.

Is it 5 or 6 channels? You're off by one somewhere.

> +    items:
> +      minItems: 1
> +      maxItems: 5
> +
> +  dma-requests:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Number of DMA request (virtual channel) supported by MediaTek
> +      Command-Queue DMA controller, support up to 32.
> +    items:
> +      minItems: 1
> +      maxItems: 32

You are describing how many elements in an array and this is a scalar.

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
> +        reg = <0x10212000 0x80>,
> +            <0x10212080 0x80>,
> +            <0x10212100 0x80>;
> +        interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>,
> +            <GIC_SPI 140 IRQ_TYPE_LEVEL_LOW>,
> +            <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&infracfg_ao CLK_INFRA_CQ_DMA>;
> +        clock-names = "cqdma";
> +        dma-channel-mask = <63>;
> +        dma-channels = <3>;
> +        dma-requests = <32>;
> +        #dma-cells = <1>;
> +    };
> +
> +...
> -- 
> 1.9.1
