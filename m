Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB317C034
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2020 15:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgCFO2u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Mar 2020 09:28:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46490 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgCFO2u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Mar 2020 09:28:50 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 026ESjnN099775;
        Fri, 6 Mar 2020 08:28:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583504925;
        bh=Db0gvxjEjJlJTJS1yJjHXtnpft56UAncNxZIQb/GHmc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PDr1cJnCWm0n4O/s7dV6uOWi2nsDzTL7cWnA6ngGGSe3dOeNF87FgBGn/yLdPQ1Ip
         9wQXPNq6t3HelOI9iVd6/oBx0Tk6BE0SHpRO35Q7Za+rXP+eH5vbizQZZcDkb7Io4n
         gad2TrFWhSXwwpKYioT16VJyrahRklOKQ20Ku/5M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 026ESjiH106892
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Mar 2020 08:28:45 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Mar
 2020 08:28:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Mar 2020 08:28:45 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 026ESbUb115246;
        Fri, 6 Mar 2020 08:28:43 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH v5 3/3] dmaengine: Create debug directories for DMA devices
Date:   Fri, 6 Mar 2020 16:28:39 +0200
Message-ID: <20200306142839.17910-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306142839.17910-1-peter.ujfalusi@ti.com>
References: <20200306142839.17910-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Create a placeholder directory for each registered DMA device.

DMA drivers can use the dmaengine_get_debugfs_root() call to get their
debugfs root and can populate with custom files to aim debugging.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c   | 28 +++++++++++++++++++++++++++-
 drivers/dma/dmaengine.h   | 16 ++++++++++++++++
 include/linux/dmaengine.h |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 509abc8e8378..5a442752e07d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -62,6 +62,22 @@ static long dmaengine_ref_count;
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
+static struct dentry *rootdir;
+
+static void dmaengine_debug_register(struct dma_device *dma_dev)
+{
+	dma_dev->dbg_dev_root = debugfs_create_dir(dev_name(dma_dev->dev),
+						   rootdir);
+	if (IS_ERR(dma_dev->dbg_dev_root))
+		dma_dev->dbg_dev_root = NULL;
+}
+
+static void dmaengine_debug_unregister(struct dma_device *dma_dev)
+{
+	debugfs_remove_recursive(dma_dev->dbg_dev_root);
+	dma_dev->dbg_dev_root = NULL;
+}
+
 static void dmaengine_dbg_summary_show(struct seq_file *s,
 				       struct dma_device *dma_dev)
 {
@@ -107,7 +123,7 @@ DEFINE_SHOW_ATTRIBUTE(dmaengine_summary);
 
 static void __init dmaengine_debugfs_init(void)
 {
-	struct dentry *rootdir = debugfs_create_dir("dmaengine", NULL);
+	rootdir = debugfs_create_dir("dmaengine", NULL);
 
 	/* /sys/kernel/debug/dmaengine/summary */
 	debugfs_create_file("summary", 0444, rootdir, NULL,
@@ -115,6 +131,12 @@ static void __init dmaengine_debugfs_init(void)
 }
 #else
 static inline void dmaengine_debugfs_init(void) { }
+static inline int dmaengine_debug_register(struct dma_device *dma_dev)
+{
+	return 0;
+}
+
+static inline void dmaengine_debug_unregister(struct dma_device *dma_dev) { }
 #endif	/* DEBUG_FS */
 
 /* --- sysfs implementation --- */
@@ -1265,6 +1287,8 @@ int dma_async_device_register(struct dma_device *device)
 	dma_channel_rebalance();
 	mutex_unlock(&dma_list_mutex);
 
+	dmaengine_debug_register(device);
+
 	return 0;
 
 err_out:
@@ -1298,6 +1322,8 @@ void dma_async_device_unregister(struct dma_device *device)
 {
 	struct dma_chan *chan, *n;
 
+	dmaengine_debug_unregister(device);
+
 	list_for_each_entry_safe(chan, n, &device->channels, device_node)
 		__dma_async_device_channel_unregister(device, chan);
 
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index e8a320c9e57c..1bfbd64b1371 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -182,4 +182,20 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static inline struct dentry *
+dmaengine_get_debugfs_root(struct dma_device *dma_dev) {
+	return dma_dev->dbg_dev_root;
+}
+#else
+struct dentry;
+static inline struct dentry *
+dmaengine_get_debugfs_root(struct dma_device *dma_dev)
+{
+	return NULL;
+}
+#endif /* CONFIG_DEBUG_FS */
+
 #endif
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 72920b5cf2d7..21065c04c4ac 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -902,6 +902,7 @@ struct dma_device {
 	/* debugfs support */
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_summary_show)(struct seq_file *s, struct dma_device *dev);
+	struct dentry *dbg_dev_root;
 #endif
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

