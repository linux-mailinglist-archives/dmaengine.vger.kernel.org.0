Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577062491AC
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 02:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHSAKw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 20:10:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48810 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHSAKv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 20:10:51 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6EB9A29E;
        Wed, 19 Aug 2020 02:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597795848;
        bh=7f6JpwIgaRJBXO+151bdoDs5oIFbz35n2tdS14jETBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwDXuS7ZbIVAOHcNlwfpMFGBDgWNtIzCGpPzBRmqm8H6cnpa2vYGtvBHgh8U6HN++
         jEXQv8dmuB3wVOpQMrbh6C+oqqwSvl7mYDV2swsNUO42nOBDe9aEVlph7RyCRp4P/p
         RlK28BiO2qc+D+WcPo6uZu6pvUoQyJkptMQpbI4s=
Date:   Wed, 19 Aug 2020 03:10:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] Fix Kconfig dependency issue with DMAENGINES
 selection
Message-ID: <20200819001030.GF2360@pendragon.ideasonboard.com>
References: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
 <20200731164744.GF12965@vkoul-mobl>
 <20200731204206.GC24315@pendragon.ideasonboard.com>
 <20200802064409.GH12965@vkoul-mobl>
 <20200811225203.GG17446@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200811225203.GG17446@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Matt, Alexandre,

Gentle ping. As this should be fixed in v5.9, a quick reply would be
really appreciated. Otherwise I'll have to bundle the rapidio fix with
the DPSUB fix, and get them both merged through the DRM/KMS tree without
your ack.

On Wed, Aug 12, 2020 at 01:52:04AM +0300, Laurent Pinchart wrote:
> On Sun, Aug 02, 2020 at 12:14:09PM +0530, Vinod Koul wrote:
> > On 31-07-20, 23:42, Laurent Pinchart wrote:
> > > On Fri, Jul 31, 2020 at 10:17:44PM +0530, Vinod Koul wrote:
> > > > On 31-07-20, 18:24, Laurent Pinchart wrote:
> > > > > Hello,
> > > > > 
> > > > > This small series fixes a Kconfig dependency issue with the recently
> > > > > merged Xilixn DPSUB DRM/KMS driver. The fix is in patch 3/3, but
> > > > > requires a separate fixes in patches 1/3 and 2/3 to avoid circular
> > > > > dependencies:
> > > > > 
> > > > >         drivers/i2c/Kconfig:8:error: recursive dependency detected!
> > > > >         drivers/i2c/Kconfig:8:  symbol I2C is selected by FB_DDC
> > > > >         drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
> > > > >         drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
> > > > >         drivers/gpu/drm/Kconfig:80:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
> > > > >         drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_HELPER is selected by DRM_ZYNQMP_DPSUB
> > > > >         drivers/gpu/drm/xlnx/Kconfig:1: symbol DRM_ZYNQMP_DPSUB depends on DMA_ENGINE
> > > > >         drivers/dma/Kconfig:44: symbol DMA_ENGINE depends on DMADEVICES
> > > > >         drivers/dma/Kconfig:6:  symbol DMADEVICES is selected by SND_SOC_SH4_SIU
> > > > >         sound/soc/sh/Kconfig:30:        symbol SND_SOC_SH4_SIU is selected by SND_SIU_MIGOR
> > > > >         sound/soc/sh/Kconfig:60:        symbol SND_SIU_MIGOR depends on I2C
> > > > >         For a resolution refer to Documentation/kbuild/kconfig-language.rst
> > > > >         subsection "Kconfig recursive dependency limitations"
> > > > > 
> > > > > Due to the DPSUB driver being merged in v5.9, this is a candidate fix
> > > > > for v5.9 as well. 1/3 and 2/3 can be merged independently, 3/3 depends
> > > > > on the first two. What's the best course of action, can I merge this all
> > > > > in a single tree, or should the rapidio and ASoC patches be merged
> > > > > independently early in the -rc cycle, and the DRM patch later on top ? I
> > > > > don't expect conflicts (especially in 2/3 and 3/3), so merging the whole
> > > > > series in one go would be simpler in my opinion.
> > > > 
> > > > Acked-By: Vinod Koul <vkoul@kernel.org>
> > > 
> > > Thank you.
> > > 
> > > As Mark as queued the sound fix in his for-next branch for v5.9, could
> > > you queue the dmaengine fix for v5.9 too ?
> > 
> > Dmaengine? I see three patches none of which touch dmaengine..
> > Did I miss something?
> 
> I'm not sure what I was thinking... It's the rapidio patch that needs to
> be merged.
> 
> Matt, Alexandre, can you either merge the patch as a v5.9 fix, or give
> me an ack to get it merged through the DRM tree ?

-- 
Regards,

Laurent Pinchart
