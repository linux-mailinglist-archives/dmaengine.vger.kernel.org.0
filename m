Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74673C31B
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2019 06:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389877AbfFKEur (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jun 2019 00:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389620AbfFKEur (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Jun 2019 00:50:47 -0400
Received: from localhost (unknown [171.76.113.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7112D20820;
        Tue, 11 Jun 2019 04:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560228646;
        bh=BM/H6eur2/+LuSYrz8MfGQ5n31xjuO0Mxb9d5OKqYHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUEt+P4G/DVAk1QmvLM9k244SjcBfoiQDil8gm6GhyX2ZTD2+gwkOJKO7qFzfHPjL
         IASllE2J2ZYZi9CUhZNXFkL8/R6E7ftCwX5zcqgZ9m87ec78CewFRZl7fLwYFMJVuT
         HY93LdnxIgAAgWBPRaS3qBXZfw7ho91wf9i35EDM=
Date:   Tue, 11 Jun 2019 10:17:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH] dmaengine: dmatest: Add support for completion polling
Message-ID: <20190611044738.GT9160@vkoul-mobl.Dlink>
References: <20190529083724.18182-1-peter.ujfalusi@ti.com>
 <4f327f4a-9e3d-c9d2-fe48-14e492b07417@ti.com>
 <793f9f48-0609-4aa5-2688-bf30525e229c@ti.com>
 <20190604124527.GG15118@vkoul-mobl>
 <0e909b8a-8296-7c6a-058a-3fc780d66195@ti.com>
 <20190610070435.GL9160@vkoul-mobl.Dlink>
 <01766659-4b81-cf58-8b00-458b6272c7ef@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01766659-4b81-cf58-8b00-458b6272c7ef@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-06-19, 14:12, Peter Ujfalusi wrote:
> 
> 
> On 10/06/2019 10.04, Vinod Koul wrote:
> >>> I think we should view DMA_PREP_INTERRUPT from client pov, but
> >>> controller cannot get away with disabling interrupts IMO.
> >>
> >> What happens if client is issuing a DMA memcpy (short one) while
> >> interrupts are disabled?
> >>
> >> The user for this is:
> >> drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> >>
> >> commit: f5b9930b85dc6319fd6bcc259e447eff62fc691c
> >>
> >> The interrupt based completion is not going to work in some cases, the
> >> DMA driver should obey that the missing DMA_PREP_INTERRUPT really
> >> implies that interrupts can not be used.
> > 
> > well yes but how do we *assume* completion and issue subsequent txns?
> > Does driver create a task and poll?
> 
> The client driver will poll on tx_status, like using dma_sync_wait().
> The DMA driver is expected to check if the transfer is completed by
> other means than relying on the interrupt for transfer completion.
> 
> >>
> >>> Assuming I had enough caffeine before I thought process, then client would
> >>> poll descriptor status using cookie and should free up once the cookie
> >>> is freed, makes sense?
> >>
> >> OK, so clients are expected to call dmaengine_terminate_*
> >> unconditionally after the transfer is completed, right?
> > 
> > How do you know/detect transfer is completed?
> 
> This is a bit tricky and depends on the DMA hardware.
> For sDMA (omap-dma) we already do this by checking the channel status.
> The channel will be switched to idle if the transfer is completed.

Well we are talking about DMA and doing this kind of things doesn't make
sense to me. Why not do memcpy/pio instead. DMA is designed to finish
txn fast and move to next one, if we cannot do that, I would say lets
not use dmaengine in those cases! Keeping dmaengine idle is not really
good design.

> EDMA on the other hand does not provide straight forward way to check if
> the transfer is completed w/o interrupts, however we can see it if the
> CC loaded the closing dummy paRAM slot (address is 0).
> 
> If I want to enable this for UDMAP then I would check the return ring if
> I got back the descriptor or not.
> 
> >> If we use interrupts then the handler would anyway free up the
> >> descriptor, so terminating should not do any harm, if we can not have
> >> interrupts then terminate will clear up the completed descriptor
> >> proactively.
> > 
> > yes terminate part is fine.
> 
> OK, so I don't need to change this patch for dmatest, right?
> 
> I'll prepare the EDMA patch and an update for omap-dma as well.
> 
> >> In any case I have updated the EDMA patch to do the same thing in case
> >> of polling w/o interrupts as it would do in the completion irq handler,
> >> and similar approach prepared for omap-dma as well.
> >>
> >> - Péter
> >>
> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> >> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> > 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
