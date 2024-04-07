Return-Path: <dmaengine+bounces-1751-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB06389AF88
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60ED2282296
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D810A26;
	Sun,  7 Apr 2024 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQL45DWu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022911181;
	Sun,  7 Apr 2024 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477946; cv=none; b=XJiZkaY4n3V0WZHEV1XviI6K4iscHG5y2dolkQLTwkCSU5ijA0WEhDWJUhAvHsbdzHxbSMOjH0e7BYeMUcAt8Wq3CK+bFcuP2yA62UCKX0RYKUgo1r7ODvQhIJlTTu8Dp3RLnRJ6Jq45NKvasTp4BV+a0vT7WaK4UCyv3UC3pfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477946; c=relaxed/simple;
	bh=e9UXYTAc5sFI75CK5XgqAQXmOoDPNUpaUP0KGJszuPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpJ5bzhQftrsakbUNkfUzf5EhcJGC3Ma6cIAEau8+6/BYp/oqghW+0N3jLzwt4nAtO6cKgDl3Grgh7RZJV9+6QeJkueIyPIvasQdRANJ5UGh6NijnLaDalSjZgoS3JBR95I/nb6qb8bDvPirgNRkirmVsLJGyLGym8r29qhcUwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQL45DWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F29BC433F1;
	Sun,  7 Apr 2024 08:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712477945;
	bh=e9UXYTAc5sFI75CK5XgqAQXmOoDPNUpaUP0KGJszuPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQL45DWu0HxJomMb0clRFnENNm4bArAijal3EZ3qTPml9cdTdnQD/Jv+nZ6r4estn
	 tdFm3p3nVi1vJ7RNY79r2A213/2M8AZsb3FfhENk6Agglm3lvLZmkpgMrH5L3HWAuU
	 1mdfJp57B03c6ql4jqZ4OM6opBEQZTdC85Czud6bGKKwlGvmwv3roxGCrb88TvH02/
	 TPIjgoqyRoHs4zvdtsgjgaUksKCcFJEmaIFG1lDVXc4m8ISrskkrOi2Hn/iIHyNQtI
	 JNoPhQ3FBDp0yzYfHuEd/7iNzyF1QjxWLZZwhc+321A+Kax/Gni7nVcjqHjoPfQVAD
	 +9J6be2H9OZHg==
Date: Sun, 7 Apr 2024 13:49:00 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v9 1/6] dmaengine: Add API function
 dmaengine_prep_peripheral_dma_vec()
Message-ID: <ZhJW9JEqN2wrejvC@matsya>
References: <20240310124836.31863-1-paul@crapouillou.net>
 <20240310124836.31863-2-paul@crapouillou.net>
 <ZgUM1LFEWs3lwoAU@matsya>
 <599394c0220079b7b42dc732be817ca8a1eb4214.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <599394c0220079b7b42dc732be817ca8a1eb4214.camel@crapouillou.net>

On 02-04-24, 13:31, Paul Cercueil wrote:
> Hi Vinod,
> 
> Le jeudi 28 mars 2024 à 11:53 +0530, Vinod Koul a écrit :
> > On 10-03-24, 13:48, Paul Cercueil wrote:
> > > This function can be used to initiate a scatter-gather DMA
> > > transfer,
> > > where the address and size of each segment is located in one entry
> > > of
> > > the dma_vec array.
> > > 
> > > The major difference with dmaengine_prep_slave_sg() is that it
> > > supports
> > > specifying the lengths of each DMA transfer; as trying to override
> > > the
> > > length of the transfer with dmaengine_prep_slave_sg() is a very
> > > tedious
> > > process. The introduction of a new API function is also justified
> > > by the
> > > fact that scatterlists are on their way out.
> > > 
> > > Note that dmaengine_prep_interleaved_dma() is not helpful either in
> > > that
> > > case, as it assumes that the address of each segment will be higher
> > > than
> > > the one of the previous segment, which we just cannot guarantee in
> > > case
> > > of a scatter-gather transfer.
> > > 
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > 
> > > ---
> > > v3: New patch
> > > 
> > > v5: Replace with function dmaengine_prep_slave_dma_vec(), and
> > > struct
> > >     'dma_vec'.
> > >     Note that at some point we will need to support cyclic
> > > transfers
> > >     using dmaengine_prep_slave_dma_vec(). Maybe with a new "flags"
> > >     parameter to the function?
> > > 
> > > v7:
> > >   - Renamed *device_prep_slave_dma_vec() ->
> > > device_prep_peripheral_dma_vec();
> > >   - Added a new flag parameter to the function as agreed between
> > > Paul
> > >     and Vinod. I renamed the first parameter to prep_flags as it's
> > > supposed to
> > >     be used (I think) with enum dma_ctrl_flags. I'm not really sure
> > > how that API
> > >     can grow but I was thinking in just having a bool cyclic
> > > parameter (as the
> > >     first intention of the flags is to support cyclic transfers)
> > > but ended up
> > >     "respecting" the previously agreed approach.
> > > ---
> > >  include/linux/dmaengine.h | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > index 752dbde4cec1..856df8cd9a4e 100644
> > > --- a/include/linux/dmaengine.h
> > > +++ b/include/linux/dmaengine.h
> > > @@ -160,6 +160,16 @@ struct dma_interleaved_template {
> > >  	struct data_chunk sgl[];
> > >  };
> > >  
> > > +/**
> > > + * struct dma_vec - DMA vector
> > > + * @addr: Bus address of the start of the vector
> > > + * @len: Length in bytes of the DMA vector
> > > + */
> > > +struct dma_vec {
> > > +	dma_addr_t addr;
> > > +	size_t len;
> > > +};
> > > +
> > >  /**
> > >   * enum dma_ctrl_flags - DMA flags to augment operation
> > > preparation,
> > >   *  control completion, and communicate status.
> > > @@ -910,6 +920,10 @@ struct dma_device {
> > >  	struct dma_async_tx_descriptor
> > > *(*device_prep_dma_interrupt)(
> > >  		struct dma_chan *chan, unsigned long flags);
> > >  
> > > +	struct dma_async_tx_descriptor
> > > *(*device_prep_peripheral_dma_vec)(
> > > +		struct dma_chan *chan, const struct dma_vec *vecs,
> > > +		size_t nents, enum dma_transfer_direction
> > > direction,
> > > +		unsigned long prep_flags, unsigned long flags);
> > >  	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
> > >  		struct dma_chan *chan, struct scatterlist *sgl,
> > >  		unsigned int sg_len, enum dma_transfer_direction
> > > direction,
> > > @@ -973,6 +987,19 @@ static inline struct dma_async_tx_descriptor
> > > *dmaengine_prep_slave_single(
> > >  						  dir, flags,
> > > NULL);
> > >  }
> > >  
> > > +static inline struct dma_async_tx_descriptor
> > > *dmaengine_prep_peripheral_dma_vec(
> > > +	struct dma_chan *chan, const struct dma_vec *vecs, size_t
> > > nents,
> > > +	enum dma_transfer_direction dir, unsigned long prep_flags,
> > > +	unsigned long flags)
> > > +{
> > > +	if (!chan || !chan->device || !chan->device-
> > > >device_prep_peripheral_dma_vec)
> > > +		return NULL;
> > > +
> > > +	return chan->device->device_prep_peripheral_dma_vec(chan,
> > > vecs, nents,
> > > +							    dir,
> > > prep_flags,
> > > +							   
> > > flags);
> > > +}
> > 
> > API looks good to me, thanks
> > Few nits though:
> > - Can we add kernel-doc for this new API please
> > - Also update the documentation adding this new api
> > - Lastly, we seem to have two flags, I know you have added a comment
> > but
> >   I dont seem to recall the discussion (looked at old threads for
> > clue
> >   as well), can you please remind me why we need both? And in your
> > case,
> >   what is the intended usage of these flags, i would prefer single
> >   clean one...
> > 
> 
> The "prep_flags" is a mask of "enum dma_ctrl_flags".
> 
> The second "flags" was supposed to be specific to this function, and
> was to future-proof the API as we eventually want to have a "cyclic"
> flag, which would emulate a cyclic transfer by linking the SG hardware
> descriptors accordingly.
> 
> However - I think we can already do that with DMA_PREP_REPEAT and
> DMA_PREP_LOAD_EOT, right? So we can probably drop the second "flags".

Yeah that could be done, we should add Documentation to clarify this

-- 
~Vinod

