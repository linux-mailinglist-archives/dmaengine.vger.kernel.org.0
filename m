Return-Path: <dmaengine+bounces-5862-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31947B10A3A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jul 2025 14:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7EC3AD369
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jul 2025 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E122749D6;
	Thu, 24 Jul 2025 12:31:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D2265CA4;
	Thu, 24 Jul 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360296; cv=none; b=CVuaecfKYE6LO3X4UQoYL9eORp8/rB6VEOEF2bST/VPxACp0rvwh4zWSa/vWldnaLKNTaAVP1nkIAp8GZ5yxlY4zs/0piY/oX9hQoQ9rtyyzM4NWU78FiMwTx1/9u859S+hWzNi7LGHteV9OaHkTyACDGwiOmttoEb+O17FI8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360296; c=relaxed/simple;
	bh=6gW1O+8T+ie5JBZvdwtSAFWnQaJdFjlrByrYTH2nYHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKXuFj2UzSeGhpP3EIDRJeg1d9dYsHM8Jsm45oZFyfK4VjDpGpEPgAg+vWBKuh5D14vIItHOA1naA1AF254NTZ7mM5vEsMKA53IzC6V5jZykSx5xUfDALHscglMhcb9anJvQIE9G/gb5eHZ0I3pNmwJFAIQvLxHnBVu4wWqduO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AAFFB341044;
	Thu, 24 Jul 2025 12:31:33 +0000 (UTC)
Date: Thu, 24 Jul 2025 20:31:28 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alex Elder <elder@riscstar.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v3 2/8] dmaengine: mmp_pdma: Add optional clock support
Message-ID: <20250724123128-GYB748228@gentoo>
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
 <20250714-working_dma_0701_v2-v3-2-8b0f5cd71595@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-working_dma_0701_v2-v3-2-8b0f5cd71595@riscstar.com>

Hi Guodong,

I personally find the word 'optional' introducing some confusions..
I can understand from driver perspective, it's kind of optional,
but from SpacemiT K1 perspective, it's mandatory for this driver
(the 'clocks' property of DT is in 'required' section)

feel free to improve the commit message, maybe add some motivation
hehind this

On 17:39 Mon 14 Jul     , Guodong Xu wrote:
> Add support for retrieving and enabling an optional clock during
> mmp_pdma_probe().
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v3: No change.
> v2: No change.
> ---
>  drivers/dma/mmp_pdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index a95d31103d3063a1d11177a1a37b89ac2fd213e9..4a6dbf55823722d26cc69379d22aaa88fbe19313 100644
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
> 
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)

