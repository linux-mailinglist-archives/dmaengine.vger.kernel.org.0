Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124AA72568A
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jun 2023 09:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjFGH41 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Jun 2023 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjFGH40 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Jun 2023 03:56:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE70E79
        for <dmaengine@vger.kernel.org>; Wed,  7 Jun 2023 00:56:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6o1V-000699-Pn; Wed, 07 Jun 2023 09:56:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6o1T-005gwG-6s; Wed, 07 Jun 2023 09:56:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6o1S-00Bwh7-GJ; Wed, 07 Jun 2023 09:56:02 +0200
Date:   Wed, 7 Jun 2023 09:56:02 +0200
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
Subject: Re: [PATCH 05/10] dt-bindings: pwm: convert pwm-bcm2835 bindings to
 YAML
Message-ID: <20230607075602.s2pfs7dl7fwkyevm@pengutronix.de>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-6-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lyuxia23pum2phqj"
Content-Disposition: inline
In-Reply-To: <20230604121223.9625-6-stefan.wahren@i2se.com>
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


--lyuxia23pum2phqj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jun 04, 2023 at 02:12:18PM +0200, Stefan Wahren wrote:
> Convert the DT binding document for pwm-bcm2835 from .txt to YAML.

Both dt_binding_check and dtbs_check (for ARCH=3Darm) are happy, apart
=66rom errors like:

arch/arm/boot/dts/bcm2711-rpi-4-b.dtb: pwm@7e20c000: #pwm-cells:0:0: 3 was =
expected
        From schema: Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml

which is fixed in patch #6. So:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Who will pick up this patch? Is it supposed to go in via pwm or
arm/broadcom? (I suggest the latter.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lyuxia23pum2phqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSAOBEACgkQj4D7WH0S
/k4w2Qf/THJ6pslrb8HwoYlT3z4Xn2MagNVHuNgc00ChJFQ2ZijLk5hnXxwVOXVg
hIj81DGnNyr+INajGYLHCxPIxwzV1wXJpdI2rj2nysvZB3d74v95qhibjiiUQz5P
GOy4EQrbYBAx/UZLGv+qoOf1xIzoUnYmgRZr2LcNBbW2o1ttHOMMjK6wh8ov4ARo
a9livwubMJDy/L00KdyVZ/BfZ0UN+qi8X5fF9PjP19OUgQCTnjYCJBsm0NIFdX0E
ta3UQwJngoKQ3z2kvRc5ouyq3lVCIi5xZ+4dXJB5KO5ZglOTNgS+IM2DybJt9u5D
AAGPigBN9yAoSJpaDGdylqO8ktDP/w==
=nlpC
-----END PGP SIGNATURE-----

--lyuxia23pum2phqj--
