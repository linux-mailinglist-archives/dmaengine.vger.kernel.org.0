Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820BD41A62B
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 05:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbhI1DqL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 23:46:11 -0400
Received: from mail-eopbgr1320104.outbound.protection.outlook.com ([40.107.132.104]:13245
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238852AbhI1DqH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 23:46:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R81IOKcNczX5Uu7fZ0plwsKb1sQgFZcC/AUHB60a6p/DoWrpOGdSJBzk5v8MKT2rGVMSQrMHmlLgZrCs8Tn52hz/9X4Xd1J3nMBmSc0t2AzvddTtbuI6xmG8Rz8lNDKHKXfsMp66Pl3ggubNCvkaBQbR9n8pmsfKE4gVJ4hykZRguZ5hZipIK8/bBgq/Ow++KFRzBufzw1OCebrdB7YmGVPFYndh5SsBgm0APjWYTK3sExYYVuNxRG1ecHuhyyE5fZYEdi9ajwSPk3RV4fan/JEmHh4VCsT/6IuWKPReXtio0UgVzYsahb/yEO2r+KOjtIo/xYgN3y+LOj2quNY1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Pqz5NMsgkUWr6cXmxRLephkOY3R/aAt4hCONbBIwnqg=;
 b=QuGwnNoqw+cRibUEt3ge6OFFzHsPKsAqwcaoJYAT/qgwriToK6LIiGsBJjblm+eRGp+v6yL1w/f8FTeKcHo4h3zergRX7eSlpL7sOfjNOTph/tyU8O0hMKbej2qS7pN/JBPe3XV4yqg4LlPKwfoQnuQdMrrTKx3aE/YUNKe1NF5YRLD/PduV1/dwmsvPYjTokyjBL1JG1mdY0DZwSP+XGoSFbJqQoTVXgyRy/x+SFow+RT9kZEPERZVjTgbpg28lfshfBFeB+CMQoBWJIWTn9gIYnXFQaL4IqN2P7jzI2+F8Pq2RKUgrVVxhvbn8zmox3GZ2tQKJE0S20dITYfnOMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pqz5NMsgkUWr6cXmxRLephkOY3R/aAt4hCONbBIwnqg=;
 b=ZzWNXf84jGNvxLi7sE9uAIFxX9L82iMfGViA0yjw9ArPI7loGK/NgZZMeQBoL8F+0Y9/zti18pfqNXw1eAmJpczvdgjLiU7JVxs+gGzkSkorZDEK7rG1+5KL7JkHrridOyBriIp8RFdn7e0OY6Y3OVzwKsNi+nKfSLpdNKaC7v8=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3401.apcprd06.prod.outlook.com (2603:1096:100:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 03:44:26 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 03:44:26 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2] dma: dw-edma-pcie: switch from 'pci_' to 'dma_' API
Date:   Mon, 27 Sep 2021 20:44:20 -0700
Message-Id: <1632800660-108761-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:c9::11) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HKAPR03CA0024.apcprd03.prod.outlook.com (2603:1096:203:c9::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4566.9 via Frontend Transport; Tue, 28 Sep 2021 03:44:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3ab7c35-c6c6-4285-51e8-08d9823244d9
X-MS-TrafficTypeDiagnostic: SL2PR06MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB340149F511AAC65C1638006FBDA89@SL2PR06MB3401.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pmr23LHILPzdsNeWmUXJ/RCaQmo9szj44E7dtAcT7tdUUwhHjP2gPbM6TXVaoJHfJYUOTV/5VbB0OxJ1ervbb8STw0/9mFMgCwh7dwcNx4ltzcowVNXQ0nSgU3hqenatxJjJEPVAMSDE3g5+TUX/kUaXULgICJQei9TwOiN2odEwnVe4YfR/veOZL3yzLgUVD1+zHL3gdWy0NbOlmZzkKXqpJp9SJw+5cfcJ+pIpSYIU8enIKfLOnjLgtKg8E6+dRM1Vvjva/7mUO/EJ2jONwGUXvTecFAHSt2ZYIrT+r/V5CmYNvyXruJmpc2phUCZy/tbcQl0DqdSYK5bEx6dBX0hPB7D9e/2tOWaKFZqnGsLKSHq/Xgp3t0VqZzoBav77sxT8UXjr4Moj0FbxYASYP3FrKVAHGvRmeStQj8SKqIJWLhYXIFCLwQpRwccUWQAvm3qlCqlElv29vEdROxQSoU8ODK05gxdJGnkpLJfHWkTLBYDIczRz5eRNcBx567iwTQsK/VHvaRnzabGRZJyh0GknxTJ9SwNb6RlIh3ougApLYvPfusWSrvDwznmDFCmrKGeVrGX39goaFtpr6IJHOfQNF/xc9UDETXZmqAd5AXlfb+ecqTfpdgxa89h3fQHVlKinCtS87zuxJjd/pCTdoGuCq+EvgQizWhZbirc2v9Ri+wjI3F3dvpAl/soppXvywXNUkrUgH0hd3mGG95FUNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38350700002)(26005)(6666004)(66556008)(38100700002)(110136005)(2906002)(316002)(66476007)(66946007)(508600001)(6506007)(52116002)(36756003)(2616005)(4326008)(6486002)(5660300002)(186003)(8936002)(6512007)(107886003)(83380400001)(86362001)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DZeOxh00oHepwPTvZazYtvMo4W4yh9krhprKOQXTDmsI3qOd3pIScB6grzpU?=
 =?us-ascii?Q?uKHnchDw2+3Oto710pKtFlVTkUL+uCc4DKkC80xB9OnFEFNw4fMI1apQNDox?=
 =?us-ascii?Q?yQ+1UmuRNvk4oTjPnsdSEdYSZzwCxRLnnAIqe+mjpZQVkpoHONj7dCOVSUN8?=
 =?us-ascii?Q?GXhqgL+QAagDuHZtbW5orxnVkOi53poyKT1a9yd1RAfLDlWn4K1PfLIv64dO?=
 =?us-ascii?Q?mfxL28w6QC5sKltiaDx6VfKvgw6ir0zizI15qNUsmvzwnYLyhlchl5WQBkgv?=
 =?us-ascii?Q?XSQeWEqkf3EYFVfjDVd/wm3VqQVF4+5Au3K79bBrWwRrI+XceMfOo4HcvzMY?=
 =?us-ascii?Q?nELUoDiUsXe/hf4NNJ3dGRGcGECwO+QJkuo+VSLVgeRXjUC/4gr72F8R1+1+?=
 =?us-ascii?Q?Id6FwNmf49jcYOh+yuy2OgrzQ41tangEqNCm17wC2IVOXvzOc8PyDyGeP9Jw?=
 =?us-ascii?Q?O34B8DiUliqVKT1Vv66kBNkRmmiJkvwKzxrx03Cp+OYEMnW9kje+EHSk/v47?=
 =?us-ascii?Q?6OOx7omWfGAVYri/P7Tr0wDH46O29e9IERmojU4PqKYfHU5UpHfb3pusR7lf?=
 =?us-ascii?Q?Gk5XBhRt7sTSpzDzSerMdS209RUB+ZTS/QzJPYl8VXDRTdiWYfqPF/MIejsi?=
 =?us-ascii?Q?jBgkDPgxYkPLuA22/npkE8j4PDaUVQN2LFiyO3Vb+No5vKi+4pX6J6f53l6V?=
 =?us-ascii?Q?MKzPPNfeFecIGR+b06sMObKKqdOdQSirU3l0Lub66O96DV0YHkXBGOKNVXn5?=
 =?us-ascii?Q?SPwNqwyL2+S3GEG5Co5oCCgGNTAP9VdmjpBt5EyWTPJn4Lxqi5Y470GH0OBD?=
 =?us-ascii?Q?4VZ64h3TEvFDyFBvwqawhURj4SYscmD7cfgyIWtvXUB5V/ro65HLRjFNE+7/?=
 =?us-ascii?Q?31J4BMFWdDIn6YOZWdWKsVN+GFqy2XA387eEOeuiDOkCPi1f7jw1TFue1rso?=
 =?us-ascii?Q?ldzUWRcG7uLOVp8xGezU9knI6WhgvWhUVbpm2WJsX+O+urOrDQSsqli1TlYz?=
 =?us-ascii?Q?hat3mA24LYcvS5E47T6wZtKnLV08tnuSOOOUgm2EOnmTdrMjShi7b9zQldZI?=
 =?us-ascii?Q?7tSXegIvZ3AYSP9A3dEENBw4GCbO07KX6SrSlG2jE2VVd3fRpl/vQBSai7db?=
 =?us-ascii?Q?v5wEGqOv0/MH4Cj5qtr5hsrUJXCC6Om2kH5N+aeKhm7hMK8pvYkpk+KpODUV?=
 =?us-ascii?Q?TAL8chxuZH3SwU2WMzOwqQtbs/pmzQZeTZBkrcIBaJlLIFFWXZlyWuK3zx8C?=
 =?us-ascii?Q?/tUie9fLZ/DhSXbmdnW90CfM1GzVrMcyUy5JSp/umr0YMVq9P01OSI4UXNW9?=
 =?us-ascii?Q?0dvk1MfIxDfxHF5/ZAErQUVI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ab7c35-c6c6-4285-51e8-08d9823244d9
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 03:44:26.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8yhEXSVTrnUUACBYsrYNsWuICkxHL87mvXG8HcO3eO2duv+54FJ1LwXL3PjI6I3F89BeQklwb3FEjxvA1WyEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3401
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

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

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

