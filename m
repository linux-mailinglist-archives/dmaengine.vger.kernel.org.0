Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71F140DE3
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2020 16:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAQP3l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jan 2020 10:29:41 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:42196 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAQP3l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jan 2020 10:29:41 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id rTVe210095USYZQ01TVe9c; Fri, 17 Jan 2020 16:29:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1isTZ3-0002FB-Ux; Fri, 17 Jan 2020 16:29:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1isTZ3-00087d-Tp; Fri, 17 Jan 2020 16:29:37 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] dmaengine: Remove dma_device_satisfies_mask() wrapper
Date:   Fri, 17 Jan 2020 16:29:31 +0100
Message-Id: <20200117152933.31175-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117152933.31175-1-geert+renesas@glider.be>
References: <20200117152933.31175-1-geert+renesas@glider.be>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit aa1e6f1a385eb2b0 ("dmaengine: kill struct dma_client and
supporting infrastructure") removed the last user of the
dma_device_satisfies_mask() wrapper.

Remove the wrapper, and rename __dma_device_satisfies_mask() to
dma_device_satisfies_mask(), to get rid of one more function starting
with a double underscore.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/dmaengine.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 4ac77456e8300828..56a8420c388679d3 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -308,11 +308,8 @@ static void dma_channel_rebalance(void)
 		}
 }
 
-#define dma_device_satisfies_mask(device, mask) \
-	__dma_device_satisfies_mask((device), &(mask))
-static int
-__dma_device_satisfies_mask(struct dma_device *device,
-			    const dma_cap_mask_t *want)
+static int dma_device_satisfies_mask(struct dma_device *device,
+				     const dma_cap_mask_t *want)
 {
 	dma_cap_mask_t has;
 
@@ -531,7 +528,7 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
 {
 	struct dma_chan *chan;
 
-	if (mask && !__dma_device_satisfies_mask(dev, mask)) {
+	if (mask && !dma_device_satisfies_mask(dev, mask)) {
 		dev_dbg(dev->dev, "%s: wrong capabilities\n", __func__);
 		return NULL;
 	}
-- 
2.17.1

