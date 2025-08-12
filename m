Return-Path: <dmaengine+bounces-5997-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 222ADB21AF4
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 04:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A371906E74
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D020F07C;
	Tue, 12 Aug 2025 02:50:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB526AE4;
	Tue, 12 Aug 2025 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967047; cv=none; b=f+96pg772iecB2KUGj9trJcSJgFyjjfigoYTWcipQh+uN0uhmgiXAoUFjMFMp7xhjq9dCSIVhnVRf9HBnhh+vPqzlPH4wm0ofkKwK0pLgHc7NP/+2dQ5T/7toYtIQURY04gWYxrZFP86kDzkvcswiS3cJmXBI6FLOi8pde5iEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967047; c=relaxed/simple;
	bh=M9fHa2s/+Jjv+dUhSxNAbBUSjoWV2zNpTjBRnXpsbJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IXaNbKsFkPHynw8EE6Uy800/SB5cePyY3uCu6qrc727N4O0ryUz9VdRATIq/hX7HbXkvNaf1KL4DlN3QDK/Y3K9JFUM78ZAlXDNg+ncUk7t29QcFzAZHgiUs3J5qfruj9njdbpg9iyYL97BUVoGv1vSrJvnIPHz8NrtbtgWJ/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c1G9C3LYZz2Cfyc;
	Tue, 12 Aug 2025 10:46:23 +0800 (CST)
Received: from kwepemp200005.china.huawei.com (unknown [7.202.195.96])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A1EF1A0188;
	Tue, 12 Aug 2025 10:50:42 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 kwepemp200005.china.huawei.com (7.202.195.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 10:50:41 +0800
From: Ziming Du <duziming2@huawei.com>
To: <dmaengine@vger.kernel.org>
CC: <duziming2@huawei.com>, <liuyongqiang13@huawei.com>,
	<xueshuai@linux.alibaba.com>, <fenghuay@nvidia.com>, <vkoul@kernel.org>,
	<dave.jiang@intel.com>, <vinicius.gomes@intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dmaengine: idxd: init: Fix uninitialized use of conf_dev in  idxd_setup_wqs()
Date: Tue, 12 Aug 2025 11:18:11 +0800
Message-ID: <20250812031811.1602950-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp200005.china.huawei.com (7.202.195.96)

Fix Smatch-detected issue:
drivers/dma/idxd/init.c:246 idxd_setup_wqs() error:
uninitialized symbol'conf_dev'

'conf_dev' may be used uninitialized in error handling paths.
Specifically, if the memory allocation for 'wq' fails, the code
jumps to 'err', and attempt to call put_device(conf_dev), without
ensuring that conf_dev has been properly initialized.

Fix it by initializing conf_dev to NULL at declaration.
Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")
Signed-off-by: Ziming Du <duziming2@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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


