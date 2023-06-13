Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D6872DDAE
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbjFMJar (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjFMJap (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 05:30:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3B6B7
        for <dmaengine@vger.kernel.org>; Tue, 13 Jun 2023 02:30:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q90Lx-0003DC-Vz; Tue, 13 Jun 2023 11:30:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q90Lw-0075fp-Ff; Tue, 13 Jun 2023 11:30:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q90Lv-00DpVq-G7; Tue, 13 Jun 2023 11:30:15 +0200
Date:   Tue, 13 Jun 2023 11:30:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
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
Message-ID: <20230613093014.sot4l2kihnkkx3o5@pengutronix.de>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-6-stefan.wahren@i2se.com>
 <20230607075602.s2pfs7dl7fwkyevm@pengutronix.de>
 <20230609215932.GA2531610-robh@kernel.org>
 <3b868924-9d9c-ae0a-a7b8-0afbd01c4a4b@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q34rb5xucwxwl2gk"
Content-Disposition: inline
In-Reply-To: <3b868924-9d9c-ae0a-a7b8-0afbd01c4a4b@i2se.com>
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


--q34rb5xucwxwl2gk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 11:02:40AM +0200, Stefan Wahren wrote:
> Hi,
>=20
> Am 09.06.23 um 23:59 schrieb Rob Herring:
> > On Wed, Jun 07, 2023 at 09:56:02AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Hello,
> > >=20
> > > On Sun, Jun 04, 2023 at 02:12:18PM +0200, Stefan Wahren wrote:
> > > > Convert the DT binding document for pwm-bcm2835 from .txt to YAML.
> > >=20
> > > Both dt_binding_check and dtbs_check (for ARCH=3Darm) are happy, apart
> > > from errors like:
> > >=20
> > > arch/arm/boot/dts/bcm2711-rpi-4-b.dtb: pwm@7e20c000: #pwm-cells:0:0: =
3 was expected
> > >          From schema: Documentation/devicetree/bindings/pwm/pwm-bcm28=
35.yaml
> > >=20
> > > which is fixed in patch #6. So:
> > >=20
> > > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > >=20
> > > Who will pick up this patch? Is it supposed to go in via pwm or
> > > arm/broadcom? (I suggest the latter.)
> >=20
> > The default is the subsystem (pwm). Why not here?
>=20
> i think Uwe's concern is about the fact, that the series is late in cycle.
> So the chance that the fixing DTS patch 6 miss Linux 6.5 is very high.

My concern is only that nobody might feel responsible and think the
other party will pick up. Thierry didn't pick up patches yet for the
next merge window (or I missed it), so I guess it's not yet to late for
going in via pwm.

I suggest to let it go in via the arm/broadcom tree, to have the whole
series together.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--q34rb5xucwxwl2gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSINyUACgkQj4D7WH0S
/k7ZDQf/cfElfv6yePm9EHQQdztYHh3IO4c1+a3mYiV4paMsOf7dNK8samM5rkwG
qR+VEGxcdHYUgNLhqwu4KLj8WqQrk9myA9/WKZIAlL8fOhfuFYwEBTbunRG12ocC
8zMfwPNwLa/15vEcQjYNcJqUOxxt3LTIfJwQI/rbycLrjUy7uhx/zz1nL0vhR4PN
75KD5ihTsHVxDRQM7RSNjZ/GjXl/9AC+amWFKoUJ9DGGmrx8/eQDkipqAtgPHeGu
DxsSWmBqlodiGo6mr8BdLJFaGqYGGIJBAhvXgfFOqpObxy6xS6S1YSUzeMY/ztm7
DaJyM4EnXxL2LWbTGlBz4IrAf49BNA==
=jtkA
-----END PGP SIGNATURE-----

--q34rb5xucwxwl2gk--
