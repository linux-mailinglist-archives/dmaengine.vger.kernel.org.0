Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7755375EC31
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jul 2023 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGXHJU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jul 2023 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXHJT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jul 2023 03:09:19 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22C6138;
        Mon, 24 Jul 2023 00:09:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C2E524000E;
        Mon, 24 Jul 2023 07:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690182552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0OTdgWQ6Vo/4tl1ZM7En0YdjITPLKGIP2IIxkkPFJRM=;
        b=iC5ZIY44VFrCSUNoeMIdYmOyqSrlrW7N4tyY+Hq53oXBVph3jCQ5ij8fsDynsYh6NybKfF
        47iBUwR964ggu52YB13yaU1E18wok2aDQAXdbpXfZnCVzqeybMcvNBEm04M8MJv49vz912
        60p20TKBhztddQMV6EZbSo0vTLzFb3Ok+FWErn92iDiDFjDyPmqRh1JKdYw5xT3hwpwVlV
        u4k2GthKUnBFuRNrRP/XoPSerupU1HIaiVySzO/QpWk35FaiLI3dwdIhQ2brWGTyOPPUCM
        8E3/Ier83smwYkYCv/LsZ20OWFpB5I2g8A5epoX659Pa/Omr3Rckh60nqnZ+5A==
Date:   Mon, 24 Jul 2023 09:09:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     nikita.shubin@maquefel.me,
        Hartley Sweeten <hsweeten@visionengravers.com>,
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
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
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
Subject: Re: [PATCH v3 24/42] mtd: nand: add support for ts72xx
Message-ID: <20230724090902.679ea56d@xps-13>
In-Reply-To: <ZLqx+Osn3gcHjUph@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
        <20230605-ep93xx-v3-24-3d63a5f1103e@maquefel.me>
        <ZLqx+Osn3gcHjUph@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

> > +static int ts72xx_nand_attach_chip(struct nand_chip *chip)
> > +{
> > +	switch (chip->ecc.engine_type) {
> > +	case NAND_ECC_ENGINE_TYPE_SOFT:
> > +		if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN)
> > +			chip->ecc.algo =3D NAND_ECC_ALGO_HAMMING;
> > +		break;
> > +	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> > +		return -EINVAL;
> > +	default: =20
>=20
> > +		break; =20
>=20
> Here it will return 0, is it a problem?

Seems ok, there are two other situations: on-die ECC engine and no ECC
engine, both do not require any specific handling on the controller
side.

>=20
> > +	}
> > +
> > +	return 0;
> > +} =20
>=20
> ...
>=20
> > +static void ts72xx_nand_remove(struct platform_device *pdev)
> > +{
> > +	struct ts72xx_nand_data *data =3D platform_get_drvdata(pdev);
> > +	struct nand_chip *chip =3D &data->chip;
> > +	int ret;
> > +
> > +	ret =3D mtd_device_unregister(nand_to_mtd(chip)); =20
>=20
> > +	WARN_ON(ret); =20
>=20
> Why?!  Is it like this in other MTD drivers?

Yes, we did not yet change the internal machinery to return void, and
we don't want people to think getting errors there is normal.

> > +	nand_cleanup(chip);
> > +} =20
>=20

Thanks,
Miqu=C3=A8l
