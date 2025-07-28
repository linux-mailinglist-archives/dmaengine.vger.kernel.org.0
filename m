Return-Path: <dmaengine+bounces-5874-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC5B139CD
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 13:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3484A188FF89
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD94225BEFD;
	Mon, 28 Jul 2025 11:23:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5861DB125;
	Mon, 28 Jul 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701820; cv=none; b=GUXz8YICQpDfBArS7pfmV2doMgc7pXxrnR6fPuzcNIseyuCbWdB2lYhdyE5IsrQ7U7PWGM5Mo0iV4PlRoL4F4tjLuyIVscTiTSa6pzJJHFXjed7tpLBFQrctvKX/fCMzri9Q8w+5kcMH2ROAUM70T5iesRpcysBzg56xQE26eMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701820; c=relaxed/simple;
	bh=bPjTWwaYcYGFnl+LXKUqClUFdbY1il0+wZRkk8mi2EI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VwRNswemToxcorFHNc44ngpoeyNeCuwmQv+B+c4XWWfgzQKbkZzvWug/G8pGQAwl1TGFUE472zqWvB/ydXk2PlohtFpkQ91Iz5vl1lw1ykV7TIFNXzUJbz+FMJq3WZNjwlgUKN++B/i9oUEWCEvnwEae/xwJ5A7NRwjVlg4C0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4brGFF2QGNz14M34;
	Mon, 28 Jul 2025 19:18:41 +0800 (CST)
Received: from kwepemp200005.china.huawei.com (unknown [7.202.195.96])
	by mail.maildlp.com (Postfix) with ESMTPS id 892A4180B52;
	Mon, 28 Jul 2025 19:23:33 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 kwepemp200005.china.huawei.com (7.202.195.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 19:23:32 +0800
From: Ziming Du <duziming2@huawei.com>
To: <dmaengine@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
	<dave.jiang@intel.com>, <vinicius.gomes@intel.com>,
	<liuyongqiang13@huawei.com>
Subject: [PATCH next] dmaengine: idxd: init: Fix uninitialized use of conf_dev in  idxd_setup_wqs()
Date: Mon, 28 Jul 2025 19:51:28 +0800
Message-ID: <20250728115128.50889-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemp200005.china.huawei.com (7.202.195.96)

Fix Smatch-detected issue:
drivers/dma/idxd/init.c:246 idxd_setup_wqs() error:
uninitialized symbol'conf_dev'

'conf_dev' may be used uninitialized in error handling paths.
Specifically, if the memory allocation for 'wq' fails, the code
jumps to 'err', and attempt to call put_device(conf_dev), without
ensuring that conf_dev has been properly initialized.

Fix it by initializing conf_dev to NULL at declaration.

Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/dma/idxd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 35bdefd3728b..2b61f26af1f6 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -178,7 +178,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_wq *wq;
-	struct device *conf_dev;
+	struct device *conf_dev = NULL;
 	int i, rc;
 
 	idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
-- 
2.43.0


