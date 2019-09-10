Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39419AE925
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfIJL3g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 07:29:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45162 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfIJL3f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 07:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wgIQgAvUrwptuky0KxuYuEfEm9DxQ/ou+hkqf/1K8sc=; b=pV7lK0yHBFHYmggetiQx0qLE0
        OMLiGbI/uzb/K9cl+jUWdcgv19DNq2VtbJ+Kbqz5b1co5p722filQenw7dIiGRMmPtC9/2Qwomt0D
        LgkSoNPl8svcuZeh72IiVDaPebDneIE5DZIPLIHtJwIoza2I7O3k03NTvSUugVF7X5a2M=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7eKp-0006xV-NC; Tue, 10 Sep 2019 11:29:23 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 131B8D02D76; Tue, 10 Sep 2019 12:29:23 +0100 (BST)
Date:   Tue, 10 Sep 2019 12:29:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Vinod Koul <vkoul@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
        linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 03/10] spi: Guarantee cacheline alignment of
 driver-private data
Message-ID: <20190910112923.GN2036@sirena.org.uk>
References: <cover.1564825752.git.lukas@wunner.de>
 <69faaeb305582ab7dca65fa08635edfa1a39b3fa.1564825752.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HL3CiL6n73+IAdG4"
Content-Disposition: inline
In-Reply-To: <69faaeb305582ab7dca65fa08635edfa1a39b3fa.1564825752.git.lukas@wunner.de>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--HL3CiL6n73+IAdG4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2019 at 12:10:00PM +0200, Lukas Wunner wrote:
> __spi_alloc_controller() uses a single allocation to accommodate struct
>=20
> Reverse the order.  A forthcoming commit leverages this to grant DMA
> access to driver-private data of the BCM2835 SPI master.

That's just shuffling the problem around, the same issues will
then apply to the controller struct and you'll take a performance
penalty on architectures that don't like unaligned accesses.

> An alternative approach would be to round up struct spi_controller to
> cacheline size, at the expense of some wasted memory.

That would seem more logical, or just do two alloacations.  It's
not like we allocate huge numbers of SPI controllers.

--HL3CiL6n73+IAdG4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl13iRIACgkQJNaLcl1U
h9CbxwgAg4jjd1KJdTBT4e6p6KE9w/p5UJ0GGEXa8Jkt7PnhdYsUJY5Q5Qn6X4M9
JDBbkQL60QbtYcHfw8KOSKmpuMOBcERliowOajWGKEGkwMP43u1ebTgVDjuUDAzO
+xqQnUUz9I68js5OOT4Ha67QFwYsPrteM+PHgvt1cf8Lx/JJOXOoNn+FAtUdbGRo
+BNEqIC4uvaPESXbfteHq9YT9gnl2zgHP+wX5Gds10V2tFkmqbDHJ9G61MI5OM0n
d0KQxrL+mEfi35s4RvdUAKAH4OYFVRLLUpsp/cFs/tKsO7sVn1+p1GPALhkpLaRW
I57TaHuRcc9SfYm58Sr03r90Aa9ajg==
=rzgq
-----END PGP SIGNATURE-----

--HL3CiL6n73+IAdG4--
