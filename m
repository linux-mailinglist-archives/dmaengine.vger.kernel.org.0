Return-Path: <dmaengine+bounces-2175-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2FD8CF907
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 08:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED53B1C20ACA
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 06:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18827FC02;
	Mon, 27 May 2024 06:26:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E54D184E
	for <dmaengine@vger.kernel.org>; Mon, 27 May 2024 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791167; cv=none; b=nhtqyyOhcinXCwSV1d8tm65wp2l3Kic8Lg7IBkCy6JWGFGXr601sHPQQQOjIzm4+5/B9JqgX6Kx4yDm9aTVmb0ZzQZ6fJK7UgCHyDuiZxH4Z5BSkNPm64An8Zm6YixAk9kAetXMsFEIH74ug6W3P7dM8Dj1S1sE+POgSukUoUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791167; c=relaxed/simple;
	bh=9U+0lmhskMlFEImqoA7pWnnb+vkHur/ljTtC1s3mOaQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dhEEY4OhNp6WX311/1qzRSVcN+r145i0vrg4u57RdrlrUXSnpSgdtqEwJ/+TPcT5SftlAvYllR+pzzqPIi5xHZY9Bw7njuG/4fwy9q49/PEYKiVP0ayeyz9TgghfMoXtdaDFkcJ8LJ3arAuwMMGSmLQtuWoxkwNRRxJBi5w7bUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id C79747F00058;
	Mon, 27 May 2024 14:19:21 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][RFC] dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list
Date: Mon, 27 May 2024 14:19:20 +0800
Message-Id: <20240527061920.48626-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

I think when the description is freed, it maybe used again because of
race, then it's next maybe pointer a value that should not be freed

To prevent this, list_for_each_entry_safe should be used.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/dma/idxd/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 8dc029c..0c7fed7 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -611,7 +611,7 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 
 	spin_unlock(&irq_entry->list_lock);
 
-	list_for_each_entry(desc, &flist, list) {
+	list_for_each_entry_safe(desc, n, &flist, list) {
 		/*
 		 * Check against the original status as ABORT is software defined
 		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
-- 
2.9.4


