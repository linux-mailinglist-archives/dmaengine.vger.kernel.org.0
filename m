Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE82A64253A
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 09:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiLEI67 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 03:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiLEI6H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 03:58:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5FB17E3E
        for <dmaengine@vger.kernel.org>; Mon,  5 Dec 2022 00:56:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p27Gz-00065M-Gc; Mon, 05 Dec 2022 09:56:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p27Gw-002QBr-3u; Mon, 05 Dec 2022 09:56:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p27Gw-002hzv-68; Mon, 05 Dec 2022 09:56:22 +0100
Date:   Mon, 5 Dec 2022 09:56:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     kernel@pengutronix.de, Arnd Bergmann <arnd@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-next@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        dmaengine@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>
Subject: Re: Regression in dmaengine/next was removed
Message-ID: <20221205085622.75yyfztkahmrlrz4@pengutronix.de>
References: <20221021203329.4143397-14-arnd@kernel.org>
 <20221118215401.505480-1-u.kleine-koenig@pengutronix.de>
 <f0425349-d965-0a40-0672-27dfbe45eb44@linaro.org>
 <b759a3e7-7a45-3dc9-14ba-8b01da798f10@linaro.org>
 <20221125085117.23p7yv6wgo6b5l3v@pengutronix.de>
 <7f5cf3d8-4a3b-41eb-fed9-1ade4ba1e4e2@linaro.org>
 <20221202112003.kanwr7bixbaiqdgz@pengutronix.de>
 <Y4nkvT+R8t6eGrWj@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7eoiblj4p2fvpvxp"
Content-Disposition: inline
In-Reply-To: <Y4nkvT+R8t6eGrWj@matsya>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--7eoiblj4p2fvpvxp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Vinod,

On Fri, Dec 02, 2022 at 05:12:53PM +0530, Vinod Koul wrote:
> On 02-12-22, 12:20, Uwe Kleine-K=F6nig wrote:
> > I made the subject a bit more expressive.

I wonder what I intended to write there, something like "Regression in
dmaengine/next in arm/s3c2410_defconfig", sorry to make it look as if
you already fixed the regression :-)

> > On Fri, Nov 25, 2022 at 09:52:51AM +0100, Krzysztof Kozlowski wrote:
> > > On 25/11/2022 09:51, Uwe Kleine-K=F6nig wrote:
> > > > On Sun, Nov 20, 2022 at 12:22:31PM +0100, Krzysztof Kozlowski wrote:
> > > >> On 20/11/2022 11:31, Krzysztof Kozlowski wrote:
> > > >>> On 18/11/2022 22:54, Uwe Kleine-K=F6nig wrote:
> > > >>>> The linux/platform_data/dma-s3c24xx.h header file was removed. I=
t didn't
> > > >>>> declare or define any symbol needed in devs.c though, so the #in=
clude
> > > >>>> can just be dropped.
> > > >>>>
> > > >>>> Fixes: cccc46ae3623 ("dmaengine: remove s3c24xx driver")
> > > >>>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.d=
e>
> > > >>>> ---
> > > >>>
> > > >>> The file was not removed... or it should not have been yet. The s=
3c24xx
> > > >>> dma driver removal should be part of Arnd series taken via SoC AR=
M.
> > > >=20
> > > > The patch enters next with the merge of
> > > >=20
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git =
next
> > > >=20
> > > > Ah, the patch that became cccc46ae3623 (i.e. patch #14) is part of a
> > > > bigger series. Its patch #1 removes s3c24xx.c (which you pointed ou=
t to be still
> > > > broken) and patch #2 includes the change I suggested here.
> > > >=20
> > > >> I think that commit should be just dropped instead.
> > > >=20
> > > > +1
> > > >=20
> > > > BTW, cccc46ae3623 is included in next since next-20221107 and breaks
> > > > (at least) arm/s3c2410_defconfig. So I would consider reverting
> > > > cccc46ae3623 a fix. (Added linux-next to Cc:)
> > >=20
> > > Yes. The build failure of next was reported already by kernel test ro=
bot.
> > >=20
> > > Vinod, can we drop this patch?
> >=20
> > That patch is still contained in the next tags of this week. :-(
>=20
> Apologies for delay, I was moving...
>=20
> I have reverted and pushed now

Thanks!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7eoiblj4p2fvpvxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmONsjMACgkQwfwUeK3K
7AmXSwf/VZuQ2FjkiIN+56r+5b4pEZ6q5pmktLnS0zhETdeXoiKfbQl2nRhk8YOk
DKhMlUpD5jGS4r5PXYhct9n10dSquwOQDSrDRtf3HO2VTroTREEJ48vEjOkpu7TY
th0TIWt/ZoXjfASyFi8Vpx7Y26Mi6rye9pLZk96FLiYGCfTX5G0ygi1/Fh4uMUeY
teQIqSUg7C1hN56rYP37btxYBehUlhWmxW3P+rLGUYT+ZPGvsEXWv0K2XIajrPTd
pKr+xmec6C2GuHsc3EN0YtPITdrHGBC9RTrMaC8XDXKaGYVAEEYzueSCTCTvcRQ5
sDUzioR2cnq37vyUneeVlX043ZBszA==
=9QGH
-----END PGP SIGNATURE-----

--7eoiblj4p2fvpvxp--
