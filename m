Return-Path: <dmaengine+bounces-8098-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D9AD00712
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 01:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF30730312EB
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 00:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7467BA21;
	Thu,  8 Jan 2026 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJPqEtaQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB4347DD;
	Thu,  8 Jan 2026 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767830588; cv=none; b=pduBiS95nCs3CCPzDK45GbjwiPeH1v4pkC7MohbxfSfrFMXu8KnleO8E/lB1CPYkoWzmt1f4zaTBGU302Pnq2NY0Y9EIQPzF7hDMlT/8Ch7U4Gol7ciL+BiGs0H/LcwGPbW73Y1TigecAxp78huD8W2Ypits2uF2aGqb9fbgphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767830588; c=relaxed/simple;
	bh=Mjs+isH35nbq5IQLiDPgBuN2JrDFOhx6xgAZFUFeFS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHqH9Uz1ekYlp+TQIPEkD435RWioiYUQFVnSpwr1vlh2M0I7UbOSQ9Vj5kYqxovoWPFsEY1uUZF+bdAu31A/Ck/KUeLONjMlipa0Tt+dwaH2p/ADQQRNweuc/6nXjSnadwIFI7PP6d1wGlimp1jolTH+dNbWfYMs7hv4Ybs+zMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJPqEtaQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767830586; x=1799366586;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Mjs+isH35nbq5IQLiDPgBuN2JrDFOhx6xgAZFUFeFS4=;
  b=CJPqEtaQ30Pza9JgXu2tmmGD4ixpxalFjg/oXp1n2WVGtiNkeZnj07O8
   vXEq4toxLHuDoLIS0MWSz8R+NblaQpSDZGXRw1l7IeyMN1nfxTFci/8rK
   EHmQyq2wrCr2BU/ON1mMrpdhRlCOu7cKtjW3xX1xxvHetuiKrswZc/1Ok
   dqocqoZ15kZkpcRfdlOdmCkw83ytWyaiYR6zB6tayIOCFZcIR3x22QMag
   yOe9YPjFH3ihNhUeBV+oEAG6QQsWbqDDMjLaBYe3cngf7CCYr702ON6WG
   mcel2E/YNmhriaBUAUn948FuIioVgRtyjLm/iw2nYDOdq/pofmQ5aT/LV
   Q==;
X-CSE-ConnectionGUID: IKjY/SmbSPCdRBfHgu8Kow==
X-CSE-MsgGUID: wMtR4PCoS8iHHI9BiAIdOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="68214637"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="68214637"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 16:03:01 -0800
X-CSE-ConnectionGUID: /gaJzZFjTqCvVRjZqhIZ2Q==
X-CSE-MsgGUID: i19lJU91Qbqb5fzkzzwavA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="203074582"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 16:03:01 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 07 Jan 2026 16:02:23 -0800
Subject: [PATCH RESEND v2 2/2] dmaengine: idxd: Add Max SGL Size Support
 for DSA3.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-idxd-yi-sun-dsa3-sgl-size-v2-2-dbef8f559e48@intel.com>
References: <20260107-idxd-yi-sun-dsa3-sgl-size-v2-0-dbef8f559e48@intel.com>
In-Reply-To: <20260107-idxd-yi-sun-dsa3-sgl-size-v2-0-dbef8f559e48@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Yi Sun <yi.sun@intel.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 Yi Lai <yi1.lai@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767830580; l=5027;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=Iuh1FqQhvl1qBB9wMSSzJC94HqpzF4pusHp8FsXIYyA=;
 b=jVLdyf0/ysGptwWmCOL9ty1x/m5sNszOFV5jOwM6KooO9Utv7cyxNxKwNAh1kkieWVMsSXkok
 iA/VWskQsI9DQEIJ5e/Lh7uaG05A/XKjUYSvyQ7pnJSGY2YZjt9SDBD
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

From: Yi Sun <yi.sun@intel.com>

Certain DSA 3.0 opcodes, such as Gather copy and Gather reduce, require max
SGL configured for workqueues prior to supporting these opcodes.

Configure the maximum scatter-gather list (SGL) size for workqueues during
setup on the supported HW. Application can then properly handle the SGL
size without explicitly setting it.

Signed-off-by: Yi Sun <yi.sun@intel.com>
Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c    |  5 +++++
 drivers/dma/idxd/idxd.h      | 16 ++++++++++++++++
 drivers/dma/idxd/init.c      |  5 +++++
 drivers/dma/idxd/registers.h |  3 ++-
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index c2cdf41b6e57..c26128529ff4 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -390,6 +390,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	memset(wq->name, 0, WQ_NAME_SIZE);
 	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
 	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
+	idxd_wq_set_init_max_sgl_size(idxd, wq);
 	if (wq->opcap_bmap)
 		bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 }
@@ -989,6 +990,8 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	/* bytes 12-15 */
 	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
 	idxd_wqcfg_set_max_batch_shift(idxd->data->type, wq->wqcfg, ilog2(wq->max_batch_size));
+	if (idxd_sgl_supported(idxd))
+		wq->wqcfg->max_sgl_shift = ilog2(wq->max_sgl_size);
 
 	/* bytes 32-63 */
 	if (idxd->hw.wq_cap.op_config && wq->opcap_bmap) {
@@ -1167,6 +1170,8 @@ static int idxd_wq_load_config(struct idxd_wq *wq)
 
 	wq->max_xfer_bytes = 1ULL << wq->wqcfg->max_xfer_shift;
 	idxd_wq_set_max_batch_size(idxd->data->type, wq, 1U << wq->wqcfg->max_batch_shift);
+	if (idxd_sgl_supported(idxd))
+		wq->max_sgl_size = 1U << wq->wqcfg->max_sgl_shift;
 
 	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
 		wqcfg_offset = WQCFG_OFFSET(idxd, wq->id, i);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index cc0a3fe1c957..ea8c4daed38d 100644
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
+	return idxd->data->type == IDXD_TYPE_DSA &&
+	       idxd->hw.version >= DEVICE_VERSION_3 &&
+	       idxd->hw.dsacap0.sgl_formats;
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
index 2bdd1b34d50a..fb80803d5b57 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -222,6 +222,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		init_completion(&wq->wq_resurrect);
 		wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
 		idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
+		idxd_wq_set_init_max_sgl_size(idxd, wq);
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
@@ -590,6 +591,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
 		idxd->hw.dsacap1.bits = ioread64(idxd->reg_base + IDXD_DSACAP1_OFFSET);
 		idxd->hw.dsacap2.bits = ioread64(idxd->reg_base + IDXD_DSACAP2_OFFSET);
 	}
+	if (idxd_sgl_supported(idxd)) {
+		idxd->max_sgl_size = 1U << idxd->hw.dsacap0.max_sgl_shift;
+		dev_dbg(dev, "max sgl size: %u\n", idxd->max_sgl_size);
+	}
 
 	/* read iaa cap */
 	if (idxd->data->type == IDXD_TYPE_IAX && idxd->hw.version >= DEVICE_VERSION_2)
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 85e83a61a50b..f95411363ea9 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -390,7 +390,8 @@ union wqcfg {
 		/* bytes 12-15 */
 		u32 max_xfer_shift:5;
 		u32 max_batch_shift:4;
-		u32 rsvd4:23;
+		u32 max_sgl_shift:4;
+		u32 rsvd4:19;
 
 		/* bytes 16-19 */
 		u16 occupancy_inth;

-- 
2.52.0


