Return-Path: <dmaengine+bounces-5453-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386DAD92BD
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 18:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ECA189EA90
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE89E211476;
	Fri, 13 Jun 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CstMtbds"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205720F079;
	Fri, 13 Jun 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749831568; cv=none; b=NXVFjWoCbLR8p/wXyJWZNE1cvgo09aq8tiZbsRDFK4KOVdyWiLnydaAxl7Wy108sIKiUoqpZ4StGArKJ/lDgWLVMLMQ1R0e84FwLaAlq6gKeaP6AQ0qDmVqSgnIh7G97vYGnowW3Q9VhJExObaEtWgqENOHrJR1EVsZ/SjbrR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749831568; c=relaxed/simple;
	bh=lA01gUMjFLrT+EPuMprAzxxtzaJPHgIPj1gJ4a71blo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJdshqgiE96cE4Ytp25j1NirSs752suwZB/fMtohuN+gQs5Dn33WWV8fT9JaAuoOQBo/c1sKh/e8opVhWC22KpYtjBJmErulQD9na+14wtZ9QnEGPNqy3/YZ41M/iXE0J/qOfmiQ3mEkXZP2aEiYKlk3cX75MxtZWCO9eM2Djyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CstMtbds; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749831568; x=1781367568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lA01gUMjFLrT+EPuMprAzxxtzaJPHgIPj1gJ4a71blo=;
  b=CstMtbdsG0A0dLWaoJY5nhfBGteltzVbpC0hP1t5RxX9T5LVsnpqXjYi
   I2lpoHmBT4PFlLfSTf/XEOoe2ncK1Rd73xpOC6kBBjO+sH0BR89hSQfaS
   o+3raXg/96Zd93YKFWnbsVnmL26NTZ7ZXg7GOeIqIFntOzSBgjqY7WzHZ
   LpGF3dz8JR5NbYSBDpcbc9jQGlBxrw7ehRNL7J3ZcZvvpbfgFXc0vSHMX
   7p6Aus/y5waglkoCWKSd6wxgzKL5P+31Eqbo8jmZj3J2ZY74EbHCkdClT
   xuxmZCTPhmFLXGNrO9SBdtjjvZq+Rgj2nHuKkz2IY2ZN6Iz0spmws2xk9
   A==;
X-CSE-ConnectionGUID: 1ctB+sFLRs2YjMG2amNzng==
X-CSE-MsgGUID: Xrp4FCpdR0OMoZeoWhOcwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52149244"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="52149244"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:19:28 -0700
X-CSE-ConnectionGUID: mAVOzOJMSTyScXj0PaRaYg==
X-CSE-MsgGUID: f0LK/4uLQiWYbgvVIfdrUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="147859291"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by orviesa009.jf.intel.com with ESMTP; 13 Jun 2025 09:19:24 -0700
From: Yi Sun <yi.sun@intel.com>
To: dave.jiang@intel.com,
	vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com,
	gordon.jin@intel.com,
	fenghuay@nvidia.com,
	anil.s.keshavamurthy@intel.com,
	philip.lantz@intel.com
Subject: [PATCH 2/2] dmaengine: idxd: Add Max SGL Size Support for DSA3.0
Date: Sat, 14 Jun 2025 00:18:34 +0800
Message-ID: <20250613161834.2912353-3-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613161834.2912353-1-yi.sun@intel.com>
References: <20250613161834.2912353-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain DSA 3.0 opcodes, such as Gather copy and Gather reduce requires max
SGL configured for workqueues prior to support these opcodes.

Configure the maximum scatter-gather list (SGL) size for workqueues during
setup on the supported HW. Application can then properly handle the SGL
size without explicitly setting it.

Signed-off-by: Yi Sun <yi.sun@intel.com>
Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5cf419fe6b46..1c10b030bea7 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -375,6 +375,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	memset(wq->name, 0, WQ_NAME_SIZE);
 	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
 	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
+	idxd_wq_set_init_max_sgl_size(idxd, wq);
 	if (wq->opcap_bmap)
 		bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 }
@@ -974,6 +975,8 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	/* bytes 12-15 */
 	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
 	idxd_wqcfg_set_max_batch_shift(idxd->data->type, wq->wqcfg, ilog2(wq->max_batch_size));
+	if (idxd_sgl_supported(idxd))
+		wq->wqcfg->max_sgl_shift = ilog2(wq->max_sgl_size);
 
 	/* bytes 32-63 */
 	if (idxd->hw.wq_cap.op_config && wq->opcap_bmap) {
@@ -1152,6 +1155,8 @@ static int idxd_wq_load_config(struct idxd_wq *wq)
 
 	wq->max_xfer_bytes = 1ULL << wq->wqcfg->max_xfer_shift;
 	idxd_wq_set_max_batch_size(idxd->data->type, wq, 1U << wq->wqcfg->max_batch_shift);
+	if (idxd_sgl_supported(idxd))
+		wq->max_sgl_size = 1U << wq->wqcfg->max_sgl_shift;
 
 	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
 		wqcfg_offset = WQCFG_OFFSET(idxd, wq->id, i);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index cc0a3fe1c957..fe5af50b58a4 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -227,6 +227,7 @@ struct idxd_wq {
 	char name[WQ_NAME_SIZE + 1];
 	u64 max_xfer_bytes;
 	u32 max_batch_size;
+	u32 max_sgl_size;
 
 	/* Lock to protect upasid_xa access. */
 	struct mutex uc_lock;
@@ -348,6 +349,7 @@ struct idxd_device {
 
 	u64 max_xfer_bytes;
 	u32 max_batch_size;
+	u32 max_sgl_size;
 	int max_groups;
 	int max_engines;
 	int max_rdbufs;
@@ -692,6 +694,20 @@ static inline void idxd_wq_set_max_batch_size(int idxd_type, struct idxd_wq *wq,
 		wq->max_batch_size = max_batch_size;
 }
 
+static bool idxd_sgl_supported(struct idxd_device *idxd)
+{
+	return idxd->hw.dsacap0.sgl_formats &&
+	       idxd->data->type == IDXD_TYPE_DSA &&
+	       idxd->hw.version >= DEVICE_VERSION_3;
+}
+
+static inline void idxd_wq_set_init_max_sgl_size(struct idxd_device *idxd,
+						 struct idxd_wq *wq)
+{
+	if (idxd_sgl_supported(idxd))
+		wq->max_sgl_size = 1U << idxd->hw.dsacap0.max_sgl_shift;
+}
+
 static inline void idxd_wqcfg_set_max_batch_shift(int idxd_type, union wqcfg *wqcfg,
 						  u32 max_batch_shift)
 {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index cc8203320d40..f37a7d7b537a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -217,6 +217,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		init_completion(&wq->wq_resurrect);
 		wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
 		idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
+		idxd_wq_set_init_max_sgl_size(idxd, wq);
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
@@ -585,6 +586,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	idxd->hw.dsacap0.bits = ioread64(idxd->reg_base + IDXD_DSACAP0_OFFSET);
 	idxd->hw.dsacap1.bits = ioread64(idxd->reg_base + IDXD_DSACAP1_OFFSET);
 	idxd->hw.dsacap2.bits = ioread64(idxd->reg_base + IDXD_DSACAP2_OFFSET);
+	if (idxd_sgl_supported(idxd)) {
+		idxd->max_sgl_size = 1U << idxd->hw.dsacap0.max_sgl_shift;
+		dev_dbg(dev, "max sgl size: %u\n", idxd->max_sgl_size);
+	}
 
 	/* read iaa cap */
 	if (idxd->data->type == IDXD_TYPE_IAX && idxd->hw.version >= DEVICE_VERSION_2)
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 45485ecd7bb6..0401cfc95f27 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -385,7 +385,8 @@ union wqcfg {
 		/* bytes 12-15 */
 		u32 max_xfer_shift:5;
 		u32 max_batch_shift:4;
-		u32 rsvd4:23;
+		u32 max_sgl_shift:4;
+		u32 rsvd4:19;
 
 		/* bytes 16-19 */
 		u16 occupancy_inth;
@@ -585,6 +586,15 @@ union evl_status_reg {
 
 #define IDXD_DSACAP0_OFFSET		0x180
 union dsacap0_reg {
+	struct {
+		u64 max_sgl_shift:4;
+		u64 max_gr_block_shift:4;
+		u64 ops_inter_domain:7;
+		u64 rsvd1:17;
+		u64 sgl_formats:16;
+		u64 max_sg_process:8;
+		u64 rsvd2:8;
+	};
 	u64 bits;
 };
 
-- 
2.43.0


