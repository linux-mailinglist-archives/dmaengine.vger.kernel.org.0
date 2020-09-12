Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE84267883
	for <lists+dmaengine@lfdr.de>; Sat, 12 Sep 2020 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgILHWs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Sep 2020 03:22:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbgILHWq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 12 Sep 2020 03:22:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 110BE934AD00487DC4C8;
        Sat, 12 Sep 2020 15:22:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sat, 12 Sep 2020
 15:22:38 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <dave.jiang@intel.com>, <Leonid.Ravich@emc.com>,
        <dmaengine@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] dmaengine: ioat: Make two symbols static
Date:   Sat, 12 Sep 2020 15:21:58 +0800
Message-ID: <20200912072158.602585-1-yanaijie@huawei.com>
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

This eliminates the following sparse warning:

drivers/dma/ioat/dma.c:29:5: warning: symbol 'completion_timeout' was
not declared. Should it be static?
drivers/dma/ioat/dma.c:33:5: warning: symbol 'idle_timeout' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/dma/ioat/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index a814b200299b..8cce4e059b7a 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -26,11 +26,11 @@
 
 #include "../dmaengine.h"
 
-int completion_timeout = 200;
+static int completion_timeout = 200;
 module_param(completion_timeout, int, 0644);
 MODULE_PARM_DESC(completion_timeout,
 		"set ioat completion timeout [msec] (default 200 [msec])");
-int idle_timeout = 2000;
+static int idle_timeout = 2000;
 module_param(idle_timeout, int, 0644);
 MODULE_PARM_DESC(idle_timeout,
 		"set ioat idel timeout [msec] (default 2000 [msec])");
-- 
2.25.4

