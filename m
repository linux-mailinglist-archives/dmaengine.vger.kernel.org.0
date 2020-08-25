Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE5B2518EE
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 14:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgHYMsd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 08:48:33 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28498 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728185AbgHYMsa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 08:48:30 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PCeAnc017803;
        Tue, 25 Aug 2020 08:48:18 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 332w761k6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 08:48:17 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07PCmGLv034842
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Aug 2020 08:48:16 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 05:48:15 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 05:47:56 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Aug 2020 05:48:14 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07PCm0jN001781;
        Tue, 25 Aug 2020 08:48:11 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>, <dan.j.williams@intel.com>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 6/6] dmaengine: axi-dmac: add support for reading bus attributes from registers
Date:   Tue, 25 Aug 2020 15:48:33 +0300
Message-ID: <20200825124840.43664-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825124840.43664-1-alexandru.ardelean@analog.com>
References: <20200825124840.43664-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_04:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=25
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250096
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Starting with core version 4.3.a the DMA bus attributes can (and should) be
read from the INTERFACE_DESCRIPTION (0x10) register.

For older core versions, this will still need to be provided from the
device-tree.

The bus-type values are identical to the ones stored in the device-trees,
so we just need to read them. Bus-width values are stored in log2 values,
so we just need to use them as shift values to make them equivalent to the
current format.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 66 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 7ee56ae60093..25442a437879 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -6,6 +6,7 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
@@ -45,6 +46,16 @@
  * there is no address than can or needs to be configured for the device side.
  */
 
+#define AXI_DMAC_REG_INTERFACE_DESC	0x10
+#define   AXI_DMAC_DMA_SRC_TYPE_MSK	GENMASK(13, 12)
+#define   AXI_DMAC_DMA_SRC_TYPE_GET(x)	FIELD_GET(AXI_DMAC_DMA_SRC_TYPE_MSK, x)
+#define   AXI_DMAC_DMA_SRC_WIDTH_MSK	GENMASK(11, 8)
+#define   AXI_DMAC_DMA_SRC_WIDTH_GET(x)	FIELD_GET(AXI_DMAC_DMA_SRC_WIDTH_MSK, x)
+#define   AXI_DMAC_DMA_DST_TYPE_MSK	GENMASK(5, 4)
+#define   AXI_DMAC_DMA_DST_TYPE_GET(x)	FIELD_GET(AXI_DMAC_DMA_DST_TYPE_MSK, x)
+#define   AXI_DMAC_DMA_DST_WIDTH_MSK	GENMASK(3, 0)
+#define   AXI_DMAC_DMA_DST_WIDTH_GET(x)	FIELD_GET(AXI_DMAC_DMA_DST_WIDTH_MSK, x)
+
 #define AXI_DMAC_REG_IRQ_MASK		0x80
 #define AXI_DMAC_REG_IRQ_PENDING	0x84
 #define AXI_DMAC_REG_IRQ_SOURCE		0x88
@@ -801,6 +812,51 @@ static int axi_dmac_parse_dt(struct device *dev, struct axi_dmac *dmac)
 	return 0;
 }
 
+static int axi_dmac_read_chan_config(struct device *dev, struct axi_dmac *dmac)
+{
+	struct axi_dmac_chan *chan = &dmac->chan;
+	unsigned int val, desc;
+
+	desc = axi_dmac_read(dmac, AXI_DMAC_REG_INTERFACE_DESC);
+	if (desc == 0) {
+		dev_err(dev, "DMA interface register reads zero\n");
+		return -EFAULT;
+	}
+
+	val = AXI_DMAC_DMA_SRC_TYPE_GET(desc);
+	if (val > AXI_DMAC_BUS_TYPE_FIFO) {
+		dev_err(dev, "Invalid source bus type read: %d\n", val);
+		return -EINVAL;
+	}
+	chan->src_type = val;
+
+	val = AXI_DMAC_DMA_DST_TYPE_GET(desc);
+	if (val > AXI_DMAC_BUS_TYPE_FIFO) {
+		dev_err(dev, "Invalid destination bus type read: %d\n", val);
+		return -EINVAL;
+	}
+	chan->dest_type = val;
+
+	val = AXI_DMAC_DMA_SRC_WIDTH_GET(desc);
+	if (val == 0) {
+		dev_err(dev, "Source bus width is zero\n");
+		return -EINVAL;
+	}
+	/* widths are stored in log2 */
+	chan->src_width = 1 << val;
+
+	val = AXI_DMAC_DMA_DST_WIDTH_GET(desc);
+	if (val == 0) {
+		dev_err(dev, "Destination bus width is zero\n");
+		return -EINVAL;
+	}
+	chan->dest_width = 1 << val;
+
+	axi_dmac_adjust_chan_params(chan);
+
+	return 0;
+}
+
 static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 {
 	struct axi_dmac_chan *chan = &dmac->chan;
@@ -880,7 +936,13 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ret = axi_dmac_parse_dt(&pdev->dev, dmac);
+	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
+
+	if (version >= ADI_AXI_PCORE_VER(4, 3, 'a'))
+		ret = axi_dmac_read_chan_config(&pdev->dev, dmac);
+	else
+		ret = axi_dmac_parse_dt(&pdev->dev, dmac);
+
 	if (ret < 0)
 		goto err_clk_disable;
 
@@ -912,8 +974,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dmac->chan.vchan.desc_free = axi_dmac_desc_free;
 	vchan_init(&dmac->chan.vchan, dma_dev);
 
-	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
-
 	ret = axi_dmac_detect_caps(dmac, version);
 	if (ret)
 		goto err_clk_disable;
-- 
2.17.1

