Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299AE24DC82
	for <lists+dmaengine@lfdr.de>; Fri, 21 Aug 2020 19:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgHURDt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Aug 2020 13:03:49 -0400
Received: from crapouillou.net ([89.234.176.41]:60498 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgHURCM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Aug 2020 13:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598029328; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ug5gxRXWAmpM8XNioOeKclYiEPP4BbU07uhWjR3Ug9Q=;
        b=x1UiSShYKhNWkYR4fQ4NnNOx3XVOyC4J+Uz2YQHTAnKh/JxvHpm9QtgSjOtpAdZOiMnO0e
        7T6i334G567SO96AIU6yNxNwTGC/AI4+5imcJfDekHDN5JDlFPplnW903jV5n7taNgCDwC
        ykVqnCCQ5EHDAvi9htZfbLUidHoW9DA=
Date:   Fri, 21 Aug 2020 19:01:57 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] drivers/dma/dma-jz4780: Fix race condition between
 probe and irq handler
To:     madhuparnabhowmik10@gmail.com
Cc:     vkoul@kernel.org, dan.j.williams@intel.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org
Message-Id: <9BBFFQ.4DKVQYU5BDCT1@crapouillou.net>
In-Reply-To: <20200821034423.12713-1-madhuparnabhowmik10@gmail.com>
References: <20200821034423.12713-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



Le ven. 21 ao=FBt 2020 =E0 9:14, madhuparnabhowmik10@gmail.com a =E9crit :
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>=20
> In probe, IRQ is requested before zchan->id is initialized which can=20
> be
> read in the irq handler. Hence, shift request irq after other=20
> initializations
> complete.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Thanks for the patch.

Cheers,
-Paul

>=20
> ---
> Changes since v1:
> Keep enable clock before request IRQ.
> ---
>  drivers/dma/dma-jz4780.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 448f663da89c..8beed91428bd 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -879,24 +879,11 @@ static int jz4780_dma_probe(struct=20
> platform_device *pdev)
>  		return -EINVAL;
>  	}
>=20
> -	ret =3D platform_get_irq(pdev, 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	jzdma->irq =3D ret;
> -
> -	ret =3D request_irq(jzdma->irq, jz4780_dma_irq_handler, 0,=20
> dev_name(dev),
> -			  jzdma);
> -	if (ret) {
> -		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
> -		return ret;
> -	}
> -
>  	jzdma->clk =3D devm_clk_get(dev, NULL);
>  	if (IS_ERR(jzdma->clk)) {
>  		dev_err(dev, "failed to get clock\n");
>  		ret =3D PTR_ERR(jzdma->clk);
> -		goto err_free_irq;
> +		return ret;
>  	}
>=20
>  	clk_prepare_enable(jzdma->clk);
> @@ -949,10 +936,23 @@ static int jz4780_dma_probe(struct=20
> platform_device *pdev)
>  		jzchan->vchan.desc_free =3D jz4780_dma_desc_free;
>  	}
>=20
> +	ret =3D platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		goto err_disable_clk;
> +
> +	jzdma->irq =3D ret;
> +
> +	ret =3D request_irq(jzdma->irq, jz4780_dma_irq_handler, 0,=20
> dev_name(dev),
> +			  jzdma);
> +	if (ret) {
> +		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
> +		goto err_disable_clk;
> +	}
> +
>  	ret =3D dmaenginem_async_device_register(dd);
>  	if (ret) {
>  		dev_err(dev, "failed to register device\n");
> -		goto err_disable_clk;
> +		goto err_free_irq;
>  	}
>=20
>  	/* Register with OF DMA helpers. */
> @@ -960,17 +960,17 @@ static int jz4780_dma_probe(struct=20
> platform_device *pdev)
>  					 jzdma);
>  	if (ret) {
>  		dev_err(dev, "failed to register OF DMA controller\n");
> -		goto err_disable_clk;
> +		goto err_free_irq;
>  	}
>=20
>  	dev_info(dev, "JZ4780 DMA controller initialised\n");
>  	return 0;
>=20
> -err_disable_clk:
> -	clk_disable_unprepare(jzdma->clk);
> -
>  err_free_irq:
>  	free_irq(jzdma->irq, jzdma);
> +
> +err_disable_clk:
> +	clk_disable_unprepare(jzdma->clk);
>  	return ret;
>  }
>=20
> --
> 2.17.1
>=20


