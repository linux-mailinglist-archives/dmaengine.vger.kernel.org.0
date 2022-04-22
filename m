Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CDB50BA47
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448738AbiDVOkN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448748AbiDVOkL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 10:40:11 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E555BD1A;
        Fri, 22 Apr 2022 07:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVILEzarXfNvldznhBhdbwl3RVf76ZdRAqqz+6Kwfesa/USkWDgv2XiTtsNkE1ngaiVH/jjNHG20CJeHbL61trqc2egfcXfC1K+CoeC94wFjrISTTcyIs+5wS0AXTWH3+U9R4AD72O0hfQ8YUa+FrRBdm/HLsAGtjP/nx01m8dTfvNCauevBmg03Ixgu+SleomXPVXUf5KIT8xu5KnIXrYxI75RXudL4guJ8hhNi7lfegGYSyGMIMRRIwE6zQqXJlUAsacdMRnxUDXi/mnS2hOJsoIX65OkDvRrmthHFEi7BhOXcEiRu0H+qQcrnvqXyL6fNys4jO21UwXA2klTvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYUJkQ8Dp0mqy9iZs/YK4Hyn1gTP4MKjWnN2+JyWvGg=;
 b=H4bsj0xxbOtT2ibDmEuANfPVIiVr0xkEnrfr2dSWFs9cCq/sQ+O5vhUQ+X9WiPf+DmhG+elSZayrIx/2iimJSk927V8ccw6D4/B6z5ohAFg31+nX8zEq9cghEHDHHasE73LvTEA/pjjIum7fa2rAW/KM1ztS4lT/IrVy/8gDWjsxAy0rw06RjteWGDQMzbXGpDDSWYfi3MHA6zo+F2WmY+xFXQn0uXNVqdLeWpokyYEptR5ido7pNog+ed3lbyWXYl8772L1OTKD9BlhCXzYE0166+MsE1ps/bcDd0iEK2ao8/bFq7UTK7MYT/jq9tDtJifxx/hFS9HglNuVTqjSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYUJkQ8Dp0mqy9iZs/YK4Hyn1gTP4MKjWnN2+JyWvGg=;
 b=FK99emWfEy4XsQIJrvatH6qvoU6foOEiE5NZSQOK6g7DayE2OUFnPwLSsJ2emK8c5JQEc1FI2KqGDfFiZBUqm/0+vUal1SZ8kj8AiPGiEyP2AqSqtgqx8M9YVB/lmLxRKb1MxO0tRjhJply9um/4z6fDKm6VPUiIEZ3ymmtwmXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2644.eurprd04.prod.outlook.com (2603:10a6:203:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:37:15 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 14:37:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v9 5/9] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
Date:   Fri, 22 Apr 2022 09:36:39 -0500
Message-Id: <20220422143643.727871-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422143643.727871-1-Frank.Li@nxp.com>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c826fe2-ad26-49e6-dda3-08da246d989e
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2644:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB264433AE81E6231D6A2FA7B988F79@AM5PR0401MB2644.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sf8hund/t7TRkUZpN1bEsHLDPizlr+elQWv9CPqjiGrF9RaBAHZECgaSIoOeKx2yudr2W1dG717BsBK7IRgMnd3O4KXt7N0CfrsC7NCw1Xl0OVXW24uJeizEw09umTe0xjrSbim0/RsL/XkZvftjvivt8Lxi52TvCmMzzDSUKnxapA4xg8mD7tQsMyoi7sYO2MLwGGiFiKd+L3AWNTbY/iqzYA8xo+AQFvl1icOFJ92Yiu+YFXc7nor9W/MGS69z8SqeMBTQVCZvGMPJj+NfIFWSclaSFEzQ63Kz8x4Ni8aXtnPjRm/2NimnzMDASKVAoOhuH8KT34m5asEZ6sG6rywhGPf0XiA8nZlANjt+GudVH+LfPO/XaxJ8xz9jw7uULPfV2Lid3E93QgDSbvC0f0RVWKnQWVoxiNhuKAvrNPNdxx+p57JIabYo65IHtupCClYECkx3VhyE95JMnXj1aYzOeCBA9pX+iTSzppHuj1CnG4hTCpCRZTDBy4Pfba+hr5c3l9MSZU1+KsHhniZ01v1Ug0LlxHOdLfOFGuKK2KQ4Mh0uklhxWHdrS0QqatAUw47dcnCjNZgw1HCWjR49Qt+fSps5vzPQveXTKZcHYRdq66CjBgQV7oLXBYPGfhStIfUXwu7AznynKQ0KHbOu4mBKXcOU6qJBlqHwFSLqhlNYspTpiQW4K+WXnlxnlka8i1EeSo3H5/FhvIIS8ZM3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(4326008)(6666004)(66946007)(83380400001)(508600001)(5660300002)(6506007)(86362001)(38350700002)(6512007)(36756003)(52116002)(26005)(38100700002)(2616005)(6486002)(66556008)(7416002)(8676002)(66476007)(2906002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCDwlmSK/KkD0tMLTH6Twx6yPvcTiOsXflXoe5PkS/YiZWa5551/WBdKWZuW?=
 =?us-ascii?Q?28SKipCV6/JuKjeQB2Uq/ZJ+ng6sMx8dRqVXJBwbHXhfX+CVVeNzeT4UB1yu?=
 =?us-ascii?Q?Zn/qP4+co/igpSg+mVsO9Qvh7pH/+ZtlmLhKUMuTQXVzlbSQKx7ZXtRsDqHb?=
 =?us-ascii?Q?M0PKkYdz0O3jGBiZdgpz+V0t4GQGmpRpuZto7WxJlyxABmiDvV8T7kT7wDyL?=
 =?us-ascii?Q?ijfJkIAGwOYDOrF9XpivgVjE+ULV5fYx67GAFo7W9SlgNimpWwm030vCu567?=
 =?us-ascii?Q?cdCvK/dBONEfAwiEUYPOQfv3YoWKlAJ3uczKaWjfs7hiC5zLGt4TFyYQVklO?=
 =?us-ascii?Q?X41T7HRV5QeBRzPa76i1NPnaoTA+fSYh9HM2qlSCETrRAZpbUrkxLDVS1xoO?=
 =?us-ascii?Q?jKfh2I6/DYHMsWN3tQcqaGxIVxTbABt0WEDKDLq0M1kEC7k4YIckN3VCOfuZ?=
 =?us-ascii?Q?13KYCcO0sALiz3/yxDnasI9+wPp9WZwXQfl1WzTA6xK7jeSHYKPVKzOkyPPi?=
 =?us-ascii?Q?bPPMbvcVdMNU86115IvQ9HsjETDi0Cvvw42PvEioS9H+wEFP33rcSfd9FRv5?=
 =?us-ascii?Q?F6o0YoctY/B4j0dRbFA62+K5Y2lHtOGGFcggt0RIKpSTEeUN+5dI1IoAxJJk?=
 =?us-ascii?Q?CHLIZe7GwNU4CtJDjC01dhmWCYlYSRYmqXn89/kvhubXMSGHcIXMXqdXpRQn?=
 =?us-ascii?Q?OevlPzsKVB1LCbGfCWh0YFupsjl+cDpxA6ENuMBCnURcaljM+cQRbQ7l7JOW?=
 =?us-ascii?Q?vplDyvqAa90F/dm/zxoyD7T1JByp9Ck3yi7ivunIz9xz56gnqYaMkQ3S3b+K?=
 =?us-ascii?Q?+ED8vZSTK9wDwiWOVwBDFH8B7Kr4Qywjf9ZkKSKAc/7PEk0CTbHIhoXurDR2?=
 =?us-ascii?Q?Ni99gz4fUvHXojAXAzOiPQv1qS6CrpLkCnADW78V3AHCYkkJA5EIkVoxSaa0?=
 =?us-ascii?Q?J1REYjhBIiGczJakubRZVTe2t0ibdf08FUQ9mzZ2QcaIgoLcgTpYhqb7PLAp?=
 =?us-ascii?Q?kAg2bHCjmManoiYtKCiO/A4nLooB/oS9f3ywyyM3k9Bj9SXCjK68Fd7BIBcH?=
 =?us-ascii?Q?P8a2bVXVF3yurO+65p8681eJ++N8fzT5orehpgJR58Ljk9fS+eIO7C7xNzx5?=
 =?us-ascii?Q?2obhgDwJGRoJu9xB3Sy1CgC+0ta1JuhAzG27fHRi5bd189EFWb25WkUP9URF?=
 =?us-ascii?Q?nMiJynLPTGlO48q6nec+E9qr35h0rXcqgb9JNfcF/r9YUV9DXvlMPewSmxJh?=
 =?us-ascii?Q?TnzVMWaNnH8KIWWausH1rVqdqUeZEvt1CPlSjxaMjhUjnvmAJiOR7j+WCoMR?=
 =?us-ascii?Q?3MfT6xuTdfjvqOIxFDN06NCBhUDUgXG9Q4zsr/GpHVP8UsybWmuFsbzQ7HmL?=
 =?us-ascii?Q?DVQNKZCpK7iEpwoNul08WFKG/BT/jTtZ+P9NYUMuP976+3h9kC9KFnJRv1Cc?=
 =?us-ascii?Q?90flTpOwR000ZbABSdem8XdMSI906yBRYjX6Vy5Vl0v7Dhq7JaqthGhq9GQM?=
 =?us-ascii?Q?wBETxk3VXxzf7kbUYpn0Ez9WiAzIV1tLS+Yp/2bJNm3O2QL9WlROjm2DxJeq?=
 =?us-ascii?Q?0vDXAFR8AUkXhXpzP3SoN6Z3EeNvhdTjPwoeq/2OPFDWGQtJJR9sCC4VrIvA?=
 =?us-ascii?Q?WsIHg5LRVnYWwOFZ/bhlp296KWhBefGXPcneiGCZ19DrZNNa9Od0oBlD+TPc?=
 =?us-ascii?Q?YeJ0sCNt3yN76/HesP3x76Zq5hJnN6LZH1elJH1lUdNqYbTgj9W7Ru/dFoRh?=
 =?us-ascii?Q?kOFV/C10Eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c826fe2-ad26-49e6-dda3-08da246d989e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:15.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf2fsMzLwpwybfiGqspusmGHnqIhS9JXip6y57OmDDP3huAw33WnIJ2srLjX4URDPTQFVPcRtLipos9st+EQNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2644
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

