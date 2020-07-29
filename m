Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E592322AF
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jul 2020 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2Q3g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jul 2020 12:29:36 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33632 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Q3g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jul 2020 12:29:36 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8EF72563;
        Wed, 29 Jul 2020 18:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596040169;
        bh=WPUP2yatqQeW6/0Ji0JPJMGTvsstJemKEg5UIsIJNrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJcZvSTEcF3frPa0CK+u48UdNqqDg4M0DKGr2W4KOhXKpG2da9LRFUOHFju4ZQouX
         Jo4/U4S6EncZtXK+eqgEhdN9xBCs2OYYKIaEyWWqXiVfbpAGRWXYlihxYDG0pqVT1F
         eHjTESLvi5P4cmw2ng6tuHlGSrEbEMbK4Ga7MSwU=
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
Subject: [PATCH 1/3] rapidio: Replace 'select' DMAENGINES 'with depends on'
Date:   Wed, 29 Jul 2020 19:29:08 +0300
Message-Id: <20200729162910.13196-2-laurent.pinchart@ideasonboard.com>
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
 drivers/rapidio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
index e4c422d806be..b9f8514909bf 100644
--- a/drivers/rapidio/Kconfig
+++ b/drivers/rapidio/Kconfig
@@ -37,7 +37,7 @@ config RAPIDIO_ENABLE_RX_TX_PORTS
 config RAPIDIO_DMA_ENGINE
 	bool "DMA Engine support for RapidIO"
 	depends on RAPIDIO
-	select DMADEVICES
+	depends on DMADEVICES
 	select DMA_ENGINE
 	help
 	  Say Y here if you want to use DMA Engine frameork for RapidIO data
-- 
Regards,

Laurent Pinchart

