Return-Path: <dmaengine+bounces-4662-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1CAA5810A
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 07:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED320188B986
	for <lists+dmaengine@lfdr.de>; Sun,  9 Mar 2025 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE0516D9AF;
	Sun,  9 Mar 2025 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HlCtyDza"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9C14A639;
	Sun,  9 Mar 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741501273; cv=none; b=UI63teY1vw3Ot9nJZPgKxwyrAXPoYY5AMWNiPi89T94am/Kze6B/gabYiJ4q2STC22KIZSNpQlJfw+qKdYeXBiCxOPKy+wvelr8zWu/Rjf7klRVWSWejc3aylaMU6ma83/OWmuyhHQcx9pCwWvGy5VtK0arPVIK6566V2H2b1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741501273; c=relaxed/simple;
	bh=4CbiqQNRnrQdmHO55TWzXPEDMLl29lD553RWhVtfw9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/7vytMW191xMXb5GTVfwbi4a8i+4aa5ZeD3oUSX87r/2Bsh3ICmA+hJuXctSG9aJwZ0c19BiM4YTOcnE5vif18LPx1h45YgTLr4PrdXnYlPfXmOYg2TNnuc8jSmjAKljDfJU7gHDd6JvmBAwf3Re4fNvsqXNmteibVf6GjVZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HlCtyDza; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741501262; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+bvzo0ZO4+s6B1eaNsXnCqwubGCp+6w4TgJqDRVFlBE=;
	b=HlCtyDzax3YGNh0QCiXaWmB+FxWk5GmKqEPSrZbeqnErCKweWD19zWtN+bMDJKP1/xeiz6JRs+E9Nx5wYipQyp9N4nD5IrXV8enuMOqmQmGudAdXgmiQrzh0o9LeARpAIHzaTvMD+7aW5/fBgKhbWZC9zSeb8txvuKuuSgKk6Us=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQwVyj1_1741501261 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 09 Mar 2025 14:21:01 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	Markus.Elfring@web.de,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups
Date: Sun,  9 Mar 2025 14:20:52 +0800
Message-ID: <20250309062058.58910-4-xueshuai@linux.alibaba.com>
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

Memory allocated for groups is not freed if an error occurs during
idxd_setup_groups(). To fix it, free the allocated memory in the reverse
order of allocation before exiting the function in case of an error.

Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 635838a81e0f..fe4a14813bba 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -326,6 +326,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(group);
 			goto err;
 		}
 
@@ -350,7 +351,10 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 	while (--i >= 0) {
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
+		kfree(group);
 	}
+	kfree(idxd->groups);
+
 	return rc;
 }
 
-- 
2.39.3


