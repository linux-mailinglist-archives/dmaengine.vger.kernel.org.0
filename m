Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0987399B64
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 09:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFCHVv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 03:21:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3522 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCHVv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 03:21:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwcfR4pbNzYnBL;
        Thu,  3 Jun 2021 15:17:19 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 15:20:04 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 15:20:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
CC:     <vkoul@kernel.org>
Subject: [PATCH -next v2] dma: ipu: fix doc warning in ipu_irq.c
Date:   Thu, 3 Jun 2021 15:24:25 +0800
Message-ID: <20210603072425.2973570-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix the following make W=1 warning and correct description:

  drivers/dma/ipu/ipu_irq.c:238: warning: expecting prototype for ipu_irq_map(). Prototype was for ipu_irq_unmap() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/dma/ipu/ipu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
index 0d5c42f7bfa4..97d9a6f04f2a 100644
--- a/drivers/dma/ipu/ipu_irq.c
+++ b/drivers/dma/ipu/ipu_irq.c
@@ -230,7 +230,7 @@ int ipu_irq_map(unsigned int source)
 }
 
 /**
- * ipu_irq_map() - map an IPU interrupt source to an IRQ number
+ * ipu_irq_unmap() - unmap an IPU interrupt source
  * @source:	interrupt source bit position (see ipu_irq_map())
  * @return:	0 or negative error code
  */
-- 
2.25.1

