Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA292422A7
	for <lists+dmaengine@lfdr.de>; Wed, 12 Aug 2020 00:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHKWwS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 18:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKWwS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Aug 2020 18:52:18 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C031C06174A
        for <dmaengine@vger.kernel.org>; Tue, 11 Aug 2020 15:52:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDB4E9A8;
        Wed, 12 Aug 2020 00:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597186337;
        bh=2OPvRjIhJuE9NtcniD8wieCQ1jdfZIaegrNpOuRGiZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2xWAqX1E5oyXWPJ2/MkeHzN/O8Mq3q8XoxLNjZ5A0lGqVhsgQBIhbuNjtwi1+imu
         2e4ugFRHx284hGV5ZM2xHtKPBT/DGOLxQlIV3m1QhHWLc4KCdNjeGO7TDx67FbPhlk
         rNTM1cFyHiw+aPbEEqnT3DtLFRZAR0ou8VDV07T8=
Date:   Wed, 12 Aug 2020 01:52:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH v2 0/3] Fix Kconfig dependency issue with DMAENGINES
 selection
Message-ID: <20200811225203.GG17446@pendragon.ideasonboard.com>
References: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
 <20200731164744.GF12965@vkoul-mobl>
 <20200731204206.GC24315@pendragon.ideasonboard.com>
 <20200802064409.GH12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200802064409.GH12965@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Sun, Aug 02, 2020 at 12:14:09PM +0530, Vinod Koul wrote:
> On 31-07-20, 23:42, Laurent Pinchart wrote:
> > On Fri, Jul 31, 2020 at 10:17:44PM +0530, Vinod Koul wrote:
> > > On 31-07-20, 18:24, Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > This small series fixes a Kconfig dependency issue with the recently
> > > > merged Xilixn DPSUB DRM/KMS driver. The fix is in patch 3/3, but
> > > > requires a separate fixes in patches 1/3 and 2/3 to avoid circular
> > > > dependencies:
> > > > 
> > > >         drivers/i2c/Kconfig:8:error: recursive dependency detected!
> > > >         drivers/i2c/Kconfig:8:  symbol I2C is selected by FB_DDC
> > > >         drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
> > > >         drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
> > > >         drivers/gpu/drm/Kconfig:80:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
> > > >         drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_HELPER is selected by DRM_ZYNQMP_DPSUB
> > > >         drivers/gpu/drm/xlnx/Kconfig:1: symbol DRM_ZYNQMP_DPSUB depends on DMA_ENGINE
> > > >         drivers/dma/Kconfig:44: symbol DMA_ENGINE depends on DMADEVICES
> > > >         drivers/dma/Kconfig:6:  symbol DMADEVICES is selected by SND_SOC_SH4_SIU
> > > >         sound/soc/sh/Kconfig:30:        symbol SND_SOC_SH4_SIU is selected by SND_SIU_MIGOR
> > > >         sound/soc/sh/Kconfig:60:        symbol SND_SIU_MIGOR depends on I2C
> > > >         For a resolution refer to Documentation/kbuild/kconfig-language.rst
> > > >         subsection "Kconfig recursive dependency limitations"
> > > > 
> > > > Due to the DPSUB driver being merged in v5.9, this is a candidate fix
> > > > for v5.9 as well. 1/3 and 2/3 can be merged independently, 3/3 depends
> > > > on the first two. What's the best course of action, can I merge this all
> > > > in a single tree, or should the rapidio and ASoC patches be merged
> > > > independently early in the -rc cycle, and the DRM patch later on top ? I
> > > > don't expect conflicts (especially in 2/3 and 3/3), so merging the whole
> > > > series in one go would be simpler in my opinion.
> > > 
> > > Acked-By: Vinod Koul <vkoul@kernel.org>
> > 
> > Thank you.
> > 
> > As Mark as queued the sound fix in his for-next branch for v5.9, could
> > you queue the dmaengine fix for v5.9 too ?
> 
> Dmaengine? I see three patches none of which touch dmaengine..
> Did I miss something?

I'm not sure what I was thinking... It's the rapidio patch that needs to
be merged.

Matt, Alexandre, can you either merge the patch as a v5.9 fix, or give
me an ack to get it merged through the DRM tree ?

-- 
Regards,

Laurent Pinchart
