Return-Path: <dmaengine+bounces-4824-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B97A7BC34
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41061B6061D
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E81E0083;
	Fri,  4 Apr 2025 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mElQKUG2"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F391EFF90;
	Fri,  4 Apr 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768154; cv=none; b=Uwt2XxrBntChqtNrulMLguU6VaZWCUiYvAEY4G6/EbaODJ4oW92LBV5EdPYCb7AzVjbu+PFPh9PNei/p9sq20E0ULK+/LqpRCAdv3PO9pJOi4XC7STYwzRKc7/SARr8feHagFaEOOUiKdmBrwqGnUGTH1cuHi9X5Fb8glh4p1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768154; c=relaxed/simple;
	bh=d+jJYEEXvfxCfqpIfgEm+Tabi8hXYp5Fahd6eIu8Upw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQCnW1tnyR7faE7b+EIeZHgGIrWPltmGEDkA4AJUj8tgTIRh5HpHATE1TeqjgmuEmnO6w4JFfuIUDB6dJ78u5M0mYjK3F+lj6AE1WnsG0Ly+TAeS2h5p9tmm/y7Xet2k1da/CJgY8jvKwmtKwrEZ33NHCCHKHPPDn0W31pdYhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mElQKUG2; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743768141; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XJ01F+rqnhGV29oO2n8+5TyMDaDIvW//7qhuHE1yXcc=;
	b=mElQKUG2TjN7SyihbaU+/s1lK4AgDGxfrCQxuE5psxWTtW/uxa8qcNo4aauN8xZ99gTPERWgDPJuUszk8BFXW8Bl7PExk3KNEZm6JHVhmz+FU/nu95Nj4LpygJizRvp6TTm0RfrjkaXKsZShjNptWcLmWRVqbHFkIBpJfjQfMpg=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WUyld4S_1743768140 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Apr 2025 20:02:20 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/9] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups
Date: Fri,  4 Apr 2025 20:02:11 +0800
Message-ID: <20250404120217.48772-4-xueshuai@linux.alibaba.com>
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

Memory allocated for groups is not freed if an error occurs during
idxd_setup_groups(). To fix it, free the allocated memory in the reverse
order of allocation before exiting the function in case of an error.

Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 drivers/dma/idxd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index ff6ec3c0f604..7f0a26e2e0a5 100644
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
2.43.5


