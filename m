Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038F82DE13B
	for <lists+dmaengine@lfdr.de>; Fri, 18 Dec 2020 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733172AbgLRKmd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Dec 2020 05:42:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9631 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgLRKmc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Dec 2020 05:42:32 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cy54j4mVcz15Zdt;
        Fri, 18 Dec 2020 18:41:09 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 18 Dec 2020 18:41:41 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH] dma/qcom/gpi: Fixes a format mismatch
Date:   Fri, 18 Dec 2020 18:41:37 +0800
Message-ID: <20201218104137.59200-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

drivers/dma/qcom/gpi.c:1419:3: warning: format '%lu' expects argument of
 type 'long unsigned int', but argument 8 has type 'size_t {aka unsigned
 int}' [-Wformat=]
drivers/dma/qcom/gpi.c:1427:31: warning: format '%lu' expects argument of
 type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned
 int}' [-Wformat=]
drivers/dma/qcom/gpi.c:1447:3: warning: format '%llx' expects argument of
 type 'long long unsigned int', but argument 4 has type 'dma_addr_t {aka
 unsigned int}' [-Wformat=]
drivers/dma/qcom/gpi.c:1447:3: warning: format '%llx' expects argument of
 type 'long long unsigned int', but argument 5 has type 'phys_addr_t {aka
 unsigned int}' [-Wformat=]

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 drivers/dma/qcom/gpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index d2334f535de2..556c070a514c 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1416,7 +1416,7 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
 	len = 1 << bit;
 	ring->alloc_size = (len + (len - 1));
 	dev_dbg(gpii->gpi_dev->dev,
-		"#el:%u el_size:%u len:%u actual_len:%llu alloc_size:%lu\n",
+		"#el:%u el_size:%u len:%u actual_len:%llu alloc_size:%zu\n",
 		  elements, el_size, (elements * el_size), len,
 		  ring->alloc_size);
 
@@ -1424,7 +1424,7 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
 					       ring->alloc_size,
 					       &ring->dma_handle, GFP_KERNEL);
 	if (!ring->pre_aligned) {
-		dev_err(gpii->gpi_dev->dev, "could not alloc size:%lu mem for ring\n",
+		dev_err(gpii->gpi_dev->dev, "could not alloc size:%zu mem for ring\n",
 			ring->alloc_size);
 		return -ENOMEM;
 	}
@@ -1444,8 +1444,8 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
 	smp_wmb();
 
 	dev_dbg(gpii->gpi_dev->dev,
-		"phy_pre:0x%0llx phy_alig:0x%0llx len:%u el_size:%u elements:%u\n",
-		ring->dma_handle, ring->phys_addr, ring->len,
+		"phy_pre:%pad phy_alig:%pa len:%u el_size:%u elements:%u\n",
+		&ring->dma_handle, &ring->phys_addr, ring->len,
 		ring->el_size, ring->elements);
 
 	return 0;
-- 
2.27.0

