Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47DF725693
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jun 2023 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjFGH4p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Jun 2023 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbjFGH4o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Jun 2023 03:56:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D29011D
        for <dmaengine@vger.kernel.org>; Wed,  7 Jun 2023 00:56:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6o1s-0006EZ-6H; Wed, 07 Jun 2023 09:56:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6o1r-005gwN-7f; Wed, 07 Jun 2023 09:56:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6o1q-00BwhG-Dh; Wed, 07 Jun 2023 09:56:26 +0200
Date:   Wed, 7 Jun 2023 09:56:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 06/10] ARM: dts: bcm283x: Increase pwm-cells
Message-ID: <20230607075626.l4r6s4iv2c53oqvf@pengutronix.de>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-7-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nkfzq4xvfsjk34rv"
Content-Disposition: inline
In-Reply-To: <20230604121223.9625-7-stefan.wahren@i2se.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--nkfzq4xvfsjk34rv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 04, 2023 at 02:12:19PM +0200, Stefan Wahren wrote:
> The pwm-bcm2835 supports PWM polarity, so adjust the affected dtsi
> files accordingly and fix the dtbs_check warning:
>=20
> pwm@7e20c000: #pwm-cells:0:0: 3 was expected
>=20
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/bcm2711.dtsi | 2 +-
>  arch/arm/boot/dts/bcm283x.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.d=
tsi
> index 83745672a120..239db6927a02 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -278,7 +278,7 @@ pwm1: pwm@7e20c800 {
>  			clocks =3D <&clocks BCM2835_CLOCK_PWM>;
>  			assigned-clocks =3D <&clocks BCM2835_CLOCK_PWM>;
>  			assigned-clock-rates =3D <10000000>;
> -			#pwm-cells =3D <2>;
> +			#pwm-cells =3D <3>;
>  			status =3D "disabled";
>  		};
> =20
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.d=
tsi
> index c9c52a19ef3b..2ca8a2505a4d 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -416,7 +416,7 @@ pwm: pwm@7e20c000 {
>  			clocks =3D <&clocks BCM2835_CLOCK_PWM>;
>  			assigned-clocks =3D <&clocks BCM2835_CLOCK_PWM>;
>  			assigned-clock-rates =3D <10000000>;
> -			#pwm-cells =3D <2>;
> +			#pwm-cells =3D <3>;
>  			status =3D "disabled";
>  		};

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nkfzq4xvfsjk34rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSAOCkACgkQj4D7WH0S
/k6UBggAgvayeHLsrs/QoH0DThdI444unR+mI44HOrHaaDTf7fYE12Wau1a8aMHi
7ufoNYuDfJIrjLNgQFkeIKpwJvqoJAam9AH52lVzWLXrIbtz00Obv5JewRtCCqty
TJeR3/uMGa1sm7vETs3cdiJgvguI5pH9P3+L0rXONt9VupIu4fvKFRrLUHuroJ2c
vUjQDerbAfxqxyCbs4Tkocptsq3eqiVANJGBXcu+V6Vi4DKJ3BAWChMM4jMSwwv4
tJd3Y7RFK+DXZs/9mhY57S3xDLUEeTLcu2mUmNbsje6YhhyPa68QQ/Ffs8eCKA8T
rtyYA4Z0UiM7KKfVeGZa354PnmjpyA==
=KQux
-----END PGP SIGNATURE-----

--nkfzq4xvfsjk34rv--
