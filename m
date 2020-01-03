Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9577B12F265
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jan 2020 01:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgACA7a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jan 2020 19:59:30 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:56768 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACA7a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jan 2020 19:59:30 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B799516;
        Fri,  3 Jan 2020 01:59:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1578013168;
        bh=avADPdVIPmgkTxjzmwCLXbS5lpBP31JmxFilJEC7pQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=op1UOZHCG9Rn3cGisw30vezWCAjcc8W4WoEeUeKkGFOXc3qa+p9cIZf7eVQaRaMRV
         mKR6XtTp90J1fXaC2RMgUw6ikblVe6QpUnCH96KtdGkCgW+SyEOI6bAa4b48gGe50h
         UU5TBI9xBNDDSAHwUv9bAOi+hWxdRIZ1p4edYja8=
Date:   Fri, 3 Jan 2020 02:59:18 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Hyun Kwon <hyunk@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v2 2/4] dma: xilinx: dpdma: Add the Xilinx DisplayPort
 DMA engine driver
Message-ID: <20200103005918.GO4843@pendragon.ideasonboard.com>
References: <20191109175908.GI952516@vkoul-mobl>
 <20191205150407.GL4734@pendragon.ideasonboard.com>
 <20191205163909.GH82508@vkoul-mobl>
 <20191205202746.GA26880@smtp.xilinx.com>
 <20191208160349.GD14311@pendragon.ideasonboard.com>
 <20191220051309.GA19504@pendragon.ideasonboard.com>
 <20191220080127.GI2536@vkoul-mobl>
 <20191220123523.GB4865@pendragon.ideasonboard.com>
 <20191220154059.GR2536@vkoul-mobl>
 <20191220160232.GE4865@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191220160232.GE4865@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Fri, Dec 20, 2019 at 06:02:32PM +0200, Laurent Pinchart wrote:
> On Fri, Dec 20, 2019 at 09:10:59PM +0530, Vinod Koul wrote:
> > On 20-12-19, 14:35, Laurent Pinchart wrote:
> > > On Fri, Dec 20, 2019 at 01:31:27PM +0530, Vinod Koul wrote:
> > > > On 20-12-19, 07:13, Laurent Pinchart wrote:
> > > > 
> > > > > > OK, in the light of this information I'll keep the two separate and will
> > > > > > switch to vchan as requested by Vinod.
> > > > > 
> > > > > I've moved forward with this task, but eventually ran into one hack in
> > > > > the driver that is more difficult to get rid of than the other ones.
> > > > > 
> > > > > For display operation, the DPSUB driver needs to submit cyclic
> > > > > interleaved transfer requests. There's no such thing (as far as I can
> > > > > tell) in the DMA engine API, so the DPDMA drive simply keeps processing
> > > > 
> > > > we do support interleave, you need to implement
> > > > .device_prep_interleaved_dma and use dmaengine_prep_interleaved_dma()
> > > > from the client
> > > 
> > > I mean both interleaved and cyclic at the same time.
> > > 
> > > > > the same descriptor over and over again until a new one is issued. The
> > > > > hardware supports this with the help of hardware-based chaining of
> > > > > descriptors, and the DPDMA driver simply sets the next pointer of the
> > > > > descriptor to itself.
> > > > > 
> > > > > How can I solve this in a way that wouldn't abuse the DMA engine API ?
> > > > 
> > > > Is this not a cyclic case of descriptor?
> > > 
> > > Exactly my point :-) It's cyclic, but has to be interleaved too as it's
> > > a 2D transfer.
> > 
> > IIRC the interleaved descriptor can be set in such a way that last chunk
> > points to the first one..
> 
> I don't see a way to do this in the existing API, am I missing something
> ? And how would the completion handler be called in that case, once per
> frame still ? I don't think vchan supports this at the moment
> 
> > I think Jassi had good ideas for generic interleave API which can do
> > all this :)
> 
> How do I get this driver moving forward in the meantime ? :-)

Happy new year, and gentle ping :-)

-- 
Regards,

Laurent Pinchart
