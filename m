Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7861C7057
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2020 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgEFMcr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 May 2020 08:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgEFMcr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 May 2020 08:32:47 -0400
Received: from localhost (unknown [122.181.213.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 969E02073A;
        Wed,  6 May 2020 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588768366;
        bh=2HeHx25rrbmAOidE8OdtADn4dMn0JO5uB8keXJ9LGsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b89rqPTZL86KL9HPgEN+MW9gSGTaXzI8BLG9Z/WHKb1Ys5hRxIeznn1tri/k7+uKj
         pvuMvU75o4Wl+Uo3/pQ8gvrcTr1CJK+cwxCCs/NX+heMIJOPvAhEcagkEeAbi8Og0j
         ZwfudM63ZNrO6BPQFDCoN0puq+7EuExmGtTCNGjI=
Date:   Wed, 6 May 2020 18:02:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dmaengine: cookie bypass for out of order completion
Message-ID: <20200506123236.GB1375924@vkoul-mobl>
References: <158827174736.34343.16479132955205930987.stgit@djiang5-desk3.ch.intel.com>
 <20200504053959.GI1375924@vkoul-mobl>
 <f5207da6-f54e-1402-f5b1-7f52baa58132@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5207da6-f54e-1402-f5b1-7f52baa58132@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dave,

On 04-05-20, 07:59, Dave Jiang wrote:
> On 5/3/2020 10:39 PM, Vinod Koul wrote:
> > On 30-04-20, 11:35, Dave Jiang wrote:
> > > The cookie tracking in dmaengine expects all submissions completed in
> > 
> > Correct and that is a *very* fundamental assumption of the cookie
> > management. Modifying this will cause impact to other as well..
> 
> The current modification only impacts drivers that opt out of this. So all
> existing or future driver does not return the out of order flag should
> remain unimpacted.
> 
> > 
> > > order. Some DMA devices like Intel DSA can complete submissions out of
> > > order, especially if configured with a work queue sharing multiple DMA
> > > engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned for
> > 
> > We should add this as a capability in dmaengine. How else would users
> > know if they can expect out of order completion..
> 
> Hmmm...this is more an attribute of the hardware rather than a capability
> that a user would request right? Should we add a new function that would
> provide an avenue for users to query the device on such attributes and
> others like channel depth or SGL max size?

Well we have capabilities of hw reported so that users knows. This
should also be a capability reported

> > > those DMA devices. The user should use callbacks to track the completion
> > > rather than the DMA cookie. This would address the issue of dmatest
> > > complaining that descriptors are "busy" when the cookie count goes
> > > backwards due to out of order completion.
> > 
> > Can we add some documentation for this behaviour as well
> 
> sure thing.
> 
> > 
> > > 
> > > Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
> > > ---
> > >   drivers/dma/dmatest.c     |    3 ++-
> > >   drivers/dma/idxd/dma.c    |    2 +-
> > >   include/linux/dmaengine.h |    1 +
> > >   3 files changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> > > index a2cadfa2e6d7..60a4a9cec3c8 100644
> > > --- a/drivers/dma/dmatest.c
> > > +++ b/drivers/dma/dmatest.c
> > > @@ -821,7 +821,8 @@ static int dmatest_func(void *data)
> > >   			result("test timed out", total_tests, src->off, dst->off,
> > >   			       len, 0);
> > >   			goto error_unmap_continue;
> > > -		} else if (status != DMA_COMPLETE) {
> > > +		} else if (status != DMA_COMPLETE &&
> > > +			   status != DMA_OUT_OF_ORDER) {
> > >   			result(status == DMA_ERROR ?
> > >   			       "completion error status" :
> > >   			       "completion busy status", total_tests, src->off,
> > > diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> > > index c64c1429d160..3f54826abc12 100644
> > > --- a/drivers/dma/idxd/dma.c
> > > +++ b/drivers/dma/idxd/dma.c
> > > @@ -133,7 +133,7 @@ static enum dma_status idxd_dma_tx_status(struct dma_chan *dma_chan,
> > >   					  dma_cookie_t cookie,
> > >   					  struct dma_tx_state *txstate)
> > >   {
> > > -	return dma_cookie_status(dma_chan, cookie, txstate);
> > > +	return DMA_OUT_OF_ORDER;
> > 
> > So you are returning out of order always?
> 
> Yes. The hardware does not gaurantee in order processing at all. The only
> way to do so is to submit a batched operation with fence set on every
> descriptor in the batch.
> 
> > 
> > >   }
> > >   /*
> > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > index 21065c04c4ac..a0c130131e45 100644
> > > --- a/include/linux/dmaengine.h
> > > +++ b/include/linux/dmaengine.h
> > > @@ -39,6 +39,7 @@ enum dma_status {
> > >   	DMA_IN_PROGRESS,
> > >   	DMA_PAUSED,
> > >   	DMA_ERROR,
> > > +	DMA_OUT_OF_ORDER,
> > >   };
> > >   /**
> > 

-- 
~Vinod
