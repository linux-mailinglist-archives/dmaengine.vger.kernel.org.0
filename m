Return-Path: <dmaengine+bounces-308-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E217FD171
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 09:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258921C20F2E
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 08:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADFA12B74;
	Wed, 29 Nov 2023 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6923DAF
	for <dmaengine@vger.kernel.org>; Wed, 29 Nov 2023 00:55:58 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SgCpd2H0Vz4f3l1w
	for <dmaengine@vger.kernel.org>; Wed, 29 Nov 2023 16:55:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4392A1A089F
	for <dmaengine@vger.kernel.org>; Wed, 29 Nov 2023 16:55:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxGV_GZlHhEBCQ--.28112S4;
	Wed, 29 Nov 2023 16:55:55 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: dmaengine@vger.kernel.org,
	imx@lists.linux.dev
Cc: Frank.Li@nxp.com,
	vkoul@kernel.org,
	yangyingliang@huawei.com
Subject: [PATCH] dmaengine: fsl-edma: fix wrong pointer check in fsl_edma3_attach_pd()
Date: Wed, 29 Nov 2023 17:00:00 +0800
Message-Id: <20231129090000.841440-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxGV_GZlHhEBCQ--.28112S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW7Xry8Kr1kCw4rCw1fXrb_yoWDCrg_JF
	1rZrW7uryktF1ayr1Ykw47ZrZ5ZrWj939a9w1vy34fJFy5Zw1fXrWktr1Yvr17XFW29FyU
	WF1kZr1ruFySkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbr8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WF
	yUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUzeOJUUUUU
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

device_link_add() returns NULL pointer not PTR_ERR() when it fails,
so replace the IS_ERR() check with NULL pointer check.

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/dma/fsl-edma-main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index aea7a703dda7..238a69bd0d6f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -396,9 +396,8 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 		link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
 					     DL_FLAG_PM_RUNTIME |
 					     DL_FLAG_RPM_ACTIVE);
-		if (IS_ERR(link)) {
-			dev_err(dev, "Failed to add device_link to %d: %ld\n", i,
-				PTR_ERR(link));
+		if (!link) {
+			dev_err(dev, "Failed to add device_link to %d\n", i);
 			return -EINVAL;
 		}
 
-- 
2.25.1


