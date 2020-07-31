Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8617234B59
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jul 2020 20:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbgGaSzA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 14:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387798AbgGaSy7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 31 Jul 2020 14:54:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB7232076B;
        Fri, 31 Jul 2020 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596221698;
        bh=jS1U4zFDamDkVxZwKJMZWoe2ooesb2SZQVbitfvRu1I=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ln8yi3GE3vhvcFG2k8S9Qjp3IZpII2VUpDPaxJMt85QZbFtefUTPoh4c0W3r4L6u6
         LEFS0v4TnWyC7TkC3a7BVRgu6VNZBTWuzWD+9X+QJmyxEiH2FTesoleWY1/3vjBt2C
         87g5UvNf8U3KZsdN2cuUhVd1L5RBM22z7eURZ89w=
Date:   Fri, 31 Jul 2020 19:54:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
References: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/3] Fix Kconfig dependency issue with DMAENGINES selection
Message-Id: <159622167149.22822.4163044113413538310.b4-ty@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 29 Jul 2020 19:29:07 +0300, Laurent Pinchart wrote:
> This small series fixes a Kconfig dependency issue with the recently
> merged Xilixn DPSUB DRM/KMS driver. The fix is in patch 3/3, but
> requires a separate fixes in patches 1/3 and 2/3 to avoid circular
> dependencies:
> 
> 	drivers/i2c/Kconfig:8:error: recursive dependency detected!
> 	drivers/i2c/Kconfig:8:  symbol I2C is selected by FB_DDC
> 	drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
> 	drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
> 	drivers/gpu/drm/Kconfig:80:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
> 	drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_HELPER is selected by DRM_ZYNQMP_DPSUB
> 	drivers/gpu/drm/xlnx/Kconfig:1: symbol DRM_ZYNQMP_DPSUB depends on DMA_ENGINE
> 	drivers/dma/Kconfig:44: symbol DMA_ENGINE depends on DMADEVICES
> 	drivers/dma/Kconfig:6:  symbol DMADEVICES is selected by SND_SOC_SH4_SIU
> 	sound/soc/sh/Kconfig:30:        symbol SND_SOC_SH4_SIU is selected by SND_SIU_MIGOR
> 	sound/soc/sh/Kconfig:60:        symbol SND_SIU_MIGOR depends on I2C
> 	For a resolution refer to Documentation/kbuild/kconfig-language.rst
> 	subsection "Kconfig recursive dependency limitations"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sh: Replace 'select' DMADEVICES 'with depends on'
      commit: 2dbf11ec7d3a63ebde946b5747ad6bd74d45adb1

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
