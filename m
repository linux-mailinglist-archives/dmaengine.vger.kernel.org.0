Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21452234866
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jul 2020 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgGaPYs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgGaPYs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jul 2020 11:24:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B6C061574
        for <dmaengine@vger.kernel.org>; Fri, 31 Jul 2020 08:24:48 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C613253C;
        Fri, 31 Jul 2020 17:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596209086;
        bh=1jEtHKBuUmX31jIArrukyhniEPcaJWdiV6IZDK8bqvw=;
        h=From:To:Cc:Subject:Date:From;
        b=iyJx/eGqicVHgTfLJWVe2f9ocLWfDcpHSnQDW1pebeN7jD6i8NTbEvHT7wp43zXwO
         mbAw7UCwQQYGN+9a7plPjP4rkwoX1XXpiQAsu59LTJmmGqr5ZlWqNilszpZpLr4G/g
         Gqxqo8OaSXK79KUt7SrOEyvpPNjoy/mthyhKdrbI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>
Subject: [PATCH v2 0/3] Fix Kconfig dependency issue with DMAENGINES selection
Date:   Fri, 31 Jul 2020 18:24:30 +0300
Message-Id: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This small series fixes a Kconfig dependency issue with the recently
merged Xilixn DPSUB DRM/KMS driver. The fix is in patch 3/3, but
requires a separate fixes in patches 1/3 and 2/3 to avoid circular
dependencies:

        drivers/i2c/Kconfig:8:error: recursive dependency detected!
        drivers/i2c/Kconfig:8:  symbol I2C is selected by FB_DDC
        drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
        drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
        drivers/gpu/drm/Kconfig:80:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
        drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_HELPER is selected by DRM_ZYNQMP_DPSUB
        drivers/gpu/drm/xlnx/Kconfig:1: symbol DRM_ZYNQMP_DPSUB depends on DMA_ENGINE
        drivers/dma/Kconfig:44: symbol DMA_ENGINE depends on DMADEVICES
        drivers/dma/Kconfig:6:  symbol DMADEVICES is selected by SND_SOC_SH4_SIU
        sound/soc/sh/Kconfig:30:        symbol SND_SOC_SH4_SIU is selected by SND_SIU_MIGOR
        sound/soc/sh/Kconfig:60:        symbol SND_SIU_MIGOR depends on I2C
        For a resolution refer to Documentation/kbuild/kconfig-language.rst
        subsection "Kconfig recursive dependency limitations"

Due to the DPSUB driver being merged in v5.9, this is a candidate fix
for v5.9 as well. 1/3 and 2/3 can be merged independently, 3/3 depends
on the first two. What's the best course of action, can I merge this all
in a single tree, or should the rapidio and ASoC patches be merged
independently early in the -rc cycle, and the DRM patch later on top ? I
don't expect conflicts (especially in 2/3 and 3/3), so merging the whole
series in one go would be simpler in my opinion.

Compared to v1, commit messages have been fixed to mention DMADEVICES
instead of DMAENGINES.

Laurent Pinchart (3):
  rapidio: Replace 'select' DMADEVICES 'with depends on'
  ASoC: sh: Replace 'select' DMADEVICES 'with depends on'
  drm: xlnx: dpsub: Fix DMADEVICES Kconfig dependency

 drivers/gpu/drm/xlnx/Kconfig | 1 +
 drivers/rapidio/Kconfig      | 2 +-
 sound/soc/sh/Kconfig         | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart

