Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6650A2F4
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389608AbiDUOru (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389648AbiDUOr3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:47:29 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10051.outbound.protection.outlook.com [40.107.1.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A6341F87;
        Thu, 21 Apr 2022 07:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lorMEgsQjt4YNIHTZzw3ntlaSrmS7+0H1LhymSbEb4DcP8QkiFCSgLakZfsTr6T/J4vAmAaFiqwb2zE5E4yhgOGE7yN4UwVLb0KFkjAzdHsh4UVAKmYmAgawRRXaNwbT3TTZu2b3k2DMocytWGKKnGULaZEN7vLHsqtemsv3npz0ECyRWDYJYvqnUknSd8Yk2Lwc79QgiEW4fU4EqTBbNLutB6nhPuN136FiX7LRqr1T6C1QzmdWw8pKBhiXCRBwzRFJq/PYoXWl0Uhog7sDjiaqzPS+z0ewvTxq+4bjVIAUTc3EqaOc9KnBa0zUUBzXlRxOxRTYGII4trxwl/MYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYUJkQ8Dp0mqy9iZs/YK4Hyn1gTP4MKjWnN2+JyWvGg=;
 b=FCOa45iGen1cPsUVBXdwVXYlPpkMIGR7XWVp2rhikfLElKR3IzP6IFbv9gogqoITMvXIABZJPtFFlgfXp5Sm3WCcXCXoH+O/7pwzH0eJzTJnoM3ycj26lANKB/5YoeqAKA82Kd3SWXbeh02ufVQ2mitDl8tYT1BIXv/yr2nl79DYqp52IJCHZBz/fiO+bt9/hfEiw/k++K928R01b+O+tRlrR2usVbWU8DMtneqiNAPt1N7MqSRN/HLVQ2Wjf9uxfF5TZHnhA3VvdR74MsCz/59+Oaj9lv3I551Y/xMf1tJZxJf8hKVf98/igGmKdB3xKy4+1ba3xulDPS5lojmDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYUJkQ8Dp0mqy9iZs/YK4Hyn1gTP4MKjWnN2+JyWvGg=;
 b=KzQd9XMm1q+YY2yylZvmrKfbwPh+PL1fzV6MMtmvVVgYhZ8zkQnktwwB4AwDnRVsX7eJhwrdOtCIwZHJFdsFHIr7x3etiKTee5WAtJhc82k9oiEn2bZUrApdEHihT5HeGDbXwKExB+rUQsLm0lsivdKovHhHW0N19zC929jmwQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:35 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:44:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v8 5/9] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
Date:   Thu, 21 Apr 2022 09:43:45 -0500
Message-Id: <20220421144349.690115-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421144349.690115-1-Frank.Li@nxp.com>
References: <20220421144349.690115-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f529a6c-08b0-4588-77c0-08da23a57456
X-MS-TrafficTypeDiagnostic: AS8PR04MB8689:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB868917BCB45495BE6638B47688F49@AS8PR04MB8689.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BHEGXOsWu7NMLUZacYO6KEW17r0QPmhCauNWCwqUgZ31dNpvpMerdyIwjYrtXLqBy6XmXpC/JVJ+T+5xB1rCJdjjxFnDaMHphBUAnx93wbsE7IRzH7pbP9QA6RKtuwG6VqsURlj/Ye3XMa6REiGdLhqyWNeoPg7E63jxEDv+jxtYl0rLxWCsz3hW8SuHlO3vk3SpK1+BJrRZfAtdJdVCHrlyLGlypf4BBVd5vejgpprS2BGvj5VqAOG1SgHcCiHWqYZFe7Ql9e7qNouWhLlA98DDZ+yrErSVYXuHFVkZtAoEt4Ieatqzjrt6UK0P+/AgLTwppkwxJx4g5PZFuT0fNr9A/1VXRqxWIYTGHoMN3RXtNmC2MJn5Y7lhpFv/qILL7ozb/sy1DfkfQNUlLqPY8mWVfriJhRlC8M188gw905WmaRZV6BieJK5Ahuh7yDO0uIHVeluCpIGk+rOmEJeUYdnDiaFWC4ewfk224eGbiE1OKqZETO0J64Y9tc6DP0H1Dw2sIOjJQm5QauduFmYsHp0xhIixdqTdUuQshAuizuC/hZbqhbWRGkElp/FfZO5XTUHV8e8LSFNbr+NTQsWA84N4RJiUUzHm/xJ1314JTu01SKvyXIJIbJ/Y1rbTB4HECiRup10nx62DG+XdGZAYJbbh1ey8phGug8fmFwea5evEOGKVrQEOi2EQ07Y/7repM4crz7DvYTLMruB1Vqi5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(6512007)(508600001)(4326008)(316002)(26005)(66556008)(8676002)(52116002)(6666004)(6506007)(6486002)(83380400001)(86362001)(38350700002)(38100700002)(186003)(8936002)(2906002)(2616005)(7416002)(36756003)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/dhOj6U8vsmOJKbscKyD9yoLKibgfYyvsL6daS5257oQYJ28D3ZGDwwTMcz?=
 =?us-ascii?Q?ajgLwA+OzoGye9MAJdDLMWaqTD1t39tDRk0gLtSL3ezfcipwqLUO8yMmY3HG?=
 =?us-ascii?Q?qK/VfgBuKS1lamVEtq3homs93OA1CC7ZLmJwtQapEOW7QmmDXjdrFGJgJNZP?=
 =?us-ascii?Q?Et9vgHv4pJ9qduWElnfR9v+Nmsk03kGvevkJeZntBWup+RVvqVbuDtIw4CCe?=
 =?us-ascii?Q?u6Z1MeiFNCIqgVY0YkK9u/Ds5b+rka/TBb8uiiz6tJ2L0rXjKmSwwPlGou5s?=
 =?us-ascii?Q?O8fYpcuTY5GiKtglqpdGU4vJ/Nl0XcARwhCSmd+VadmMHe2mXzz36um8DhF5?=
 =?us-ascii?Q?l4thuBFe8yC10wtE31NYKaDuSqq9ZCQfoL6kI661GKH7gRSJy9wZjXk/O5RC?=
 =?us-ascii?Q?RVzj/CPDEwnsx8ApYCzjoIONnjqIY46mi5g12dQl5t9GrCGqnau1VCSx8e8X?=
 =?us-ascii?Q?799hfd2NA3Q0BfGu/NacWBMuFkcmYyUsscIPlF77xD512RnGUoxNdveHyfFG?=
 =?us-ascii?Q?II2eqcqP+wYtUHrjRos1Z7ssASLUseGftkhnKW/fnBmWxkBDNNhPavozLrfu?=
 =?us-ascii?Q?cbSAn6F65mbTtD1xF+Xna6Ha4Pd4MzF9xWPASHBj5PlOx0GZk9mC5qW6ikvm?=
 =?us-ascii?Q?CG0GgXdpZAxeebiAT+Sq+1TyqSI8w9LtfuFGjCKmOfZlDx+kLDpHApYlUJeT?=
 =?us-ascii?Q?IiTUBNceHno7xRwfTjg59esTS0FV8/EGyKRRk+AX4uRh4OkDnldCJp6oxc3f?=
 =?us-ascii?Q?4Pyy+JhSdqBPo5q2P3QL1TrYiX3OLIwAiyI0moQKKkEk07chLhfvv3ZESoSE?=
 =?us-ascii?Q?Agu/K4RNMmlySUxrztfRJfxGrLJtZIoz+MbzIsvJoOkcO9p65nt2eKcIBB0e?=
 =?us-ascii?Q?UmhtR+SXggr4mKXFyBiq2CAwqF2dzo7vDollJlGgDEyQeMFWKPi1faUyjxTr?=
 =?us-ascii?Q?3SuRh7AyNzxBGGo2ImMITNBFnt40LOEgyVbJ8+OvbD3KPU70sORkIpVj/Ejm?=
 =?us-ascii?Q?eaq1IeEv5wu3vpxtfoWN9LQsy1DsSCqN5EOWi80vtGNIUv7/a1Orvhfz4NIi?=
 =?us-ascii?Q?C5pOGhjua8LJTZ0W8Bcg3ccrVWKWLGgngj+CJ59wuZeWxZ2gD4cYoDYai5pc?=
 =?us-ascii?Q?0qQ8Njf/gVY/YuHWtR3UT2BE+gR3CQLAZnSlVEJgXa9STFwHal/v3OiwiGLv?=
 =?us-ascii?Q?PJYUjpgk//TVyDQ+Tazb2+5C4bKgtQuuaY5Ywk/hjLMgwRlKD8Md5V1mYV5N?=
 =?us-ascii?Q?uw37mlxjnh1fncGEowvH5+R+7OBIiO8y+dbicv1csOGQP4JtQ4stkuxfKWBU?=
 =?us-ascii?Q?FB8mWJqaTEhQAsr2d+cdN/T5WPuVdvdnOEhD1eZKdKU2pNY1ukjc5zx8OqBS?=
 =?us-ascii?Q?MnY6xcycmYPlUkmnY0M9BV3/kXI3lZ0NhUyyh5xY2DRPvltrru2KUXxoIgVd?=
 =?us-ascii?Q?TN7R83Pn4HKwJHDacS/CCHsmr923ASaW6ALLibgZCvtHvxGAyRMr4Xmd9Eyk?=
 =?us-ascii?Q?zUFRTHlJd9/smlUnXvF5EjOPWj1YZarEqJp1KYBhr2SWbR6XCVaPGqkhbERB?=
 =?us-ascii?Q?iUqQkDECEeRrZgoGJbDs5cC5b7lAh0dWxf0Zy2jF5HPGTVSOgfBHCkcB0M4N?=
 =?us-ascii?Q?gHbAApmCsrA0M46+TciQrY30iNqo7mhRETKOraqQ/cZP+jl5735zLPU3hDoQ?=
 =?us-ascii?Q?GrH7ld520eKdTnM6nTfmtfqU9eqU7hC3w/e4Wzpd/C+/6B0l4kQuAtuWW4DR?=
 =?us-ascii?Q?dFJ6MoyPcA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f529a6c-08b0-4588-77c0-08da23a57456
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:44:35.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcNE/9LzaXosSBvjLa3IuBkxAa5oY8LaPrZ4fCKxj43vRVLbta7nbhoomEdxXWUP+SCSrDkVOAAW0xFkfDXSkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 drivers/dma/dw-edma/dw-edma-core.c | 49 +++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1a0a98f6c5515..184622be500b7 100644
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

