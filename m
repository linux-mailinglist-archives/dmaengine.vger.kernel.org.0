Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2967E425A0
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfFLM0Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 08:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfFLM0Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 08:26:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B8C208C4;
        Wed, 12 Jun 2019 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560342375;
        bh=IJFJ3UvGATTgDCH/PLIaXtkwkRHcWi82Y/Juds58mrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyj6z+t1W8UH9uf7L8D7BUuk2eFG9Ja5ol0ko59+6SCHwnjS640uK8qP25NUZK2F9
         aDU7vMn0BCCmQScLWEEK5J/BDLL+A7Ip2NNNZ+u8G+UuHOQMiX6vx2bEweBgy3ofBd
         ++jtrkscdLgeMd5UVPal2D8TRNLGBhBo8dLo4Z00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] dma: pxa_dma: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:25:55 +0200
Message-Id: <20190612122557.24158-4-gregkh@linuxfoundation.org>
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

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/pxa_dma.c | 56 +++++++++----------------------------------
 1 file changed, 11 insertions(+), 45 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index b429642f3e7a..0f698f49ee26 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -132,7 +132,6 @@ struct pxad_device {
 	spinlock_t			phy_lock;	/* Phy association */
 #ifdef CONFIG_DEBUG_FS
 	struct dentry			*dbgfs_root;
-	struct dentry			*dbgfs_state;
 	struct dentry			**dbgfs_chan;
 #endif
 };
@@ -326,31 +325,18 @@ static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
 					     int ch, struct dentry *chandir)
 {
 	char chan_name[11];
-	struct dentry *chan, *chan_state = NULL, *chan_descr = NULL;
-	struct dentry *chan_reqs = NULL;
+	struct dentry *chan;
 	void *dt;
 
 	scnprintf(chan_name, sizeof(chan_name), "%d", ch);
 	chan = debugfs_create_dir(chan_name, chandir);
 	dt = (void *)&pdev->phys[ch];
 
-	if (chan)
-		chan_state = debugfs_create_file("state", 0400, chan, dt,
-						 &chan_state_fops);
-	if (chan_state)
-		chan_descr = debugfs_create_file("descriptors", 0400, chan, dt,
-						 &descriptors_fops);
-	if (chan_descr)
-		chan_reqs = debugfs_create_file("requesters", 0400, chan, dt,
-						&requester_chan_fops);
-	if (!chan_reqs)
-		goto err_state;
+	debugfs_create_file("state", 0400, chan, dt, &chan_state_fops);
+	debugfs_create_file("descriptors", 0400, chan, dt, &descriptors_fops);
+	debugfs_create_file("requesters", 0400, chan, dt, &requester_chan_fops);
 
 	return chan;
-
-err_state:
-	debugfs_remove_recursive(chan);
-	return NULL;
 }
 
 static void pxad_init_debugfs(struct pxad_device *pdev)
@@ -358,40 +344,20 @@ static void pxad_init_debugfs(struct pxad_device *pdev)
 	int i;
 	struct dentry *chandir;
 
-	pdev->dbgfs_root = debugfs_create_dir(dev_name(pdev->slave.dev), NULL);
-	if (IS_ERR(pdev->dbgfs_root) || !pdev->dbgfs_root)
-		goto err_root;
-
-	pdev->dbgfs_state = debugfs_create_file("state", 0400, pdev->dbgfs_root,
-						pdev, &state_fops);
-	if (!pdev->dbgfs_state)
-		goto err_state;
-
 	pdev->dbgfs_chan =
-		kmalloc_array(pdev->nr_chans, sizeof(*pdev->dbgfs_state),
+		kmalloc_array(pdev->nr_chans, sizeof(struct dentry *),
 			      GFP_KERNEL);
 	if (!pdev->dbgfs_chan)
-		goto err_alloc;
+		return;
+
+	pdev->dbgfs_root = debugfs_create_dir(dev_name(pdev->slave.dev), NULL);
+
+	debugfs_create_file("state", 0400, pdev->dbgfs_root, pdev, &state_fops);
 
 	chandir = debugfs_create_dir("channels", pdev->dbgfs_root);
-	if (!chandir)
-		goto err_chandir;
 
-	for (i = 0; i < pdev->nr_chans; i++) {
+	for (i = 0; i < pdev->nr_chans; i++)
 		pdev->dbgfs_chan[i] = pxad_dbg_alloc_chan(pdev, i, chandir);
-		if (!pdev->dbgfs_chan[i])
-			goto err_chans;
-	}
-
-	return;
-err_chans:
-err_chandir:
-	kfree(pdev->dbgfs_chan);
-err_alloc:
-err_state:
-	debugfs_remove_recursive(pdev->dbgfs_root);
-err_root:
-	pr_err("pxad: debugfs is not available\n");
 }
 
 static void pxad_cleanup_debugfs(struct pxad_device *pdev)
-- 
2.22.0

