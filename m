Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBFF6FB1E3
	for <lists+dmaengine@lfdr.de>; Mon,  8 May 2023 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjEHNni (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 May 2023 09:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjEHNng (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 May 2023 09:43:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7201A489
        for <dmaengine@vger.kernel.org>; Mon,  8 May 2023 06:43:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pw18s-0001YG-LV; Mon, 08 May 2023 15:43:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pw18n-0020ex-GE; Mon, 08 May 2023 15:43:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pw18m-002RT6-Eg; Mon, 08 May 2023 15:43:00 +0200
Date:   Mon, 8 May 2023 15:43:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        Eric Dumazet <edumazet@google.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "Y.B. Lu" <yangbo.lu@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/6] bus: fsl-mc: Make remove function return void
Message-ID: <20230508134300.s36d6k4e25f6ubg4@pengutronix.de>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
 <20230412171056.xcluewbuyytm77yp@pengutronix.de>
 <AM0PR04MB6289BB9BA4BC0B398F2989108F9B9@AM0PR04MB6289.eurprd04.prod.outlook.com>
 <20230413060004.t55sqmfxqtnejvkc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="er5lj4tlfdoxmrvp"
Content-Disposition: inline
In-Reply-To: <20230413060004.t55sqmfxqtnejvkc@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--er5lj4tlfdoxmrvp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Leo,

On Thu, Apr 13, 2023 at 08:00:04AM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Apr 12, 2023 at 09:30:05PM +0000, Leo Li wrote:
> > > On Fri, Mar 10, 2023 at 11:41:22PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > Hello,
> > > >
> > > > many bus remove functions return an integer which is a historic
> > > > misdesign that makes driver authors assume that there is some kind =
of
> > > > error handling in the upper layers. This is wrong however and
> > > > returning and error code only yields an error message.
> > > >
> > > > This series improves the fsl-mc bus by changing the remove callback=
 to
> > > > return no value instead. As a preparation all drivers are changed to
> > > > return zero before so that they don't trigger the error message.
> > >=20
> > > Who is supposed to pick up this patch series (or point out a good rea=
son for
> > > not taking it)?
> >=20
> > Previously Greg KH picked up MC bus patches.
> >=20
> > If no one is picking up them this time, I probably can take it through
> > the fsl soc tree.
>=20
> I guess Greg won't pick up this series as he didn't get a copy of it :-)
>=20
> Browsing through the history of drivers/bus/fsl-mc there is no
> consistent maintainer to see. So if you can take it, that's very
> appreciated.

My mail was meant encouraging, maybe it was too subtile? I'll try again:

Yes, please apply, that would be wonderful!

:-)

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--er5lj4tlfdoxmrvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRY/GMACgkQj4D7WH0S
/k4cswf+N9Mgu+WF1jiKgllTl1eIxkYX2sJ67f9koV32iMjq4Cfyr/EeCWolZb/c
5MfyrMdDe6UXeNzFn/HNTMJ+2Uc+zhRsowOFNHQKu9ysxWqNLnGnr+2Z1B9BSQY+
mK3hhU0iLOWmLRZqQvK4iOKQmoy/jtBUWRIOfmff7fVrmHke3of31J7iZGaVLbEM
uKgAqaUqbuhy/yKnWrtsjI032ANLw3SbE0KBgTIOLsWADSgYqHJVsxs7Ek5vLFy0
yixu653kysPtTS5Jb20ytWk7BzQVMpYFdfq7QogzdL0qYqqrO+oJEGjXP5traHsl
DX2GOiQ8R6tswdZcisDFe4wQC15hYQ==
=19CE
-----END PGP SIGNATURE-----

--er5lj4tlfdoxmrvp--
