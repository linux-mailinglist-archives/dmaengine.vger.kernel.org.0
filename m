Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085AA1F3CB8
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 15:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgFINga (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 09:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgFINga (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jun 2020 09:36:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302F220760;
        Tue,  9 Jun 2020 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591709789;
        bh=Li2Zv/6mZ+A+7R/O4fGGBVAxKZqiekxdMlcIJEyMsuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wvyrDCX2Kyt8XdCcriT/loGbIqItmnhi6dxs74zoVk3ao9QrbLlBuUdzAO7csHcG8
         8J9cfDv4FK0Oazwhr1o1bqrJ4gQgjb60Rw+jFyneV0En2dSvoJSxNOc/LXZ2e7b8hU
         pyoTKOiQHj5Q/qf8HCS3CKeh3ZntT4ycRcBMu3ww=
Date:   Tue, 9 Jun 2020 14:36:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
Message-ID: <20200609133627.GG4583@sirena.org.uk>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
 <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
 <20200608143458.GH4593@sirena.org.uk>
 <VE1PR04MB66388F89015F774EE3FFF69D89850@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200608153139.GI4593@sirena.org.uk>
 <59ce3620-00b9-bac1-30e1-011a29583642@arm.com>
 <VE1PR04MB6638B1EC49D295C64292B7BD89820@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <bcfc3637-65af-577a-ddbd-890b6c83a6e6@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline
In-Reply-To: <bcfc3637-65af-577a-ddbd-890b6c83a6e6@arm.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 11:00:33AM +0100, Robin Murphy wrote:

> Ah, I think I understand what's going on now. That's... really ugly :(

> Looking at the SPI core code, I think a better way to handle this would be
> to have your fallback path call spi_unmap_buf() directly (or perform the
> same actions, if exporting that to drivers is unacceptable), then make su=
re
> ->can_dma() returns false after that such that spi_unmap_msg() won't try =
to
> unmap it again. That's a lot more reasonable than trying to fake up a
> DMA_TO_DEVICE transfer in the middle of a DMA_FROM_DEVICE operation on the
> same buffer.

Ideally the driver would be checking in can_dma() if the DMA controller
is able to perform transactions rather than letting things run as far as=20
trying to actually do the transfer, that's a whole lot cleaner and more
manageable than running into an error doing the transfer.  I'm surprised
that there's no DMA API way to figure this out TBH.

We'll also need some handling for this changing at runtime, we're not
expecting this to be dynamic at all - we're expecting it to be a static
property of the controller/transfer combination, we didn't contemplate
this varying randomly at runtime.  Instead of rechecking can_dma() we
ought to have a flag saying if we did the mapping (which the bodge Robin
suggests above could clear).

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fkFoACgkQJNaLcl1U
h9DtGQgAg3cybc1xp7BBF/QRvws6J4hPoAwnctYQTcfaBVM70lGt4MoQdY+j0ymD
YB6menlav/89t8bYFq7D5gtHajROU0WHsoMpV0MqojMtTOJG+Bo7uALWKblPRuTH
kFOBCkPPZXT/yJGw47VaNlQuvjI/Zh8SlLBzjqMAmkDF9OjNN8ZAp8c2KBihDg8O
YeQZEPlcgtdR/rJlia6YucfA52ZDivjbKaCQIg6hQhiuFU86nxRFqaohBUqxRb5a
SacvLkra2J+oUkr6z/P76+DkFlZ6cQ3hWGuKWIyr89Ie1/4cvuKvahvYfrpgR2ph
rY445Tv19HnK2Aaz0RUu6zumFOa3pA==
=2yHW
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
