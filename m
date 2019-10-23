Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93512E202B
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407030AbfJWQId (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 12:08:33 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55278 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407029AbfJWQIc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 12:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1571846907; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRZB4Hmo5/AC64REY0JMNENCt0f2esO31XyLdZy2uFQ=;
        b=JYXpuEAAsoua8tBu2BljyqX08TmjmJrKr9tmjqGwvlUXK+4INzM7BKtakhifYk9LGFTzjo
        8Vsh3TYUCWV6UK5pMpQtPq7n4kkA9/MPpx7u8AFEN8XgDRiRQ0fWvf/FTOTK3ho3gOYWGE
        P+i8TVlHeb8OrSciyk8RaH53ka7KHw0=
Date:   Wed, 23 Oct 2019 18:08:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH RESEND 2/2] dmaengine: JZ4780: Add support for the X1000.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, vkoul@kernel.org,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Message-Id: <1571846901.3.0@crapouillou.net>
In-Reply-To: <1571814137-46002-3-git-send-email-zhouyanjie@zoho.com>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
        <1571814137-46002-1-git-send-email-zhouyanjie@zoho.com>
        <1571814137-46002-3-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Zhou,


Le mer., oct. 23, 2019 at 15:02, Zhou Yanjie <zhouyanjie@zoho.com> a=20
=E9crit :
> Add support for probing the dma-jz4780 driver on the X1000 Soc.
>=20
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  drivers/dma/dma-jz4780.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index cafb1cc0..f809a6e 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -1019,11 +1019,18 @@ static const struct jz4780_dma_soc_data=20
> jz4780_dma_soc_data =3D {
>  	.flags =3D JZ_SOC_DATA_ALLOW_LEGACY_DT | JZ_SOC_DATA_PROGRAMMABLE_DMA,
>  };
>=20
> +static const struct jz4780_dma_soc_data x1000_dma_soc_data =3D {
> +	.nb_channels =3D 8,
> +	.transfer_ord_max =3D 7,
> +	.flags =3D JZ_SOC_DATA_ALLOW_LEGACY_DT | JZ_SOC_DATA_PROGRAMMABLE_DMA,

Please don't use JZ_SOC_DATA_ALLOW_LEGACY_DT for new bindings.

With that flag removed:
Reviewed-by: Paul Cercueil <paul@crapouillou.net>


> +};
> +
>  static const struct of_device_id jz4780_dma_dt_match[] =3D {
>  	{ .compatible =3D "ingenic,jz4740-dma", .data =3D &jz4740_dma_soc_data=20
> },
>  	{ .compatible =3D "ingenic,jz4725b-dma", .data =3D=20
> &jz4725b_dma_soc_data },
>  	{ .compatible =3D "ingenic,jz4770-dma", .data =3D &jz4770_dma_soc_data=20
> },
>  	{ .compatible =3D "ingenic,jz4780-dma", .data =3D &jz4780_dma_soc_data=20
> },
> +	{ .compatible =3D "ingenic,x1000-dma", .data =3D &x1000_dma_soc_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
> --
> 2.7.4
>=20
>=20

=

