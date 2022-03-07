Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4969A4D0B6C
	for <lists+dmaengine@lfdr.de>; Mon,  7 Mar 2022 23:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbiCGWtV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Mar 2022 17:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbiCGWtU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Mar 2022 17:49:20 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10056.outbound.protection.outlook.com [40.107.1.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B3CAE40;
        Mon,  7 Mar 2022 14:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYyEk6cMIh/fw5rxnaUaX58A1pMD+x7by5fJxvdA/wKRM3iuJNimuSUyqlHRUgO2ZDqS5enXT9qMH37eMpQH6Y0xPx9nzVpNhawaz/tCT8e66iyzgZMFU8PhWKeLfaEACss6f41YPoevD8n9pcVTZqBOch52hUZPKigpIWbIvtVcXaQ1Sknl8LC21PRVGdidIxfn9/VdKpte4p02HqKcTMCC5mY0SZLmCZCAiBs5qe+Qg4jGrFxYKZnFEuc1rkQXr7fTTgCCoUYjPPPo/Te5F/9XVtxXi+QoGTvPJbkpuYtI4SakUglagZcBY70gqRxu+O6gI0RkwrFOqmrG8+IlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZr0kME42/GY0AQp2i5YqL9e9h+9es8joiFWTrpgRNU=;
 b=a248+LPZvNv+Y0LsRNfcx9OmLhTWSGh4rufLLGy8Z9nlNTkMa5bhASy67v1yDblmaDEscgDDLRLV6tarMzRr2AEL3WPK6q5vhKYElRv0gqL0xQ6dIWLO+NoGFfX2/MjcJEnRigvTfhmpVDW3IwdurlAy9SkfVHTikBXTJkYwR/EPzYtuIkUSsscEJih516ERK6gc96rOWEq32jWESiYuFbJ4XpZ/VxFF9SBAnTp3z71sjGMyNMZKRQXiKu2XgayHYzHuVkpKe47+or3h/fIGnAzPkWLTsrqLdgIauSU10BtdWzUiuFVjddQLS0hj/FoE/TMMaT058q3k+1ZeBmD1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZr0kME42/GY0AQp2i5YqL9e9h+9es8joiFWTrpgRNU=;
 b=Di/YN5myasvgfFceRU/fDNmkTBpbApAz2keyM/dr07gliPWIzupim3bUaF2zwyA1MrE3pH26I8ad/vQiCqhX8xMn9ZSOMjgh2Llgq60FufAWfDRl61FPxpiWnVJWzdGtCuW/ALuo81hpOaOfEmS9x3aDU2HQQfdZ3xESXvoxXr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4946.eurprd04.prod.outlook.com (2603:10a6:208:c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 22:48:22 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 22:48:22 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 4/6] dmaengine: dw-edma: Don't rely on the deprecated "direction" member
Date:   Mon,  7 Mar 2022 16:47:48 -0600
Message-Id: <20220307224750.18055-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bdd930e0-2b0d-4454-4408-08da008c9525
X-MS-TrafficTypeDiagnostic: AM0PR04MB4946:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4946781336AE6DCD31F9373A88089@AM0PR04MB4946.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmMT7pWWkc21ncygTnIzwJW7IsYDCkN29h5bCy2GHBQQULrzjJtTt1Cr3Oa/cJLjQSy9sApertA68w0g+FwNXKPP2tC6DiKYq+EUMlY2vVfziU0SQKTL4VAsGqdNeRSQ053/9YpNbp37OwjZfykzQ2ol0Hi8aioff4o+oXcXnig5al+jhe91si3XfpqovCN55haRzV7xBDKiAN8VhoRzEoCh/Jq6gj4mFrtXeNPeAey2HMEJRdJdp44ZQRF1OZ0JIbYcR3vRavo4jx+oXFj5fsVuBNtFZ0Odev38jjnHRUbhLfiVeLF3bGr3VVtaLEDszIL5JGxNF5jIG1eN2E1Mtmv6Sc0IkhispsGbx9DPeTZcYu+cSkMlZ1bb3jKrYq2sXpLMfTLUplc+VJB1hj5etH25y7KlQpc5htGvNzPMFrVASk9+9HGhaln4wCA8fyALgclzy4g9wKZgKwA03XcqTkELDTQ8uLeAd7fnQ2GCzLwbnzQPR6w+2/HoZewby09VCebAm8I7SCmlSyjNicHiTyI/EW+5E3DShWK2jx5fBidyWGqekRu6Qi6t6jDQM6Z3BLu03aU8yZzBo74PEdYR0c7SSGPP6uiQ60yAMonsb0MTDg8Ojk9boamR9CEoYUMwY+GheSNk6qxZAuW8wdLi2xDU/vt5X4Uia27tQlfP48UdSG4q8TdVbSTKRs9WOdR0kf/iFpyRU3TpC88OLiYXuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(86362001)(8676002)(508600001)(7416002)(66476007)(66946007)(66556008)(4326008)(6512007)(8936002)(6486002)(6666004)(6506007)(52116002)(83380400001)(38350700002)(1076003)(186003)(26005)(36756003)(316002)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vVxnVPJRBytgBSEsdOBo5mwCfFrZfIOgu381dBO5r1528u9S/WvVY0mzpebj?=
 =?us-ascii?Q?bRVPH331rvDSUokPBaVuLl3OhmP4dOf2GIz1u3yF1pVjYALbnuai+huLOfOV?=
 =?us-ascii?Q?qKKU4zjVEIQmAHCTXB5AXbsdq4o/wR4+aqn+dOAJEj5flULCURcOGwRnHbCL?=
 =?us-ascii?Q?3uO6Zo8Meau2OKNSnV8t7cgCLoWAQPa/gm7dfGE3xGw6h09WeRQMKbjVp3/2?=
 =?us-ascii?Q?Wpy4bOs5XI2IdK1pTF2/Qey0bJhEeA8nPTuwpXBaaitP0uw9S8G3LFB4pPBZ?=
 =?us-ascii?Q?3tzdLr4HmX5PBD2brmWsevePvnz8hd4ApYLLmp/HkY9lPsO1E9MdaYso9L1Y?=
 =?us-ascii?Q?8+EhYxtnGzoRQcjGoZ/pxexUWzHujJhLeyfxb2ROV4Mh8kEN2ElB+xPl4dNW?=
 =?us-ascii?Q?biRf7s2L+kO3uECcti5itu637OOsEkcmW+2rgapyqLlDTqpov99O5p6WTdg+?=
 =?us-ascii?Q?GTwz40n2DH/Rhh4UI/Yu3etY5n7L6dGh+Swsu3SQ7qlVbFXW5eHB4+u3C38j?=
 =?us-ascii?Q?hN+cvu1iDnHhzvdSpeCNJTq98kzUrwKWWXm5YSoMVPomSQo9ytqUYHUvN8ee?=
 =?us-ascii?Q?OxSPvijmY9D+JMpI3/f8uZNJALn6IhB/6UQaXZSU11BoJdpTObsZKexP36vz?=
 =?us-ascii?Q?NS5CMj0PPFdeapfxH51IvsgFMuTvGX3pzBj4X3gRNk3jtoaGtQLoZiC0qk3O?=
 =?us-ascii?Q?Or4FrDlOaBWVsmAX/q2pbzR7Zh286OGamXqkf9usPW0PJ+pykRwF8YPzqXDE?=
 =?us-ascii?Q?We/rGbUrdT3sgefLJUaZsOS0mDnXVsLBBVFmMawcG6cf1BScgq1ywRNgGl1K?=
 =?us-ascii?Q?ae0GVIj087o+oXWmKcViNA9IGz7Gv9S26gR2yWlrn6ToNwq933sVgVGt248K?=
 =?us-ascii?Q?17xufGpy53JpMitiN7paimKW8GRgarmiOHSfGQjwmS3af8iz6BWBRAmGVbLj?=
 =?us-ascii?Q?fyCbVVSgZc5VM1l7O4lcj9CKxdO8aVTc1BhM92WoT6DFdpwRqjJ7uud3axjz?=
 =?us-ascii?Q?PeAU9iLMKukY66n1cGCM5cIleg/1pHZnB4qtHmOkhwpRUe9Zhj5U4H5xP6CL?=
 =?us-ascii?Q?nxx3YSl1oY7x6EZf4LCxyhz3TYRZDc7RI7K03M3TRJhvUcMcU+IWZt8oov7Y?=
 =?us-ascii?Q?0Q3ubIf7T4TTEdWZHCr1vuMsq9nTZubFVTZfotxAeASeFOUv0Mc3bVWjdI/L?=
 =?us-ascii?Q?spFbtJS0kFZI3p2N5Cn6/8FV/OSH6Vo3L/gSwtCNh+sGuXB9a4m3BsU35hah?=
 =?us-ascii?Q?Xy7Gg87gE9Iu7wFBCnLUo2NF9xyKAAREI4h1yht9t+q9WAWbrz8aHac4LtRC?=
 =?us-ascii?Q?XaT2Q1Ifv/X89MMEY6HEMU8m61AVn/s9G5KfVZa2EyYwsm5JwNpvgHQFkHIe?=
 =?us-ascii?Q?hv2vET8eSyoDrpbTdqo0Jfx5sUc9E9tUrARJCegtLPhyIeMnIQKkoNSW6rJs?=
 =?us-ascii?Q?3D0yPUc+pR6oPXkhuGVIoS+MDmnF1OhzGiFTae6T6CxlAL+G4KyuD4U034p3?=
 =?us-ascii?Q?mddfkw0stx1c6sRWKO5q3ptdk9f6US2OylbcjJcGr+3TJmORB/zfoCjfC+6W?=
 =?us-ascii?Q?exqFjGwiV9n+ScJyG6DbNUJwQVOljcVQulDd5HCLr4UmK4EEcvG5tHnVRcQQ?=
 =?us-ascii?Q?2t43/LYkm2oOU4xnn905Sa4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd930e0-2b0d-4454-4408-08da008c9525
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 22:48:22.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obikCPHB2etMIBswy4drpFypsuMR7Uvph4qQRfwkuy5nosrCm1s/9aSfqy/fV3i5RDGCqPZSSIdnHQ40IkR6Nw==
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

The "direction" member of the "dma_slave_config" structure is deprecated.
The clients no longer use this field to specify the direction of the slave
channel. But in the eDMA core, this field is used to differentiate between the
Root complex (remote) and Endpoint (local) DMA accesses.

Nevertheless, we can't differentiate between local and remote accesses without
a dedicated flag. So let's get rid of the old check and add a new check for
verifying the DMA operation between local and remote memory instead.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Resend added dmaengine@vger.kernel.org

Change from v1 to v3
 - direct pick up from Manivannan

 drivers/dma/dw-edma/dw-edma-core.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 3636c48f5df15..0635157d260c1 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -341,22 +341,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
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
+	/* eDMA supports only read and write between local and remote memory */
+	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
 		return NULL;
-	default: /* remote DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
-			break;
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
-			break;
-		return NULL;
-	}
 
 	if (xfer->type == EDMA_XFER_CYCLIC) {
 		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
-- 
2.24.0.rc1

