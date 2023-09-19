Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD457A6738
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjISOsd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjISOsd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 10:48:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDBEC9
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 07:48:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qic1Y-000412-AJ; Tue, 19 Sep 2023 16:48:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qic1X-007Tkb-SD; Tue, 19 Sep 2023 16:48:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qic1X-0031nB-Ie; Tue, 19 Sep 2023 16:48:23 +0200
Date:   Tue, 19 Sep 2023 16:48:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-mips@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 09/59] dma: dma-jz4780: Convert to platform remove
 callback returning void
Message-ID: <20230919144822.yepo3eq3tmptllqv@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-10-u.kleine-koenig@pengutronix.de>
 <7554150cb8b097a84133524df9fd05e70707b6ce.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lzkeeqrbsjhowzsb"
Content-Disposition: inline
In-Reply-To: <7554150cb8b097a84133524df9fd05e70707b6ce.camel@crapouillou.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--lzkeeqrbsjhowzsb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 03:39:10PM +0200, Paul Cercueil wrote:
> Hi Uwe,
>=20
> Le mardi 19 septembre 2023 =E0 15:31 +0200, Uwe Kleine-K=F6nig a =E9crit=
=A0:
> > The .remove() callback for a platform driver returns an int which
> > makes
> > many driver authors wrongly assume it's possible to do error handling
> > by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource
> > leaks.
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new() which already returns void. Eventually after all
> > drivers
> > are converted, .remove_new() is renamed to .remove().
>=20
> "is renamed" -> "will be renamed"?

I guess you're right here. I fixed that in my template, but I won't
resend this series (and the others with the same issue) for now.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lzkeeqrbsjhowzsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUJtLUACgkQj4D7WH0S
/k7S1Af/cUM7DlWIsad70QoNd9BpSiK/TK4UD8Uo+SmV1ztuonT3Lgub0tHMdyr1
oGXzCw4zOnULEJln0w6vMlkSOx1ZTmSlTJ2j1bv/paV6d+0CZzq1dcJgap3cPCKM
R3BRcY5u3lMjhBW6GmK+wSOoKB3y3Z7KnWw7voVWCACIzpVFVWUBt+KNIlwWB26N
c2XDAHQmDkGOjRDuF8koOrlbjDb6Sef21fxQKVz5Vs7zKvRklDfpTWNF9IhQqBUx
ElrK3qq+gEklJJfTFycKpdvl0TZsL7vXWQUq55HSVqZIMuwXMdgOZ00h38lChCH1
J2xq0VQKfgUvG0IiA/rGSXWBBY61/Q==
=U4lt
-----END PGP SIGNATURE-----

--lzkeeqrbsjhowzsb--
