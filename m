Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3602DA3AF
	for <lists+dmaengine@lfdr.de>; Mon, 14 Dec 2020 23:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441251AbgLNWxG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Dec 2020 17:53:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37229 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgLNWwy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Dec 2020 17:52:54 -0500
Received: by mail-oi1-f196.google.com with SMTP id l207so21162692oib.4;
        Mon, 14 Dec 2020 14:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TSPeDwDqHL7Ub0+2b5Fnr/pWsApzxn+V5GRHfk0wSRk=;
        b=MmI0JROeH53fMD8FYLdhjPTKxzb4q0euZfs8qy44ygtCAx/gP1cAwcD898G5TFrwM5
         fQgZc92XUHp1ANs12VvLeosBlqMVPIcfTaJAelUcX74zQcXOPY6oI8JQ8NeExqkjrCwV
         Emtb14SL3bBVQkhEJ7XsycLo6BgxNyTUusJBRkMwKLPui4wq9QlWROpecQYAk5rW+YjU
         DECg7tr5nrfrUDsSwHwg7/aNnz7aM40U4jn+4FvdXomsqFcGYw+0Pm8ceUzzT9jY/xgE
         74Y0p/nnJsgFaPfOk3SPiZfabGYfh/zLrKpFg4p/2jkMoAoqlRAEfRSL1cZ1+ZAYzVxV
         H85g==
X-Gm-Message-State: AOAM532OIDC6rz+V2D+9bJ13qRI66iTyWN1/EeHGhveIBMud+xW19fOG
        0aHcCnTAqrQ8S5IZWDPlhg==
X-Google-Smtp-Source: ABdhPJwOXULB1ECJDoaE4w7+NuBTCx7ST1Vt2ZrWx2F+JgYT4PHNu7Qv4AxQPf62WhVJbIDUjq/fyA==
X-Received: by 2002:aca:bb43:: with SMTP id l64mr19511603oif.52.1607986333112;
        Mon, 14 Dec 2020 14:52:13 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i82sm4591680oif.33.2020.12.14.14.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:52:12 -0800 (PST)
Received: (nullmailer pid 2530719 invoked by uid 1000);
        Mon, 14 Dec 2020 22:52:11 -0000
Date:   Mon, 14 Dec 2020 16:52:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com,
        andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 01/16] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Message-ID: <20201214225211.GA2525287@robh.at.kernel.org>
References: <20201211004642.25393-1-jee.heng.sia@intel.com>
 <20201211004642.25393-2-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211004642.25393-2-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 11, 2020 at 08:46:27AM +0800, Sia Jee Heng wrote:
> YAML schemas Device Tree (DT) binding is the new format for DT to replace
> the old format. Introduce YAML schemas DT binding for dw-axi-dmac and
> remove the old version.
> 
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 ------
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml


> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> new file mode 100644
> index 000000000000..61ad37a3f559
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/snps,dw-axi-dmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare AXI DMA Controller
> +
> +maintainers:
> +  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> +
> +description:
> +  Synopsys DesignWare AXI DMA Controller DT Binding

allOf:
  - $ref: dma-controller.yaml#

> +
> +properties:
> +  compatible:
> +    enum:
> +      - snps,axi-dma-1.01a
> +
> +  reg:
> +    items:
> +      - description: Address range of the DMAC registers
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

Already described in dma-controller.yaml

> +    minimum: 1
> +    maximum: 8
> +
> +  snps,dma-masters:
> +    description: |
> +      Number of AXI masters supported by the hardware.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2]
> +    default: 2
> +
> +  snps,data-width:
> +    description: |
> +      AXI data width supported by hardware.
> +      (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6]
> +    default: 4
> +
> +  snps,priority:
> +    description: |
> +      Channel priority specifier associated with the DMA channels.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 8
> +    default: [0, 1, 2, 3]
> +
> +  snps,block-size:
> +    description: |
> +      Channel block size specifier associated with the DMA channels.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 8
> +    default: [4096, 4096, 4096, 4096]
> +
> +  snps,axi-max-burst-len:
> +    description: |
> +      Restrict master AXI burst length by value specified in this property.
> +      If this property is missing the maximum AXI burst length supported by
> +      DMAC is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 256
> +    default: 16
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - '#dma-cells'

Already required.

> +  - dma-channels
> +  - snps,dma-masters
> +  - snps,data-width
> +  - snps,priority
> +  - snps,block-size

How can these be both required and have a default?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +     #include <dt-bindings/interrupt-controller/arm-gic.h>
> +     #include <dt-bindings/interrupt-controller/irq.h>
> +     /* example with snps,dw-axi-dmac */
> +     dmac: dma-controller@80000 {
> +         compatible = "snps,axi-dma-1.01a";
> +         reg = <0x80000 0x400>;
> +         clocks = <&core_clk>, <&cfgr_clk>;
> +         clock-names = "core-clk", "cfgr-clk";
> +         interrupt-parent = <&intc>;
> +         interrupts = <27>;
> +         #dma-cells = <1>;
> +         dma-channels = <4>;
> +         snps,dma-masters = <2>;
> +         snps,data-width = <3>;
> +         snps,block-size = <4096 4096 4096 4096>;
> +         snps,priority = <0 1 2 3>;
> +         snps,axi-max-burst-len = <16>;
> +     };
> -- 
> 2.18.0
> 
