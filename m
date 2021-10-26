Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E2043B9A3
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 20:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhJZSeG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 14:34:06 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44805 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhJZSd5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Oct 2021 14:33:57 -0400
Received: by mail-ot1-f42.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so21044372otl.11;
        Tue, 26 Oct 2021 11:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+egWkbJH2Flqgjgy++dVLhNbQ1CPC0WUG5ECT1T2aw=;
        b=b8vGjrav+cIulND4TaqtPu+5SBpvcFDxiljkgUSpNy3W1g1aGwshRkYvtXEHK2mKwH
         uXFwTFKVIyIzNXQHzfjf8gu4xx+/Pp5zWaLNHgNCIZDRvcEPFDau7/GOMuoJ5qdrSaVT
         bLwSrR3uOGypvQn5XDxlVbogQ/P37K0kwoTFQMoRKKM4+pMxOqrDuhE9Cmh8kR6okuCo
         pica3QHrvSOgkd7PgBtbh4oaHj/rBs3JBJMdovcfUIECxPju3s3lHcKvRwiFtxamaq2/
         t+b3lsrh4BSgYFdtLSYdfAP8cCJs3jCAUGdLOy8IfY0NIjpBkEp1g59coTsd0mPoLpfM
         MRgg==
X-Gm-Message-State: AOAM532LUeXqyEAHI1pzYuLtwrOv1wsYsaQokm/QT9pqceMm7cSOa7Jj
        S3minHSv14z6NMHmQs1XuQ==
X-Google-Smtp-Source: ABdhPJxdwZpTZdiE+CGPhdxC5lfxtTSzLOIl1+kyzNOpz/zl6w87999JYr7IBJwuZvHScSrjTMfgEQ==
X-Received: by 2002:a05:6830:4428:: with SMTP id q40mr21080094otv.184.1635273092635;
        Tue, 26 Oct 2021 11:31:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k4sm4849827oic.48.2021.10.26.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:31:31 -0700 (PDT)
Received: (nullmailer pid 2986051 invoked by uid 1000);
        Tue, 26 Oct 2021 18:31:30 -0000
Date:   Tue, 26 Oct 2021 13:31:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com,
        thierry.reding@gmail.com, vkoul@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v10 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Message-ID: <YXhJgsmUiE69z5n3@robh.at.kernel.org>
References: <1635180046-15276-1-git-send-email-akhilrajeev@nvidia.com>
 <1635180046-15276-2-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635180046-15276-2-git-send-email-akhilrajeev@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 25, 2021 at 10:10:43PM +0530, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 108 +++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> new file mode 100644
> index 0000000..d3f58d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -0,0 +1,108 @@
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
> +        - nvidia,tegra186-gpcdma
> +        - nvidia,tegra194-gpcdma
> +      - items:
> +        - const: nvidia,tegra186-gpcdma
> +        - const: nvidia,tegra194-gpcdma
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 32

One per channel or what? You must define what each one is.

> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: gpcdma
> +
> +  iommus:
> +    maxItems: 1
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
> +    gpcdma:dma-controller@2600000 {

Drop unused labels.

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
