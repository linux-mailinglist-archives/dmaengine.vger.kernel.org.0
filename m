Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A48224773
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jul 2020 02:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGRAY1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 20:24:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38286 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgGRAY1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 20:24:27 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CCCD471D;
        Sat, 18 Jul 2020 02:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595031865;
        bh=XFqAobomhursN/um5vLhkR2zQB6iwoMPxBhk5EDHbWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fo2Rxc+Vl4+NmFsQdtTvcoCNaMKeWd1az7ImIlY1Z4/GJSC6DLz4MTiWbM0KJDpvW
         2C3AmjQfGhEhW3dr4evSr7p8HhzSqZJBraKSyESFHY/3gTu0eQOh+atqDaiWCvNJaN
         RjibJP09Gk5vOKcId8vgy1hrXuJ707t/lHV/eHnE=
Date:   Sat, 18 Jul 2020 03:24:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v7 0/5] dma: Add Xilinx ZynqMP DPDMA driver
Message-ID: <20200718002416.GC5962@pendragon.ideasonboard.com>
References: <20200717013337.24122-1-laurent.pinchart@ideasonboard.com>
 <20200717061120.GE82923@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200717061120.GE82923@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Fri, Jul 17, 2020 at 11:41:20AM +0530, Vinod Koul wrote:
> On 17-07-20, 04:33, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch series adds a new driver for the DPDMA engine found in the
> > Xilinx ZynqMP.
> > 
> > The previous version can be found at [1]. All review comments have been
> > taken into account. The main changes are in the DPDMA driver, with
> > cleanups in the debugfs support, and handling of the !LOAD_EOT case when
> > preparing transactions.
> > 
> > The driver has been successfully tested with the ZynqMP DisplayPort
> > subsystem DRM driver.
> > 
> > As I would like to merge both this series and the DRM driver that
> > depends on it for v5.9 (if still possible), I have based those patches
> > on top of v5.8-rc1. There's unfortunately a conflict with the DMA engine
> > next branch, which is easy to resolve.
> > 
> > Vinod, if you're fine with the series, I can propose two ways forward:
> > 
> > - You can apply the patches on top of v5.8-rc1, push that to a base
> >   branch, merge it into the dmaengine -next branch, and push the base
> >   branch to a public git tree to let me base the DRM driver on it.
> 
> Applied 1-3 to dmaengine.git topic/xilinx, it should show up in -next
> later in the day

Thank you!

-- 
Regards,

Laurent Pinchart
