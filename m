Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53125EB84
	for <lists+dmaengine@lfdr.de>; Sun,  6 Sep 2020 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgIEWl2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 5 Sep 2020 18:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgIEWl1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 5 Sep 2020 18:41:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1434DC061244
        for <dmaengine@vger.kernel.org>; Sat,  5 Sep 2020 15:41:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0F3A0335;
        Sun,  6 Sep 2020 00:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599345680;
        bh=+JnWbrRsHBmaman0I5wNAZAxxg71ZprVjbM/kQoQtBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jl236eIgq29eClfDRSHbXnPT1eVeOnQT8SGPjwd8PFKzYJisCrcIyQQxqH59b0uyZ
         v8IRZmKFreC9qEtIko7Pka8hvqn1FND8ygpJJIe+/sGbkI2gAV8QDivGFW/DnBt/0R
         5B3y1kuoVjLinGmpf+PTZYIWry/TCiBJ6Tlj2q6g=
Date:   Sun, 6 Sep 2020 01:40:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [GIT PULL FOR v5.9] Fix Kconfig dependency issue with DMAENGINES
 selection
Message-ID: <20200905224056.GA10794@pendragon.ideasonboard.com>
References: <20200905172751.GC6319@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905172751.GC6319@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With Dave and Daniel on the recipients' list this time.

On Sat, Sep 05, 2020 at 08:27:51PM +0300, Laurent Pinchart wrote:
> Hi Dave and Daniel,
> 
> This small pull request fixes a Kconfig dependency issue introduced in
> v5.9-rc1. Among the three patches required to fix the issue, the ASoC
> fix has been merged in Linus' tree already. I haven't been able to get
> the RapidIO patch reviewed by the subsystem maintainers, so I've
> included it here as it's a dependency for the DRM patch.
> 
> The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:
> 
>   Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://linuxtv.org/pinchartl/media.git tags/drm-xlnx-dpsub-fixes-20200905
> 
> for you to fetch changes up to 3e8b2403545efd46c6347002e27eae4708205fd4:
> 
>   drm: xlnx: dpsub: Fix DMADEVICES Kconfig dependency (2020-09-05 19:52:54 +0300)
> 
> ----------------------------------------------------------------
> Kconfig fixes for DRM_ZYNQMP_DPSUB DMA engine dependency
> 
> ----------------------------------------------------------------
> Laurent Pinchart (2):
>       rapidio: Replace 'select' DMAENGINES 'with depends on'
>       drm: xlnx: dpsub: Fix DMADEVICES Kconfig dependency
> 
>  drivers/gpu/drm/xlnx/Kconfig | 1 +
>  drivers/rapidio/Kconfig      | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 

-- 
Regards,

Laurent Pinchart
