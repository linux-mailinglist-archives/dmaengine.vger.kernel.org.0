Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D021AD4D
	for <lists+dmaengine@lfdr.de>; Sun, 12 May 2019 19:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfELRFx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 May 2019 13:05:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49718 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfELRFw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 May 2019 13:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9HMs6CFMH8EU8RkzgWGBu0MKVwuwgXnq0J4Rp8C3PBM=; b=kVo2FL0u92pisbUZ8qm0jj+af
        upIAewvYpAZOIs/oaH3emVc/79v5kuI85PG0MY/aVGoH1H5P/7qYMngw3I0DXCu+z9tA6PeG3vsDJ
        VAMcxzyYfxEdLK2QtkJp5Ar37wdVSg/uLZF7sTVaGcGOQtay0AqUCCdfZwbhuAldLK9r0=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044d-8y; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id DE14D440066; Sun, 12 May 2019 10:16:18 +0100 (BST)
Date:   Sun, 12 May 2019 18:16:18 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 06/14] spi: imx: fix ERR009165
Message-ID: <20190512091618.GP21483@sirena.org.uk>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-7-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline
In-Reply-To: <1557249513-4903-7-git-send-email-yibin.gong@nxp.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 09:16:13AM +0000, Robin Gong wrote:
> Change to XCH  mode even in dma mode, please refer to the below
> errata:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

Acked-by: Mark Brown <broonie@kernel.org>

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX5GIACgkQJNaLcl1U
h9Ax/Qf9F9Mm2dXsW6BETnXLb+haskxu5BW0ouwrc02+EmnMZCpk+eK2JWSx/BVA
hHEAVO5EpQ0txbRvSYWbDxfOheX1M6BYaA2ROjxHirVL+HT52VRa+dYja6OcK/LY
PDXYdW6hHB3YqCBFcV+/oXF94jjke9Rh+pnUIs5YEdRnd5MoZiYSCzvJKVcsDaHl
FAzP/LhX8HAupSbLbGojE7NKqKj2SuOeaKsD10zBEdo0eVFzCCsKwkNvmTlweDgy
VXujenPsoeAsM9VNu5En2yvrMtAN+7oe2mo5HZvOvdF4deOUS4HqR87fFEzT4Zad
IWZBFcTVrdqXuUinn5daxLAhu/5Rjg==
=9X9u
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--
