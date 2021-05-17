Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E699382658
	for <lists+dmaengine@lfdr.de>; Mon, 17 May 2021 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhEQIMV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 May 2021 04:12:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3779 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbhEQIMT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 May 2021 04:12:19 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkBZG4MSYzmjG0;
        Mon, 17 May 2021 16:07:34 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:11:01 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 16:11:01 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <vkoul@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 3/3] dmaengine: zynqmp_dma: Fix PM reference leak in zynqmp_dma_alloc_chan_resourc()
Date:   Mon, 17 May 2021 16:18:26 +0800
Message-ID: <20210517081826.1564698-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210517081826.1564698-1-yukuai3@huawei.com>
References: <20210517081826.1564698-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
Fix it by replacing it with pm_runtime_resume_and_get to keep usage
counter balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index d8419565b92c..5fecf5aa6e85 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -468,7 +468,7 @@ static int zynqmp_dma_alloc_chan_resources(struct dma_chan *dchan)
 	struct zynqmp_dma_desc_sw *desc;
 	int i, ret;
 
-	ret = pm_runtime_get_sync(chan->dev);
+	ret = pm_runtime_resume_and_get(chan->dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.4

