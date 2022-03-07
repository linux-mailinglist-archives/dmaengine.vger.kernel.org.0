Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67104D0B6A
	for <lists+dmaengine@lfdr.de>; Mon,  7 Mar 2022 23:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343869AbiCGWtS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Mar 2022 17:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343870AbiCGWtR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Mar 2022 17:49:17 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30049.outbound.protection.outlook.com [40.107.3.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB4496B9;
        Mon,  7 Mar 2022 14:48:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfbVL+Z5/dXzplanOlbof0dgh2m1BciRfTb2DL195mR2GRlTqMNIrNcvkp6L+I3uwf9kTrpro8Hj5odNcPrXRjZCqE6lxepdo54zc5ss7Fju+8NhayaxpmFVn0uISRnZT2xi1Ff76lOZlF+FObCWoMc4fS1w2em3mG8qHWTvB7F+Y8XMnR3TPhp4ZjYofBlANXVb6Z0klDJVdpExUvG7qjc4i8gnQqdS6XsvIb2AUiZ+tIRXO3zj+m2wGDDHne+NEFnbppqZILo2dgfmfduToaVKnqZxd/R2ATYU2hQXfZKGZSAzb148My1IhN2xsvsRtl2lmtdLOCOz1NuvkdU0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm5Nao0dQd84uxVyUjyUfIocDzQS3Lopu4mkKoG1/6k=;
 b=Tf01hKISM+WpExh7K4NHyr24SleyLbxYkHseKrJ0+4GDCwHR9LNV/gfHpxANUke/y7lKaRalN+pz9l/UpDn787XAH4wzvk/2fFmWdHLVnUu15GPu5Gl+N6+cxikH7CnHQrdExL9R6v9xSZgY75eFxnP/4iFnyPUEyI97klV4cvfy2tVQapX4u5CQvmdqDN4s/23Ek72djxAbUaP9jAG2kAozTEY83DR+exYODkfX4TdJ16DXmOru5OgeXibo4J31mPlMSl5s3LGVzX5IGp9kS879jcs67SQkG+iiVQqNcx9AnjjJSMCH82WBP+iohmT0uDObqAluBYmiK1C0nN/ZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm5Nao0dQd84uxVyUjyUfIocDzQS3Lopu4mkKoG1/6k=;
 b=HfIAJb0bkDJFb1cD49YUi3ylgPYCkNoXS8mx8QYGhQy2rPfJiAVuk2sbZIQF3caSki8jP29ZxHWHH35HdZL6pfzdfnRfFYFnyAkDz9XtAz/F0I3EELSKid9rP5A78zFeuumAMS/BBdh/j1Jzn7YzrzFvcbScMjL26q7CeDlpqqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4946.eurprd04.prod.outlook.com (2603:10a6:208:c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 22:48:18 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 22:48:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 3/6] dmaengine: dw-edma: Fix programming the source & dest addresses for ep
Date:   Mon,  7 Mar 2022 16:47:47 -0600
Message-Id: <20220307224750.18055-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220307224750.18055-1-Frank.Li@nxp.com>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94affd4-c8ef-4b42-83f2-08da008c92c4
X-MS-TrafficTypeDiagnostic: AM0PR04MB4946:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4946D6DACCD23481753EBD2B88089@AM0PR04MB4946.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uyu2OS9R+XdpMYd/iBjeswNkUF5T+e3Gr7QeraKr5ojPjVrIuIk0ArE+K5y/sa+ldc0/T/w7voex7r0J0ISsNxnUaXQ9VjuW/arc4pZJhDEly6dWKqzPcE+amEzFjiOJN66sfmQ8rt8Z1X5Sv4zNaXXLpEbsslJ+ssPa2fgGWPvEfBAttToa6wtRhpd2FIcSLsq46rwWutD1OEZKbHRrnXBQ/ID+0ExrrPho+Tv7LEiM9xZPTcWSNOrajTPg4x/q/Fk4/vSFX20omJs84K3YuqIeAj2JHymFpKcTL3iZzwrIpD/3Q4mpUqn3nbdoinU8KCKFvf8qqglE/Cbjdnqk07flkjaFBbTI+yW5HVkv3lIh5zaPYSvEZ/mIWxqapUFeySRBfxoZIq/QKWm7f+XaCSkLv7+YcEsjQ6cJDXNLoW8gN2P4mKOwQUEvn2LTikLiBNQX7nDHGy/qdFpILVQmPUwEK4t4i73qCr6/KxgoWaiEGr7fUkbXKkS7P1W0NeayAUQ0cVYOi2WoQ2rFZwqRI4vrGohZ4lnTZt3aK7QjS3gXGN1QTZUDfcKXVWiH7hULuNcx59GLz747e/9GcpJvzo0QZS2scy3k6ydld4b9ZI/SUgxAg/4G9XYVBxzH+0W2T+nJzeJZv4p4825qKaRvKLTIWz1QAZbxTZ+wu1ODHjLA0Fjau0sk8TaqSe+te57gEyg3ulXg9xQLixye9RzpzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(86362001)(8676002)(508600001)(7416002)(66476007)(66946007)(66556008)(4326008)(6512007)(8936002)(6486002)(6666004)(6506007)(52116002)(83380400001)(38350700002)(1076003)(186003)(26005)(36756003)(316002)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LxBoU50vRUYXsU/9e8979OAqi80LzV6tevL904DKh0OIc2Zb58G6m0oNX2BL?=
 =?us-ascii?Q?qzbhof6Y56dgaclIrZrdjV5BqP6pIOPezDb1R6mvlLWoKFArCMEsjONML+XN?=
 =?us-ascii?Q?LrmQv/+kIdNT7SwlynNVH7y0gWoOYtvhMtpnRBHE7Sx3RmdZzQkonGeO76nz?=
 =?us-ascii?Q?IeOahankN2sBx5AIhpTHSj9fqhTFkBxbWlhFCO1ygv0QJ7S9ar1AEVYCeEdV?=
 =?us-ascii?Q?u+s5eN14jHFoo0XboEde3Z89JnfgJKjQEb2B2LhNYvbAwpAhh2A9KjJEhKtl?=
 =?us-ascii?Q?Bef8At228qmQCFyIMqDKXcOTEJBDDyRbY4wFkm1PBexuwfjNf9b1h5oIC4mM?=
 =?us-ascii?Q?u4y2jyReByEGoIjaxHAQmOlPyAeMEccKEdMzJ3i+jl0IAiTy5K4CfdOqzK5c?=
 =?us-ascii?Q?PITmHZWDitXB2yQeEwA0+Qd8r/zsWPqNFrhKtk9dwgkbBC4X7L/4z1kzeuY7?=
 =?us-ascii?Q?wDX5y7EHoKw5PUHzZM4NaZMuKWbBSTRpNCV838V+jXu8guGBipqdFR2t7agA?=
 =?us-ascii?Q?l/6WQkiXo1eN5a8/ibqgUTxLY0t9xqMKgXGTxIb7IXpc8sOpqMP7277zfSbM?=
 =?us-ascii?Q?Yzr2CUDeKHfSq0GGx2D6XNLv8nBd/689gX4H1F8XyNP/0CklPM6np2+3dCNo?=
 =?us-ascii?Q?5UKpyIxdhbCq9+Kp1VtwYq5kHASFYDYz0VIglvljRjz3odjM52PB93R62sV1?=
 =?us-ascii?Q?xmk8p5hat9xb6KgKOxzCk47zai1XdUI8hLK0tZdCiOi1+1d9EOPh98PucyUL?=
 =?us-ascii?Q?xMzscXWXUDam8H7Ni0navB+9hW06DB0i6DeO8ah3UbkWucybtqfdC7HmFZIz?=
 =?us-ascii?Q?CXLEhAriZqb/4PeeYgquIy8lKgfNneJotE4+EhtBwrU3wAYwiz6LC9W9h7TS?=
 =?us-ascii?Q?CW5mogYjTA7hE5fjzKZ9H3qBtnYj3pxUL6PVM6fPCV6WMPCzN0K0MxqiZV7q?=
 =?us-ascii?Q?0PrDyp63p0ajZg+4kjHaxTe8PqMYQIrtYK6fOsrL5fSDNzo7COBSl5RhBUHt?=
 =?us-ascii?Q?vp2DBtRXmmfCElJcXic0PIEwn6eRS8brNILXtrYb/SOniIMFrVaeA+DroI7Q?=
 =?us-ascii?Q?eJc6jccU7dlYmxGMjBURNlSAs0ogC03e3oXmrl/P1SPsBudtAGgoO+g8T6ur?=
 =?us-ascii?Q?jv+bYerPVCuY0uZIITZmtCNWzl3bObPtytLml4/ZrFZHjnMgP6dRtJm9L1ra?=
 =?us-ascii?Q?NXUPylBrvl08cQgdMGphjtCuZpsyVV1jMdT/W5npYAMsK3BsWTVlo4TPk+sa?=
 =?us-ascii?Q?DfmFWXUn1xgdjBRHicGEPx2eLkuGO1l2HxAREvfvGa/1bB8yj39mSXp+WddE?=
 =?us-ascii?Q?iEJGs96kEDkMr+7zght8gNI0ARmvLtnxJxD8RfX235EpljVy/J8Z+eEKKy8E?=
 =?us-ascii?Q?9Mb9RRrihOuCIh0jUONtGFZ9aLtDQjacgr6ExjZUxpzYzaLnoZxoGaE7g2Ch?=
 =?us-ascii?Q?dkQ1WExwttHSouJ7M+tDnkU16gs6FOesk88JsapXMCAnYJLEZ7pxpiSLfk9f?=
 =?us-ascii?Q?GWC+S6auPcIGsZ0ojDIp4FfmkSQgk4bdkLWiOrWNPfQ2f+0H4DECLQwyBAOH?=
 =?us-ascii?Q?lRcXfUahEUaSwlz+xMU59fAWew3xZQ1W4yIfG7JjN838CBTeggK/GjgnnnvQ?=
 =?us-ascii?Q?y5mEXKdF7PbL/rx+MidgOdc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94affd4-c8ef-4b42-83f2-08da008c92c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 22:48:18.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pwg/n63VriCax0aSLs8w/D4SxfaKPkl5+0vOhE6j37XB7MltWhvcOkwqa5mrC+/sg6uzg7FgFwbBAqJDP1OArw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

When eDMA is controlled by the Endpoint (EP), the current logic incorrectly
programs the source and destination addresses for read and write. Since the
Root complex and Endpoint uses the opposite channels for read/write, fix the
issue by finding out the read operation first and program the eDMA accordingly.

Cc: stable@vger.kernel.org
Fixes: bd96f1b2f43a ("dmaengine: dw-edma: support local dma device transfer semantics")
Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Resend added dmaengine@vger.kernel.org

Change from V1-v3
 - Direct pick up from Manivannan

 drivers/dma/dw-edma/dw-edma-core.c | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 0cb66434f9e14..3636c48f5df15 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -334,6 +334,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_chunk *chunk;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
+	bool read = false;
 	u32 cnt = 0;
 	int i;
 
@@ -424,7 +425,36 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
-		if (chan->dir == EDMA_DIR_WRITE) {
+		/****************************************************************
+		 *
+		 *        Root Complex                           Endpoint
+		 * +-----------------------+             +----------------------+
+		 * |                       |    TX CH    |                      |
+		 * |                       |             |                      |
+		 * |      DEV_TO_MEM       <-------------+     MEM_TO_DEV       |
+		 * |                       |             |                      |
+		 * |                       |             |                      |
+		 * |      MEM_TO_DEV       +------------->     DEV_TO_MEM       |
+		 * |                       |             |                      |
+		 * |                       |    RX CH    |                      |
+		 * +-----------------------+             +----------------------+
+		 *
+		 * If eDMA is controlled by the Root complex, TX channel
+		 * (EDMA_DIR_WRITE) is used for memory read (DEV_TO_MEM) and RX
+		 * channel (EDMA_DIR_READ) is used for memory write (MEM_TO_DEV).
+		 *
+		 * If eDMA is controlled by the endpoint, RX channel
+		 * (EDMA_DIR_READ) is used for memory read (DEV_TO_MEM) and TX
+		 * channel (EDMA_DIR_WRITE) is used for memory write (MEM_TO_DEV).
+		 *
+		 ****************************************************************/
+
+		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
+		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
+			read = true;
+
+		/* Program the source and destination addresses for DMA read/write */
+		if (read) {
 			burst->sar = src_addr;
 			if (xfer->type == EDMA_XFER_CYCLIC) {
 				burst->dar = xfer->xfer.cyclic.paddr;
-- 
2.24.0.rc1

