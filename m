Return-Path: <dmaengine+bounces-4167-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 600CCA17520
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2025 00:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620327A3CB7
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 23:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B651F0E31;
	Mon, 20 Jan 2025 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="MY3PoJB3"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E41EEA5F;
	Mon, 20 Jan 2025 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737417494; cv=none; b=EvJKQGXRbYAb4qjpWQ64rv0nEnEhRzAY98zPozz1hJeCDvP7W2wPFg6IwYduqLoF5be+ul6aLmuQmULMnVyGZltIo3pAC+/qVUpGpeUD/mszMurAky3iTpn+0VJJUT6RemoeSuoBCkcc1z9P1Qg3oAoeHADwjY89aVw+T964Hek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737417494; c=relaxed/simple;
	bh=X7XkJHJJePFk96UIZAhtCRmPeQpsM03ev+h9+VwScas=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGfIMsk1BkCxNeZ42NmVaw2Hxz84oG63JwulBX2nt/E2Zr7vcT0lNXNysr+6xXtfuCqCOrzgz5ykSraUMozk8sIgq5n+QWoqtNn70pvZOm7DL1QwqgybvuicUuoSAL0uKRMOjRboxPb4mv5O4mn31r9G6AD4q8pDJKPld+s6U1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=MY3PoJB3; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1737416955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vb+cZhxGdLsBtYABfJWi+gMxt2Bz2rrH5ztnMW0VGro=;
	b=MY3PoJB3fzwPtDfAIMG4l2lWi8xrA08Tbln3l+koIj+YmfHqWrZ8H8/E1ykQ89gYz2yuj5
	Dyrr5x+I/g3Dcpx53gJUY5iYJJ83yXPq3iYz9labBithfS2ln3tDDVdVDiJ0nNeOXwesh3
	Yz1eZVxMrFkGuaO4bT32LcpkiGRxfzA=
Message-ID: <b32939c57f1faff7ae33c072d5824d8225735de6.camel@crapouillou.net>
Subject: Re: [PATCH] dma: jz4780: fix call balance of jzdma->clk handling
 routines
From: Paul Cercueil <paul@crapouillou.net>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Vinod Koul <vkoul@kernel.org>, Alex Smith <alex.smith@imgtec.com>, 
 Zubair Lutfullah Kakakhel	 <Zubair.Kakakhel@imgtec.com>,
 linux-mips@vger.kernel.org, 	dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fedor Pchelkin	 <pchelkin@ispras.ru>, Alexey
 Khoroshilov <khoroshilov@ispras.ru>, Vadim Mutilin	 <mutilin@ispras.ru>,
 lvc-project@linuxtesting.org
Date: Tue, 21 Jan 2025 00:48:13 +0100
In-Reply-To: <20250120135059.302273-1-mordan@ispras.ru>
References: <20250120135059.302273-1-mordan@ispras.ru>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Vitalii,

Le lundi 20 janvier 2025 =C3=A0 16:50 +0300, Vitalii Mordan a =C3=A9crit=C2=
=A0:
> If the clock jzdma->clk was not enabled in jz4780_dma_probe(), it
> should
> not be disabled in any path.
>=20
> Conversely, if it was enabled in jz4780_dma_probe(), it must be
> disabled
> in all error paths to ensure proper cleanup.
>=20
> Use the devm_clk_get_enabled() helper function to ensure proper call
> balance for jzdma->clk.
>=20
> Found by Linux Verification Center (linuxtesting.org) with Klever.
>=20
> Fixes: d894fc6046fe ("dmaengine: jz4780: add driver for the Ingenic
> JZ4780 DMA controller")
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul


> ---
> =C2=A0drivers/dma/dma-jz4780.c | 14 ++++----------
> =C2=A01 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 100057603fd4..ff9c387fd8c1 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -896,15 +896,13 @@ static int jz4780_dma_probe(struct
> platform_device *pdev)
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> -	jzdma->clk =3D devm_clk_get(dev, NULL);
> +	jzdma->clk =3D devm_clk_get_enabled(dev, NULL);
> =C2=A0	if (IS_ERR(jzdma->clk)) {
> -		dev_err(dev, "failed to get clock\n");
> +		dev_err(dev, "failed to get and enable clock\n");
> =C2=A0		ret =3D PTR_ERR(jzdma->clk);
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> -	clk_prepare_enable(jzdma->clk);
> -
> =C2=A0	/* Property is optional, if it doesn't exist the value will
> remain 0. */
> =C2=A0	of_property_read_u32_index(dev->of_node, "ingenic,reserved-
> channels",
> =C2=A0				=C2=A0=C2=A0 0, &jzdma->chan_reserved);
> @@ -972,7 +970,7 @@ static int jz4780_dma_probe(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	ret =3D platform_get_irq(pdev, 0);
> =C2=A0	if (ret < 0)
> -		goto err_disable_clk;
> +		return ret;
> =C2=A0
> =C2=A0	jzdma->irq =3D ret;
> =C2=A0
> @@ -980,7 +978,7 @@ static int jz4780_dma_probe(struct
> platform_device *pdev)
> =C2=A0			=C2=A0 jzdma);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(dev, "failed to request IRQ %u!\n", jzdma-
> >irq);
> -		goto err_disable_clk;
> +		return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D dmaenginem_async_device_register(dd);
> @@ -1002,9 +1000,6 @@ static int jz4780_dma_probe(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0err_free_irq:
> =C2=A0	free_irq(jzdma->irq, jzdma);
> -
> -err_disable_clk:
> -	clk_disable_unprepare(jzdma->clk);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -1015,7 +1010,6 @@ static void jz4780_dma_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	of_dma_controller_free(pdev->dev.of_node);
> =C2=A0
> -	clk_disable_unprepare(jzdma->clk);
> =C2=A0	free_irq(jzdma->irq, jzdma);
> =C2=A0
> =C2=A0	for (i =3D 0; i < jzdma->soc_data->nb_channels; i++)


