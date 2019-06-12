Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503CA425A8
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfFLM03 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 08:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfFLM0Z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 08:26:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D69208C4;
        Wed, 12 Jun 2019 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560342384;
        bh=pwRn6AXU7SWO1tJhlUuy4tZltJqtkI4L1pFotOCpAEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+/Xsan74f4XdgCu9VaU2vkspMbyBS8QvScp8jEVLqbpTrRML8fX+438U2RZ8BwdX
         sfckT6icVtnTgxnNGd4gf70cQmwQk64okzM1M6Q5IrWO56V0wCZ47SifU7dJ+0ucAA
         sX3IAgUh1x3CcIljR90kH0zUlAqcdikJl9zyx+aE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dma: bcm-sba-raid: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:25:53 +0200
Message-Id: <20190612122557.24158-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612122557.24158-1-gregkh@linuxfoundation.org>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, because there is no need to save the file dentry, remove the
variable that was saving it as it was never even being used once set.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/bcm-sba-raid.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index fa81d0177765..275e90fa829d 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -164,7 +164,6 @@ struct sba_device {
 	struct list_head reqs_free_list;
 	/* DebugFS directory entries */
 	struct dentry *root;
-	struct dentry *stats;
 };
 
 /* ====== Command helper routines ===== */
@@ -1716,17 +1715,11 @@ static int sba_probe(struct platform_device *pdev)
 
 	/* Create debugfs root entry */
 	sba->root = debugfs_create_dir(dev_name(sba->dev), NULL);
-	if (IS_ERR_OR_NULL(sba->root)) {
-		dev_err(sba->dev, "failed to create debugfs root entry\n");
-		sba->root = NULL;
-		goto skip_debugfs;
-	}
 
 	/* Create debugfs stats entry */
-	sba->stats = debugfs_create_devm_seqfile(sba->dev, "stats", sba->root,
-						 sba_debugfs_stats_show);
-	if (IS_ERR_OR_NULL(sba->stats))
-		dev_err(sba->dev, "failed to create debugfs stats file\n");
+	debugfs_create_devm_seqfile(sba->dev, "stats", sba->root,
+				    sba_debugfs_stats_show);
+
 skip_debugfs:
 
 	/* Register DMA device with Linux async framework */
-- 
2.22.0

