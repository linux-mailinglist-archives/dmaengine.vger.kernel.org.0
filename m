Return-Path: <dmaengine+bounces-7127-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B91BC47888
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 16:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827A93A9FB6
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66A316199;
	Mon, 10 Nov 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQwMYm6Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990623A58B;
	Mon, 10 Nov 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787833; cv=none; b=hzag68pH7KtVyk/3pRyJoVRUg4zfv28ACsA754ZjCAXiqcXZzG0KubAMRkYC/swcruVi2Sh7vAULiVXB7LBHaHMYxqx29PqbmVSt2mQISoHwmmKzHWOWR/m3Wba4wiaI3GEkNKWF4+FnXah6dSURdk2ho9ErWd0vxpeUGjQPtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787833; c=relaxed/simple;
	bh=4/NiTzMh9keqtirYL2aI8f4//oEtuSlc6IsakhE2XcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pdsr4ii74y61qw8iqMQhYd3VCu+IAZ2xU4jcpM1ntZJufqIXTA79M+trcDjGEUn2gNyGDNM4fqAmUf/jVEUJwZiRKZpfV7TNySV3+f2I60b0H64HDhTXODGErsAHupfWlRByGvMe9v2siMXE2AIqvTKvJgTAAQfQyPBC1/CiVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQwMYm6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD586C4CEF5;
	Mon, 10 Nov 2025 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787832;
	bh=4/NiTzMh9keqtirYL2aI8f4//oEtuSlc6IsakhE2XcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQwMYm6ZOfzM7bhvnvuyx+ZuRz17RKu2Y5151m9WX8YpLI6OYbRivm3JuCCbUqMP9
	 2uRQXLpW20r7q8l0s+CJMeZxHoiQ766yKIWy5iMBCRx4EOCExgAOkT7lyk5eCDZlf3
	 RXMhvH9OecPP8ofLFS/uAsWLYddglgxG0HOXC5anSxRxRrqxHOngzz3D/diMhyp/Zx
	 4ZwNuj20U6w2ZoBFcKpIssKFkuM3DfeGUowdsydLOkrWz+USB0VlhkHttIGBcjkjCW
	 m/gi7K4dmkgPmAvjCw/rUMLy+liIoKMR+CHey5/FqeoHI8BL6/LqtgnPNucQp1hb83
	 7U7sgAj4OiJLA==
Date: Mon, 10 Nov 2025 09:21:18 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Vinod Koul <vkoul@kernel.org>, 
	Thomas Andreatta <thomasandreatta2000@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Olivier Dautricourt <olivierdautricourt@gmail.com>, 
	Stefan Roese <sr@denx.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/13] scatterlist: introduce sg_nents_for_dma() helper
Message-ID: <jea2owcqtjeomlbwkfopt3ujsnakn4p3xeyqhh7s4kowf7k7dr@deyg5pky5udo>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
 <20251110103805.3562136-2-andriy.shevchenko@linux.intel.com>
 <waid6zxayuxacb6sntlxwgyjia3w25sfz2tzxxzb4tkqgmx63o@ndpztxeh6o32>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <waid6zxayuxacb6sntlxwgyjia3w25sfz2tzxxzb4tkqgmx63o@ndpztxeh6o32>

On Mon, Nov 10, 2025 at 09:05:26AM -0600, Bjorn Andersson wrote:
> On Mon, Nov 10, 2025 at 11:23:28AM +0100, Andy Shevchenko wrote:
> > Sometimes the user needs to split each entry on the mapped scatter list
> > due to DMA length constrains. This helper returns a number of entities
> > assuming that each of them is not bigger than supplied maximum length.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/linux/scatterlist.h |  2 ++
> >  lib/scatterlist.c           | 25 +++++++++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> > 
> > diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> > index 29f6ceb98d74..6de1a2434299 100644
> > --- a/include/linux/scatterlist.h
> > +++ b/include/linux/scatterlist.h
> > @@ -441,6 +441,8 @@ static inline void sg_init_marker(struct scatterlist *sgl,
> >  
> >  int sg_nents(struct scatterlist *sg);
> >  int sg_nents_for_len(struct scatterlist *sg, u64 len);
> > +int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len);
> > +
> >  struct scatterlist *sg_last(struct scatterlist *s, unsigned int);
> >  void sg_init_table(struct scatterlist *, unsigned int);
> >  void sg_init_one(struct scatterlist *, const void *, unsigned int);
> > diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> > index 4af1c8b0775a..4d1a010f863c 100644
> > --- a/lib/scatterlist.c
> > +++ b/lib/scatterlist.c
> > @@ -64,6 +64,31 @@ int sg_nents_for_len(struct scatterlist *sg, u64 len)
> >  }
> >  EXPORT_SYMBOL(sg_nents_for_len);
> >  
> > +/**
> > + * sg_nents_for_dma - return the count of DMA-capable entries in scatterlist
> > + * @sgl:	The scatterlist
> > + * @sglen:	The current number of entries
> > + * @len:	The maximum length of DMA-capable block
> > + *
> > + * Description:
> > + * Determines the number of entries in @sgl which would be permitted in
> > + * DMA-capable transfer if list had been split accordingly, taking into
> > + * account chaining as well.
> > + *
> > + * Returns:
> > + *   the number of sgl entries needed
> > + *
> > + **/
> > +int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len)

All but two clients store the value in an unsigned int. Changing the
return type to unsigned int also signals that the function is just
returning a count (no errors).

Regards,
Bjorn

> > +{
> > +	struct scatterlist *sg;
> > +	int i, nents = 0;
> > +
> > +	for_each_sg(sgl, sg, sglen, i)
> > +		nents += DIV_ROUND_UP(sg_dma_len(sg), len);
> > +	return nents;
> > +}
> 
> We need an EXPORT_SYMBOL() here.
> 
> With that, this looks good to me.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> Regards,
> Bjorn
> 
> > +
> >  /**
> >   * sg_last - return the last scatterlist entry in a list
> >   * @sgl:	First entry in the scatterlist
> > -- 
> > 2.50.1
> > 
> > 
> 

