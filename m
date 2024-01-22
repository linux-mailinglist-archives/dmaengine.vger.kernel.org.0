Return-Path: <dmaengine+bounces-775-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA783610C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 12:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6041F25EA3
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453C3BB2A;
	Mon, 22 Jan 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT8RYILN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B483A8CF;
	Mon, 22 Jan 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921571; cv=none; b=KbhVNuO+FcKtHczjMqQBaJzYy75mhNWPltY6SKQI9rncK8P4ow+tgE7kCJuUKSQaGA/xhOLrxhTFH0GQg/Ma06seqkz0EWMtrvPYZfBrVHbRv42fa5V0pz6GI4H278zP4XLc1/Ix/9vPUF/imPLkh1Ll1L7m1DMu0iX1A+ZAceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921571; c=relaxed/simple;
	bh=V/MmW1yVoK0TjvFsg0TJRYR3IjhkDr66kgUMy4s5icQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvcnf1pF4l77Sqj6ZNXFA4DxtlwbXEKdUgirGkxng48oV2DZ7+TJMmKncGJVFb5EukEqa2xLluY/ztj47MH/6VFro1hbhQyAvPPdxAjDDleLOntZNMOH9EQp+2WTYZt7an2HpEqN1qtxhdI4hnZITZsU4FFnHcMlYFskgglijVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT8RYILN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C865C433C7;
	Mon, 22 Jan 2024 11:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921570;
	bh=V/MmW1yVoK0TjvFsg0TJRYR3IjhkDr66kgUMy4s5icQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sT8RYILNkg7DURq+DonPfOgYKWZzT9z1t7mKh5x8C8ZtDBgG2Ac0So6ocPeViznQk
	 +b371knvzEQWiydLKI1rfHATW4gAcoP59HbiRavhYPxlUmUDhWQYFGir8/FVGINZd4
	 4pbOy4f0jZXJrLq+pJ3U/hqDcEQirBEh7ORQTHlbVbDWuK1Bz5xSiDRJ61ytOBjCy+
	 MIKGPKdVLBk54rOk1kK1ZfjKmuXIlY6qfkGds5xNN06kmh+7o/uJaxX7pptL30KyeJ
	 KtePRH0INjn0SKiK3esQsx8GBl9w/Z8ZG+lbA3GAdrOUfJSnUjJhBs97oG+pTIzNU4
	 jhoAF4LEG4IIA==
Date: Mon, 22 Jan 2024 16:36:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH v5 3/8] dmaengine: Add API function
 dmaengine_prep_slave_dma_vec()
Message-ID: <Za5MHkzSjyVUoytI@matsya>
References: <20231219175009.65482-1-paul@crapouillou.net>
 <20231219175009.65482-4-paul@crapouillou.net>
 <ZYRWbROAuMXftH07@matsya>
 <86a30af0db2232bd473a38cd001342156cd4012e.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86a30af0db2232bd473a38cd001342156cd4012e.camel@crapouillou.net>

Hi Paul,


On 08-01-24, 13:20, Paul Cercueil wrote:
> Hi Vinod,
> 
> Le jeudi 21 décembre 2023 à 20:44 +0530, Vinod Koul a écrit :
> > On 19-12-23, 18:50, Paul Cercueil wrote:
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
> > > ---
> > >  include/linux/dmaengine.h | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > index 3df70d6131c8..ee5931ddb42f 100644
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
> 
> I don't want to be pushy, but I'd like to know how to solve this now,
> otherwise I'll just send the same patches for my v6.
> 
> > so you want to transfer multiple buffers, right? why not use
> > dmaengine_prep_slave_sg(). If there is reason for not using that one?
> 
> The reason is that we want to have the possibility to transfer less
> than the total size of the scatterlist, and that's currently very hard
> to do - scatterlists were designed to not be tampered with.
> 
> Christian König then suggested to introduce a "dma_vec" which had been
> on his TODO list for a while now.

Yeah for this interleaved seems overkill. Lets go with this api. I would
suggest change the name of the API replacing slave with peripheral
though

-- 
~Vinod

