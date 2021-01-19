Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866F32FBF69
	for <lists+dmaengine@lfdr.de>; Tue, 19 Jan 2021 19:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbhASSsO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Jan 2021 13:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbhASS22 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 Jan 2021 13:28:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4BFE20706;
        Tue, 19 Jan 2021 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611074312;
        bh=bYfPJr7IQjJOjlgpiF/HJm9OHSZLjC+nl2dgDEXIMYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABvBWkGe+Mz1LPmpywiu90WQvntlmqlR5etSKZQj0pY5L3xN+efqwcSiLHUlOj2+K
         Tq74Q3k228tTU3ILHUiGAVoGAnq4jOabygXSbSUCOeQgwVZGYDm75U7PfUQ7ZwRYzY
         jV15Keifg47loly+w2vRggSSOmXMNaNWiBauiU8ts6B4FD08Nw+qHjxYNGWCbqCwsS
         ku5Ww9fiZ3+3tgSKWnux19PI57fipZmeJtcyqATQgDnji3F35KA+xylGtQbZjbkwe3
         i1KrTY43JgGQrU4Jgx2TtpEfLmVOQ/jgIlp19X98lvwsFk5wkg/b5ZRzTJCN8O7/+4
         ufNWUtiNlogow==
Date:   Tue, 19 Jan 2021 22:08:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add module parameter to force disable
 of SVA
Message-ID: <20210119163822.GC2771@vkoul-mobl>
References: <161074811013.2184257.13335125853932003159.stgit@djiang5-desk3.ch.intel.com>
 <20210117065115.GL2771@vkoul-mobl>
 <a7b50b40-ee4a-24c3-d4ba-40c770c970f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b50b40-ee4a-24c3-d4ba-40c770c970f1@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-01-21, 10:06, Dave Jiang wrote:
> 
> On 1/16/2021 11:51 PM, Vinod Koul wrote:
> > On 15-01-21, 15:01, Dave Jiang wrote:
> > > Add a module parameter that overrides the SVA feature enabling. This keeps
> > > the driver in legacy mode even when intel_iommu=sm_on is set. In this mode,
> > > the descriptor fields must be programmed with dma_addr_t from the Linux DMA
> > > API for source, destination, and completion descriptors.
> > > 
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > ---
> > >   drivers/dma/idxd/init.c |    8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > > index 25cc947c6179..9687a24ff982 100644
> > > --- a/drivers/dma/idxd/init.c
> > > +++ b/drivers/dma/idxd/init.c
> > > @@ -26,6 +26,10 @@ MODULE_VERSION(IDXD_DRIVER_VERSION);
> > >   MODULE_LICENSE("GPL v2");
> > >   MODULE_AUTHOR("Intel Corporation");
> > > +static bool sva = true;
> > > +module_param(sva, bool, 0644);
> > > +MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
> > Documentation for this please..
> 
> Just comments or is there somewhere specific for driver module parameter
> documentations?

All the parameters are supposed to be documented in Documentation/admin-guide/kernel-parameters.txt

Thanks

-- 
~Vinod
