Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4515D15914B
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2020 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgBKOBk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Feb 2020 09:01:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728295AbgBKOBj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Feb 2020 09:01:39 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B19E9F6E2C2579081B1;
        Tue, 11 Feb 2020 22:01:37 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 22:01:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: idxd: remove set but not used variable 'group'
Date:   Tue, 11 Feb 2020 21:53:35 +0800
Message-ID: <20200211135335.55924-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

drivers/dma/idxd/sysfs.c: In function engine_group_id_store:
drivers/dma/idxd/sysfs.c:419:29: warning: variable group set but not used [-Wunused-but-set-variable]

It is not used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/idxd/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6d907fe..e4f35bd 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -416,7 +416,7 @@ static ssize_t engine_group_id_store(struct device *dev,
 	struct idxd_device *idxd = engine->idxd;
 	long id;
 	int rc;
-	struct idxd_group *prevg, *group;
+	struct idxd_group *prevg;
 
 	rc = kstrtol(buf, 10, &id);
 	if (rc < 0)
@@ -436,7 +436,6 @@ static ssize_t engine_group_id_store(struct device *dev,
 		return count;
 	}
 
-	group = &idxd->groups[id];
 	prevg = engine->group;
 
 	if (prevg)
-- 
2.7.4


