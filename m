Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AF73043CA
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 17:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392842AbhAZQ0h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 11:26:37 -0500
Received: from www.zeus03.de ([194.117.254.33]:35132 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390801AbhAZQ0Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 11:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Xqs1mtjaC3nVZ+Jiv8DQnPtyMH32
        zxsqqXVsjiZLZ4M=; b=O3xUFAq9kmMnUmXFuiX6D6aJL8zxM3+INUWh1huJwjvQ
        bXwC96aEOrz8/4yntpUaDUAiEIfc7CCi3nAblU6htd3hTiXLJPj3olX0iEYwzXJz
        0AVRHKqFho3n1b8nedkQj1jrfttYDusi0+kfjuOFfzOmjcArf+Gg+wxzmL2Dsv4=
Received: (qmail 3783984 invoked from network); 26 Jan 2021 17:25:34 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2021 17:25:34 +0100
X-UD-Smtp-Session: l3s3148p1@IoeUGtC5KuUgAwDPXyX1AEdA8SGgn5QT
Date:   Tue, 26 Jan 2021 17:25:33 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Message-ID: <20210126162533.GC928@ninjato>
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20210125142431.1049668-5-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2021 at 03:24:31PM +0100, Geert Uytterhoeven wrote:
> The DMACs (both SYS-DMAC and RT-DMAC) on R-Car V3U differ slightly from
> the DMACs on R-Car Gen2 and other R-Car Gen3 SoCs:
>   1. The per-channel registers are located in a second register block.
>      Add support for mapping the second block, using the appropriate
>      offsets and stride.
>   2. The common Channel Clear Register (DMACHCLR) was replaced by a
>      per-channel register.
>      Update rcar_dmac_chan_clear{,_all}() to handle this.
>      As rcar_dmac_init() needs to clear the status before the individual
>      channels are probed, channel index and base address initialization
>      are moved forward.
>=20
> Inspired by a patch in the BSP by Phong Hoang
> <phong.hoang.wz@renesas.com>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Apporach looks good, didn't check the gory details. However, it still
works fine with I2C + DMA on V3U, so:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmAQQn0ACgkQFA3kzBSg
KbZi4w/9Eeda53xRTs5EXMmbccCC/SLtFJBLKhFFO0GyoiQxmU4OrFfnrL60vcJ1
WCc3uJBPIf20FKLwOIt8b+lXotJalWh6aCl4iZj7BgeKSNdPNkBjtqcCMR0nQBbg
Ps33xRRhp8pO0r1K91o37GnW/NKWYTshUz9loB4j/OCpiIob4tiBb/hTRLNJ3loI
x3RgLCi7269RqC47cq+T+VbNk8ftbzWBXEcFTT5+We+Enr2qPM58XRSXRgZv79NI
/ChfzGotu5KHUrxQPPknyb9+OCmG7RM6g+AOxiYjBy3jk51IoW+tZxhrjliAkktI
+C/+PPbtwAocwLgTKJwQMzU6XUoXaeqPgHRpoCfl4ZXMnbsoObYwtD82SoTjZUCM
nkEvzt9FHN6/xd5WTZscHmSXGY7sVmM6I83chFNzcfukv9/iIV7SSWbN8ir3ashL
SYeUB6yrgk2Br3UpufdS8/Ptddmq6WlXWStSoBloUukB+WEvyK9D6uWJfIKW1655
Ny5y11hrhmPdRmVFnZbbfcEMq3tLM+06jj8+VuenlNTg9in6IqEQFaqo+nzesfWZ
q+Dtr30W3Qptp/ktWLHUiEHqKC2Ww09O6y5pJfBpGEzgJpblhqJP6XMv/42RKKYV
zzUEnGFsgtnwXgWAzEmmWanoXDmiMYP0PyvP7gzJS9OjF7c2hB0=
=6eRP
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
