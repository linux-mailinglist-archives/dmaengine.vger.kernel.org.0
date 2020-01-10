Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B43C1372A1
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 17:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgAJQST (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 11:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgAJQST (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jan 2020 11:18:19 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F67B20673;
        Fri, 10 Jan 2020 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578673098;
        bh=CNkQqQjNxxjMxd0cG6tO8K7HmYmp24FIWvU31w4VO4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yDJfo217GwgxoqlanVfhv8is/B104K1Nwu3xmcXrGW2wwky2haCsda334DspVENpg
         aoMinfIx6wsKYfWzlnT2XMSYm4WpcaJjAfNASITSTerk1VDzQtY2sVC2AD76M8tpoJ
         jqjzSKwYUYTtXep+Zq0pv834kKv0gA00kcT4DpXM=
Date:   Fri, 10 Jan 2020 17:18:15 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] dmaengine: sun4i: Add support for cyclic requests
 with dedicated DMA
Message-ID: <20200110161815.iyvtjg35uxfehlqp@gilmour.lan>
References: <20200110141140.28527-1-stefan@olimex.com>
 <20200110141140.28527-2-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="totzryfts3qen7g5"
Content-Disposition: inline
In-Reply-To: <20200110141140.28527-2-stefan@olimex.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--totzryfts3qen7g5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2020 at 04:11:39PM +0200, Stefan Mavrodiev wrote:
> Currently the cyclic transfers can be used only with normal DMAs. They
> can be used by pcm_dmaengine module, which is required for implementing
> sound with sun4i-hdmi encoder. This is so because the controller can
> accept audio only from a dedicated DMA.
>
> This patch enables them, following the existing style for the
> scatter/gather type transfers.
>
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--totzryfts3qen7g5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhijxwAKCRDj7w1vZxhR
xS5OAQCuIzZcjjb8Sg26Hl9el8UvbemFQG9v3vr7NYDHlHNz6gD/eRGoMlVnct4z
GxzxvLVcX2fzSzVP+7DXzQDhetp1Pgs=
=h876
-----END PGP SIGNATURE-----

--totzryfts3qen7g5--
