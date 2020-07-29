Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3D2322B0
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jul 2020 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2Q3h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jul 2020 12:29:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33646 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgG2Q3h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jul 2020 12:29:37 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 36A1F9BF;
        Wed, 29 Jul 2020 18:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596040170;
        bh=KVM3J71ytG4aD9KCN56H16S59gG570Zxeid8qwLvghQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrorK1v4V2um5AwG6qXGjqgSJTmsDChti1+9TrpbakkUYEz1nxVf79tXOZqvwlTQB
         3hAW2qQLSrTilz+TsR0O4uJvJkUEG6ljvKqL7Rx38qKvg8VFW80d5TCF1oJ5pARQDf
         QnE56cnh+E8BvoR85+P0dyRUmyn6xXYzBMuUPcAc=
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
Subject: [PATCH 2/3] ASoC: sh: Replace 'select' DMAENGINES 'with depends on'
Date:   Wed, 29 Jul 2020 19:29:09 +0300
Message-Id: <20200729162910.13196-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
References: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enabling a whole subsystem from a single driver 'select' is frowned
upon and won't be accepted in new drivers, that need to use 'depends on'
instead. Existing selection of DMAENGINES will then cause circular
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

