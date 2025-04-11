Return-Path: <dmaengine+bounces-4880-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB7AA8681F
	for <lists+dmaengine@lfdr.de>; Fri, 11 Apr 2025 23:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E9417A172
	for <lists+dmaengine@lfdr.de>; Fri, 11 Apr 2025 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D37298988;
	Fri, 11 Apr 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0lCBHcK"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1404B28137D
	for <dmaengine@vger.kernel.org>; Fri, 11 Apr 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406611; cv=none; b=Y9Rz8eYsjBf1pEkfdy7pUDZ1ZLl5kANG0DtW6ZGVS+2M3vc5NAmQYJd3rsoNFtiZj7S6ZDYVog1rdnnu7T3LNAnPZdeymNl+nuvS6hcZOisUX7/GZB9W0CIYJYz++IoDWRQC9c9WqzIa04mmePHABlxNysXDIArjk/xPpmti1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406611; c=relaxed/simple;
	bh=cT/cquOiK5kJbCKhWNDsa/HD2qOKMLcuuMPbjMzKudQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1FQ7E9I7fnP/bQ0kdSxKtPtGHKMwvm1bM7qofLYaFKkaIHhwXnjMhr3mmfSQkXlbtTZbw52X1ZtCb7JKEw2T55dgpF6LmchCjb8O9ED+LV5kmtV0gd2Mxvtubq0dhCGzD/OblPm7385nX6ZS0cN6XuugEgIs7rnHX1chkTLpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0lCBHcK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744406608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8LHwnmfwnlUW2PNBPXgiSju2q0/JsD2x4Yxk0rIXgs=;
	b=F0lCBHcKvf6MAKC8S8lqfLIXS3zJ7g8VQJg/dnjhFBghcLvIetvZl1aBaeuzByzDU6S5gy
	+GHcBx2fHM6hxPjtNuBneEUQWqXkR5tgYQyVVbdgENlBFjn80HmBVTq/FHrQQq3trGEOXX
	+ujMALbMGPMorHuAgv5wsBjI7be+yy0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-R2JoGHHMPrii-x6bjEouvQ-1; Fri,
 11 Apr 2025 17:23:25 -0400
X-MC-Unique: R2JoGHHMPrii-x6bjEouvQ-1
X-Mimecast-MFC-AGG-ID: R2JoGHHMPrii-x6bjEouvQ_1744406603
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DBA819560B3;
	Fri, 11 Apr 2025 21:23:23 +0000 (UTC)
Received: from f39 (unknown [10.22.65.78])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78F8E180B486;
	Fri, 11 Apr 2025 21:23:21 +0000 (UTC)
Date: Fri, 11 Apr 2025 23:23:18 +0200
From: Eder Zulian <ezulian@redhat.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Basavaraj.Natikar@amd.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, jsnitsel@redhat.com,
	ddutile@redhat.com
Subject: Re: [PATCH RFC 1/1] dmaengine: ptdma: use SLAB_TYPESAFE_BY_RCU for
 the DMA descriptor slab
Message-ID: <Z_mIRn6G1wBH5jfP@f39>
References: <20250411194148.247361-1-ezulian@redhat.com>
 <20250411194148.247361-2-ezulian@redhat.com>
 <41a120c8-e5ad-4a0f-96cf-1159d5d1b4e1@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a120c8-e5ad-4a0f-96cf-1159d5d1b4e1@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Dave,

On Fri, Apr 11, 2025 at 01:34:28PM -0700, Dave Jiang wrote:
> 
> 
> On 4/11/25 12:41 PM, Eder Zulian wrote:
> > The SLAB_TYPESAFE_BY_RCU flag prevents a change of type for objects
> > allocated from the slab cache (although the memory may be reallocated to
> > a completetly different object of the same type.) Moreover, when the
> > last reference to an object is dropped the finalization code must not
> > run until all __rcu pointers referencing the object have been updated,
> > and then a grace period has passed.
> 
> I would pull some of the explanation on why and how from your cover. Also, a fixes tag may be needed?

Sure. Thanks for your suggestion. I will add both the explanation and a
fixes tag. Right now I think the fixes tag would point to the initial
commit, but let me double check that on Monday. Maybe I should wait a bit
more and integrate feedback from others as well in a v2.

> 
> DJ
>  
> > 
> > Signed-off-by: Eder Zulian <ezulian@redhat.com>
> > ---
> >  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> > index 715ac3ae067b..b70dd1b0b9fb 100644
> > --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> > +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> > @@ -597,7 +597,8 @@ int pt_dmaengine_register(struct pt_device *pt)
> >  
> >  	pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
> >  					       sizeof(struct pt_dma_desc), 0,
> > -					       SLAB_HWCACHE_ALIGN, NULL);
> > +					       SLAB_HWCACHE_ALIGN |
> > +					       SLAB_TYPESAFE_BY_RCU, NULL);
> >  	if (!pt->dma_desc_cache) {
> >  		ret = -ENOMEM;
> >  		goto err_cache;
> 

Thank you,
Eder


