Return-Path: <dmaengine+bounces-4821-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AE0A7BC39
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA623BC01F
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709DC1EB9F4;
	Fri,  4 Apr 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wlxXMvXd"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A51E1DE7;
	Fri,  4 Apr 2025 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768150; cv=none; b=iZ9LmD1VACpnQrC62UXHOJ5H0Jpi8nbGwM9T9lCvr4tWlI4uxgbWMsQC/WR/EBFrmXDGzlZ1hRL1mIXFK+NsV4bQR87habeywB5aFljPkwnYPpp0adZX1coXbs+i8KkTTNL0abCTTozZ1XhGsQRCIDDXcUyAMk6ofMWPZcucWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768150; c=relaxed/simple;
	bh=Dt6RyjDkbtfECZNsTctiSSADXgGcZPflEasijEWIUQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIukme3thPileMCVxX603J8xZWaJVcBbl/Pug44cSg7V2VDj1RDCC4fbpo4aibSYR3BkCHDYHRY8ffXCr0/ypbqfYHSfT1H5dnZ+0Q/2nyinfmQj+3XWeQozY/SRsKrnLPzrDR9sLiDwJD7CoXMKHTOZJSfjDX2nXaooNED77kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wlxXMvXd; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743768140; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=E63D3a4UUFyXm/wG8nOV+rzvBCPd3HiIjLHhpke82hY=;
	b=wlxXMvXd30XglQrMHA/XZn/BsP8Ok9oono9s0VNeqJsCCbSzb1BsimpmtcWu51+3rSypoOXd74feouSy7pCbnimBNXpH4Bs7gjjaRXD4tI9xaR5jyt9oruds38lt1JrPAKfPCaNw9qEfftEm9cDMelpAIxA3y8kgt4xuRbKuJkY=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WUyld3p_1743768139 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Apr 2025 20:02:19 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs
Date: Fri,  4 Apr 2025 20:02:09 +0800
Message-ID: <20250404120217.48772-2-xueshuai@linux.alibaba.com>
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

Memory allocated for wqs is not freed if an error occurs during
idxd_setup_wqs(). To fix it, free the allocated memory in the reverse
order of allocation before exiting the function in case of an error.

Fixes: 7c5dd23e57c1 ("dmaengine: idxd: fix wq conf_dev 'struct device' lifetime")
Fixes: 700af3a0a26c ("dmaengine: idxd: add 'struct idxd_dev' as wrapper for conf_dev")
Fixes: de5819b99489 ("dmaengine: idxd: track enabled workqueues in bitmap")
Fixes: b0325aefd398 ("dmaengine: idxd: add WQ operation cap restriction support")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 drivers/dma/idxd/init.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index fca1d2924999..80fb189c9624 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -169,8 +169,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->wq_enable_map) {
-		kfree(idxd->wqs);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_bitmap;
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
@@ -189,10 +189,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		conf_dev->bus = &dsa_bus_type;
 		conf_dev->type = &idxd_wq_device_type;
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
-		if (rc < 0) {
-			put_device(conf_dev);
+		if (rc < 0)
 			goto err;
-		}
 
 		mutex_init(&wq->wq_lock);
 		init_waitqueue_head(&wq->err_queue);
@@ -203,7 +201,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
-			put_device(conf_dev);
 			rc = -ENOMEM;
 			goto err;
 		}
@@ -211,9 +208,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
-				put_device(conf_dev);
 				rc = -ENOMEM;
-				goto err;
+				goto err_opcap_bmap;
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
@@ -224,12 +220,28 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 	return 0;
 
- err:
+err_opcap_bmap:
+	kfree(wq->wqcfg);
+
+err:
+	put_device(conf_dev);
+	kfree(wq);
+
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
+		if (idxd->hw.wq_cap.op_config)
+			bitmap_free(wq->opcap_bmap);
+		kfree(wq->wqcfg);
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
+		kfree(wq);
+
 	}
+	bitmap_free(idxd->wq_enable_map);
+
+err_bitmap:
+	kfree(idxd->wqs);
+
 	return rc;
 }
 
-- 
2.43.5


