Return-Path: <dmaengine+bounces-4943-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D1A97497
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 20:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AB31893327
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B10296179;
	Tue, 22 Apr 2025 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHOKjfGD"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7DF290097
	for <dmaengine@vger.kernel.org>; Tue, 22 Apr 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347305; cv=none; b=o8j/9M8Jyuma3UQWtwSmSD4nGr21jC8TtHeklBGTKkhUVaTBgeNIZrOKDsJNWjzlp4xJ3nKqCqjJlRTsQ5ygY1fMZfeJW0O3pGDfEnqgWKVAcd16Y52ak92gMzT6BK4twGMP8fFfphTBN72TGklh6ssJ2aMA876XrmljD4hqLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347305; c=relaxed/simple;
	bh=jIcPwdCVJ4oPl3FG8BiGvp9E06ch1KDrjP/gHM9Et0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEA7d0wnPNLSq+wDmOOi6nLY0ZAKGHrB7KKC6tvZgbmfRfRG7kqjWACtj5T7PEhXi3cfOzqp+JSuQftOCbY01Td6+9cnlcnfonmLQZPq4HgOROo7b71jJ0i9DmmOjZcJmfE0IDWBc3tXNqvmvGFImAhEALv0tD2N94E5ykY8L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHOKjfGD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745347302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQm82sFSaAR8XqBVikoka6Rm4k9SPi8HP+wCt/c07D8=;
	b=IHOKjfGDgesX+KU/P6zsimi+Fq6ggFI6KL9+CbIyYnJaNxL838nqiK0U+EJ7CKJBfvzhtn
	iI+DoXL/Adij3ZyT9gO+83Fjy4j0dzeYLgaXPPP8GeRuA7dP0Ib3oL2hM416tsKndBeJ2x
	iT2DvBqk2cFiCnx2woZu1wbiA/mDis4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-9SWX8oGzNGCd6pL2zxiPJw-1; Tue,
 22 Apr 2025 14:41:36 -0400
X-MC-Unique: 9SWX8oGzNGCd6pL2zxiPJw-1
X-Mimecast-MFC-AGG-ID: 9SWX8oGzNGCd6pL2zxiPJw_1745347295
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE9A0180087A;
	Tue, 22 Apr 2025 18:41:34 +0000 (UTC)
Received: from f39 (unknown [10.44.32.103])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82BF1180094C;
	Tue, 22 Apr 2025 18:41:32 +0000 (UTC)
Date: Tue, 22 Apr 2025 20:41:29 +0200
From: Eder Zulian <ezulian@redhat.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Basavaraj.Natikar@amd.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, jsnitsel@redhat.com,
	ddutile@redhat.com
Subject: Re: [PATCH RFC 1/1] dmaengine: ptdma: use SLAB_TYPESAFE_BY_RCU for
 the DMA descriptor slab
Message-ID: <aAfi2SeDqD8IybOJ@f39>
References: <20250411194148.247361-1-ezulian@redhat.com>
 <20250411194148.247361-2-ezulian@redhat.com>
 <87ikn2lcww.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikn2lcww.fsf@AUSNATLYNCH.amd.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello Nathan,

On Thu, Apr 17, 2025 at 04:02:23PM -0500, Nathan Lynch wrote:
> Eder Zulian <ezulian@redhat.com> writes:
> > The SLAB_TYPESAFE_BY_RCU flag prevents a change of type for objects
> > allocated from the slab cache (although the memory may be reallocated to
> > a completetly different object of the same type.) Moreover, when the
> > last reference to an object is dropped the finalization code must not
> > run until all __rcu pointers referencing the object have been updated,
> > and then a grace period has passed.
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
> 
> No, this code wasn't written to exploit SLAB_TYPESAFE_BY_RCU and this
> change can only obscure the problem. There's likely a data race in the
> driver.
> 

Ack. Let's conclude my RFC and discard the proposed patch then.
Thank you very much for your feedback. 

> I suspect pt_cmd_callback_work() has a bug:
> 
>         spin_lock_irqsave(&chan->vc.lock, flags);
>         if (desc) {
>                 if (desc->status != DMA_COMPLETE) {
>                         if (desc->status != DMA_ERROR)
>                                 desc->status = DMA_COMPLETE;
> 
>                         dma_cookie_complete(tx_desc);
>                         dma_descriptor_unmap(tx_desc);
>                 } else {
>                         tx_desc = NULL;
>                 }
>         }
>         spin_unlock_irqrestore(&chan->vc.lock, flags);
> 
>         if (tx_desc) {
>                 dmaengine_desc_get_callback_invoke(tx_desc, NULL);
>                 dma_run_dependencies(tx_desc);
> >>>>            list_del(&desc->vd.node); <<< must be done under vc.lock
>                 vchan_vdesc_fini(vd);
>         }
> 
> But that's relatively new code that may not be in the kernel you're
> running.
> 

True. pt_cmd_callback_work() wasn't in the kernel used for tests and it
seems to be used only if 'pt->ver == AE4_DMA_VERSION'. In that kernel
pt_cmd_callback() would call pt_handle_active_desc() which seemed to have
the same bug.

Eder


