Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2D0F1F6
	for <lists+dmaengine@lfdr.de>; Tue, 30 Apr 2019 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfD3IXI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Apr 2019 04:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3IXI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Apr 2019 04:23:08 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F94E20835;
        Tue, 30 Apr 2019 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556612586;
        bh=Ax7kPNajmahK5/UstcB84x/WDLbOavAFjZ0njaK2UbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHND4OReBGyxKTLOodkLnfdc/7gyGeTctWO8VahlGw2wBkG0/RYaktPVgY+GDlR67
         LevTswToLl9bLpXZE3eEI1DoOkp0bgGzbMT/iFG6+rQyV76LBBX7yrKuBG9HtoKRcC
         SjmWZ6U8A++1UyV1W9jK++jSUeZMSQo+aZH+vJnk=
Date:   Tue, 30 Apr 2019 13:52:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dma: fix residue calculation in
 stm32-dma
Message-ID: <20190430082255.GP3845@vkoul-mobl.Dlink>
References: <1553689316-6231-1-git-send-email-arnaud.pouliquen@st.com>
 <20190426121751.GC28103@vkoul-mobl>
 <6894b54e-651f-1caf-d363-79d1ef0eee14@st.com>
 <20190429051310.GC3845@vkoul-mobl.Dlink>
 <26fa7710-76cb-e202-a367-c2e2408b6808@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26fa7710-76cb-e202-a367-c2e2408b6808@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-04-19, 16:52, Arnaud Pouliquen wrote:
> 
> 
> On 4/29/19 7:13 AM, Vinod Koul wrote:
> > On 26-04-19, 15:41, Arnaud Pouliquen wrote:
> >>>> During residue calculation. the DMA can switch to the next sg. When
> >>>> this race condition occurs, the residue returned value is not valid.
> >>>> Indeed the position in the sg returned by the hardware is the position
> >>>> of the next sg, not the current sg.
> >>>> Solution is to check the sg after the calculation to verify it.
> >>>> If a transition is detected we consider that the DMA has switched to
> >>>> the beginning of next sg.
> >>>
> >>> Now, that sounds like duct tape. Why should we bother doing that.
> >>>
> >>> Also looking back at the stm32_dma_desc_residue() and calls to it from
> >>> stm32_dma_tx_status() am not sure we are doing the right thing
> >> Please, could you explain what you have in mind here?
> > 
> > So when we call vchan_find_desc() that tells us if the descriptor is in
> > the issued queue or not..  Ideally it should not matter if we have one
> > or N descriptors issued to hardware.
> > 
> > So why should you bother checking for next_sg.
> > 
> >>> why are we looking at next_sg here, can you explain me that please
> >>
> >> This solution is similar to one implemented in the at_hdmac.c driver
> >> (atc_get_bytes_left function).
> >>
> >> Yes could be consider as a workaround for a hardware issue...
> >>
> >> In stm32 DMA Peripheral, we can register up to 2 sg descriptors (sg1 &
> >> sg2)in DMA registers, and use it in a cyclic mode (auto reload). This
> >> mode is mainly use for audio transfer initiated by an ALSA driver.
> >>
> >> >From hardware point of view the DMA transfers first block based on sg1,
> >> then it updates registers to prepare sg2 transfer, and then generates an
> >> IRQ to inform that it issues the next transfer (sg2).
> >>
> >> Then driver can update sg1 to prepare the third transfer...
> >>
> >> In parallel the client driver can requests status to get the residue to
> >> update internal pointer.
> >> The issue is in the race condition between the call of the
> >> device_tx_status ops and the update of the DMA register on sg switch.
> > 
> > Sorry I do not agree! You are in stm32_dma_tx_status() hold the lock and
> > IRQs are disabled, so even if sg2 was loaded, you will not get an
> > interrupt and wont know. By looking at sg1 register you will see that
> > sg1 is telling you that it has finished and residue can be zero. That is
> > fine and correct to report.
> > 
> > Most important thing here is that reside is for _requested_ descriptor
> > and not _current_ descriptor, so looking into sg2 doesnt not fit.
> > 
> >> During a short time the hardware updated the registers containing the
> >> sg ID but not the transfer counter(SxNDTR). In this case there is a
> >> mismatch between the Sg ID and the associated transfer counter.
> >> So residue calculation is wrong.
> >> Idea of this patch is to perform the calculation and then to crosscheck
> >> that the hardware has not switched to the next sg during the
> >> calculation. The way to crosscheck is to compare the the sg ID before
> >> and after the calculation.
> >>
> >> I tested the solution to force a new recalculation but no real solution
> >> to trust the registers during this phase. In this case an approximation
> >> is to consider that the DMA is transferring the first bytes of the next sg.
> >> So we return the residue corresponding to the beginning of the next buffer.
> > 
> > And that is wrong!. The argument is 'cookie' and you return residue for
> > that cookie.
> > 
> > For example, if you have dma txn with cookie 1, 2, 3, 4 submitted, then currently HW
> > is processing cookie 2, then for tx_status on:
> > cookie 1: return DMA_COMPLETE, residue 0
> > cookie 2: return DMA_IN_PROGRESS, residue (read from HW)
> > cookie 3: return DMA_IN_PROGRESS, residue txn length
> > cookie 4: return DMA_IN_PROGRESS, residue txn length
> > 
> > Thanks
> > 
> I think i miss something in my explanation, as from my humble POV (not
> enough expert in DMA framework...) we only one cookie here as only one
> cyclic transfer...

> Regarding your answers it looks like my sg explanation are not clear and
> introduce confusions... Sorry for this, i was used sg for internal STM32
> DMA driver, not for the framework API itself.
> 
> Let try retry to re-explain you the stm32 DMA cyclic mode management.
> 
> STM32 STM32 hardware:
> -------------------
> (ref manual:
> https://www.st.com/content/ccc/resource/technical/document/reference_manual/group0/51/ba/9e/5e/78/5b/4b/dd/DM00327659/files/DM00327659.pdf/jcr:content/translations/en.DM00327659.pdf)
> 
> The stm32 DMA supports cyclic mode using a hardware double
> buffer mode.
> In this double buffer, we can program up to 2 transfers. When one is
> completed, the DMA automatically switch on the other. This could be see
> as a hardware LLI with only 2 transfer descriptors.
> A hardware bit CT (current target) is used to determine the
> current transfer (CT = 0 or 1).
> A hardware NDT (num of data to transfer) counter can be read to
> determine DMA position in current transfer.
> An IRQ is generated when this CT bit is updated to allows driver to
> update the double buffer for the next transfer.
> 
> On client side (a.e audio):
> -------------------------
> The client requests a cyclic transfer by calling
> stm32_dma_prep_dma_cyclic. For instance it can request the transfer of a
> buffer divided in 10 periods. In this case only one cookie submitted
> (right?).
> 
> At stm32dma driver level these 10 periods are registered in an internal
> software table (desc->sg_req[]).As cyclic, the last sg_req point to the
> first one.
> 
> So to be able to transfer the whole software table, we have to update
> the STM32 DMA double buffer at each end of transfer period.
> The filed chan->next_sg points to the next sg_req in the software table.
> that should be write in the STM32 DMA double buffer.
> 
> Residue calculation:
> -------------------
> During a transfer we can get the position in a period thanks to the
> NDT(num of data to transfer) bit-field.
> 
> So the calculation is :
> 1) Get the NDT field value
> 3) add the periods remaining in the desc->sg_req[] table.
> 
> In parallel the STM32 DMA hardware updates the transfer buffer in 3 steps:
> 1) update CT register field.
> 2) Update NDT register field.
> 3) generate the IRQ (As you mention the IRQ is not treated during the
> device_tx_status as protected from interrupts).
> 
> We are facing issue when computing the residue during the update of the
> CT and the NDT. The CT and NDT can as been updated ( both or only CT...)
> without driver context update (IRQ disabled).
> In this case we can point to the beginning of the current transfer(
> completed) instead of the next_transfer. This generates a residue error
> and for audio a time-stamp regression (so video freeze or audio plop).
> 
> So the patch proposed consists in:
> 1) getting the current NDT value
> 2) reading CT and check that the hardware does not point to the next_sg.
> 	if yes:
> 	- CT has been updated by hardware but IRQ still not treated.
> 	- By default we consider the current_sg as completed, so we
> 	  point to the beginning of the next_sg buffer.
> 
> Hope that will help to clarify.

Yes that helps, maybe we should add these bits in code and changelog..
:)

And how does this impact non cyclic case where N descriptors maybe
issued. The driver seems to support non cyclic too...

Thanks
-- 
~Vinod
