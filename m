Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8971AD53
	for <lists+dmaengine@lfdr.de>; Sun, 12 May 2019 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfELRGJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 May 2019 13:06:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49686 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfELRFw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 May 2019 13:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=01m3A/Y96dMVi6jTGfgljQjDaC0yvjKoGzz4EJpMfPs=; b=jTRdt4HhtnJjJHafp1MIflgZ8
        DZNUAtSsEZnlic7cY43AZUWFfqne/30nLvtlhzq+5gLB7NCZVftCdhuPDJGwaTEwGgQ385E7Oxy6z
        ejT7lGh7gJceE/BG8tR/752ua5O1uQ3VB0PdZAl8F4cgWquXy+a85ZE9YD+VG0yBo5hm4=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044n-A0; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id BEB6F44006E; Sun, 12 May 2019 10:17:53 +0100 (BST)
Date:   Sun, 12 May 2019 18:17:53 +0900
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
Subject: Re: [PATCH v3 08/14] dt-bindings: spi: imx: add new i.mx6ul
 compatible name
Message-ID: <20190512091753.GR21483@sirena.org.uk>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-9-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7UIJfHqpdi+oBJdT"
Content-Disposition: inline
In-Reply-To: <1557249513-4903-9-git-send-email-yibin.gong@nxp.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--7UIJfHqpdi+oBJdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 09:16:25AM +0000, Robin Gong wrote:
> ERR009165 fixed from i.mx6ul, add its compatible name.
>=20
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Acked-by: Mark Brown <broonie@kernel.org>

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--7UIJfHqpdi+oBJdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX5MEACgkQJNaLcl1U
h9DdIAf/X2qeVaCSbFh1puBpR4faa0Kk6jowtA52t44qC/EzFms+BOzR9IEV5IEl
CMfUXrocjbJGM9ubz9YDaTcdp1hfJPXjfpkkFfnYubbnPeIR7gH5JQVDb9k21Q4q
DQ3x92Ldeq94CS1/5udatrzwOwnPwzayg+jnMrXg8piLbxdaJND8cxuvCdcr5be2
7TCvW2RvUU1RCVLa3RlgTrfPDPx5DMHEvrNihyLa9MBeWBqvL4w/amqfgFefglJo
oymv3ABjbEAWv31Gl/ZsvQsU3CAFv/pLy9C5MSysjtK9jJA2HZXzDCn+kPYwu7ul
XGAR6UEeIZ8LBryhYFFLGTrT89O+fQ==
=5tdn
-----END PGP SIGNATURE-----

--7UIJfHqpdi+oBJdT--
