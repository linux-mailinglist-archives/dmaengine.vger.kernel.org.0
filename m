Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9C251B0
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 16:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfEUOPe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 10:15:34 -0400
Received: from mail-eopbgr790073.outbound.protection.outlook.com ([40.107.79.73]:4736
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfEUOPe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 10:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrkNWlyv5gN7zf2YmkeQIfobqVs58WfVc/gmqazSWkY=;
 b=5bpfU5uBXiaM+2y6+rG6lLc4wcLHWChRbeFU/32WlbZJUgcD5L2rAw0rpaQe+2M0PYB+m0NcPt2PbWlwAtKE2sAMQ3pWyHLzrMC178HleW37LR2OsCxEL6kkHX4UmO+X5vujOnQigWSkKDIcr5DDp5hD9slEhVRz3lCyCbnVMcI=
Received: from CY1PR03CA0034.namprd03.prod.outlook.com (2603:10b6:600::44) by
 BN6PR03MB3123.namprd03.prod.outlook.com (2603:10b6:405:44::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 14:14:51 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by CY1PR03CA0034.outlook.office365.com
 (2603:10b6:600::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Tue, 21 May 2019 14:14:50 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 14:14:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4LEEn4x032399
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 21 May 2019 07:14:49 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 21 May 2019
 10:14:48 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3][V2] dmaengine: axi-dmac: Discover length alignment requirement
Date:   Tue, 21 May 2019 17:14:24 +0300
Message-ID: <20190521141425.26176-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521141425.26176-1-alexandru.ardelean@analog.com>
References: <20190521141425.26176-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(2980300002)(199004)(189003)(43544003)(316002)(8676002)(8936002)(16586007)(246002)(2906002)(86362001)(36756003)(48376002)(50466002)(478600001)(2351001)(50226002)(53416004)(486006)(51416003)(7696005)(2616005)(476003)(47776003)(446003)(70206006)(76176011)(11346002)(426003)(305945005)(7636002)(336012)(70586007)(126002)(14444005)(44832011)(6916009)(26005)(186003)(4326008)(54906003)(1076003)(356004)(6666004)(5660300002)(106002)(77096007)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3123;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a77925-d9b6-48cc-e67b-08d6ddf6b03a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BN6PR03MB3123;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3123:
X-Microsoft-Antispam-PRVS: <BN6PR03MB3123DA391F6705F4CA1B7659F9070@BN6PR03MB3123.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0044C17179
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zuqtqtNGMbO/zxEmuhuyvtfA1v72/Aq31OseTcU1qFQXe2HB4HgncIH3F1/E1svY99q16bhnBt77NAjyKHlW9+K62GEG3pRYnVgKuI20gWH3T0eL9Qa7HnQGzMcY8WgTz3SblGCUGg9ghlLy1UYhNxoX2dzU2DgubFWFahCjYI/9Rc0idhHaSNhihHcpTPesDZ25Yr9Tak1/LM5fqmkiwcHozwI1wWt8/6XMp4vf79AoORnunrfOd8rMPkdL9qk94GmHjgzFR72NzvbeYWvAhw8rRjslTtOY42HvALd8w/D4uq1VSWYBhdaRK0ZnQqkCl1mo0DsPEFYBXFAt3Egh5Cb6UmXjcjwI1TT99RWPz5tCuG4yxSpNVL1pJ24kOnOPErypwJYZGm3gcRg/XVbnYBGD57NxeyJHMDrnlnqWvnE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 14:14:50.5465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a77925-d9b6-48cc-e67b-08d6ddf6b03a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3123
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
 drivers/dma/dma-axi-dmac.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 0984ae6eb155..196e6c429182 100644
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
@@ -670,6 +675,13 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac)
 		return -ENODEV;
 	}
 
+	if (version >= ADI_AXI_PCORE_VER(4, 1, 'a')) {
+		axi_dmac_write(dmac, AXI_DMAC_REG_X_LENGTH, 0x00);
+		chan->length_align_mask = axi_dmac_read(dmac, AXI_DMAC_REG_X_LENGTH);
+	} else {
+		chan->length_align_mask = chan->address_align_mask;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

