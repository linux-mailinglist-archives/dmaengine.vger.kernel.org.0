Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF89442EFE
	for <lists+dmaengine@lfdr.de>; Tue,  2 Nov 2021 14:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKBNWw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Nov 2021 09:22:52 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:42514 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhKBNWw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Nov 2021 09:22:52 -0400
Received: by mail-ot1-f44.google.com with SMTP id v19-20020a9d69d3000000b00555a7318f31so17848440oto.9;
        Tue, 02 Nov 2021 06:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wzh03PSR5cG30V8z75lqhDgLPLd/dGpZFScd2ass+5k=;
        b=o1nExjEX/2rXNoqeDMPekc6/YrOE/nf5NzwvXK+S+Xf7I7kjn6pjdqgnpqcN4pQglp
         OAkI+t+Yw2DkpejTEwhBmZQPrqJxs5KdFnqFpppb973mwZLwmKZDPJTC5d3WG76nkfRv
         UTTA/7cA2on1FejSTeNwWcMJBgPcKMMqouWJk0IbtueKj8yvRuWXN8zWx9I/OXxxGsUh
         /T1R0v0CKr/w66SNPZYuBzfUJ6Yli9w8htGQ4EFTkcXwrYzRzkK1A17oTZxFJ2pi5FIN
         c/Fm4MvX17QelfvZr3fHXQnIQbS0L6xehdp8qrmbYiOuw3bcHSzRovUvdJ54gRYlXG+1
         TH4g==
X-Gm-Message-State: AOAM5336Fz/qY0J87rxMQmRhypORgMeqbZcoXndLriX17QcNIs6dk0dm
        14c1Zz21c5/vtMWvM/n64Q==
X-Google-Smtp-Source: ABdhPJylcpLZGGhjNZtShUe5v5UatdNYwEtQFFpIY7evw1cIgDGu/sW4FpuuHD6AA0I7V7iuV9K/eQ==
X-Received: by 2002:a9d:490e:: with SMTP id e14mr26734803otf.194.1635859217009;
        Tue, 02 Nov 2021 06:20:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p133sm4848317oia.11.2021.11.02.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:20:16 -0700 (PDT)
Received: (nullmailer pid 2712189 invoked by uid 1000);
        Tue, 02 Nov 2021 13:20:15 -0000
Date:   Tue, 2 Nov 2021 08:20:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     dan.j.williams@intel.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com,
        thierry.reding@gmail.com, vkoul@kernel.org
Subject: Re: [PATCH v11 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Message-ID: <YYE7D2W721a1L4Mb@robh.at.kernel.org>
References: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
 <1635427419-22478-2-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635427419-22478-2-git-send-email-akhilrajeev@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 28, 2021 at 06:53:36PM +0530, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 115 +++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> new file mode 100644
> index 0000000..bc97efc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra GPC DMA Controller Device Tree Bindings
> +
> +description: |
> +  The Tegra General Purpose Central (GPC) DMA controller is used for faster
> +  data transfers between memory to memory, memory to device and device to
> +  memory.
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Rajesh Gumasta <rgumasta@nvidia.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nvidia,tegra186-gpcdma
> +          - nvidia,tegra194-gpcdma
> +      - items:
> +          - const: nvidia,tegra186-gpcdma
> +          - const: nvidia,tegra194-gpcdma

One of these is wrong. Either 186 has a fallback to 194 or it doesn't.

> +
> +  "#dma-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |

Don't need '|' if there's no formatting.

> +      Should contain all of the per-channel DMA interrupts in
> +      ascending order with respect to the DMA channel index.
> +    minItems: 1
> +    maxItems: 32
> +
> +  resets:
> +    description: |
> +      Should contain the reset phandle for gpcdma.

Not really a useful description. Drop.

> +    maxItems: 1
> +
> +  reset-names:
> +    const: gpcdma
> +
> +  iommus:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - resets
> +  - reset-names
> +  - "#dma-cells"
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/tegra186-mc.h>
> +    #include <dt-bindings/reset/tegra186-reset.h>
> +
> +    dma-controller@2600000 {
> +        compatible = "nvidia,tegra186-gpcdma";
> +        reg = <0x2600000 0x0>;
> +        resets = <&bpmp TEGRA186_RESET_GPCDMA>;
> +        reset-names = "gpcdma";
> +        interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +        #dma-cells = <1>;
> +        iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
> +        dma-coherent;
> +    };
> +...
> -- 
> 2.7.4
> 
> 
