Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D021EF7AB
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 10:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfKEJBV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 04:01:21 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:45378 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfKEJBV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Nov 2019 04:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1572944478; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8eGloal3wFITROlsa+3+OEoqn/01a4l5HxLb1IPvlI=;
        b=muXT0KAne3fIchktcCiubXpRWz4RTA2/K59EnXVeQ2SNYowo2Y8cbMixJGV6Jr9xWQ0y/r
        56HBfxGMi2gH5qR6sRobiRUam9LGOJFHtMJFBdHru0/89gXcxkNI399MluwpRfCgNPnyi0
        LacMIwU4owZQyTYmQUCuz8EpSHT67zo=
Date:   Tue, 05 Nov 2019 10:01:12 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dmaengine: dma-jz4780: add missed clk_disable_unprepare
 in remove
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1572944472.3.0@crapouillou.net>
In-Reply-To: <20191104161622.11758-1-hslester96@gmail.com>
References: <20191104161622.11758-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,


Le mar., nov. 5, 2019 at 00:16, Chuhong Yuan <hslester96@gmail.com> a=20
=E9crit :
> The remove misses to disable and unprepare jzdma->clk.
> Add a call to clk_disable_unprepare to fix it.
>=20
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Thanks.


> ---
>  drivers/dma/dma-jz4780.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index cafb1cc065bb..66ab76b9520f 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -987,6 +987,7 @@ static int jz4780_dma_remove(struct=20
> platform_device *pdev)
>=20
>  	of_dma_controller_free(pdev->dev.of_node);
>=20
> +	clk_disable_unprepare(jzdma->clk);
>  	free_irq(jzdma->irq, jzdma);
>=20
>  	for (i =3D 0; i < jzdma->soc_data->nb_channels; i++)
> --
> 2.23.0
>=20

=

