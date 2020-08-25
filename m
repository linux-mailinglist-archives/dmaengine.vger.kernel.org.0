Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239CD2518E8
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 14:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgHYMsn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 08:48:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41966 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729203AbgHYMsl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 08:48:41 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PCeAmx017797;
        Tue, 25 Aug 2020 08:48:29 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 332w761k7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 08:48:28 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07PCmR97034904
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Aug 2020 08:48:27 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 05:48:26 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 05:48:26 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Aug 2020 05:48:25 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07PCm0jT001781;
        Tue, 25 Aug 2020 08:48:22 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>, <dan.j.williams@intel.com>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 5/6] dmaengine: axi-dmac: wrap channel parameter adjust into function
Date:   Tue, 25 Aug 2020 15:48:39 +0300
Message-ID: <20200825124840.43664-13-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825124840.43664-1-alexandru.ardelean@analog.com>
References: <20200825124840.43664-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_04:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=8
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250096
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The channel parameters (which are read from the device-tree) are adjusted
for the DMAEngine framework in the axi_dmac_parse_chan_dt() function, after
they are read from the device-tree.

When we want to read these from registers, we will need to use the same
logic, so this change splits the logic into a separate function.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 1a1e227fa935..7ee56ae60093 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -717,6 +717,20 @@ static const struct regmap_config axi_dmac_regmap_config = {
 	.writeable_reg = axi_dmac_regmap_rdwr,
 };
 
+static void axi_dmac_adjust_chan_params(struct axi_dmac_chan *chan)
+{
+	chan->address_align_mask = max(chan->dest_width, chan->src_width) - 1;
+
+	if (axi_dmac_dest_is_mem(chan) && axi_dmac_src_is_mem(chan))
+		chan->direction = DMA_MEM_TO_MEM;
+	else if (!axi_dmac_dest_is_mem(chan) && axi_dmac_src_is_mem(chan))
+		chan->direction = DMA_MEM_TO_DEV;
+	else if (axi_dmac_dest_is_mem(chan) && !axi_dmac_src_is_mem(chan))
+		chan->direction = DMA_DEV_TO_MEM;
+	else
+		chan->direction = DMA_DEV_TO_DEV;
+}
+
 /*
  * The configuration stored in the devicetree matches the configuration
  * parameters of the peripheral instance and allows the driver to know which
@@ -760,16 +774,7 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 		return ret;
 	chan->dest_width = val / 8;
 
-	chan->address_align_mask = max(chan->dest_width, chan->src_width) - 1;
-
-	if (axi_dmac_dest_is_mem(chan) && axi_dmac_src_is_mem(chan))
-		chan->direction = DMA_MEM_TO_MEM;
-	else if (!axi_dmac_dest_is_mem(chan) && axi_dmac_src_is_mem(chan))
-		chan->direction = DMA_MEM_TO_DEV;
-	else if (axi_dmac_dest_is_mem(chan) && !axi_dmac_src_is_mem(chan))
-		chan->direction = DMA_DEV_TO_MEM;
-	else
-		chan->direction = DMA_DEV_TO_DEV;
+	axi_dmac_adjust_chan_params(chan);
 
 	return 0;
 }
-- 
2.17.1

