Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331B22AEFA
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfE0Gz1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 02:55:27 -0400
Received: from mail-eopbgr790053.outbound.protection.outlook.com ([40.107.79.53]:53504
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfE0Gz1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 02:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIWyfdaWBynJxAnjUQrRvBzfSKIvDO6mdNLId1SYJuc=;
 b=5Tq6BlT7vS4K0EDfYlxa/rIRMa1v7aBa7Pb8SfxVqsNJk4Jz+J6vae2BC+yTwo6vZVk/DOw79rlIryfYkVqXafL5fXgrVMThrLjHrIij64mKL6t5dnMYImn/1Od9bwN5YdIrXzmO6BoYaTHtbR4zZ9TtGLnlRoxD+aHxnCmJLI8=
Received: from BN6PR03CA0005.namprd03.prod.outlook.com (2603:10b6:404:23::15)
 by DM2PR03MB558.namprd03.prod.outlook.com (2a01:111:e400:241d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.17; Mon, 27 May
 2019 06:55:24 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN6PR03CA0005.outlook.office365.com
 (2603:10b6:404:23::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16 via Frontend
 Transport; Mon, 27 May 2019 06:55:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Mon, 27 May 2019 06:55:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4R6tMZw029725
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 26 May 2019 23:55:23 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 27 May 2019
 02:55:22 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3][V3] dmaengine: axi-dmac: Discover length alignment requirement
Date:   Mon, 27 May 2019 09:55:17 +0300
Message-ID: <20190527065518.18613-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527065518.18613-1-alexandru.ardelean@analog.com>
References: <20190527065518.18613-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(199004)(189003)(43544003)(7636002)(50226002)(26005)(51416003)(7696005)(1076003)(54906003)(106002)(5660300002)(70586007)(316002)(16586007)(186003)(70206006)(2906002)(246002)(77096007)(305945005)(426003)(336012)(8936002)(48376002)(446003)(126002)(486006)(2616005)(86362001)(44832011)(478600001)(2351001)(11346002)(53416004)(476003)(107886003)(76176011)(8676002)(6666004)(36756003)(356004)(6916009)(14444005)(50466002)(47776003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB558;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2c61f23-3de8-4c7a-de61-08d6e2704b02
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:DM2PR03MB558;
X-MS-TrafficTypeDiagnostic: DM2PR03MB558:
X-Microsoft-Antispam-PRVS: <DM2PR03MB558BA867D8F030EC6CBD431F91D0@DM2PR03MB558.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0050CEFE70
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wuXWCDOeXLxPl7IGoEi0x1AQfR97SV3tJJg5rOOJDbJb/DVvAUdULm+y+RY7y/ZtBRKYC+erkzUV9JsjoE+g8Eg0qjY8NV53CqAbopWCFHfxgISDSmmOGn2PdYTgs6O6e0cSBMBqlWcIme4THhfVtuDZPl/PlzUyJKmZvqDPvbsTcP+z5ByQDUntXgwkvxfqKfYlQZMVX16UNDHZ9qGPf5ylB+u804CZdZt/XBB4MYbSeRIrfeW8qiXORO3ZlW8wqa4T+9rNu3mFmbEGcg5d93Q8w2hGAWKVhjP8te59j7mjoKtZ9SivqqC7LqVg63LrNOELq3nIvyBWr7HJgEI9TRdg70e9t2L7G0aESRw1srYziZ/x7RhupPhnq+ZtKlkTbcaEdglIVTUUa1etw+oeBbQfQKanG4OtihauaY2DKQg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2019 06:55:23.9405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c61f23-3de8-4c7a-de61-08d6e2704b02
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB558
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Starting with version 4.1.a the AXI-DMAC is capable of reporting the
required length alignment.

The LSBs that are required to be set for alignment will always read back as
set from the transfer length register. It is not possible to clear them by
writing a 0. This means the driver can discover the length alignment
requirement by writing 0 to that register and reading back the value.

Since the DMA will support length alignment requirements that are different
from the address alignment requirement track both of them independently.

For older versions of the peripheral assume that the length alignment
requirement is equal to the address alignment requirement.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 0984ae6eb155..74ae6246d9a5 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -20,6 +20,7 @@
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/fpga/adi-axi-common.h>
 
 #include <dt-bindings/dma/axi-dmac.h>
 
@@ -110,7 +111,8 @@ struct axi_dmac_chan {
 	unsigned int dest_type;
 
 	unsigned int max_length;
-	unsigned int align_mask;
+	unsigned int address_align_mask;
+	unsigned int length_align_mask;
 
 	bool hw_cyclic;
 	bool hw_2d;
@@ -169,14 +171,14 @@ static bool axi_dmac_check_len(struct axi_dmac_chan *chan, unsigned int len)
 {
 	if (len == 0)
 		return false;
-	if ((len & chan->align_mask) != 0) /* Not aligned */
+	if ((len & chan->length_align_mask) != 0) /* Not aligned */
 		return false;
 	return true;
 }
 
 static bool axi_dmac_check_addr(struct axi_dmac_chan *chan, dma_addr_t addr)
 {
-	if ((addr & chan->align_mask) != 0) /* Not aligned */
+	if ((addr & chan->address_align_mask) != 0) /* Not aligned */
 		return false;
 	return true;
 }
@@ -394,7 +396,7 @@ static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	num_segments = DIV_ROUND_UP(period_len, chan->max_length);
 	segment_size = DIV_ROUND_UP(period_len, num_segments);
 	/* Take care of alignment */
-	segment_size = ((segment_size - 1) | chan->align_mask) + 1;
+	segment_size = ((segment_size - 1) | chan->length_align_mask) + 1;
 
 	for (i = 0; i < num_periods; i++) {
 		len = period_len;
@@ -623,7 +625,7 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 		return ret;
 	chan->dest_width = val / 8;
 
-	chan->align_mask = max(chan->dest_width, chan->src_width) - 1;
+	chan->address_align_mask = max(chan->dest_width, chan->src_width) - 1;
 
 	if (axi_dmac_dest_is_mem(chan) && axi_dmac_src_is_mem(chan))
 		chan->direction = DMA_MEM_TO_MEM;
@@ -640,6 +642,9 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 static int axi_dmac_detect_caps(struct axi_dmac *dmac)
 {
 	struct axi_dmac_chan *chan = &dmac->chan;
+	unsigned int version;
+
+	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
 
 	axi_dmac_write(dmac, AXI_DMAC_REG_FLAGS, AXI_DMAC_FLAG_CYCLIC);
 	if (axi_dmac_read(dmac, AXI_DMAC_REG_FLAGS) == AXI_DMAC_FLAG_CYCLIC)
@@ -670,6 +675,14 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac)
 		return -ENODEV;
 	}
 
+	if (version >= ADI_AXI_PCORE_VER(4, 1, 'a')) {
+		axi_dmac_write(dmac, AXI_DMAC_REG_X_LENGTH, 0x00);
+		chan->length_align_mask =
+			axi_dmac_read(dmac, AXI_DMAC_REG_X_LENGTH);
+	} else {
+		chan->length_align_mask = chan->address_align_mask;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

