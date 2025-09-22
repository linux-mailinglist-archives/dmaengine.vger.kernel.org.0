Return-Path: <dmaengine+bounces-6681-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B843B928A2
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 20:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F53A59D7
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 18:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393A316914;
	Mon, 22 Sep 2025 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuO7sf29"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23704289824;
	Mon, 22 Sep 2025 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564246; cv=none; b=XGDR8iw5xKAPzUO46BFQd1MqvdI3WZycfrK1P7+ryFyqjUtO6vp5AYqnF/WZB3Lahsg19R1TI2t5MyGWS9mMfmdMTu5KHaD5XtpvCH3IeW1KVoMSeFnK9FQXFN4Z2KfbfkGAVC0C/+J54LAoPs7hPHICWf9inMagDHasLIjUQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564246; c=relaxed/simple;
	bh=L9lfSFfAFkIwqNZiT8BuwyifCSThhLnjRTrvPs+IIdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTEuA4F709qlNMJAdYAhd2B5tyCZ24M6JfkrjlBRw3M3EAiIrdPyQWbjlrRj1DkVondXffRRvSHJ2mRy4FXcV8I+x5AfZbchW84VX79IhlOMFbLaIIuXOrPMI5vyPNGDkK1dB5AJjs9Y+5skNgV7NMIu9nH2Pqw+Y1KENZrjRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuO7sf29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C4EC4CEF0;
	Mon, 22 Sep 2025 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758564246;
	bh=L9lfSFfAFkIwqNZiT8BuwyifCSThhLnjRTrvPs+IIdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XuO7sf29Gl3ExIVcVZoCotjBNm3sk5GSvahi/cVy0jCmUwsRze6ueZWDob1ye9ecZ
	 Z7y677vHWKpuPqKxHPdGwXBaUnxQtk7nfu+bDD2FMWkSCnDcKXFQTQ6RmMa1GpHtL7
	 hCDqiwntDiMzz9O+fS0+0F03rrkVX1aVsXXM4zSg82k4YFHElOioIXXCAw004tNAj7
	 rCMzM9rPjOIB/rOxuQTiY/IiqnngQk4/GqL+9pBiMnzdxqMvQDmabA55m92HTnOGFO
	 RqBCizGK5IfTUIeDyIguy9vptrroQP7zKvtqUwIC0Mdp11YU+0AKY8f2aFdY/ktorj
	 kGBrcyWquc0YQ==
Date: Mon, 22 Sep 2025 13:04:04 -0500
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
Subject: Re: [PATCH 02/10] dt-bindings: clock: Add RDA Micro RDA8810PL
 clock/reset controller
Message-ID: <20250922180404.GA542994-robh@kernel.org>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
 <20250919-rda8810pl-mmc-v1-2-d4f08a05ba4d@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-rda8810pl-mmc-v1-2-d4f08a05ba4d@mainlining.org>

On Fri, Sep 19, 2025 at 01:48:42AM +0700, Dang Huynh wrote:
> Add documentation describing the RDA8810PL Clock and Reset
> controller.
> 
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
>  .../bindings/clock/rda,8810pl-apsyscon.yaml        | 43 +++++++++++++
>  include/dt-bindings/clock/rda,8810pl-apclk.h       | 70 ++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml b/Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..d90dae8ebaa270aa822e4855d2a4a892168c5eea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rda,8810pl-apsyscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RDA Micro RDA8810PL AP Clock Controller
> +
> +maintainers:
> +  - Dang Huynh <dang.huynh@mainlining.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: rda,8810pl-apsyscon
> +      - const: syscon

What makes this a syscon? (Answer in the commit msg). If your only use 
is so the regmap is automagically created for you, don't. Create a 
regmap yourself in your driver.

Rob

