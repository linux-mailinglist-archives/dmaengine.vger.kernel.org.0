Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92612B07F0
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 15:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgKLO6G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 09:58:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43845 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLO6D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Nov 2020 09:58:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id y22so5805403oti.10;
        Thu, 12 Nov 2020 06:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzomR2457JzNPEkc4wmRbKkcWEmWqpBD7KuvF89fibM=;
        b=ghUraP7ZnIkdJ9sMtw6WqCmDu6dJ35enRfDS6nUzFILgfxCx3N+Q9Q0j4vw5NXUAor
         87HjHIAxIqTx0oPyWgi5jEJTg+Pfqb9OGH1RaYefJAVWek2UZMSGLGxoqi2wvFeGNiLV
         12En1GE19MmoEF0uGShZTi0AsFqYai2vR6/8GAZyDZN+Anv/dZILqt1Jt4Wbt+DjbC67
         5GPZJIVr/wfuzSR7lxNtDg74HtlfZ2+VGwGtatQWDc1+QHntysy+8+4LA19oMN5IXi9T
         z7WH2/h9I5ycUKCaOQnyXjFShVbV5aTO9pIFhbCVNre1WOGNL+KbCGMBSufmTUCu63ER
         xI4A==
X-Gm-Message-State: AOAM532xuDhMbAX5p7NfUPZU/dksUEhGPF0siCa29eIPsqyGphKK0KRD
        RtFZQbqBZIvAI04zBwpZGg==
X-Google-Smtp-Source: ABdhPJwOQcHhxxUSsWnv6Up3CyU+P27HKK5b9fj5uBkIeRDqGet7+h5NEOmvn6JB6olwKWbXu2Ek1g==
X-Received: by 2002:a9d:ea9:: with SMTP id 38mr5672482otj.339.1605193082053;
        Thu, 12 Nov 2020 06:58:02 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s185sm1210421oia.18.2020.11.12.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:58:01 -0800 (PST)
Received: (nullmailer pid 3588430 invoked by uid 1000);
        Thu, 12 Nov 2020 14:58:00 -0000
Date:   Thu, 12 Nov 2020 08:58:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com,
        andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 10/15] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Message-ID: <20201112145800.GB3583607@bogus>
References: <20201112084953.21629-1-jee.heng.sia@intel.com>
 <20201112084953.21629-11-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112084953.21629-11-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Nov 12, 2020 at 04:49:48PM +0800, Sia Jee Heng wrote:
> Add support for Intel KeemBay AxiDMA to the dw-axi-dmac
> Schemas DT binding.
> 
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 481ef0dacf5f..18e9422095bb 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
>  
>  maintainers:
>    - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
> +  - Jee Heng Sia <jee.heng.sia@intel.com>
>  
>  description: |
>   Synopsys DesignWare AXI DMA Controller DT Binding
> @@ -16,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - snps,axi-dma-1.01a
> +      - intel,kmb-axi-dma
>  
>    reg:
>      items:
> @@ -24,6 +26,7 @@ properties:
>    reg-names:
>      items:
>        - const: axidma_ctrl_regs
> +      - const: axidma_apb_regs

You need 'minItems: 1' here or everyone has to have 2 entries.

Also, doesn't 'reg' need updating?

>  
>    interrupts:
>      maxItems: 1
> @@ -124,3 +127,25 @@ examples:
>           snps,priority = <0 1 2 3>;
>           snps,axi-max-burst-len = <16>;
>       };
> +
> +  - |
> +     #include <dt-bindings/interrupt-controller/arm-gic.h>
> +     #include <dt-bindings/interrupt-controller/irq.h>
> +     /* example with intel,kmb-axi-dma */
> +     #define KEEM_BAY_PSS_AXI_DMA
> +     #define KEEM_BAY_PSS_APB_AXI_DMA
> +     axi_dma: dma@28000000 {
> +         compatible = "intel,kmb-axi-dma";
> +         reg = <0x28000000 0x1000 0x20250000 0x24>;

reg = <0x28000000 0x1000>, <0x20250000 0x24>;

> +         reg-names = "axidma_ctrl_regs", "axidma_apb_regs";
> +         interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +         clock-names = "core-clk", "cfgr-clk";
> +         clocks = <&scmi_clk KEEM_BAY_PSS_AXI_DMA>, <&scmi_clk KEEM_BAY_PSS_APB_AXI_DMA>;
> +         #dma-cells = <1>;
> +         dma-channels = <8>;
> +         snps,dma-masters = <1>;
> +         snps,data-width = <4>;
> +         snps,priority = <0 0 0 0 0 0 0 0>;
> +         snps,block-size = <1024 1024 1024 1024 1024 1024 1024 1024>;
> +         snps,axi-max-burst-len = <16>;
> +     };
> -- 
> 2.18.0
> 
