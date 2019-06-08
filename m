Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E97539C66
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2019 12:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfFHKX5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 8 Jun 2019 06:23:57 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53618 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFHKX5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 8 Jun 2019 06:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559989433; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJIBROPajbwGD0O0Tb1kIVJrLXMHOBUS1qqiU0qUs7I=;
        b=EEbSk4hSuMyQ45iw2Rfdvv7kIo0I4tdQji5ZlCq8+R80Te/eYGw7Ne624TzHEU1Gze9Io0
        D0vq4ia3hLBfn5s0WHtsRp2fvltlSpDMuC0ZZr/1vXafaF3zNQ6fwy3cYMqLHrcWV118X8
        HDPsDa3FMjOMdImstzzpDFIhgWZ+Fd8=
Date:   Sat, 08 Jun 2019 12:23:49 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dma: jz4780: Make probe function __init_or_module
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, od@zcrc.me
Message-Id: <1559989429.1815.7@crapouillou.net>
In-Reply-To: <20190607160758.16794-1-paul@crapouillou.net>
References: <20190607160758.16794-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I misunderstood what __init_or_module was for. Please ignore this=20
patch. Sorry for the noise.


Le ven. 7 juin 2019 =E0 18:07, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> This allows the probe function to be dropped after the kernel finished
> its initialization, in the case where the driver was not compiled as a
> module.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-jz4780.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 7204fdeff6c5..b2f7e6660ad6 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -815,7 +815,7 @@ static struct dma_chan=20
> *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>  	}
>  }
>=20
> -static int jz4780_dma_probe(struct platform_device *pdev)
> +static int __init_or_module jz4780_dma_probe(struct platform_device=20
> *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	const struct jz4780_dma_soc_data *soc_data;
> @@ -966,7 +966,7 @@ static int jz4780_dma_probe(struct=20
> platform_device *pdev)
>  	return ret;
>  }
>=20
> -static int jz4780_dma_remove(struct platform_device *pdev)
> +static int __exit jz4780_dma_remove(struct platform_device *pdev)
>  {
>  	struct jz4780_dma_dev *jzdma =3D platform_get_drvdata(pdev);
>  	int i;
> --
> 2.21.0.593.g511ec345e18
>=20

=

