Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1611339D5
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2020 04:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAHDzl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jan 2020 22:55:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36631 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgAHDzk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jan 2020 22:55:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id 19so2293763otz.3
        for <dmaengine@vger.kernel.org>; Tue, 07 Jan 2020 19:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KLfZmUczJHxkBJ7qYbPJXerVFSLgsQsJgvS5hmfmovA=;
        b=MtP4KQYUV87wMJdLPyXDA+76TEgyr6pwSn+wjnxnK0hqQ9JSkF0256ElG/0V8zWSWM
         z2PbeQDMqJT3hZqOBwMjqi4bPtwsg+1a5avXbeJa3NiO65p/0/6Q8QACIJho4ZtqW1zB
         Y1yTUwXhRWl2fiFRGFjefKN4sqUXXaYEc//5jo9FxQ09+0xJ3EBjSXiiOQkflnDwGocq
         84Z3CZLtFjLGZhSKpzsLGlrxt6SlW7DuM29+m6NLw4UrJH7asWZaDjxO6GVCxTja6kzA
         HY4kKoC4fGBWaoK4xA28KJGvPugksShXFCnBZnuUUsZK/W7Jyos1EvRzSGKTNj50Na/V
         Iovg==
X-Gm-Message-State: APjAAAVH03S/+zjGI9EeL7fGvbAXjWok9UrUDuTLVkNj5T1JKtdZyAum
        EHq8vnxP18jSyC28uQfb29BLs2I=
X-Google-Smtp-Source: APXvYqyAbXXZuOF4KtJkhn+Hq5whfXLPi3+CvaiKvM+hqI+R4kpFd79wpGJ018ZVpbQBgESjrwK3vg==
X-Received: by 2002:a05:6830:22c6:: with SMTP id q6mr2829414otc.244.1578455739591;
        Tue, 07 Jan 2020 19:55:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v21sm653595otr.72.2020.01.07.19.55.38
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 19:55:38 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219e3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 07 Jan 2020 21:55:37 -0600
Date:   Tue, 7 Jan 2020 21:55:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add UniPhier external DMA
 controller bindings
Message-ID: <20200108035537.GA7843@bogus>
References: <1576630620-1977-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1576630620-1977-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576630620-1977-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Dec 18, 2019 at 09:56:59AM +0900, Kunihiko Hayashi wrote:
> Add external DMA controller bindings implemented in Socionext UniPhier
> SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/dma/uniphier-xdmac.txt     | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-xdmac.txt

Please make this a DT schema. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt b/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
> new file mode 100644
> index 00000000..4e3927f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/uniphier-xdmac.txt
> @@ -0,0 +1,86 @@
> +Socionext UniPhier external DMA controller bindings
> +
> +This describes the devicetree bindings for an external DMA engine to perform
> +memory-to-memory or peripheral-to-memory data transfer, implemented in
> +Socionext UniPhier SoCs.
> +
> +* DMA controller
> +
> +Required properties:
> +- compatible: Should be "socionext,uniphier-xdmac".
> +- reg: Specifies offset and length of the register set for the device.
> +- interrupts: An interrupt specifier associated with the DMA controller.
> +- #dma-cells: Must be <2>. The first cell represents the channel index.
> +	The second cell represents the factor for transfer request.
> +	This is mentioned in DMA client section.
> +- dma-channels : Number of DMA channels supported. Should be 16.

If always 16, then why do you need this?

> +
> +Example:
> +	xdmac: dma-controller@5fc10000 {
> +		compatible = "socionext,uniphier-xdmac";
> +		reg = <0x5fc10000 0x1000>, <0x5fc20000 0x800>;
> +		interrupts = <0 188 4>;
> +		#dma-cells = <2>;
> +		dma-channels = <16>;
> +	};
> +
> +* DMA client
> +
> +Required properties:
> +- dmas: A list of DMA channel requests.
> +- dma-names: Names of the requested channels corresponding to dmas.
> +
> +DMA clients must use the format described in the dma.txt file, using a two cell
> +specifier for each channel.

No need to redefine the client binding here. Just need the cell format 
as below.

> +
> +Each DMA request consists of 3 cells:
> + 1. A phandle pointing to the DMA controller
> + 2. Channel index
> + 3. Transfer request factor number, If no transfer factor, use 0.
> +	The number is SoC-specific, and this should be specified with relation
> +	to the device to use the DMA controller. The list of the factor number
> +	can be found below.
> +
> +	0x0	none
> +	0x8	UART ch0 Rx
> +	0x9	UART ch0 Tx
> +	0xa	UART ch1 Rx
> +	0xb	UART ch1 Tx
> +	0xc	UART ch2 Rx
> +	0xd	UART ch2 Tx
> +	0xe	UART ch3 Rx
> +	0xf	UART ch3 Tx
> +	0x14	SCSSI ch1 Rx
> +	0x15	SCSSI ch1 Tx
> +	0x16	SCSSI ch0 Rx
> +	0x17	SCSSI ch0 Tx
> +	0x18	SCSSI ch2 Rx
> +	0x19	SCSSI ch2 Tx
> +	0x1a	SCSSI ch3 Rx
> +	0x1b	SCSSI ch3 Tx
> +	0x21	I2C ch0 Rx
> +	0x22	I2C ch0 Tx
> +	0x23	I2C ch1 Rx
> +	0x24	I2C ch1 Tx
> +	0x25	I2C ch2 Rx
> +	0x26	I2C ch2 Tx
> +	0x27	I2C ch3 Rx
> +	0x28	I2C ch3 Tx
> +	0x29	I2C ch4 Rx
> +	0x2a	I2C ch4 Tx
> +	0x2b	I2C ch5 Rx
> +	0x2c	I2C ch5 Tx
> +	0x2d	I2C ch6 Rx
> +	0x2e	I2C ch6 Tx
> +
> +Example:
> +	spi3: spi@54006300 {
> +		compatible = "socionext,uniphier-scssi";
> +		reg = <0x54006300 0x100>;
> +		interrupts = <0 39 4>;
> +		clocks = <&peri_clk 14>;
> +		resets = <&peri_rst 14>;
> +
> +		dmas = <&xdmac 0 0x1a>, <&xdmac 1 0x1b>;
> +		dma-names = "rx", "tx";
> +	};
> -- 
> 2.7.4
> 
