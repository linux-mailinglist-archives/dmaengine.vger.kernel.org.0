Return-Path: <dmaengine+bounces-4492-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF4A36C30
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 06:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671C43AAAA9
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 05:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2296E19ABD8;
	Sat, 15 Feb 2025 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d6ELRKUe"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98217799F;
	Sat, 15 Feb 2025 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739598283; cv=none; b=ZoTcBbbGh7KsKPMhNGRAmbN0oBvYtPmJEwmelIy1CIduixoqk97SE/Eri/1TNdPxtY6QSZgmhuzb+QadFXeUSZnNcV4APqqNLfjcUfXdfOs+OGMVmmQJvSxhNXmM6lip3XKukGhJhvGrdXzr44lJylo7gVo8dkpp/2ZCQ5eK6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739598283; c=relaxed/simple;
	bh=yo7qlUaeF3xO9z4Scj60HtMY12AAzelde4yE32W+jFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mE2JPaaABfIAlwpvlVXUL5NDkP97ZTq9uNcTm2rwBzqRxLmptM/TBCOC/MY+X82794lCOC4LxvessdNfk+HgYO07PKh1Jm9+ANbceFEHAZqjqV3qAmkPYQRvdXUW5p8D0AlYWfPmr7RKrXjO06P9e6t1FC4Dk422PzZbXHIFxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d6ELRKUe; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739598277; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ca7xZlMAPEYMN9D4MiMu30TtHiCMTqjknr5SucAhlr8=;
	b=d6ELRKUecePhOPnkn/QCBeBJgispvx+uBu+JgDGxNtEnKx4cExanya43bR3DJfVjcBm9Y+p9UjYVAdf8H+4NZVkzEUnF6AKm031EQ3EFZhtv85v5XCuirxTrUgkqgiZugnpYRcNpPIP/durXAZsMRa4u+yxd+KbjekCt0jF4QGQ=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPSysOL_1739598276 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 13:44:36 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: nikhil.rao@intel.com,
	xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call
Date: Sat, 15 Feb 2025 13:44:30 +0800
Message-ID: <20250215054431.55747-7-xueshuai@linux.alibaba.com>
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

The remove call stack is missing idxd cleanup to free bitmap, ida and
the idxd_device. Call idxd_free() helper routines to make sure we exit
gracefully.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index ac1cdc1d82bf..f40f1c44a302 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1295,7 +1295,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
-	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {
-- 
2.39.3


