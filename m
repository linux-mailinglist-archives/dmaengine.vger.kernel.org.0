Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027AE231E8E
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jul 2020 14:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG2MaA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jul 2020 08:30:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57006 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgG2M37 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Jul 2020 08:29:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0093AEF0BE9D4ACCC48C;
        Wed, 29 Jul 2020 20:29:53 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Jul 2020
 20:29:45 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <anup.patel@broadcom.com>, <ray.jui@broadcom.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] dmaengine: bcm-sba-raid: add missing put_device() call in sba_probe()
Date:   Wed, 29 Jul 2020 20:30:02 +0800
Message-ID: <20200729123002.2476320-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

if of_find_device_by_node() succeed, sba_probe() doesn't have a
corresponding put_device(). Thus add a jump target to fix the
exception handling for this function implementation.

Fixes: 743e1c8ffe4e ("dmaengine: Add Broadcom SBA RAID driver")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/dma/bcm-sba-raid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 64239da02e74..322d48b397e7 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -1707,7 +1707,7 @@ static int sba_probe(struct platform_device *pdev)
 	/* Prealloc channel resource */
 	ret = sba_prealloc_channel_resources(sba);
 	if (ret)
-		goto fail_free_mchan;
+		goto put_device;
 
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())
@@ -1737,6 +1737,8 @@ static int sba_probe(struct platform_device *pdev)
 fail_free_resources:
 	debugfs_remove_recursive(sba->root);
 	sba_freeup_channel_resources(sba);
+put_device:
+	put_device(&)
 fail_free_mchan:
 	mbox_free_channel(sba->mchan);
 	return ret;
-- 
2.25.4

