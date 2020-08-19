Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D832496E1
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHSHQF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Aug 2020 03:16:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25516 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbgHSHQE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Aug 2020 03:16:04 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07J7FHPD002384;
        Wed, 19 Aug 2020 03:15:49 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3304n5cf77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 03:15:49 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07J7FmpK059848
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 19 Aug 2020 03:15:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 19 Aug
 2020 03:15:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 19 Aug 2020 03:15:47 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07J7Fg8v020449;
        Wed, 19 Aug 2020 03:15:45 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>, <dan.j.williams@intel.com>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/5] dmaengine: axi-dmac: move clock enable earlier
Date:   Wed, 19 Aug 2020 10:16:30 +0300
Message-ID: <20200819071633.76494-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819071633.76494-1-alexandru.ardelean@analog.com>
References: <20200819071633.76494-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_04:2020-08-18,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=25 clxscore=1011 phishscore=0
 priorityscore=1501 mlxlogscore=732 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190061
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The clock may also be required to read registers from the IP core (if it is
provided and the driver needs to control it).
So, move it earlier in the probe.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 088c79137398..07665c60c21b 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -850,6 +850,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->clk))
 		return PTR_ERR(dmac->clk);
 
+	ret = clk_prepare_enable(dmac->clk);
+	if (ret < 0)
+		return ret;
+
 	INIT_LIST_HEAD(&dmac->chan.active_descs);
 
 	of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
@@ -892,10 +896,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dmac->chan.vchan.desc_free = axi_dmac_desc_free;
 	vchan_init(&dmac->chan.vchan, dma_dev);
 
-	ret = clk_prepare_enable(dmac->clk);
-	if (ret < 0)
-		return ret;
-
 	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
 
 	ret = axi_dmac_detect_caps(dmac, version);
-- 
2.17.1

