Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3F07B14D3
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 09:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjI1H1V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjI1H1U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 03:27:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC88DE
        for <dmaengine@vger.kernel.org>; Thu, 28 Sep 2023 00:27:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qllQW-0006Ud-Ot; Thu, 28 Sep 2023 09:27:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qllQW-009We3-8l; Thu, 28 Sep 2023 09:27:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qllQV-005ZeG-VN; Thu, 28 Sep 2023 09:27:11 +0200
Date:   Thu, 28 Sep 2023 09:27:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        Liu Shixin <liushixin2@huawei.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 57/59] dma: xilinx: xilinx_dma: Convert to platform
 remove callback returning void
Message-ID: <20230928072711.k63x7snqdfiholxg@pengutronix.de>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-58-u.kleine-koenig@pengutronix.de>
 <MN0PR12MB59538717A8FEA06243DFFBEFB7FFA@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="miamvuj7headcrln"
Content-Disposition: inline
In-Reply-To: <MN0PR12MB59538717A8FEA06243DFFBEFB7FFA@MN0PR12MB5953.namprd12.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--miamvuj7headcrln
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 22, 2023 at 11:36:50AM +0000, Pandey, Radhey Shyam wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Tuesday, September 19, 2023 7:02 PM
> > To: Vinod Koul <vkoul@kernel.org>
> > Cc: Simek, Michal <michal.simek@amd.com>; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Rob Herring <robh@kernel.org>; Peter
> > Korsgaard <peter@korsgaard.com>; Liu Shixin <liushixin2@huawei.com>;
> > dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > kernel@pengutronix.de
> > Subject: [PATCH 57/59] dma: xilinx: xilinx_dma: Convert to platform rem=
ove
> > callback returning void
> >=20
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart f=
rom
> > emitting a warning) and this typically results in resource leaks.
> > To improve here there is a quest to make the remove callback return voi=
d. In
> > the first step of this quest all drivers are converted to
> > .remove_new() which already returns void. Eventually after all drivers =
are
> > converted, .remove_new() is renamed to .remove().
> >=20
> > Trivially convert this driver from always returning zero in the remove =
callback
> > to the void returning variant.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index 0a3b2e22f23d..0c363a1ed853
> > 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -3245,7 +3245,7 @@ static int xilinx_dma_probe(struct platform_device
> > *pdev)
> >   *
> >   * Return: Always '0'
> >   */
>=20
> Nit - kernel-doc return documentation needs to be updated.

Good catch, I should add that to my pre-send checks. I fixed it in my
tree, so an eventual v2 will be good. I'll wait a bit before resending.

@Vinod: If you pick up this series, feel free to skip this patch or
fixup with=20

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dm=
a.c
index 0c363a1ed853..e40696f6f864 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3242,8 +3242,6 @@ static int xilinx_dma_probe(struct platform_device *p=
dev)
 /**
  * xilinx_dma_remove - Driver remove function
  * @pdev: Pointer to the platform_device structure
- *
- * Return: Always '0'
  */
 static void xilinx_dma_remove(struct platform_device *pdev)
 {

or apply as is (in which case I will follow up with a separate patch to
fix this).

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--miamvuj7headcrln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUVKs8ACgkQj4D7WH0S
/k68SAf9GBgnXxc7o/MD9kSIupTY9sJIOGkkyNmIyVu8ABTmQGB+b/IvO7M2PTaq
A3YVW6Hkvg55vfRtvZfj6xb7g3A+6mLWplpWoDKCBURMic2a472FGlQjF+dOUCUb
mSFWQ3Uz5W2YwSs1/wO/JHRjWXmcx8jRUGAfJ5zcHAh/ekc/Z+ja/hfvNfK57SA4
EUHGXWxKr+L3x2q3z5s/S9vxeEJutVPKNgoa2XpsQplXEi4JTITH/BSIBhtO2e2S
zvhJ2+Ra2HfbbG2RRDapq60gYivNsXQCsT8XrXgHUb27mL9fOtoMJ1N9BXBsuW6m
1qYTCJ9KOXedoikw+WF/4r7NUHCn9w==
=eTXe
-----END PGP SIGNATURE-----

--miamvuj7headcrln--
