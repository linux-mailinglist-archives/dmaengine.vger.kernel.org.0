Return-Path: <dmaengine+bounces-6815-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2723FBD21EF
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 10:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0D83BFD70
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0C2DC340;
	Mon, 13 Oct 2025 08:41:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF52264CB
	for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344915; cv=none; b=tMQ21TTeD/sFmorBUAaLU0rxTgsULw8wWGa0MOJof2kacwWee6yBrN+D19F8zK4GdkblX21JUVsOGc8Gul8gzUmLyHQ1HVoJ+JgOaKhms4gVtA+/KMYM4Joo94ZO1Un6QvhbFgS3wAb31ICHH/vrlTeaJ/HmVW+IaCT61as9oF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344915; c=relaxed/simple;
	bh=UEFOSh0xRz8cYbaVE1rSJZQXECRmazCUfCdPoIpjvgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GCIp5ajOvMqNCvEMXyCgpwgAxFUEzAzXH2TsatsVfBJZM3kkUjoFBQ33N6bKtQJF3D0DjXUsqItOuYquZyEwilzMbq59Fr8UedK9b5+5fZLLaaYa2+PNlC1ZfkQ7l8B2FEizJZiry8/JkM9F0KCKm79nq5mJdmb45fRG0XwCUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v8E7n-0004vn-1X; Mon, 13 Oct 2025 10:41:47 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v8E7m-003M6K-0Q;
	Mon, 13 Oct 2025 10:41:46 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v8E7m-000000004e4-0FhD;
	Mon, 13 Oct 2025 10:41:46 +0200
Message-ID: <bf59e192acc06c88f122578e40ee64e1cafe8152.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] dmaengine: dw-axi-dmac: add reset control support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Artem Shimko <a.shimko.dev@gmail.com>, Eugeniy Paltsev
	 <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Oct 2025 10:41:45 +0200
In-Reply-To: <20251012100002.2959213-3-a.shimko.dev@gmail.com>
References: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
	 <20251012100002.2959213-3-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On So, 2025-10-12 at 13:00 +0300, Artem Shimko wrote:
> Add proper reset control handling to the AXI DMA driver to ensure
> reliable initialization and power management. The driver now manages
> resets during probe, remove, and system suspend/resume operations.
>=20
> The implementation stores reset control in the chip structure and adds
> reset assert/deassert calls at the appropriate points: resets are
> deasserted during probe after clock acquisition, asserted during remove
> and error cleanup, and properly managed during suspend/resume cycles.
> Additionally, proper error handling is implemented for reset control
> operations to ensure robust behavior.
>=20
> This ensures the controller is properly reset during power transitions
> and prevents potential issues with incomplete initialization.
>=20
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 41 ++++++++++++-------
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
>  2 files changed, 28 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c
> index 8b7cf3baf5d3..3f4dd2178498 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1321,6 +1321,9 @@ static int axi_dma_suspend(struct device *dev)
>  	axi_dma_irq_disable(chip);
>  	axi_dma_disable(chip);
> =20
> +	if (chip->has_resets)
> +		reset_control_assert(chip->resets);

reset_control_assert/deassert() handle NULL pointers, so you could drop
the chip->has_resets flag and just

	reset_control_assert(chip->resets);

unconditionally.

> +
>  	clk_disable_unprepare(chip->core_clk);
>  	clk_disable_unprepare(chip->cfgr_clk);
> =20
> @@ -1340,6 +1343,9 @@ static int axi_dma_resume(struct device *dev)
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (chip->has_resets)
> +		reset_control_deassert(chip->resets);
> +

Same as above.

>  	axi_dma_enable(chip);
>  	axi_dma_irq_enable(chip);
> =20
> @@ -1455,7 +1461,6 @@ static int dw_probe(struct platform_device *pdev)
>  	struct axi_dma_chip *chip;
>  	struct dw_axi_dma *dw;
>  	struct dw_axi_dma_hcfg *hdata;
> -	struct reset_control *resets;
>  	unsigned int flags;
>  	u32 i;
>  	int ret;
> @@ -1487,16 +1492,6 @@ static int dw_probe(struct platform_device *pdev)
>  			return PTR_ERR(chip->apb_regs);
>  	}
> =20
> -	if (flags & AXI_DMA_FLAG_HAS_RESETS) {
> -		resets =3D devm_reset_control_array_get_exclusive(&pdev->dev);
> -		if (IS_ERR(resets))
> -			return PTR_ERR(resets);
> -
> -		ret =3D reset_control_deassert(resets);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	chip->dw->hdata->use_cfg2 =3D !!(flags & AXI_DMA_FLAG_USE_CFG2);
> =20
>  	chip->core_clk =3D devm_clk_get(chip->dev, "core-clk");
> @@ -1507,18 +1502,31 @@ static int dw_probe(struct platform_device *pdev)
>  	if (IS_ERR(chip->cfgr_clk))
>  		return PTR_ERR(chip->cfgr_clk);
> =20
> +	chip->has_resets =3D !!(flags & AXI_DMA_FLAG_HAS_RESETS);
> +	if (chip->has_resets) {
> +		chip->resets =3D devm_reset_control_array_get_exclusive(&pdev->dev);
> +		if (IS_ERR(chip->resets))
> +			return PTR_ERR(chip->resets);
> +
> +		ret =3D reset_control_deassert(chip->resets);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
> +	}
> +

Why is this moved down here?

>  	ret =3D parse_device_properties(chip);
>  	if (ret)
> -		return ret;
> +		goto err_exit;
> =20
>  	dw->chan =3D devm_kcalloc(chip->dev, hdata->nr_channels,
>  				sizeof(*dw->chan), GFP_KERNEL);
> -	if (!dw->chan)
> -		return -ENOMEM;
> +	if (!dw->chan) {
> +		ret =3D -ENOMEM;
> +		goto err_exit;
> +	}
> =20
>  	ret =3D axi_req_irqs(pdev, chip);
>  	if (ret)
> -		return ret;
> +		goto err_exit;
> =20
>  	INIT_LIST_HEAD(&dw->dma.channels);
>  	for (i =3D 0; i < hdata->nr_channels; i++) {
> @@ -1605,6 +1613,9 @@ static int dw_probe(struct platform_device *pdev)
> =20
>  err_pm_disable:
>  	pm_runtime_disable(chip->dev);
> +err_exit:
> +	if (chip->has_resets)
> +		reset_control_assert(chip->resets);

If it is ok to keep the module in reset, shouldn't the reset control be
asserted on device remove() as well?

regards
Philipp

