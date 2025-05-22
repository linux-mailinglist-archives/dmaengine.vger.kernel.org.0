Return-Path: <dmaengine+bounces-5246-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646DFAC04B8
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 08:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59C61BC0FD3
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002214831E;
	Thu, 22 May 2025 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m0ALHT/R"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20F846F;
	Thu, 22 May 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895942; cv=none; b=M6VvVhb0u0/LlgkaSq1+pDYarvpTQtpUN4W4tE7ZKQWLQze1i0QiwDc7O8KXuPdrgcZLRDdgBoDPzyo/xOJeg+aC5b+v0fNGuoDL3q+nCumMfMSFq0LoAe7JanCM8hhyBmiiQzAt9e9vWlPGgwoLtF3zvDTGK2xLC1LAg3V6dYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895942; c=relaxed/simple;
	bh=Lxxydbs1YWlTQwA1t3ZFiK5gpCrcOrNoISTsj/cLPi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG5vjHc5HfrvwJlqDe9wL6MoBo6u8BWqYEeVwGZHwe+bXLmVK+DONhVyUqYY91v1RyTp1tJ2+/JA8Yb/nphvCPdtyQSxpMfFIvremyR1FuVw5r60lra+z+ZlXASMWAFa86hCAVK6Nq5WrVskuJgeC7lsOsLoQ3oRPhV1WqyyyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m0ALHT/R; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747895935; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=35xG/OL7cebb121Ga2sJIWpP9JWzw+MoYXEapkoiMN8=;
	b=m0ALHT/RixzTYnd0+mgcKpmrJkMCP2rZNCxhXfWqPuGMr94FVrHh4i+RVc0S5VKdd/dDWycX5nUdRJnyiYuamEsYwAq2syY871SQXAtMm2CjYLWnSjy5xMVfKmyD0096nPomlRdw0G+WlXbKWMPljhoQ+2Gd6dExV231ODkVLNA=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WbUiQNi_1747895613 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 14:33:33 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	colin.i.king@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dmaengine: idxd: fix potential NULL pointer dereference on wq setup error path
Date: Thu, 22 May 2025 14:33:29 +0800
Message-ID: <20250522063329.51156-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
References: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If wq allocation fails during the initial iteration of the loop,
`conf_dev` is still NULL.  However, the existing error handling via
`goto err` would attempt to call `put_device(conf_dev)`, leading to a
NULL pointer dereference.

This issue occurs because there's no dedicated error label for the WQ
allocation failure case, causing it to fall through to an incorrect
error path.

Fix this by introducing a new error label `err_wq`, ensuring that we
only invoke `put_device(conf_dev)` when `conf_dev` is valid.

Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")
Cc: stable@vger.kernel.org
Reported-by: Colin King <colin.i.king@gmail.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 760b7d81fcd8..bf57ad30d613 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -196,7 +196,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
 		if (!wq) {
 			rc = -ENOMEM;
-			goto err;
+			goto err_wq;
 		}
 
 		idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
@@ -246,6 +246,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	put_device(conf_dev);
 	kfree(wq);
 
+err_wq:
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
 		if (idxd->hw.wq_cap.op_config)
-- 
2.43.5


