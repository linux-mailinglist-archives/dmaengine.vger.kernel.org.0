Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83B0123F5F
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 07:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRGEu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Dec 2019 01:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLRGEt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Dec 2019 01:04:49 -0500
Received: from localhost (unknown [27.59.34.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C964F2053B;
        Wed, 18 Dec 2019 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576649088;
        bh=KwPuZdR5lSwje+uhKXoVIKve1o6Gk5r5nmvl/M3/epw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXJ1+uJZuO0XEHpCJzw3AQzS4Rs73Qj7rxAOEamLyGimaDZMncGbiWAayRsRlenV1
         w9i5x9W+6uHFtAtvAenxYSOr5+czXfp/IeJB40mwltaWuNkPoM+Eow5gaMKvdDkFgi
         mq0lNCxtdL4ERtTibmjQV+kf1VjEdVX1mscciTw0=
Date:   Wed, 18 Dec 2019 11:34:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radheys@xilinx.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "nick.graumann@gmail.com" <nick.graumann@gmail.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Reset DMA channel in
 dma_terminate_all
Message-ID: <20191218060437.GQ2536@vkoul-mobl>
References: <1574664121-13451-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20191210060113.GP82508@vkoul-mobl>
 <CH2PR02MB70009D78EA8C487BFFA54964C75A0@CH2PR02MB7000.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR02MB70009D78EA8C487BFFA54964C75A0@CH2PR02MB7000.namprd02.prod.outlook.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-12-19, 14:46, Radhey Shyam Pandey wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Tuesday, December 10, 2019 11:31 AM
> > To: Radhey Shyam Pandey <radheys@xilinx.com>
> > Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> > nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> > Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; git
> > <git@xilinx.com>
> > Subject: Re: [PATCH] dmaengine: xilinx_dma: Reset DMA channel in
> > dma_terminate_all
> > 
> > On 25-11-19, 12:12, Radhey Shyam Pandey wrote:
> > > Reset DMA channel after stop to ensure that pending transfers and
> > > FIFOs in the datapath are flushed or completed. It fixes intermittent
> > > data verification failure reported by xilinx dma test client.
> > >
> > > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > > ---
> > >  drivers/dma/xilinx/xilinx_dma.c | 17 +++++++++--------
> > >  1 file changed, 9 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > > b/drivers/dma/xilinx/xilinx_dma.c index a9c5d5c..6f1539c 100644
> > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > @@ -2404,16 +2404,17 @@ static int xilinx_dma_terminate_all(struct
> > dma_chan *dchan)
> > >  	u32 reg;
> > >  	int err;
> > >
> > > -	if (chan->cyclic)
> > > -		xilinx_dma_chan_reset(chan);
> > 
> > So reset is required for non cyclic cases as well now?
> 
> Yes. In absence of reset in non-cyclic case, when dmatest client
> driver is stressed and loaded/unloaded multiple times we see dma 
> data comparison failures. Possibly IP is prefetching/holding the
> previous state and reset ensures a clean state on each iteration.
> > 
> > > -
> > > -	err = chan->stop_transfer(chan);
> > > -	if (err) {
> > > -		dev_err(chan->dev, "Cannot stop channel %p: %x\n",
> > > -			chan, dma_ctrl_read(chan,
> > XILINX_DMA_REG_DMASR));
> > > -		chan->err = true;
> > > +	if (!chan->cyclic) {
> > > +		err = chan->stop_transfer(chan);
> > 
> > no stop for cyclic now..?
> After reset stop is not needed, so for the cyclic mode we only do reset.

Okay makes sense, can you please add these as comments, down the line
these will be very useful for you & others to debug!

-- 
~Vinod
