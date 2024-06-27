Return-Path: <dmaengine+bounces-2549-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A879A91A173
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 276A3B23E2F
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 08:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F547D401;
	Thu, 27 Jun 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEJZDHhV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B5757EA;
	Thu, 27 Jun 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476921; cv=none; b=tYsM8cl6yVqdgxSITTF6F+xAvhFE6Tk8beMF42EqoVmUPCKHi1k2dKzuLEEsbR/vy8N77hVyOzVMnoKEcRzVKHn86+i4koAWeSpNZ2/o5Xm5wAETvOGWfKCXPg0YgIU1RvOU0T/F2FwP3tVjJ8PL1IDDdDw/MWO8+sY+Pw4fob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476921; c=relaxed/simple;
	bh=n/uEXqzaAS0LB/LRznxb+HuYwPZJVllY5Qhdrwu1MqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evxYHIGhEnMf5DoYustJ8gf2HZL8SL7dc2V3++ITJ2UYtcZtq6s4gjt0dLTX3FEQerWZrCAwyDkUArT0w6CTY1FTjG87YsmzgjpIZTR9b5274U27ro1L8QV5a1W/bUBVDm5nqYDQ00EnMj0km8dIZErx83ZES6EQFZPTWZueI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEJZDHhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF220C2BBFC;
	Thu, 27 Jun 2024 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719476921;
	bh=n/uEXqzaAS0LB/LRznxb+HuYwPZJVllY5Qhdrwu1MqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEJZDHhVhcNiVug6kgdBPbYxRjCNx3u1B6goW2YKr70VVSxpBOxlBUHeSuYa69PEO
	 evUjmHD04cVXV97ioGmV3hC66TnlzhUmiTVfDnx82jeam1/5GVSaKrmaNr8cpBMXOw
	 8ElIXezAY0pkC1nzBYb5NtlIA8abPWhBuy+YAeh32+IqCX00aDhGxRp3lvyLRCz4yO
	 xyZs7jyr3zFqI06WgnbXHULic4LJo+85KS/zFk/1Zy9T4+iB8MD92cf7ss7dqUgoYz
	 jO/xxmlIKNrjscgSLWgU30KlHGdw8b7kuzL9AfjX0Lh1nRVv89E3Db7ACr7prEHib7
	 AgMu06ztKLyiQ==
Date: Thu, 27 Jun 2024 09:28:33 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
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
Message-ID: <20240627082833.GI2532839@google.com>
References: <20240626101809.25227-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626101809.25227-1-krzysztof.kozlowski@linaro.org>

On Wed, 26 Jun 2024, Krzysztof Kozlowski wrote:

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
>  Documentation/devicetree/bindings/leds/leds-lgm.yaml          | 3 +--

Acked-by: Lee Jones <lee@kernel.org>

>  Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml  | 2 +-
>  Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml | 2 +-
>  Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml  | 2 +-
>  Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml   | 2 +-
>  7 files changed, 7 insertions(+), 9 deletions(-)

-- 
Lee Jones [李琼斯]

