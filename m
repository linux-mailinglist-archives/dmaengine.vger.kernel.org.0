Return-Path: <dmaengine+bounces-4826-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51180A7BC3E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 14:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE2D17B836
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9871F3D21;
	Fri,  4 Apr 2025 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ikH13drN"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C61F12E7;
	Fri,  4 Apr 2025 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768156; cv=none; b=s54s/v5enkyxpIHtlm0x8FC1w8qu11c9xEAYyc7I8c+K1Cc3IXpc4H1XsiZLpPCZxYtuuujEJt0PZ8CgKQtYv9JSs62hU7QPVESpoETCJ3ASH5mPjBI0Ss+Lcfh70JXYOs3SFXNtKdc0BubEzcMtIpIMBySc2jb8g0bISmrkNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768156; c=relaxed/simple;
	bh=uSowLlD33f0Ns4kT3FjfvxpSLud2PBaZhfUCcZeFwP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbzAbLN2Cdg+IAlgmMQ5F8jkvbYbVFSPUGRLXcWO6STdUAFEPKfKqELIk1Pn9FVDxw/793+aBnUga14ZIn56svWfEHcaKRxWhxFBFOUs98iZhPvAfCxU0F2UgapctCN3g2zjnAk+hN1mDMhpJRoukzAPozW437XTZNn0ADUjIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ikH13drN; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743768144; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SxvMUKx0UtmHnSPEXCBgkqeFgDKfDwGQVwbLp687BM0=;
	b=ikH13drNsa6iNSqOBf3vIqBUIXpdDaGuN8aD+oO45dSKe4UReJMkmUEZ/P2drRtUiWKXNyGSIqyFh2hqI5hf3GSe+MhfZv9Jp9CqiZJ9w+a56NzvhSzPS426JJx+CGY5+s7NpAnBC898ZD7MC9bgyMsp0MDNZK/m858iKWdkjA4=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WUyld6F_1743768143 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Apr 2025 20:02:23 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call
Date: Fri,  4 Apr 2025 20:02:16 +0800
Message-ID: <20250404120217.48772-9-xueshuai@linux.alibaba.com>
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

The remove call stack is missing idxd cleanup to free bitmap, ida and
the idxd_device. Call idxd_free() helper routines to make sure we exit
gracefully.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Cc: stable@vger.kernel.org
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 drivers/dma/idxd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f2b5b17538c0..974b926bd930 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1335,6 +1335,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {
-- 
2.43.5


