Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5440E3BB5FE
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jul 2021 05:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGEDz6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jul 2021 23:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhGEDz4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 4 Jul 2021 23:55:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99AA9613C9;
        Mon,  5 Jul 2021 03:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625457200;
        bh=elIXYsjFhQt/v0BxThJcD8RjLjjJbHU5/6nS2Y86KBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fk7/noQtv7/ZZ8ImltTRPViDaejolf2pAgPD0NWkVDYXoLWXyaosGT88Z1OYEoG6l
         JXEGT2QfRi1+DTcqpmkPFamn3GgK91pM3TQ0tqpNFPvRv/+VqAsOqx+/S6YuxOph07
         SfSstNs2KWVxMEwNom8nzVd/aM3eFW79dnUsRCYxfAeRGr6yhryyBO5Bq2Z0B9oGC9
         dwyYIM+YbV2F1dRhdYkjXntCS3uncp8+EZp3DJCXeWK1l8i8EvqDKdz4hiwiCMvwE+
         pig89d9eE0LFylFmb+RLZ3hcZl9uRLyWGU+wRrDT7vEyB2GmtBDW0Jwf6jQ6G2AStI
         RE6d5Be1MM+hA==
Date:   Mon, 5 Jul 2021 09:23:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
Cc:     radhey pandey <radheydmaengine@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, radheys@xilinx.com
Subject: Re: [EXTERNAL] Re: [PATCH 0/4] Expand Xilinx CDMA functions
Message-ID: <YOKCLNL/mLnYV6rp@matsya>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
 <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
 <YILKq+jNZZSs37xa@vkoul-mobl.Dlink>
 <bed31611-a084-2a05-f3a3-25585a47be9a@metafoo.de>
 <YIMB6DpM//wrPC6q@vkoul-mobl.Dlink>
 <CAK8fcYC3Hdxas-5qUbXTi=a6VMXavt9O+yWn=1+8fPewehKy2w@mail.gmail.com>
 <20210702142310.vowvjanfwfivu45a@adrianlarumbe-HP-Elite-7500-Series-MT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702142310.vowvjanfwfivu45a@adrianlarumbe-HP-Elite-7500-Series-MT>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-07-21, 15:23, Adrian Larumbe wrote:
> On 01.06.2021 15:59, radhey pandey wrote:
> > On Fri, Apr 23, 2021 at 10:51 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 23-04-21, 15:51, Lars-Peter Clausen wrote:
> > > > On 4/23/21 3:24 PM, Vinod Koul wrote:
> > > > > On 23-04-21, 11:17, Lars-Peter Clausen wrote:
> > > > > > It seems to me what we are missing from the DMAengine API is the equivalent
> > > > > > of device_prep_dma_memcpy() that is able to take SG lists. There is already
> > > > > > a memset_sg, it should be possible to add something similar for memcpy.
> > > > > You mean something like dmaengine_prep_dma_sg() which was removed?
> > > > >
> > > > Ah, that's why I could have sworn we already had this!
> > >
> > > Even at that time we had the premise that we can bring the API back if
> > > we had users. I think many have asked for it, but I havent seen a patch
> > > with user yet :)
> > Right.  Back then we had also discussed bringing the dma_sg API
> > but the idea was dropped as we didn't had a xilinx/any consumer
> > client driver for it in the mainline kernel.
> > 
> > I think it's the same state now.
> 
> Would it be alright if I brought back the old DMA_SG interface that was removed
> in commit c678fa66341c?  It seems that what I've effectively done is
> implementing the semantics of that API call under the guise of
> dma_prep_slave. However I still need mem2mem SG transfer support on CDMA, which
> seems long gone from the driver, even though the HW does offer it.
> 
> If people are fine with it I can restore that interface and CDMA as the sole consumer.

I guess I should start putting this regularly now! Yes it is okay to
bring dma sg support, provided
1. We have a user
2. the sematics of how that api works is well defined. Esp in the case where is src_sg and dstn_sg are different

Also, I would not accept patches which implement this in guise of a
different API.

Thanks

-- 
~Vinod
