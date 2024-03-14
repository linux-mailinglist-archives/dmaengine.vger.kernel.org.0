Return-Path: <dmaengine+bounces-1384-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7513687BDF9
	for <lists+dmaengine@lfdr.de>; Thu, 14 Mar 2024 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EBD283EDA
	for <lists+dmaengine@lfdr.de>; Thu, 14 Mar 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA56FBB7;
	Thu, 14 Mar 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E38r5Nx7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80185A4E0
	for <dmaengine@vger.kernel.org>; Thu, 14 Mar 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424061; cv=none; b=VRXQStVBXDZWWnWXyAnxxGhiTkP0OP6kkdTwBSoG5upowrDJORA40qoKidFgnNdAGSbwa80z2IprPRu+G5onmFUwYryGW0YJXk+VfvOLBJhI8x5lLIdqI/JOhFLehtC4/BGn5eXOzuh5kxMEf2836JAIQG8sfJwjFVA3cteknts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424061; c=relaxed/simple;
	bh=sbe5v4OQeS1qAcza/X4jCkymnqLJt1xm73UeFizXQww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAOHde3yA5t2eACMB+XpfrJ1jfZ+puPGx+RMVzmXkr0TESLRgM7vtfYO7QpjFkKMXVjabSa9BpJOjG1XLEoGFgfZrgVmlV8LSFMxNnqtHDaHvn7E6SZaaUtNpzBpB9IRNsMEzJkWqLkNUexR21zL21nBs90e5u5bO7HLHUGH0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E38r5Nx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1D8C43390;
	Thu, 14 Mar 2024 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710424060;
	bh=sbe5v4OQeS1qAcza/X4jCkymnqLJt1xm73UeFizXQww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E38r5Nx7siCEAguJvJREeyWv9V2wqmfeVzrEKXoKrQ+LDtaYj0VRHZv18dKs3wtVx
	 MIXzUXWYD5/gObxJk+Yc68tKaeqR51Z+DIk0PIDhnoXaOjO8EbRAaUCDGk/3k8BSBJ
	 rPtAMbIozO73PvEkWjnF1TReLnQ8bQ0PaUDKjvmxoE/JD9nI2L2csTZdQ/tvQG7aDe
	 xf1D6EKbrTGqVHzUTatumSQS8n5evw6M8XyZtgmUBLusq+foFNUigw5qsFXoPt/+H8
	 jXGwwGOcyqsqr4Jqb8+4CW97z0t/WJ/fdmDV0XH6oqenzSkGynX26iv5M8IEAz4e5T
	 1dDrp7Z9J0Y6A==
Date: Thu, 14 Mar 2024 13:47:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-rpi-kernel@lists.infradead.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
	Jim Quinlan <jim2101024@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: DMA range support on BCM283x
Message-ID: <aa533a97-ea62-4d84-aea9-2714e7561517@sirena.org.uk>
References: <CAPY8ntByJYzSv0kTAc1kY0Dp=vwrzcA0oWiPpyg7x7_BQwGSnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3BojqALUy3Pd7FYg"
Content-Disposition: inline
In-Reply-To: <CAPY8ntByJYzSv0kTAc1kY0Dp=vwrzcA0oWiPpyg7x7_BQwGSnA@mail.gmail.com>
X-Cookie: WYSIWYG:


--3BojqALUy3Pd7FYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2024 at 03:06:01PM +0000, Dave Stevenson wrote:

> Assuming I'm correct with the above, the question is how to implement
> a solution that corrects the behaviour whilst still supporting the old
> DT, and preferably isn't spread far and wide through the code.
> Worst case is to require all DMA users and the DMA controller to look
> for the dma-ranges property, observe the range isn't present, and drop
> back to the current behaviour.
> Slightly nicer is to use the knowledge that "ranges" and "dma-ranges"
> in this case should be identical, so have the DMA controller driver
> attempt a lookup with "ranges" if "dma-ranges" fails.

Either of those solutions seems fine to me.

--3BojqALUy3Pd7FYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXy//UACgkQJNaLcl1U
h9BQLQgAg2kkY1+UoOyMsc8yjidfUlJGGDAyGqaGN01e/WzfJ9maJoVkA0FqhCCY
WPAoGL5VCZUtSupDKjFdmpU/VPfHyvF4ZMWfgrc9Pn2z4tEqnR6eXDb3FZasVpSv
9cMWuQ4NgZUx1kAttLBLcIogHFeMNTK3hqSC6Fcz7TJ+u7H96VgvyfH1jGeZ4JWw
wTL0/0ZSqUf051j4gAjEPKKHnrpOnCFXsv8PYBRP7eyrGA6sAiTyM9R8+Oh1kswi
3HM74B81s2j+6ZviddWInzjGuzDP5cicCNerEDwu49r9yBPlma8w/ghukZIDH1ov
FT9gjkeNCZr+07Gd2ieQSl8irnJEfQ==
=pmfs
-----END PGP SIGNATURE-----

--3BojqALUy3Pd7FYg--

