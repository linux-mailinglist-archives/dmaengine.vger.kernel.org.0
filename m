Return-Path: <dmaengine+bounces-6684-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060AB92921
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB4E7A814C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 18:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC675317712;
	Mon, 22 Sep 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk6ob/OG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC0E27A919;
	Mon, 22 Sep 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564805; cv=none; b=L+kaudMK0UoXLI/rR8keSFMZRKdHaZvJ1pdOXAJ4uMwWZ9SsOJ7vERyHk51biyaFbTVbTClPBmstKD4G6W34xAc+EQWbKYZIFTY/rJooN3ckPaLb5RJmHsd9Igy91YXQlDBOFs+Z8+OTNg0uJXhvvy8QdisJRTh7iO7OPAZZfPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564805; c=relaxed/simple;
	bh=ch3XJR3/J1ZY9eeHVCkTk3w1gXTPD/CTnWH+kKraEHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puKWaC+jb+aHlo1ESPqwoKCkRx4RwmO5BymV2OcMS7fTTXdboQOhQemdW/8wt6sMlGHj33+Vxt1MCaG5/X1OEzSo1lVqPtDPzc/w0g5aoURlocx0sj1TXaxZTYZhPt3T0252eR6iNj52YYnGeZfloCEdFeMl6yw5GqSEGymHgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk6ob/OG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABED0C4CEF5;
	Mon, 22 Sep 2025 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758564804;
	bh=ch3XJR3/J1ZY9eeHVCkTk3w1gXTPD/CTnWH+kKraEHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yk6ob/OGAwkGwWAGBkC3qGsL386M31FRg5HYHcF6fPnimFhdojR95nWwH1ZyzM8So
	 h7zcLzQJCGrZUbByHokQiq2rPXoQovFkjUIRLMWjh/C5NUAWvWT7r9jw+e6hVXqknQ
	 v/gyeUsRx5+lyUGTRB4ay78pCyjW8zJsxawdOzJeJ9USmCKNyQChfKIqy54MA59FlL
	 1CL0h2tfxpF4yPwQs6pFiHonmeFZIc1eK8syWFQeya/tghmGe8aRRHgEPqMyyDrhMe
	 97Nhgnd0kWevlM6zF4bWz0Z9Fz4Rql+DkHFKCo/IXy/gL4hzqII5Izi3/JAu1UA1HN
	 2b9fRV2dD7PDw==
Date: Mon, 22 Sep 2025 13:13:23 -0500
From: Rob Herring <robh@kernel.org>
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: mmc: Add RDA SDMMC controller
Message-ID: <20250922181323.GA556259-robh@kernel.org>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
 <20250919-rda8810pl-mmc-v1-4-d4f08a05ba4d@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-rda8810pl-mmc-v1-4-d4f08a05ba4d@mainlining.org>

On Fri, Sep 19, 2025 at 01:48:44AM +0700, Dang Huynh wrote:
> Add documentation describing the SD/MMC controller in RDA Micro
> RDA8810PL SoC.
> 
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  Documentation/devicetree/bindings/mmc/rda,mmc.yaml | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/rda,mmc.yaml b/Documentation/devicetree/bindings/mmc/rda,mmc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f3cda38abd66023ca9bc94d1c29df5ae9e211e7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/rda,mmc.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/rda,mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RDA Micro SD/MMC Controller
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +maintainers:
> +  - Dang Huynh <dang.huynh@mainlining.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rda,8810pl-mmc
> +      - const: rda,mmc

Drop the generic compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  rda,mclk-adj:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Some board need MCLK output to be delayed for the card to work.
> +      If not present, MCLK output is not delayed.
> +    minimum: 0
> +    maximum: 255

You can drop the constraints if they are not less than uint8 range.

What are the units? 

I guess 'adj' means adjust. Just use 'rda,mclk-delay' to be more 
precise.

> +
> +  rda,mclk-inv:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Some board need MCLK to be inverted for the card to work.
> +      If not present, MCLK is not inverted.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - dmas
> +  - dma-names
> +  - vmmc-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/rda,8810pl-apclk.h>
> +    #include <dt-bindings/dma/rda-ifc.h>
> +    mmc@20950000 {
> +      compatible = "rda,8810pl-mmc", "rda,mmc";
> +      reg = <0x20950000 0x1000>;
> +      interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&ap_syscon CLK_APB2>;
> +      clock-names = "mclk";
> +      resets = <&ap_syscon RST_APB2_SDMMC1>;
> +      dmas = <&ifc IFC_SDMMC1_TX>, <&ifc IFC_SDMMC1_RX>;
> +      dma-names = "tx", "rx";
> +      vmmc-supply = <&vdd_sdmmc>;
> +      rda,mclk-adj = /bits/ 8 <1>;
> +      rda,mclk-inv;
> +    };
> +
> +...
> 
> -- 
> 2.51.0
> 

