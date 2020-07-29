Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB7B2322B2
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jul 2020 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG2Q3m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jul 2020 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgG2Q3m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jul 2020 12:29:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81294C061794
        for <dmaengine@vger.kernel.org>; Wed, 29 Jul 2020 09:29:42 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E3EF0B8F;
        Wed, 29 Jul 2020 18:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596040175;
        bh=xB0gUOPhwdLlAfoF9pG/5jwaKF4JCE2b9OyRj3KJvKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYYNQyechBS9DDJZD2f89/DwSMsDTMQ3EOFY0Zo2J5b9Ez0Eeli9dVGXtarDSmmfP
         DZtNq1L63JGMHdJuAQautBotENM041aBnjW12gqgtqKlpESRCbOndNPGHK8oWm0mZu
         IqmOzWXg0+r8yJJ75Z+57b2grBcvJ8C8GqYo8L8E=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>
Subject: [PATCH 3/3] drm: xlnx: dpsub: Fix DMADEVICES Kconfig dependency
Date:   Wed, 29 Jul 2020 19:29:10 +0300
Message-Id: <20200729162910.13196-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
References: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dpsub driver uses the DMA engine API, and thus selects DMA_ENGINE to
provide that API. DMA_ENGINE depends on DMADEVICES, which can be
deselected by the user, creating a possibly unmet indirect dependency:

WARNING: unmet direct dependencies detected for DMA_ENGINE
  Depends on [n]: DMADEVICES [=n]
  Selected by [m]:
  - DRM_ZYNQMP_DPSUB [=m] && HAS_IOMEM [=y] && (ARCH_ZYNQMP || COMPILE_TEST [=y]) && COMMON_CLK [=y] && DRM [=m] && OF [=y]

Add a dependency on DMADEVICES to fix this.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/gpu/drm/xlnx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
index aa6cd889bd11..b52c6cdfc0b8 100644
--- a/drivers/gpu/drm/xlnx/Kconfig
+++ b/drivers/gpu/drm/xlnx/Kconfig
@@ -2,6 +2,7 @@ config DRM_ZYNQMP_DPSUB
 	tristate "ZynqMP DisplayPort Controller Driver"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on COMMON_CLK && DRM && OF
+	depends on DMADEVICES
 	select DMA_ENGINE
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
-- 
Regards,

Laurent Pinchart

