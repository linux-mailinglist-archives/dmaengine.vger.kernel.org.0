Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7532D24A32
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfEUIXk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 04:23:40 -0400
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:45470
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfEUIXk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 04:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raxVxpshZcEGe+GI7X+DGrfYDIFMwzV3JvtAFbzmU64=;
 b=j2L/cBgPmyx1OJP3C9a3mhthpwlAELyViAaXOfYXCywXuqoD2g9lcO5eckru3Qreb4/vm2LVv6GDnjf4JG4EaXcq/qr7spV0gAqxowO67dP2JwVoKPERblxBQfVKloWf87FUNfEG7aQj+tivPx3XMEgDdZdoLXD1+qP+wrsxyQg=
Received: from CY4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:910:4d::43)
 by SN2PR03MB2269.namprd03.prod.outlook.com (2603:10b6:804:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Tue, 21 May
 2019 08:23:37 +0000
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR03CA0102.outlook.office365.com
 (2603:10b6:910:4d::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Tue, 21 May 2019 08:23:36 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT048.mail.protection.outlook.com (10.152.76.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 08:23:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4L8Nak8021500
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 21 May 2019 01:23:36 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 21 May 2019
 04:23:35 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] dmaengine: axi-dmac: Discover length alignment requirement
Date:   Tue, 21 May 2019 14:23:30 +0300
Message-ID: <20190521112331.32424-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(43544003)(199004)(189003)(336012)(186003)(77096007)(1076003)(26005)(50466002)(48376002)(70586007)(6666004)(356004)(8676002)(70206006)(5660300002)(6916009)(53416004)(2616005)(486006)(8936002)(476003)(7636002)(44832011)(86362001)(126002)(305945005)(50226002)(2351001)(478600001)(2906002)(47776003)(7696005)(51416003)(16586007)(316002)(106002)(246002)(426003)(4326008)(36756003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2269;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3892e988-0cea-419b-2721-08d6ddc59f19
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:SN2PR03MB2269;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2269:
X-Microsoft-Antispam-PRVS: <SN2PR03MB226989957651E6E5FC1C71C7F9070@SN2PR03MB2269.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0044C17179
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: nhw74J9eOhpvjbhse7Syv0cssVWtbaOpwpW9hhMFgAl0yA1RWSdNgZDJn5NdA8Wq64hYGxhCzJq6GkaPcTKpVwd4JWID65DdFKFo/lTBv4H02iFBkDdEN7opD8EZNLFS9JoLTtRr642HDsiVCiws18325/5QKke1XjvJxQqHEaAtWs5umLwcGzyerzO+R6WsHPTZvVmIRO1dzlhGfrC518KRef0j2tD0c7CVa1o2o0D4E3B+npxKWdap4oU2BJ5gtZhZhosdTEnn7SEHcPhsrUGYMBjXMY5RtSW6NL4ltULKTkAAt27bigcNpVSIFuFNLqS1fyWbhZjZeSXIhjOvHISuJb1XkfjWYwoIM9BKvAPQYrUlRvPQjdJWFzNMlIVA0o3ur9ZHYGCtvCGZM89C3iBvToGc/cDVlMgL1JC0nd0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 08:23:36.6094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3892e988-0cea-419b-2721-08d6ddc59f19
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2269
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
---
 drivers/dma/dma-axi-dmac.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 0984ae6eb155..edd81ceeeb33 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -44,6 +44,8 @@
  * there is no address than can or needs to be configured for the device side.
  */
 
+#define AXI_DMAC_REG_VERSION		0x00
+
 #define AXI_DMAC_REG_IRQ_MASK		0x80
 #define AXI_DMAC_REG_IRQ_PENDING	0x84
 #define AXI_DMAC_REG_IRQ_SOURCE		0x88
@@ -110,7 +112,8 @@ struct axi_dmac_chan {
 	unsigned int dest_type;
 
 	unsigned int max_length;
-	unsigned int align_mask;
+	unsigned int address_align_mask;
+	unsigned int length_align_mask;
 
 	bool hw_cyclic;
 	bool hw_2d;
@@ -169,14 +172,14 @@ static bool axi_dmac_check_len(struct axi_dmac_chan *chan, unsigned int len)
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
@@ -394,7 +397,7 @@ static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	num_segments = DIV_ROUND_UP(period_len, chan->max_length);
 	segment_size = DIV_ROUND_UP(period_len, num_segments);
 	/* Take care of alignment */
-	segment_size = ((segment_size - 1) | chan->align_mask) + 1;
+	segment_size = ((segment_size - 1) | chan->length_align_mask) + 1;
 
 	for (i = 0; i < num_periods; i++) {
 		len = period_len;
@@ -623,7 +626,7 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 		return ret;
 	chan->dest_width = val / 8;
 
-	chan->align_mask = max(chan->dest_width, chan->src_width) - 1;
+	chan->address_align_mask = max(chan->dest_width, chan->src_width) - 1;
 
 	if (axi_dmac_dest_is_mem(chan) && axi_dmac_src_is_mem(chan))
 		chan->direction = DMA_MEM_TO_MEM;
@@ -640,6 +643,9 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
 static int axi_dmac_detect_caps(struct axi_dmac *dmac)
 {
 	struct axi_dmac_chan *chan = &dmac->chan;
+	unsigned int version;
+
+	version = axi_dmac_read(dmac, AXI_DMAC_REG_VERSION);
 
 	axi_dmac_write(dmac, AXI_DMAC_REG_FLAGS, AXI_DMAC_FLAG_CYCLIC);
 	if (axi_dmac_read(dmac, AXI_DMAC_REG_FLAGS) == AXI_DMAC_FLAG_CYCLIC)
@@ -670,6 +676,13 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac)
 		return -ENODEV;
 	}
 
+	if ((version & 0xff00) >= 0x0100) {
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

