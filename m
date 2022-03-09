Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC04D3BD0
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 22:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiCIVNy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 16:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiCIVNx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 16:13:53 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05C9FF9;
        Wed,  9 Mar 2022 13:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjWqrY6Vyp82H35zhy3VNQTd1PtpFCu03oA/dpy7GqC3hOvvni3HXRQJfsizDB9LgpAbBylb0nViHln661mVVK5yyGErFpVQqpX9ZXEnDOlyEI02RiAqWeoqrnuol91YrqWmJ8RC/kulfcGZX5ODdS+Ehob7fvov/FYOBvF/6PleaEMFt+RoIyERxz6rYhWOJAEQ3YzcbBu2bzVkVcE5c2yCRmnWToyVhvbmPC6y7/XBHYAD0ceqrX0+Y0boqtihsBZc0NI3Ol6n87FDnm88lDYC4IMwQASdnnY/xzLAKF+4y4PQT8lD7S/IUpSRbgiQTVV3RqLWvPbD9YBLEEmk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=472FIKlaO3DakBiBSbd3jLTBFdDZ4qcy2IlKX/rYfLI=;
 b=LTKge4CjffWCcvJ8gPgFAyDXBEaYkM2ChhVvwkCH/SnhF9E/p4fErRGnUtTHu8Ely0qauDZ+/LMA0OWWXo4yx0yYkBP0rbEnFiRKEpsi3e14eNIGmiTu7Tv7EPwyZdG82ugpXO/EWs4slzAYDRKzR8xd+n62xrrm0/cb6oUTL7E3UXZDKnL9nT80gOBda9lmAJ9dfWbXwVTgN89hULK7JDH1Wf2h6LFW+Gf85f0B69s8JD0Vt6H+5MJiLZ2qWc1PCkD5V03d3ptdSjEJ+L3eL8VrZKydheW6sMqpYoi3aVpd2usER90PFv+jYllwlnn1xwKNbYlAgnCYjkzbbTCL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=472FIKlaO3DakBiBSbd3jLTBFdDZ4qcy2IlKX/rYfLI=;
 b=WEOtdhqmsoOxhjlK17UI8VBDsxqEt4TC0ehM6ANJHP8PLppSz/Da6t8t9u3YurGIu0xrHG/KT4auSaoAMrCWuE/qbC554qlPgn5XRkiBK/7RfOLgmETSrXjh4SMis1Z4F+fYQOXGakeRpb1B/i8mQZ/r4XOa+jNDvKcJDGK/tt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 21:12:48 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 21:12:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source & dest addresses for ep
Date:   Wed,  9 Mar 2022 15:12:01 -0600
Message-Id: <20220309211204.26050-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220309211204.26050-1-Frank.Li@nxp.com>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4921c33-cb3a-48a1-84d0-08da02119066
X-MS-TrafficTypeDiagnostic: AS8PR04MB8358:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB83585E53E3AC9AD3AF4B6E4B880A9@AS8PR04MB8358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVNU63sKOxFO4LCu6GQtGLXuGoUCwe/MNTX6iAQ6xFZZiVWDpxGlf+v/JE+S53s6W4Hp2H0Djs4VBffNogwRDVSjoeV2Cob0cqX3o4qLQVCZeYiOMKJOVZ1aQOG0azqrJHE8TNGK2LYAizBLpfw3lpVZNT94iYg0F4njPSaxEUQzqO7D5MkEVWo7N9UwEl1MfONtUvUogdzhFp5Ad6ZzOrd8WdfKBVDn+73VdwEY4L073IT/zoJR7CxD0kJcsxQZ7ySrZqrb7XqOFRvvR0o73+9TgE6onWjKvcjSUrlVpaLu7Ew9dYXAARndv3eCNSFtTOF1Qb7OrG9IPytcACVs7J1N00VqnScc8vvl247KXPKnF2+50h/OqQRDqrh3GWKKiP89GuYv2lNMj2Ng67U2dXyca4YqHkMempeUXiD3WLV2q40kXniM7yo0CHiUs2hd6bTKGiJ2rqpPbV9dHMMHmEYHpQuifQ90Mjyv8Vd/4+jzup28rYr5ByY5XHvi5lrPZq97bP2kyTo1KHj1CdaMbJS9r4NKqr4nkStcgN+RLt8/g8xnpoWt0ksTim9kuEfUMEDPpAvr/5e4GavROsLAjHgeRfA3X2kEqNrOPZXqpoZ17yiacWAqUnveNhcs44h4TuOhZL6DE45W0CjKnWan7em5vjAoKLap8MEUiM+Qrh1Q2/DD/Bkw0ZpzmVTuPDEpZXa/A1t0udzhTfz2b3K6lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(508600001)(2616005)(1076003)(316002)(83380400001)(6512007)(66946007)(86362001)(66556008)(52116002)(66476007)(8676002)(6506007)(4326008)(36756003)(2906002)(38350700002)(38100700002)(6486002)(5660300002)(6666004)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+af0EjM6kGRz1wNivx+IDihRXY1URaqigbRUqU133FppM9IJVybhSw+7AGk?=
 =?us-ascii?Q?ykmCcldQU0O0AhWu67OYzIu+7QQQjohIqfLeBcQp5o6/Rx3uZDhUT0GXqA/t?=
 =?us-ascii?Q?IwqfNUTAZh06DPmLlQ4gYxelug05Ye9roGeZAdde5YJMTYOPA1CBMUp1mzr6?=
 =?us-ascii?Q?xhJ4Qz2ICTuYbxbGDpq+kpUsHYN1qV8iVrAAXsTQQofyR0CjPNSJESEBXVqX?=
 =?us-ascii?Q?nisit3cQyH3Hy1/9MlHU2Bwhdbe6m2s4T2vKIxCBQnlUrLyffZ8+/RnY6qwM?=
 =?us-ascii?Q?NS6tDR3jUzr3iWvOxrFUkx1IZfzB84i0zyixyddbM3MVRFXGMW78rv4rEm7s?=
 =?us-ascii?Q?569rcWOam185X2yXBZNG7xJ/0k0hsi0cW0/gpyoXglO8pX0B7JZeuTYMlWPj?=
 =?us-ascii?Q?tvZs4G58wvORP0dw6+Nwg5EGW/BhtKFa0it/p3NCMpCNYocx7McHh3DKirRP?=
 =?us-ascii?Q?XiEqAQpFycdxZdvbBDv5E0aW6nC/nFP0QCNqjJPl8Sngm7ZBZ5z5XpHaOjoD?=
 =?us-ascii?Q?6TMQIsELFORsmZxNjY7pRCwxGv6hnbujlhB8JkajuHo9DM3ys0hsUaFOjoMq?=
 =?us-ascii?Q?uD6m81SrkTkgNyjIqfkJD/5O2vRmLHTGtbQuYp3RMHt8RWIA1lbwPx9S3WQw?=
 =?us-ascii?Q?LGZ0RZYe+he2QuAS0L/QRjaXyhFRAnB/2+DdcIISQAijej+Ud8noImgcmisd?=
 =?us-ascii?Q?I7RIp5HKkFVT3op9cRFyQZhYdEtG1nc6kIcR70zhfDH4MSe5uu2KamsGUPEG?=
 =?us-ascii?Q?NaTbOZo3IxRD1BCoRF0mE8llN2MUW3YTFHJuIxkK4j+WgR4BDryVMhTJAjnL?=
 =?us-ascii?Q?3rs1MubxIXQbJ3ZjeXCW5Y14gwDc3kw/GaGnFKQHWNrP+gxd0yUlDtgdl1eG?=
 =?us-ascii?Q?cxsrC2b0m8cX3GlkpLQEQoFb+dCCDUgO1oAijItxiUSRaKKqGV6ky8GjYVin?=
 =?us-ascii?Q?FG0FcuzMnLWc0mNQ5Nzuk1QZBTOxoMtjHJ4Il4pwLJnnjgbO92xcHvUilJyx?=
 =?us-ascii?Q?y0eb5xTzbLinPton6bTdzCaQFtNqXXQ8DOuwcZ0RcAQrxsDVtEPjVe+GW31K?=
 =?us-ascii?Q?QgOmmyHrhjY1XgKirkzDHJk7suwN65YlPnKsb4bbKSw82Le4Kxac/ov28uue?=
 =?us-ascii?Q?rNgARDwiKrTVaw7xUPAqedgQC/FAplJkdctR/U4X2dyzwusvSqz6nnK9cbfG?=
 =?us-ascii?Q?EnBAA+xGDG04HH60+8S53uP/72Puo5mN0XNqAAIKltd5KgDxbf+wjbNCfJeV?=
 =?us-ascii?Q?kekrn4eyCQkjsTucW2hCCIFSOjJVdHKxr8ly4yp+147eI2AzcVwUJL8GFe6W?=
 =?us-ascii?Q?lRwm9EyciAy4hd4jNFEZlPutaIE4d2vtiQ5B7Bjjgj4QVhSUt5I6g+HtjC+X?=
 =?us-ascii?Q?vHFi3si4i7Oo1bYanG0K9xLxKgZ37qTOeeYz9jle5pFFcr1yyZhKqBYNUy4C?=
 =?us-ascii?Q?ZnN7Mj215oiZEyS7WWSBwV3/Uw4v8a4qOIT709jT8KiNr6VkpLucuDc4EFBH?=
 =?us-ascii?Q?9+1ipZDKrtGJyLo6xGKott9yBvOldW64JLF390V6ghF3hDLKfbu4R0I8dkWt?=
 =?us-ascii?Q?n9dy47nw4SDhTP0bOl8zLaFpiygp4G6+NgHtil2Ot9+fyaadRBFuBDQ6Polj?=
 =?us-ascii?Q?msMa4sf2vtF9V4q+KXlWfvs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4921c33-cb3a-48a1-84d0-08da02119066
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:12:48.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBUtDhXke5Qh6aZy73o0Sq3ARvh2/33wfqPkhsXhtEdJNRID2wJCGawb+NMuhsuKOdwTGjNdHSwD/5SdtuuYyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358
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
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
No change between v1 to v4

 drivers/dma/dw-edma/dw-edma-core.c | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 66dc650577919..507f08db1aad3 100644
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

