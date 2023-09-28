Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3B7B1257
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 08:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjI1GIU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 02:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjI1GIS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 02:08:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934D99
        for <dmaengine@vger.kernel.org>; Wed, 27 Sep 2023 23:08:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlkBi-0004RI-IP; Thu, 28 Sep 2023 08:07:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlkBh-009VzQ-G9; Thu, 28 Sep 2023 08:07:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlkBh-005YUC-6U; Thu, 28 Sep 2023 08:07:49 +0200
Date:   Thu, 28 Sep 2023 08:07:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        sorganov@gmail.com, festevam@gmail.com,
        ilpo.jarvinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH RESEND] serial: imx: Fix potential deadlock on
 sport->port.lock
Message-ID: <20230928060749.qzs6qgcesstclqqk@pengutronix.de>
References: <20230927181939.60554-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f7bog4b3txnbhuoj"
Content-Disposition: inline
In-Reply-To: <20230927181939.60554-1-dg573847474@gmail.com>
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


--f7bog4b3txnbhuoj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc +=3D Vinod Koul, dmaengine@vger.kernel.org]

Hello,

On Wed, Sep 27, 2023 at 06:19:39PM +0000, Chengfeng Ye wrote:
> As &sport->port.lock is acquired under irq context along the following
> call chain from imx_uart_rtsint(), other acquisition of the same lock
> inside process context or softirq context should disable irq avoid double
> lock.
>=20
> <deadlock #1>
>=20
> imx_uart_dma_rx_callback()
> --> spin_lock(&sport->port.lock)
> <interrupt>
>    --> imx_uart_rtsint()
>    --> spin_lock(&sport->port.lock)
>=20
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.

Ah, I understood before that you really experienced that deadlock (or a
lockdep splat). I didn't test anything, but I think the
imx_uart_dma_rx_callback() is called indirectly by
sdma_update_channel_loop() which is called in irq context. I don't know
if this is the case for all dma drivers?!

@Vinod: Maybe you can chime in here: Is a dma callback always called in
irq context?

If yes, this patch isn't needed. Otherwise it might be a good idea to
not use the special knowledge and switch to spin_lock_irqsave() as
suggested.

> To prevent the potential deadlock, the patch uses spin_lock_irqsave()
> on the &sport->port.lock inside imx_uart_dma_rx_callback() to prevent
> the possible deadlock scenario.
>=20
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

If we agree this patch is a good idea, we can add:

Fixes: 496a4471b7c3 ("serial: imx: work-around for hardware RX flood")

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f7bog4b3txnbhuoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUVGDQACgkQj4D7WH0S
/k6Msgf+Nch+utVGLzdo/mRgW9Bdxbi16a03vlH2nAu50axg2kKLy3gztudaYrlj
QarLJ7u8TsOWzkU+EP6ye3ubFGhApV/7ne+/QUeEdQmkuz8LHf35pk3+dCKenhkC
NN2+l08DUIM/+uwjD2ESMQM2M/Td9fW+9PsMKgLNiiIlE/ZA5tOOGbSU6UUoS5uv
R9BdzUY2c5/a3ANnyf/c9A2Df+yqoLcMBUXrhnoAXJSflSf3Z2GYTv7FyHotLJb5
c4D6cClkyrMeGJ1VmgTTVOcz35ZDIhkprc4Q/SmqPj9IiuejavBjPmjJHNG1rcV3
6zS7jDlI0tgIqSoz8PnJLK3AJzluTQ==
=CCkc
-----END PGP SIGNATURE-----

--f7bog4b3txnbhuoj--
