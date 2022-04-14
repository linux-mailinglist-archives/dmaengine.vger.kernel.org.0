Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5892B501F3B
	for <lists+dmaengine@lfdr.de>; Fri, 15 Apr 2022 01:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347721AbiDNXkU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 19:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiDNXkS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 19:40:18 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140072.outbound.protection.outlook.com [40.107.14.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E1BB92E;
        Thu, 14 Apr 2022 16:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYuO7g3rRpW3iBwJ1Kwy3PDH/YxHXBxLmzcxwLUFHh4zzbuEnCvc4UPA9OhsGaBCDdWg9NidMNGx1+PO+12JR8W5j8P3SjNtg1JpOWkaQo0zX4YTguFcOfBWra+9oBNeFogi4WTRreI1Mp9pIX98aBIvBW+MSya7Kkk614tUFyWc94raZXDwOQmbJqmCrtdFJO88OsRUFmXyOloHRBrZE8LjJI0dFtV/qEInGQDs75fEgJylim8OPuTe9kMgfxJ3pyW4NqEi+FJKQmclvP4RWElkF4pul8D4d7MWv9xTlhkw/QJ5EB+0UTllR6gzksuViBVcBGdVS8yTI4TaXBkH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujmBwN8Skl5YVXKpH66vPLqMo+p93BVk0tewwsLHYQA=;
 b=l5Poy0y+ngI5oMnap457s9KajAIrnlujM+NCGz/ee/rxD27d/MuUku+UzCWHhHKA0W5bFJSLtd37ngOSfGY2ZxLyL8FqjlXycz+JPJAXW8YCyzstafKfGdmQ2DI06+wAPCVRa543Oub6hXb2Nc39Ji42gHuWKvRcURwS2wFPW5r4ARFsfdg1zpdNhtovKg9XixFF2RE1dmEywwauISe4fe0Ru+Gqu0/SsiZLVs8PcoT5l+SxL/UCFWl7vqZy2k1OvoKf/V+fzoEtSqFQoxiqhlzvfd+KbbJauDMMjVZ73Gja/BloHDiNL0P28sWMYlAYlBkY27LMeT3IgZGDN1iaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujmBwN8Skl5YVXKpH66vPLqMo+p93BVk0tewwsLHYQA=;
 b=KzSLKCNWnfbbliRJOal0wWsNU3pMZWCJQxuYPpm8kHlRJlle/cK8GPlK1RIxmJyfQtTbglzn9P/jWHoVnmKDKH40o81IChNtBNz1pWRPX0wQThhadJ0+XJ/Qu7JJElweZUqIjXbS2FfnZHXaH3bq1abakqQGBiwoTxmxsXE1NW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:37:49 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 23:37:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v7 5/9] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
Date:   Thu, 14 Apr 2022 18:37:05 -0500
Message-Id: <20220414233709.412275-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414233709.412275-1-Frank.Li@nxp.com>
References: <20220414233709.412275-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::22) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f261a0b6-c02e-4405-e2cc-08da1e6fc978
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB6043DF7E02C17DFDE23204BC88EF9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsTbxg0vIFS81zidFVfuwVnXt4JJ8BkdoQtbKHVKWoLTZ4oURd8K9U/QAuaClQaIF721jwjyCu0srByh2vANGq36wvVf3g1lL6pBxfTfO6PWcvmo5u06oTxqJuUTrkM4JNqTA58+/3zsm0lQqvAtz0xC+Fp2ktXa6JFU/JvSTGj7cwGOo63xx+OUMHzZ5QV1e47obMxqSolLZE6jdFG0CgXpBY7mB8DhkC2RTFDs0GBcl6zmP5SD3WbVDrg0KpkUldij7aLGxGR7BTCGahnfYS8xELviWUGTmn2UPX9Wlc7mpSKKKh6dP2zaFnZbYYK3ZUTiBZ+95HLSg0ZPWcraXUU0lycNvdqIw31lECnHm9HvAol65b9zaNMXHGIA7NG6glXRIkKzfLSTpNEXg8D0HUUljYslQRbIJhnOb+m55lwBB6Nh4vrztHYeiHa0ecAK9LtMsyfAqXgIa2QdMXYCUQ39zjWFMe1rt4YYogyQbZ5aRVEHjOGjjNR+hoqQbej79y5W04hg93jKsZpnPyAP/dZpx3siKG2Hh75LZfMpY+I5mlu9cvOORDKxaRhy85ZprHTVDBw8lE4zONR0rRPoqLK0rehN8s6HEAAmAyXjZUGGlojGCkVAZt1eBg9E3814VXuvUHHrK51tx2u9xus9CMwONHfR2Zzopq7sREMyE92i9WWBt/SpklAMIpz1gkLo0mg/u7LtVVwNWUtle4wGAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(8936002)(38350700002)(83380400001)(36756003)(38100700002)(508600001)(6486002)(2906002)(6512007)(6666004)(4326008)(8676002)(186003)(316002)(86362001)(7416002)(1076003)(52116002)(66556008)(26005)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pjisHWjqfQN5ozyVtbACnrCU3DTRqbh3CluJyhJ8pRDb3K8tZ7dbgIv7InAK?=
 =?us-ascii?Q?MU6SZN54Qj8SjFVmQGrO8PiaISzOgrlKjwAcXp4Rn69O65iz8mE2fp82e4pa?=
 =?us-ascii?Q?pcsPEyQ2IFbDTedsRtJVMPBYOKSE4fvG3fdTxWpgo8/7Ksvh8fxH/Rh7gBvp?=
 =?us-ascii?Q?YOMEkODDP+ktGqlAaEoOCfWaVRgEbvf1sP/6OyOfJTmaQJyUoVCY9511R/jJ?=
 =?us-ascii?Q?P8jD1UyQ1nxWRPwrH/X09ClXCqlbUSHnNAP/GrYedlBByJQaoNAcf27mH/NX?=
 =?us-ascii?Q?m0JPWktNczOGd7WD1ZshPMgJU4g3ABP8rVfEvcOqqvAbJiUdIykTLWYglv94?=
 =?us-ascii?Q?Wnd5+ubSEAlrOUoWiS4De6p2bEV/6kgnAbAJtfVxv+N4Q85H+I2OE8hu3Hoi?=
 =?us-ascii?Q?UzLhjS5yiaiVZWn8+NSHAeacV9Plnk8QIE46a3gxyodx1cLhtz8HXhecPNie?=
 =?us-ascii?Q?45Hgd1kJQx5rr7cuD/DsThrIBx74McWlQF2Y5vL1tzn6nbhCK0GPT4LEcQ+x?=
 =?us-ascii?Q?YXkJd6fTilFgJuiYhSM3ba8tcy5IfSN2i1X/0uCdpZY2VKyXEkCKeiVu96oW?=
 =?us-ascii?Q?mOmYZpE9/pDc4Vy2E/piMgzEM/K3V8TtLfWyr8Es5K/GTEVclZqt9h/W+fBP?=
 =?us-ascii?Q?7fLFzBd3+P0mWjhMM2ZqDz14CeKmJRRKfF7/cIGZ+AlFDPTxgBZqUg1/IWdo?=
 =?us-ascii?Q?2vQcqbEPd+Il90Qkm9PUiCnKAwIhUhxbTVbSWjFiMCaaVtuewaJWen8DJJUm?=
 =?us-ascii?Q?ZLHGqiaaMRAKelcT/bbIYmnwTGNPCUX+RzGNVVuH96P82nFNOAtXM8gx9oUT?=
 =?us-ascii?Q?FvtfdTNQcxMv+L7s6NzELvisp4W+zBimLPOQlTbEuzp2xeMPTXfGjAHmUgK5?=
 =?us-ascii?Q?HD2vnTV2i8UJWQvavq9FGq+e8zf2ivD2bMg6rN0X9jHFxJhGn221trJC6WY9?=
 =?us-ascii?Q?ljxc3NjuAwA5iclW2A4TLfsFtXIlV416KqdyQsq7FuIZ5snJElnBNVZduEeO?=
 =?us-ascii?Q?E7QNXybbS6s2skdYGaEQpVXm+R+G1kqQk6YyumHWL9JJ3yedpuyIPNMZjReg?=
 =?us-ascii?Q?p4yVSh32LsebYclelChldv991v4meJFVLReYOeQ4CrdtiFI5x3aL4yyfs2ty?=
 =?us-ascii?Q?ips7erwOOpiWVfjG9yGhwD+uDV0RkieKpbpYk8zulM4f1CK75GJTiBHnJvOy?=
 =?us-ascii?Q?uKK0DmDt+6kgvWSw0bxeq+rcw4EAeo1gsCeyUlzGreajhitcx2ual0yFDz/e?=
 =?us-ascii?Q?JXujuq7BT5pEtrl4yoA7dXnFXEcjdyycQSSGkD44dUqHivoYFZtLcV9QfBpn?=
 =?us-ascii?Q?K2BF0S6N4e57jQyXZ9KpkwnOOmV2s7Gj/UaNWAO5VjBSKVl/UGgrW/EEAO8y?=
 =?us-ascii?Q?ur9wsy7LqKc8U1PmchpcoN+5Y3gQ5yq78ZKWjlKMTuIZ2pL+xhSeSnzRovk+?=
 =?us-ascii?Q?aMVcAPxbKVTWjS2QYgDlsEt5J+tR3oqYlAkPG9DWYmpvH0BN6b+VsBuQimGQ?=
 =?us-ascii?Q?0yufTYxt5MKwM58y6KFe/PqQSqd/tKBpIxBq/V4zS0v6Ziy7wCJgUaSWfnig?=
 =?us-ascii?Q?41ioakBLmtt/zazsbLqOJNGVxoxdVBUOUEh0Kq6WNLewUMVkmYvBK8ZwoNvJ?=
 =?us-ascii?Q?cDdP2WIYmoWqaYoKwt5QPIo4IwqxWYBSrX4RrI7dNh+YvBXa0+ehSqgemREW?=
 =?us-ascii?Q?0wsgh7036nk+5U0LAeNFnGKqymR+8TjwqtkzQ/VJyRITH2PjSycEZ8gDOJPI?=
 =?us-ascii?Q?kZj6U7MxxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f261a0b6-c02e-4405-e2cc-08da1e6fc978
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:37:49.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEywrqc9yZDQqXVMsr/4DVDJE3s5fx5+Xd0HcjM/KtuIIrlQoafmpRLfJG4nn2/NRCgp3xIfI7CbEtQVWfhRPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
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
---
 drivers/dma/dw-edma/dw-edma-core.c | 49 +++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8c440cd7ca0e2..f413fd9416956 100644
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

