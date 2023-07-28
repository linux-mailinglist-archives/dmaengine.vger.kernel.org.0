Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B04A7666F5
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jul 2023 10:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjG1IZJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jul 2023 04:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjG1IYb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jul 2023 04:24:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D95C49C2;
        Fri, 28 Jul 2023 01:23:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so2211975e87.3;
        Fri, 28 Jul 2023 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690532612; x=1691137412;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0xhbAiUbjd2h8hrbYvNKZ3J3fpbP+0wJ7Vc6YuSc5c=;
        b=jrdmr35Ma2osjBpAw3b9zN2kpLkQsvLEfbCx5UHTMTNqBNBjhTPut7YAnI1ip2Me9E
         yzozyIliQB4+szgNhW0g0Q4bblCOsZLbMn4ryQ95yGJCoL71J5dZ42Q3M2xBLvGVTNPp
         LcyNALkje5B3N3kOTp2uN8zdRm7YP7l6y4qwUPR4u9PL8kKPH3sKDTUnYikFKf8ptMsq
         YU1jL/0+FPTbtIWCnpf3Tbek+0YJvm2JFtIgL9QUnlg6OqEfX6FF3e2xh1CCKQo2r81+
         hrKsVO1ierOOMs4LcFnOlzmEcHpJSZYhMstv5dGnsH0pXMmC2Y7WpIGZ1x6muN8i1vm7
         qoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532612; x=1691137412;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0xhbAiUbjd2h8hrbYvNKZ3J3fpbP+0wJ7Vc6YuSc5c=;
        b=KSIRjIfu6lXfXAt3R8zmjPTMOgzO5rWvNdVUxYEKFmj7B5NOy4lLBwKxzLCIlQNiHW
         WFMtInuRb4Co7VwJGQONgaHbtvkdQHMpOiOYWrweIGJxPKuSbzFVVlypXOBBQYeEEskX
         JiGKOdXp6xGbfwWlnX+cZqAv9G4AQAIdnCJGc6A8mFRvNjRJCW4qAjOd5ZROekhfte79
         /0yRQftJJnIBpzFv4AW5KdlvaOsaDZOcBIP8VwAwoAixZOh0FoK6aMCIeb1rPx98pRNj
         xK7g22WcQAisIa53A2UZaenjK1u947b8C4YGejK1TdrUcfE4pDO8qNS/Gl1Lea/8DhSv
         QB+g==
X-Gm-Message-State: ABy/qLboI3a2GQMc2UjPA2oG5Nuf3xgsIorWzLP2L6U0lsYxvYuCaPGw
        3/7tCxlA1A2yYPEYxJXpqFQ=
X-Google-Smtp-Source: APBJJlFYN35PMSaGWFsU7bOEaiX1P6f6+mU/fUJluxRlPtCVWghClcGBDgOqdbqj5ReW0PmnIoHbWg==
X-Received: by 2002:a05:6512:3256:b0:4fb:9e1a:e592 with SMTP id c22-20020a056512325600b004fb9e1ae592mr1042977lfr.4.1690532612150;
        Fri, 28 Jul 2023 01:23:32 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p17-20020aa7d311000000b005224f840130sm1528577edq.60.2023.07.28.01.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:23:31 -0700 (PDT)
Date:   Fri, 28 Jul 2023 10:23:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 37/42] pwm: ep93xx: drop legacy pinctrl
Message-ID: <ZMN7AQozKJ-WvEtD@orome>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-37-3d63a5f1103e@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wGJHzmMJDSXZkkT2"
Content-Disposition: inline
In-Reply-To: <20230605-ep93xx-v3-37-3d63a5f1103e@maquefel.me>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--wGJHzmMJDSXZkkT2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 02:29:37PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Drop legacy gpio request/free since we are using
> pinctrl for this now.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-ep93xx/core.c       | 42 ---------------------------------=
------
>  drivers/pwm/pwm-ep93xx.c          | 18 -----------------
>  include/linux/soc/cirrus/ep93xx.h |  4 ----
>  3 files changed, 64 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--wGJHzmMJDSXZkkT2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTDewAACgkQ3SOs138+
s6Fe1xAAmWGPXd//baY5gEQfFUeoZOB6tksL9wdhNTccZsdUbLbxDijfBzSgF8LC
4mvLpGWCiVebT2hMwacsnHquq26aZ3xvnlVRB/0ic5Y2kxa86bm12Y4pBsVjTSJJ
G4lOWY+DsW30C6I5FsCrnXfk0WQBj41lSHodIBmwHL9qac0hyJfTytGObyLB5oiF
ac/Jss8xCi9FzacqnbKVCcWJQp070a/ptFCyXiXkc5sCZUii5eVbVyvjNvvuxUml
BBdPYMMs4C+kocreEgCn7FI6anxgJ+IpqdxtMTwxUmocdA93Fif8XS75ystxbrRv
SN0WMNlM6br95MU2Y/M0B21LivCfGu4PMreELcuoabHDN+TJwZk3AJzv6dv1hmhb
Yy5Ptu2ZrR8xaV5LnHv1sDI5+RxSp1Pvt0Y8ap5MDHQDuL5oyzqBPVhhtPijSy1J
qTZ3+vNGJAHWTGl5o748veQ8cu5tAdKANos5DSk1ihUcgdjopOrNVbAwpbStloRb
1XGCOp8jBHitHVIibWOzq1iYX39CGqTR4IGzoPaE4vC7MwbJ/3gHxfMoyVLwpuEj
+XLcWlwcAfKINSGGx4yLHXAJF0bUbwHwom7p61rS8GeN0FCzkMO8ydTI6ZTh06lj
sMd10ehwOllaHRNRjzZ8l3IozZoq+jDoPJPkeDuS8lTmKu2PKNk=
=Y8RN
-----END PGP SIGNATURE-----

--wGJHzmMJDSXZkkT2--
