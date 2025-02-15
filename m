Return-Path: <dmaengine+bounces-4495-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC760A36C36
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 06:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425043AE4A7
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224B1A254E;
	Sat, 15 Feb 2025 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U1QanTi4"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7E19DF66;
	Sat, 15 Feb 2025 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739598286; cv=none; b=fQq6YicQI9TU8IwDnRpmnMDoB8k24BDh6hbeLvcn5FWQXE70ef4qF5KIlaaCtqs50+wHMGi7dBBgU4MFl1bT9uA38O34rSQDkeASNb3uaMgSQdR1p8IaPQt7tamegisfv1MUeLGPSHV3Kh/OI6Pn+rcYcLxLGmdTCHtm6+GPzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739598286; c=relaxed/simple;
	bh=Gd3QuvVUwwaXOMTn22LJfR8ggxA+qsdsGFMiFuF6moU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWclOIl9e8pYrtWiqbCD6Ue41S+KvJrTNQvisoIXyHzK3oQN4HV7488vtU/63YV804ByV3GgdNMHIeLAAZhRFK1Vq937JGcNGg5yjCOxPFWNAMkgK3rbDCugLyr89zhH9q311jmdbvetsvbT9YU8nJTO3np5g/valwvHRv50k/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U1QanTi4; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739598276; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TwIpPAeALoWFsS7S+cMv96y4UX2XGf68/jW3CZv7Zuw=;
	b=U1QanTi42mbeTm5XlxzaoRZHgehVx64MhqIH8HMGi0XNuz4sfg9LdXSSK4toHDfWEE6KTWyp3zQvOGh6bJwIc1Afh+/CFKsFfjQNAnPPFPspSOrJAxopWVrjtZB6r+Gwne3paoFFEWZXLtAcuYQo/0eAqabbYVdOgwK+ii1t9rc=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPSysO0_1739598275 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 13:44:35 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: nikhil.rao@intel.com,
	xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
Date: Sat, 15 Feb 2025 13:44:28 +0800
Message-ID: <20250215054431.55747-5-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory allocated for idxd is not freed if an error occurs during
idxd_alloc(). To fix it, free the allocated memory in the reverse order
of allocation before exiting the function in case of an error.

Fixes: a8563a33a5e2 ("dmanegine: idxd: reformat opcap output to match bitmap_parse() input")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a2da68e6144d..dc34830fe7c3 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -567,28 +567,34 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
 	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
 	if (idxd->id < 0)
-		return NULL;
+		goto err_ida;
 
 	idxd->opcap_bmap = bitmap_zalloc_node(IDXD_MAX_OPCAP_BITS, GFP_KERNEL, dev_to_node(dev));
-	if (!idxd->opcap_bmap) {
-		ida_free(&idxd_ida, idxd->id);
-		return NULL;
-	}
+	if (!idxd->opcap_bmap)
+		goto err_opcap;
 
 	device_initialize(conf_dev);
 	conf_dev->parent = dev;
 	conf_dev->bus = &dsa_bus_type;
 	conf_dev->type = idxd->data->dev_type;
 	rc = dev_set_name(conf_dev, "%s%d", idxd->data->name_prefix, idxd->id);
-	if (rc < 0) {
-		put_device(conf_dev);
-		return NULL;
-	}
+	if (rc < 0)
+		goto err_name;
 
 	spin_lock_init(&idxd->dev_lock);
 	spin_lock_init(&idxd->cmd_lock);
 
 	return idxd;
+
+err_name:
+	put_device(conf_dev);
+	bitmap_free(idxd->opcap_bmap);
+err_opcap:
+	ida_free(&idxd_ida, idxd->id);
+err_ida:
+	kfree(idxd);
+
+	return NULL;
 }
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
-- 
2.39.3


