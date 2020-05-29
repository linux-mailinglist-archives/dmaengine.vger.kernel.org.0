Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDC1E87AC
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgE2TYt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 15:24:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42083 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2TYs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 May 2020 15:24:48 -0400
Received: by mail-io1-f66.google.com with SMTP id d5so525166ios.9;
        Fri, 29 May 2020 12:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncA1UY1KFuVSo+dgrM2Ia9S54/5AbQa0Xrtk2pQ7Rpg=;
        b=DLT4H/LSWVg2mTX7Y+mE4Y/8D5y/55HG57jnAOsyG7x6noAZ12PuXyjn/S0fsrZTjc
         tW6KzfUuCxSfHcT24u7o5D55Ys+CV+0Gg6wtvPDVXMviESeyHCKChLxIeQnMWfGQ3+yn
         TW3AUYfxF+3mb5h2qhsvNjbsBOpnNXfMXQ83tAh3YIkVNIEg2zOBH1eKudLYEh81RZ8S
         J0fjO3xyGbKWjI+Q632KQiHUewke0SztrmCaH6VRLip5htsR+pMpe+A9b9Ts8xi0yL2F
         rdSKu8+rKeYCqrop5SlwfzMFQz8smko9AOml3x/noF0HETxtpJDkNU7azNhtPAf6GQQ3
         ZwFQ==
X-Gm-Message-State: AOAM533blsyuCW2O07s1eAqgYADCocUA7rFUelNaUBMg4avnfqo1yfU8
        4z8WjAarNbDQ1tOQXAXdWA==
X-Google-Smtp-Source: ABdhPJwqvXK5Nh8UeEPtncN2XbompTf/OSEA4G54suYQIG3STlJL/YnP452nV6nfPe4nUqyJuC6XDw==
X-Received: by 2002:a6b:e714:: with SMTP id b20mr8135145ioh.195.1590780287110;
        Fri, 29 May 2020 12:24:47 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p3sm4241556iog.31.2020.05.29.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:24:45 -0700 (PDT)
Received: (nullmailer pid 2795396 invoked by uid 1000);
        Fri, 29 May 2020 19:24:43 -0000
Date:   Fri, 29 May 2020 13:24:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     EastL <EastL.Lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, vkoul@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v4 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
Message-ID: <20200529192443.GA2785767@bogus>
References: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
 <1590659832-31476-2-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590659832-31476-2-git-send-email-EastL.Lee@mediatek.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 28, 2020 at 05:57:09PM +0800, EastL wrote:
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6779 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: EastL <EastL.Lee@mediatek.com>

Need a full name.

> ---
>  .../devicetree/bindings/dma/mtk-cqdma.yaml         | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> new file mode 100644
> index 0000000..045aa0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/mtk-cqdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Command-Queue DMA controller Device Tree Binding
> +
> +maintainers:
> +  - EastL <EastL.Lee@mediatek.com>
> +
> +description:
> +  MediaTek Command-Queue DMA controller (CQDMA) on Mediatek SoC
> +  is dedicated to memory-to-memory transfer through queue based
> +  descriptor management.
> +

Need a $ref to dma-controller.yaml

> +properties:
> +  "#dma-cells":
> +    minimum: 1
> +    # Should be enough
> +    maximum: 255
> +    description:
> +      Used to provide DMA controller specific information.
> +
> +  compatible:
> +    const: mediatek,cqdma

Needs SoC specific compatible string(s).

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 255

You can have 255 register regions?

You need to define what each region is if more than 1.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 255

255 interrupts?

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: cqdma
> +
> +  dma-channel-mask:
> +    description:
> +      Bitmask of available DMA channels in ascending order that are
> +      not reserved by firmware and are available to the
> +      kernel. i.e. first channel corresponds to LSB.
> +      The first item in the array is for channels 0-31, the second is for
> +      channels 32-63, etc.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      minItems: 1
> +      # Should be enough
> +      maxItems: 255

This already has a definition in dma-common.yaml. Don't copy-n-paste 
it. Just add any constraints you have. Like what is the max number of 
channels?

> +
> +  dma-channels:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Number of DMA channels supported by the controller.
> +
> +  dma-requests:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Number of DMA request signals supported by the controller.

Same comment on these 2.

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
> +        compatible = "mediatek,cqdma";
> +        reg = <0 0x10212000 0 0x80>,
> +            <0 0x10212080 0 0x80>,
> +            <0 0x10212100 0 0x80>;

Examples default to 1 cell each for address and size.

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
