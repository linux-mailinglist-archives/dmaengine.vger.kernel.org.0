Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B421814BF
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 10:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCKJ04 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 05:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgCKJ04 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 05:26:56 -0400
Received: from localhost (unknown [106.201.105.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB5020828;
        Wed, 11 Mar 2020 09:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583918815;
        bh=QcNGdpQHsI/SFC6XmNOOtZkcHp79Ei3W2Z+qhJw+9JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwDl/K7XISWQoZJHEICCdTw4wIkjtSZksX9MwGBXwCcoIxcEasa/g6NSIgqSND1bC
         TxrlwozVFColIrFjyZPVxactj4f5ETAo98IgPf9TNOnU6E70mIZIChYeJmeCPno6ck
         sYnLQ8uGqt54lqfFZh49Lfi7Rtfu/H2N39+BkfHU=
Date:   Wed, 11 Mar 2020 14:56:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, geert@linux-m68k.org
Subject: Re: [PATCH v5 0/3]  dmaengine: Initial debugfs support
Message-ID: <20200311092648.GM4885@vkoul-mobl>
References: <20200306142839.17910-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306142839.17910-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-03-20, 16:28, Peter Ujfalusi wrote:
> Hi,
> 
> Changes sicne v4:
> - Move the dmaengine_debugfs_init() from late_initcall to be called from
>   dma_bus_init to avoid races due to probe orders of drivers.
> - Separate patch to create DMA driver directories for debugfs
> 
> Changes since v3:
> - Create a directory for dmaengine and name the initial file as summary
> - Function to get the debugfs root for DMA drivers if they want to place files
> - Custom dbg_summary_show implementation for k3-udma
> 
> Changes since v2:
> - Use dma_chan_name() for printing the channel's name
> 
> Changes since v1:
> - Use much more simplified fops for the debugfs file (via DEFINE_SHOW_ATTRIBUTE)
> - do not allow modification to dma_device_list while the debugfs file is read
> - rename the slave_name to dbg_client_name (it is only for debugging)
> - print information about dma_router if it is used by the channel
> - Formating of the output slightly changed
> 
> The basic debugfs file (/sys/kernel/debug/dmaengine/summary) can be used to
> query basic information about the DMAengine usage (am654-evm):
> 
> # cat /sys/kernel/debug/dmaengine/summary
> dma0 (285c0000.dma-controller): number of channels: 96
> 
> dma1 (31150000.dma-controller): number of channels: 267
>  dma1chan0    | 2b00000.mcasp:tx
>  dma1chan1    | 2b00000.mcasp:rx
>  dma1chan2    | in-use
>  dma1chan3    | in-use
>  dma1chan4    | in-use
>  dma1chan5    | in-use
> 
> Drivers can implement custom dbg_summary_show to add extended information via
> the summary file, like with the second patch for k3-udma (j721e-evm):
> 
> # cat /sys/kernel/debug/dmaengine/summary
> dma0 (285c0000.dma-controller): number of channels: 24
> 
> dma1 (31150000.dma-controller): number of channels: 84
>  dma1chan0    | 2b00000.mcasp:tx (MEM_TO_DEV, tchan16 [0x1010 -> 0xc400], PDMA[ ACC32 BURST ], TR mode)
>  dma1chan1    | 2b00000.mcasp:rx (DEV_TO_MEM, rchan16 [0x4400 -> 0x9010], PDMA[ ACC32 BURST ], TR mode)
>  dma1chan2    | 2ba0000.mcasp:tx (MEM_TO_DEV, tchan17 [0x1011 -> 0xc507], PDMA[ ACC32 BURST ], TR mode)
>  dma1chan3    | 2ba0000.mcasp:rx (DEV_TO_MEM, rchan17 [0x4507 -> 0x9011], PDMA[ ACC32 BURST ], TR mode)
>  dma1chan4    | in-use (MEM_TO_MEM, chan0 pair [0x1000 -> 0x9000], PSI-L Native, TR mode)
>  dma1chan5    | in-use (MEM_TO_MEM, chan1 pair [0x1001 -> 0x9001], PSI-L Native, TR mode)
>  dma1chan6    | in-use (MEM_TO_MEM, chan4 pair [0x1004 -> 0x9004], PSI-L Native, TR mode)
>  dma1chan7    | in-use (MEM_TO_MEM, chan5 pair [0x1005 -> 0x9005], PSI-L Native, TR mode)
> 
> With the last patch the debugfs looks like this:
> # ls -al /sys/kernel/debug/dmaengine/
> total 0
> drwxr-xr-x  4 root root 0 Jan  1 02:00 .
> drwx------ 29 root root 0 Jan  1 02:00 ..
> drwxr-xr-x  2 root root 0 Jan  1 02:00 285c0000.dma-controller
> drwxr-xr-x  2 root root 0 Jan  1 02:00 31150000.dma-controller
> -r--r--r--  1 root root 0 Jan  1 02:00 summary

Applied, thanks

-- 
~Vinod
