Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA742496E3
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 09:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHSHQH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Aug 2020 03:16:07 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26770 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbgHSHQG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Aug 2020 03:16:06 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07J7Dafl023237;
        Wed, 19 Aug 2020 03:15:53 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3304kcmfu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 03:15:53 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07J7Fpsf031729
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 19 Aug 2020 03:15:51 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 19 Aug
 2020 00:15:50 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 19 Aug 2020 00:15:49 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07J7Fg8w020449;
        Wed, 19 Aug 2020 03:15:47 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>, <dan.j.williams@intel.com>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/5] dmaengine: axi-dmac: wrap entire dt parse in a function
Date:   Wed, 19 Aug 2020 10:16:31 +0300
Message-ID: <20200819071633.76494-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819071633.76494-1-alexandru.ardelean@analog.com>
References: <20200819071633.76494-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_04:2020-08-18,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=8 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190060
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

All these attributes will be read from registers in newer core versions, so
just wrap the logic into a function.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 39 ++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 07665c60c21b..473c4a159c89 100644
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
@@ -856,19 +877,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&dmac->chan.active_descs);
 
-	of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
-	if (of_channels == NULL)
-		return -ENODEV;
-
-	for_each_child_of_node(of_channels, of_chan) {
-		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
-		if (ret) {
-			of_node_put(of_chan);
-			of_node_put(of_channels);
-			return -EINVAL;
-		}
-	}
-	of_node_put(of_channels);
+	ret = axi_dmac_parse_dt(&pdev->dev, dmac);
+	if (ret < 0)
+		return ret;
 
 	pdev->dev.dma_parms = &dmac->dma_parms;
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
-- 
2.17.1

