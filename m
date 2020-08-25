Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17382518FF
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgHYMtw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 08:49:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17934 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728946AbgHYMsY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 08:48:24 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PCe9iN017665;
        Tue, 25 Aug 2020 08:48:10 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 332w761k6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 08:48:10 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07PCm82W017030
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Aug 2020 08:48:08 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 25 Aug
 2020 05:48:07 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Aug 2020 05:48:06 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07PCm0jJ001781;
        Tue, 25 Aug 2020 08:48:04 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>, <dan.j.williams@intel.com>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/6] dmaengine: axi-dmac: move active_descs list init after device-tree init
Date:   Tue, 25 Aug 2020 15:48:29 +0300
Message-ID: <20200825124840.43664-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825124840.43664-1-alexandru.ardelean@analog.com>
References: <20200825124840.43664-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_04:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=8
 mlxlogscore=929 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250096
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We want to enable the clock right after it is obtained. Then later we'll
want to read the core version via register-access (which requires the clock
to be enabled).

The initialization of the active_descs list can be postponed after reading
from registers (or reading the device-tree).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 088c79137398..90a99bdffa2b 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -850,8 +850,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->clk))
 		return PTR_ERR(dmac->clk);
 
-	INIT_LIST_HEAD(&dmac->chan.active_descs);
-
 	of_channels = of_get_child_by_name(pdev->dev.of_node, "adi,channels");
 	if (of_channels == NULL)
 		return -ENODEV;
@@ -866,6 +864,8 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	}
 	of_node_put(of_channels);
 
+	INIT_LIST_HEAD(&dmac->chan.active_descs);
+
 	pdev->dev.dma_parms = &dmac->dma_parms;
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
 
-- 
2.17.1

