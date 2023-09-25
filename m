Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9034E7AD462
	for <lists+dmaengine@lfdr.de>; Mon, 25 Sep 2023 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjIYJUU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Sep 2023 05:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjIYJUT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Sep 2023 05:20:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF8C0
        for <dmaengine@vger.kernel.org>; Mon, 25 Sep 2023 02:20:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkhl7-0007eZ-Cq; Mon, 25 Sep 2023 11:20:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkhl6-008pnP-Tm; Mon, 25 Sep 2023 11:20:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkhl6-004dPf-Jc; Mon, 25 Sep 2023 11:20:04 +0200
Date:   Mon, 25 Sep 2023 11:20:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tim van der Staaij | Zign <Tim.vanderstaaij@zigngroup.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix deadlock in interrupt handler
Message-ID: <20230925092004.natij4i364yupevi@pengutronix.de>
References: <AM0PR08MB30897429213E8DB9BCC1D6C880F8A@AM0PR08MB3089.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3vziazxi4g3jfqf6"
Content-Disposition: inline
In-Reply-To: <AM0PR08MB30897429213E8DB9BCC1D6C880F8A@AM0PR08MB3089.eurprd08.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--3vziazxi4g3jfqf6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 21, 2023 at 09:57:11AM +0000, Tim van der Staaij | Zign wrote:
> dev_warn internally acquires the lock that is already held when
> sdma_update_channel_loop is called. Therefore it is acquired twice and
> this is detected as a deadlock. Temporarily release the lock while
> logging to avoid this.
>=20
> Signed-off-by: Tim van der Staaij <tim.vanderstaaij@zigngroup.com>
> Link: https://lore.kernel.org/all/AM0PR08MB308979EC3A8A53AE6E2D3408802CA@=
AM0PR08MB3089.eurprd08.prod.outlook.com/
> ---
>  drivers/dma/imx-sdma.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 51012bd39900..3a7cd783a567 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -904,7 +904,10 @@ static void sdma_update_channel_loop(struct sdma_cha=
nnel *sdmac)
>  	 * owned buffer is available (i.e. BD_DONE was set too late).
>  	 */
>  	if (sdmac->desc && !is_sdma_channel_enabled(sdmac->sdma, sdmac->channel=
)) {
> +		spin_unlock(&sdmac->vc.lock);
>  		dev_warn(sdmac->sdma->dev, "restart cyclic channel %d\n", sdmac->chann=
el);
> +		spin_lock(&sdmac->vc.lock);
> +

I don't know if Sascha's patch helps, but this patch looks definitively
wrong. If this was the right approach (and I doubt it is) this
would definitively lack an explaining code comment.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3vziazxi4g3jfqf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmURUMIACgkQj4D7WH0S
/k56XQf/Z4tp5E2PnPCbZXqG6hnW84LB48sTntvzlHjgepkXNBivI0Ww08OVuvp7
6t6LyqUXpkh574B8mlTO29Pc1G095CmbvdOE3/CrrHh8gLbUCOgIBTefPG6xqE7C
cPKGpwUxJ2PzxyP0GJA1pEyFLi4Dh9Bj1cLjjZdKQPL926Wf24RpgDMN4DsUpNjw
L7kVsO/kCs7bopTZHnGNmuEE7yMz2UTSQeJ8tF9Kfl0vuoWFXT0njUVl7B1JABsM
N8Rbo5fudyeu9+PeBf964B8jHc5hAbF1TLDrIo36QGEB4GnG9v+6SBrwcgfb9kVi
WKCB91+hVfqHn3+AlA3pRfxrpHOuKw==
=Jqzd
-----END PGP SIGNATURE-----

--3vziazxi4g3jfqf6--
