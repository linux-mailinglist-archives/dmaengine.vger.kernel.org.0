Return-Path: <dmaengine+bounces-3776-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25749D665A
	for <lists+dmaengine@lfdr.de>; Sat, 23 Nov 2024 00:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0509DB22684
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 23:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A061D319B;
	Fri, 22 Nov 2024 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnUSRLow"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55D1C7B8D;
	Fri, 22 Nov 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318239; cv=none; b=R3buPoxBmobyA+fvRAU16mRae1+DJjTjI/GBFnCCwlYuvDxRWu4dSqMiIEAkA5xXeTlHJ/2TIrVEH/gJg0npWaVx8Kutgge0AU1AGlPdLSZ7isUBcMVPT7tnP1FmQ0SEOpH956g+/gqX6pyxf+Yq+p2cwlD4Hq8M4YNURCtPbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318239; c=relaxed/simple;
	bh=jph7/J8vvzqNTj1B4WjL2EGHusaNaMb73zYHAHYJN6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEDsCIC43zxteT3CELPS7ArnLiAUJuRYnzpLKDjlUAG2oBksFH3HElBvs6v5Y8dds5nkLGKxivLTs+XkFKgnYmqwL5KpLlZ+6SQvHmVMDbBDT17qFOpb3oew4iYTJc3f6eS4Ke/1OJSJSNwQsvuk/JOIMYaVW1D3Dd6BFrcoeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnUSRLow; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732318237; x=1763854237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jph7/J8vvzqNTj1B4WjL2EGHusaNaMb73zYHAHYJN6Y=;
  b=RnUSRLowSaZqjCdiKfiIs0OndQPdnBFK+v7hiuj+WWG26xAvbaBEsaWv
   WCOikTiW+gXf505W9Gn4GIkQnR5mH+Cex/YMmy9kfBDipfy6SIc26TIDE
   1wWEiHQORv2uDCsY0Du9uxuSLB486fyfff6RaU9IGf/tYNy63RLEMNXXL
   n5UwLzHzJxnhE8gCxgyiifUhbKs5KHR43CPYlqhMih9h9+gLA8c1Tb9RH
   5X1UPBvePhYH68YOkicl8G00WvL4YmHe71nfe26B0e/NyMiwGhrpZ9iZ9
   jkNNbU1UGWkFySLBnyV7M788cVJrbObZ8SL/Y4iPWZjsdlAkG8xSM6M//
   g==;
X-CSE-ConnectionGUID: WG+a+b3mRTegSPHCECfjzg==
X-CSE-MsgGUID: Z2U1tfXQQICohpCEAnQhMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43134423"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="43134423"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:30:35 -0800
X-CSE-ConnectionGUID: q/hsHCvaT2OmoHFpfFR4UA==
X-CSE-MsgGUID: EUG5wKEpQIGNSzHd1XtxZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="95127797"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa005.fm.intel.com with ESMTP; 22 Nov 2024 15:30:35 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 3/5] dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers
Date: Fri, 22 Nov 2024 15:30:26 -0800
Message-Id: <20241122233028.2762809-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241122233028.2762809-1-fenghua.yu@intel.com>
References: <20241122233028.2762809-1-fenghua.yu@intel.com>
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
Change log:
v2:
- Call a helper idxd_free_saved() to free all saved configs (Dave Jiang).
- Replace defined bitmap free function with existing bitmpa_free().

 drivers/dma/idxd/idxd.h |  11 ++
 drivers/dma/idxd/init.c | 225 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 1f93dd6db28f..8b381a1fb259 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -374,6 +374,17 @@ struct idxd_device {
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
index a76ec4312a94..da5b76a1e208 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -756,6 +756,231 @@ static void idxd_unbind(struct device_driver *drv, const char *buf)
 	put_device(dev);
 }
 
+#define idxd_free_saved_configs(saved_configs, count)	\
+	do {						\
+		int i;					\
+							\
+		for (i = 0; i < (count); i++)		\
+			kfree(saved_configs[i]);	\
+	} while (0)
+
+static void idxd_free_saved(struct idxd_group **saved_groups,
+			    struct idxd_engine **saved_engines,
+			    struct idxd_wq **saved_wqs,
+			    struct idxd_device *idxd)
+{
+	if (saved_groups)
+		idxd_free_saved_configs(saved_groups, idxd->max_groups);
+	if (saved_engines)
+		idxd_free_saved_configs(saved_engines, idxd->max_engines);
+	if (saved_wqs)
+		idxd_free_saved_configs(saved_wqs, idxd->max_wqs);
+}
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
+			/* Free saved groups */
+			idxd_free_saved(saved_groups, NULL, NULL, idxd);
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
+		idxd_free_saved(saved_groups, NULL, NULL, idxd);
+
+		return -ENOMEM;
+	}
+	for (i = 0; i < idxd->max_engines; i++) {
+		struct idxd_engine *saved_engine __free(kfree) =
+				kzalloc_node(sizeof(*saved_engine), GFP_KERNEL,
+					     dev_to_node(dev));
+		if (!saved_engine) {
+			/* Free saved groups and engines */
+			idxd_free_saved(saved_groups, saved_engines, NULL,
+					idxd);
+
+			return -ENOMEM;
+		}
+
+		memcpy(saved_engine, idxd->engines[i], sizeof(*saved_engine));
+		saved_engines[i] = no_free_ptr(saved_engine);
+	}
+
+	unsigned long *saved_wq_enable_map __free(bitmap) =
+			bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL,
+					   dev_to_node(dev));
+	if (!saved_wq_enable_map) {
+		/* Free saved groups and engines */
+		idxd_free_saved(saved_groups, saved_engines, NULL, idxd);
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
+		idxd_free_saved(saved_groups, saved_engines, NULL, idxd);
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
+			idxd_free_saved(saved_groups, saved_engines, saved_wqs,
+					idxd);
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


