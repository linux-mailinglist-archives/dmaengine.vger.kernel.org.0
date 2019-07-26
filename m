Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62D764A9
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfGZLeB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jul 2019 07:34:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56194 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZLeB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Jul 2019 07:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5Gf3w/MVbMZMYK8bIC4gRWxvIqP0knReDLN6eNPEqKM=; b=xDuN5S0H1Z90uPzdw6R64amMy
        gnMBiADJuFYD7QblFkqSVwB6tn/WF7BGvvo30k/J0aPMmA1HEiUnpoQWAzka7PaHDQ4Joyhpn28yE
        EF2CUDXHQO0sCka8C6a7kNpPIaO1hAAThEsGBgsnR0u9wX9Txm8yC32A/rlHacR2+gL5o=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqyTc-0001Mp-Sb; Fri, 26 Jul 2019 11:33:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2EC622742B63; Fri, 26 Jul 2019 12:33:32 +0100 (BST)
Date:   Fri, 26 Jul 2019 12:33:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 04/11] ASoC: jz4740: Drop lb60 board code
Message-ID: <20190726113332.GD4902@sirena.org.uk>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <20190725220215.460-5-paul@crapouillou.net>
X-Cookie: List at least two alternate dates.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 06:02:08PM -0400, Paul Cercueil wrote:
> The board now uses the simple-audio-card driver.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>

Acked-by: Mark Brown <broonie@kernel.org>

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl065QsACgkQJNaLcl1U
h9AE2wf7BtVnDND6hd0UergsxXl5U3RJXvpiGgm/0yVLxuFEWPiM0EFqLGMWqoxE
3l20EeSRpPmuyPH/GyBi4VYbtfk/QkickfZgmRTnK53CZURHGm15Dr9Prj6WJ5Vp
H8QHogCOvGkoZGZh0E7Upp1Ofw05EC/ZStES9Ptw0TRNRENeP6SIRNDZJSBp7A5/
TpEw+fvcu9R2andSKgKYEsZJhppM9oSRB6H4XRNM1Zxu6FTNfkmMG0ycTRjwJPvz
ZXt6d0bq7TrYHkNajY1Wk1JwfM/wPlcW3xATpeBcp6RgazsL+i2T3fe2J541EGzJ
KSs0o9NZufIfr1QaVv4L9HrMAsSE0A==
=jJYl
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
