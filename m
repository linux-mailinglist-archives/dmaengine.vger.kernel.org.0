Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BCF229A97
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jul 2020 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbgGVOvf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 10:51:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49768 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbgGVOve (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 10:51:34 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A1A0329;
        Wed, 22 Jul 2020 16:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595429492;
        bh=/fMULphszkY0Xg0wf+ovDCCHWoF20I8KIaYsvkNYc5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peyhr82EWx91N1aY+tEZRsO8aToL3yZZ4hNZwJaJ/soCD7Xcm78FiM8tdSRvn2j9t
         lz/T4wvWRW0uBsx6xBv9MJocPdYacA8wdXaA9sZpxq70fUdFa/mFPV77Tn34rq+F4G
         uDAlHraOGXA4SYDMEsH5//BLjw2zf7i3UQ6JEkjU=
Date:   Wed, 22 Jul 2020 17:51:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 3/3] dmaengine: xilinx: dpdma: fix kernel doc format
Message-ID: <20200722145127.GC29813@pendragon.ideasonboard.com>
References: <20200718135201.191881-1-vkoul@kernel.org>
 <20200718135201.191881-3-vkoul@kernel.org>
 <20200722131119.GH5833@pendragon.ideasonboard.com>
 <20200722142608.GR12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200722142608.GR12965@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Wed, Jul 22, 2020 at 07:56:08PM +0530, Vinod Koul wrote:
> On 22-07-20, 16:11, Laurent Pinchart wrote:
> > On Sat, Jul 18, 2020 at 07:22:01PM +0530, Vinod Koul wrote:
> > > xilinx_dpdma_chan structure documents 'desc' members, but that leads
> > > to warnings, so split that up and describe members
> > > 
> > > drivers/dma/xilinx/xilinx_dpdma.c:241: warning: Function parameter or
> > > member 'desc' not described in 'xilinx_dpdma_chan'
> > > 
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  drivers/dma/xilinx/xilinx_dpdma.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> > > index 430f3714f6a3..d94c75a842f8 100644
> > > --- a/drivers/dma/xilinx/xilinx_dpdma.c
> > > +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> > > @@ -214,8 +214,8 @@ struct xilinx_dpdma_tx_desc {
> > >   * @lock: lock to access struct xilinx_dpdma_chan
> > >   * @desc_pool: descriptor allocation pool
> > >   * @err_task: error IRQ bottom half handler
> > > - * @desc.pending: Descriptor schedule to the hardware, pending execution
> > > - * @desc.active: Descriptor being executed by the hardware
> > > + * @desc: pending: Descriptor schedule to the hardware, pending execution
> > > + *        active: Descriptor being executed by the hardware
> > 
> > According to
> > https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#nested-structs-unions,
> > the existing syntax is supposed to be valid. Where does the above
> > warning come from ?
> 
> W=1 build again..

I get the same when plumbing the source file into the kerneldoc build.
The generated documentation however contains the description of both
desc.pending and desc.active. If you want to fix the warning, I think
you should instead add a line to document @desc, but without removing
the existing @desc.pending and @desc.active lines.

> > >   * @xdev: DPDMA device
> > >   */
> > >  struct xilinx_dpdma_chan {

-- 
Regards,

Laurent Pinchart
