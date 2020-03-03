Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7028B1776C0
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2020 14:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgCCNOb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Mar 2020 08:14:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbgCCNOb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 3 Mar 2020 08:14:31 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EF1357A0F349068C8526;
        Tue,  3 Mar 2020 21:14:25 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 21:14:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>, <peng.ma@nxp.com>,
        <yuehaibing@huawei.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] dmaengine: fsl-dpaa2-qdma: remove set but not used variable 'dpaa2_qdma'
Date:   Tue, 3 Mar 2020 21:13:47 +0800
Message-ID: <20200303131347.28392-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c: In function dpaa2_qdma_shutdown:
drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:795:28: warning: variable dpaa2_qdma set but not used [-Wunused-but-set-variable]

commit 3e0ca3c38dc2 ("dmaengine: fsl-dpaa2-qdma: Adding shutdown hook")
involved this, remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index fabbbb9..4ec909e 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -792,13 +792,11 @@ static int dpaa2_qdma_remove(struct fsl_mc_device *ls_dev)
 
 static void dpaa2_qdma_shutdown(struct fsl_mc_device *ls_dev)
 {
-	struct dpaa2_qdma_engine *dpaa2_qdma;
 	struct dpaa2_qdma_priv *priv;
 	struct device *dev;
 
 	dev = &ls_dev->dev;
 	priv = dev_get_drvdata(dev);
-	dpaa2_qdma = priv->dpaa2_qdma;
 
 	dpdmai_disable(priv->mc_io, 0, ls_dev->mc_handle);
 	dpaa2_dpdmai_dpio_unbind(priv);
-- 
2.7.4


