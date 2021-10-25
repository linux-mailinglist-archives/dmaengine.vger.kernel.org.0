Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0C438F02
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 07:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhJYFxF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 01:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhJYFxE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 01:53:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4783560F9C;
        Mon, 25 Oct 2021 05:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635141043;
        bh=xNn1kVTPHVB8Gp1EuJzknYKzUz8pI6VLiRtbOnNlKRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mruM/QhZqVejOn66oIyjI7eAc6bUF6SJUjxPLWr+k3SUTTZllgEh+vEJNt/xfGKv3
         GeWcGq564hKdr0j6YOtvsilyARTNEhvuDP3oimtjRY2PlxuAD0N7VaYUqbXuKDi/au
         27hGSF/guDASDrK0b0P/BAVKfKykfdQu1cRlUjgJfo+AtWrmQ7aEkyane2e+aFMgHh
         BIrHaTRLuawYdfPyJguKebi5gVfXMAtxx7t8wscs1F5OWfCf8EqPA2W95Qjz8IJ2ax
         iPwbtm3fvWan5SnPwJko14gViGrwF12TPexUl7auXeOgK4MJH4K+sQDtQJu0DUvIlE
         ZYXGIs9AwjzhQ==
Date:   Mon, 25 Oct 2021 11:20:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     jonathanh@nvidia.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        rgumasta@nvidia.com, thierry.reding@gmail.com
Subject: Re: [PATCH v9 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Message-ID: <YXZFrqzuVS2TM12g@matsya>
References: <1633438536-11399-1-git-send-email-akhilrajeev@nvidia.com>
 <1633438536-11399-2-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633438536-11399-2-git-send-email-akhilrajeev@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-10-21, 18:25, Akhil R wrote:
> Add DT binding document for NVIDIA Tegra GPCDMA controller.

why is Rob and DT list not cced here?

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

-- 
~Vinod
