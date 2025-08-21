Return-Path: <dmaengine+bounces-6099-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6284B2F2F3
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 10:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1E7171CF0
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7172ED84E;
	Thu, 21 Aug 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IA+vm9Pi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AD2EBDF2;
	Thu, 21 Aug 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766349; cv=none; b=Nt95TBf4CN476CbjcmU0swTILDQlPx/wBwQW3u2JhdOs26LV1tbIk47u/hX4kQn1IiZ88dTx1HpywURSQSRnVVBnsfOICUWODThuMLPmTu7qPL+IHukMA4znHdZSxBVlI9UEMcNW4MVOxa0gJGByobS5O/NkWKae59NSPDB7RV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766349; c=relaxed/simple;
	bh=xr2wmTiBbgKMffEmUw3ANz0RaBM49eqI4ruutNEKNlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL/CfG+fuPPEw3p6wB301CGw3T1VAw3QszKxijuW1pWeFy5GAmmzKhpIywLCV/ItU7MRAjl8VcyLVDjM35y/7Wb8zG111m68B9y9fMbvXL2j94OMe3Vi/21ghpsNI1OHqGwyDcq661MEvihO3Yosw8NTs6ycjS+yaYf/5naEZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IA+vm9Pi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755766347; x=1787302347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xr2wmTiBbgKMffEmUw3ANz0RaBM49eqI4ruutNEKNlc=;
  b=IA+vm9PiatRIXI6LDSPKWjg8mdpBnqYAPjtNzcbqtkfPXOtlEBv4zOl3
   8ey9vn5TfqAVCbrMeymHbBl7Ik8HRZSUn9BOJH318McIT5ZlpKzMtVHcV
   HxsdY53xeDUTn+x0ZRfgLC/JiG5sLXhvXHpWBN9Gn5AnSkTnGsTbcYmTQ
   R3DTO3+d9EtOnObd5rEpGhojBEWLM1lmKgIp2WMXviP0F+3oiX+9q+7t1
   Badx/PWT62rnqphpgjH1efrS3dJ7SSY5jGj0RRdD+gtpjELO1b4FDAqpm
   lbhNPfYHmh9rHOUNv120Bbk5J+a3uBz//gw8555C3C8OCpb4zKrZCtvb+
   g==;
X-CSE-ConnectionGUID: I6vZkViWTHa6qF459wse8A==
X-CSE-MsgGUID: 7IRXgjQcRGGdnZv1MhNtYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61877151"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61877151"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:52:27 -0700
X-CSE-ConnectionGUID: Q6T/rM0lR0695vZc/2mnsA==
X-CSE-MsgGUID: zia+Tii1R1SfDHBhXEq7bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173624822"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2025 01:52:22 -0700
From: Yi Sun <yi.sun@intel.com>
To: vkoul@kernel.org
Cc: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.sun@intel.com,
	gordon.jin@intel.com,
	fenghuay@nvidia.com,
	yi1.lai@intel.com,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [PATCH v3 2/2] dmaengine: idxd: Add Max SGL Size Support for DSA3.0
Date: Thu, 21 Aug 2025 16:51:11 +0800
Message-ID: <20250821085111.1430076-3-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821085111.1430076-1-yi.sun@intel.com>
References: <20250821085111.1430076-1-yi.sun@intel.com>
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
Tested-by: Yi Lai <yi1.lai@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

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
index 084df60d407b..395d5486aee6 100644
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
index 439bbc311591..c5f344c55a69 100644
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


