Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9007E2A0A43
	for <lists+dmaengine@lfdr.de>; Fri, 30 Oct 2020 16:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgJ3PtJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Oct 2020 11:49:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:53025 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgJ3PtI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:08 -0400
IronPort-SDR: DzgPRznBFrkw8TiPBMYo+tbNCIm/0RinWCZWLwSXVsEz1cnCr0r4L9fabyT2nELaeqvvKomO1d
 tk3JrDjY5oXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="155600055"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="155600055"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 08:49:07 -0700
IronPort-SDR: FsUT04zulXywCZ2g8JjlUsRTJr0KnxbjQvZTvO1EtZ2OFywKQaRDRGTFoBPFrXF6q88pU/q4bB
 zNiBd3kYE3Yg==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="537107551"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 08:49:07 -0700
Subject: [PATCH] dmaengine: idxd: Update calculation of group offset to be
 more readable
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 30 Oct 2020 08:49:06 -0700
Message-ID: <160407294683.839093.10740868559754142070.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Create helper macros to make group offset calculation more readable.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c    |   12 +++++-------
 drivers/dma/idxd/registers.h |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 2f09eb89a906..d6f551dcbcb6 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -543,24 +543,22 @@ static void idxd_group_config_write(struct idxd_group *group)
 	dev_dbg(dev, "Writing group %d cfg registers\n", group->id);
 
 	/* setup GRPWQCFG */
-	for (i = 0; i < 4; i++) {
-		grpcfg_offset = idxd->grpcfg_offset +
-			group->id * 64 + i * sizeof(u64);
-		iowrite64(group->grpcfg.wqs[i],
-			  idxd->reg_base + grpcfg_offset);
+	for (i = 0; i < GRPWQCFG_STRIDES; i++) {
+		grpcfg_offset = GRPWQCFG_OFFSET(idxd, group->id, i);
+		iowrite64(group->grpcfg.wqs[i], idxd->reg_base + grpcfg_offset);
 		dev_dbg(dev, "GRPCFG wq[%d:%d: %#x]: %#llx\n",
 			group->id, i, grpcfg_offset,
 			ioread64(idxd->reg_base + grpcfg_offset));
 	}
 
 	/* setup GRPENGCFG */
-	grpcfg_offset = idxd->grpcfg_offset + group->id * 64 + 32;
+	grpcfg_offset = GRPENGCFG_OFFSET(idxd, group->id);
 	iowrite64(group->grpcfg.engines, idxd->reg_base + grpcfg_offset);
 	dev_dbg(dev, "GRPCFG engs[%d: %#x]: %#llx\n", group->id,
 		grpcfg_offset, ioread64(idxd->reg_base + grpcfg_offset));
 
 	/* setup GRPFLAGS */
-	grpcfg_offset = idxd->grpcfg_offset + group->id * 64 + 40;
+	grpcfg_offset = GRPFLGCFG_OFFSET(idxd, group->id);
 	iowrite32(group->grpcfg.flags.bits, idxd->reg_base + grpcfg_offset);
 	dev_dbg(dev, "GRPFLAGS flags[%d: %#x]: %#x\n",
 		group->id, grpcfg_offset,
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 1041c2779f9b..6f2f736097e5 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -356,4 +356,22 @@ union wqcfg {
 
 #define WQCFG_STRIDES(_idxd_dev) ((_idxd_dev)->wqcfg_size / sizeof(u32))
 
+#define GRPCFG_SIZE		64
+#define GRPWQCFG_STRIDES	4
+
+/*
+ * This macro calculates the offset into the GRPCFG register
+ * idxd - struct idxd *
+ * n - wq id
+ * ofs - the index of the 32b dword for the config register
+ *
+ * The WQCFG register block is divided into groups per each wq. The n index
+ * allows us to move to the register group that's for that particular wq.
+ * Each register is 32bits. The ofs gives us the number of register to access.
+ */
+#define GRPWQCFG_OFFSET(idxd_dev, n, ofs) ((idxd_dev)->grpcfg_offset +\
+					   (n) * GRPCFG_SIZE + sizeof(u64) * (ofs))
+#define GRPENGCFG_OFFSET(idxd_dev, n) ((idxd_dev)->grpcfg_offset + (n) * GRPCFG_SIZE + 32)
+#define GRPFLGCFG_OFFSET(idxd_dev, n) ((idxd_dev)->grpcfg_offset + (n) * GRPCFG_SIZE + 40)
+
 #endif


