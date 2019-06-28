Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0730159CBB
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 15:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfF1NOM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 09:14:12 -0400
Received: from sauhun.de ([88.99.104.3]:50872 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfF1NOM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Jun 2019 09:14:12 -0400
Received: from localhost (p54B332FA.dip0.t-ipconnect.de [84.179.50.250])
        by pokefinder.org (Postfix) with ESMTPSA id E3CFB2C35BF;
        Fri, 28 Jun 2019 15:14:09 +0200 (CEST)
Date:   Fri, 28 Jun 2019 15:14:09 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        "George G . Davis" <george_davis@mentor.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix .flush_buffer() issues
Message-ID: <20190628131409.GD1458@ninjato>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190626173434.GA24702@x230>
 <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
 <20190628123907.GA10962@vmlxhi-102.adit-jv.com>
 <20190628125534.GB1458@ninjato>
 <20190628130200.GA11231@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20190628130200.GA11231@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I am doing this per-patch to allow patchwork to reflect the status of
> each patch on the linux-renesas-soc front-page. AFAIK patchwork ignores
> series-wide '*-by: Name <email>' signatures/tags.

AFAIK, yes.

Thanks!


--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0WEqEACgkQFA3kzBSg
KbY3KxAAol+tj9vY1pw+ygeHJqJVjisfXmzKP3Qx7rD3wy+I1oEKd/wYdL00jZB0
7525vYJh18H3+LTXQhnWIs0ypSaA/C61n88thIpS+ppCdSq5Dm7nV1q0oin/fNlY
axvmdUp+4y9NRkS2wECy11pQWm4dRgo9F/hglml2O2d9T3Nw6UoFifRSndZ7Bxyi
fbAQQ0D5N73TMnMb8UQRNCynS0AAR6SDn4mz0AKGfmiUH3vImPt6zFzORi2cjJmJ
a9RDuBOa3vRmcjKKFulrX2XaSY2cet9uTyVzoH8s8f12LySG4lfGSF1jvl5PV8Ga
c4s5Jq8JOsT1ByViTO2WNqmxFrxNjTfMpH2yqDpAa/KCWuq+TdkDOAMbINlarHqg
pd7zqW5HYDzA/1CAH1EwhUiwtkevcQ+OT/v4Lw+W8kOAjYbRSDlo4zicTZjpcdbW
w8ge2iSxz91wLhm/OTwvDN71GdjfKmz/RFIpv9P38j4QO8GR8J5eHLcZB1bZoenl
PK32hzLzpnFsJX5udVpshWvyV5A2dTmO7FTX4DnUBvPHEbpq1OOd1IxEHp2uR7if
9MjQq9bmn1D5McMidQ6QRdJR7KEqXrJzhI1//kBeesaEsYGDohCdExvkhxkmpUGG
B+jZgl/nzty2ZgHh/7wflJg7/ofjyvW8G3z6sFCA9peL2mEqO5Y=
=jpwd
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
