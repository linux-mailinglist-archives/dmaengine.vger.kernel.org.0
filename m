Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABA6251C20
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHYPTf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 11:19:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7986 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbgHYPTb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 11:19:31 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PFAE8h027792;
        Tue, 25 Aug 2020 11:19:18 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 332w7622ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 11:19:18 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07PFJGfC021579
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Aug 2020 11:19:16 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 08:19:15 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 08:18:55 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Aug 2020 08:19:14 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07PFJ9kw007670;
        Tue, 25 Aug 2020 11:19:11 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>, <dan.j.williams@intel.com>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RESEND PATCH v2 1/6] dmaengine: axi-dmac: move version read in probe
Date:   Tue, 25 Aug 2020 18:19:45 +0300
Message-ID: <20200825151950.57605-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825151950.57605-1-alexandru.ardelean@analog.com>
References: <20200825151950.57605-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_05:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=8
 mlxlogscore=893 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250114
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The 'version' of the IP core will be needed to adapt the driver to a new
feature (i.e. reading some DMA parameters from registers).
To do that, the version will be checked, so this is being moved out of the
axi_dmac_detect_caps() function.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f1d149e32839..088c79137398 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -774,12 +774,9 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 	return 0;
 }
 
-static int axi_dmac_detect_caps(struct axi_dmac *dmac)
+static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 {
 	struct axi_dmac_chan *chan = &dmac->chan;
-	unsigned int version;
-
-	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
 
 	axi_dmac_write(dmac, AXI_DMAC_REG_FLAGS, AXI_DMAC_FLAG_CYCLIC);
 	if (axi_dmac_read(dmac, AXI_DMAC_REG_FLAGS) == AXI_DMAC_FLAG_CYCLIC)
@@ -831,6 +828,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	struct axi_dmac *dmac;
 	struct resource *res;
 	struct regmap *regmap;
+	unsigned int version;
 	int ret;
 
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
@@ -898,7 +896,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ret = axi_dmac_detect_caps(dmac);
+	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
+
+	ret = axi_dmac_detect_caps(dmac, version);
 	if (ret)
 		goto err_clk_disable;
 
-- 
2.17.1

