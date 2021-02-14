Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5031AED5
	for <lists+dmaengine@lfdr.de>; Sun, 14 Feb 2021 04:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBNDon (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 13 Feb 2021 22:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBNDon (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 13 Feb 2021 22:44:43 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA4C061574
        for <dmaengine@vger.kernel.org>; Sat, 13 Feb 2021 19:44:03 -0800 (PST)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 772C52FE;
        Sun, 14 Feb 2021 04:43:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613274239;
        bh=Aiu8utsA/R0EL/bSR1XIAxocUingsu+BsqrWoP+MP+g=;
        h=From:To:Cc:Subject:Date:From;
        b=BACJdj49byDU91sa8417p7wiT77lN/lxfc6rzbdtYvc1nstGIAz82/XXFNpkRV5Cy
         4TKxuPC2nv8x/wXXBslxboR7wPGwS7kLcRLkOJF5VRo8dPFq7eRLB0rJbRlMny7+8h
         GDyip0oCMINeM3Jp2kqx6uKboqkJRCTf0Y/xVtAM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] dmaengine: xilinx: dpdma: Fix compilation when !HAS_IOMEM
Date:   Sun, 14 Feb 2021 05:43:19 +0200
Message-Id: <20210214034319.11569-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The xilinx-dpdma driver uses the devm_platform_ioremap_resource() API,
which is only available when HAS_IOMEM is selected. Depend on the
Kconfig symbol to fix the error.

While at it, also depend on ARCH_ZYNQ to avoid cluttering the
configuration on other platforms, unless COMPILE_TEST is selected. The
former would be enough to guarantee HAS_IOMEM, but with COMPILE_TEST we
still need to explicit dependendy on HAS_IOMEM.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d242c7632621..205bc888d49f 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -702,6 +702,8 @@ config XILINX_ZYNQMP_DMA
 
 config XILINX_ZYNQMP_DPDMA
 	tristate "Xilinx DPDMA Engine"
+	depends on ARCH_ZYNQ || COMPILE_TEST
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
Regards,

Laurent Pinchart

