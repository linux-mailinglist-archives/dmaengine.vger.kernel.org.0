Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABEC1F3C40
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgFIN0U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 09:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgFIN0U (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jun 2020 09:26:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7946A2074B;
        Tue,  9 Jun 2020 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591709180;
        bh=PD6ch/MJQc9epSsTqGkjMHuE3Bn2LG6EcC5hHXFGdq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m64ifHeq25sd9NUSmmUGWjukAom8pausfLbRSSwhrcFU3eCJVbVlg0ILMpKb/Vked
         cAbbrFQLB4CNUK9xlRfrHUjsjod+WFOu1XpWokyplWBQ/zHrUOBIWmxvht7qCAMuLC
         RQOC4Mh+5nXlCKj0YAB/Fe3BUxAOyMCTAMvT3N7k=
Date:   Tue, 9 Jun 2020 14:26:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
        <linux-arm-kernel@lists.infradead.org>,
        Robin Gong <yibin.gong@nxp.com>
Subject: Re: (EXT) Re: [PATCH v9 RESEND 01/13] spi: imx: add
 dma_sync_sg_for_device after fallback from dma
Message-ID: <20200609132617.GF4583@sirena.org.uk>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
 <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
 <20200608143458.GH4593@sirena.org.uk>
 <VE1PR04MB66388F89015F774EE3FFF69D89850@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200608153139.GI4593@sirena.org.uk>
 <59ce3620-00b9-bac1-30e1-011a29583642@arm.com>
 <VE1PR04MB6638B1EC49D295C64292B7BD89820@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <bcfc3637-65af-577a-ddbd-890b6c83a6e6@arm.com>
 <4a663b38fe5c6b2ee37049fb0dcd88b70dbf232e.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline
In-Reply-To: <4a663b38fe5c6b2ee37049fb0dcd88b70dbf232e.camel@ew.tq-group.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2020 at 12:09:09PM +0200, Matthias Schiffer wrote:

> I assume the actual issue is that the SDMA controller is considered
> registered before the firmware load has finished, but I have no idea
> how feasible it would be to change that (some comments in the code
> explain why this currently isn't the case).

Right, this is what's causing trouble (or at least the DMA driver not
doing PIO behind the driver I guess but that's pretty nasty).

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fjfkACgkQJNaLcl1U
h9BfBAf8CV0CLky89IU/mEpL41EP3zYDh1CpOj14T0/q0rrhzJssgAgiQpuqedGZ
+DCbmgd/BwcI8pzX9h8VKeAd+A3aA7VX99WyBCuXC0HlTSpVXfNToMQJbPtTnZ6Z
kOgDEW/grpy/YDCsJCbShsIhns0ziINTO7tY9uPaPqBXd9oMDgFLdWRT/FprI3Ev
k7hg5PoMjblnT55/96ZZgOCUp8OsE1U9vI+o0gModN1ksRouto/eMfei4IibQA9s
foKiP7g14rArPdSbl+JKhnjPvIt6wrxoNdD5TCh1ZH7u/MI7VrSRr5+OGhguRzha
K7/XCESdTGTHW+s5NU5gyADCheFsvg==
=iBCT
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
