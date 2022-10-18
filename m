Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83131603493
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiJRVDS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 17:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJRVDQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 17:03:16 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41E457BFD;
        Tue, 18 Oct 2022 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666126967; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hm2vibk7Nws+cwH2D661vnMd4Ktzez2ut5ZPSrOfgLw=;
        b=D/CwAwX3TpCrbczLRmoIbaT8xeRBIeoOVtnJTh2Z9eowd9F57Xw5Mu8PPWG71PUb/HGb8m
        1EUiCwxnMeEXWmv0wqTElv7rD4NWl9m0q8+kbW5jjO+Xi5KpmQYpnyk4mB84EHjaZzzdhe
        OTEPYEtvkhPgM2j6+EOLlkG3KPCU6pM=
Date:   Tue, 18 Oct 2022 22:02:37 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/2] dmaengine: JZ4780: Add support for the JZ4755.
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <DSVYJR.6R2II2D52YQ5@crapouillou.net>
In-Reply-To: <20221018181219.3251309-3-lis8215@gmail.com>
References: <20221018181219.3251309-1-lis8215@gmail.com>
        <20221018181219.3251309-3-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Siarhei,

Le mar., oct. 18 2022 at 21:12:19 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =E9crit :
> The JZ4755 has 4 DMA channels per DMA unit, two idential DMA units.
>=20
> The JZ4755 has the similar DMA engine to JZ4725b and it has the
> same bug as JZ4725b, see commit a40c94be2336.
> At least the JZ_SOC_DATA_BREAK_LINKS flag make it work much better,
> although not ideal.
>=20
> Tested-by: Siarhei Volkau <lis8215@gmail.com>
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>

You forgot my tag that I added on your V2.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/dma/dma-jz4780.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 2a483802d..9c1a6e9a9 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -1038,6 +1038,13 @@ static const struct jz4780_dma_soc_data=20
> jz4725b_dma_soc_data =3D {
>  		 JZ_SOC_DATA_BREAK_LINKS,
>  };
>=20
> +static const struct jz4780_dma_soc_data jz4755_dma_soc_data =3D {
> +	.nb_channels =3D 4,
> +	.transfer_ord_max =3D 5,
> +	.flags =3D JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC |
> +		 JZ_SOC_DATA_BREAK_LINKS,
> +};
> +
>  static const struct jz4780_dma_soc_data jz4760_dma_soc_data =3D {
>  	.nb_channels =3D 5,
>  	.transfer_ord_max =3D 6,
> @@ -1101,6 +1108,7 @@ static const struct jz4780_dma_soc_data=20
> x1830_dma_soc_data =3D {
>  static const struct of_device_id jz4780_dma_dt_match[] =3D {
>  	{ .compatible =3D "ingenic,jz4740-dma", .data =3D &jz4740_dma_soc_data=20
> },
>  	{ .compatible =3D "ingenic,jz4725b-dma", .data =3D=20
> &jz4725b_dma_soc_data },
> +	{ .compatible =3D "ingenic,jz4755-dma", .data =3D &jz4755_dma_soc_data=20
> },
>  	{ .compatible =3D "ingenic,jz4760-dma", .data =3D &jz4760_dma_soc_data=20
> },
>  	{ .compatible =3D "ingenic,jz4760-mdma", .data =3D=20
> &jz4760_mdma_soc_data },
>  	{ .compatible =3D "ingenic,jz4760-bdma", .data =3D=20
> &jz4760_bdma_soc_data },
> --
> 2.36.1
>=20


