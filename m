Return-Path: <dmaengine+bounces-3240-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200098A83D
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42A01C21755
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A74190052;
	Mon, 30 Sep 2024 15:12:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEE190671
	for <dmaengine@vger.kernel.org>; Mon, 30 Sep 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709174; cv=none; b=szb/3Yl+IVkWy2TgcE+pM5kBFKcQ81PcXUT+sUUdp/+91/fffAKCNaf1VPdHfseBUjS2IFageSXksGimz4Ne6TLqOme9Z47e8MSSG4TQPOtmwtLsIOM6VFi4d0mRlHq9w6ETU3V2J6xW3ZZa6NEFHKsH5knpS7BWeuLX6efHlkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709174; c=relaxed/simple;
	bh=kVaZaIovbaLeKMOfcrrCEP3OE/iyUWs6aRUHCjsFx8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPAjdZLgToQ9QzOi93dMUp4P5MXowCZZjBMTOt5u/TF1gcSVnN/qzEreLkz+bc4zWbtA+fhcGxLuJzvDIO70vVR9JtOTz9HO/wQb3KACBzziYJYNAp0F3oyi8xc+m9PGGe/CffovjYjJKxRq25zgHDTNTwNPgUXO2Q3GbUrov+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svI4n-0001Wv-Uz; Mon, 30 Sep 2024 17:12:42 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svI4m-002f1m-V4; Mon, 30 Sep 2024 17:12:40 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svI4m-000CXt-2u;
	Mon, 30 Sep 2024 17:12:40 +0200
Message-ID: <53ef80b6fa77b0ce2545adb602dd3b6f58461c01.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] dmaengine: sh: rz-dmac: add r7s72100 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-renesas-soc@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org
Date: Mon, 30 Sep 2024 17:12:40 +0200
In-Reply-To: <20240930145955.4248-4-wsa+renesas@sang-engineering.com>
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
	 <20240930145955.4248-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Mo, 2024-09-30 at 16:59 +0200, Wolfram Sang wrote:
> Update descriptions and make getting resets optional.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/dma/sh/Kconfig   | 6 +++---
>  drivers/dma/sh/rz-dmac.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
> index c0b2997ab7fd..2b2e8ca257f5 100644
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -49,10 +49,10 @@ config RENESAS_USB_DMAC
>  	  SoCs.
> =20
>  config RZ_DMAC
> -	tristate "Renesas RZ/{G2L,V2L} DMA Controller"
> -	depends on ARCH_RZG2L || COMPILE_TEST
> +	tristate "Renesas RZ/{A1,G2L,V2L} DMA Controller"
> +	depends on ARCH_R7S72100 || ARCH_RZG2L || COMPILE_TEST
>  	select RENESAS_DMA
>  	select DMA_VIRTUAL_CHANNELS
>  	help
>  	  This driver supports the general purpose DMA controller found in the
> -	  Renesas RZ/{G2L,V2L} SoC variants.
> +	  Renesas RZ/{A1,G2L,V2L} SoC variants.
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 811389fc9cb8..03f3f99f0f4a 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -893,7 +893,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
>  	/* Initialize the channels. */
>  	INIT_LIST_HEAD(&dmac->engine.channels);
> =20
> -	dmac->rstc =3D devm_reset_control_array_get_exclusive(&pdev->dev);
> +	dmac->rstc =3D devm_reset_control_array_get_optional_exclusive(&pdev->d=
ev);
>  	if (IS_ERR(dmac->rstc))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
>  				     "failed to get resets\n");

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

