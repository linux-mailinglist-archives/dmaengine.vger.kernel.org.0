Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478EB20159
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2019 10:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEPIbp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 May 2019 04:31:45 -0400
Received: from mail-eopbgr820050.outbound.protection.outlook.com ([40.107.82.50]:29856
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfEPIbo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 May 2019 04:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGJi4wEBkif6j+1oSz1qAN561tP4d+Ixab6SpXjQadw=;
 b=dlvcRkHtiVvh5kWoQz9Qe6CK/JpNcyeDVPPz0ARqm7hsXPF6PXxS3sxxeT6oyZk/wnUWlOC9mJdzRZnBHioQ6qFAshg6hKrc5TAIGi0sCl/pOeI8uWuZAzAsE5H+9NHYVdF0OldHCweH/TGoZP2SUO3T4T07v9EsgDxKkNeQ2Dc=
Received: from DM6PR03CA0039.namprd03.prod.outlook.com (2603:10b6:5:100::16)
 by BL2PR03MB547.namprd03.prod.outlook.com (2a01:111:e400:c23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.25; Thu, 16 May
 2019 08:31:42 +0000
Received: from SN1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR03CA0039.outlook.office365.com
 (2603:10b6:5:100::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Thu, 16 May 2019 08:31:41 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT030.mail.protection.outlook.com (10.152.72.114) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Thu, 16 May 2019 08:31:40 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4G8VesH024706
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 16 May 2019 01:31:40 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 16 May 2019
 04:31:39 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] dmaengine: axi-dmac: Sanity check memory mapped interface support
Date:   Thu, 16 May 2019 11:31:34 +0300
Message-ID: <20190516083134.29460-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(199004)(189003)(26005)(77096007)(2906002)(186003)(5660300002)(478600001)(36756003)(4326008)(14444005)(6916009)(336012)(44832011)(426003)(7696005)(2616005)(51416003)(316002)(476003)(486006)(126002)(305945005)(7636002)(50226002)(8676002)(246002)(8936002)(16586007)(54906003)(2351001)(48376002)(107886003)(106002)(53416004)(1076003)(47776003)(50466002)(86362001)(6666004)(70586007)(70206006)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB547;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9921b2-2059-4ccc-8f22-08d6d9d8ebc6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BL2PR03MB547;
X-MS-TrafficTypeDiagnostic: BL2PR03MB547:
X-Microsoft-Antispam-PRVS: <BL2PR03MB547D02E5104F8AD1672C7FDF90A0@BL2PR03MB547.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FuPm4+7wflemHBG7duX7/JxEkJPtDnJMcBt5uLcG2AGtirSzgWIfQjlTEvnA4YtVikLK2H3baTYv/0Fxo30bq54fQIBY95sS1LeGg2TFkWL17bVB6IDllHWfZ96zsddjvqPZoEQRw/QAudAxe7aazPWazSGIrB+CZqcMMx9UAqvFqsjAhJycl5YeGnEvaMQnuWmv8tnkyVEpjUX8Pro00oaw7B3Tbub0calq7uZr4o3WLRiv17xK6tpQikxTwNlRrY+8RSza3FEk/C2zooU/ylzlFBHs5thtbMhJn6xh+/Gh58ST4OvzlvPhUSVhxklS5lz9sAz8vSX0D6PGw3VFN+IQBxDW5EtM5XpPNc0VR3PWCP750V6MnNrd5OunTqL0gFxQtiyMYdjedT0LCSZZEr7WNeGAKlyqIfW1YmT8me0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 08:31:40.9053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9921b2-2059-4ccc-8f22-08d6d9d8ebc6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB547
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

The AXI-DMAC supports different types of interface for the data source and
destination ports. Typically one of those ports is a memory-mapped
interface while the other is some kind of streaming interface.

The information about which kind of interface is used for each port is
encoded in the devicetree.

It is also possible in the driver to detect whether a port supports
memory-mapped transfers or not. For streaming interfaces the address
register is read-only and will always return 0. So in order to check if a
port supports memory-mapped transfers write a non-zero value to the
corresponding address register and check that the value read-back is still
non zero.

This allows to detect mismatches between the devicetree description and the
actual hardware configuration.

Unfortunately it is not possible to autodetect the interface types since
there is no method to distinguish between the different streaming ports. So
the best thing that can be done is to error out when a memory mapped port
is described in the devicetree but none is detected in the hardware.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f32fdf21edbd..5710179a401e 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -632,7 +632,7 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 	return 0;
 }
 
-static void axi_dmac_detect_caps(struct axi_dmac *dmac)
+static int axi_dmac_detect_caps(struct axi_dmac *dmac)
 {
 	struct axi_dmac_chan *chan = &dmac->chan;
 
@@ -648,6 +648,24 @@ static void axi_dmac_detect_caps(struct axi_dmac *dmac)
 	chan->max_length = axi_dmac_read(dmac, AXI_DMAC_REG_X_LENGTH);
 	if (chan->max_length != UINT_MAX)
 		chan->max_length++;
+
+	axi_dmac_write(dmac, AXI_DMAC_REG_DEST_ADDRESS, 0xffffffff);
+	if (axi_dmac_read(dmac, AXI_DMAC_REG_DEST_ADDRESS) == 0 &&
+	    chan->dest_type == AXI_DMAC_BUS_TYPE_AXI_MM) {
+		dev_err(dmac->dma_dev.dev,
+			"Destination memory-mapped interface not supported.");
+		return -ENODEV;
+	}
+
+	axi_dmac_write(dmac, AXI_DMAC_REG_SRC_ADDRESS, 0xffffffff);
+	if (axi_dmac_read(dmac, AXI_DMAC_REG_SRC_ADDRESS) == 0 &&
+	    chan->src_type == AXI_DMAC_BUS_TYPE_AXI_MM) {
+		dev_err(dmac->dma_dev.dev,
+			"Source memory-mapped interface not supported.");
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
 static int axi_dmac_probe(struct platform_device *pdev)
@@ -723,7 +741,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	axi_dmac_detect_caps(dmac);
+	ret = axi_dmac_detect_caps(dmac);
+	if (ret)
+		goto err_clk_disable;
 
 	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
 
-- 
2.17.1

