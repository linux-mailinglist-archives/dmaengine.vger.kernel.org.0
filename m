Return-Path: <dmaengine+bounces-5501-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E460CADC1F9
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 08:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A349E18962D2
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F54128BA9D;
	Tue, 17 Jun 2025 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+n75FWs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F928BA88;
	Tue, 17 Jun 2025 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140044; cv=none; b=ORccjx36T3ECqPW8Kp32evLQoc0fxMBJKeRN9UZl/CnnoXUU0ry4J1Fyxk+p2U0Y7etKjRbnF13UHRV62k1VdgpTtmeomboGwqf2SZQPAMlseXRS9qAY37k9nr/QBq7JvcmAsdv6fj0O5/+U91NHZ6bl6LNxVt4eL5nSYOy0B/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140044; c=relaxed/simple;
	bh=12KagmyykjPqQMTUr7/Xg6vcmrHrd0PDZscIpv7eR6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2AVzz7H8GqM1Sipp8sHCoJgcIAFH+1Q1NsrulJmWUjqo8QrRVEdtW+Agh7IH6tYLAhkeWQYgdPd6hT1tOLmq/mtAnG9oJfZZ186SlCryZ1lby5peXoNBfQFGnBRpAWxwesm7hlkEZTxyoWl5H/zLpoSUBDUUML3kUo4Vd9QMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+n75FWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C90C4CEE3;
	Tue, 17 Jun 2025 06:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750140042;
	bh=12KagmyykjPqQMTUr7/Xg6vcmrHrd0PDZscIpv7eR6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+n75FWsGqTzvmHUfHuMgS8O6lwy9yaKs48ViOPWs569cr3u+we5FiHAA0vYfyqk+
	 my6j6uttoFlsLTeK0k49Nj1iRK3xyV/SjceCjivB1g9kE3w3AQiaGhUjNEaRZNx6ME
	 wYsci9Ej9IZ7BSag4Bx0P8gxTFfX/Z6x+hKnVxO9ET+FzwfZGKeyDy/aYwZR8u+Obr
	 gWoUbDVHZDcivZLjzpmcY8l0/UH8QWcenREytrBpxe9f5bNsjHfHzH8FbC7EOZvL6g
	 GmxGfx+IxjKctiwGB2tKQovlgzAELQpypBfLvhOIBcySeYGe6aA+ypExS5hDA4f2GX
	 qQ0/CB6XuX+DA==
Date: Tue, 17 Jun 2025 11:30:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, emil.renner.berthing@canonical.com,
	inochiama@gmail.com, geert+renesas@glider.be, tglx@linutronix.de,
	hal.feng@starfivetech.com, joel@jms.id.au, duje.mihanovic@skole.hr,
	elder@riscstar.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 2/8] dma: mmp_pdma: Add optional clock support
Message-ID: <aFEEhik8x2k5_myN@vaman>
References: <20250611125723.181711-1-guodong@riscstar.com>
 <20250611125723.181711-3-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611125723.181711-3-guodong@riscstar.com>

On 11-06-25, 20:57, Guodong Xu wrote:
> Add support for retrieving and enabling an optional clock using
> devm_clk_get_optional_enabled() during mmp_pdma_probe().

Its dmaengine, please tag them as such

> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  drivers/dma/mmp_pdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index a95d31103d30..4a6dbf558237 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -15,6 +15,7 @@
>  #include <linux/device.h>
>  #include <linux/platform_data/mmp_dma.h>
>  #include <linux/dmapool.h>
> +#include <linux/clk.h>
>  #include <linux/of_dma.h>
>  #include <linux/of.h>
>  
> @@ -1019,6 +1020,7 @@ static int mmp_pdma_probe(struct platform_device *op)
>  {
>  	struct mmp_pdma_device *pdev;
>  	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
> +	struct clk *clk;
>  	int i, ret, irq = 0;
>  	int dma_channels = 0, irq_num = 0;
>  	const enum dma_slave_buswidth widths =
> @@ -1037,6 +1039,10 @@ static int mmp_pdma_probe(struct platform_device *op)
>  	if (IS_ERR(pdev->base))
>  		return PTR_ERR(pdev->base);
>  
> +	clk = devm_clk_get_optional_enabled(pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
>  	if (pdev->dev->of_node) {
>  		/* Parse new and deprecated dma-channels properties */
>  		if (of_property_read_u32(pdev->dev->of_node, "dma-channels",
> -- 
> 2.43.0

-- 
~Vinod

