Return-Path: <dmaengine+bounces-5873-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B1B139AD
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 13:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFB2188566F
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C1B248861;
	Mon, 28 Jul 2025 11:08:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC58C42A82;
	Mon, 28 Jul 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700923; cv=none; b=IAUAzpdaBcwI0nL2SyBWBUr3XWYwIzxU0cRHlLFEY1s4rXXzHeMG2cNjPhMkq6yY1xBM1sWJjPgjOVKObf5oOPu3eQDcpZiR9VEYIQ58ommSRqTB/7efG1nOz6HksGkAeyR54RgS7+WSvA3nqIZknlwPc2h2aa4qwbyFES5QAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700923; c=relaxed/simple;
	bh=bPjTWwaYcYGFnl+LXKUqClUFdbY1il0+wZRkk8mi2EI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uqEhofElN7pSvMJ5AWc5fOs5en87LEQT2WXGdcCuE9F5W9r/NpTGtdJlunrZekjgjkvbehygA2Wp6weXxZmhexqzHqQik/pcx+kMha9QDwGxUMtiWsVJEmWwn4tns+udQn2dkYzzEZ9chEM7IgK34C03yb0ey/K8VqK3tjPbODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4brFwn150dzdc7H;
	Mon, 28 Jul 2025 19:04:25 +0800 (CST)
Received: from kwepemp200005.china.huawei.com (unknown [7.202.195.96])
	by mail.maildlp.com (Postfix) with ESMTPS id C89821800B2;
	Mon, 28 Jul 2025 19:08:37 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 kwepemp200005.china.huawei.com (7.202.195.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 19:08:37 +0800
From: Ziming Du <duziming2@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <dmaengine@vger.kernel.org>, <vkoul@kernel.org>, <dave.jiang@intel.com>,
	<vinicius.gomes@intel.com>, <liuyongqiang13@huawei.com>
Subject: [PATCH next] dmaengine: idxd: init: Fix uninitialized use of conf_dev in  idxd_setup_wqs()
Date: Mon, 28 Jul 2025 19:36:32 +0800
Message-ID: <20250728113632.50805-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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


