Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06A2D879C
	for <lists+dmaengine@lfdr.de>; Sat, 12 Dec 2020 17:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393719AbgLLQIP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Dec 2020 11:08:15 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:35625 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgLLQIA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 12 Dec 2020 11:08:00 -0500
Received: from localhost.localdomain ([93.22.36.60])
        by mwinf5d29 with ME
        id 3U6E240181HrHD103U6Efl; Sat, 12 Dec 2020 17:06:16 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Dec 2020 17:06:16 +0100
X-ME-IP: 93.22.36.60
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     leoyang.li@nxp.com, zw@zh-kernel.org, vkoul@kernel.org,
        dan.j.williams@intel.com, iws@ovro.caltech.edu
Cc:     linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] dmaengine: fsldma: Fix a resource leak in an error handling path of the probe function
Date:   Sat, 12 Dec 2020 17:06:14 +0100
Message-Id: <20201212160614.92576-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In case of error, the previous 'fsl_dma_chan_probe()' calls must be undone
by some 'fsl_dma_chan_remove()', as already done in the remove function.

It was added in the remove function in commit 77cd62e8082b ("fsldma: allow
Freescale Elo DMA driver to be compiled as a module")

Fixes: d3f620b2c4fe ("fsldma: simplify IRQ probing and handling")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Patch provided as-is.
I don't have the configuration to compile test this patch
---
 drivers/dma/fsldma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 554f70a0c18c..f8459cc5315d 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1214,6 +1214,7 @@ static int fsldma_of_probe(struct platform_device *op)
 {
 	struct fsldma_device *fdev;
 	struct device_node *child;
+	unsigned int i;
 	int err;
 
 	fdev = kzalloc(sizeof(*fdev), GFP_KERNEL);
@@ -1292,6 +1293,10 @@ static int fsldma_of_probe(struct platform_device *op)
 	return 0;
 
 out_free_fdev:
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
+		if (fdev->chan[i])
+			fsl_dma_chan_remove(fdev->chan[i]);
+	}
 	irq_dispose_mapping(fdev->irq);
 	iounmap(fdev->regs);
 out_free:
-- 
2.27.0

