Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3452A5F5
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 17:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349855AbiEQPUH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349851AbiEQPUF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 11:20:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150050.outbound.protection.outlook.com [40.107.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE153B579;
        Tue, 17 May 2022 08:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=labGmK8gLRquQbygZBV2QjNC9SVVUBCew6P1tID6v0XBPfIx5LUv2SUSFo5T7VLV65SVEC16sqMLhIKxB9BTVxH13Uf93QoMmVUEzszeZpjxiyz1ItcKtcRD7QSNacpxUQBOAKKyHtBXcZdkMEHVs2+DDFtzJNg3n7ko4X1mW4PiKCYxk73datHFGmPvUs/nGIbPBciBcZp2CkESK2ZrPJHdJaF9GzbZorXZgemo7lBk3nfm2+qecvAqfCnomlWqG6YD3CxAJuPbuDWMYCLl42tmOufzbGSyZ0ME8HOiTckHj7jpfK6PECCM+bSjpNutdvNfixGcu6kd+iiO2hZggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6PYFWLjdxdEGOKFifXzCyQb8b2XDlH4k/Z9xT9L3lA=;
 b=e2jghIQpOgzvxAYbl5RI2DYboLisOTaa5zqnFOPUw+TcVFGU0JlZbywuNyFKt/vOq+cRVOSw4Gt8bI1J53MEbZwyrOgpMR7ks235VusfCdibzGPtcK3/ZV3e2WgI46zHEjy88XuBOa9gdpsZyl3OCBxXWhC2eF1DaklJuO+Sl9VibGOy+fsf7VpiYdYrgQy+qndK/eMCavkm7rijC4snFCwWNpZqDZg+enELQLozCzVe/zOhggH9BhkmUc1V3vATPrGx1U/6bB9dvpSJwnRPY1GrvNAQjohZ3lYZT814PphqTwEf+jpUKQiqnRRnsbzk94rZLUXha/52HsJU9v4seQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6PYFWLjdxdEGOKFifXzCyQb8b2XDlH4k/Z9xT9L3lA=;
 b=PwQSNin7AsK8Hqo7TTGA/c9e0b2ixbvPetcq4tgX3ZQsskrGSxIAiZhhHnwPhBIjbdyCKXn66lQ3c0uC65aEwnxNU+mT1w+VhRoKa7M7CHJgNvJMexVRfC6rCenDsqpc5MJMLmsrbDPUmO00lekxZxegDnW4KBUO+ZkuBHKjc2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR0401MB2285.eurprd04.prod.outlook.com (2603:10a6:800:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:20:00 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 17 May 2022
 15:20:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v11 5/8] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
Date:   Tue, 17 May 2022 10:19:12 -0500
Message-Id: <20220517151915.2212838-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517151915.2212838-1-Frank.Li@nxp.com>
References: <20220517151915.2212838-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94193302-3159-4f6d-54c4-08da3818b579
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2285BDCCF90C9642409520A588CE9@VI1PR0401MB2285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kflU6oI0fgdaOAYQ10V6k8R5TO/t2OITxQLrk4PJXer+ciNbVwVbUBdktPTld9WOiwd1jtq/47iy7c0aj3GZZP5iMO5a/29g9Z2xncsJZrAOrFypa9Sc8jSSDhqHhoNk6nhHVo7Jc29R8P0KeLMVHLIwTfZvG4ZB74LtP+nZZeVEkUfzes4Q654jsNa7h5U6n5TtkHTbbnWVZTDu4vR5Mn9ETMrCHB1xgVX6Zf/uqF7gbQvLxF/yDgb9k/8m9sgjkNCl3nigMWgGxEMKQNEg4QPqI7GnY3CSk1TITBpbBJ0jcjTK+Rmxtt13R1wqIQhTykgwo9k7jQmpMWLIBl/mtTgeETVcjLLtTiAs+A9qZabq8KQSGvA7i0A/Fd06knBc6TPnTL9r4YPp4aEk9MYD7/QCZ3SKWm33+7/B4Phdd9/rCFXefrn6gnAu4Q1NM9nWfPAYh8d7Gs5XsEwG5uoRER/vLlD0jupqU+5UhTbidIQnfcLEc+dTgvPo+4kh6rl/ASghBNvVOjg5IjoT9a1FNGQ9SCJHQYhSiFW1RuTJj/Sa8HDWTg5NKQIYC+UA68ttdwDiviWCGZtMjqR65due4p6780wSYn6UPd+xoiaCfEJaSKqeXu19xaakyRYKVFSOJWLNgazQNPRmSz04pbUOioyXqmqgB5wGG3RN3nTnURj1/Vg2s7JTiZ1sJtF3uqDoIvaWQ18SUnoY13zP3QZtz5qwSzjOykyYawCi1cmxDK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6666004)(52116002)(8676002)(6506007)(66556008)(86362001)(36756003)(6486002)(316002)(508600001)(38350700002)(38100700002)(2616005)(1076003)(186003)(921005)(83380400001)(8936002)(2906002)(6512007)(66476007)(26005)(5660300002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xX4waKt38lxbYPOxnrQ9PRdRcsa0XyGiS+/Q22HjvGYq6tcSdYO9h+CEwLKf?=
 =?us-ascii?Q?ppMDaqTIzT1/S0PUDrSscjni8sc80d6pfXQAng7Wa5+d1ssg3tWkIznRlAoc?=
 =?us-ascii?Q?EnBKHY8F5c4yO2o9i5xQQ34HfEMfP1dcrwYlyYUGqZn8foWyqNUwUReYG4SP?=
 =?us-ascii?Q?RCoAr5re3aLiilRW3q0bGlIBKq0YyjhwYT/PqW2Sbv/Yu4DHmcoStwEZOY/w?=
 =?us-ascii?Q?khOHiiwCGHSguhZXTcr16pr4UzQs/VBRGx3k1wIlWp19MZNxPj5AW7SvulV5?=
 =?us-ascii?Q?iuDoFLiqfLYcDAraqd8seToLT12UbspSS1D/yUcAoWI6j96HwZEXBBRO7EiG?=
 =?us-ascii?Q?IcC/qf+J+whM7xKf9ZPKpoWVXGTvmu1FZ/UzqSD8NUGYwQ5q3UaG4Jh1Y7EI?=
 =?us-ascii?Q?lwhH6ihsvtb55KuppR/j4rHHc4rz1a/bY6of6SELVy8d5Q3ZgmTspCjOQOu0?=
 =?us-ascii?Q?bOAIkwSQLf+4KaGgWLgSc4xXuSqTEENx9NrIzs5x5kFcRsz9yeOsFX0WZLC1?=
 =?us-ascii?Q?h8cl7RzFFk3tNO+RbvFUKlqunXsCCRiVPxTAShw8Ol6Inmd2eOboAnNZCAj1?=
 =?us-ascii?Q?epAVhp00vuVvfyBwA7zPeJvlizIL8mLlst4zrDfaQ0jWkpoYVH244n23rEv9?=
 =?us-ascii?Q?COt83aTWFFNGkkyE2UuG1mP/rGSYaamFPAKJlRYkIjh731Ol5S7UGCbOnQO7?=
 =?us-ascii?Q?Oubxl+hTuzW4QTgR/f2Gds8r269h/jOIehV4Ike7h7eJb4loSIN2WjWlQ5mn?=
 =?us-ascii?Q?CKwMLUBhDK8eVs6emvxOWl0SLGU6ii3LOakNy9ihne+xcxSRBm2BnQUaCGmC?=
 =?us-ascii?Q?OTl9pc/hQzxRU1IpeNeXc5cAqAuSG6mWRu8BelyndqMTOQ6fMWLNhgEt0CP9?=
 =?us-ascii?Q?9U1d6R6sPJrXGUTlxf1du3bt9NG1GzJ0FW2SUPwdtHEAZUARX2NS2HOEa8ML?=
 =?us-ascii?Q?GqDfm5G5CbFQlQB3E+3dJFhMIS3c/6EojpN2emAigIICNDybRbO76G/p+buF?=
 =?us-ascii?Q?q79M1ciZJjRpIMwd9f6eTZYFsS8yOsK0p+yiRlSkpEnrlchhWDjYceFBvK8/?=
 =?us-ascii?Q?qKJzNXvyDrkkaz2cQe1tuDCu+bzkGQiaTOCUBwKY5LMvparsQks/ZoGYqKmM?=
 =?us-ascii?Q?2t5mNeQ+hLD3kD/TDcf1Rwm2g9upVjeaWVxtRn4AmtHnPTxKvF6z0yn3bSWW?=
 =?us-ascii?Q?TxmbQ15l68/wG7zJHI6TBHfS0BsoGdMqRVKnuKoe13kD3LG+mubOhKIgyrHz?=
 =?us-ascii?Q?jIhvhYsaUbsrvccnJsA1X1v1ne05o9t65IqpZNXQvMhGPudcnoaBddegESqK?=
 =?us-ascii?Q?tfh5F+ivccKZB24h9QRWJu5gs/7SFTQlbUXIuw+I62+yc1zL89souBQshEA+?=
 =?us-ascii?Q?XI7sX63YrDPskmIbUVv0CQ7nQMEMoEPF0XC4tc3erN+MewW820A26mGkRIMg?=
 =?us-ascii?Q?OcesWxumZlP0ctHr05GBcFPApUZEYwG6z28IWr8LyEJ1xVrYiaEBAFFzcdjt?=
 =?us-ascii?Q?5iksWjXrVryAUp/hyDqKlrTjZJl46PkmN5pDob5Vzmcn8bvIJX7qFGWsgo6+?=
 =?us-ascii?Q?aHE1bDG+jIMnYZforUmDW5OlfkBpxSZRrt8peDX3ZTmbYmW+BaDmAX+pugUL?=
 =?us-ascii?Q?lFlkRl4VFrjFCgfZ1FiRvPCB0soKJneg3ELRDOjfPZ3CLpyQnzx/gp/sHQyf?=
 =?us-ascii?Q?4g9AftBzBXKwvBorgvdsVvovyZCi9yrF/q97Ocqp8E3A+C5Fp8lnQx9aXXG0?=
 =?us-ascii?Q?qJGnvlHS1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94193302-3159-4f6d-54c4-08da3818b579
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 15:20:00.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eS9xVLIPqKjm0Bv1VRxDa0+w7bYbIy6px0IQ0+hrGx6kHjh7OgTg+kyKsNICGGjc5iN7sRE2v6UZDZuBj8+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

The dma_slave_config.direction field usage in the DW eDMA driver has been
introduced in the commit bd96f1b2f43a ("dmaengine: dw-edma: support local
dma device transfer semantics"). Mainly the change introduced there was
correct (indeed DEV_TO_MEM means using RD-channel and MEM_TO_DEV -
WR-channel for the case of having eDMA accessed locally from
CPU/Application side), but providing an additional
MEM_TO_MEM/DEV_TO_DEV-based semantics was quite redundant if not to say
potentially harmful (when it comes to removing the denoted field). First
of all since the dma_slave_config.direction field has been marked as
obsolete (see [1] and the structure dc [2]) and will be discarded in
future, using it especially in a non-standard way is discouraged. Secondly
in accordance with the commit denoted above the default
dw_edma_device_transfer() semantics has been changed despite what it's
message said. So claiming that the method was left backward compatible was
wrong.

Anyway let's fix the problems denoted above and simplify the
dw_edma_device_transfer() method by dropping the parsing of the
DMA-channel direction field. Instead of having that implicit
dma_slave_config.direction field semantic we can use the recently added
DW_EDMA_CHIP_LOCAL flag to distinguish between the local and remote DW
eDMA setups thus preserving both cases support. In addition to that an
ASCII-figure has been added to clarify the complication out.

[1] Documentation/driver-api/dmaengine/provider.rst
[2] include/linux/dmaengine.h: dma_slave_config.direction

Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 49 +++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1ef326f7151a3..3ce0d7600da64 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -340,21 +340,40 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	if (!chan->configured)
 		return NULL;
 
-	switch (chan->config.direction) {
-	case DMA_DEV_TO_MEM: /* local DMA */
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
-			break;
-		return NULL;
-	case DMA_MEM_TO_DEV: /* local DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
-			break;
-		return NULL;
-	default: /* remote DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
-			break;
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
-			break;
-		return NULL;
+	/*
+	 * Local Root Port/End-point              Remote End-point
+	 * +-----------------------+ PCIe bus +----------------------+
+	 * |                       |    +-+   |                      |
+	 * |    DEV_TO_MEM   Rx Ch <----+ +---+ Tx Ch  DEV_TO_MEM    |
+	 * |                       |    | |   |                      |
+	 * |    MEM_TO_DEV   Tx Ch +----+ +---> Rx Ch  MEM_TO_DEV    |
+	 * |                       |    +-+   |                      |
+	 * +-----------------------+          +----------------------+
+	 *
+	 * 1. Normal logic:
+	 * If eDMA is embedded into the DW PCIe RP/EP and controlled from the
+	 * CPU/Application side, the Rx channel (EDMA_DIR_READ) will be used
+	 * for the device read operations (DEV_TO_MEM) and the Tx channel
+	 * (EDMA_DIR_WRITE) - for the write operations (MEM_TO_DEV).
+	 *
+	 * 2. Inverted logic:
+	 * If eDMA is embedded into a Remote PCIe EP and is controlled by the
+	 * MWr/MRd TLPs sent from the CPU's PCIe host controller, the Tx
+	 * channel (EDMA_DIR_WRITE) will be used for the device read operations
+	 * (DEV_TO_MEM) and the Rx channel (EDMA_DIR_READ) - for the write
+	 * operations (MEM_TO_DEV).
+	 *
+	 * It is the client driver responsibility to choose a proper channel
+	 * for the DMA transfers.
+	 */
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		if ((chan->dir == EDMA_DIR_READ && dir != DMA_DEV_TO_MEM) ||
+		    (chan->dir == EDMA_DIR_WRITE && dir != DMA_MEM_TO_DEV))
+			return NULL;
+	} else {
+		if ((chan->dir == EDMA_DIR_WRITE && dir != DMA_DEV_TO_MEM) ||
+		    (chan->dir == EDMA_DIR_READ && dir != DMA_MEM_TO_DEV))
+			return NULL;
 	}
 
 	if (xfer->type == EDMA_XFER_CYCLIC) {
-- 
2.35.1

