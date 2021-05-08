Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76192376F08
	for <lists+dmaengine@lfdr.de>; Sat,  8 May 2021 05:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhEHDC3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 May 2021 23:02:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17479 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHDC3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 May 2021 23:02:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FcX884xLHzkX9N;
        Sat,  8 May 2021 10:58:48 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 11:01:16 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Vinod Koul <vkoul@kernel.org>, Peng Ma <peng.ma@nxp.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] dmaengine: fsl-dpaa2-qdma: Fix error return code in two functions
Date:   Sat, 8 May 2021 11:00:56 +0800
Message-ID: <20210508030056.2027-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in the function where it is.

Fixes: 7fdf9b05c73b ("dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA controller driver for Layerscape SoCs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 4ec909e0b810..4ae057922ef1 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -332,6 +332,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 	}
 
 	if (priv->dpdmai_attr.version.major > DPDMAI_VER_MAJOR) {
+		err = -EINVAL;
 		dev_err(dev, "DPDMAI major version mismatch\n"
 			     "Found %u.%u, supported version is %u.%u\n",
 				priv->dpdmai_attr.version.major,
@@ -341,6 +342,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 	}
 
 	if (priv->dpdmai_attr.version.minor > DPDMAI_VER_MINOR) {
+		err = -EINVAL;
 		dev_err(dev, "DPDMAI minor version mismatch\n"
 			     "Found %u.%u, supported version is %u.%u\n",
 				priv->dpdmai_attr.version.major,
@@ -475,6 +477,7 @@ static int __cold dpaa2_qdma_dpio_setup(struct dpaa2_qdma_priv *priv)
 		ppriv->store =
 			dpaa2_io_store_create(DPAA2_QDMA_STORE_SIZE, dev);
 		if (!ppriv->store) {
+			err = -ENOMEM;
 			dev_err(dev, "dpaa2_io_store_create() failed\n");
 			goto err_store;
 		}
-- 
2.25.1


