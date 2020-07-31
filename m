Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22888234C67
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jul 2020 22:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgGaUmT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgGaUmT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jul 2020 16:42:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C07C061574
        for <dmaengine@vger.kernel.org>; Fri, 31 Jul 2020 13:42:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB6D353C;
        Fri, 31 Jul 2020 22:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596228136;
        bh=TGDv3Frj4rCMmzqFPlTvoVIycIJIp6yYmbKH/jOE9mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Im3+k8u+Yxa3c9UDV4VQq4DNQKg69ugyaC0/L5DmB2fFrkduhebVB6KTRG6iVWOXa
         egFJ/d36EO5mvPkd5KwvF3DNugdzJwhUdIkiLFzsp02rX3vkq8SC/KwnGOV1ia4eVw
         Bs2wh5kDTRDxiPEdhX1Rhc3bov2XSPe5p41MPOfk=
Date:   Fri, 31 Jul 2020 23:42:06 +0300
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
Message-ID: <20200731204206.GC24315@pendragon.ideasonboard.com>
References: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
 <20200731164744.GF12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731164744.GF12965@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Fri, Jul 31, 2020 at 10:17:44PM +0530, Vinod Koul wrote:
> On 31-07-20, 18:24, Laurent Pinchart wrote:
> > Hello,
> > 
> > This small series fixes a Kconfig dependency issue with the recently
> > merged Xilixn DPSUB DRM/KMS driver. The fix is in patch 3/3, but
> > requires a separate fixes in patches 1/3 and 2/3 to avoid circular
> > dependencies:
> > 
> >         drivers/i2c/Kconfig:8:error: recursive dependency detected!
> >         drivers/i2c/Kconfig:8:  symbol I2C is selected by FB_DDC
> >         drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
> >         drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
> >         drivers/gpu/drm/Kconfig:80:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
> >         drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_HELPER is selected by DRM_ZYNQMP_DPSUB
> >         drivers/gpu/drm/xlnx/Kconfig:1: symbol DRM_ZYNQMP_DPSUB depends on DMA_ENGINE
> >         drivers/dma/Kconfig:44: symbol DMA_ENGINE depends on DMADEVICES
> >         drivers/dma/Kconfig:6:  symbol DMADEVICES is selected by SND_SOC_SH4_SIU
> >         sound/soc/sh/Kconfig:30:        symbol SND_SOC_SH4_SIU is selected by SND_SIU_MIGOR
> >         sound/soc/sh/Kconfig:60:        symbol SND_SIU_MIGOR depends on I2C
> >         For a resolution refer to Documentation/kbuild/kconfig-language.rst
> >         subsection "Kconfig recursive dependency limitations"
> > 
> > Due to the DPSUB driver being merged in v5.9, this is a candidate fix
> > for v5.9 as well. 1/3 and 2/3 can be merged independently, 3/3 depends
> > on the first two. What's the best course of action, can I merge this all
> > in a single tree, or should the rapidio and ASoC patches be merged
> > independently early in the -rc cycle, and the DRM patch later on top ? I
> > don't expect conflicts (especially in 2/3 and 3/3), so merging the whole
> > series in one go would be simpler in my opinion.
> 
> Acked-By: Vinod Koul <vkoul@kernel.org>

Thank you.

As Mark as queued the sound fix in his for-next branch for v5.9, could
you queue the dmaengine fix for v5.9 too ?

-- 
Regards,

Laurent Pinchart
