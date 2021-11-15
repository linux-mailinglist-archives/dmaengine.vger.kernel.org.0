Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27F4450570
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 14:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhKONca (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 08:32:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231805AbhKONcN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 08:32:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01B2961C4F;
        Mon, 15 Nov 2021 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636982957;
        bh=d7tYqUsWDtoH/nl2BZKWt1Fg723w2autMfgUYEMNJag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxAtFPBbvP/6AMCR/771dj85JLwT9nMjXuRQW/p/vGkRcrzxY2dfXvwIZFnFfefwu
         kvsKyiub8ajs3EgHPbs6+p59+0bA/wbHJl2rz7tgW3TeuyJq/UzZVAAAGhAdFi+CZW
         Uw+2qQawe1sg1MzO5qZDCDpwqeQYNaR5EdOhc2COOEUfXCP0x7GGBQFYXF9J63TxGW
         AwoXnh5gr7ftDkRGa/KmDw/s4JgpvjP7FcwtMuv6k/iKRgLccKlkjLmXo33ME7VFfJ
         JbTTzrKQ/VAOfK2BvkUlHyAruho4/iLVVQdqlwG9oXsUX0VqxqKDDGf3cxU4kWKLOe
         vGM3FZPU3/xnQ==
Date:   Mon, 15 Nov 2021 13:29:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 02/11] spi: pic32: stop setting dma_config->slave_id
Message-ID: <YZJgoxE15OYKYP2K@sirena.org.uk>
References: <20211115085403.360194-1-arnd@kernel.org>
 <20211115085403.360194-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IMTM3OEYqWoLprto"
Content-Disposition: inline
In-Reply-To: <20211115085403.360194-3-arnd@kernel.org>
X-Cookie: Custer committed Siouxicide.
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--IMTM3OEYqWoLprto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 15, 2021 at 09:53:54AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Setting slave_id makes no sense with DT based probing, and
> should eventually get removed entirely. Address this driver
> by no longer setting the field here.

Acked-by: Mark Brown <broonie@kernel.org>

--IMTM3OEYqWoLprto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGSYKMACgkQJNaLcl1U
h9BFJgf/fpBvGqcjOVPEzPWsUxd950Aql84mdfpVf7Q34yAtuAJMlorUf+ARZFeV
RvrFCJ6tyeWZsZCKm+HMgfJFIp4GSOcn2asZ7p06z3lpAzDdX9Yn8aFW1bcIUOee
EjiSLquSQyBmUy+upf3bbaVPV1YyDaj5IajH5PQCVwj1mfRcilnqGpBPEJgpEo99
MNhpTEA3rcd6ESQQ0QyMAliW+T4BwAkXCtnWnSt4bVq1NfViOEbTGn/Nh7OaGwrI
dNe0cE4t3/9Vo3mtQY6IgF2d7gcIiTePrXRq74w940zsn4Rh6RpX5mGPiwM+OYh3
l7AvLSoqMeL1h9M5Yek/O6k8yVVJuQ==
=RhAB
-----END PGP SIGNATURE-----

--IMTM3OEYqWoLprto--
