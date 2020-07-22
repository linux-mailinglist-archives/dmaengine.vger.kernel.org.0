Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A14229A09
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jul 2020 16:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGVO0N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 10:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgGVO0N (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Jul 2020 10:26:13 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0BAC20709;
        Wed, 22 Jul 2020 14:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595427973;
        bh=7dXMgkDvN/RRf88HUufDO2HIwI/VEp1DsV5zWW3Lekk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1/gFlMMrITciVlDEDFdJwXhieQ/IF3zcaB6DMpbOrtUIGjySnhX7yq1/kAfzV5+zV
         nPQkiRchfwqCAERreo3SurGRGLUk7Cd8N/JfcR0SZMZ9kiIEAn582m5MecVjh5QyxR
         jQ4qW/O3tSaN1Dci3+Fli6BYe2foos1nc5qAWIFM=
Date:   Wed, 22 Jul 2020 19:56:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 3/3] dmaengine: xilinx: dpdma: fix kernel doc format
Message-ID: <20200722142608.GR12965@vkoul-mobl>
References: <20200718135201.191881-1-vkoul@kernel.org>
 <20200718135201.191881-3-vkoul@kernel.org>
 <20200722131119.GH5833@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722131119.GH5833@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-20, 16:11, Laurent Pinchart wrote:
> Hi Vinod,
> 
> Thank you for the patch.
> 
> On Sat, Jul 18, 2020 at 07:22:01PM +0530, Vinod Koul wrote:
> > xilinx_dpdma_chan structure documents 'desc' members, but that leads
> > to warnings, so split that up and describe members
> > 
> > drivers/dma/xilinx/xilinx_dpdma.c:241: warning: Function parameter or
> > member 'desc' not described in 'xilinx_dpdma_chan'
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/dma/xilinx/xilinx_dpdma.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> > index 430f3714f6a3..d94c75a842f8 100644
> > --- a/drivers/dma/xilinx/xilinx_dpdma.c
> > +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> > @@ -214,8 +214,8 @@ struct xilinx_dpdma_tx_desc {
> >   * @lock: lock to access struct xilinx_dpdma_chan
> >   * @desc_pool: descriptor allocation pool
> >   * @err_task: error IRQ bottom half handler
> > - * @desc.pending: Descriptor schedule to the hardware, pending execution
> > - * @desc.active: Descriptor being executed by the hardware
> > + * @desc: pending: Descriptor schedule to the hardware, pending execution
> > + *        active: Descriptor being executed by the hardware
> 
> According to
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#nested-structs-unions,
> the existing syntax is supposed to be valid. Where does the above
> warning come from ?

W=1 build again..

> 
> >   * @xdev: DPDMA device
> >   */
> >  struct xilinx_dpdma_chan {
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
~Vinod
