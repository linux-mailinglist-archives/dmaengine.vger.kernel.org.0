Return-Path: <dmaengine+bounces-4823-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E4EA7BC2E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB90A7A7B39
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9CB1F12F3;
	Fri,  4 Apr 2025 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yKmuO7x4"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026A191F98;
	Fri,  4 Apr 2025 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768153; cv=none; b=fkV5yS0HiN9hLdVPdDMA6PiKVntDOdjjNuz/lO1UGo1CkPzvjcz1MVMl+D9OlkxUcYQKc44VhpGa4c3tEWd//9oF+UG1mJotg6KDkjoxCzIk3TjqGtt0/+l5xtLT9HTiOisyarPmXS9Sijz8L/dm2TNoQc+BDlrqqc1k/TcVvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768153; c=relaxed/simple;
	bh=dqDu8WL4h4bZfWHM69QQlCAdoWMi8cbOaNG41oLCUw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILI7TYHfO74gGww+L+TSzo2Gax/dubltsygcRTvGRwYKModTQQ4gOjVtCWNxdj1Xns5Ln91PyZDRng9iSzAogetlQSq51hlxgocfErP/qrWNMYhi63+e2VKfgCCOW+J/d7KZ+byctfQdS1DssdaMOI9ycTNmRcQsP5dNRApKCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yKmuO7x4; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743768144; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BF0hRp/spta9T2HH0txDA+euJMfdcZjxuSjIy5hZh2U=;
	b=yKmuO7x4uDWBRtVFiav3k9/+m09KF8/7pSJj988XW0N4GmOijoqFWGq2heLZXhfYeQsGD+caJTwmdwpPeYITRcu4lpJOs3fxBQsCOfXtPNEIdvba1zvQPguGimlogDPP514cjCuOqOO1vhJVzPGZBUxPdpysbe8YwWdhpymAy6s=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WUyld5F_1743768141 cluster:ay36)
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
Subject: [PATCH v4 5/9] dmaengine: idxd: Add missing cleanups in cleanup internals
Date: Fri,  4 Apr 2025 20:02:13 +0800
Message-ID: <20250404120217.48772-6-xueshuai@linux.alibaba.com>
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

The idxd_cleanup_internals() function only decreases the reference count
of groups, engines, and wqs but is missing the step to release memory
resources.

To fix this, use the cleanup helper to properly release the memory
resources.

Fixes: ddf742d4f3f1 ("dmaengine: idxd: Add missing cleanup for early error out in probe call")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 drivers/dma/idxd/init.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a40fb2fd5006..f8129d2d53f1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -407,14 +407,9 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 
 static void idxd_cleanup_internals(struct idxd_device *idxd)
 {
-	int i;
-
-	for (i = 0; i < idxd->max_groups; i++)
-		put_device(group_confdev(idxd->groups[i]));
-	for (i = 0; i < idxd->max_engines; i++)
-		put_device(engine_confdev(idxd->engines[i]));
-	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(wq_confdev(idxd->wqs[i]));
+	idxd_clean_groups(idxd);
+	idxd_clean_engines(idxd);
+	idxd_clean_wqs(idxd);
 	destroy_workqueue(idxd->wq);
 }
 
-- 
2.43.5


