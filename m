Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1A3043A8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392378AbhAZQTq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 11:19:46 -0500
Received: from www.zeus03.de ([194.117.254.33]:33048 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392852AbhAZQTd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 11:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=4ZLkDNc++qocydbWdU4zqKsHkW8m
        ct9HExq6tc8OORo=; b=INnAyJ92KMmHxdi7Hxoj4hm7w+9OvwfUMiKBdLFHhsI6
        0ui6fVgvw0WNRhb28XLd6pnlUOVOfMn4Txa5nxk5FkG6KgRYTsx1uXOmDyGIIxTg
        PbF0Qhe8kBAeQmAErYyiF7raKkAN1DPSXmNNWFPsh8bWgPo/MdaupL4T69/PEuY=
Received: (qmail 3781773 invoked from network); 26 Jan 2021 17:18:41 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2021 17:18:41 +0100
X-UD-Smtp-Session: l3s3148p1@mq28AdC5AOUgAwDPXyX1AEdA8SGgn5QT
Date:   Tue, 26 Jan 2021 17:18:36 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dmaengine: rcar-dmac: Add
 for_each_rcar_dmac_chan() helper
Message-ID: <20210126161836.GA928@ninjato>
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20210125142431.1049668-3-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2021 at 03:24:29PM +0100, Geert Uytterhoeven wrote:
> Add and helper macro for iterating over all DMAC channels, taking into
> account the channel mask.  Use it where appropriate, to simplify code.
>=20
> Restore "reverse Christmas tree" order of local variables while adding a
> new variable.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good and works fine with I2C + DMA on V3U:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmAQQNgACgkQFA3kzBSg
KbZsDhAAsC8vs8BUss6fJwgkDZuLlrZvz984Ox/0TUevcI8XmIMEFx5d8uUQ20R5
1n8RyV1bm02lMEsD2cN/+xFPXZXPzvitfSb2l2vtLPHqn6AeDGbNqGQQ7v3dGk6H
hUtakdFePtNhsDVc4kmUmM9XGQN8qxL2hlFXLKGkjF5hZHMlC7e9m2J3+74IAi70
5wiGLtGjNroFwAyFvofd+8NuNrYmQyjyfsaygqQJFNIKBSYKAmVZmN81MWhoYU1w
NLj59QpjkmKeNeP3b2whjoM9c1m54zcaKsERPMAQBoQpKhPfGk5PguOwEWYT8svk
jjOgyqUoIfuPP2KOWsLGlDTmHEfoqQXONjZAQqqoWzF82aq4y/V8hT6mPNb93xIB
Kr4dKji8fVVGBRRoSTGb6EPN1ml3xP69WuxGKiK8ZR2RRKHZ1yj8DcjQGmIxzepD
nIfk6IWobSWATVO5jElElNEfEHZeXjRWh8atVLkfGQdQXu5isDhaVfQbTT+ik/7o
aLcAvi9+GL7YJfnaLWR55EZjpvSpKI+9S9MkCWDX04F9uR+BoHHfFc+UPBNioKzd
VhsH8mxJ+2wPck+0pSelFdxYQRdzbE8kAjiOlc0Gkb3QtDrVXdYlXzx8NHDD1CVG
4V4OEt1ZdIRrEu/oLp9J0fcGbfjrD1qqEkUTgtjdMjPCb+u8pY4=
=MZqC
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
