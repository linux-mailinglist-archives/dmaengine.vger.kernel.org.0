Return-Path: <dmaengine+bounces-5324-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE29AD0B2B
	for <lists+dmaengine@lfdr.de>; Sat,  7 Jun 2025 05:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCF81890F99
	for <lists+dmaengine@lfdr.de>; Sat,  7 Jun 2025 03:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952551B043C;
	Sat,  7 Jun 2025 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RZxSqWRB"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C38152E02;
	Sat,  7 Jun 2025 03:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749268266; cv=none; b=ujvuN0KTVT7Y+JNHBVPPdn2VMyxpzOQdnTKMjCfIWYg6+WzTtgVm5bJaiiG9CPyLGdtWKYsQKfMveY14/OnLkD9ZN3vIwuesb7ir4f2ajJScA8U3X6f37jvDvXcYQclC3xl8CYkXEec22nAnFh2WG9m9YXUyvXZmNla0Smdt7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749268266; c=relaxed/simple;
	bh=TO39zRfkdJpwBMKGG9fkZahw7ixJbcoLpDCi/C9QEYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTF/FB0xrleZx5eJION2Ag+AfUoYwi3oWVp9rNbgvUl7debyQHWUf+kAsRAc+wGh7/QUORGMxh29S/x0rAXb5Cs4iNCa4pt2ZViBi4dN7GHwq9vLAozqgAxJ6HUh59uWgMbEUgpFB/O+V0aYwum1W2xq0eraE6HBo2/FT2DcQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RZxSqWRB; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749268255; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mH/4mZprVQCWqhuJFYNdxPlXR2Cnoux70JmvcnxqCBI=;
	b=RZxSqWRBGXd/2TqBFmMoxadO75pb18f+yfqXrwtOB5aQfYV3KebqdzU6zprqXxaE87slIvnzUMVkHb80Z7c9wbxlQEhL9htzgv7QjBTbcHPPFjrlYeoHL+OBYwOPldSlIlGaTcZSYHRGKfFnIsluMRW2dXnw5SIj+xf17rU1dC4=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WdE2yr2_1749267933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Jun 2025 11:45:34 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	colin.i.king@gmail.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org
Subject: [PATCH v2] dmaengine: idxd: fix potential NULL pointer dereference on wq setup error path
Date: Sat,  7 Jun 2025 11:45:32 +0800
Message-ID: <20250607034532.92512-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
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
Closes: https://lore.kernel.org/dmaengine/aDQt3_rZjX-VuHJW@stanley.mountain
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
changes since v1: 
- add Reviewed-by tag from Dave Jiang
- add Reported-by tag from Dan Carpenter and its Closes link
---
 drivers/dma/idxd/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 80355d03004d..a818d4799770 100644
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


