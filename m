Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F5B5EE19
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2019 23:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGCVJC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jul 2019 17:09:02 -0400
Received: from sauhun.de ([88.99.104.3]:55406 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfGCVJB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Jul 2019 17:09:01 -0400
Received: from localhost (p54B333B3.dip0.t-ipconnect.de [84.179.51.179])
        by pokefinder.org (Postfix) with ESMTPSA id 46B452C2761;
        Wed,  3 Jul 2019 23:08:59 +0200 (CEST)
Date:   Wed, 3 Jul 2019 23:08:58 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
Message-ID: <20190703210858.GA5012@kunai>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190626173434.GA24702@x230>
 <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
 <20190628123907.GA10962@vmlxhi-102.adit-jv.com>
 <20190628125534.GB1458@ninjato>
 <20190628130200.GA11231@vmlxhi-102.adit-jv.com>
 <20190703173050.GA11328@kroah.com>
 <20190703181519.ifrmycrsrohcc2gf@x230>
 <20190703184422.GA14207@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20190703184422.GA14207@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I've been doing this for a very long time now, before patchwork was even
> around.  It's pretty trivial to collect them on my own.

It's a workflow thing. Mileages vary. I ask people to tag patches
individually for reasonable small series.


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0dGWYACgkQFA3kzBSg
KbZL4w/+MqHZmwiTEJqm8BZ2ZK8faQJvNomt3fXolYS8QXPu/O3Xx6cuAqGSBCH7
t0+YtpEqfzxXaezbtsNX74gVA1LdDJMB907+D72NuepZamo/xa0RmHPbVH5R7Aiw
iLPw38oHscptehopOa+sS6fIXyOusnAqq7ItgLlLg8b3tS1xxkzZsChtT9tS1IPt
M0nsXR1q5Ag3z+mQkE3AM1U4TXbns8rou2FH6eBOCE97sp7eEuBeFX7Whe17bOzX
ia95g3H4Rf4RJ/NwwRpoJSh8nOh/8Ey52idfWOVrvwRMGWOJN3cq+V4lCBs/hKLQ
yNPp6EM4vGioTTYz6KiMHzPfjrxvGlHCFgVceYNA90PnXAhygutwG82Cpun7ob/J
HcoNJLePIcg0/ziV9kOzReyc9hTGCo2wJHQaAlVR/Fo04p8Oxr5+rFveVWNyUtzt
TntLF1sDdpqYfjLvEfft1ygmAvBw2CxLLyWmLQwKa+ucyF6dayGNbJN9kl++Anhf
vr2P339IStBPk2U7CChrLO4NTBlvBuTS+SlH83D4Faay9ozjNcHLGi6ss53KLzo0
EpLi0o8LDoNWU+uYKccENLlfRBQq5Xryt/TtGIHHxJI3rJWOnm/1gXCg39q/VHpy
CQx9isnS61NUwrwu2DEb3SgBAv43+hoP5N08jSZqJKgCkzDxsd4=
=pG6l
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
