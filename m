Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8602463858B
	for <lists+dmaengine@lfdr.de>; Fri, 25 Nov 2022 09:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKYIvw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Nov 2022 03:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiKYIvq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Nov 2022 03:51:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216CD31EE2
        for <dmaengine@vger.kernel.org>; Fri, 25 Nov 2022 00:51:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oyUQe-0008Qt-8q; Fri, 25 Nov 2022 09:51:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oyUQX-000Bz1-Gz; Fri, 25 Nov 2022 09:51:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oyUQX-000FZX-M5; Fri, 25 Nov 2022 09:51:17 +0100
Date:   Fri, 25 Nov 2022 09:51:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, kernel@pengutronix.de,
        linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dmaengine@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] ARM: s3c: Fix a build error after the s3c24xx dma driver
 was removed
Message-ID: <20221125085117.23p7yv6wgo6b5l3v@pengutronix.de>
References: <20221021203329.4143397-14-arnd@kernel.org>
 <20221118215401.505480-1-u.kleine-koenig@pengutronix.de>
 <f0425349-d965-0a40-0672-27dfbe45eb44@linaro.org>
 <b759a3e7-7a45-3dc9-14ba-8b01da798f10@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="esiizevgytu3ebii"
Content-Disposition: inline
In-Reply-To: <b759a3e7-7a45-3dc9-14ba-8b01da798f10@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--esiizevgytu3ebii
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Nov 20, 2022 at 12:22:31PM +0100, Krzysztof Kozlowski wrote:
> On 20/11/2022 11:31, Krzysztof Kozlowski wrote:
> > On 18/11/2022 22:54, Uwe Kleine-K=F6nig wrote:
> >> The linux/platform_data/dma-s3c24xx.h header file was removed. It didn=
't
> >> declare or define any symbol needed in devs.c though, so the #include
> >> can just be dropped.
> >>
> >> Fixes: cccc46ae3623 ("dmaengine: remove s3c24xx driver")
> >> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >> ---
> >=20
> > The file was not removed... or it should not have been yet. The s3c24xx
> > dma driver removal should be part of Arnd series taken via SoC ARM.

The patch enters next with the merge of

	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next

Ah, the patch that became cccc46ae3623 (i.e. patch #14) is part of a
bigger series. Its patch #1 removes s3c24xx.c (which you pointed out to be =
still
broken) and patch #2 includes the change I suggested here.

> I think that commit should be just dropped instead.

+1

BTW, cccc46ae3623 is included in next since next-20221107 and breaks
(at least) arm/s3c2410_defconfig. So I would consider reverting
cccc46ae3623 a fix. (Added linux-next to Cc:)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--esiizevgytu3ebii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOAggIACgkQwfwUeK3K
7AlqoQf+KRbGDmlQGJTMMKxkt2L3KLegKVD+jLC7UDsLNb0hvIZfNNT+rHssdKoT
ECq3d0DiK74j5sRtBthgpx3HXMMv5Pu8KgdCNFctiqrfKHugthsaVUNCoEx3Y6cN
JUfGERyytyAduNPLUzUNS79ANWeVpZ2z9lIYwbDZpdcwLp8JY2RFSfvIqU25l8ug
3S+e+/NXj37PgCkgvyp8DWbcEoRpNrHLmpaXivhayf3D//0MYa6kdGM0Xejdtw0T
an5yLUFEdndcRBpp0t9yWh/M83/xTJZ9ndcp8RZMjEVdcBedKpPo/UyO4K+sWQFp
hfWyBh44QeIwv64XfzGst+xJRoGOuw==
=WdqC
-----END PGP SIGNATURE-----

--esiizevgytu3ebii--
