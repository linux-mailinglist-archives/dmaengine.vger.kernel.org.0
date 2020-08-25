Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3F2518FE
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHYMtw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 08:49:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19564 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729040AbgHYMsY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 08:48:24 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PCmA63018883;
        Tue, 25 Aug 2020 08:48:12 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3330951ggh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 08:48:12 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07PCmA7R034798
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Aug 2020 08:48:10 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 08:48:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 08:48:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Aug 2020 08:48:09 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07PCm0jL001781;
        Tue, 25 Aug 2020 08:48:07 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>, <dan.j.williams@intel.com>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 4/6] dmaengine: axi-dmac: wrap entire dt parse in a function
Date:   Tue, 25 Aug 2020 15:48:31 +0300
Message-ID: <20200825124840.43664-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825124840.43664-1-alexandru.ardelean@analog.com>
References: <20200825124840.43664-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_04:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=8 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250097
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

All these attributes will be read from registers in newer core versions, so
just wrap the logic into a function.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 40 +++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f4b17b5e3914..1a1e227fa935 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -774,6 +774,28 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 	return 0;
 }
 
+static int axi_dmac_parse_dt(struct device *dev, struct axi_dmac *dmac)
+{
+	struct device_node *of_channels, *of_chan;
+	int ret;
+
+	of_channels = of_get_child_by_name(dev->of_node, "adi,channels");
+	if (of_channels == NULL)
+		return -ENODEV;
+
+	for_each_child_of_node(of_channels, of_chan) {
+		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
+		if (ret) {
+			of_node_put(of_chan);
+			of_node_put(of_channels);
+			return -EINVAL;
+		}
+	}
+	of_node_put(of_channels);
+
+	return 0;
+}
+
 static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 {
 	struct axi_dmac_chan *chan = &dmac->chan;
@@ -823,7 +845,6 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 
 static int axi_dmac_probe(struct platform_device *pdev)
 {
-	struct device_node *of_channels, *of_chan;
 	struct dma_device *dma_dev;
 	struct axi_dmac *dmac;
 	struct resource *res;
@@ -854,22 +875,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
-	if (of_channels == NULL) {
-		ret = -ENODEV;
+	ret = axi_dmac_parse_dt(&pdev->dev, dmac);
+	if (ret < 0)
 		goto err_clk_disable;
-	}
-
-	for_each_child_of_node(of_channels, of_chan) {
-		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
-		if (ret) {
-			of_node_put(of_chan);
-			of_node_put(of_channels);
-			ret = -EINVAL;
-			goto err_clk_disable;
-		}
-	}
-	of_node_put(of_channels);
 
 	INIT_LIST_HEAD(&dmac->chan.active_descs);
 
-- 
2.17.1

