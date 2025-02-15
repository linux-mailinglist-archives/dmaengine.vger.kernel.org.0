Return-Path: <dmaengine+bounces-4489-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA1A36C2B
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 06:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9723C7A4E64
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 05:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C7518CBFB;
	Sat, 15 Feb 2025 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g16/x57e"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF61624D9;
	Sat, 15 Feb 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739598281; cv=none; b=OJpDwxNOvbz76A5tQSReQkSzUTkbWFHct3x0ZDEYMGuPQzNDD0o0yzft7jX/uf5/hSukaIzVm2W2675k2SmcFhMThYmU4S6fP53SwzPt/X1dUUXqdmIMYWmchxojW8tV0yjUxWeWQbWSCVPAZHav4ABrJKwrpMrp9hYSXfMPsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739598281; c=relaxed/simple;
	bh=jBt7+vnJjRgzyW+ey5C4tsfMOJ85XpSkNkkXKzASRZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCjGTbsFKxIb+3YGm5ZJCYhovzJJF7EzPFcI4DH09Zh6MIZxgJ45PDFwCXMqpQ/NjBEdsqWdU9I6Q1I1T+YcPXbC33rbFmJQilkSOrFnsr9WLADXyovrOeuUEU3JOskWU2xu4YsP86XEgSWyj1ToaPNGrXuuTia7cVKbWiBWmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g16/x57e; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739598274; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6mzodyOusN1fygK0BoeX0n09AD6gHWxROo2RlbkTXbE=;
	b=g16/x57erEKylUg/onc05qSlbJb7zU4YEGD+dVj2csSvkN5dDOlYR46f1wbcN68Nu2ICV0SEw8pXsWXSpa+Uqp5EZg2EYKh09dp8jSDrgsZRlhSkCwsIbZRpFLor+7WHDJipQWcQr1mzXAuEiMgOn6aB2psTaWNLC6Y2sWHitUw=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPSysNU_1739598273 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 13:44:33 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: nikhil.rao@intel.com,
	xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs
Date: Sat, 15 Feb 2025 13:44:25 +0800
Message-ID: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
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

Memory allocated for wqs is not freed if an error occurs during
idxd_setup_wqs(). To fix it, free the allocated memory in the reverse
order of allocation before exiting the function in case of an error.

Fixes: a8563a33a5e2 ("dmanegine: idxd: reformat opcap output to match bitmap_parse() input")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index b946f78f85e1..b85736fd25bd 100644
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
@@ -191,6 +191,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(wq);
 			goto err;
 		}
 
@@ -204,6 +205,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
 			put_device(conf_dev);
+			kfree(wq);
 			rc = -ENOMEM;
 			goto err;
 		}
@@ -211,7 +213,9 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
+				kfree(wq->wqcfg);
 				put_device(conf_dev);
+				kfree(wq);
 				rc = -ENOMEM;
 				goto err;
 			}
@@ -225,11 +229,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
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


