Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2C59C21
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfF1Mzh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 08:55:37 -0400
Received: from sauhun.de ([88.99.104.3]:50692 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfF1Mzh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Jun 2019 08:55:37 -0400
Received: from localhost (p54B332FA.dip0.t-ipconnect.de [84.179.50.250])
        by pokefinder.org (Postfix) with ESMTPSA id 029B82C35BF;
        Fri, 28 Jun 2019 14:55:34 +0200 (CEST)
Date:   Fri, 28 Jun 2019 14:55:34 +0200
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
Message-ID: <20190628125534.GB1458@ninjato>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190626173434.GA24702@x230>
 <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
 <20190628123907.GA10962@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20190628123907.GA10962@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > If a serial port is used as a console, the port is used for both DMA
> > (normal use) and PIO (serial console output).  The latter can have a
> > negative impact on the former, aggravating existing bugs, or triggering
> > more races, even in the hardware.  So I think it's better to be more
> > cautious and keep DMA disabled for the console.
>=20
> Thanks for the extensive and comprehensible replies.
> No more questions from my end.
> Looking forward to picking the patches from vanilla/stable trees.

If you could formally add such a tag:

Tested-by: <your email>

(maybe also Acked-by: or Reviewed-by:, dunno if you think it is
apropriate)

to the patches, this would be much appreciated and will usually speed up
the patches getting applied.

Thanks for your help!


--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0WDkIACgkQFA3kzBSg
KbYwxg//eqNbjfZIVe+MKaB8at3n680u6qn8/woFxTmDLiJjpMQiL3tDRrwf4mCY
7KbrgGM6dRiQZzCu70YpUWBIu2WnKk6fyHasi6gAaEtWEh9CEXFxhdtsuek8g3oi
bHlINoU6WJi2ntoW2HyW2o9f9jEJ8yM6imwQFOxnh73kdzwP36Iv2umMNnE6Xv1D
z31sHgI/0eA3TddHAZ6vMLT1S3/YaogSLY8GQRlEEGap4vEvHD5V6Od6mgWgJuHj
s3bXnM9XCOjrjkHDJRE6r6CZQBd36fYl8B0tF7qbdwjxbM43LDSAbYLJGOof5sdB
Z3/5Mi7vBekBRG3X5FRbhHhb+mE5IWXoXALWv/ZjVPz5kgZ9zEoqE4qZxOqwCpGQ
tnZoAcycOsAmpX1AIQq0iw1KnHtLwfSDuBwi9CiKv6OL/FoBQu0m3F8I/fdSpNyF
rodpn4MTfTa8ybHTDKhJAd5vRNyV8ullhDotUkv+VIJ/4dw+fzlrV1SUmlEd4VJu
1L2mWxU9hvAOV8DB5z719D5l5GbDG/adUh5KHVZGM0DdtCPcHX718FZufW61oqmA
bR/yzqYn56nsIyWg125Su+YdWPQLtitjJqYPNc5oNOTMJOeexpZzqBzaYoQMJfLJ
zZJOGCmzekY7l95fpEOEyMB2ysO4X7Xp+zpZsYzQ0IeDOJBRtBc=
=BrYw
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
