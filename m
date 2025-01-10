Return-Path: <dmaengine+bounces-4094-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6784CA089DD
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 09:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7145616663A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2025 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D638207E10;
	Fri, 10 Jan 2025 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mbpm4XNn"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93418F54;
	Fri, 10 Jan 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497366; cv=none; b=hLYQDrPuqcdfmP5hNbA+XfoOylMD3J/oCYifDqH+6XqPvdZd5EEf/JB6LrvTWnbiYZ+P0C5SqqCzeDMW8s2tYFz5UHyTBHAdEOUX6/keI/Hw1wVs3mcOUA0nTInXI12vuZOerdcKOAfA8CgdGi+YI7ze++mCd/4AT2jvkv/+h24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497366; c=relaxed/simple;
	bh=IElGyJw+SrDCt/hiQANTJdV06h4bSsP3ho0A9Vq4IBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys1BwvbCGoY3PYcdcgyVsKjgkM1kQG/DjZYLZTyHCcICPrkiFeLnhPVrB5id6gpyJeUYvRUPRDVpOe1o4g7tiDQnP9AkwokEga8hE1Y+VFk7RJRdiJMn4A/ghufkfrWkaixHmL2eS1pBug/xQ9nrsnZn/n770MDNB9lb0X5au7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mbpm4XNn; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736497360; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=87EsWey0RhJOOSVtnxQRiNfjF2nSIAafUIVDhuFBxbM=;
	b=mbpm4XNno77pBt4HqHrR/+zSU94iKFxLVnzT58pslPT88AdahfWOCf+Stc6lMnC1ZvfXWARfhSananDMeXroVAcYVKWmR6KN1ZVxO51rUWLVytCcBSYsZxrSpEFohiKhRzD+OE9Vnde4QpKDN3ETwGGmik2UwTVLkWyitEDLhfU=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNKKAxX_1736497359 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jan 2025 16:22:39 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs
Date: Fri, 10 Jan 2025 16:22:33 +0800
Message-ID: <20250110082237.21135-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
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

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/init.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 234c1c658ec7..6772d9251cd7 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -167,8 +167,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->wq_enable_map) {
-		kfree(idxd->wqs);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_bitmap;
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
@@ -189,6 +189,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(wq);
 			goto err;
 		}
 
@@ -202,6 +203,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
 			put_device(conf_dev);
+			kfree(wq);
 			rc = -ENOMEM;
 			goto err;
 		}
@@ -209,7 +211,9 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
+				kfree(wq->wqcfg);
 				put_device(conf_dev);
+				kfree(wq);
 				rc = -ENOMEM;
 				goto err;
 			}
@@ -223,11 +227,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	return 0;
 
  err:
-	while (--i >= 0) {
+	while (i-- > 0) {
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
2.39.3


