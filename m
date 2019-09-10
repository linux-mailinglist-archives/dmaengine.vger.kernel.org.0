Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935AFAE907
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 13:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfIJLWA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 07:22:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60572 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfIJLWA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 07:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A8jI1ZIv+LmFYP1vzv9lG6tX5ecqkv2UQHrZNqgICaY=; b=dPIl1fuiIu1weFgYn+3uwh0O8
        pLimz2nTVd0HWfU/miSaUFibh82uUIv27J/4XrFXS7Gf68tK8WC1IVOIu1Qg0xdO1S3w3ysRv9h0N
        KPAjNZnpkS3w2KTOJYZgutFs+BXUCCCCEesHVDI7UxWA/i24cuuNjePqgo2bTwUhmdvHE=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7eDN-0006st-UN; Tue, 10 Sep 2019 11:21:42 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 4D15CD02D76; Tue, 10 Sep 2019 12:21:41 +0100 (BST)
Date:   Tue, 10 Sep 2019 12:21:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/10] Raspberry Pi SPI speedups
Message-ID: <20190910112141.GM2036@sirena.org.uk>
References: <cover.1564825752.git.lukas@wunner.de>
 <20190907090637.macdahajrzjepluc@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4e5ZDkbgLEOfWmLx"
Content-Disposition: inline
In-Reply-To: <20190907090637.macdahajrzjepluc@wunner.de>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--4e5ZDkbgLEOfWmLx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 07, 2019 at 11:06:37AM +0200, Lukas Wunner wrote:

> Do you have any thoughts on it?  Any objections?

Having found this in the archives something went quite wrong with
the posting, the patches appear to be in a random non-sequential
order:

   20466 N T 08/03 Lukas Wunner    (1.7K) [PATCH 00/10] Raspberry Pi SPI sp=
eedup
   20467 N T 08/03 Lukas Wunner    (2.0K) =E2=94=9C=E2=94=80>[PATCH 02/10] =
dmaengine: bcm2835: A
   20468 N C 08/08 Vinod Koul      (2.2K) =E2=94=82 =E2=94=94=E2=94=80>
   20469 N T 08/03 Lukas Wunner    (1.1K) =E2=94=9C=E2=94=80>[PATCH 01/10] =
dmaengine: bcm2835: A
   20470 N C 08/08 Vinod Koul      (1.3K) =E2=94=82 =E2=94=94=E2=94=80>
   20471 N T 08/03 Lukas Wunner    (3.9K) =E2=94=9C=E2=94=80>[PATCH 04/10] =
spi: bcm2835: Drop dm
   20472 N T 08/03 Lukas Wunner    (3.5K) =E2=94=9C=E2=94=80>[PATCH 05/10] =
spi: bcm2835: Work ar

I have no recollection of what happened with this but I'd expect
it's something to do with that and the lengthy discussion of some
bits.

It also doesn't apply any more, please resend.  In addition it
looks like patch 5 is a fix but it's in the middle of the series
for some reason, in general bug fixes should always be sent as
the first so that they don't depend on anything else.

To repeat what I said in the standard mail please don't send
pings, they're just noise - I can't apply a ping.

--4e5ZDkbgLEOfWmLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl13h0QACgkQJNaLcl1U
h9A88Qf8DlbBpp7DhN7BfjnkCZfaXdor6fBkSrviYSICJL3hOoNfms5mskg0obFQ
NGWU1b1SzZW/bpQd+JK5HZJv/CQWw5mycB+Au0GQFZ4dZuIsU8P9Wm/wHUQx/Zzh
QH6ZSNIHiHDnae8XdE5YhIcZQ/VoA9C9bEC86eewbbZ0JukxAI1KjNh73sBlxfzV
ZvAlI06Tc5xMaX0SDeYc50IyhRYAMPuJq12S/NRwRMW8cMxD1nZIr1rF9eChVfL/
Q4yyX9lxi56w86vVvja1zbpZmh/M4drhbTzKGVu24dIfupo+gfM2tycM+7vavy6t
c+LfMXUKRizF3sFHgtvqaZJosL8Ikg==
=Wc0Y
-----END PGP SIGNATURE-----

--4e5ZDkbgLEOfWmLx--
