Return-Path: <dmaengine+bounces-1866-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD52E8A89C2
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 19:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEB91F20CC4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E1171084;
	Wed, 17 Apr 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHChMN57"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207F171079;
	Wed, 17 Apr 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373409; cv=none; b=djQswGIQfjyFbPKDSuHyzwS6SP8x0cprZ3n4TjKXqsYncV5IY3KVucRkZxX9Abuga0i5u8MiWk+/9z+loIZAGSKZWKK3l1hBCmMcHTZmg5BSaHR2aslEPn/4L3Kf8hj2wEythdM3WrBf6ccfwSxYGyPnEXDNEIMzfDYnH7HLJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373409; c=relaxed/simple;
	bh=QjtQ6V3Ehbk5LLxAr33UNMioxKiRpcYG4jFh+UYBzEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvD51BoGQgl5RI6+hbFXuZXr5kOJRsGUUooYfCmUeuhen6hGwhyqKMVYZzadF6JdhvlX1l4dJ/LKqukTyoLYKlYUEWRuyJSbL4fv12x+6ZEE/o4IO75YJFwz8E7sPAGrLTK58nkB6h23q6/thh3merdT9xrJv32PQ1ceuwnrbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHChMN57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504D6C072AA;
	Wed, 17 Apr 2024 17:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713373408;
	bh=QjtQ6V3Ehbk5LLxAr33UNMioxKiRpcYG4jFh+UYBzEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHChMN57kBOXbFM4QTwzgQyXPTNjbqinV6W7wCepAN0W6oYfeaCyE6dgKeTCTR9Xv
	 G9gEj89fKjNhohGEO//tSrWYiXUTCgtUL61JfvkiXyV2qflbR+0Ju4n86LASM8Gklr
	 +SYKoh/Yf160Uj7zpDeF/vPQnEA2Fv5pwxKYmY8Alo+/cv6LvvuWDJvCTvbqkdCiR+
	 ctIWquCQr+S1e28UlSRsRzreoUOHkqDwxVp20LMc8VqBlaN6APWAr9UHoWtlRpq7B9
	 DfKauiiui1p6RXPmALDG6N2WTI0W9lAOJhlx+HXi7wSDkfmilRwd2jZmRjkXkkGUhE
	 vdQEAdyRcF6tw==
Date: Wed, 17 Apr 2024 22:33:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nishad Saraf <nishads@amd.com>, nishad.saraf@amd.com,
	sonal.santan@amd.com, max.zhen@amd.com
Subject: Re: [PATCH V10 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Message-ID: <ZiAA3C4wXaAHcJ1E@matsya>
References: <1709675352-19564-1-git-send-email-lizhi.hou@amd.com>
 <1709675352-19564-2-git-send-email-lizhi.hou@amd.com>
 <ZhKd7CHXHB7FadY0@matsya>
 <aa6a63c0-7cce-1f49-4ae5-3e5d93f98fe5@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa6a63c0-7cce-1f49-4ae5-3e5d93f98fe5@amd.com>

On 08-04-24, 11:06, Lizhi Hou wrote:

> > > +static void *qdma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
> > > +				   size_t *payload_len, size_t *max_len)
> > > +{
> > > +	struct qdma_mm_vdesc *vdesc;
> > > +
> > > +	vdesc = container_of(tx, typeof(*vdesc), vdesc.tx);
> > > +	if (payload_len)
> > > +		*payload_len = sizeof(vdesc->dev_addr);
> > > +	if (max_len)
> > > +		*max_len = sizeof(vdesc->dev_addr);
> > > +
> > > +	return &vdesc->dev_addr;
> > Can you describe what metadata is being used here for?
> 
> The metadata is the device address the dma request will transfer
> 
> data to / from.  Please see the example usage here:
> 
> https://github.com/houlz0507/XRT-1/blob/qdma_v1_usage/src/runtime_src/core/pcie/driver/linux/xocl/subdev/qdma.c#L311
> 
> Before dmaengine_submit(), it specifies the device address.

Hmmm, why is the vaddr passed like this, why not use slave_config for
this

-- 
~Vinod

