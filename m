Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6023D9C8A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 06:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhG2ETQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 00:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233607AbhG2ETQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Jul 2021 00:19:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E04056103B;
        Thu, 29 Jul 2021 04:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627532353;
        bh=p8SBuZAJ6O+BJYgXJaAwIZI6ZZrm6vAYzJw2y8GigdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAfCwh0oVVfZCn3gmmS6VRDS8xNr4F03NxSvNPLI/vxHrqFH+8ANkQv27Cy6fwgqI
         Mq7WjpM7vbTQMONFufOWoHpqXU709sUU56zIGQfE+1zEEldVx9APx/xYrFchAsr7zw
         5ryIM6Z0K3zZxp8SVtIBuM6GNoUO6WF1W8IRGuoYaf849hdwuWd91yRBSeklAd4C21
         FV5awmwXiXP4Y0ZWwgXUhXntH34ACUrcSdiVfvNj9e6bMVwFsRyFOVF0wUh9nwc4gl
         y2CeCaYI795pPQFmhHw7+M8FFTSPwrtN3PifFB5rV0+YtbaJxrxA0kPZBvlatCIJed
         X/RC6kJxypd4A==
Date:   Thu, 29 Jul 2021 09:49:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Adrian Larumbe <adrianml@alumnos.upm.es>
Cc:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>,
        dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dmaengine: xilinx_dma: Restore support for memcpy SG
 transfers
Message-ID: <YQIsPV1FTWtA0tYN@matsya>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
 <20210706234338.7696-2-adrian.martinezlarumbe@imgtec.com>
 <YO5u/ZK4njSpYrwN@matsya>
 <20210726221423.5q6b5cwruznzqfxr@worklaptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726221423.5q6b5cwruznzqfxr@worklaptop.localdomain>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-07-21, 23:14, Adrian Larumbe wrote:
> Hi Vinod, I'm the same person who authored this patch. I left my previous
> employer so no longer have access to their company email address. However I've
> signed this email with the same GPG key to confirm my identity.
> 
> On 14.07.2021 10:28, Vinod Koul wrote:
> > On 07-07-21, 00:43, Adrian Larumbe wrote:
> > > This is the old DMA_SG interface that was removed in commit
> > > c678fa66341c ("dmaengine: remove DMA_SG as it is dead code in kernel"). It
> > > has been renamed to DMA_MEMCPY_SG to better match the MEMSET and MEMSET_SG
> > > naming convention.
> > > 
> > > It should only be used for mem2mem copies, either main system memory or
> > > CPU-addressable device memory (like video memory on a PCI graphics card).
> > > 
> > > Bringing back this interface was prompted by the need to use the Xilinx
> > > CDMA device for mem2mem SG transfers. The current CDMA binding for
> > > device_prep_dma_memcpy_sg was partially borrowed from xlnx kernel tree, and
> > > expanded with extended address space support when linking descriptor
> > > segments and checking for incorrect zero transfer size.
> > > 
> > > Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
> > > ---
> > >  .../driver-api/dmaengine/provider.rst         |  11 ++
> > >  drivers/dma/dmaengine.c                       |   7 +
> > >  drivers/dma/xilinx/xilinx_dma.c               | 122 ++++++++++++++++++
> > 
> > Can you make this split... documentation patch, core change and then
> > driver
> 
> I understand you'd like these in three different patches, is that right? Or

Correct

> maybe one patch for the core change and its associated documentation, and

doc and core should be different

> another one for the consumer.
> 
> > >  include/linux/dmaengine.h                     |  20 +++
> > >  4 files changed, 160 insertions(+)
> > > 
> > > diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> > > index ddb0a81a796c..9f0efe9e9952 100644
> > > --- a/Documentation/driver-api/dmaengine/provider.rst
> > > +++ b/Documentation/driver-api/dmaengine/provider.rst
> > > @@ -162,6 +162,17 @@ Currently, the types available are:
> > >  
> > >    - The device is able to do memory to memory copies
> > >  
> > > +- - DMA_MEMCPY_SG
> > > +
> > > +  - The device supports memory to memory scatter-gather transfers.
> > > +
> > > +  - Even though a plain memcpy can look like a particular case of a
> > > +    scatter-gather transfer, with a single chunk to transfer, it's a
> > > +    distinct transaction type in the mem2mem transfer case. This is
> > > +    because some very simple devices might be able to do contiguous
> > > +    single-chunk memory copies, but have no support for more
> > > +    complex SG transfers.
> > 
> > How does one deal with cases where
> >  - src_sg_len and dstn_sg_len are different?
> 
> Then only as many bytes as the smallest of the scattered buffers will be copied.

Is that not a restriction and that needs to be documented with examples!

> 
> > >  - src_sg and dstn_sg are different lists (maybe different number of
> > >    entries with different lengths..)
> > > 
> > > I think we need to document these cases or limitations..
> 
> I don't think we should place any restrictions on the number of scatterlist
> entries or their length, and the consumer driver should ensure that these get
> translated into a device-specific descriptor chain. However the previous
> semantic should always be observed, which effectively turns the operation into
> sort of a strncpy.

That sounds right, but someone needs to know how to handle such cases
with this API, that needs to be explained in detail on expected
behaviour when src_sg_len & dstn_sg_len and same, less or more!

-- 
~Vinod
