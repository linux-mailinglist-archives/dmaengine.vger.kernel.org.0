Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609B245981B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Nov 2021 00:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhKVXEv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 18:04:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhKVXEp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 18:04:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DBA960FED;
        Mon, 22 Nov 2021 23:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637622097;
        bh=5HPGeejKcq0/skHJyiqCEkuW5nT9h90VXdWH7CYPbFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEdiJ23lulIvuZIRcBfsS+qhZQdy45DABTeQ/9eMEUl1h55xvksxls/uuZO4VBeI8
         VaCo7TKNLJwRLa3QYvdv6RNwEp2FVuh3jDzzlTQaQEP63m8H/MG3PA9JAEloDYolQp
         c9/rmjY39HvZyawWUPIV3NjC+iYFEvh7eF6njpejVduCoCGuYmDwm0WoROg8MZpuON
         SIl6D9XkBqQ40owCHtFzbFPFXQsgb6+Hp4V/BoNJJJnMHVdW/zgOyJBpirCAwPOfIz
         HcfB+kkGUqemGZoka/SinHrWStHXFAUQPzrIQFgTm1oadehKRNNCm1qA6BWKPpcaq0
         1TgibwoU5fvdw==
Date:   Mon, 22 Nov 2021 23:01:28 +0000
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
Subject: Re: [PATCH v2 00/11] dmaengine: kill off dma_slave_config->slave_id
Message-ID: <YZwhSPkhAqZy3bqY@sirena.org.uk>
References: <20211122222203.4103644-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="71Si6a9AhnlReqww"
Content-Disposition: inline
In-Reply-To: <20211122222203.4103644-1-arnd@kernel.org>
X-Cookie: Lake Erie died for your sins.
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--71Si6a9AhnlReqww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 22, 2021 at 11:21:52PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> I recently came across some new uses of the 'slave_id' field that
> I had (almost) removed a few years ago. There are no legitimate
> uses of this field in the kernel, only a few stale references and
> two drivers that abuse the field as a side-channel between the
> dmaengine driver and its client.

Acked-by: Mark Brown <broonie@kernel.org>

--71Si6a9AhnlReqww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGcIUcACgkQJNaLcl1U
h9B/hgf6AiPwJAMMKcdb/6uCfAJACPZtqMFn2hE6HQgrw8mlTsR3sGqhQj3c3NWF
vkLYtSZ20L2tPvS1uyAxjIRzIm91rqriu6pNurmupB6D+347UfSMpYhtbEKXvbBw
1UF5ftPw1t5IGduAX6HKBfaN1Iab53577DJb/uJwR3Mb/WBh9aFpuyRwuZgjBOwE
MvpTaAK2GHY4loDjJChSAK+zlCQMFbc4I2mZuahtf4wvBts/eZn7bAqAruzPMnTL
e3crlktLeH7C0DMKJpmrxvTvS0CDsEUUOJ+tM7aNmtsdyYTAZEG35vzJgVly61jc
7e5I5GHB1Jxsid3oM7WeznOhbimQEw==
=AKUT
-----END PGP SIGNATURE-----

--71Si6a9AhnlReqww--
