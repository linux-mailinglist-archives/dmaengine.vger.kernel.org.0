Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D112A0A67
	for <lists+dmaengine@lfdr.de>; Fri, 30 Oct 2020 16:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgJ3Pv7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Oct 2020 11:51:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:4119 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgJ3Pv7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 30 Oct 2020 11:51:59 -0400
IronPort-SDR: 5vxo661pAmG7Jdm60HrskR9d9W6sS8T0V8uR6suyQThdesHyX1/ck5i7d+Sgh/FL/YVbqMOufE
 CHvOcZlpfv3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="253333461"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="253333461"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 08:51:58 -0700
IronPort-SDR: Jzw+A1W1Zzrc6wOWvgGcn5r4e/XhWGcOXRfdENwgBByg63oZEDLLH/sMCF98Liv96pToqP1S8M
 UY1V3kxFl7ew==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="527150450"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 08:51:58 -0700
Subject: [PATCH] dmaengine: idxd: define table offset multiplier
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 30 Oct 2020 08:51:56 -0700
Message-ID: <160407311690.839435.6941865731867828234.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert table offset multiplier magic number to a define.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c      |   17 +++++++----------
 drivers/dma/idxd/registers.h |    2 ++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index c24106efc16e..45b0eac640c3 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -214,17 +214,14 @@ static void idxd_read_table_offsets(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 
 	offsets.bits[0] = ioread64(idxd->reg_base + IDXD_TABLE_OFFSET);
-	offsets.bits[1] = ioread64(idxd->reg_base + IDXD_TABLE_OFFSET
-			+ sizeof(u64));
-	idxd->grpcfg_offset = offsets.grpcfg * 0x100;
+	offsets.bits[1] = ioread64(idxd->reg_base + IDXD_TABLE_OFFSET + sizeof(u64));
+	idxd->grpcfg_offset = offsets.grpcfg * IDXD_TABLE_MULT;
 	dev_dbg(dev, "IDXD Group Config Offset: %#x\n", idxd->grpcfg_offset);
-	idxd->wqcfg_offset = offsets.wqcfg * 0x100;
-	dev_dbg(dev, "IDXD Work Queue Config Offset: %#x\n",
-		idxd->wqcfg_offset);
-	idxd->msix_perm_offset = offsets.msix_perm * 0x100;
-	dev_dbg(dev, "IDXD MSIX Permission Offset: %#x\n",
-		idxd->msix_perm_offset);
-	idxd->perfmon_offset = offsets.perfmon * 0x100;
+	idxd->wqcfg_offset = offsets.wqcfg * IDXD_TABLE_MULT;
+	dev_dbg(dev, "IDXD Work Queue Config Offset: %#x\n", idxd->wqcfg_offset);
+	idxd->msix_perm_offset = offsets.msix_perm * IDXD_TABLE_MULT;
+	dev_dbg(dev, "IDXD MSIX Permission Offset: %#x\n", idxd->msix_perm_offset);
+	idxd->perfmon_offset = offsets.perfmon * IDXD_TABLE_MULT;
 	dev_dbg(dev, "IDXD Perfmon Offset: %#x\n", idxd->perfmon_offset);
 }
 
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 6f2f736097e5..d29a58ee2651 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -102,6 +102,8 @@ union offsets_reg {
 	u64 bits[2];
 } __packed;
 
+#define IDXD_TABLE_MULT			0x100
+
 #define IDXD_GENCFG_OFFSET		0x80
 union gencfg_reg {
 	struct {


