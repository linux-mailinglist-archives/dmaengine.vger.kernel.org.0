Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FB72A8686
	for <lists+dmaengine@lfdr.de>; Thu,  5 Nov 2020 19:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbgKES44 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Nov 2020 13:56:56 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:33142 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgKES44 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Nov 2020 13:56:56 -0500
Received: by mail-oo1-f65.google.com with SMTP id u5so691925oot.0;
        Thu, 05 Nov 2020 10:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=15Y1K9usUkG9wBYnByVHYm2MLoK4h6XMHFtLXY+mdjs=;
        b=rURCeC+sWDtHrJnFmLVi0Y7ku+A8UYeNto8FZ1PgI33VwjXCnvGIDFiRR1YGKCjMvw
         w5I+r0+EQmJrKadO2Eeue+qfhzOGPHavX5ITo9PTLNHSDdNUWICXVt0cxNx6dTeweYqn
         AOxVFHAfD00sX1wUnY6MLoxKvddIV3z+C2b7CWGMw/Xqz5vvnIB3Y1rTYKPg9DazFU9q
         nsHlzUwbjVnEZMWw9dUONprgTuv6woxwVnIqFldf+eO9K3bKMdvbIdXTrHFhonnUgxEI
         YlnlL1/wTrkmwXEr5a+Dn9ngozZe1nK7GmvBvwd1H7zPm2FEOE80QExFKnyT3EKKXcqG
         vTSw==
X-Gm-Message-State: AOAM533B4hK+X6a3xezWyz8q80WG6/mvFIKlWAOVXkJs47rt/ekV9sgb
        zfOcNvZ82S16mcCWw9PgBg==
X-Google-Smtp-Source: ABdhPJyoNx34h4/j3YzRqbVXxQbGXFshAsrXGC4xBgpM5T7zjUT14r8TQBLtnmtsKzVZ70fe1xmcEw==
X-Received: by 2002:a4a:6251:: with SMTP id y17mr2455201oog.17.1604602614670;
        Thu, 05 Nov 2020 10:56:54 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i12sm537841oon.26.2020.11.05.10.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:56:53 -0800 (PST)
Received: (nullmailer pid 1631441 invoked by uid 1000);
        Thu, 05 Nov 2020 18:56:52 -0000
Date:   Thu, 5 Nov 2020 12:56:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     devicetree@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, vkoul@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: dma: Convert ADMA doc to json-schema
Message-ID: <20201105185652.GB1622537@bogus>
References: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
 <1604571846-14037-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604571846-14037-3-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Nov 05, 2020 at 03:54:04PM +0530, Sameer Pujar wrote:
> Move ADMA documentation to YAML format.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra210-adma.txt          | 56 -------------
>  .../bindings/dma/nvidia,tegra210-adma.yaml         | 95 ++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
> deleted file mode 100644
> index 245d306..0000000
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -* NVIDIA Tegra Audio DMA (ADMA) controller
> -
> -The Tegra Audio DMA controller that is used for transferring data
> -between system memory and the Audio Processing Engine (APE).
> -
> -Required properties:
> -- compatible: Should contain one of the following:
> -  - "nvidia,tegra210-adma": for Tegra210
> -  - "nvidia,tegra186-adma": for Tegra186 and Tegra194
> -- reg: Should contain DMA registers location and length. This should be
> -  a single entry that includes all of the per-channel registers in one
> -  contiguous bank.
> -- interrupts: Should contain all of the per-channel DMA interrupts in
> -  ascending order with respect to the DMA channel index.
> -- clocks: Must contain one entry for the ADMA module clock
> -  (TEGRA210_CLK_D_AUDIO).
> -- clock-names: Must contain the name "d_audio" for the corresponding
> -  'clocks' entry.
> -- #dma-cells : Must be 1. The first cell denotes the receive/transmit
> -  request number and should be between 1 and the maximum number of
> -  requests supported. This value corresponds to the RX/TX_REQUEST_SELECT
> -  fields in the ADMA_CHn_CTRL register.
> -
> -
> -Example:
> -
> -adma: dma@702e2000 {
> -	compatible = "nvidia,tegra210-adma";
> -	reg = <0x0 0x702e2000 0x0 0x2000>;
> -	interrupt-parent = <&tegra_agic>;
> -	interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -	clocks = <&tegra_car TEGRA210_CLK_D_AUDIO>;
> -	clock-names = "d_audio";
> -	#dma-cells = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> new file mode 100644
> index 0000000..b4e657d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nvidia,tegra210-adma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra Audio DMA (ADMA) controller
> +
> +description: |
> +  The Tegra Audio DMA controller is used for transferring data
> +  between system memory and the Audio Processing Engine (APE).
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nvidia,tegra210-adma
> +          - nvidia,tegra186-adma
> +      - items:
> +          - const: nvidia,tegra194-adma
> +          - const: nvidia,tegra186-adma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      Should contain all of the per-channel DMA interrupts in
> +      ascending order with respect to the DMA channel index.

You need to define how many (minItems/maxItems).

> +
> +  clocks:
> +    description: Must contain one entry for the ADMA module clock

How many?

> +
> +  clock-names:
> +    const: d_audio
> +
> +  "#dma-cells":
> +    description: |
> +      The first cell denotes the receive/transmit request number and
> +      should be between 1 and the maximum number of requests supported.
> +      This value corresponds to the RX/TX_REQUEST_SELECT fields in the
> +      ADMA_CHn_CTRL register.
> +

Drop the blank line.

> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include<dt-bindings/clock/tegra210-car.h>
> +
> +    dma-controller@702e2000 {
> +        compatible = "nvidia,tegra210-adma";
> +        reg = <0x702e2000 0x2000>;
> +        interrupt-parent = <&tegra_agic>;
> +        interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&tegra_car TEGRA210_CLK_D_AUDIO>;
> +        clock-names = "d_audio";
> +        #dma-cells = <1>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 
