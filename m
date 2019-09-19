Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA5B7FCB
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 19:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391200AbfISRN4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 13:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389036AbfISRNz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Sep 2019 13:13:55 -0400
Received: from localhost (unknown [106.200.214.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7047214AF;
        Thu, 19 Sep 2019 17:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568913234;
        bh=OMKr/cmWPumpo9LCv+3v3aRUPCtQnLyLX5PRnZs/l1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WleYMfFQAUT2Ob78sZcIRDgLfTKZG/AUrTqsaITJ2OYeCI9pCEVjSqgorDdF9M/6h
         7f96JC2rTxefq/1FFGt4R/+3wQ00Y2nTIibvhZqc/ePhF+i2n26lrLq827RIErvhVz
         oDQjUCLI3gL0nJ+niA0Uxoq29+ykYZ5eHovdGRdQ=
Date:   Thu, 19 Sep 2019 22:42:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] staging: Support Avalon-MM DMA Interface for PCIe
Message-ID: <20190919171246.GS4392@vkoul-mobl>
References: <cover.1568817357.git.a.gordeev.box@gmail.com>
 <20190919113708.GA3153236@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919113708.GA3153236@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-09-19, 13:37, Greg KH wrote:
> On Thu, Sep 19, 2019 at 11:59:11AM +0200, Alexander Gordeev wrote:
> > The Avalon-MM DMA Interface for PCIe is a design found in hard IPs for
> > Intel Arria, Cyclone or Stratix FPGAs. It transfers data between on-chip
> > memory and system memory. This RFC is an attempt to provide a generic API:
> > 
> > 	typedef void (*avalon_dma_xfer_callback)(void *dma_async_param);
> >  
> > 	int avalon_dma_submit_xfer(
> > 		struct avalon_dma *avalon_dma,
> > 		enum dma_data_direction direction,
> > 		dma_addr_t dev_addr, dma_addr_t host_addr,
> > 		unsigned int size,
> > 		avalon_dma_xfer_callback callback,
> > 		void *callback_param);
> >  
> > 	int avalon_dma_submit_xfer_sg(struct avalon_dma *avalon_dma,
> > 		enum dma_data_direction direction,
> > 		dma_addr_t dev_addr,
> > 		struct sg_table *sg_table,
> > 		avalon_dma_xfer_callback callback,
> > 		void *callback_param);
> >  
> > 	int avalon_dma_issue_pending(struct avalon_dma *avalon_dma);

Why wrap the *existing* kernel APIs with you own!

A quick glance at the code submitted tells me that it mimcks kernel
APIs. But why you folks didnt use the kernel dmaengine APIs in not clear
to me. So please convert it (should be relatively easy as you seem to
have wrappers for dmaengine callbacks)

> > 
> > Patch 1 introduces "avalon-dma" driver that provides the above-mentioned
> > generic interface.
> > 
> > Patch 2 adds "avalon-drv" driver using "avalon-dma" to transfer user-
> > provided data. This driver was used to debug and stress "avalon-dma"
> > and could be used as a code base for other implementations. Strictly
> > speaking, it does not need to be part of the kernel tree.
> > A companion tool using "avalon-drv" to DMA files (not part of this
> > patchset) is located at git@github.com:a-gordeev/avalon-drv-tool.git

Heh! We do have a dmatest driver which does this and much more! why not
use that one instead of adding you own!

> > The suggested interface is developed with the standard "dmaengine"
> > in mind and could be reworked to suit it. I would appreciate, however
> > gathering some feedback on the implemenation first - as the hardware-
> > specific code would persist. It is also a call for testing - I only
> > have access to a single Arria 10 device to try on.

Why not use dmaengine in first place?

> > This series is against v5.3 and could be found at
> > git@github.com:a-gordeev/linux.git avalon-dma-engine
> 
> Why is this being submitted for drivers/staging/ and not the "real" part
> of the kernel tree?
> 
> All staging code must have a TODO file listing what needs to be done in
> order to get it out of staging, and be self-contained (i.e. no files
> include/linux/)
> 
> Please fix that up when resending this series.

-- 
~Vinod
