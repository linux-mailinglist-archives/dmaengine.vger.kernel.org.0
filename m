Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54959251C16
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgHYPTf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 11:19:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11802 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbgHYPTd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 11:19:33 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PF8D0T004055;
        Tue, 25 Aug 2020 11:19:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3330952018-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 11:19:21 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07PFJJ5B061695
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Aug 2020 11:19:19 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 08:19:18 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 08:19:18 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Aug 2020 08:19:17 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07PFJ9l0007670;
        Tue, 25 Aug 2020 11:19:15 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>, <dan.j.williams@intel.com>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RESEND PATCH v2 3/6] dmaengine: axi-dmac: move clock enable earlier
Date:   Tue, 25 Aug 2020 18:19:47 +0300
Message-ID: <20200825151950.57605-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825151950.57605-1-alexandru.ardelean@analog.com>
References: <20200825151950.57605-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_05:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=747 spamscore=0
 suspectscore=25 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250114
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The clock may also be required to read registers from the IP core (if it is
provided and the driver needs to control it).
So, move it earlier in the probe.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 90a99bdffa2b..f4b17b5e3914 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -850,16 +850,23 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->clk))
 		return PTR_ERR(dmac->clk);
 
+	ret = clk_prepare_enable(dmac->clk);
+	if (ret < 0)
+		return ret;
+
 	of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
-	if (of_channels == NULL)
-		return -ENODEV;
+	if (of_channels == NULL) {
+		ret = -ENODEV;
+		goto err_clk_disable;
+	}
 
 	for_each_child_of_node(of_channels, of_chan) {
 		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
 		if (ret) {
 			of_node_put(of_chan);
 			of_node_put(of_channels);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_clk_disable;
 		}
 	}
 	of_node_put(of_channels);
@@ -892,10 +899,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
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

