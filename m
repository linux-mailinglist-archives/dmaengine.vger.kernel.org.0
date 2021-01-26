Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8018C304BBB
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 22:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbhAZVuZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbhAZRDk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 12:03:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C416022EBD;
        Tue, 26 Jan 2021 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611680579;
        bh=bUosObEPj6sBUrbn1Vw5C/9VJJ2eDmdALlTgxMH/ih0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1Ctjdc16APYIO80/vAyDnXkJOPATRq8vAQ4XGokaXNNwlEHPGjoJjmD5Z5L5pj0A
         ytk+fyGbUcmuE8VQUk8L3c2h52CB/0x7Z+dHM1/KdDduuFgEUMs19WhzW0b/lSkqAr
         agj3UnYnx1UzPzAKEjC54N8y8UDWRWg1Dw9p7bMVymhAzidJGd4DV64pDhG7sjoTS3
         p+Ql5w6ytQtgIWI0TWmQ5rATEKEzcpO4rlAeAvMmCn1RtcuvjyjgHf7hKsHmTX2PQL
         Q2/alOOKGNQVTbQzdFAqscmYUSxO0FZPJSeqItIBh+GPAMDJCdczAFpTP2hsYgUvm0
         0ULRhvJ/sQKeA==
Date:   Tue, 26 Jan 2021 22:32:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add module parameter to force disable
 of SVA
Message-ID: <20210126170255.GP2771@vkoul-mobl>
References: <161074811013.2184257.13335125853932003159.stgit@djiang5-desk3.ch.intel.com>
 <20210117065115.GL2771@vkoul-mobl>
 <a7b50b40-ee4a-24c3-d4ba-40c770c970f1@intel.com>
 <20210119163822.GC2771@vkoul-mobl>
 <425267d2-dd13-5710-65b9-d98beff2b328@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425267d2-dd13-5710-65b9-d98beff2b328@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-01-21, 12:44, Dave Jiang wrote:
> 
> On 1/19/2021 9:38 AM, Vinod Koul wrote:
> > On 18-01-21, 10:06, Dave Jiang wrote:
> > > On 1/16/2021 11:51 PM, Vinod Koul wrote:
> > > > On 15-01-21, 15:01, Dave Jiang wrote:
> > > > > Add a module parameter that overrides the SVA feature enabling. This keeps
> > > > > the driver in legacy mode even when intel_iommu=sm_on is set. In this mode,
> > > > > the descriptor fields must be programmed with dma_addr_t from the Linux DMA
> > > > > API for source, destination, and completion descriptors.
> > > > > 
> > > > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > > > ---
> > > > >    drivers/dma/idxd/init.c |    8 +++++++-
> > > > >    1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > > > > index 25cc947c6179..9687a24ff982 100644
> > > > > --- a/drivers/dma/idxd/init.c
> > > > > +++ b/drivers/dma/idxd/init.c
> > > > > @@ -26,6 +26,10 @@ MODULE_VERSION(IDXD_DRIVER_VERSION);
> > > > >    MODULE_LICENSE("GPL v2");
> > > > >    MODULE_AUTHOR("Intel Corporation");
> > > > > +static bool sva = true;
> > > > > +module_param(sva, bool, 0644);
> > > > > +MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
> > > > Documentation for this please..
> > > Just comments or is there somewhere specific for driver module parameter
> > > documentations?
> > All the parameters are supposed to be documented in Documentation/admin-guide/kernel-parameters.txt
> 
> It seems to be for core kernel components and subsystems, and not specific
> device drivers. I'm not seeing any of the dmaengine driver module params
> being in this doc after grepping in drivers/dma.

Yeah we should fix that as well :)

-- 
~Vinod
