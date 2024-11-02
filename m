Return-Path: <dmaengine+bounces-3679-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2D9BA1D2
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 18:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142AB2820A3
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F830188721;
	Sat,  2 Nov 2024 17:45:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6821815688C;
	Sat,  2 Nov 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730569545; cv=none; b=DQcuntE86XRMDX6Kyq/P3Jz/gJJ+a/j8bnPvhtlVLcq1PukE8XxExpHhViTfgp80or3Xs4HppHICrUMup1G1thJd1WSwkrPkUlyc9vwcmd/TQ3+Y4tHdRzVODc6R/ODlttWKEvgBhHf1DdbEdrnclWMB9SvP0a1e6Sq8lEoxKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730569545; c=relaxed/simple;
	bh=6WrhZWAJgavrSKkvG6AR5CqzWMmZYIaV6d20Lx0RzVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2n0Hp1kbUMeD8uoAl3F4IBNpvGKPEg95bePueQcNxh/77W7+MDZQbUg+ADuBTPIRsrF+1LxSVTZg4AwF8MZ/+j2vxVj35PAGuE8ojtLKfiIZQNGRSm0faOVFL6pAI2UBH7qT8D7YTXdklxc5tZMLazIPLQKMy4wGM/5nqDGamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68869FEC;
	Sat,  2 Nov 2024 10:46:04 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06EB03F66E;
	Sat,  2 Nov 2024 10:45:32 -0700 (PDT)
Date: Sat, 2 Nov 2024 17:45:16 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: "=?UTF-8?B?Q3PDs2vDoXMs?= Bence" <csokas.bence@prolan.hu>
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Mesih Kilinc
 <mesihkilinc@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Philipp
 Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v5 2/5] dma-engine: sun4i: Add has_reset option to quirk
Message-ID: <20241102174516.02d124d6@minigeek.lan>
In-Reply-To: <20241102093140.2625230-3-csokas.bence@prolan.hu>
References: <20241102093140.2625230-1-csokas.bence@prolan.hu>
	<20241102093140.2625230-3-csokas.bence@prolan.hu>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Nov 2024 10:31:41 +0100
"Cs=C3=B3k=C3=A1s, Bence" <csokas.bence@prolan.hu> wrote:

Hi,

> From: Mesih Kilinc <mesihkilinc@gmail.com>
>=20
> Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
> has this bit but in order to support suniv we need to add it. So add
> support for reset bit.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> [ csokas.bence: Rebased and addressed comments ]
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>
> ---
>=20
> Notes:
>     Changes in v2:
>     * Call reset_control_deassert() unconditionally, as it supports optio=
nal resets
>     * Use dev_err_probe()
>     * Whitespace
>     Changes in v3:
>     * More dev_err_probe() fixes
>     Changes in v4:
>     * Use return value of dev_err_probe()
>     Changes in v5:
>     * More whitespace
>=20
>  drivers/dma/sun4i-dma.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index b2c1e4b9f696..9d1e3c51342d 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_dma.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> =20
> @@ -159,6 +160,7 @@ struct sun4i_dma_config {
>  	u8 ddma_drq_sdram;
> =20
>  	u8 max_burst;
> +	bool has_reset;
>  };
> =20
>  struct sun4i_dma_pchan {
> @@ -208,6 +210,7 @@ struct sun4i_dma_dev {
>  	int				irq;
>  	spinlock_t			lock;
>  	const struct sun4i_dma_config *cfg;
> +	struct reset_control *rst;
>  };
> =20
>  static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
> @@ -1215,6 +1218,13 @@ static int sun4i_dma_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(priv->clk);
>  	}
> =20
> +	if (priv->cfg->has_reset) {
> +		priv->rst =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);

Can't we use devm_reset_control_get_optional_exclusive(), and then save
this whole has_reset bit?

> +		if (IS_ERR(priv->rst))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(priv->rst),
> +					     "Failed to get reset control\n");
> +	}
> +
>  	platform_set_drvdata(pdev, priv);
>  	spin_lock_init(&priv->lock);
> =20
> @@ -1287,6 +1297,14 @@ static int sun4i_dma_probe(struct platform_device =
*pdev)
>  		return ret;
>  	}
> =20
> +	/* Deassert the reset control */
> +	ret =3D reset_control_deassert(priv->rst);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			      "Failed to deassert the reset control\n");
> +		goto err_clk_disable;
> +	}
> +
>  	/*
>  	 * Make sure the IRQs are all disabled and accounted for. The bootloader
>  	 * likes to leave these dirty
> @@ -1355,6 +1373,7 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg =
=3D {
>  	.ddma_drq_sdram		=3D SUN4I_DDMA_DRQ_TYPE_SDRAM,
> =20
>  	.max_burst		=3D SUN4I_MAX_BURST,
> +	.has_reset		=3D false,
>  };
> =20
>  static const struct of_device_id sun4i_dma_match[] =3D {


