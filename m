Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0DA38911
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2019 13:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfFGLam (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jun 2019 07:30:42 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:50502 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfFGLam (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jun 2019 07:30:42 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id MnWg2000L3XaVaC06nWgSq; Fri, 07 Jun 2019 13:30:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD4y-0004FR-PI; Fri, 07 Jun 2019 13:30:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD4y-0003na-Mv; Fri, 07 Jun 2019 13:30:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] dmaengine: Grammar s/the its/its/, s/need/needs/
Date:   Fri,  7 Jun 2019 13:30:39 +0200
Message-Id: <20190607113039.14560-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/dmaengine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c92260b1b8972346..03ac4b96117cd8db 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -61,7 +61,7 @@ static long dmaengine_ref_count;
 /* --- sysfs implementation --- */
 
 /**
- * dev_to_dma_chan - convert a device pointer to the its sysfs container object
+ * dev_to_dma_chan - convert a device pointer to its sysfs container object
  * @dev - device node
  *
  * Must be called under dma_list_mutex
@@ -705,7 +705,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 		chan = acpi_dma_request_slave_chan_by_name(dev, name);
 
 	if (chan) {
-		/* Valid channel found or requester need to be deferred */
+		/* Valid channel found or requester needs to be deferred */
 		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
 			return chan;
 	}
-- 
2.17.1

