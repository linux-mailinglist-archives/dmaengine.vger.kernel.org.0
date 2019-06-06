Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F279E371FD
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFFKqD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 06:46:03 -0400
Received: from mail-eopbgr790057.outbound.protection.outlook.com ([40.107.79.57]:31872
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfFFKqC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 6 Jun 2019 06:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzcvRzTx/BX4fb85nYT8X67khODAmxmfCi7faI2/STg=;
 b=AAUTupEksld/zRGhWEquO26iAUEBM9bqbboP7BpN9tcI0pkRaqCO359q35nuDS1U5YNAwGaXnlOST0EOC3GhfI7TUKiSfkDeVLgBfXThDjA+vQREXqBn9s6+B75yXlIrImwSooDa+NGC55GFYCvjWOdXWteXcinxio7pPi/j7DU=
Received: from DM5PR03CA0049.namprd03.prod.outlook.com (2603:10b6:4:3b::38) by
 BL2PR03MB548.namprd03.prod.outlook.com (2a01:111:e400:c26::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 10:45:58 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by DM5PR03CA0049.outlook.office365.com
 (2603:10b6:4:3b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.21 via Frontend
 Transport; Thu, 6 Jun 2019 10:45:58 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Thu, 6 Jun 2019 10:45:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x56Ajvb3013752
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Thu, 6 Jun 2019 03:45:57 -0700
Received: from saturn.ad.analog.com (10.48.65.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Jun 2019 06:45:57 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/4] dmaengine: axi-dmac: populate residue info for completed xfers
Date:   Thu, 6 Jun 2019 13:45:48 +0300
Message-ID: <20190606104550.32336-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606104550.32336-1-alexandru.ardelean@analog.com>
References: <20190606104550.32336-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(316002)(50466002)(2870700001)(426003)(106002)(126002)(246002)(51416003)(48376002)(8676002)(6916009)(1076003)(86362001)(5660300002)(36756003)(77096007)(6666004)(7636002)(14444005)(76176011)(70586007)(11346002)(44832011)(70206006)(186003)(2616005)(476003)(446003)(486006)(305945005)(7696005)(8936002)(50226002)(478600001)(107886003)(2906002)(4326008)(356004)(47776003)(2351001)(26005)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB548;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e553d6c1-1eb0-4541-2a68-08d6ea6c28b3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL2PR03MB548;
X-MS-TrafficTypeDiagnostic: BL2PR03MB548:
X-Microsoft-Antispam-PRVS: <BL2PR03MB5484339E2238BAC40A5EFEFF9170@BL2PR03MB548.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 00603B7EEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9FyIKk0b5hecVkFxRB+z5C3m1YSs4RKh3uNI2Y2zR/j2NIybIpXVhmj9gnz0/Ee6DDtAiMS0SstjbyMR6jj12iklAraUA9IsT+fJbu+Xdz2BxGMKg9IKpJ9GqQGHfgiwX/LXNbWP3ZuF0moOMu0aS5ZXUntSczs9lCqzPhYmPZoUAdPKuhGeDrEcGCgfDjJ+x+NaYe9uBLM5U6++bzXw335R7n3QzJT1jF3fSm8tnc55jbL9G16BTwH2hy2QPy4Ebfe8w96bY41K8miH60DklqmhS1S9L6+/DE4u29OeJTFrNknUl29HIJVNVbpxdY7qtZ43RMtZ2MsO31uB9kJoB8nZ1RG86o2TEbX+TO/wdfPJW+tyErWHrMnBSQhGtlPPleDR3bOG1VeRF331seMSuCXNwsjsfuZB0KnFV8TiMMc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2019 10:45:57.7470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e553d6c1-1eb0-4541-2a68-08d6ea6c28b3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB548
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Starting with version 4.2.a, the AXI DMAC controller can report partial
transfers that have been issued.

This change implements computing DMA residue information for transfers,
based on that reported information.

The way this is done, is to dequeue the partial transfers from the FIFO of
partial transfers, store the partial length to the correct segment &
descriptor, and compute the residue before submitting the DMA cookie to the
DMA framework.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 99 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index d5e29bbc3d43..e0702697e2b3 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -64,6 +64,8 @@
 #define AXI_DMAC_REG_STATUS		0x430
 #define AXI_DMAC_REG_CURRENT_SRC_ADDR	0x434
 #define AXI_DMAC_REG_CURRENT_DEST_ADDR	0x438
+#define AXI_DMAC_REG_PARTIAL_XFER_LEN	0x44c
+#define AXI_DMAC_REG_PARTIAL_XFER_ID	0x450
 
 #define AXI_DMAC_CTRL_ENABLE		BIT(0)
 #define AXI_DMAC_CTRL_PAUSE		BIT(1)
@@ -73,6 +75,9 @@
 
 #define AXI_DMAC_FLAG_CYCLIC		BIT(0)
 #define AXI_DMAC_FLAG_LAST		BIT(1)
+#define AXI_DMAC_FLAG_PARTIAL_REPORT	BIT(2)
+
+#define AXI_DMAC_FLAG_PARTIAL_XFER_DONE BIT(31)
 
 /* The maximum ID allocated by the hardware is 31 */
 #define AXI_DMAC_SG_UNUSED 32U
@@ -85,6 +90,7 @@ struct axi_dmac_sg {
 	unsigned int dest_stride;
 	unsigned int src_stride;
 	unsigned int id;
+	unsigned int partial_len;
 	bool schedule_when_free;
 };
 
@@ -114,6 +120,7 @@ struct axi_dmac_chan {
 	unsigned int address_align_mask;
 	unsigned int length_align_mask;
 
+	bool hw_partial_xfer;
 	bool hw_cyclic;
 	bool hw_2d;
 };
@@ -245,6 +252,9 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 		desc->num_sgs == 1)
 		flags |= AXI_DMAC_FLAG_CYCLIC;
 
+	if (chan->hw_partial_xfer)
+		flags |= AXI_DMAC_FLAG_PARTIAL_REPORT;
+
 	axi_dmac_write(dmac, AXI_DMAC_REG_X_LENGTH, sg->x_len - 1);
 	axi_dmac_write(dmac, AXI_DMAC_REG_Y_LENGTH, sg->y_len - 1);
 	axi_dmac_write(dmac, AXI_DMAC_REG_FLAGS, flags);
@@ -257,6 +267,82 @@ static struct axi_dmac_desc *axi_dmac_active_desc(struct axi_dmac_chan *chan)
 		struct axi_dmac_desc, vdesc.node);
 }
 
+static inline unsigned int axi_dmac_total_sg_bytes(struct axi_dmac_chan *chan,
+	struct axi_dmac_sg *sg)
+{
+	if (chan->hw_2d)
+		return sg->x_len * sg->y_len;
+	else
+		return sg->x_len;
+}
+
+static void axi_dmac_dequeue_partial_xfers(struct axi_dmac_chan *chan)
+{
+	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
+	struct axi_dmac_desc *desc;
+	struct axi_dmac_sg *sg;
+	u32 xfer_done, len, id, i;
+	bool found_sg;
+
+	do {
+		len = axi_dmac_read(dmac, AXI_DMAC_REG_PARTIAL_XFER_LEN);
+		id  = axi_dmac_read(dmac, AXI_DMAC_REG_PARTIAL_XFER_ID);
+
+		found_sg = false;
+		list_for_each_entry(desc, &chan->active_descs, vdesc.node) {
+			for (i = 0; i < desc->num_sgs; i++) {
+				sg = &desc->sg[i];
+				if (sg->id == AXI_DMAC_SG_UNUSED)
+					continue;
+				if (sg->id == id) {
+					sg->partial_len = len;
+					found_sg = true;
+					break;
+				}
+			}
+			if (found_sg)
+				break;
+		}
+
+		if (found_sg) {
+			dev_dbg(dmac->dma_dev.dev,
+				"Found partial segment id=%u, len=%u\n",
+				id, len);
+		} else {
+			dev_warn(dmac->dma_dev.dev,
+				 "Not found partial segment id=%u, len=%u\n",
+				 id, len);
+		}
+
+		/* Check if we have any more partial transfers */
+		xfer_done = axi_dmac_read(dmac, AXI_DMAC_REG_TRANSFER_DONE);
+		xfer_done = !(xfer_done & AXI_DMAC_FLAG_PARTIAL_XFER_DONE);
+
+	} while (!xfer_done);
+}
+
+static void axi_dmac_compute_residue(struct axi_dmac_chan *chan,
+	struct axi_dmac_desc *active)
+{
+	struct dmaengine_result *rslt = &active->vdesc.tx_result;
+	unsigned int start = active->num_completed - 1;
+	struct axi_dmac_sg *sg;
+	unsigned int i, total;
+
+	rslt->result = DMA_TRANS_NOERROR;
+	rslt->residue = 0;
+
+	/*
+	 * We get here if the last completed segment is partial, which
+	 * means we can compute the residue from that segment onwards
+	 */
+	for (i = start; i < active->num_sgs; i++) {
+		sg = &active->sg[i];
+		total = axi_dmac_total_sg_bytes(chan, sg);
+		rslt->residue += (total - sg->partial_len);
+	}
+}
+
 static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 	unsigned int completed_transfers)
 {
@@ -268,6 +354,10 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 	if (!active)
 		return false;
 
+	if (chan->hw_partial_xfer &&
+	    (completed_transfers & AXI_DMAC_FLAG_PARTIAL_XFER_DONE))
+		axi_dmac_dequeue_partial_xfers(chan);
+
 	do {
 		sg = &active->sg[active->num_completed];
 		if (sg->id == AXI_DMAC_SG_UNUSED) /* Not yet submitted */
@@ -281,10 +371,14 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 			start_next = true;
 		}
 
+		if (sg->partial_len)
+			axi_dmac_compute_residue(chan, active);
+
 		if (active->cyclic)
 			vchan_cyclic_callback(&active->vdesc);
 
-		if (active->num_completed == active->num_sgs) {
+		if (active->num_completed == active->num_sgs ||
+		    sg->partial_len) {
 			if (active->cyclic) {
 				active->num_completed = 0; /* wrap around */
 			} else {
@@ -675,6 +769,9 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac)
 		return -ENODEV;
 	}
 
+	if (version >= ADI_AXI_PCORE_VER(4, 2, 'a'))
+		chan->hw_partial_xfer = true;
+
 	if (version >= ADI_AXI_PCORE_VER(4, 1, 'a')) {
 		axi_dmac_write(dmac, AXI_DMAC_REG_X_LENGTH, 0x00);
 		chan->length_align_mask =
-- 
2.20.1

