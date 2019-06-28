Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D653E59C2D
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfF1M5y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 08:57:54 -0400
Received: from sauhun.de ([88.99.104.3]:50752 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfF1M5y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Jun 2019 08:57:54 -0400
Received: from localhost (p54B332FA.dip0.t-ipconnect.de [84.179.50.250])
        by pokefinder.org (Postfix) with ESMTPSA id B48AC2C35BF;
        Fri, 28 Jun 2019 14:57:52 +0200 (CEST)
Date:   Fri, 28 Jun 2019 14:57:52 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Reject zero-length slave DMA
 requests
Message-ID: <20190628125752.GC1458@ninjato>
References: <20190624123818.20919-1-geert+renesas@glider.be>
 <20190626181459.GA31913@x230>
 <CAMuHMdUpPEdz3aDXo90XQ7b-jP2ErxwqLKgmEFUhhuB-oBzrDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUpPEdz3aDXo90XQ7b-jP2ErxwqLKgmEFUhhuB-oBzrDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > [..]
> > > -     if (rchan->mid_rid < 0 || !sg_len) {
> > > +     if (rchan->mid_rid < 0 || !sg_len || !sg_dma_len(sgl)) {
> > >               dev_warn(chan->device->dev,
> > >                        "%s: bad parameter: len=3D%d, id=3D%d\n",
> > >                        __func__, sg_len, rchan->mid_rid);
> >
> > Just wanted to share the WARN output proposed by Wolfram in
> > https://patchwork.kernel.org/patch/11012991/#22721733
> > in case the issue discussed in [1] is reproduced with this patch:
>=20
> I'm not such a big fan of WARN()...

Well, if 'id' points indirectly to the driver, then I agree here that
WARN might not be needed. Not as obvious, but probably good enough.


--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0WDtAACgkQFA3kzBSg
KbYbPg/9HEY0hGDM9WM07n9jV/N3TQvccjAC/bHuk4W3Y4L9pFjIrg2rDi0KS6N4
Jtkv3wcAHnf5qLmgwIbLMr3/rkgluyJwmKJdFKekcCme8QcbaU0E9jFp/XjTvK0d
ythx2KR4prY8FghkRUNgp6/oB8sA0fITfZvukwUMBJ3XKu3yXtDtHoeH2RxsvgK8
/7PTJrWadwVhLqLYlMqR6akRQkjPQxRxUVsQXqAxY0JAwrYHZkfYwXkknB8bmmsJ
mL37Qk2+k0SJrr8FwCdsuHOa9jnKkLsAhGfiQyvZd3b/7+I9vPxzAFwCU1VFjYEY
rYBo/RVFraU0DDg2j6O/qp/Spy17cPH1628aTBZ5PHWRmkbEkndcj3Jlmt79Kq+a
yfSRegl4NHrIOKywqGgMUOsUxm07BjHhJmCykCjUTJq/6K/TtJnLWyAQmM8IXQy/
fFox/sybSAkqPXuN5XzaSe1BBBC/JCNfS8Z3bO9RHaHg+Etms+cjo5r9lJXUm1RE
tVB7KtMBDyYNcdiLuxWLl2nrbcqSnK55B89ZqWKQhJYXm5tTjQcYlgsoqJYlU+Qh
U2x7knOaRX9k23jIPg1f/ugZBLbxxW4Htm3102wUNoJky8mGnMkiCysPo7PwzZm3
ppmSb8DzOAYnDpgKwRRUejcQkx5RllKjcNxuBGSzhQIjl0XbiNM=
=am8R
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
