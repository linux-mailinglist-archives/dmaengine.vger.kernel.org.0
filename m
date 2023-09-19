Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F947A6986
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjISRVz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 13:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjISRVv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 13:21:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70932A6
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 10:21:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401da71b83cso66857095e9.2
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695144104; x=1695748904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCW05DYPpdGYyJU3IE/oUGPdifsWeWp895tHny3FRl8=;
        b=PnLtgkKzX+77cWXvPnQUrvOjw2HC7xMxpMZYcQdkCZSqTMMttH69nbnmEjs7Dc1f12
         IZWQLGlq8FGv20+SrTGOoETTPZLbVl8w5xSgphRQt9k2npUyeLxQAaW/iVogQW8gD/vx
         n1YaZ+CtPHOV39kq0IOnCtqq28yHjVbmAlG1TyP15axQiiHhhHJuShqUdB4BYWy5iSiv
         BuZviN+LdWOubtFRvGrFQkR+83JcMCo36ddkN4J7Hd5/sfjU9MmoprFL4M9DXlCWP81A
         VEi2JmmL4r1mIJxMAfuKeWpksdKCcYK+wmag0l3mgoM1tr0bcXQFmdrXsh4zQJ2CcU2h
         hEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144104; x=1695748904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCW05DYPpdGYyJU3IE/oUGPdifsWeWp895tHny3FRl8=;
        b=DwZB8M/R8fINxjD4dckGR7N9thT5HRjSTMmPMXk05/HYRJ4h6/yysa7rW447iiAVRK
         aBvg6H9w6vJOxR5iOALH553cH2sRYe/AGkcSo6XowODjqSPy0Y1xJlmXJ0DES27fAjY4
         eFU0Etbii56dk515FITNFKnKOJBIw48y1Hp8ecV8jrAA/vd2bAPfr8IvQS+drE1YHeZQ
         SbLmA7zqC54uNNalkIkY1rOWX6bZxsvDnWA07AVIO9a0ZKvULRlg7BIwtEZ+KRBh2j2b
         nU6CHI9kbsytO2KHjyaQV5U1shNNQQrljGU08Al5/fgM53/xuczZQasDAwDhHOO62+oy
         u4FA==
X-Gm-Message-State: AOJu0YzHstZF2zoMbJyldp7Baznd/D4dQ833A/baY7pQchv4+pQQ8/8m
        1rAXNLwntS46bytYNDZtk78=
X-Google-Smtp-Source: AGHT+IH2Km3ubh0lb33ebM1eHNMAYyqIfJqNboXqNuS/MKTzpkoELMt5NJJdos3JsfqGyHZjA2EDMA==
X-Received: by 2002:adf:e506:0:b0:319:8bb3:ab83 with SMTP id j6-20020adfe506000000b003198bb3ab83mr226937wrm.66.1695144103504;
        Tue, 19 Sep 2023 10:21:43 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id kg11-20020a17090776eb00b009a1a653770bsm8078550ejc.87.2023.09.19.10.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:21:43 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH 45/59] dma: sun4i-dma: Convert to platform remove callback
 returning void
Date:   Tue, 19 Sep 2023 19:21:41 +0200
Message-ID: <1868017.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20230919133207.1400430-46-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-46-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dne torek, 19. september 2023 ob 15:31:53 CEST je Uwe Kleine-K=F6nig napisa=
l(a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/dma/sun4i-dma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index e86c8829513a..2e7f9b07fdd2 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -1271,7 +1271,7 @@ static int sun4i_dma_probe(struct platform_device
> *pdev) return ret;
>  }
>=20
> -static int sun4i_dma_remove(struct platform_device *pdev)
> +static void sun4i_dma_remove(struct platform_device *pdev)
>  {
>  	struct sun4i_dma_dev *priv =3D platform_get_drvdata(pdev);
>=20
> @@ -1282,8 +1282,6 @@ static int sun4i_dma_remove(struct platform_device
> *pdev) dma_async_device_unregister(&priv->slave);
>=20
>  	clk_disable_unprepare(priv->clk);
> -
> -	return 0;
>  }
>=20
>  static const struct of_device_id sun4i_dma_match[] =3D {
> @@ -1294,7 +1292,7 @@ MODULE_DEVICE_TABLE(of, sun4i_dma_match);
>=20
>  static struct platform_driver sun4i_dma_driver =3D {
>  	.probe	=3D sun4i_dma_probe,
> -	.remove	=3D sun4i_dma_remove,
> +	.remove_new =3D sun4i_dma_remove,
>  	.driver	=3D {
>  		.name		=3D "sun4i-dma",
>  		.of_match_table	=3D sun4i_dma_match,




