Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147EF7C5E9
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 17:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfGaPRZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 11:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfGaPRZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 31 Jul 2019 11:17:25 -0400
Received: from localhost (unknown [171.76.116.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043D5206A2;
        Wed, 31 Jul 2019 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564586244;
        bh=QLtbVtyJYSI7n5fVnkziSsOezk9bUyYirENwCfguXxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbzuLgqb5ns6zxuRild0zWDqNUDFQPIZGJ7Fb4av46TQnhuG4/wrb4hZprvP0cT8C
         KU54V3L8FjH2uk6USMAu/AM6/lP3w++MBb24XnXqobPpgHMhRa9xX9wl//+hHhJmL9
         UwPz49l5flgfdOFWG4taG3u0nQVUH5cC37Tngm5M=
Date:   Wed, 31 Jul 2019 20:46:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Sameer Pujar <spujar@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dan.j.williams@intel.com, tiwai@suse.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
Message-ID: <20190731151610.GT12733@vkoul-mobl.Dlink>
References: <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
 <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
 <20190624062609.GV2962@vkoul-mobl>
 <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
 <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
 <20190719050459.GM12733@vkoul-mobl.Dlink>
 <3e7f795d-56fb-6a71-b844-2fc2b85e099e@nvidia.com>
 <20190729061010.GC12733@vkoul-mobl.Dlink>
 <98954eb3-21f1-6008-f8e1-f9f9b82f87fb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98954eb3-21f1-6008-f8e1-f9f9b82f87fb@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-19, 10:48, Jon Hunter wrote:
> 
> On 29/07/2019 07:10, Vinod Koul wrote:
> > On 23-07-19, 11:24, Sameer Pujar wrote:
> >>
> >> On 7/19/2019 10:34 AM, Vinod Koul wrote:
> >>> On 05-07-19, 11:45, Sameer Pujar wrote:
> >>>> Hi Vinod,
> >>>>
> >>>> What are your final thoughts regarding this?
> >>> Hi sameer,
> >>>
> >>> Sorry for the delay in replying
> >>>
> >>> On this, I am inclined to think that dma driver should not be involved.
> >>> The ADMAIF needs this configuration and we should take the path of
> >>> dma_router for this piece and add features like this to it
> >>
> >> Hi Vinod,
> >>
> >> The configuration is needed by both ADMA and ADMAIF. The size is
> >> configurable
> >> on ADMAIF side. ADMA needs to know this info and program accordingly.
> > 
> > Well I would say client decides the settings for both DMA, DMAIF and
> > sets the peripheral accordingly as well, so client communicates the two
> > sets of info to two set of drivers
> 
> That maybe, but I still don't see how the information is passed from the
> client in the first place. The current problem is that there is no means
> to pass both a max-burst size and fifo-size to the DMA driver from the
> client.

So one thing not clear to me is why ADMA needs fifo-size, I thought it
was to program ADMAIF and if we have client programme the max-burst
size to ADMA and fifo-size to ADMAIF we wont need that. Can you please
confirm if my assumption is valid?

> IMO there needs to be a way to pass vendor specific DMA configuration
> (if this information is not common) otherwise we just end up in a
> scenario like there is for the xilinx DMA driver
> (include/linux/dma/xilinx_dma.h) that has a custom API for passing this
> information.
> 
> Cheers
> Jon
> 
> -- 
> nvpublic

-- 
~Vinod
