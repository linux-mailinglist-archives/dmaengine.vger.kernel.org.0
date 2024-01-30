Return-Path: <dmaengine+bounces-906-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75756842B83
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 19:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B701C24282
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF81292DB;
	Tue, 30 Jan 2024 18:14:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6578D1552EC;
	Tue, 30 Jan 2024 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638461; cv=none; b=IcqAukhc1I0N5NCR6nP1sMM0Wvz5bSQmvuoC71R5S165g9m8jy/6Q+5VOgHhLwOHqAC1QMFj6DmKFYvb5HUSvHJIB2+f3NCucb1SQEUO7SnY0kox1Q9OkRdC20sY43ABVr18X+ds6K13I1/XkAgzYNuFfFDQXD+NNCa6Uq1+7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638461; c=relaxed/simple;
	bh=/tqXGxwF3b22rn3wgrCe0BaGaBi/qiWgcoDjGcjSu3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6lwPSgClyT1VU+qon9gZJC4mOu8UtTjBiDKt6eQ8RqxXnBNIIWyw9jJeIf3J98oWct9dUtWjLtg1YzY9Voj/dPVPVQGOqyGYxkv+BYj/ZBZsVIRtst88ymCOef4ndXUUeVXYyp8UHPwZlNO/TU/z98RbD9IFpxIOpeirf8CW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A28E6DA7;
	Tue, 30 Jan 2024 10:14:59 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.45.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7811B3F762;
	Tue, 30 Jan 2024 10:14:14 -0800 (PST)
Date: Tue, 30 Jan 2024 18:14:11 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Nikhil Rao <nikhil.rao@intel.com>, Tony Zhu <tony.zhu@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] dmaengine: idxd: Change wmb() to smp_wmb() when copying
 completion record to user space
Message-ID: <Zbk8c6l5gZslj6wJ@FVFF77S0Q05N>
References: <20240130025806.2027284-1-fenghua.yu@intel.com>
 <Zbk4wGNcB-g91Vr0@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbk4wGNcB-g91Vr0@FVFF77S0Q05N>

On Tue, Jan 30, 2024 at 05:58:24PM +0000, Mark Rutland wrote:
> This patch might be ok (it looks reasonable as an optimization), but I think
> the description of wmb() and smp_wmb() is incorrect. I also think that you're
> missing an rmb()/smp_rmb()eor equivalent on the reader side.

Sorry, the above should have said:
	
	an rmb()/smp_rmb() *or* equivalent

> 
> On Mon, Jan 29, 2024 at 06:58:06PM -0800, Fenghua Yu wrote:
> > wmb() is used to ensure status in the completion record is written
> > after the rest of the completion record, making it visible to the user.
> > However, on SMP systems, this may not guarantee visibility across
> > different CPUs.
> > 
> > Considering this scenario that event log handler is running on CPU1 while
> > user app is polling completion record (cr) status on CPU2:
> > 
> > 	CPU1				CPU2
> > event log handler			user app
> > 
> > 					1. cr = 0 (status = 0)
> > 2. copy X to user cr except "status"
> > 3. wmb()
> > 4. copy Y to user cr "status"
> > 					5. poll status value Y
> > 				 	6. read rest cr which is still 0.
> > 					   cr handling fails
> > 					7. cr value X visible now
> > 
> > Although wmb() ensure value Y is written and visible after X is written
> > on CPU1, the order is not guaranteed on CPU2. So user app may see status
> > value Y while cr value X is still not visible yet on CPU2. This will
> > cause reading 0 from the rest of cr and cr handling fails.
> 
> The wmb() on CPU1 ensures the order of the reads, but you need an rmb() on CPU2

Sorry again, the above should have said:

	The wmb() on CPU1 ensures the order of the *writes*

Apologies for any confusion resulting from those mistakes.

Mark.

> between reading the 'status' and 'rest' parts; otherwise CPU2 (or the
> compiler!) is permitted to hoist the read of 'rest' early, before reading from
> 'status', and hence you can end up with a sequence that is effectively:
> 
> 	CPU1				CPU2
>   event log handler			user app
> 					
>   					1. cr = 0 (status = 0)
>   				 	6a. read rest cr which is still 0.
>   2. copy X to user cr except "status"
>   3. wmb()
>   4. copy Y to user cr "status"
>   					5. poll status value Y
>   					6b. cr handling fails
>   					7. cr value X visible now
> 
> Since this is all to regular cacheable memory, it's *sufficient* to use
> smp_wmb() and smp_rmb(), but that's an optimization rather than an ordering
> fix.
> 
> Note that on x86_64, TSO means that the stores are in-order (and so smp_wmb()
> is just a compiler barrier), and IIUC loads are not reordered w.r.t. other
> loads (and so smp_rmb() is also just a compiler barrier).
> 
> > Changing wmb() to smp_wmb() ensures Y is written after X on both CPU1
> > and CPU2. This guarantees that user app can consume cr in right order.
> 
> This implies that smp_wmb() is *stronger* than wmb(), whereas smp_wmb() is
> actually *weaker* (e.g. on x86_64 wmb() is an sfence, whereas smp_wmb() is a
> barrier()).
> 
> Thanks,
> Mark.
> 
> > 
> > Fixes: b022f59725f0 ("dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling")
> > Suggested-by: Nikhil Rao <nikhil.rao@intel.com>
> > Tested-by: Tony Zhu <tony.zhu@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> >  drivers/dma/idxd/cdev.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> > index 77f8885cf407..9b7388a23cbe 100644
> > --- a/drivers/dma/idxd/cdev.c
> > +++ b/drivers/dma/idxd/cdev.c
> > @@ -681,9 +681,10 @@ int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
> >  		 * Ensure that the completion record's status field is written
> >  		 * after the rest of the completion record has been written.
> >  		 * This ensures that the user receives the correct completion
> > -		 * record information once polling for a non-zero status.
> > +		 * record information on any CPU once polling for a non-zero
> > +		 * status.
> >  		 */
> > -		wmb();
> > +		smp_wmb();
> >  		status = *(u8 *)cr;
> >  		if (put_user(status, (u8 __user *)addr))
> >  			left += status_size;
> > -- 
> > 2.37.1
> > 
> > 
> 

