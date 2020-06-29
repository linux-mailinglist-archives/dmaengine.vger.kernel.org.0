Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE18120E276
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 00:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390284AbgF2VFi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbgF2TMn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jun 2020 15:12:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A60C0086D8
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2020 02:30:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6DD5F2B3;
        Mon, 29 Jun 2020 11:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593423044;
        bh=Saol7L3H0VGdy6cAigbabBK4AhIm5QXCZUaNt34Hsxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkQ23763M9Bn+dZyMWRVqUBepaFiZ6q60PPx624H5LdsIrbDUv2LMV8H+iYaSJPht
         zbX2Xo//wIuuXWFACpW3dt6OVeWIQuMD0lfC394Utt79CsxiWdnh6sUVKDdkX9py3p
         dCHgGY1GaU4q2I3EM5ai6Rv0Cc5IYEDKtgIgA0kU=
Date:   Mon, 29 Jun 2020 12:30:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/6] dma: Add Xilinx ZynqMP DPDMA driver
Message-ID: <20200629093041.GE6012@pendragon.ideasonboard.com>
References: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

CC'ing Greg.

The first version of this patch series I've posted dates back from early
November last year. Could you please help getting it merged ?

On Thu, May 28, 2020 at 05:52:22AM +0300, Laurent Pinchart wrote:
> Hello,
> 
> This patch series adds a new driver for the DPDMA engine found in the
> Xilinx ZynqMP.
> 
> The previous version can be found at [1]. All review comments have been
> taken into account. The only change is the addition of the
> DMA_PREP_LOAD_EOT transaction flag (and the corresponding DMA_LOAD_EOT
> capability bit), as requested during the review of v4. Please see the
> discussions from v4 for the rationale.
> 
> The driver has been successfully tested with the ZynqMP DisplayPort
> subsystem DRM driver.
> 
> [1] https://lore.kernel.org/dmaengine/20200513165943.25120-1-laurent.pinchart@ideasonboard.com/
> 
> Hyun Kwon (1):
>   dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver
> 
> Laurent Pinchart (5):
>   dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
>   dmaengine: virt-dma: Use lockdep to check locking requirements
>   dmaengine: Add support for repeating transactions
>   dmaengine: xilinx: dpdma: Add debugfs support
>   arm64: dts: zynqmp: Add DPDMA node
> 
>  .../dma/xilinx/xlnx,zynqmp-dpdma.yaml         |   68 +
>  MAINTAINERS                                   |    9 +
>  .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |    4 +
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   10 +
>  drivers/dma/Kconfig                           |   10 +
>  drivers/dma/virt-dma.c                        |    2 +
>  drivers/dma/virt-dma.h                        |   10 +
>  drivers/dma/xilinx/Makefile                   |    1 +
>  drivers/dma/xilinx/xilinx_dpdma.c             | 1782 +++++++++++++++++
>  include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   |   16 +
>  include/linux/dmaengine.h                     |   19 +
>  11 files changed, 1931 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
>  create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c
>  create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h

-- 
Regards,

Laurent Pinchart
