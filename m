Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493F320E556
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 00:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgF2Vfx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 17:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbgF2Skq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:46 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7717D23772;
        Mon, 29 Jun 2020 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593424611;
        bh=idXPzKmtDVif9QXEO0/n7K8hVyQ6Ksxmg/BKsm84pP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1yAw7U7ewZFYDAtL37FuU/ga080RSmSZTiF5XTw3av4okBK2wlfBUp0Tms+Jr+AW
         SehKjKckuchwDkzdYCoZl0EmSWEYc8nPqn9kfLR7kRo+Lvb9cLnm1jRpBMEbIvPiJE
         TSvSXRiY43lR6RsLpE594MsPU5nfGPpsMgerVd+E=
Date:   Mon, 29 Jun 2020 15:26:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/6] dma: Add Xilinx ZynqMP DPDMA driver
Message-ID: <20200629095647.GI2599@vkoul-mobl>
References: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
 <20200629093041.GE6012@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629093041.GE6012@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 29-06-20, 12:30, Laurent Pinchart wrote:
> Hi Vinod,
> 
> CC'ing Greg.
> 
> The first version of this patch series I've posted dates back from early
> November last year. Could you please help getting it merged ?

Sorry for the delay in reviewing this series, this one is on my review
list for this week, so I should get to this  very soon.

> 
> On Thu, May 28, 2020 at 05:52:22AM +0300, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch series adds a new driver for the DPDMA engine found in the
> > Xilinx ZynqMP.
> > 
> > The previous version can be found at [1]. All review comments have been
> > taken into account. The only change is the addition of the
> > DMA_PREP_LOAD_EOT transaction flag (and the corresponding DMA_LOAD_EOT
> > capability bit), as requested during the review of v4. Please see the
> > discussions from v4 for the rationale.
> > 
> > The driver has been successfully tested with the ZynqMP DisplayPort
> > subsystem DRM driver.
> > 
> > [1] https://lore.kernel.org/dmaengine/20200513165943.25120-1-laurent.pinchart@ideasonboard.com/
> > 
> > Hyun Kwon (1):
> >   dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver
> > 
> > Laurent Pinchart (5):
> >   dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
> >   dmaengine: virt-dma: Use lockdep to check locking requirements
> >   dmaengine: Add support for repeating transactions
> >   dmaengine: xilinx: dpdma: Add debugfs support
> >   arm64: dts: zynqmp: Add DPDMA node
> > 
> >  .../dma/xilinx/xlnx,zynqmp-dpdma.yaml         |   68 +
> >  MAINTAINERS                                   |    9 +
> >  .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |    4 +
> >  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   10 +
> >  drivers/dma/Kconfig                           |   10 +
> >  drivers/dma/virt-dma.c                        |    2 +
> >  drivers/dma/virt-dma.h                        |   10 +
> >  drivers/dma/xilinx/Makefile                   |    1 +
> >  drivers/dma/xilinx/xilinx_dpdma.c             | 1782 +++++++++++++++++
> >  include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   |   16 +
> >  include/linux/dmaengine.h                     |   19 +
> >  11 files changed, 1931 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> >  create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c
> >  create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
~Vinod
