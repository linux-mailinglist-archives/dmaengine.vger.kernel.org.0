Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D03440EEB5
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 03:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242159AbhIQB1M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Sep 2021 21:27:12 -0400
Received: from mail-eopbgr1300139.outbound.protection.outlook.com ([40.107.130.139]:26880
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232222AbhIQB1M (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Sep 2021 21:27:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCVBCtAT4e63nTZYF8PfdG5x0lYF//4Q6lP3PLJ5OXVUyiQ4HaNIrZDc2AuPavRAPZp99AtIlDesiqY76lFWl8ic/v26+CaxQUKYtf2vA7nkBVN5Xt79De+bdz4jlHhNfqFfIlZlLGNZAR593YHvaklxVbuzfJYRVvxa0kScm1FZfHiSzAcAsWWB4jm51mux3AtpRAxp7uWbsZs9k3WzLUg4Tr3AZ1Ufm6SZzA3TKVfgIb+DWMzOhZJlrln0vvoZG1lEjULA/199fkj4gQOcd2NecOFf/qF0T3aAoOsksw4WyTwhtzEeEP/QQM/eMCIllPKH4+lO5BbGgJNok+9+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yj2FEsHV4XOpfKH2C5TL0/1DSyezYKrwKe7kbitn54U=;
 b=lUp3iPZgCedCI6v4qrp8PvMEdT7xP0xDoeokZPgR2XBF/rJcE52cVITXh9SlcaNbP+ubV3r55UKN94m0bhogf0H/ZUu59X6Tp6eymQiM0D+A8Hxdeb0B3m7QvU86gdBHRxmG2kBp0E1f/q3pcZ+w8J38mm29GERURpBKK9q9BVw1KtVVs+t/ZKJAliFcQICmFwjODzv1V1fWvMleT3nKpCcjKtuRKl/j22mcA7ZoSPgJ5ehZqN6m0PPL7Sjt6JLxICjKqE66nANB4O8H7Oi04ald7Hu36SkwSnyxZxr7JEvSHP6UcoxdR9R8Kl3hVuaf/6U1G9VslC/KwXZ/xZOi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj2FEsHV4XOpfKH2C5TL0/1DSyezYKrwKe7kbitn54U=;
 b=C7NRioq2+MoBgot+tvYBVNkzvrGvrk5CWtPxl9YVF1vG0nTtEjfvMZPjK8HpwBDJhhnzRtgQYT7hwmVvUmk5vU/KJk2+0L9CHaPWJk1l3j/r6NP0MFUy+7xGCqF5uD7dqETpfmjJbh+ow5v523IVaKIv+tp3/DixBVdwAzjf1dQ=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3180.apcprd06.prod.outlook.com (2603:1096:100:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 01:25:46 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 01:25:45 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] dma: dw-edma-pcie: switch from 'pci_' to 'dma_' API
Date:   Thu, 16 Sep 2021 18:24:56 -0700
Message-Id: <1631841897-7506-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 01:25:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fccb49e-6a2c-48ad-7f8c-08d9797a1284
X-MS-TrafficTypeDiagnostic: SL2PR06MB3180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3180B19099B6B1823D70144CBDDD9@SL2PR06MB3180.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nxI1VurFFw3wWUjg6m0cMxae71cpMSvppthb3n8c4fDQa7wHul5o35HFm+OqXaXwDcQsfF5cKf7+yDEd+Z4I53jLgIwPa9S/RTnJHAhVxOW6+3PqxU2mxgYN8fF77or9Ew18yDfoKhNvKwj73iWP/QOL/M0Ru3mwgtICNvEGpe9ucdvAFx8eO050Rg/ZgzZLPq2StgZRrVtAqXA0tlTZgRfHlfjrRsYXvP6ZbkSw3+sD/xJmar/qLM0edj5lgGgw31tKsoWI0VhJFGaNUB6pTZU1vq+GsUcahcA/J2CSQ/SE5gCpvUhzXdh11EY1r/Oyc5bm/UbEl2xqVQWZIBX+UJ9Pk2UhqrwZCn4vPshBDhLbIAiKRqVaowU1XPV9veLl4buavvyVFnO+WlXYyrzbnYPKdD8f0qcDYf22wViyXw4m+OU3j8XuNeks9VF8QYJwoSlFvSQZohYbfK6yJ5kLSVIsXbf9lDVyQmVJc6zOXviBfCvVw6UKLTsJh/UT3qaQ6d9rF0sGzLUwb+C8m4WrXlp0+rCzNpDiuHsMKrHMhTtw7Gz4IaFViA/x17mmVgZIdw6+IHymSMFThrf4xWrlafituAifjMcTdn8CnYyj9Nyf3Q3TYki6B9gp9ZOQLfdLfvhbU29Uq37ZVvy1nQqD/7/M+Y+o6qwUuSvtHx9W4IFqkamWrwL04n4rpMe3YyH2+r3zigQDRSq/4s2cPy13PVSB4Xje+k0by2xMpKmVuBKbnq2Tga6rWeHsObrHdniHKylYHDnExO840mR7xpjkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(4326008)(107886003)(6512007)(36756003)(86362001)(38100700002)(66476007)(66556008)(66946007)(6666004)(6506007)(38350700002)(6486002)(83380400001)(2906002)(5660300002)(956004)(966005)(8936002)(186003)(2616005)(316002)(110136005)(26005)(478600001)(52116002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9XjDKrrlDfGXefrxKs05rmRZW5EvN44lybJdT9JV/3R2RJiIL6LTYGo0uVTZ?=
 =?us-ascii?Q?LgyY2gpDGsSbsf0AxsRQoT2Wck3ZhXRmkOnVMqT0m5koeWqC+UDDUxtsrjaG?=
 =?us-ascii?Q?21b/GQ9KXLF8VXhCvl8NX92EFzmdKSiMX/Q8NLUTMfFbLy7jmtkw27Xchi5C?=
 =?us-ascii?Q?ePrIys2iFL7XrtKWWIwxFLFRFTUMXwWoT4vgja7eg4jzc5WRbgPmIqJKxZfH?=
 =?us-ascii?Q?S5JJiX3iv0HlXsvNoAUEpvugvsuc2cpFmKn/BjOSHkXAmBkEIrgxinVakfiw?=
 =?us-ascii?Q?cOYj2vZVRDNDT+7CGbeA39lS59Dp79cj/Sm3YXPjIJPb7UTMW8YS4H6a91bi?=
 =?us-ascii?Q?N10afIAKFMB1B//VRDEAorHt6tijLSF01M18U3RaGcPxVkq+3LJIEM6njN0u?=
 =?us-ascii?Q?RrqcPlVLNqXyLOpPP1wLeKSO+vPrD6cEVgrNH7OKK6bKEQq8TAzTW3Tw2pr1?=
 =?us-ascii?Q?RJP57emb7OvicLhwRzZss4mKNocd/eb4me2/okQ0NrZtF4gycMcMF6PNE5Pt?=
 =?us-ascii?Q?DMaZ1ApYeoKjCVv6/5mVFjhOumqECQeb2UgdLC3lrnrrJa5aPw2rzHK7nVD2?=
 =?us-ascii?Q?ShjcPmZsl6Cj5UO8OysXGvSKlyOsYotLzV/BAFhJn+E/A7YnSCbF7j+sCOgg?=
 =?us-ascii?Q?wNqNPi5psEGda5Xih8czbiWfKV3yNeo+kI1OBW6nUDOX+gor3hSbXY/0y53W?=
 =?us-ascii?Q?cYY+ttilCdPYhtThqwoUAwHk4vmQ8KlBSZQ6+tTjElzmrfVT613Hyj7gkvmG?=
 =?us-ascii?Q?0LAYJ8Ehi4DB5KTp/gBvBnaxDjtZ52GOlOAGLRazwHYcOtBfvROObuqw05h9?=
 =?us-ascii?Q?Jqv9qkgPyjr+pHkDnH6s4PuZbk6tHieqj84MBWrjUhk1ykAZ6A+1r3gntU0L?=
 =?us-ascii?Q?4yxu8/2jNfRXv7glSQJ++0qJGZeuJgNqDn39cRt3cRv8kv2KQHPorIDdlo0l?=
 =?us-ascii?Q?71uqDdKjJH1NNPGrCQ8nUfbl0SVsz7Drg9jh8EC1KiuR8tZPv9ePIZLEq1Yu?=
 =?us-ascii?Q?WtR+dNrFmxZfkpZB12exumgWW/3moavrqdE6nBM2ef2MVVSkdgdgHR4njQij?=
 =?us-ascii?Q?O5i3tqaE/tU1I1Qp5nwKNrklJXMUjvoIZI5yR9d8Pw0u8z+EgRhZ2lnXLDz+?=
 =?us-ascii?Q?MPcF2WQTFzBCn39agNh5JoH8Kac+Zg12hCVGmWJY7bQUasdHwFOgTa8Mw092?=
 =?us-ascii?Q?pPvsmXDdAWS2zOQs7H+VTGWIxC5LNc//uMPxQOwpWYFQieald348pfU2d+++?=
 =?us-ascii?Q?2XoDkIiSZngp6SYGPooJEmcDgNL6I5Nki6ImU+Mfi6k5xQuueyJsldx7BpSf?=
 =?us-ascii?Q?lZVNWE2HuziRLt4czrRhhxbv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fccb49e-6a2c-48ad-7f8c-08d9797a1284
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 01:25:45.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ky4rMdSwdanDHCdrSGW/KnjyHLxkc+CTqefYik4nUWiFhl9uSpRDVt7yk3dZSTjxLkXJTsThU48t682LXilVdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
updated to a much less verbose 'dma_set_mask_and_coherent()'.

This type of patches has been going on for a long time, I plan to 
clean it up in the near future. If needed, see post from 
Christoph Hellwig on the kernel-janitors ML:
https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)
 mode change 100644 => 100755 drivers/dma/dw-edma/dw-edma-pcie.c

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 44f6e09..198f6cd
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -186,27 +186,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	/* DMA configuration */
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (!err) {
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-		if (err) {
-			pci_err(pdev, "consistent DMA mask 64 set failed\n");
-			return err;
-		}
+		pci_err(pdev, "DMA mask 64 set failed\n");
+		return err;
 	} else {
 		pci_err(pdev, "DMA mask 64 set failed\n");
 
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
 			pci_err(pdev, "DMA mask 32 set failed\n");
 			return err;
 		}
-
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (err) {
-			pci_err(pdev, "consistent DMA mask 32 set failed\n");
-			return err;
-		}
 	}
 
 	/* Data structure allocation */
-- 
2.7.4

