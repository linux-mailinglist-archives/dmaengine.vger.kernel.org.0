Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340B236982D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 19:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhDWRVW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 13:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhDWRVV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 23 Apr 2021 13:21:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACEB3611BD;
        Fri, 23 Apr 2021 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619198444;
        bh=6nDF3Mx1RMRmqx9XA8SbAOUoFBZdUSTxHMGv17X3KeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZ8gyl+JM5UK7RbjYGlVTyDdRYnGeBz7XSGusTedMf9i+qbsOHa/Up9eZgChNNfbu
         ugqLQ0hA+sRFUWXPzVZuWGb+oSp11yuhvnM09uMYvwNeQyp3H6a5OQHMiheVcrOUQF
         wMLn02O5j9kTXhS7BVGdGEyyUz1lyf9FMzsrSB1aJlDizkuijSKIci2hci49WCfk5U
         GGNJjP0XGnQ6k+dObg/ooAPJ3HPGdMSr8J/jIa7B0w44mXu0MgoRIDLDBW3NHLrHRI
         6bSz3zQGWIjaRtPsJpAPQg777zj6qJJzY8q49h4OK8XEQJ8G3MmG5+yfb88u0wMQ58
         og3TkmjUfWp9A==
Date:   Fri, 23 Apr 2021 22:50:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>,
        dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Expand Xilinx CDMA functions
Message-ID: <YIMB6DpM//wrPC6q@vkoul-mobl.Dlink>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
 <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
 <YILKq+jNZZSs37xa@vkoul-mobl.Dlink>
 <bed31611-a084-2a05-f3a3-25585a47be9a@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed31611-a084-2a05-f3a3-25585a47be9a@metafoo.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-21, 15:51, Lars-Peter Clausen wrote:
> On 4/23/21 3:24 PM, Vinod Koul wrote:
> > On 23-04-21, 11:17, Lars-Peter Clausen wrote:
> > > It seems to me what we are missing from the DMAengine API is the equivalent
> > > of device_prep_dma_memcpy() that is able to take SG lists. There is already
> > > a memset_sg, it should be possible to add something similar for memcpy.
> > You mean something like dmaengine_prep_dma_sg() which was removed?
> > 
> Ah, that's why I could have sworn we already had this!

Even at that time we had the premise that we can bring the API back if
we had users. I think many have asked for it, but I havent seen a patch
with user yet :)

> > static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
> >                 struct dma_chan *chan,
> >                 struct scatterlist *dst_sg, unsigned int dst_nents,
> >                 struct scatterlist *src_sg, unsigned int src_nents,
> >                 unsigned long flags)
> > 
> > The problem with this API is that it would work only when src_sg and
> > dst_sg is of similar nature, if not then how should one go about
> > copying...should we fill without a care for dst_sg being different than
> > src_sg as long as total data to be copied has enough space in dst...
> At least for the CDMA the only requirement is that both buffers have the
> same total size.

I will merge if with a user but semantics need to be absolutely clear on
what is allowed and not, do I hear a volunteer ?
-- 
~Vinod
