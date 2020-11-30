Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6982C90B7
	for <lists+dmaengine@lfdr.de>; Mon, 30 Nov 2020 23:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgK3WLw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Nov 2020 17:11:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37479 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgK3WLv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Nov 2020 17:11:51 -0500
Received: by mail-io1-f66.google.com with SMTP id k3so5619471ioq.4;
        Mon, 30 Nov 2020 14:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PwkJqLowzDL+9HXdnbrfZmKU7lasECCA1uDRYV9fPoQ=;
        b=Ni7e23JfLMj3Y7LPVoy+aUDsLbScnlMfTcS1oCPIEWqlXWb6kFQ/AKkue7lmXk3vhG
         F4Z304QITqjuXnbecuSUa/fxsx2G4UujA6JDamnCcn7ieWxRrAtJl4bXWeGrWN5BrmKJ
         17CwlLCqeVBtRqeEaL/PDh8Hw8fJyZ7a6sewLBnwFdOoMm54vb4n/Mq/nIezDdRXhDND
         Yr0kR/0CgJKor0MO6R3RMSxchNImiiaVDUhgS+DS9H/yNF82E+lSnZYNEsaT1b1HA+gz
         JovTNUCHkt/CK2GwpPC8XudyfKFuYvkSZfpfS3LDaZ7gt1FerAbroZ3F38+LZ9/FJd8f
         z0jQ==
X-Gm-Message-State: AOAM530JSQ8j/OZzqSgrJP5hyB7c6nMEFnUcTE+Ll5M7UpaGfV6/FrFz
        IP4QBH9aOccn4R1ftUBVhw==
X-Google-Smtp-Source: ABdhPJzRrL6U7pdbMbCbLDE1gq9Xwe5CX+NGWTcG2eLvrnrXuqch8z1WKPajJAbyAjuyQxcgJXTV0w==
X-Received: by 2002:a5e:8606:: with SMTP id z6mr15966064ioj.91.1606774270222;
        Mon, 30 Nov 2020 14:11:10 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d1sm3127532ioh.3.2020.11.30.14.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:11:09 -0800 (PST)
Received: (nullmailer pid 3123248 invoked by uid 1000);
        Mon, 30 Nov 2020 22:11:07 -0000
Date:   Mon, 30 Nov 2020 15:11:07 -0700
From:   Rob Herring <robh@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, vkoul@kernel.org,
        dan.j.williams@intel.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt: bindings: dma: Add DT bindings for HiSilicon
 Hiedma Controller
Message-ID: <20201130221107.GA3117412@robh.at.kernel.org>
References: <20201119200129.28532-1-gengdongjiu@huawei.com>
 <20201119200129.28532-4-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119200129.28532-4-gengdongjiu@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Nov 19, 2020 at 08:01:28PM +0000, Dongjiu Geng wrote:
> The Hiedma Controller v310 Provides eight DMA channels, each
> channel can be configured for one-way transfer. The data can
> be transferred in 8-bit, 16-bit, 32-bit, or 64-bit mode. This
> documentation describes DT bindings of this controller.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  .../bindings/dma/hisilicon,hiedmacv310.yaml   | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml b/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
> new file mode 100644
> index 000000000000..fe5c5af4d3e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier:  GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/hisilicon,hiedmacv310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon Hiedma Controller v310 Device Tree Bindings
> +
> +description: |
> +  These bindings describe the DMA engine included in the HiSilicon Hiedma
> +  Controller v310 Device.
> +
> +maintainers:
> +  - Dongjiu Geng <gengdongjiu@huawei.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  "#dma-cells":
> +    const: 2
> +
> +  "#clock-cells":
> +    const: 2

The DMA controller is a clock provider? Odd. What does each cell 
represent?

> +
> +  compatible:
> +    const: hisilicon,hiedmacv310
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  misc_regmap:
> +    description: phandle pointing to the misc controller provider node.
> +
> +  misc_ctrl_base:
> +    maxItems: 1

These 2 can be a single property with phandle + reg offset.

Also, needs a vendor prefix and don't use '_'.

> +
> +  clocks:
> +    items:
> +      - description: apb clock
> +      - description: axi clock
> +
> +  clock-names:
> +    items:
> +      - const: apb_pclk
> +      - const: axi_aclk
> +
> +  resets:
> +    description: phandle pointing to the dma reset controller provider node.
> +
> +  reset-names:
> +    items:
> +      - const: dma-reset
> +
> +  dma-requests:
> +    maximum: 32
> +
> +  dma-channels:
> +    maximum: 8
> +
> +
> +required:
> +  - "#dma-cells"
> +  - "#clock-cells"
> +  - compatible
> +  - misc_regmap
> +  - misc_ctrl_base
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - dma-requests
> +  - dma-channels
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/hi3559av100-clock.h>
> +
> +    dma: dma-controller@10040000 {
> +      compatible = "hisilicon,hiedmacv310";
> +      reg = <0x10040000 0x1000>;
> +      misc_regmap = <&misc_ctrl>;
> +      misc_ctrl_base = <0x144>;
> +      interrupts = <0 82 4>;
> +      clocks = <&clock HI3559AV100_EDMAC1_CLK>, <&clock HI3559AV100_EDMAC1_AXICLK>;
> +      clock-names = "apb_pclk", "axi_aclk";
> +      #clock-cells = <2>;
> +      resets = <&clock 0x16c 7>;
> +      reset-names = "dma-reset";
> +      dma-requests = <32>;
> +      dma-channels = <8>;
> +      #dma-cells = <2>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
