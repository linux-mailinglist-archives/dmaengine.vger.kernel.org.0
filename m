Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06157B163F
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjI1Iox (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1Iou (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 04:44:50 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D5313A
        for <dmaengine@vger.kernel.org>; Thu, 28 Sep 2023 01:44:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlmdS-0008UJ-69; Thu, 28 Sep 2023 10:44:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlmdR-009XKe-5K; Thu, 28 Sep 2023 10:44:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlmdQ-005ah3-S5; Thu, 28 Sep 2023 10:44:36 +0200
Date:   Thu, 28 Sep 2023 10:44:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     festevam@gmail.com, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>,
        sorganov@gmail.com, kernel@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, dmaengine@vger.kernel.org,
        shawnguo@kernel.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND] serial: imx: Fix potential deadlock on
 sport->port.lock
Message-ID: <20230928084436.fftw5sk4sixaedck@pengutronix.de>
References: <20230927181939.60554-1-dg573847474@gmail.com>
 <20230928060749.qzs6qgcesstclqqk@pengutronix.de>
 <ZRUtZ/M3Ml6ltc2m@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r6y5twzpb32i5htn"
Content-Disposition: inline
In-Reply-To: <ZRUtZ/M3Ml6ltc2m@matsya>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--r6y5twzpb32i5htn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Vinod,

thanks for your quick answer!

On Thu, Sep 28, 2023 at 01:08:15PM +0530, Vinod Koul wrote:
> On 28-09-23, 08:07, Uwe Kleine-K=F6nig wrote:
> > [Cc +=3D Vinod Koul, dmaengine@vger.kernel.org]
> >=20
> > Hello,
> >=20
> > On Wed, Sep 27, 2023 at 06:19:39PM +0000, Chengfeng Ye wrote:
> > > As &sport->port.lock is acquired under irq context along the following
> > > call chain from imx_uart_rtsint(), other acquisition of the same lock
> > > inside process context or softirq context should disable irq avoid do=
uble
> > > lock.
> > >=20
> > > <deadlock #1>
> > >=20
> > > imx_uart_dma_rx_callback()
> > > --> spin_lock(&sport->port.lock)
> > > <interrupt>
> > >    --> imx_uart_rtsint()
> > >    --> spin_lock(&sport->port.lock)
> > >=20
> > > This flaw was found by an experimental static analysis tool I am
> > > developing for irq-related deadlock.
> >=20
> > Ah, I understood before that you really experienced that deadlock (or a
> > lockdep splat). I didn't test anything, but I think the
> > imx_uart_dma_rx_callback() is called indirectly by
> > sdma_update_channel_loop() which is called in irq context. I don't know
> > if this is the case for all dma drivers?!
> >=20
> > @Vinod: Maybe you can chime in here: Is a dma callback always called in
> > irq context?
>=20
> Not in callback but a tasklet context. The DMA irq handler is supposed
> to use a tasklet for invoking the callback

So drivers/dma/imx-sdma.c is bogous as it calls

	-> sdma_int_handler()
	  -> sdma_update_channel_loop()
	    -> dmaengine_desc_get_callback_invoke()

resulting in imx_uart_dma_rx_callback() (and others) being called in irq
context, right?

In that case:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

(for the imx-UART patch that stops assuming imx_uart_dma_rx_callback()
is called with irqs off).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r6y5twzpb32i5htn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUVPPIACgkQj4D7WH0S
/k7vNwgAhb4pKXKJbH9aBhcqanU4xb1tK0/f8VK6sZW0aeeWi7M4Ix1HQFdLg9va
AS2/DwTdV7PHtMX5NJhPkqyUupi2SIJ7fXQo5pkN4p0sHBCzNIYrgpCtvXi/azSC
qKXuOOTw8A9HvoeTKNbKQm6n2Va/AaPORzE/uzZq/m7ni4JHuCSqZMEIzRtJ05/O
m6c2cs6FDkGfPE3B8WRWK4ClF5hFZ7mhdQr118Y8tb/cAQ6eG8BzGNMQJt555Rrn
plV5TSK5mnbmW/B2psEEVmQcBrwZz+vfbsoAvd45B8Lnstey+e9DX+Fmvs8I3Pse
rJmz4QDc2grxnjlCvVSBHtj4jEBOKQ==
=p5nE
-----END PGP SIGNATURE-----

--r6y5twzpb32i5htn--
