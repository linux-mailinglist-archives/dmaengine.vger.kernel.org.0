Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5233DF97
	for <lists+dmaengine@lfdr.de>; Tue, 16 Mar 2021 21:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhCPUxK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Mar 2021 16:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232364AbhCPUww (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Mar 2021 16:52:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1884A64E76;
        Tue, 16 Mar 2021 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615927971;
        bh=+dogfZ43isbezmZjR8u8oBMqRI6I4K4OVSRSSOGkf2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YsWIEAjJBm0D4M77EqdYv/Leo+bMmaYAGUvI3VajtyYywcW/JFPzh9x57v3mfmwYf
         YujlNJ+DBnuMusWrdfsN5gE1NlqpjUhmetkDfYik8DMM5yVHfoGGOJmNalRdHKTa6e
         /0Ld2f5x1W77S1HfwxS33vLAcM4FgvAoeV/fKPZE+hHoZY6KURxMIPw+1a1PXp9y8g
         eunsT2Tyv4+e/D2OgmBt2QBInqyEYuQpiF83O2YubdBBj+M54t5spPbxr0M0vWZo+5
         fLJWcoGeXbyDgeobIKGeDLNj0hvA40Mb+Vpm01QLUawGk9fGKZxrebA+3ia2HFX5Jw
         dkdqEWX2XCtww==
Date:   Tue, 16 Mar 2021 20:52:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Clean-up undocumented compatible strings
Message-ID: <20210316205249.GG4309@sirena.org.uk>
References: <20210316194918.3528417-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline
In-Reply-To: <20210316194918.3528417-1-robh@kernel.org>
X-Cookie: Results vary by individual.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 16, 2021 at 01:49:18PM -0600, Rob Herring wrote:
> Adding checks for undocumented compatible strings reveals a bunch of
> warnings in the DT binding examples. Fix the cases which are typos, just
> a mismatch between the schema and the example, or aren't documented at all.
> In a couple of cases, fixing the compatible revealed some schema errors
> which are fixed.

Acked-by: Mark Brown <broonie@kernel.org>

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBRGqAACgkQJNaLcl1U
h9AAYwf/QQEXJESFxZVZKApeC2ypxUDckOjIAXw+3ZZYA3a9Mx/MllGedYIfGyqx
aONmpU5uRZxnWP50YGV5Y5oYS6er1ey2MwMikahPpMxhLoUfXVdEQgsocEJxquWg
3L0Yf9+3IZPTx0uH5yeyhiFnlUCjHxhm1CE3h1sKgQJsytcX+pHiew/vRQSfU8xW
JDEEuG1WfeQgOQ7VU3RthJ118ifcy+QeZaU2oSA6GsrpFdQk/qyVUyIF3FVGCeck
TAASFFWk7hmMFicdUN2pxZ3aUYewYwlZAsp2DdrfEvf2vIKCPxeVuLP8qSQ4O68+
/7rhwzcbiO5Nkq6aIxXzcZ19meepFg==
=bmyZ
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--
