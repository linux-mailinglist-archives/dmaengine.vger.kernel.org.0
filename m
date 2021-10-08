Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C084262FA
	for <lists+dmaengine@lfdr.de>; Fri,  8 Oct 2021 05:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhJHDd1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 23:33:27 -0400
Received: from mail-eopbgr1310098.outbound.protection.outlook.com ([40.107.131.98]:23230
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229501AbhJHDd1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Oct 2021 23:33:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTQdrlvrjxTMMkPS3Q58NqD78xy+g2wHXP7zBPRJ+xMlncwLwcbhLKdQziJYwHcoCcj70k6M6P0M+5CUjf/XNzX7rQHyu81HB0BhBthwfT7Y9x8ZUHi8F0D1/20CgAOXhURCoJDu2z40bCyJ9Vo0XT9KBwglxp8EykWL2jzxx5RK1/Mj1oz5hio+wsGwONg7QJbpZawlyC38hj9KpB2MY8cXjgZlFPBoT17o0GXY9m4wqt+O4k+DrSULh2HUAXcHzHHgRZ1dD9xuVmf5KyK3zXJ65Z6CIRlXjJb5I8sbb/Ahxyxn8S9BScwZOY+yT3KJ35vU6XuvR2fZAiSbBBzNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W8DejXV0lPTAlVmWbNikoZL5cUs5fjl+7gC/Ce2+bU=;
 b=AA2rZzTMASgFPFS2BvM0w5NcYneN8V49kvOsiNEDGIH7Zu/VAjJ01PH3vF7Ys/WLDIzqkRTHB7FlCNOcmX+FZcaICkipTpBmIenWTdAA+x76hf1VObUZiZyULb74I6BzWF0oF1e8vKnC/zirHWk/fsIIw456Jnj2OyXeTHPLxO0eCCEpGD8qhpsTy+2REd9oYkAvpgBBtKg/hglSEfPohlTSuTQv2uUAw88z5UMqmgzS8s72n6NduZz/jUL1YgPD5z//zBgwzCEy+dfT9T9ztMIMeW5x+pcPFntf4IuFMo8W+mPvCg0c6Oz2DlTm9faR2bUkjwhzXkM78Uk0rEoCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W8DejXV0lPTAlVmWbNikoZL5cUs5fjl+7gC/Ce2+bU=;
 b=pOfya57310dV4/WieiLDKwdAbas0/EvQGKt7g8hpgcrs952vHpPHBVLjauJaAA6zza4vO/0taI6lcRMtRLtRFN96hWilYecBpAuvVAkbM+hPgfh2EX6sFTk4X3VKYHQZ85DqG1Drh1hdJDYLlLruoySsWin8WKbUalG0jY5sBi0=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3210.apcprd06.prod.outlook.com (2603:1096:100:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 03:31:29 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.019; Fri, 8 Oct 2021
 03:31:29 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V3 1/7] dma: dw-edma-pcie: switch from 'pci_' to 'dma_' API
Date:   Thu,  7 Oct 2021 20:28:27 -0700
Message-Id: <1633663733-47199-2-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
References: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0209.apcprd02.prod.outlook.com (2603:1096:201:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 03:31:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f33b911-d8d7-49c4-4ea5-08d98a0c1de8
X-MS-TrafficTypeDiagnostic: SL2PR06MB3210:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB32103BF0F1D08C7DBF271AC5BDB29@SL2PR06MB3210.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oILFAQUYHM596XJcfmsUhnegkQi1f6/ZCmMjjU5alqXr0zLtoLWvI6E227gsVQGOkg6akrFBkifGY5yxi78OKEED6atCwlKDD7vQXa/kWzIJT8LWSzczfg5tmBzYcMOadG5LdArBUuBCLuRtcfEgtikOc/6K/xiKtpRjjSvdNi8d9sEFGONRvHBUhkwn/Dzz7eqbQuY0yauaz7as0PmBE3GZOQzUC4Ez8Sgi9Wuhsn6OOg8ySw0+QgJ3fHBWNbSeGP/jw8hTHdYAc9VbnQ8qbv3V5PSMFl/Y9PRQVJitj+bIlwT46elMzyELURHhDlfZPzKdFZw/2xd4j77pPq9SYTkyCEuqDq10+p+F+sdIZjA6PUy4hRwbw4CMvI+ZyM7zrZvx2qqrJ2YXCaoQZOajLYqjynhBlVnoMGBVlXFsyvuv7GtIgT5AsGJE68jbWWBixc588/aYQyZ0ks371L59zb8gv1x/5H6KBt8EwSWMrf705uyulKc/hcbSdv3fix9vrYHOPrtzYh3LSuCx6g9A7W2AhIeXVKUzLK6qzD5I4DwwBcAhCFP3m02/sTnknJUya/SWVwFK2U/DVw1yQHADlnwiH7FtIdxDMWI87hXvPOyGl+UhlwrEGdb1gaTPpz+qrvptUyEE/nbtuc0Yrfp/MPWmo2vr+pj6nycPUCNFbnFUvqZM6CsPKxKE85+jWqMH/TLyL9e54k7jnpwPoAZ2eAT5i8QThZDhAw4YJqOlo0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6486002)(110136005)(8936002)(2616005)(26005)(5660300002)(6512007)(186003)(86362001)(4326008)(2906002)(66946007)(107886003)(66476007)(66556008)(52116002)(508600001)(36756003)(6506007)(7416002)(38100700002)(38350700002)(956004)(83380400001)(8676002)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GE0M01zx/ik7Av9EKh2z0CgLpyQroSNdDW2RRIybWWtiqjQ0J57+FzYQ6Wlx?=
 =?us-ascii?Q?rGFJPDuApodIo2z4/viN5Xp4/ul9ytTt0LMc05KPgt1oR6LdfKm7SZdlmUIu?=
 =?us-ascii?Q?iJUvVbyghG0n7VWfKE8fuMp/FpgYuH2lAx5ngv9oySeBnqAaZKI2iKddHp0G?=
 =?us-ascii?Q?E1uIMSvZdyVfLB6kgMaxN94AaY4OcYOaIhpb3c3TxCga2j65Rrxzf7KAXhho?=
 =?us-ascii?Q?6A9SO7vJKcF/rRBWwu13Un7RqAG8KyDWEIphPSg5SVDR+oh6jVZEM2ylj06/?=
 =?us-ascii?Q?njqY4Ly5QtfkJ+2xHFSZE9go/WsnKB8KgoNh4Rwb+RwsDo5zJulpFzGCWdz8?=
 =?us-ascii?Q?i8SUTW526QTz2/1IbUQmzO8FAa4fbA5y/SNzLh52UM8bqiOs/qgHUg1QOKFB?=
 =?us-ascii?Q?F1rmFSxbtrVCs0NW0X8rgmeuvHeBckn2EYg4vTNnkvTrIVBbX678syPnkiMn?=
 =?us-ascii?Q?OIvTrlpxURs7S4sF63fK1xdJl3+Yk+qi+VvpOyrZaB9FpCVMmDPsJg02KZPi?=
 =?us-ascii?Q?Z8PlO6MI7astZPGvPNRSnQp1qwkUKZ0SjyY1xv71Gb0Cs+lepYJWQajeqhKf?=
 =?us-ascii?Q?oACNBjajqoR+3MGnHxuz9U2YbFYI/255UPw700DC+jbaUz7GT41ueKhNli2L?=
 =?us-ascii?Q?YAPeXHL3g1ONskj7CR3IKnp5gzJNF1dtuXfQZ04hbMRi9Y940PUp2CmxOv3c?=
 =?us-ascii?Q?ndK9GMzN7w6SN59P5jRuWJHdPLjBKVOYFmC5ExHUmUn6lVe+0k3fAP40F6QC?=
 =?us-ascii?Q?C7TUKrHYCl5DcsHBaCPROjkAnpk04kekt3+hZnTIGEYwnu3XBlOggT7a3SW0?=
 =?us-ascii?Q?/f6O5I6DwAIe9E6i2n8ivrkjW8ZMcfJTW8gBVbx2B9qqPGorfawoERq9aQ4e?=
 =?us-ascii?Q?0/5FOA0XHeoaITknjuCQd0m84dDh+UQRblWoCGVZltScdyOl80UQgccHXZbj?=
 =?us-ascii?Q?dNUhGKPuQ7S9TTSA5/725ylqRQNEKvJ/tocA10HuTIKOXDuzy/yQERxdG4V8?=
 =?us-ascii?Q?mnjvuPR5Hxko3cA7X1vJVsPhMpSP4atXGvs3CajX2leRsLkdLD5kEDXY0q8i?=
 =?us-ascii?Q?i2wIaTFdvsKTHy6FNaoz5PHysuQSGA/6H5TQrLwt7lJ4tptXlPtPS8HyaZUt?=
 =?us-ascii?Q?FjZ/zBsiochRtF4tHdU6ojSW/l+e+GWu+giyby+rRtiaXSokCWy+lmZ6P9hT?=
 =?us-ascii?Q?S2jluvj842Ll9nI7zixwDPGoQ369CQBu45dEnLM/zaieStP1C9QAvgdveqRH?=
 =?us-ascii?Q?xOXF+EdQsTTX4aFuTykgtqL6e9w5ie5WN4vTVz2l2H7Mba5eXDPT7kMnvOet?=
 =?us-ascii?Q?k/0+P16fuzFkW1RjSZsj9HaZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f33b911-d8d7-49c4-4ea5-08d98a0c1de8
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 03:31:29.6589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZK44ZfECUNyxYvwjcaAVWIOH+crvIFibGztZmMvUCt6pzj4ReLMkY8Yc7S3BpbDbjvUN8CJvyl6y3wXwXfi0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3210
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

The wrappers in include/linux/pci-dma-compat.h should go away.

pci_set_dma_mask()/pci_set_consistent_dma_mask() should be
replaced with dma_set_mask()/dma_set_coherent_mask(), 
and use dma_set_mask_and_coherent() for both.

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

