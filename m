Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D25234868
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jul 2020 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbgGaPYu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jul 2020 11:24:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41316 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgGaPYu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jul 2020 11:24:50 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84D85B83;
        Fri, 31 Jul 2020 17:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596209088;
        bh=UqaLHXGEvWF6bf+r1UT6gPxJ23EEhgK8OJfXiuRbETQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IupZ5z4l9m5M8A7SQqy2LlPfrGEPnAoeLvQDXo+/Er/nfrMrOI8dH0jzy0DsEIq9S
         1zXnG+Ag0JrhXe2edF5vAdpicAB1A5vfqzViEjVtY88Fe18xKuAd00L6sRkEimiyVF
         y3gIsntuXI7AnDrI56IWFuAo/rXG3R6KGPCz/eT8=
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
Subject: [PATCH v2 2/3] ASoC: sh: Replace 'select' DMADEVICES 'with depends on'
Date:   Fri, 31 Jul 2020 18:24:32 +0300
Message-Id: <20200731152433.1297-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
References: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enabling a whole subsystem from a single driver 'select' is frowned
upon and won't be accepted in new drivers, that need to use 'depends on'
instead. Existing selection of DMADEVICES will then cause circular
dependencies. Replace them with a dependency.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 sound/soc/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index dc20f0f7080a..ef8a29b9f641 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -30,8 +30,8 @@ config SND_SOC_SH4_FSI
 config SND_SOC_SH4_SIU
 	tristate
 	depends on ARCH_SHMOBILE && HAVE_CLK
+	depends on DMADEVICES
 	select DMA_ENGINE
-	select DMADEVICES
 	select SH_DMAE
 	select FW_LOADER
 
-- 
Regards,

Laurent Pinchart

