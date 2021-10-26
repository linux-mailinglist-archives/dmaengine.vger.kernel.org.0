Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1D43AE75
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 11:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhJZJDs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 05:03:48 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:64443
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhJZJDr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Oct 2021 05:03:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFWdxmQdD9mpLThmZktESYqa+UuHcGjDKTUXlh/8VfBNTG3CbO+cVe2sJu9rY2WmPrh6DmoBHR5SJX3NDf+4gp+yqH1AM20XLtcZa+VDf6cRv5lCCKDZ1ajY1/fcegjs9KsrD1neEznCDx7swYYpf8TUQH5NFe7GTqWAGu3vcQOjHxgNVEHrtvnJazWCaXDKF6ux/c64e3Osud03THlOnNymgVeqVXMGMT3bHjvxeOqzqE/QfVdnjYHlFA7QERN0Se/olTIKDgA7lCLxc+u9/MNNbR6i8jyUQjc80ZdpF8qgIqZY0CCPUMxPbW5cwly9ordcoVkLdJ9YQtvBCpdAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPqfIRe696/cfFKi/P6dU62rTQf9HZWmRJXsY+ntzVo=;
 b=nmirWy8i9Dn6KU1CoAVbp0itnIDeFcLlvlQ4F3+FAn4dhwA9fjFExc7sQQ80XqPKllVZIqds8eG7JDUPg0bY4k85GSM/y04zMv5jXk6qsVYZA1wS0tIlsX2pCcZYMPHjQLc8Ae6pNQXlWtQlnMnD0+/TTEG0wyrtwHDM7pTpmQ1MZteRv2OL5waV5qKtB44AXSs3t45zz4F8CWwlcH5hkL0zXxGNanMh0Eo4aTeUkWaxr3uUwLR7pH4g2clPgytA1CsKEH6JJmyLy1TuKXFTNzEw9hxBU49oh5XLGJJeJvEbDxwytHuUTuT8k3u3IM7eaHUO8um5hzg7eFcc0B+iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPqfIRe696/cfFKi/P6dU62rTQf9HZWmRJXsY+ntzVo=;
 b=spNFeWQwdwnU8aS6taEeuuvgmCnTG2AlmeIe4C0S2088dFjMgW+KFb4nc5XEkQ7R8p8vf9d/TykSB9/L/65+yHsIKuoFALnfi79uMvizblYgV4R26YTPa5eXXdZXCxkeY1Yses2Nk0VvXdhnev/swoRbhZlViFPSOGbU4vKcwFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16)
 by AM0PR04MB5556.eurprd04.prod.outlook.com (2603:10a6:208:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 09:01:22 +0000
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e]) by AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e%6]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 09:01:22 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, yibin.gong@nxp.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/1] dmaengine: fsl-edma: support edma memcpy
Date:   Tue, 26 Oct 2021 17:00:25 +0800
Message-Id: <20211026090025.2777292-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0148.apcprd03.prod.outlook.com
 (2603:1096:4:c8::21) To AM8PR04MB7444.eurprd04.prod.outlook.com
 (2603:10a6:20b:1de::16)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0148.apcprd03.prod.outlook.com (2603:1096:4:c8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Tue, 26 Oct 2021 09:01:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99f1f225-b2d3-46d9-bdc0-08d9985f2e8f
X-MS-TrafficTypeDiagnostic: AM0PR04MB5556:
X-Microsoft-Antispam-PRVS: <AM0PR04MB5556D5916E63C91AF3827901E1849@AM0PR04MB5556.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SI+GnihI3vwayfN4VZMoabPu1E/Ym6RdntZibEHNn/rhytvEaup42JbdtutbCkbFTwUWeC65cCmQsgKKJnoirk87vZfOG91FFRDhOfESB5E8iMn0jgprI7QeRc9zABTNxvY/BFvCw7YU7rI5SEkK1/iYSyQUBd0bFS3bLZiKhrOidKk0s08WTpytevfgq+VlQQjtpaS5pWTPd71T9T7QkLZY8FBJqR7m1jVC4+oq2eeQVMXvL8NNzJPpEo9XA6DNI+8sFgLDlu0rfhBbaKARBWo6rIKDHBSLy4DcjG1sDtn2r4u+yI7OBfWy4zAhVoLWZYSHwocXyb6N/KR1cdxoquUblLMVkac81fcSTIXqmCb7loka+SfP8TKBwaY3QwQ6OaXZYPNVYC0BYfjUzWRHwHs22ZxuN2siB8FVMjtC1G0tjdxR6c0GV9h5VbDffNTO/3pSw4VIt8fQM/3OVjRG6HtF20xg4pF+TnlkmcmepNyQePpzRjF72Mp+iEcz7eas+Ah+sBYaemkgS5dIA3kvZIJoUEYmMaY/sbOqUwJwLmim0lkc9dv5PtahyBKb75B5S0gfH1GBPNXTvDvzIW5k3RBXMZ5XseJ+TTLizmMrXs44s2s4rquh7dmfSLDQVGx2Df3u8r0JjG+NixlNOOCMdIDOHltBuF/FzQ5g3hWamRsKbQw7/RZLhgYevoNnlBXKgQBTYzhVCTE/AjUU7kD14g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7444.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(5660300002)(6636002)(6486002)(316002)(38100700002)(66476007)(6506007)(1076003)(6512007)(508600001)(26005)(52116002)(2616005)(2906002)(956004)(36756003)(4326008)(186003)(86362001)(66946007)(38350700002)(66556008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NCRiZyNnQ4inL1KXy+1WNa6Uik71X1ZJoMhkxt6N84MENzPFbWyCSvEI3da3?=
 =?us-ascii?Q?JvL+s+tC/uiZeZdJt5ibPyTnqSDaG5zl/sNkXeSjKSC46dsJKlC4e5mPj5eV?=
 =?us-ascii?Q?aNn70Ohf4BKxtE3U9UYhC1n5nHBoip1ilXWQ9tkMNIAB2E+0ucWbDUh1rcNC?=
 =?us-ascii?Q?VeG74UjRDWcFK1L2lkf091F/59dRTwXN05mO1K4gIVpapqv/sjlPmidy9r1v?=
 =?us-ascii?Q?TZtEgxPflzgNwOFnJzZeJR14ClLCv8K6wr8djK0ytFdoGUFS97L2I7rlemS+?=
 =?us-ascii?Q?xKioYpRvx18Wlc0od6DOqSuvmP7+aZYDhmHgR9BhXLgSxpQhla5+EawsOUuW?=
 =?us-ascii?Q?Bbawu3hv4WwsWjgeT71UxOYC1DSSBOBHtBRHR5sJkf6fY1v5025zvxK9ZvPb?=
 =?us-ascii?Q?9yNxwFVe7FLDzLYLwDYnU98VXkvq5Ekw4IJpFCvWbwI1AEhYugSurn5C1DgZ?=
 =?us-ascii?Q?kSMPLdvR1WmADbGM6kqXvfxVGEJDLcCvAC2LYgmJfKONEylXf1PpDcAZo5mI?=
 =?us-ascii?Q?ARHsOXU4jMQGiXBxTOeEQe0eK7C5LCUSt4hOm1PVCKGRCLtU/5YVivfDgqDN?=
 =?us-ascii?Q?zFOz5RgJRwrot4TNpJgYitSIS1xz9QR8hcTvTjKETT+KTlFM3NF+LINkZhVB?=
 =?us-ascii?Q?reH36qzeWYSyD1sSART8Ky4ODk3oazpDykkwTs3//sLPXzwIhauxOLFLBaKn?=
 =?us-ascii?Q?/Zb3DQluNXtK8x4ul0cJGSANF+8II/J1Ueq1+BPUgUsY/TolI1JfLuXF/dYb?=
 =?us-ascii?Q?GWYDqYcvNOz51GigNQwOW1bPaAV852u3oIfW/DCAVbAdFmhe8ijFNK/Z2Cws?=
 =?us-ascii?Q?OpNIFbq/brjQG+Gp/p8m/i6+xXjlOihDuPbckvUvyfCliPm3qVRjJVq+Ibo2?=
 =?us-ascii?Q?FaxjkXg5gnh5Woq/39bZA76XuOFX+ylFTvojFGtOTYCSkAufV7D34EmaIA7h?=
 =?us-ascii?Q?fgiC+0gEFY5UnVhS/2wB2eOEEUStzRNigU9qV0SRaxFhBAbKVT3tvnyYPPKo?=
 =?us-ascii?Q?ZmZLBN5/lr6ZI73te3ZnrmO2uQfW5xKRt1cMLTOh5/bBnb/mB5pSj7ayR11q?=
 =?us-ascii?Q?DlgbCszU84SmZu48+wFUKnA33/XORrod5usZ6v4Pl9ej4c1EfOqENZexluu3?=
 =?us-ascii?Q?CKE6NQQ4yFwXXK8paUQuAmmdi4PmGqanAJ1f8a2+tZsejEw3T6yyYaffYE/v?=
 =?us-ascii?Q?HLxqp/3UEJf0jZM3eXkLN0y7vRC9pj9PsBcDQHhkcdtghk/AHfitVKdDHoyz?=
 =?us-ascii?Q?qxAP5EF546o6lpN7kgvZQfzgV0vv+n2La7r1cU0+ntn1FHd9n1PvH/mnCWzI?=
 =?us-ascii?Q?/BYchkjMkLuCCrsQJnmaioP+37N3bqiAw1tPwGAs5qDexB3DZ9VHD10DmdgT?=
 =?us-ascii?Q?IX3kcvJvK2vbg5LN4jMdCOBBaZ7/94ppyGQ0p/0tzrAAtDKOddEI8qfTUhDD?=
 =?us-ascii?Q?wxETFz+WgOjUsUWS2wdxPnDLoFvdTOqcxkxSujxJewRnwm4zLTUrjQHBSTBw?=
 =?us-ascii?Q?pHefUsWdllXVokeQ9gD2AIdLgGtzEgxgMI00L8Vr7eGrr57uZnJErAmE4cFT?=
 =?us-ascii?Q?R9/3BnhI69OcS3uqHkE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f1f225-b2d3-46d9-bdc0-08d9985f2e8f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7444.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 09:01:22.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPaVjqyTHYlVsubdWYZWl9RXy701/NxGFKsH6XvFt5JND6hbHaOH5UwJd6T2iB6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5556
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add memcpy in edma. The edma has the capability to transfer data by
software trigger so that it could be used for memory copy. Enable
MEMCPY for edma driver and it could be test directly by dmatest.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes since (implicit) v3:
fix space b/w braces issue in v4.
fix fsl_edma_prep_memcpy parameters align to preceding open brace in v4.
---
 drivers/dma/fsl-edma-common.c | 31 +++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-common.h |  4 ++++
 drivers/dma/fsl-edma.c        |  7 +++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 930ae268c497..15896e2413c4 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -348,6 +348,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	struct fsl_edma_engine *edma = fsl_chan->edma;
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
+	u16 csr = 0;
 
 	/*
 	 * TCD parameters are stored in struct fsl_edma_hw_tcd in little
@@ -373,6 +374,12 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	edma_writel(edma, (s32)tcd->dlast_sga,
 			&regs->tcd[ch].dlast_sga);
 
+	if (fsl_chan->is_sw) {
+		csr = le16_to_cpu(tcd->csr);
+		csr |= EDMA_TCD_CSR_START;
+		tcd->csr = cpu_to_le16(csr);
+	}
+
 	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);
 }
 
@@ -587,6 +594,29 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 }
 EXPORT_SYMBOL_GPL(fsl_edma_prep_slave_sg);
 
+struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
+						     dma_addr_t dma_dst, dma_addr_t dma_src,
+						     size_t len, unsigned long flags)
+{
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	struct fsl_edma_desc *fsl_desc;
+
+	fsl_desc = fsl_edma_alloc_desc(fsl_chan, 1);
+	if (!fsl_desc)
+		return NULL;
+	fsl_desc->iscyclic = false;
+
+	fsl_chan->is_sw = true;
+
+	/* To match with copy_align and max_seg_size so 1 tcd is enough */
+	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
+			EDMA_TCD_ATTR_SSIZE_32BYTE | EDMA_TCD_ATTR_DSIZE_32BYTE,
+			32, len, 0, 1, 1, 32, 0, true, true, false);
+
+	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+}
+EXPORT_SYMBOL_GPL(fsl_edma_prep_memcpy);
+
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 {
 	struct virt_dma_desc *vdesc;
@@ -652,6 +682,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	dma_pool_destroy(fsl_chan->tcd_pool);
 	fsl_chan->tcd_pool = NULL;
+	fsl_chan->is_sw = false;
 }
 EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index ec1169741de1..004ec4a6bc86 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -121,6 +121,7 @@ struct fsl_edma_chan {
 	struct fsl_edma_desc		*edesc;
 	struct dma_slave_config		cfg;
 	u32				attr;
+	bool                            is_sw;
 	struct dma_pool			*tcd_pool;
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
@@ -240,6 +241,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
+struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dst, dma_addr_t dma_src,
+		size_t len, unsigned long flags);
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_issue_pending(struct dma_chan *chan);
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan);
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 90bb72af306c..76cbf54aec58 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_dma.h>
+#include <linux/dma-mapping.h>
 
 #include "fsl-edma-common.h"
 
@@ -372,6 +373,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, fsl_edma->dma_dev.cap_mask);
 
 	fsl_edma->dma_dev.dev = &pdev->dev;
 	fsl_edma->dma_dev.device_alloc_chan_resources
@@ -381,6 +383,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
 	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
 	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
+	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;
 	fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
 	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
 	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
@@ -392,6 +395,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
 	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 
+	fsl_edma->dma_dev.copy_align = DMAENGINE_ALIGN_32_BYTES;
+	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
+	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+
 	platform_set_drvdata(pdev, fsl_edma);
 
 	ret = dma_async_device_register(&fsl_edma->dma_dev);
-- 
2.25.1

