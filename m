Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946FE5BB948
	for <lists+dmaengine@lfdr.de>; Sat, 17 Sep 2022 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiIQQNU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Sep 2022 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIQQNS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Sep 2022 12:13:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699282EF05;
        Sat, 17 Sep 2022 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663431197; x=1694967197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y6i0e5Zh0e9cio0oCMoT2cRF9JrNQyrR8iaI2N4widY=;
  b=M6yBq1PLcA3cSAyHzIX2xi+4mcsC+KrECHGy6Xq7u+A5HyXa3Q/+ssjy
   Q96T3GLo7wB3tQSr+jW19cy/oeirgeDKajvBdcFP5kbpjOa8grh0iz3AG
   FC0r5qxc46xuMiJKY06Vm3+ZEXAjhnEXRSKgl6BR6cD4IYsypzQqxjpO0
   RCjVJ+LD1OZ23MbowALD+N2vbiXrTuMpo4ZNRjsLJxDoeLoZbQUxPe1Av
   Kxw1PRnUBbPcnUvL6aktiaritAGm3Gcs00V3YZv1J6s/rUlfpMvB3xbwW
   iyg1GDPyGllNKZdbc0EHtDT3cv7lSAa35VdLAk/sSHVmrhyrUWX7OnmEd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="286206513"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="286206513"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 09:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="686472601"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2022 09:13:14 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 2/5] dmanegine: idxd: reformat opcap output to match bitmap_parse() input
Date:   Sat, 17 Sep 2022 09:12:19 -0700
Message-Id: <20220917161222.2835172-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220917161222.2835172-1-fenghua.yu@intel.com>
References: <20220917161222.2835172-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

To make input and output consistent and prepping for the per WQ operation
configuration support, change the output of opcap display to match the
input that is expected by bitmap_parse() helper function. The output will
be a bitmap with field width as the number of bits using the %*pb format
specifier for printk() family.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/idxd.h      |  2 ++
 drivers/dma/idxd/init.c      | 20 ++++++++++++++++++++
 drivers/dma/idxd/registers.h |  2 ++
 drivers/dma/idxd/sysfs.c     |  9 ++-------
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index cda856bfc22a..3ab406d74176 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -308,6 +308,8 @@ struct idxd_device {
 	struct work_struct work;
 
 	struct idxd_pmu *idxd_pmu;
+
+	unsigned long *opcap_bmap;
 };
 
 /* IDXD software descriptor */
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index aa3478257ddb..913a55ccb864 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -369,6 +369,19 @@ static void idxd_read_table_offsets(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD Perfmon Offset: %#x\n", idxd->perfmon_offset);
 }
 
+static void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count)
+{
+	int i, j, nr;
+
+	for (i = 0, nr = 0; i < count; i++) {
+		for (j = 0; j < BITS_PER_LONG_LONG; j++) {
+			if (val[i] & BIT(j))
+				set_bit(nr, bmap);
+			nr++;
+		}
+	}
+}
+
 static void idxd_read_caps(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -427,6 +440,7 @@ static void idxd_read_caps(struct idxd_device *idxd)
 				IDXD_OPCAP_OFFSET + i * sizeof(u64));
 		dev_dbg(dev, "opcap[%d]: %#llx\n", i, idxd->hw.opcap.bits[i]);
 	}
+	multi_u64_to_bmap(idxd->opcap_bmap, &idxd->hw.opcap.bits[0], 4);
 }
 
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
@@ -448,6 +462,12 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	if (idxd->id < 0)
 		return NULL;
 
+	idxd->opcap_bmap = bitmap_zalloc_node(IDXD_MAX_OPCAP_BITS, GFP_KERNEL, dev_to_node(dev));
+	if (!idxd->opcap_bmap) {
+		ida_free(&idxd_ida, idxd->id);
+		return NULL;
+	}
+
 	device_initialize(conf_dev);
 	conf_dev->parent = dev;
 	conf_dev->bus = &dsa_bus_type;
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 02449aa9c454..4c96ea85f843 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -90,6 +90,8 @@ struct opcap {
 	u64 bits[4];
 };
 
+#define IDXD_MAX_OPCAP_BITS		256U
+
 #define IDXD_OPCAP_OFFSET		0x40
 
 #define IDXD_TABLE_OFFSET		0x60
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index be9ff9d4cc4b..9998ab4b28c8 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1180,14 +1180,8 @@ static ssize_t op_cap_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
-	int i, rc = 0;
-
-	for (i = 0; i < 4; i++)
-		rc += sysfs_emit_at(buf, rc, "%#llx ", idxd->hw.opcap.bits[i]);
 
-	rc--;
-	rc += sysfs_emit_at(buf, rc, "\n");
-	return rc;
+	return sysfs_emit(buf, "%*pb\n", IDXD_MAX_OPCAP_BITS, idxd->opcap_bmap);
 }
 static DEVICE_ATTR_RO(op_cap);
 
@@ -1411,6 +1405,7 @@ static void idxd_conf_device_release(struct device *dev)
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
 	ida_free(&idxd_ida, idxd->id);
+	bitmap_free(idxd->opcap_bmap);
 	kfree(idxd);
 }
 
-- 
2.32.0

