Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07F72B4942
	for <lists+dmaengine@lfdr.de>; Mon, 16 Nov 2020 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgKPP1W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 10:27:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43433 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731340AbgKPP1V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Nov 2020 10:27:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id t143so19140215oif.10;
        Mon, 16 Nov 2020 07:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xUXSweo7NzDpGONzH1JHq5i88gmR7wl2dS6zxWyTFhE=;
        b=eaLZdmhy5fQLuzsuJQ3S7xxCGtxGSSib2FIkCKEZkKwhPdUPIlnlI0W3ZyzBfcocyL
         1ihEH/H7+offNfnE9ZalORvwSJ2W4zFi84YDr++VpGC0Spzs+iQRkpPWLRRz3bp1p9iV
         SD+2xI9RoKQxP7QUrbLkO3qzSM9Y4aRMl41CjmWKGKNyX2h8sw0aPtLg6s8EFLYkGfNI
         gkOF5Hy51BQrDNJr8IUTcmIHYolV/Eyf2rBXLgE1G8AU31zvns56r0qoZYz9bIPS1MVi
         l1eWv0o/j3yuCgA7ntNWvDZnuceQG7+IPzM+ofBS7upvnA4bWoCkqD4r3cAhf09Y0cIt
         /81g==
X-Gm-Message-State: AOAM533ZDq82dJKTK61unQYvTpdVQdeolFDLKn000jqcRX7i7kEBHVHa
        VxXFoNn113bm69s2e/r29NCGUngAlg==
X-Google-Smtp-Source: ABdhPJzB2x7at4icGFJD7RlJ7Sq0hMlvfSA5yEvzkDFqQskPpqfw3eKcRmeQ2o2qM5u9D2xSis2A2w==
X-Received: by 2002:aca:30d2:: with SMTP id w201mr24774oiw.8.1605540440695;
        Mon, 16 Nov 2020 07:27:20 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t6sm4816069ooo.22.2020.11.16.07.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:27:19 -0800 (PST)
Received: (nullmailer pid 1678651 invoked by uid 1000);
        Mon, 16 Nov 2020 15:27:18 -0000
Date:   Mon, 16 Nov 2020 09:27:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: dma: Add DT bindings for HiSilicon
 Hiedma Controller
Message-ID: <20201116152718.GA1646380@bogus>
References: <20201114003440.36458-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114003440.36458-1-gengdongjiu@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 14, 2020 at 12:34:39AM +0000, Dongjiu Geng wrote:
> The Hiedma Controller v310 Provides eight DMA channels, each
> channel can be configured for one-way transfer. The data can
> be transferred in 8-bit, 16-bit, 32-bit, or 64-bit mode. This
> documentation describes DT bindings of this controller.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  .../bindings/dma/hisilicon,hiedmacv310.yaml   | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml b/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
> new file mode 100644
> index 000000000000..c04603316b40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/hisilicon,hiedmacv310.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license new bindings. GPL-2.0-only OR BSD-2-Clause

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
> +  compatible:
> +    const: hisilicon,hiedmacv310_n

s/_/-/


> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
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
> +required:
> +  - "#dma-cells"
> +  - "#clock-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names

> +  - resets
> +  - reset-names

Not documented.

> +  - dma-requests
> +  - dma-channels
> +  - devid

What's this? It's not defined. If a device index, we don't do device 
indices in DT.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/hi3559av100-clock.h>
> +
> +    dma: dma-controller@10040000 {
> +      compatible = "hisilicon,hiedmacv310_n";
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
> +      devid = <1>;
> +      #dma-cells = <2>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
