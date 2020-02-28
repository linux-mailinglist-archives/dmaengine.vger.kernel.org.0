Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12F9173545
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2020 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgB1K0h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Feb 2020 05:26:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgB1K0g (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Feb 2020 05:26:36 -0500
Received: from localhost (unknown [122.182.215.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F7062469F;
        Fri, 28 Feb 2020 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582885596;
        bh=a6pS6AMZKTCJMUm/J9xeeK8dJhS9wNmw3vRFuEYcLyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJzvhfmyo02SFTzd/qHMaf+XN8630v2AC5zdK5Zinu/QCT5b1SKfRd8Ajn5MuuqD9
         k4b9yHklC3WUsKK8LgmgO1rwFAD/EkF2s4anZabTvR9ApRZ7FGpu3Yra6WfVMlDToi
         iDcF43qj32b58ckdoY8InIJtoujNvvrBfu6UuJNk=
Date:   Fri, 28 Feb 2020 15:56:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, geert@linux-m68k.org
Subject: Re: [PATCH v3] dmaengine: Add basic debugfs support
Message-ID: <20200228102630.GB4148@vkoul-mobl>
References: <20200205111557.24125-1-peter.ujfalusi@ti.com>
 <20200224163707.GA2618@vkoul-mobl>
 <71231b0e-a9a2-4795-da71-b484f4992278@ti.com>
 <20200228044704.GC2618@vkoul-mobl>
 <970899d9-1491-78e8-1e7a-14e40915d061@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970899d9-1491-78e8-1e7a-14e40915d061@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-02-20, 12:01, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 28/02/2020 6.47, Vinod Koul wrote:
> > Hi Peter,
> > 
> > On 26-02-20, 14:10, Peter Ujfalusi wrote:
> > 
> >>>  do we really want a custom dbg_show()..? Drivers can add their own
> >>> files...
> >>
> >> They could do that already ;)
> >>
> >> With the custom dbg_show() DMA drivers can save on the surrounding
> >> code and just fill in the information regarding to their HW.
> >> Again, on am654 the default information is:
> >> # cat /sys/kernel/debug/dmaengine 
> >> dma0 (285c0000.dma-controller): number of channels: 96
> >>
> >> dma1 (31150000.dma-controller): number of channels: 267
> >>  dma1chan0    | 2b00000.mcasp:tx
> >>  dma1chan1    | 2b00000.mcasp:rx
> >>  dma1chan2    | in-use
> >>  dma1chan3    | in-use
> >>  dma1chan4    | in-use
> >>  dma1chan5    | in-use
> >>
> >> With my current .dbg_show implementation for k3-udma:
> >> # cat /sys/kernel/debug/dmaengine 
> >> dma0 (285c0000.dma-controller): number of channels: 96
> >>
> >> dma1 (31150000.dma-controller): number of channels: 267
> >>  dma1chan0    | 2b00000.mcasp:tx (MEM_TO_DEV, tchan8 [0x1008 -> 0xc400], PDMA, TR mode)
> >>  dma1chan1    | 2b00000.mcasp:rx (DEV_TO_MEM, rchan8 [0x4400 -> 0x9008], PDMA, TR mode)
> >>  dma1chan2    | in-use (MEM_TO_MEM, chan2 pair [0x1002 -> 0x9002], PSI-L Native, TR mode)
> >>  dma1chan3    | in-use (MEM_TO_MEM, chan3 pair [0x1003 -> 0x9003], PSI-L Native, TR mode)
> >>  dma1chan4    | in-use (MEM_TO_MEM, chan4 pair [0x1004 -> 0x9004], PSI-L Native, TR mode)
> >>  dma1chan5    | in-use (MEM_TO_MEM, chan5 pair [0x1005 -> 0x9005], PSI-L Native, TR mode)
> >>
> >> For me this makes a huge difference.
> > 
> > Ok
> > 
> >>>> +DEFINE_SHOW_ATTRIBUTE(dmaengine_debugfs);
> >>>> +
> >>>> +static int __init dmaengine_debugfs_init(void)
> >>>> +{
> >>>> +	/* /sys/kernel/debug/dmaengine */
> >>>> +	debugfs_create_file("dmaengine", 0444, NULL, NULL,
> >>>> +			    &dmaengine_debugfs_fops);
> >>>
> >>> Should we add a directory? That way we can keep adding stuff into that
> >>> one
> >>
> >> and have this file as 'summary' underneath?
> > 
> > Correct
> 
> /sys/kernel/debug/dmaengine/summary, right?

Yup!

> 
> >> I like the fact hat I can get all the information via one file.
> >> Saves a lot of time (and explaining to users) on finding the correct
> >> one to cat...
> > 
> > But am sure we can come with more data to show, so having a directory
> > helps :)
> 
> OK, so we need to store the dbgfs rootdir and add an API so DMA drivers
> can get the dentry of it, so they can implement their custom
> files/directories underneath.

Correct

-- 
~Vinod
