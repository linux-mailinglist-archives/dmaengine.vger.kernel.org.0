Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9850129CB4B
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 22:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374103AbgJ0Veg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 17:34:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:52167 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374098AbgJ0Veg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 17:34:36 -0400
IronPort-SDR: emhlWYDnuWl2rfMjdiznR/vWnt2BYyOop/3Fm41RmKykx39SfKJfadG8Yv1ZNPHex7hF+qDE6Q
 kqI6cWYZS3eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="165575900"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="165575900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 14:34:10 -0700
IronPort-SDR: zP0Vav1M9BnKRJIXbdjSPsF4c0CsaL6Wkdp8iPkdLpf18/HtzzYtWdXdpOcBsnZ1Zt/PHkF8xR
 VHYyh0fiTBRQ==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="535963440"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 14:34:10 -0700
Subject: [PATCH] dmaengine: idxd: fix wq config registers offset programming
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 27 Oct 2020 14:34:09 -0700
Message-ID: <160383444959.48058.14249265538404901781.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DSA spec v1.1 [1] updated to include a stride size register for WQ
configuration that will specify how much space is reserved for the WQ
configuration register set. This change is expected to be in the final
gen1 DSA hardware. Fix the driver to use WQCFG_OFFSET() for all WQ
offset calculation and fixup WQCFG_OFFSET() to use the new calculated
wq size.

[1]: https://software.intel.com/content/www/us/en/develop/download/intel-data-streaming-accelerator-preliminary-architecture-specification.html

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c    |   29 ++++++++++++++---------------
 drivers/dma/idxd/idxd.h      |    3 ++-
 drivers/dma/idxd/init.c      |    5 +++++
 drivers/dma/idxd/registers.h |   23 ++++++++++++++++++++++-
 4 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 200b9109cacf..506ac85c4a7f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -295,7 +295,7 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	int i, wq_offset;
 
 	lockdep_assert_held(&idxd->dev_lock);
-	memset(&wq->wqcfg, 0, sizeof(wq->wqcfg));
+	memset(wq->wqcfg, 0, idxd->wqcfg_size);
 	wq->type = IDXD_WQT_NONE;
 	wq->size = 0;
 	wq->group = NULL;
@@ -304,8 +304,8 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
 	memset(wq->name, 0, WQ_NAME_SIZE);
 
-	for (i = 0; i < 8; i++) {
-		wq_offset = idxd->wqcfg_offset + wq->id * 32 + i * sizeof(u32);
+	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
+		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
 		iowrite32(0, idxd->reg_base + wq_offset);
 		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
 			wq->id, i, wq_offset,
@@ -539,10 +539,10 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	if (!wq->group)
 		return 0;
 
-	memset(&wq->wqcfg, 0, sizeof(union wqcfg));
+	memset(wq->wqcfg, 0, idxd->wqcfg_size);
 
 	/* byte 0-3 */
-	wq->wqcfg.wq_size = wq->size;
+	wq->wqcfg->wq_size = wq->size;
 
 	if (wq->size == 0) {
 		dev_warn(dev, "Incorrect work queue size: 0\n");
@@ -550,22 +550,21 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	}
 
 	/* bytes 4-7 */
-	wq->wqcfg.wq_thresh = wq->threshold;
+	wq->wqcfg->wq_thresh = wq->threshold;
 
 	/* byte 8-11 */
-	wq->wqcfg.priv = !!(wq->type == IDXD_WQT_KERNEL);
-	wq->wqcfg.mode = 1;
-
-	wq->wqcfg.priority = wq->priority;
+	wq->wqcfg->priv = !!(wq->type == IDXD_WQT_KERNEL);
+	wq->wqcfg->mode = 1;
+	wq->wqcfg->priority = wq->priority;
 
 	/* bytes 12-15 */
-	wq->wqcfg.max_xfer_shift = ilog2(wq->max_xfer_bytes);
-	wq->wqcfg.max_batch_shift = ilog2(wq->max_batch_size);
+	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
+	wq->wqcfg->max_batch_shift = ilog2(wq->max_batch_size);
 
 	dev_dbg(dev, "WQ %d CFGs\n", wq->id);
-	for (i = 0; i < 8; i++) {
-		wq_offset = idxd->wqcfg_offset + wq->id * 32 + i * sizeof(u32);
-		iowrite32(wq->wqcfg.bits[i], idxd->reg_base + wq_offset);
+	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
+		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
+		iowrite32(wq->wqcfg->bits[i], idxd->reg_base + wq_offset);
 		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
 			wq->id, i, wq_offset,
 			ioread32(idxd->reg_base + wq_offset));
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c64df197e724..d48f193daacc 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -103,7 +103,7 @@ struct idxd_wq {
 	u32 priority;
 	enum idxd_wq_state state;
 	unsigned long flags;
-	union wqcfg wqcfg;
+	union wqcfg *wqcfg;
 	u32 vec_ptr;		/* interrupt steering */
 	struct dsa_hw_desc **hw_descs;
 	int num_descs;
@@ -183,6 +183,7 @@ struct idxd_device {
 	int max_wq_size;
 	int token_limit;
 	int nr_tokens;		/* non-reserved tokens */
+	unsigned int wqcfg_size;
 
 	union sw_err_reg sw_err;
 	wait_queue_head_t cmd_waitq;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 11e5ce168177..0a4432b063b5 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -178,6 +178,9 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 		wq->idxd_cdev.minor = -1;
 		wq->max_xfer_bytes = idxd->max_xfer_bytes;
 		wq->max_batch_size = idxd->max_batch_size;
+		wq->wqcfg = devm_kzalloc(dev, idxd->wqcfg_size, GFP_KERNEL);
+		if (!wq->wqcfg)
+			return -ENOMEM;
 	}
 
 	for (i = 0; i < idxd->max_engines; i++) {
@@ -251,6 +254,8 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	dev_dbg(dev, "total workqueue size: %u\n", idxd->max_wq_size);
 	idxd->max_wqs = idxd->hw.wq_cap.num_wqs;
 	dev_dbg(dev, "max workqueues: %u\n", idxd->max_wqs);
+	idxd->wqcfg_size = 1 << (idxd->hw.wq_cap.wqcfg_size + IDXD_WQCFG_MIN);
+	dev_dbg(dev, "wqcfg size: %u\n", idxd->wqcfg_size);
 
 	/* reading operation capabilities */
 	for (i = 0; i < 4; i++) {
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index a39e7ae6b3d9..aef5a902829e 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -43,7 +43,8 @@ union wq_cap_reg {
 	struct {
 		u64 total_wq_size:16;
 		u64 num_wqs:8;
-		u64 rsvd:24;
+		u64 wqcfg_size:4;
+		u64 rsvd:20;
 		u64 shared_mode:1;
 		u64 dedicated_mode:1;
 		u64 rsvd2:1;
@@ -55,6 +56,7 @@ union wq_cap_reg {
 	u64 bits;
 } __packed;
 #define IDXD_WQCAP_OFFSET		0x20
+#define IDXD_WQCFG_MIN			5
 
 union group_cap_reg {
 	struct {
@@ -333,4 +335,23 @@ union wqcfg {
 	};
 	u32 bits[8];
 } __packed;
+
+/*
+ * This macro calculates the offset into the WQCFG register
+ * idxd - struct idxd *
+ * n - wq id
+ * ofs - the index of the 32b dword for the config register
+ *
+ * The WQCFG register block is divided into groups per each wq. The n index
+ * allows us to move to the register group that's for that particular wq.
+ * Each register is 32bits. The ofs gives us the number of register to access.
+ */
+#define WQCFG_OFFSET(_idxd_dev, n, ofs) \
+({\
+	typeof(_idxd_dev) __idxd_dev = (_idxd_dev);	\
+	(__idxd_dev)->wqcfg_offset + (n) * (__idxd_dev)->wqcfg_size + sizeof(u32) * (ofs);	\
+})
+
+#define WQCFG_STRIDES(_idxd_dev) ((_idxd_dev)->wqcfg_size / sizeof(u32))
+
 #endif


