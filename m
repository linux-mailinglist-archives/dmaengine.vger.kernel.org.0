Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F002C9117
	for <lists+dmaengine@lfdr.de>; Mon, 30 Nov 2020 23:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgK3WaA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Nov 2020 17:30:00 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38276 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgK3WaA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Nov 2020 17:30:00 -0500
Received: by mail-io1-f66.google.com with SMTP id y5so12473021iow.5;
        Mon, 30 Nov 2020 14:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8/EaFjzChv3yuUtw47TiG5tYxU7hn1SO6HPIjLuIIAI=;
        b=I0dozF/A3S8FdBHjRuRyLa61+NKtTzjBquERqRrxqCgPP61Xi5dmA8/EF0dS1mLQUK
         5Gt+7Qt3+0p0aHuE2lIIe+2OiiN8gScINUPB7tSeVS+c0BvqyJnJGGBhNOm0Y2ed2o0S
         UM49+QjXI6jqvj37rwX9Ie1ay+BkxWSK57NePbC6Wcn2vMl0j6beNyIk0X38PgzK3U8m
         F758MqiivDaGUf+WY7xvErqepHGDDmP3UHzdcONzBapneTXuDL/CFVrSM+Hs3+17S8Fo
         WeqpGEYjhPCOFtyBR8Q8HFgI2EsP0E/agip+n1BKoZG/QjeJ5xX6diMsPdeUXV4Y6tdx
         ifTQ==
X-Gm-Message-State: AOAM533FQN4UCeZssfa7TEnXHRcQk8b9S735RQRkKuTDuhExZGkI/fU4
        1idV74hggml+GfgBb/2OPg==
X-Google-Smtp-Source: ABdhPJz4ardhIRNFqAXT1upJpFbz8RfML0C1QTA3Qpn7yesfFDmNiEL36ARSBrxNackgrWiKJHU2XQ==
X-Received: by 2002:a02:b011:: with SMTP id p17mr16475329jah.55.1606775358790;
        Mon, 30 Nov 2020 14:29:18 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y13sm5373842iop.14.2020.11.30.14.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:29:18 -0800 (PST)
Received: (nullmailer pid 3151605 invoked by uid 1000);
        Mon, 30 Nov 2020 22:29:16 -0000
Date:   Mon, 30 Nov 2020 15:29:16 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com,
        andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 10/16] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Message-ID: <20201130222916.GA3146362@robh.at.kernel.org>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
 <20201123023452.7894-11-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123023452.7894-11-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 23, 2020 at 10:34:46AM +0800, Sia Jee Heng wrote:
> Add support for Intel KeemBay AxiDMA to the dw-axi-dmac
> Schemas DT binding.
> 
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 6c2e8e612af5..9e3ca9083814 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -8,6 +8,7 @@ title: Synopsys DesignWare AXI DMA Controller
>  
>  maintainers:
>    - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com

Also, for the first patch, missing a '>' on the end.

> +  - Jee Heng Sia <jee.heng.sia@intel.com>
>  
>  description: |
>   Synopsys DesignWare AXI DMA Controller DT Binding
> @@ -16,14 +17,18 @@ properties:
>    compatible:
>      enum:
>        - snps,axi-dma-1.01a
> +      - intel,kmb-axi-dma
>  
>    reg:
> +    minItems: 1
>      items:
>        - description: Address range of the DMAC registers
> +      - description: Address range of the DMAC APB registers

Nevermind for my 'reg' comment on the first patch.

>  
>    reg-names:
>      items:
>        - const: axidma_ctrl_regs
> +      - const: axidma_apb_regs
>  
>    interrupts:
>      maxItems: 1
> @@ -124,3 +129,25 @@ examples:
>           snps,priority = <0 1 2 3>;
>           snps,axi-max-burst-len = <16>;
>       };
> +
> +  - |

For what's just a new compatible and extra reg field, I don't think we 
need another example.

> +     #include <dt-bindings/interrupt-controller/arm-gic.h>
> +     #include <dt-bindings/interrupt-controller/irq.h>
> +     /* example with intel,kmb-axi-dma */
> +     #define KEEM_BAY_PSS_AXI_DMA
> +     #define KEEM_BAY_PSS_APB_AXI_DMA
> +     axi_dma: dma@28000000 {
> +         compatible = "intel,kmb-axi-dma";
> +         reg = <0x28000000 0x1000>, <0x20250000 0x24>;
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
