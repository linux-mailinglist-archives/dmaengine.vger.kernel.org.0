Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBEB530219
	for <lists+dmaengine@lfdr.de>; Sun, 22 May 2022 11:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiEVJiz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 May 2022 05:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiEVJiz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 22 May 2022 05:38:55 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAAD3B3C9;
        Sun, 22 May 2022 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1653212330; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hqD/oZcjT9FRYsqGzFInG5WgvxzOftyg0RKNFC2ww7o=;
        b=FVSK1Pm7oLYN4Wygr8ewEmceAFkGgywZlcIA5rYPRgcOqvVobezKziIRP+8oU6I21fMzJ+
        e5xUZi4NU6pLs0TdZwDKNxSpX5+I6QnnjY7iWEGooa+9Hop9/35vL00vPqwQPytPSAod+y
        1qfQH1dR9utKidirmQMyikHPURajoD8=
Date:   Sun, 22 May 2022 10:38:41 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dmaengine: jz4780: fix typo in comment
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <HS2ACR.CGG9DJPX3OD31@crapouillou.net>
In-Reply-To: <20220521111145.81697-20-Julia.Lawall@inria.fr>
References: <20220521111145.81697-20-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Julia,

Le sam., mai 21 2022 at 13:10:30 +0200, Julia Lawall=20
<Julia.Lawall@inria.fr> a =E9crit :
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Thanks!
-Paul

>=20
> ---
>  drivers/dma/dma-jz4780.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index e2ec540e6519..2a483802d9ee 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -388,7 +388,7 @@ static struct dma_async_tx_descriptor=20
> *jz4780_dma_prep_slave_sg(
>=20
>  		if (i !=3D (sg_len - 1) &&
>  		    !(jzdma->soc_data->flags & JZ_SOC_DATA_BREAK_LINKS)) {
> -			/* Automatically proceeed to the next descriptor. */
> +			/* Automatically proceed to the next descriptor. */
>  			desc->desc[i].dcm |=3D JZ_DMA_DCM_LINK;
>=20
>  			/*
>=20


