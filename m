Return-Path: <dmaengine+bounces-4819-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0CA7BC2A
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D49917C0F5
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187D1E1E1B;
	Fri,  4 Apr 2025 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e90dXDhj"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FAB191F98;
	Fri,  4 Apr 2025 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768148; cv=none; b=Ujme440KScpP9Nd9CHkrtsMS07YlAg4y0xz2FXfDmrZZtQ5FqcEIN4638mLoWiMoJbjuCQlrVYQfGf53h+hQWaiYM5iec9Oq+hcisRXH01lv+fJ3zAM2K5EKJ2WIexRiaenftWHLABbfpK3rhQYkRiubJWYjIEAxemR/athox4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768148; c=relaxed/simple;
	bh=J9dgHiVoUeDehzGhiMKQsLqo/lrePUAYwnsmDH/a2V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DK/Lo2XejDM4PwXwNtFhC4JvNefcIU+WHg9ibVeFTpaPKRH13fuXh65CPMkUR7+XSfJz94p9nK9j95J8DuY2bdZWlRtBVBDd7GiG/0/tocG/E4vR+VV7SDybUqQhZi1HgDYppz+9L8LAef9LWcFU3uN9kSANhnPhlyq+VcmUrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e90dXDhj; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743768143; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X1wSzaMsYxcrm8YLnnJlfkvlBMimjzDbk7WoYmqzepA=;
	b=e90dXDhjxQIAvK23GFafkWk+YkJMVJl+AhlW2iHqncH2jwA58C6z6157FfuV84WxomSr6ceJd5I7yprITGlcVzTZjKVIPq/C8QdUzhydrY+cqqyMX4DzDYcjjAejRiwqGsHV8YWgDYU8ECLBCj15EK3NNhcP5XDmg5Hg+LudhyM=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WUyld4u_1743768141 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Apr 2025 20:02:21 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] dmaengine: idxd: Add missing cleanup for early error out in idxd_setup_internals
Date: Fri,  4 Apr 2025 20:02:12 +0800
Message-ID: <20250404120217.48772-5-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
References: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
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
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 drivers/dma/idxd/init.c | 58 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 7f0a26e2e0a5..a40fb2fd5006 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -155,6 +155,25 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
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
+	}
+	bitmap_free(idxd->wq_enable_map);
+	kfree(idxd->wqs);
+}
+
 static int idxd_setup_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -245,6 +264,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
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
@@ -296,6 +330,19 @@ static int idxd_setup_engines(struct idxd_device *idxd)
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
@@ -410,7 +457,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int rc, i;
+	int rc;
 
 	init_waitqueue_head(&idxd->cmd_waitq);
 
@@ -441,14 +488,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
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
2.43.5


