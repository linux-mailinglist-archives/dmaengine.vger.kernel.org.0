Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC43324BA12
	for <lists+dmaengine@lfdr.de>; Thu, 20 Aug 2020 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHTL7x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Aug 2020 07:59:53 -0400
Received: from crapouillou.net ([89.234.176.41]:45940 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730471AbgHTL7h (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 20 Aug 2020 07:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597924774; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kB2wGLDuU6aSHvN4xthqcKsE4uQqughcC0pSUs3BWBU=;
        b=prx1avjqa0Ec51djNOI7gQDIPqvrOlAPUI7yPDnkvY580F1LFMbGawsak00Ou/nO9a0UWN
        3d3DtzU5B+oepNoiQrT4clwIKAnw4yO/pMifbAFDcAFpXOvjJHAPknTYYFM6wOlYa5kq+P
        NdU8DgqFntO9IBnHFyjFnr+Qa13EEtk=
Date:   Thu, 20 Aug 2020 13:59:23 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drivers/dma/dma-jz4780: Fix race condition between probe
 and irq handler
To:     madhuparnabhowmik10@gmail.com
Cc:     dan.j.williams@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org
Message-Id: <ZM2DFQ.KQQJYLJ02WTD3@crapouillou.net>
In-Reply-To: <20200816072253.13817-1-madhuparnabhowmik10@gmail.com>
References: <20200816072253.13817-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Le dim. 16 ao=FBt 2020 =E0 12:52, madhuparnabhowmik10@gmail.com a =E9crit :
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>=20
> In probe IRQ is requested before zchan->id is initialized which can be
> read in the irq handler. Hence, shift request irq and enable clock=20
> after
> other initializations complete. Here, enable clock part is not part of
> the race, it is just shifted down after request_irq to keep the error
> path same as before.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

I don't think there is a race at all, the interrupt handler won't be=20
called before the DMA is registered.

More importantly, this patch will break things, as there are now=20
register writes in the probe before the clock is enabled.

Cheers,
-Paul

> ---
>  drivers/dma/dma-jz4780.c | 44=20
> ++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 448f663da89c..5cbc8c3bd6c7 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -879,28 +879,6 @@ static int jz4780_dma_probe(struct=20
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
> -	jzdma->clk =3D devm_clk_get(dev, NULL);
> -	if (IS_ERR(jzdma->clk)) {
> -		dev_err(dev, "failed to get clock\n");
> -		ret =3D PTR_ERR(jzdma->clk);
> -		goto err_free_irq;
> -	}
> -
> -	clk_prepare_enable(jzdma->clk);
> -
>  	/* Property is optional, if it doesn't exist the value will remain=20
> 0. */
>  	of_property_read_u32_index(dev->of_node,=20
> "ingenic,reserved-channels",
>  				   0, &jzdma->chan_reserved);
> @@ -949,6 +927,28 @@ static int jz4780_dma_probe(struct=20
> platform_device *pdev)
>  		jzchan->vchan.desc_free =3D jz4780_dma_desc_free;
>  	}
>=20
> +	ret =3D platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	jzdma->irq =3D ret;
> +
> +	ret =3D request_irq(jzdma->irq, jz4780_dma_irq_handler, 0,=20
> dev_name(dev),
> +			  jzdma);
> +	if (ret) {
> +		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
> +		return ret;
> +	}
> +
> +	jzdma->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(jzdma->clk)) {
> +		dev_err(dev, "failed to get clock\n");
> +		ret =3D PTR_ERR(jzdma->clk);
> +		goto err_free_irq;
> +	}
> +
> +	clk_prepare_enable(jzdma->clk);
> +
>  	ret =3D dmaenginem_async_device_register(dd);
>  	if (ret) {
>  		dev_err(dev, "failed to register device\n");
> --
> 2.17.1
>=20


