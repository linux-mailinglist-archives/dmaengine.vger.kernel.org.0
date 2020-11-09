Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425D72AB38B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 10:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKIJ0q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 04:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgKIJ0q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 04:26:46 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A2B2206ED;
        Mon,  9 Nov 2020 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604914005;
        bh=dL4w1M7JkVNx/jvqRkMTwFB16AstJVbWAl5jVOs/vbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxYJBAAalRPfZ8WTpklJKiHBlHeOLJCbCKSpQfajxqMUywkxF6TOt1b87Ao2a4l4X
         hpi9QLckTLjhhVKHA+nh4H+XUw1A0yBPwoeEEW/s2EGxJLE3jFdLz+UP5k0TaZkNip
         RxM75iJjUV+/AcjW6P0ojJ7A11IW1wyr5yUEpfJY=
Date:   Mon, 9 Nov 2020 14:56:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     Eugeniy.Paltsev@synopsys.com, andriy.shevchenko@linux.intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Message-ID: <20201109092640.GB3171@vkoul-mobl>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
 <20201027063858.4877-2-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027063858.4877-2-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-10-20, 14:38, Sia Jee Heng wrote:
> YAML schemas Device Tree (DT) binding is the new format for DT to replace
> the old format. Introduce YAML schemas DT binding for dw-axi-dmac and
> remove the old version.

I see that Rob and DT folks have not been cced, please do so

> 
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 ------
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 124 ++++++++++++++++++
>  2 files changed, 124 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> deleted file mode 100644
> index dbe160400adc..000000000000
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -Synopsys DesignWare AXI DMA Controller
> -
> -Required properties:
> -- compatible: "snps,axi-dma-1.01a"
> -- reg: Address range of the DMAC registers. This should include
> -  all of the per-channel registers.
> -- interrupt: Should contain the DMAC interrupt number.
> -- dma-channels: Number of channels supported by hardware.
> -- snps,dma-masters: Number of AXI masters supported by the hardware.
> -- snps,data-width: Maximum AXI data width supported by hardware.
> -  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> -- snps,priority: Priority of channel. Array size is equal to the number of
> -  dma-channels. Priority value must be programmed within [0:dma-channels-1]
> -  range. (0 - minimum priority)
> -- snps,block-size: Maximum block size supported by the controller channel.
> -  Array size is equal to the number of dma-channels.
> -
> -Optional properties:
> -- snps,axi-max-burst-len: Restrict master AXI burst length by value specified
> -  in this property. If this property is missing the maximum AXI burst length
> -  supported by DMAC is used. [1:256]
> -
> -Example:
> -
> -dmac: dma-controller@80000 {
> -	compatible = "snps,axi-dma-1.01a";
> -	reg = <0x80000 0x400>;
> -	clocks = <&core_clk>, <&cfgr_clk>;
> -	clock-names = "core-clk", "cfgr-clk";
> -	interrupt-parent = <&intc>;
> -	interrupts = <27>;
> -
> -	dma-channels = <4>;
> -	snps,dma-masters = <2>;
> -	snps,data-width = <3>;
> -	snps,block-size = <4096 4096 4096 4096>;
> -	snps,priority = <0 1 2 3>;
> -	snps,axi-max-burst-len = <16>;
> -};
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> new file mode 100644
> index 000000000000..e688d25864bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/snps,dw-axi-dmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare AXI DMA Controller
> +
> +maintainers:
> +  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com
> +
> +description: |
> + Synopsys DesignWare AXI DMA Controller DT Binding
> +
> +properties:
> +  compatible:
> +    enum:
> +      - snps,axi-dma-1.01a
> +
> +  reg:
> +    items:
> +      - description: Address range of the DMAC registers.
> +
> +  reg-names:
> +    items:
> +      - const: axidma_ctrl_regs
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock
> +
> +  clock-names:
> +    items:
> +      - const: core-clk
> +      - const: cfgr-clk
> +
> +  '#dma-cells':
> +    const: 1
> +
> +  dma-channels:
> +    description: |
> +      Number of channels supported by hardware.
> +
> +  snps,dma-masters:
> +    description: |
> +      Number of AXI masters supported by the hardware.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 2]
> +        default: 2
> +
> +  snps,data-width:
> +    description: |
> +      AXI data width supported by hardware.
> +      (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3, 4, 5, 6]
> +        default: 4
> +
> +  snps,priority:
> +    description: |
> +      Channel priority specifier associated with the DMA channels.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 8
> +        default: [0, 1, 2, 3]
> +
> +  snps,block-size:
> +    description: |
> +      Channel block size specifier associated with the DMA channels.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 8
> +        default: [4096, 4096, 4096, 4096]
> +
> +  snps,axi-max-burst-len:
> +    description: |
> +      Restrict master AXI burst length by value specified in this property.
> +      If this property is missing the maximum AXI burst length supported by
> +      DMAC is used. [1:256]
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 16
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - '#dma-cells'
> +  - dma-channels
> +  - snps,dma-masters
> +  - snps,data-width
> +  - snps,priority
> +  - snps,block-size

Pls add  additionalProperties: false and run latest dt schema tool from
Rob

-- 
~Vinod
