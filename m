Return-Path: <dmaengine+bounces-2577-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61691B76D
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 08:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BA21C22735
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 06:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C613C674;
	Fri, 28 Jun 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp6CluUR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400564D5BF;
	Fri, 28 Jun 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557870; cv=none; b=BacHx7tTUkJqV+R8B8hFBcWy/2Eis2hQ0t59KwySUfhuZp+X39hYt1l5VtGvH3wXcZWTHdSepla8dw2txCt4S53+3yCRdgCh1BNCmtfXId6Jh/MHw5F8iuVuUAWDwKwD5K3lF6R9dbFqZZo1pjUEaH9ur8ZhgN4jwmS/tqyLPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557870; c=relaxed/simple;
	bh=58lZCQAq4UI2kPsnIOyCJhEWm6AHR55RqFIhoOvy+cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD42gtf+G17tbnurUPzJqchkg+J7t3wMj5EhVSdXubLZOT6u0nZG4t5+vh/cX2XufWUuRT/+rXYMJisWzjvCZPQD2PfErXCf8oJu4PAnifxlxmmEArp2EaFEoyCASwFELJWUDidoYQrCMEOqKCIa9pbHPlHNIwTChXdhb4W08/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp6CluUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8CAC116B1;
	Fri, 28 Jun 2024 06:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719557869;
	bh=58lZCQAq4UI2kPsnIOyCJhEWm6AHR55RqFIhoOvy+cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zp6CluURowv+K0o/6F/MgxegIwLdBw2CY+SGJlzU3KpAFthCGzF5BdRqDhOX9fqA4
	 6t4b9L4J09XsfQ9CJ+lFuJpKnCdsOjuvXVwRyHnP01vP9BLlw5o6QxJBiFMolGBdOV
	 slZCTHTdDEmylt+etBWz6a3fIBVZBAWbN6PHcQjAC2NlCpNeIJISJn8bx3tparFCKS
	 1hQ/eZI6WuJS5OlEtQb/0au/AZDl+wqO3YNyssROZqexkI3jDED6pT5dn6x3M/6I0A
	 zuf07R+KZNWcUj3g8IyIPslcD3Fc30WwNBShmdFFG43vXx8MdIH+vY4RpRt8ZS5+jK
	 dciT+YC/UsdFw==
Date: Fri, 28 Jun 2024 12:27:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: intel,lgm: drop inactive maintainers from
 intel
Message-ID: <Zn5e6fPR5UkbPhdQ@matsya>
References: <20240626101809.25227-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626101809.25227-1-krzysztof.kozlowski@linaro.org>

On 26-06-24, 12:18, Krzysztof Kozlowski wrote:
> Emails to chuanhua.lei@intel.com, mallikarjunax.reddy@intel.com,
> yixin.zhu@intel.com and vadivel.muruganx.ramuthevar@linux.intel.com
> bounce with the same message:
> 
>   Your message wasn't delivered to Yixin.zhu@intel.com because the
>   address couldn't be found or is unable to receive email.
> 
> The Intel LGM SoC was apparently part of Home Gateway division which was
> acquired by Maxlinear, so switch maintenance of affected bindings to the
> only known non-bouncing Maxlinear address: Rahul Tanwar.
> 
> I do not know if Rahul Tanwar or Maxlinear want to maintain the
> bindings, so regardless of this change we should consider bindings
> abandoned and probably drop soon.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml    | 2 +-
>  Documentation/devicetree/bindings/dma/intel,ldma.yaml         | 3 +--

Acked-by: Vinod Koul <vkoul@kernel.org>

>  Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml  | 2 +-
>  Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml | 2 +-
>  Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml  | 2 +-

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

