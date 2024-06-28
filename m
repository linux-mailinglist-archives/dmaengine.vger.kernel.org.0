Return-Path: <dmaengine+bounces-2597-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C83291C899
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 23:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120ED1F2243F
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248080023;
	Fri, 28 Jun 2024 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtN5dCO2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3550978C9D;
	Fri, 28 Jun 2024 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611634; cv=none; b=YC9NaDRiRr9TOELir8EnlAFckQWIczAcDkNQFd6ebOhWrDaX2vJMVRrkVGpm3dH/GFL2qDtqS3N5nYqANbiDCp1cM3TnA7mSzA1mkXXAJkTtnZvpN1S3K0e3segMg48hqqf3I8wmt6l6KkiEo+I9Cxfue3HrjFK1Eh1pQHM56+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611634; c=relaxed/simple;
	bh=WcshtjSqHHVhmIBO76+DfRQx30aQY4R3HPwLd14k22E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGXKDr6gmYeWl3Imf9WdoiMF19g+qDl6Do0UlzUaoUPRmrcNE/nqam3KdD+x++gExXkpRQl9LC5QjISAR4pxRWT3asE5z8rpnGctu+mOt2BdmF8IubNo2o9QT8p3ozhbCK9vYaeWFNQD/5/cpCko4uzA+T7fK74Q50rPvhz2EXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtN5dCO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F2BC116B1;
	Fri, 28 Jun 2024 21:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719611633;
	bh=WcshtjSqHHVhmIBO76+DfRQx30aQY4R3HPwLd14k22E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtN5dCO2I35JCVc1GH9W+SlqlKfkmWFQygB8uqBD3iyYwQt/O/Neb9C6D37IBdANa
	 4SSmVf2GraKNQfMlSJdWAhry+2YIdJLKDQpzIB+UzWoPlduqjSY660NKkcSSTYVcz3
	 LaeuNi3gRNuQiEWwP8yWC1UPqO0PugY+DM/vai+WiFovnvsta1ApISRoBQL7O0U/xn
	 YDoxNfQYaVc+bTUzUyjuUmAyL3gzP/8PZPsEvu/JVYH6sHh1yLnfKpz0NG7/FE8MQ5
	 j5b4JgHIods4YJNlUqc+d/PJdd2tc7Mm84/FpgBurw2MWifZ/uvVzWM08U5/dQZ7fM
	 pQEb5I1EuTYBQ==
Date: Fri, 28 Jun 2024 15:53:50 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
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
Message-ID: <20240628215350.GA267712-robh@kernel.org>
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

On Wed, Jun 26, 2024 at 12:18:09PM +0200, Krzysztof Kozlowski wrote:
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

No bounces on this? According to this[1], Rahul is not with Maxlinear 
any more. Maybe an address in that thread will work. But seems like it 
is abandoned.

Rob

[1] https://lore.kernel.org/all/20230519044555.3750-2-yzhu@maxlinear.com/

