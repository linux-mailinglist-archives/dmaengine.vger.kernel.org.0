Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0286668145
	for <lists+dmaengine@lfdr.de>; Sun, 14 Jul 2019 23:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfGNVdK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 14 Jul 2019 17:33:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45192 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfGNVdK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 14 Jul 2019 17:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563139981; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1fCDRzN2PqCzptkf3km6xZGB3O3NlkMkWQ0uvt1B9gE=;
        b=Nd+R17ddiGfZeX48ZASU5rPe8SKwGtKiChFnwGwebfHhV5U/ytRKLAAzYD8ef/FPQxWxrX
        FgvYRe2peKPwAbwxu2XplAYtMU8cK7OSZuTCdKtAWZ0pveyqS+yqkUcsj6XQZpni7XTESo
        w+t6xISIoWubA2arUzW3idJak57NrP4=
Date:   Sun, 14 Jul 2019 17:32:47 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dmaengine: dma-jz4780: Break descriptor chains on JZ4740
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1563139967.2080.0@crapouillou.net>
In-Reply-To: <20190630225249.27369-1-paul@crapouillou.net>
References: <20190630225249.27369-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch makes the driver work on JZ4740 but fail on other SoCs.
Please ignore this patch, I'll make a V2.

Thanks,
-Paul



Le dim. 30 juin 2019 =E0 18:52, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> The current driver works perfectly fine on every generation of the
> JZ47xx SoCs, except on the JZ4740.
>=20
> There, when hardware descriptors are chained together (with the LINK
> bit set), the next descriptor isn't automatically fetched as it=20
> should -
> instead, an interrupt is raised, even if the TIE bit (Transfer=20
> Interrupt
> Enable) bit is cleared. When it happens, the DMA transfer seems to be
> stopped (it doesn't chain), and it's uncertain how many bytes have
> actually been transferred.
>=20
> Until somebody smarter than me can figure out how to make chained
> descriptors work on the JZ4740, we now disable chained descriptors on
> that particular SoC.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-jz4780.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 263bee76ef0d..aae83389cc10 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -92,6 +92,7 @@
>  #define JZ_SOC_DATA_PROGRAMMABLE_DMA	BIT(1)
>  #define JZ_SOC_DATA_PER_CHAN_PM		BIT(2)
>  #define JZ_SOC_DATA_NO_DCKES_DCKEC	BIT(3)
> +#define JZ_SOC_DATA_BREAK_LINKS		BIT(4)
>=20
>  /**
>   * struct jz4780_dma_hwdesc - descriptor structure read by the DMA=20
> controller.
> @@ -356,6 +357,7 @@ static struct dma_async_tx_descriptor=20
> *jz4780_dma_prep_slave_sg(
>  	void *context)
>  {
>  	struct jz4780_dma_chan *jzchan =3D to_jz4780_dma_chan(chan);
> +	struct jz4780_dma_dev *jzdma =3D jz4780_dma_chan_parent(jzchan);
>  	struct jz4780_dma_desc *desc;
>  	unsigned int i;
>  	int err;
> @@ -376,7 +378,8 @@ static struct dma_async_tx_descriptor=20
> *jz4780_dma_prep_slave_sg(
>=20
>  		desc->desc[i].dcm |=3D JZ_DMA_DCM_TIE;
>=20
> -		if (i !=3D (sg_len - 1)) {
> +		if (i !=3D (sg_len - 1) &&
> +		    !(jzdma->soc_data->flags & JZ_SOC_DATA_BREAK_LINKS)) {
>  			/* Automatically proceeed to the next descriptor. */
>  			desc->desc[i].dcm |=3D JZ_DMA_DCM_LINK;
>=20
> @@ -665,6 +668,7 @@ static enum dma_status=20
> jz4780_dma_tx_status(struct dma_chan *chan,
>  static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
>  				struct jz4780_dma_chan *jzchan)
>  {
> +	struct jz4780_dma_desc *desc =3D jzchan->desc;
>  	uint32_t dcs;
>  	bool ack =3D true;
>=20
> @@ -692,8 +696,10 @@ static bool jz4780_dma_chan_irq(struct=20
> jz4780_dma_dev *jzdma,
>=20
>  				jz4780_dma_begin(jzchan);
>  			} else if (dcs & JZ_DMA_DCS_TT) {
> -				vchan_cookie_complete(&jzchan->desc->vdesc);
> -				jzchan->desc =3D NULL;
> +				if (jzchan->curr_hwdesc + 1 =3D=3D desc->count) {
> +					vchan_cookie_complete(&desc->vdesc);
> +					jzchan->desc =3D NULL;
> +				}
>=20
>  				jz4780_dma_begin(jzchan);
>  			} else {
> @@ -994,6 +1000,7 @@ static int jz4780_dma_remove(struct=20
> platform_device *pdev)
>  static const struct jz4780_dma_soc_data jz4740_dma_soc_data =3D {
>  	.nb_channels =3D 6,
>  	.transfer_ord_max =3D 5,
> +	.flags =3D JZ_SOC_DATA_BREAK_LINKS,
>  };
>=20
>  static const struct jz4780_dma_soc_data jz4725b_dma_soc_data =3D {
> --
> 2.21.0.593.g511ec345e18
>=20

=

