Return-Path: <dmaengine+bounces-5546-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE6AE1BBF
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 15:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8A1189E94B
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699EC2BCF4C;
	Fri, 20 Jun 2025 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIVF1vtS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7762629CB40;
	Fri, 20 Jun 2025 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425017; cv=none; b=i5WcnCeV2rPG8xjjbFIgM1vn4boNEBIleIPaUTesrMPEtFBqcvyy6MOIRv/0ww2NIoLsiLFA2Wo6l56Tq0f762cuY4jJzCht3ld4c/00bzjQkqe3tXvhJnfcPCEKIdFxtBWVF3CybDt308Fhx/e0+8HTtjrQfSPfdTT//OT9Zug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425017; c=relaxed/simple;
	bh=I5vk2rGm9Gp8qpb3w92XvEWty7AtHtw6DnFufqS61L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYLaNrsmP3yMWCyhzgrFajQboTCR8nuctzRXM8zDQrGl8o0aL2mXHwppIdXPkC1FhwyzszX8xEiWmvvJrTFSyiWjpgPY2I/DrznwFm02NAel+S6hGMcvcvog7WHIVIMiiWJ0tz/n8IZVSfU2Mju4QvH7ljZBE1xBhsA/SwCp8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIVF1vtS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750425015; x=1781961015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5vk2rGm9Gp8qpb3w92XvEWty7AtHtw6DnFufqS61L4=;
  b=TIVF1vtS4Or9ezyCizY/T3Nn7Q6pmVV1Uiy+ynR16GLzFk6UQWA6LuSy
   HsKnsZBkHqGSJk1Q7hdZBnEO0NgixM+bAWXtaVOOa0y/shlapVi/YUgkH
   G//RZX916MhgaRvQlxDKpIEqq5vWpBb0pTuqcdUFrrVeBDXtz4VlNRfhq
   Ds79y1apSdm0wMqD7q1HhcQNZ/2qbn3B2O7Eg+EX26LHeQWc12dc5RvFg
   24lUxb0WFG3whNNFbGVGrmsWVQeeT9rS5tCwC8NWTchrqejAxSKvYl6sV
   xtz5h+RafGVzazoKrG6dUMNMGf6o1SaVLPtD22fJLP57gRGsKpU+8Zz+M
   w==;
X-CSE-ConnectionGUID: Z+Tt6J96Q/O/+4lLhKTV7Q==
X-CSE-MsgGUID: X05uKYOAR1GT1ww8rSmgMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52388893"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52388893"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:10:14 -0700
X-CSE-ConnectionGUID: sqL897AZQWejJ8rtDWZK4A==
X-CSE-MsgGUID: Nl3L8TU5RMetN1FVbCUJMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="154928687"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa003.fm.intel.com with ESMTP; 20 Jun 2025 06:10:12 -0700
From: Yi Sun <yi.sun@intel.com>
To: dave.jiang@intel.com,
	vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fenghuay@nvidia.com,
	philip.lantz@intel.com
Cc: yi.sun@intel.com,
	gordon.jin@intel.com,
	anil.s.keshavamurthy@intel.com
Subject: [PATCH v2 2/2] dmaengine: idxd: Add Max SGL Size Support for DSA3.0
Date: Fri, 20 Jun 2025 21:09:53 +0800
Message-ID: <20250620130953.1943703-3-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620130953.1943703-1-yi.sun@intel.com>
References: <20250620130953.1943703-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain DSA 3.0 opcodes, such as Gather copy and Gather reduce, require max
SGL configured for workqueues prior to supporting these opcodes.

Configure the maximum scatter-gather list (SGL) size for workqueues during
setup on the supported HW. Application can then properly handle the SGL
size without explicitly setting it.

Signed-off-by: Yi Sun <yi.sun@intel.com>
Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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
index 216461aa0cd1..4daf5995acee 100644
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
@@ -587,6 +588,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
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
index b430bddbd1e4..c665687913c6 100644
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
-- 
2.43.0


