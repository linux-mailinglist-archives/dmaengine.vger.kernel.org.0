Return-Path: <dmaengine+bounces-5507-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A717ADC39A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 09:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0784A1886074
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E028E5F3;
	Tue, 17 Jun 2025 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2QTY16Pa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81D28C5C9
	for <dmaengine@vger.kernel.org>; Tue, 17 Jun 2025 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146227; cv=none; b=nT9oqTkXvXmmUiFyqFp469nHgisLDNkEo/tgtvoSfWfpZU9tvDiFy5Xv6UQm3ZzH0FhMZ3iXUWms2T7eClvWQz8TZrpLFMbb+8dmW4L2KEnfWJSgdBluVMWHrePrZZfzlxgch4f8cvPEs6mpt+OQUcz0+ok89QTlIJKMPMXawAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146227; c=relaxed/simple;
	bh=Wanilknuq/oxgKqar3VDDdKU9mWKxoMxEl1gryaM9SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTt8VPaituK0GlE0pxO96rjPnwh+DsRO/5zcGhBoYbGbVOAVieq4cpjQodMMWsWpWrbUoFTIISSbNp/YtYt9bq7xP7kf7KTixpAgK7UfP9E8XtuMCuuKitkO9truEUeywDbvqUBHPI79MlwDRSOI0zzOfY735sLYbY6rNMoRB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2QTY16Pa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso5204212f8f.1
        for <dmaengine@vger.kernel.org>; Tue, 17 Jun 2025 00:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750146221; x=1750751021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr/0G9QcVKTsH2nCRZsPlndI4/213HWXG/qnBI+qj0g=;
        b=2QTY16PaPiD0pPXyYQUkBdgV+Y4+1psm6/V2qfmB4Lq68p9Lm72KQg+CPoYBs3OLGi
         ooFfLnEetDdmDWAKCC1Vn3lS3uXachGRa/Ld74pHGnKq09F7KPxVUlJjWO2nzK+C/mHb
         oRdkNYYvpQGegdZZsk3O6SkDA5tt37ecZD9pciazCUtNpcfSUeVLqwLKrSjwp7+84F2p
         9p3rmpZ39PKJhiHvGIZAOpCLCEk9F/EFapU7co6qmyN5Y6kKVbIoRXH5YCEKKD/s95oT
         I6FWP9bD1K6PfQzaeQ18JkCtuDp9KaurmXlFZKNl6MHHYv8y8zmXp/BaJWwIRFxIKjT1
         sgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750146221; x=1750751021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr/0G9QcVKTsH2nCRZsPlndI4/213HWXG/qnBI+qj0g=;
        b=br4DvpBHVxTvcL6A+zOse6tTmiZ/oP+viIi6oAKPd+yd6VLoqCkmpeZtYwwU7RUH9n
         L31T4BN4jAlR7xzsu3otNIxNiZKFn8Qs5UGXhrpTolre9yrOa6pFhNQXYZSLfgmC7vhu
         412Z9gWjbF7lPX7IkKZw7XfBkOFWHmc2vTCj98Ww01qzHs62zxG9hvQ1otYRSMhV0kbJ
         8tinDekOrhi3QU1bVVfdxBm0GXIpdB6MuRg2P752wJDqqzsYq2CRmVRjcUmz7o42LVAd
         y61MYZMjePcH4VKXeHDQH4o1XKtKnFEZu6AfYuMYiMzLuKTdxrYHAp4tQlElC9PjTQfe
         n3eg==
X-Forwarded-Encrypted: i=1; AJvYcCV0iDDyq7bT8HNBxkLg2KLUgkGD+l6LVcIOQwpH65tpUGoM9vndib/e/8s6b+1r4tdUDvBvvmG+8XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQU3SXhbhBL4zSlQPwXZFKWrgyMXAddOvwdSFZAW7l1SjuKHU
	bZlMJU/AMGS7DA5b+Ocn6uM4vIpQQ8iE7HSSvf9WP6fSwJZ1n1LsoQu1Hk0MTSsTUY4=
X-Gm-Gg: ASbGnctD6yACCz2ZlK8Etwa8H8IharkEpZKGJyvuMvtTlBLtZFVoGylvO3K26JBwUME
	AQLealMd5VDv/nWhUv7Q0nw9MX4cAH/jGxWzd+XEGqxWR19CoM8OiNPMeqqCmRYjSwBMB8wkcEr
	rdEdCZd927eTfg3JHEtTACZkRX/jsTq30ZcV9pivZ/WgHx633HCyMPuzz+VIJn6ZVi+edT6xuhj
	Qgmsj1sJIx429O/EB0kPWy3Mu6aQ+vIZrGWMQ3ESzEJAu+V40KHauaqHfW8d/8nbsi5Ee1V4DJu
	CG4+1pq9XHO3pFf0zmKcc8cOt7F6KPaRficTjzCKINNmbuNyfRXIFcTDZd1/9SmWbeZFNIalilf
	yl8GyVnJFdoUZjxRsc9nrnlrRnqx6
X-Google-Smtp-Source: AGHT+IHjO2Se+CNiFhQkijyy0zThy6btDct+3FCrSMJqJK2Ek1zZ0kq2x91GfZpIV9vpmdDOKsNMTg==
X-Received: by 2002:a05:6000:2302:b0:3a5:2cf3:d6ab with SMTP id ffacd0b85a97d-3a5723aeae3mr10062193f8f.39.1750146221186;
        Tue, 17 Jun 2025 00:43:41 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b18f96sm13293332f8f.66.2025.06.17.00.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 00:43:40 -0700 (PDT)
Date: Tue, 17 Jun 2025 09:43:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Abin Joseph <abin.joseph@amd.com>, michal.simek@amd.com, 
	yanzhen@vivo.com, radhey.shyam.pandey@amd.com, palmer@rivosinc.com, git@amd.com, 
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: zynqmp_dma: Add shutdown operation support
Message-ID: <rgjc7ujikyznrri27u6v3zst2m44423g46rlfnkfncr24jwx6z@mfwwvhe3upby>
References: <20250612162144.3294953-1-abin.joseph@amd.com>
 <aFENfW0v0gmtY2Gu@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pas4lfeknrusfsyc"
Content-Disposition: inline
In-Reply-To: <aFENfW0v0gmtY2Gu@vaman>


--pas4lfeknrusfsyc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dmaengine: zynqmp_dma: Add shutdown operation support
MIME-Version: 1.0

Hello Vinod,

On Tue, Jun 17, 2025 at 12:08:53PM +0530, Vinod Koul wrote:
> On 12-06-25, 21:51, Abin Joseph wrote:
> > Implement shutdown hook to ensure dmaengine could be stopped inorder for
> > kexec to restart the new kernel.
> >=20
> > Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> > ---
> >  drivers/dma/xilinx/zynqmp_dma.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqm=
p_dma.c
> > index d05fc5fcc77d..8f9f1ef4f0bf 100644
> > --- a/drivers/dma/xilinx/zynqmp_dma.c
> > +++ b/drivers/dma/xilinx/zynqmp_dma.c
> > @@ -1178,6 +1178,18 @@ static void zynqmp_dma_remove(struct platform_de=
vice *pdev)
> >  		zynqmp_dma_runtime_suspend(zdev->dev);
> >  }
> > =20
> > +/**
> > + * zynqmp_dma_shutdown - Driver shutdown function
> > + * @pdev: Pointer to the platform_device structure
> > + */
> > +static void zynqmp_dma_shutdown(struct platform_device *pdev)
> > +{
> > +	struct zynqmp_dma_device *zdev =3D platform_get_drvdata(pdev);
> > +
> > +	zynqmp_dma_chan_remove(zdev->chan);
> > +	pm_runtime_disable(zdev->dev);
> > +}
> > +
> >  static const struct of_device_id zynqmp_dma_of_match[] =3D {
> >  	{ .compatible =3D "amd,versal2-dma-1.0", .data =3D &versal2_dma_confi=
g },
> >  	{ .compatible =3D "xlnx,zynqmp-dma-1.0", },
> > @@ -1193,6 +1205,7 @@ static struct platform_driver zynqmp_dma_driver =
=3D {
> >  	},
> >  	.probe =3D zynqmp_dma_probe,
> >  	.remove =3D zynqmp_dma_remove,
> > +	.shutdown =3D zynqmp_dma_shutdown,
>=20
> Why not do all operations performed in remove..?

=2Eremove() isn't called on shutdown.

Having said that, most other drivers also don't handle .shutdown(). IMHO
this is special enough that this warrants a comment. Or is kexec a
reason to silence *all* DMA and most drivers should have a .shutdown
callback?

Best regards
Uwe

--pas4lfeknrusfsyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhRHJ4ACgkQj4D7WH0S
/k6fcwf/ZARJglob++15lJ5FJZx+lpM9MqpTeUGMKnMzw6B014DEmMpCveShyVjN
pyGyLhkwI9RHVm9w0L3Gw5tRsEk6gD228K8xE/8hLk+HYNPYqsXlE/B+2AM+Y50/
Taac6eUG7W9ZGdz6nQxSvROz5tqT5r4WpYvN+TC6hyb7H4KVB963oWjZtwONnBJH
/bsc2E3kw4J+wctryB6wce6W3ajZEkpaMyyMdzAWTcJ+DFQICD+vb5lJM8Ob8iyH
RSdhNesjl2KzAFDd75PCPRrUuD08Ndu1Wq35d1+du85WP4vLoiBR7mrW4YSjW5iI
cu529KsUImojosD6g6IMeCKHknJMqw==
=Lai6
-----END PGP SIGNATURE-----

--pas4lfeknrusfsyc--

