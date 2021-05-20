Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BCA38B325
	for <lists+dmaengine@lfdr.de>; Thu, 20 May 2021 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhETP02 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 11:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243516AbhETPZu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 11:25:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E08C06138E
        for <dmaengine@vger.kernel.org>; Thu, 20 May 2021 08:24:28 -0700 (PDT)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3062AD84;
        Thu, 20 May 2021 17:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621524266;
        bh=8pcmUONH1aUUpwsB69i0J0FO1UXvfrIZMpswMRYOr58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQAz7cwvEFxSZBKzN/kA/wsj+jekvXUoo4J0OOYr+2lxDuQffPcyZrib9AbpxYmok
         FuyPOg6jq4Dl5L8W+ih/t+m/qOFRsyniOsp88UWPb2NEDvwsbcQcwXmkI/M07aIrlH
         nsP1I5fZYHbgbQlTGk5xDjGOzXKN2IyiYSPlvuWI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Jianqiang Chen <jianqian@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] dmaengine: xilinx: dpdma: Add missing dependencies to Kconfig
Date:   Thu, 20 May 2021 18:24:17 +0300
Message-Id: <20210520152420.23986-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.1
In-Reply-To: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
References: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver depends on both OF and IOMEM support, express those
dependencies in Kconfig. This fixes a build failure on S390 reported by
the 0day bot.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6ab9d9a488a6..e47d4efbe7c5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -701,6 +701,7 @@ config XILINX_ZYNQMP_DMA
 
 config XILINX_ZYNQMP_DPDMA
 	tristate "Xilinx DPDMA Engine"
+	depends on HAS_IOMEM && OF
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
Regards,

Laurent Pinchart

