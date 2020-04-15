Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F2E1A986E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895302AbgDOJTm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 05:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895294AbgDOJTe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 05:19:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC4D206A2;
        Wed, 15 Apr 2020 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586942373;
        bh=okUruJDPJKacfzZ0/FQ2AYhcvGKcB0ud1pJhEHMTmco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDYTulwRtubO/StyzvoxSGb4Z86eU025StVoxdQmaKKQdMWZuQ6VM4J01YUyn2odB
         guw1G6SfYFsGjxMWQ8oT6Nqc1trs/EnoFvRMkLU5kwx9t6UBowe5OQK4I7IPadnP4P
         wusKq93W4BME6BmLB0JXCok9AbgT0+cFAuA4en0U=
Date:   Wed, 15 Apr 2020 10:19:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Message-ID: <20200415091931.GA5265@sirena.org.uk>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
 <VE1PR04MB6638AE84CD338AE1CF26FDFD89DB0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638AE84CD338AE1CF26FDFD89DB0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 08:41:17AM +0000, Robin Gong wrote:
> Ping....
> On 2020/03/11 16:35 Robin Gong <yibin.gong@nxp.com> wrote:
> > There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO transf=
er to

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6W0Z8ACgkQJNaLcl1U
h9Cl5Af/RsVCkwJ2F2y85wo6iV4ieGbzZRxbI7skDohZNDOFRyf1i8kEXUex8Pyb
OHjSzFguwzTlhgg6PMkp8R929OiFE3Bu8vupFdNdaw2fKZTFNoHInLjcqOtuDwSW
N4+v2rbYrlGybSYpMvl8tDz3tu/eQl1cOmdSg/UWDUpStyCrzsAMcaKJA5kEJavD
NoAHcE2LKjVeo34XmpGWOI8xiAgGqDLm27zQ2JGt6nmZxR33BS3HDfz0Fc5kCnut
XVx7ggmvMMXvERR4naP/m/c9EkZ470SjZnwYtO71L9ncM62YJdHDogRS8t0ZWn3B
sNTl4T+hhMymPnKqvdtRch+txbGv0A==
=lwLW
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
