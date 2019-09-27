Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E0C06C6
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2019 15:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfI0N5d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Sep 2019 09:57:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46276 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0N5d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Sep 2019 09:57:33 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so16404215ioo.13;
        Fri, 27 Sep 2019 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=boZXw4SCirqsRIbJ+By9WPXJ92CkT49uSIzr686TYUY=;
        b=S8Fj6UkFcdsLkCEyrpQPS3iJ8WGWrM+qKfeVBrIhZsUSCPJM1LRzD2jxENfvoj2Vv/
         MwfNdaP8Xu0UwyZOHetLuvAxCD4IZBEfeq1CAYixwrTW/WJ45GRz8pNFV/xSIZDO/cRS
         9WkeCJrcuAeGMUkW2L2AQ9jfFozLZPVhWWnLNMENvtb14cfWN7T+bcFAsEPaJgVb0rAN
         7ry0Wts/mlQ9iYVBaRU+09WIfJsihRt6Fk/bsf5sxVfp3pHxWzkge0S0KgxxqCdosUTJ
         bEhdErU5a5BeICLhZH1i0pai+orCELVEsgtpGUC6an3jWgI2vBdJxPuQo6NInrgLxLux
         eOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=boZXw4SCirqsRIbJ+By9WPXJ92CkT49uSIzr686TYUY=;
        b=Vk0bZ1oO54W1vFj9Sti+aef3UXUtfJoJJFI4NOcytxl/w5p3tvkPbtHFrnPaR8Xx5K
         Q607hYnV0n1iLOOPE8xWMQG7JIfkqpqBe/1wGki+ALyIvXJ4OPB4epMtGYr+1ILMPt5F
         Sj4qCAQoexZj1lC3Vj607kDdPh9Y/4vdudSfRtO7frdpBBixSt2RAA5rjbDSHO9jxakc
         wonZSTS3VUhoDGUdSyieHD3YtDhUrl5aMVeFy50LVuU5bNoSh3jAgxD/29aXLjd445l8
         ulNHTLVKWPRUN0smwy3759V6R/O01yVnM9U/pXFdp1euXkZ31WDW90rK7Orq5S46B1qf
         hP/w==
X-Gm-Message-State: APjAAAWYu3grQWls7p72V2FOTQ8HLi6akkNjWxkqtwfOd9VY5p1CoUua
        RtcmLe4+f9bXsyai67Uf34kC4eAMdJU=
X-Google-Smtp-Source: APXvYqw+uVnKir54+fie0lakYdLAjfXFd/WwDbFLVOLXyMmg2a5liUojGMH+R+YgpA3ZfNzqBh8H9Q==
X-Received: by 2002:a92:8f19:: with SMTP id j25mr4890285ild.302.1569592652193;
        Fri, 27 Sep 2019 06:57:32 -0700 (PDT)
Received: from lnx-nickg ([96.78.92.5])
        by smtp.gmail.com with ESMTPSA id i14sm1095488ilq.38.2019.09.27.06.57.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 06:57:31 -0700 (PDT)
Date:   Fri, 27 Sep 2019 08:57:20 -0500
From:   Nicholas Graumann <nick.graumann@gmail.com>
To:     Radhey Shyam Pandey <radheys@xilinx.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle and
 halted state in axidma stop_transfer
Message-ID: <20190927135720.GA16057@lnx-nickg>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1567701424-25658-8-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20190926172107.GN3824@vkoul-mobl>
 <CH2PR02MB7000EACD029FC7E47679393CC7810@CH2PR02MB7000.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR02MB7000EACD029FC7E47679393CC7810@CH2PR02MB7000.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 27, 2019 at 06:48:29AM +0000, Radhey Shyam Pandey wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Thursday, September 26, 2019 10:51 PM
> > To: Radhey Shyam Pandey <radheys@xilinx.com>
> > Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> > nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> > Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle
> > and halted state in axidma stop_transfer
> > 
> > On 05-09-19, 22:07, Radhey Shyam Pandey wrote:
> > > From: Nicholas Graumann <nick.graumann@gmail.com>
> > >
> > > When polling for a stopped transfer in AXI DMA mode, in some cases the
> > > status of the channel may indicate IDLE instead of HALTED if the
> > > channel was reset due to an error.
> > >
> > > Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
> > > Signed-off-by: Radhey Shyam Pandey
> > <radhey.shyam.pandey@xilinx.com>
> > > ---
> > >  drivers/dma/xilinx/xilinx_dma.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c
> > > index b5dd62a..0896e07 100644
> > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > @@ -1092,8 +1092,9 @@ static int xilinx_dma_stop_transfer(struct
> > xilinx_dma_chan *chan)
> > >
> > >  	/* Wait for the hardware to halt */
> > >  	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR,
> > val,
> > > -				       val & XILINX_DMA_DMASR_HALTED, 0,
> > > -				       XILINX_DMA_LOOP_COUNT);
> > > +				       val | (XILINX_DMA_DMASR_IDLE |
> > > +					      XILINX_DMA_DMASR_HALTED),
> > 
> > The condition was bitwise AND and now is OR.. ??
> 
> Ah, it should be same as before . Only _IDLE mask should be in OR.
> 
> Also on second thought to this patch- we need to describe which error
> scenario "in some cases the status of the channel may indicate IDLE
> instead of HALTED" as mentioned in commit description.
> 
> @Nick: Can you comment?
> 
In regard to the mask question, yes, this looks like a bug.
We should be AND'ing with the mask like before.

As far as the state, usually when we saw the IDLE state when invoking 
dmaengine_terminate_all on a channel that had errors. I have not
proved this, but I believe what happened was the following:

New transactions were queued when chan->err was set, causing
xilinx_dma_chan_reset to be invoked which ultimately results in the
hardware being in an IDLE state by the time xilinx_dma_terminate_all
gets around to invoking stop_transfer. At that point, stop_transfer is
going to time out waiting for the hardware to indicate it has HALTED and
ultimately will time out.


In any case, xilinx_dma_stop_transfer should be fine with the hardware
being in an IDLE state to indicate that the active transfer is stopped.
Case in point: The CDMA core also covered by this driver only has an
IDLE bit and no HALTED bit in its DMASR, and it checks for just the IDLE
bit in xilinx_cdma_stop_transfer().
> > 
> > > +				       0, XILINX_DMA_LOOP_COUNT);
> > >  }
> > >
> > >  /**
> > > --
> > > 2.7.4
> > 
> > --
> > ~Vinod
