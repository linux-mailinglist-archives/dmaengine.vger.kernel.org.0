Return-Path: <dmaengine+bounces-4899-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A8A89DF8
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 14:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1D3442C1A
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 12:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A68204F81;
	Tue, 15 Apr 2025 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThisYkbb"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B328E3F
	for <dmaengine@vger.kernel.org>; Tue, 15 Apr 2025 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719844; cv=none; b=cYKpt83eCtRdLJdgN592UuvlH1XKStikz5fuwBwlcb64lYh/NIyxAbwi1mSoRq5J4q4j6B9XGO5D2UXjfCKjbIxj8KQr7LcYopbeDozwSr1/uU1Is0UXeUdELzH/lYn9USDI7icCesL61bqDCDQNrZJGVjNUHGvdmIsXhnO/B3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719844; c=relaxed/simple;
	bh=b/pzgfnIhjNBJcq/S8/1l0RsJNTfD6XOM3mOkmG1ntk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avVQIxbq+ZL7RJ6fS2WjZhqDeK0RTw8MKGLUtJ/c3TurrrwXT6AlCcF0zoi9G8PZ2BjvVNG2wKhZhe3AZuDr8cMFoWmDtFtb3Uv2kE5bXJW7ZNDkboQMHO7mfflp3uQufXSTgJoNI5xwfxDY3jqpD1tJuqKcQMsQmmUJhxFihGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThisYkbb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744719841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wkzv6EQZzHxHc8eCWYu69gq70uV4laVRsXuWVaOH3yI=;
	b=ThisYkbb4+GrHXvDmY03cyxiMEat+ylzC6qZDNIIpSJU241gKwBZmvuSbIcRnKI7jp1EIr
	ZIoHpshp/MGcWn/q6qs8YopqaOgP7mvbKdAYdtsjHoFPzKbZpYYHxg6J+yJBNu31xn0Rz4
	nc836tXucXMsxp3MSwxGd9UDTVCwt+Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-kUD4lY17PE66YQGqoFajoQ-1; Tue,
 15 Apr 2025 08:23:57 -0400
X-MC-Unique: kUD4lY17PE66YQGqoFajoQ-1
X-Mimecast-MFC-AGG-ID: kUD4lY17PE66YQGqoFajoQ_1744719836
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88C1919560BB;
	Tue, 15 Apr 2025 12:23:56 +0000 (UTC)
Received: from f39 (unknown [10.44.32.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9A3C180886A;
	Tue, 15 Apr 2025 12:23:54 +0000 (UTC)
Date: Tue, 15 Apr 2025 14:23:51 +0200
From: Eder Zulian <ezulian@redhat.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Basavaraj.Natikar@amd.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ptdma: Remove unused pointer dma_cmd_cache
Message-ID: <Z_5P1563zcU3xpek@f39>
References: <20250409114019.42026-1-ezulian@redhat.com>
 <87v7r673kv.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7r673kv.fsf@AUSNATLYNCH.amd.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello Nathan,

On Mon, Apr 14, 2025 at 05:58:40PM -0500, Nathan Lynch wrote:
> Eder Zulian <ezulian@redhat.com> writes:
> > The pointer 'struct kmem_cache *dma_cmd_cache' was introduced in commit
> > b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA
> > resource") but it was never used.
> >
> > Signed-off-by: Eder Zulian <ezulian@redhat.com>
> > ---
> >  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 3 ---
> >  drivers/dma/amd/ptdma/ptdma.h           | 1 -
> >  2 files changed, 4 deletions(-)
> >
> > diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> > index 715ac3ae067b..3f7f6da05142 100644
> > --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> > +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> > @@ -656,8 +656,6 @@ int pt_dmaengine_register(struct pt_device *pt)
> >  	kmem_cache_destroy(pt->dma_desc_cache);
> >  
> >  err_cache:
> > -	kmem_cache_destroy(pt->dma_cmd_cache);
> > -
> 
> I think you could remove the 'err_cache' label and convert the users of it
> to return -ENOMEM directly, since there aren't any unmanaged allocations
> to unwind:
> 
> 	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
> 					 "%s-dmaengine-desc-cache",
> 					 dev_name(pt->dev));
> 	if (!desc_cache_name) {
> 		ret = -ENOMEM;
> 		goto err_cache;
> 	}
> 
> 	pt->dma_desc_cache = kmem_cache_create(desc_cache_name,
> 					       sizeof(struct pt_dma_desc), 0,
> 					       SLAB_HWCACHE_ALIGN, NULL);
> 	if (!pt->dma_desc_cache) {
> 		ret = -ENOMEM;
> 		goto err_cache;
> 	}
> 
> Otherwise LGTM.
> 
Thank you for your review and suggestion. Please find a link to the v2.

https://lore.kernel.org/dmaengine/20250415121312.870124-1-ezulian@redhat.com/

Eder


