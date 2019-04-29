Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D49DB66
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 07:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfD2FN2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 01:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfD2FN2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Apr 2019 01:13:28 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F15A62075E;
        Mon, 29 Apr 2019 05:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556514806;
        bh=7VmgqraXn/9VuG/nJLtKzsply2v6Qrak0T0ayd5evyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/ofAF2mDvIZ/HGpM13OgWf7Vxb81OYKP9Y0Hb9hZqR19GnHWy6fIY8jSfFOgkFkR
         WmqvjSDfKvxv2B4bUBwXNb9JcIm4nx7CYx3/qIc5e8ycMiCr5ORdFZDMKrT62+9baw
         0+/170xhhnZSRbNfzmoXM2J5Etd+5Zl3iy4VePUk=
Date:   Mon, 29 Apr 2019 10:43:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dma: fix residue calculation in
 stm32-dma
Message-ID: <20190429051310.GC3845@vkoul-mobl.Dlink>
References: <1553689316-6231-1-git-send-email-arnaud.pouliquen@st.com>
 <20190426121751.GC28103@vkoul-mobl>
 <6894b54e-651f-1caf-d363-79d1ef0eee14@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6894b54e-651f-1caf-d363-79d1ef0eee14@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-04-19, 15:41, Arnaud Pouliquen wrote:
> >> During residue calculation. the DMA can switch to the next sg. When
> >> this race condition occurs, the residue returned value is not valid.
> >> Indeed the position in the sg returned by the hardware is the position
> >> of the next sg, not the current sg.
> >> Solution is to check the sg after the calculation to verify it.
> >> If a transition is detected we consider that the DMA has switched to
> >> the beginning of next sg.
> > 
> > Now, that sounds like duct tape. Why should we bother doing that.
> > 
> > Also looking back at the stm32_dma_desc_residue() and calls to it from
> > stm32_dma_tx_status() am not sure we are doing the right thing
> Please, could you explain what you have in mind here?

So when we call vchan_find_desc() that tells us if the descriptor is in
the issued queue or not..  Ideally it should not matter if we have one
or N descriptors issued to hardware.

So why should you bother checking for next_sg.

> > why are we looking at next_sg here, can you explain me that please
> 
> This solution is similar to one implemented in the at_hdmac.c driver
> (atc_get_bytes_left function).
> 
> Yes could be consider as a workaround for a hardware issue...
> 
> In stm32 DMA Peripheral, we can register up to 2 sg descriptors (sg1 &
> sg2)in DMA registers, and use it in a cyclic mode (auto reload). This
> mode is mainly use for audio transfer initiated by an ALSA driver.
> 
> >From hardware point of view the DMA transfers first block based on sg1,
> then it updates registers to prepare sg2 transfer, and then generates an
> IRQ to inform that it issues the next transfer (sg2).
> 
> Then driver can update sg1 to prepare the third transfer...
> 
> In parallel the client driver can requests status to get the residue to
> update internal pointer.
> The issue is in the race condition between the call of the
> device_tx_status ops and the update of the DMA register on sg switch.

Sorry I do not agree! You are in stm32_dma_tx_status() hold the lock and
irqs are disabled, so even if sg2 was loaded, you will not get an
interrupt and wont know. By looking at sg1 register you will see that
sg1 is telling you that it has finished and residue can be zero. That is
fine and correct to report.

Most important thing here is that reside is for _requested_ descriptor
and not _current_ descriptor, so looking into sg2 doesnt not fit.

> During a short time the hardware updated the registers containing the
> sg ID but not the transfer counter(SxNDTR). In this case there is a
> mismatch between the Sg ID and the associated transfer counter.
> So residue calculation is wrong.
> Idea of this patch is to perform the calculation and then to crosscheck
> that the hardware has not switched to the next sg during the
> calculation. The way to crosscheck is to compare the the sg ID before
> and after the calculation.
> 
> I tested the solution to force a new recalculation but no real solution
> to trust the registers during this phase. In this case an approximation
> is to consider that the DMA is transferring the first bytes of the next sg.
> So we return the residue corresponding to the beginning of the next buffer.

And that is wrong!. The argument is 'cookie' and you return residue for
that cookie.

For example, if you have dma txn with cookie 1, 2, 3, 4 submitted, then currently HW
is processing cookie 2, then for tx_status on:
cookie 1: return DMA_COMPLETE, residue 0
cookie 2: return DMA_IN_PROGRESS, residue (read from HW)
cookie 3: return DMA_IN_PROGRESS, residue txn length
cookie 4: return DMA_IN_PROGRESS, residue txn length

Thanks
-- 
~Vinod
