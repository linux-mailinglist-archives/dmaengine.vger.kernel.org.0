Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD80234869
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jul 2020 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGaPYu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 11:24:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41324 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbgGaPYu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jul 2020 11:24:50 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66325D95;
        Fri, 31 Jul 2020 17:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596209089;
        bh=xB0gUOPhwdLlAfoF9pG/5jwaKF4JCE2b9OyRj3KJvKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8cUAQpAjaT1O0s0H8ml6yg9Lde7SvDgw+6We0vSDoPVAfqhQiEp3VsjSJr8hhzbr
         oU3EG0Fr4HiZaLn5cxRZ4gPhcMe/b+9Yh11XXRZfilR/DWPtpHbujIcrOsXSSwnftG
         jNjud1pUxHaQs1J3e0/lpjkZIU0MxFeW0YcJjDrs=
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
Subject: [PATCH v2 3/3] drm: xlnx: dpsub: Fix DMADEVICES Kconfig dependency
Date:   Fri, 31 Jul 2020 18:24:33 +0300
Message-Id: <20200731152433.1297-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
References: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
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

