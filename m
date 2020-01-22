Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C42D144DE1
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 09:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAVIqV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jan 2020 03:46:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgAVIqV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Jan 2020 03:46:21 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 412962465A;
        Wed, 22 Jan 2020 08:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579682780;
        bh=AepTZQnS41aFGnPgtfnFssNsH20gZiJLcFaGD27PRV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKE/jqr5coHc/wWfyg1XVzfBMwoTN0AhXWs9DT60kBanKLjyBiFKr2fllB1806A74
         +Rr8FQ5616OSPdnCwWeNrWpuI1lXV/wnZDKg0ZJtiGrakIj12v0wYeNSe7WEiV7AHQ
         6vIdT8z4Tfao3vHQoSBrDVNtmR0OUVIwCurppQHU=
Date:   Wed, 22 Jan 2020 09:46:17 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH v2 2/2] drm: sun4i: hdmi: Add support for sun4i HDMI
 encoder audio
Message-ID: <20200122084617.s2n4dqhwanmaxuch@gilmour.lan>
References: <20200120123326.30743-1-stefan@olimex.com>
 <20200120123326.30743-3-stefan@olimex.com>
 <20200121182905.pxs72ojqx5fz2gi3@gilmour.lan>
 <20200121182937.2ak72e4eklk4za2u@gilmour.lan>
 <20200121183247.GL4656@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eo44jwmgblwjtd3w"
Content-Disposition: inline
In-Reply-To: <20200121183247.GL4656@sirena.org.uk>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--eo44jwmgblwjtd3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 06:32:47PM +0000, Mark Brown wrote:
> On Tue, Jan 21, 2020 at 07:29:37PM +0100, Maxime Ripard wrote:
>
> > > Mark, our issue here is that we have a driver tied to a device that is
> > > an HDMI encoder. Obviously, we'll want to register into DRM, which is
> > > what we were doing so far, with the usual case where at remove /
> > > unbind time, in order to free the resources, we just retrieve our
> > > pointer to our private structure using the device's drvdata.
>
> > > Now, snd_soc_register_card also sets that pointer to the card we try
> > > to register, which is problematic. It seems that it's used to handle
> > > suspend / resume automatically, which in this case would be also not
> > > really fit for us (or rather, we would need to do more that just
> > > suspend the audio part).
>
> There's a drvdata field in the snd_soc_card for cases like this - would
> that work for you?

Ah, right, we could just retrieve the snd_soc_card in the unbind, and
the retrieve our structure that way. That's pretty simple :)

Stefan, I guess this is the easiest solution, we should just make sure
that there's a comment to explain why we retrieve snd_soc_card in the
unbind, since it's somewhat unusual.

Thanks!
Maxime

--eo44jwmgblwjtd3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXigL2QAKCRDj7w1vZxhR
xWq1AP43hh7O1drKmKw4LWDcFL1e3jFnbiNLxBGwUtUAsT8hwwEA505uGh0lTCPZ
1dpI8BQYcJ5Zzjp9JGkU9Pm1KCyZMQA=
=vZhm
-----END PGP SIGNATURE-----

--eo44jwmgblwjtd3w--
