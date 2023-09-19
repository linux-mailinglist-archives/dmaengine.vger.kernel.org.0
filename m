Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469C57A6987
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 19:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjISRWN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjISRWM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 13:22:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70461A6
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 10:22:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c1c66876aso749192466b.2
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695144125; x=1695748925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9KCoHYlrD8PBCS/9p9Xtjaer8cxRzRUbZnHNFMvu9U=;
        b=R6PPwdg3V3TdXMBg/mnMsgvrbma8QZB1ug4vsi7ToqdK/MINLwradhQOjdcanrr0v9
         vnTumWDw+9GHwcaoZY//7aVS1R8qi1BBSV2qTRIF3CcJW7Y3wVUYe1Uf+UGEMUY8UNwh
         HFqWUiaBkzW3rUbUoUvufjsCoybe3unZsGbvUHdadsLHnayyjD1KoiaNF5mC19xoE3U2
         32qWYiDpOrk2rFEapLm7mOzSUyj92kOZwRWzbr2KJ+aR6tIiqnP8jpVgLqjoL9ljjYJi
         UCiX8n6b9iucdyphgXRBFDlp2D8dvZnz5BayVewvmDjg/DY+2dM0Go25O4gRt5h6FTxY
         /iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144125; x=1695748925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9KCoHYlrD8PBCS/9p9Xtjaer8cxRzRUbZnHNFMvu9U=;
        b=DZ94YaujWi4r54Ws9uI+8PoWahyCpyvh/7MtERAgkSaoIeUQVpxpivRDh0xdB5qBQd
         r62CP4VtwprXv7K3vKp/g9q2asSViG6cA1Ds9IvXFYFuX88R2FmMYhTjxiM/1+3wRoXi
         sqVRlKpPiG7ChIYd5pHMM7aaYITw+KhWqmvEtvcHZIZ/sPEqH8/Ga0lbll2BE++W/ald
         PvSvChN1X2yOlqpZSxzmsHnmqh9PEvT1oh5bOExtb+T5bm3fJoPSciLrLNgfu2zC5n4/
         6GmyOLcpWysHTYPz6dt8Hw5HKuZV6K7s8mAF1gLMP/225gwzFB6IGPLep0B1Z9yhVsqC
         c8Eg==
X-Gm-Message-State: AOJu0Yww4VFax6tW0cvA7uzGFhktN7Sl2/cjv9qObcCugCKy2kEEkQ4I
        2AysSuv7YKOGsjXQRtP2yZE=
X-Google-Smtp-Source: AGHT+IHHr2iqkML01TMfqpkarox1Q/kZnuOFnlxS2seZbLI5P48153e7+p997Xn/FXR+PMgsoy/vHQ==
X-Received: by 2002:a17:906:1092:b0:9a2:295a:9bbb with SMTP id u18-20020a170906109200b009a2295a9bbbmr52892eju.25.1695144124887;
        Tue, 19 Sep 2023 10:22:04 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id w26-20020a17090633da00b00988be3c1d87sm7947280eja.116.2023.09.19.10.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:22:04 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH 46/59] dma: sun6i-dma: Convert to platform remove callback
 returning void
Date:   Tue, 19 Sep 2023 19:22:03 +0200
Message-ID: <13354858.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20230919133207.1400430-47-u.kleine-koenig@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-47-u.kleine-koenig@pengutronix.de>
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

Dne torek, 19. september 2023 ob 15:31:54 CEST je Uwe Kleine-K=F6nig napisa=
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
>  drivers/dma/sun6i-dma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 2469efddf540..583bf49031cf 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -1470,7 +1470,7 @@ static int sun6i_dma_probe(struct platform_device
> *pdev) return ret;
>  }
>=20
> -static int sun6i_dma_remove(struct platform_device *pdev)
> +static void sun6i_dma_remove(struct platform_device *pdev)
>  {
>  	struct sun6i_dma_dev *sdc =3D platform_get_drvdata(pdev);
>=20
> @@ -1484,13 +1484,11 @@ static int sun6i_dma_remove(struct platform_device
> *pdev) reset_control_assert(sdc->rstc);
>=20
>  	sun6i_dma_free(sdc);
> -
> -	return 0;
>  }
>=20
>  static struct platform_driver sun6i_dma_driver =3D {
>  	.probe		=3D sun6i_dma_probe,
> -	.remove		=3D sun6i_dma_remove,
> +	.remove_new	=3D sun6i_dma_remove,
>  	.driver =3D {
>  		.name		=3D "sun6i-dma",
>  		.of_match_table	=3D sun6i_dma_match,




