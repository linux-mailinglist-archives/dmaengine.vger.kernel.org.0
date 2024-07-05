Return-Path: <dmaengine+bounces-2640-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25276928D63
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 20:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C524B28553B
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5016EB4A;
	Fri,  5 Jul 2024 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLhon7mq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956D15FCE9;
	Fri,  5 Jul 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203325; cv=none; b=fRVCaO80WLtDd50hvAvr6VzSzSUwS+ZQuaqRfYu+QV7tgrTMSNXgweqlCmKJ6Zh4yeBGFpeNwjcCQl/eI5jl47NqTn0FILoBq5CXV79zYlnl64bTz862dXNuIOz4wvu0hytFpxmnuBVmzuYT3zDFj/+WUWrA6XAynVSa+w0EHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203325; c=relaxed/simple;
	bh=EZlEkzR6k7XGgV0+ZMZDFuYvwsVONhRSZrAAjdocq2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rl0hv6Nxin4actcQX5D9dISMDs1PseR6ryA0U2igV/Yu5ciqlkZQzSjfNJchTttZm2txcXitzFVY3matibCauFfbhVHDz1zLTsDqOChjmP06EECFraJaj6JDgSfkxK/V0VgFPX6XSgGfQXXDMrHS6w8HGmpHiCTEUutgFCRoOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLhon7mq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720203324; x=1751739324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EZlEkzR6k7XGgV0+ZMZDFuYvwsVONhRSZrAAjdocq2w=;
  b=hLhon7mqiHb1MbYklHoVOOVlE+m+UP0b5u9AIdZcRNJrrf5lukXN5xgo
   ufp2qHlsSsjbRNwzYKPujv6EyMD17XeF5S90AR49ATqf8HUGITqD3xJ0m
   SeWvlDo1YxDMyua7Gwlzo6sngfva+gTvCO/jYLscunxcrdHmTOsikeCdK
   zH22LGYDpLyy+VX4TViNNi3IfiEz4hotOMDiwFCYNtC5Vh7K8C4Oqlu96
   kwwaE1s1kA0kHrIYNAAfhot9mjNGvhRRtpgEYE5kBZeEieKST3QLMx6kU
   786Q4vHaIfWx/kskhNdPAw9IvGQiPpaqsrhtKio6EvsMCK9uUHbBBhDJN
   A==;
X-CSE-ConnectionGUID: 9ahph7IQRx2FIuatQ0acWg==
X-CSE-MsgGUID: kiBCil7vS2GCkD4uuAZ7cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="12410721"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="12410721"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 11:15:20 -0700
X-CSE-ConnectionGUID: KRlqnAzuSy6VRy9sDfsRbg==
X-CSE-MsgGUID: jzgzzgnqSByvc/wcDMhiUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="47672701"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa008.jf.intel.com with ESMTP; 05 Jul 2024 11:15:20 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 3/5] dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers
Date: Fri,  5 Jul 2024 11:15:16 -0700
Message-Id: <20240705181519.4067507-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240705181519.4067507-1-fenghua.yu@intel.com>
References: <20240705181519.4067507-1-fenghua.yu@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the helpers to save and restore IDXD device configurations.

These helpers will be called during Function Level Reset (FLR) processing.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/idxd.h |  11 ++
 drivers/dma/idxd/init.c | 224 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 235 insertions(+)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 03f099518ec1..4f3e98720b45 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -377,6 +377,17 @@ struct idxd_device {
 	struct dentry *dbgfs_evl_file;
 
 	bool user_submission_safe;
+
+	struct idxd_saved_states *idxd_saved;
+};
+
+struct idxd_saved_states {
+	struct idxd_device saved_idxd;
+	struct idxd_evl saved_evl;
+	struct idxd_engine **saved_engines;
+	struct idxd_wq **saved_wqs;
+	struct idxd_group **saved_groups;
+	unsigned long *saved_wq_enable_map;
 };
 
 static inline unsigned int evl_ent_size(struct idxd_device *idxd)
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a6d8097b2dcf..bb03d8cc5d32 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -749,6 +749,230 @@ static void idxd_unbind(struct device_driver *drv, const char *buf)
 	put_device(dev);
 }
 
+/* Free allocated saved wq enable map after saving wq configs. */
+static void free_saved_wq_enable_map(unsigned long *map)
+{
+	bitmap_free(map);
+}
+
+DEFINE_FREE(free_saved_wq_enable_map, unsigned long *, if (!IS_ERR_OR_NULL(_T))
+	    free_saved_wq_enable_map(_T))
+
+#define idxd_free_saved_configs(saved_configs, count)	\
+	do {						\
+		int i;					\
+							\
+		for (i = 0; i < (count); i++)		\
+			kfree(saved_configs[i]);	\
+	} while (0)
+
+/*
+ * Save IDXD device configurations including engines, groups, wqs etc.
+ * The saved configurations can be restored when needed.
+ */
+static int idxd_device_config_save(struct idxd_device *idxd,
+				   struct idxd_saved_states *idxd_saved)
+{
+	struct device *dev = &idxd->pdev->dev;
+	int i;
+
+	memcpy(&idxd_saved->saved_idxd, idxd, sizeof(*idxd));
+
+	if (idxd->evl) {
+		memcpy(&idxd_saved->saved_evl, idxd->evl,
+		       sizeof(struct idxd_evl));
+	}
+
+	struct idxd_group **saved_groups __free(kfree) =
+			kcalloc_node(idxd->max_groups,
+				     sizeof(struct idxd_group *),
+				     GFP_KERNEL, dev_to_node(dev));
+	if (!saved_groups)
+		return -ENOMEM;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		struct idxd_group *saved_group __free(kfree) =
+			kzalloc_node(sizeof(*saved_group), GFP_KERNEL,
+				     dev_to_node(dev));
+
+		if (!saved_group) {
+			idxd_free_saved_configs(saved_groups, i);
+
+			return -ENOMEM;
+		}
+
+		memcpy(saved_group, idxd->groups[i], sizeof(*saved_group));
+		saved_groups[i] = no_free_ptr(saved_group);
+	}
+
+	struct idxd_engine **saved_engines =
+			kcalloc_node(idxd->max_engines,
+				     sizeof(struct idxd_engine *),
+				     GFP_KERNEL, dev_to_node(dev));
+	if (!saved_engines) {
+		/* Free saved groups */
+		idxd_free_saved_configs(saved_groups, idxd->max_groups);
+
+		return -ENOMEM;
+	}
+	for (i = 0; i < idxd->max_engines; i++) {
+		struct idxd_engine *saved_engine __free(kfree) =
+				kzalloc_node(sizeof(*saved_engine), GFP_KERNEL,
+					     dev_to_node(dev));
+		if (!saved_engine) {
+			/* Free saved groups and engines */
+			idxd_free_saved_configs(saved_groups, idxd->max_groups);
+			idxd_free_saved_configs(saved_engines, i);
+
+			return -ENOMEM;
+		}
+
+		memcpy(saved_engine, idxd->engines[i], sizeof(*saved_engine));
+		saved_engines[i] = no_free_ptr(saved_engine);
+	}
+
+	unsigned long *saved_wq_enable_map __free(free_saved_wq_enable_map) =
+			bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL,
+					   dev_to_node(dev));
+	if (!saved_wq_enable_map) {
+		/* Free saved groups and engines */
+		idxd_free_saved_configs(saved_groups, idxd->max_groups);
+		idxd_free_saved_configs(saved_engines, idxd->max_engines);
+
+		return -ENOMEM;
+	}
+
+	bitmap_copy(saved_wq_enable_map, idxd->wq_enable_map, idxd->max_wqs);
+
+	struct idxd_wq **saved_wqs __free(kfree) =
+			kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
+				     GFP_KERNEL, dev_to_node(dev));
+	if (!saved_wqs) {
+		/* Free saved groups and engines */
+		idxd_free_saved_configs(saved_groups, idxd->max_groups);
+		idxd_free_saved_configs(saved_engines, idxd->max_engines);
+
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *saved_wq __free(kfree) =
+			kzalloc_node(sizeof(*saved_wq), GFP_KERNEL,
+				     dev_to_node(dev));
+		struct idxd_wq *wq;
+
+		if (!saved_wq) {
+			/* Free saved groups, engines, and wqs */
+			idxd_free_saved_configs(saved_groups, idxd->max_groups);
+			idxd_free_saved_configs(saved_engines,
+						idxd->max_engines);
+			idxd_free_saved_configs(saved_wqs, i);
+
+			return -ENOMEM;
+		}
+
+		if (!test_bit(i, saved_wq_enable_map))
+			continue;
+
+		wq = idxd->wqs[i];
+		mutex_lock(&wq->wq_lock);
+		memcpy(saved_wq, wq, sizeof(*saved_wq));
+		saved_wqs[i] = no_free_ptr(saved_wq);
+		mutex_unlock(&wq->wq_lock);
+	}
+
+	/* Save configurations */
+	idxd_saved->saved_groups = no_free_ptr(saved_groups);
+	idxd_saved->saved_engines = no_free_ptr(saved_engines);
+	idxd_saved->saved_wq_enable_map = no_free_ptr(saved_wq_enable_map);
+	idxd_saved->saved_wqs = no_free_ptr(saved_wqs);
+
+	return 0;
+}
+
+/*
+ * Restore IDXD device configurations including engines, groups, wqs etc
+ * that were saved before.
+ */
+static void idxd_device_config_restore(struct idxd_device *idxd,
+				       struct idxd_saved_states *idxd_saved)
+{
+	struct idxd_evl *saved_evl = &idxd_saved->saved_evl;
+	int i;
+
+	idxd->rdbuf_limit = idxd_saved->saved_idxd.rdbuf_limit;
+
+	if (saved_evl)
+		idxd->evl->size = saved_evl->size;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		struct idxd_group *saved_group, *group;
+
+		saved_group = idxd_saved->saved_groups[i];
+		group = idxd->groups[i];
+
+		group->rdbufs_allowed = saved_group->rdbufs_allowed;
+		group->rdbufs_reserved = saved_group->rdbufs_reserved;
+		group->tc_a = saved_group->tc_a;
+		group->tc_b = saved_group->tc_b;
+		group->use_rdbuf_limit = saved_group->use_rdbuf_limit;
+
+		kfree(saved_group);
+	}
+	kfree(idxd_saved->saved_groups);
+
+	for (i = 0; i < idxd->max_engines; i++) {
+		struct idxd_engine *saved_engine, *engine;
+
+		saved_engine = idxd_saved->saved_engines[i];
+		engine = idxd->engines[i];
+
+		engine->group = saved_engine->group;
+
+		kfree(saved_engine);
+	}
+	kfree(idxd_saved->saved_engines);
+
+	bitmap_copy(idxd->wq_enable_map, idxd_saved->saved_wq_enable_map,
+		    idxd->max_wqs);
+	bitmap_free(idxd_saved->saved_wq_enable_map);
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *saved_wq, *wq;
+		size_t len;
+
+		if (!test_bit(i, idxd->wq_enable_map))
+			continue;
+
+		saved_wq = idxd_saved->saved_wqs[i];
+		wq = idxd->wqs[i];
+
+		mutex_lock(&wq->wq_lock);
+
+		wq->group = saved_wq->group;
+		wq->flags = saved_wq->flags;
+		wq->threshold = saved_wq->threshold;
+		wq->size = saved_wq->size;
+		wq->priority = saved_wq->priority;
+		wq->type = saved_wq->type;
+		len = strlen(saved_wq->name) + 1;
+		strscpy(wq->name, saved_wq->name, len);
+		wq->max_xfer_bytes = saved_wq->max_xfer_bytes;
+		wq->max_batch_size = saved_wq->max_batch_size;
+		wq->enqcmds_retries = saved_wq->enqcmds_retries;
+		wq->descs = saved_wq->descs;
+		wq->idxd_chan = saved_wq->idxd_chan;
+		len = strlen(saved_wq->driver_name) + 1;
+		strscpy(wq->driver_name, saved_wq->driver_name, len);
+
+		mutex_unlock(&wq->wq_lock);
+
+		kfree(saved_wq);
+	}
+
+	kfree(idxd_saved->saved_wqs);
+}
+
 /*
  * Probe idxd PCI device.
  * If idxd is not given, need to allocate idxd and set up its data.
-- 
2.37.1


