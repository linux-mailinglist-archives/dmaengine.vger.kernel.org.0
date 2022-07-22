Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2684257DC40
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jul 2022 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiGVIWF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Jul 2022 04:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiGVIWE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Jul 2022 04:22:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558149E29A
        for <dmaengine@vger.kernel.org>; Fri, 22 Jul 2022 01:22:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEnv4-0000vG-Ok; Fri, 22 Jul 2022 10:21:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEnv3-002Tjo-Us; Fri, 22 Jul 2022 10:21:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEnv3-006l83-BJ; Fri, 22 Jul 2022 10:21:57 +0200
Date:   Fri, 22 Jul 2022 10:21:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dmaengine: sprd: Cleanup in .remove() after
 pm_runtime_get_sync() failed
Message-ID: <20220722082157.fbbwfv4ppsisjqax@pengutronix.de>
References: <20220721204054.323602-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rpv3lpbt7f2dwc4b"
Content-Disposition: inline
In-Reply-To: <20220721204054.323602-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--rpv3lpbt7f2dwc4b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 10:40:54PM +0200, Uwe Kleine-K=F6nig wrote:
> It's not allowed to quit remove early without cleaning up completely.
> Otherwise this results in resource leaks that probably yield graver
> problems later. Here for example some tasklets might survive the lifetime
> of the sprd-dma device and access sdev which is freed after .remove()
> returns.
>=20
> As none of the device freeing requires an active device, just ignore the
> return value of pm_runtime_get_sync().
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

If you want a fixes line, that would be:

Fixes: 9b3b8171f7f4 ("dmaengine: sprd: Add Spreadtrum DMA driver")

but I'm not sure this is critical enough to be backported to stable. So
apply at will.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rpv3lpbt7f2dwc4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLaXiIACgkQwfwUeK3K
7AlBhQgAkytL9CBAGlUL/tUKvkK4TzrD31qI/XORfq50DEBJv0Nd5kj0Nc3LUjUh
0vnSOtGeBoGvij6jaWVmUDqInod5m9tp2KQy4KBgIVeDgQ5kg8Dof0bIw5/I04n9
mjkDAKwki1BWQvkDdPF9n53GlN3qxSmdRYkK+BTudaiXA+MyMba4pbXztJM6ABIV
Gxl3KU1dTL2FY1QKo8DdVRALUgrtOLGmBrLPkBWLwlv8XDy4WSQJXq6tIAN/cDWs
C0Klfiv45zSHcoWTohfQ7w9nFvWUZt/IfqflWzuA/yFzliI1zbnIhhauAF9aT9g+
7UOOfuxP6I7hYCGRIzR1sv2PwGzjnw==
=OdOq
-----END PGP SIGNATURE-----

--rpv3lpbt7f2dwc4b--
