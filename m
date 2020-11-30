Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7552C9102
	for <lists+dmaengine@lfdr.de>; Mon, 30 Nov 2020 23:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgK3W0c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Nov 2020 17:26:32 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33229 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgK3W0b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Nov 2020 17:26:31 -0500
Received: by mail-io1-f67.google.com with SMTP id o8so13566899ioh.0;
        Mon, 30 Nov 2020 14:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LIfWEkt0aVq3m94fOUZkuS/yeYq9FEE9ORbmu+AJJ1w=;
        b=YvkeMdwpRF5jHJm4yi6GyrRVjsgzHyRRDv3ataEWT/Tmwn/gPOXxMEIYtke6lPjVHV
         /d35XVN4tfFR5u7eK6+PbIgWBdxNkOOnTcVrcjBbqpil7m1EPufTP2Ckgwf0oaPtIEbw
         L/ETbtZ9FtUWL+J6X6CGfGAnKAO5dkv3RMFy+T7MHWQi4sp91iITkrcw6KzZmqABnjZ3
         qYgXZRkIBxvIdnwjvJlJwmkJ5+nkBSM1BT/+uPd3iVdW5nKgKmMBXx06vCGshq57exEc
         mvIuq6hHrIvCz8tuv0pYQ29AT3SaWP1zVNgNfxQCLjQ5/FnwpFy90hZOdiMoP1eHh2CM
         +SqQ==
X-Gm-Message-State: AOAM530jVUPqV7eaH0pcZQsrVzn39BiQuUeMxdoI1jRjMps7S43UciVF
        ockHh6D6RlD3KTz4OI3S5Y3RVATIbg==
X-Google-Smtp-Source: ABdhPJyUnpP60gWfxQnWpC5+zZywke78Ty+RZxUOqPwqLvhb37q04WYH9lPqDS9hVdJ3jyAiOf6p1g==
X-Received: by 2002:a05:6602:388:: with SMTP id f8mr9205661iov.56.1606775150273;
        Mon, 30 Nov 2020 14:25:50 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p7sm2586517iln.11.2020.11.30.14.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:25:49 -0800 (PST)
Received: (nullmailer pid 3146099 invoked by uid 1000);
        Mon, 30 Nov 2020 22:25:47 -0000
Date:   Mon, 30 Nov 2020 15:25:47 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com,
        andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 01/16] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Message-ID: <20201130222547.GA3123716@robh.at.kernel.org>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
 <20201123023452.7894-2-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123023452.7894-2-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 23, 2020 at 10:34:37AM +0800, Sia Jee Heng wrote:
> YAML schemas Device Tree (DT) binding is the new format for DT to replace
> the old format. Introduce YAML schemas DT binding for dw-axi-dmac and
> remove the old version.
> 
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 ------
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 39 deletions(-)
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
> index 000000000000..6c2e8e612af5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -0,0 +1,126 @@
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

Don't need '|' unless there's formatting to preserve.

> + Synopsys DesignWare AXI DMA Controller DT Binding

And should be 2 space indent.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - snps,axi-dma-1.01a
> +
> +  reg:
> +    items:
> +      - description: Address range of the DMAC registers

Just 'maxItems: 1'

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

No need to describe a common property. You do need to provide some 
constraints. I'd assume there's less than 2^32 channels.

> +
> +  snps,dma-masters:
> +    description: |
> +      Number of AXI masters supported by the hardware.
> +    allOf:

You don't need to use allOf with a $ref anymore.

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

Looks like some constraints.

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
