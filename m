Return-Path: <dmaengine+bounces-4664-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E88A5810D
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 07:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3469D188B900
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE017ADF8;
	Sun,  9 Mar 2025 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RbRECj1z"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE914AD0D;
	Sun,  9 Mar 2025 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741501274; cv=none; b=o4GdJnNRBTEPOVVnrxVc5CVfJrHMUD/U+w7H4y6QylnbjXTVU5v/z1otuNC3PmaRfbs3tzj76+K3HGlRn+wK0Bavea4Q/5VgpF2J2w2beA87MBCgBqQ/F5s8V/tPTWcxUWz0CLMmisAAlFtUfAM4rtwEzL1AqBlndxPrQ+A+nBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741501274; c=relaxed/simple;
	bh=F6XIWytTbn+VJ8BaAUEi0Cd8UrpWPJt56uk2WdeE8uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggkdPTSFmxeJ4fsW1WJUW4L0hFcPG1vItzbKVMXWSzpDxLHsLhGf17PI5eO5lxJjqV7nfmr+CM1Qj+Ue3RJF5eSGPNzc2bW7eypKNPm27sYeNQvj/tFkDKR6kWKEMpxh2bwdZrbJMdD8hWtb9CG3h1qJSP1U/FESyVbF0Hlp6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RbRECj1z; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741501263; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HUg1dbeBXPGQiZc+fwWwEOiIkW/CGBLZSSyBw33IJo0=;
	b=RbRECj1zrEFPX9+6mbBBito720PJ7s6dguol0awWp8DEZane476KdxsPhwL9a17+14ovzqLn8FsSTFgXck210n9kfwV4WCXj4iSg6NcaENmGppglvS6Y2IQCEJkjrhDOZ4FthUYBK6idfKr7IMsRx2QpYHvSMYgatahkxaDRlSA=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQwVyjM_1741501262 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 09 Mar 2025 14:21:02 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	Markus.Elfring@web.de,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] dmaengine: idxd: Add missing cleanup for early error out in idxd_setup_internals
Date: Sun,  9 Mar 2025 14:20:53 +0800
Message-ID: <20250309062058.58910-5-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The idxd_setup_internals() is missing some cleanup when things fail in
the middle.

Add the appropriate cleanup routines:

- cleanup groups
- cleanup enginces
- cleanup wqs

to make sure it exits gracefully.

Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
Cc: stable@vger.kernel.org
Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/init.c | 59 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index fe4a14813bba..7334085939dc 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -155,6 +155,26 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
 	pci_free_irq_vectors(pdev);
 }
 
+static void idxd_clean_wqs(struct idxd_device *idxd)
+{
+	struct idxd_wq *wq;
+	struct device *conf_dev;
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = idxd->wqs[i];
+		if (idxd->hw.wq_cap.op_config)
+			bitmap_free(wq->opcap_bmap);
+		kfree(wq->wqcfg);
+		conf_dev = wq_confdev(wq);
+		put_device(conf_dev);
+		kfree(wq);
+
+	}
+	bitmap_free(idxd->wq_enable_map);
+	kfree(idxd->wqs);
+}
+
 static int idxd_setup_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -245,6 +265,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	return rc;
 }
 
+static void idxd_clean_engines(struct idxd_device *idxd)
+{
+	struct idxd_engine *engine;
+	struct device *conf_dev;
+	int i;
+
+	for (i = 0; i < idxd->max_engines; i++) {
+		engine = idxd->engines[i];
+		conf_dev = engine_confdev(engine);
+		put_device(conf_dev);
+		kfree(engine);
+	}
+	kfree(idxd->engines);
+}
+
 static int idxd_setup_engines(struct idxd_device *idxd)
 {
 	struct idxd_engine *engine;
@@ -296,6 +331,19 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 	return rc;
 }
 
+static void idxd_clean_groups(struct idxd_device *idxd)
+{
+	struct idxd_group *group;
+	int i;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		group = idxd->groups[i];
+		put_device(group_confdev(group));
+		kfree(group);
+	}
+	kfree(idxd->groups);
+}
+
 static int idxd_setup_groups(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -410,7 +458,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int rc, i;
+	int rc;
 
 	init_waitqueue_head(&idxd->cmd_waitq);
 
@@ -441,14 +489,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
  err_evl:
 	destroy_workqueue(idxd->wq);
  err_wkq_create:
-	for (i = 0; i < idxd->max_groups; i++)
-		put_device(group_confdev(idxd->groups[i]));
+	idxd_clean_groups(idxd);
  err_group:
-	for (i = 0; i < idxd->max_engines; i++)
-		put_device(engine_confdev(idxd->engines[i]));
+	idxd_clean_engines(idxd);
  err_engine:
-	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(wq_confdev(idxd->wqs[i]));
+	idxd_clean_wqs(idxd);
  err_wqs:
 	return rc;
 }
-- 
2.39.3


