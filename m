Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE776FE06
	for <lists+dmaengine@lfdr.de>; Fri,  4 Aug 2023 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjHDKDT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Aug 2023 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjHDKDS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Aug 2023 06:03:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD752118
        for <dmaengine@vger.kernel.org>; Fri,  4 Aug 2023 03:03:16 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHLq45CK2zrS9t;
        Fri,  4 Aug 2023 18:02:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 18:03:13 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <vkoul@kernel.org>, <laurentiu.tudor@nxp.com>, <leoyang.li@nxp.com>
CC:     <lizetao1@huawei.com>, <ioana.ciornei@nxp.com>,
        <uwe@kleine-koenig.org>, <dmaengine@vger.kernel.org>
Subject: [PATCH -next] dmaengine: fsl-dpaa2-qdma: Remove redundant initialization owner in dpaa2_qdma_driver
Date:   Fri, 4 Aug 2023 18:02:45 +0800
Message-ID: <20230804100245.100068-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The fsl_mc_driver_register() will set "THIS_MODULE" to driver.owner when
register a fsl_mc_driver driver, so it is redundant initialization to set
driver.owner in dpaa2_qdma_driver statement. Remove it for clean code.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index a42a37634881..7958ac33e36c 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -814,7 +814,6 @@ static const struct fsl_mc_device_id dpaa2_qdma_id_table[] = {
 static struct fsl_mc_driver dpaa2_qdma_driver = {
 	.driver		= {
 		.name	= "dpaa2-qdma",
-		.owner  = THIS_MODULE,
 	},
 	.probe          = dpaa2_qdma_probe,
 	.remove		= dpaa2_qdma_remove,
-- 
2.34.1

