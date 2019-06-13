Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E24460B
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 18:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfFMQsq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 12:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbfFMErE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Jun 2019 00:47:04 -0400
Received: from localhost (unknown [122.167.115.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F073B20896;
        Thu, 13 Jun 2019 04:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560401222;
        bh=K9FNPHmnqxi+cDtQvQzeft88w5PoDLsLVmgqgk4WPmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Anwqmr4rxIxTzAwwmYCKh1b1lsb2Hwr6+b824GvOspF92wg4JCoUn9yTIBRU+v4FE
         QB4F8U4SWd+NBczAXp5lz8i0k0QKmM6pGCEUDONXigsaqOFNFKdoXzyuWWvysAZdIZ
         3bH9HoMRUflLpwflFyltle5G6/CUhmjqcKRuC5ZI=
Date:   Thu, 13 Jun 2019 10:13:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     dan.j.williams@intel.com, tiwai@suse.com, jonathanh@nvidia.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
Message-ID: <20190613044352.GC9160@vkoul-mobl.Dlink>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-06-19, 09:19, Sameer Pujar wrote:

> > you are really going other way around about the whole picture. FWIW that
> > is how *other* folks do audio with dmaengine!
> I discussed this internally with HW folks and below is the reason why DMA
> needs
> to know FIFO size.
> 
> - FIFOs reside in peripheral device(ADMAIF), which is the ADMA interface to
> the audio sub-system.
> - ADMAIF has multiple channels and share FIFO buffer for individual
> operations. There is a provision
>   to allocate specific fifo size for each individual ADMAIF channel from the
> shared buffer.
> - Tegra Audio DMA(ADMA) architecture is different from the usual DMA
> engines, which you described earlier.
> - The flow control logic is placed inside ADMA. Slave peripheral
> device(ADMAIF) signals ADMA whenever a
>   read or write happens on the FIFO(per WORD basis). Please note that the
> signaling is per channel. There is
>   no other signaling present from ADMAIF to ADMA.
> - ADMA keeps a counter related to above signaling. Whenever a sufficient

when is signal triggered? When there is space available or some
threshold of space is reached?

> space is available, it initiates a transfer.
>   But the question is, how does it know when to transfer. This is the
> reason, why ADMA has to be aware of FIFO
>   depth of ADMAIF channel. Depending on the counters and FIFO depth, it
> knows exactly when a free space is available
>   in the context of a specific channel. On ADMA, FIFO_SIZE is just a value
> which should match to actual FIFO_DEPTH/SIZE
>   of ADMAIF channel.

That doesn't sound too different from typical dmaengine. To give an
example of a platform (and general DMAengine principles as well) I worked
on the FIFO was 16 word deep. DMA didn't knew!

Peripheral driver would signal to DMA when a threshold is reached and
DMA would send a burst controlled by src/dst_burst_size. For example if
you have a FIFO with 16 words depth, typical burst_size would be 8 words
and peripheral will configure signalling for FIFO having 8 words, so
signal from peripheral will make dma transfer 8 words.

Here the peripheral driver FIFO is important, but the driver
configures it and sets burst_size accordingly.

So can you explain me what is the difference here that the peripheral
cannot configure and use burst size with passing fifo depth?

> - Now consider two cases based on above logic,
>   * Case 1: when DMA_FIFO_SIZE > SLAVE_FIFO_SIZE
>     In this case, ADMA thinks that there is enough space available for
> transfer, when actually the FIFO data
>     on slave is not consumed yet. It would result in OVERRUN.
>   * Case 2: when DMA_FIFO_SIZE < SLAVE_FIFO_SIZE
>     This is case where ADMA won’t transfer, even though sufficient space is
> available, resulting in UNDERRUN.
> - The guideline is to program, DMA_FIFO_SIZE(on ADMA side) =
> SLAVE_FIFO_SIZE(on ADMAIF side) and hence we need a
>   way to communicate fifo size info to ADMA.

-- 
~Vinod
