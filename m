Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9AE13CA5C
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAORHg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 12:07:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgAORHf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jan 2020 12:07:35 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70661214AF;
        Wed, 15 Jan 2020 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579108054;
        bh=bZgTE+sfDA4znuib9GfQPR/++LYJ+U/zkieRwUtQu7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=po0oY3j2BHNes4mv3TqdkItqh5I3k0r89eERz/erPgkt2FX5ETzJ0L0K7OSCK4y+8
         //lAYPLI1jJnYZqoCprE7A5fzdog9uSvRK6O3f/kM30jRJGHfRyNASOGKFfeF/wE7t
         OXePKWBstOdbWX+jrYfM6YjAKRGeBM/R1jmyZ3DA=
Date:   Wed, 15 Jan 2020 18:07:31 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
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
Message-ID: <20200115170731.vt6twfhvuwjrbbup@gilmour.lan>
References: <20200110141140.28527-1-stefan@olimex.com>
 <20200110141140.28527-2-stefan@olimex.com>
 <20200115123137.GJ2818@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2bp5iwjkf7edbvmy"
Content-Disposition: inline
In-Reply-To: <20200115123137.GJ2818@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--2bp5iwjkf7edbvmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2020 at 06:01:37PM +0530, Vinod Koul wrote:
> On 10-01-20, 16:11, Stefan Mavrodiev wrote:
> > Currently the cyclic transfers can be used only with normal DMAs. They
> > can be used by pcm_dmaengine module, which is required for implementing
> > sound with sun4i-hdmi encoder. This is so because the controller can
> > accept audio only from a dedicated DMA.
> >
> > This patch enables them, following the existing style for the
> > scatter/gather type transfers.
>
> I presume you want this to go with drm tree (if not let me know) so:
>
> Acked-by: Vinod Koul <vkoul@kernel.org>

There's no need for it to go through DRM, it can go through your tree :)

Maxime

--2bp5iwjkf7edbvmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXh9G0wAKCRDj7w1vZxhR
xcYaAP9Ias1ypfUPOfaG/F7N9WB9I/ldnmBh5I24ez8A9pQPlQD/XUfJTn9Wh8iY
O3h8YeDStjv1z+kttwwWJ6ms4KlhIAU=
=r61M
-----END PGP SIGNATURE-----

--2bp5iwjkf7edbvmy--
