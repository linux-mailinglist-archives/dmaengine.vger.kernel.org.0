Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A0440F2FC
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhIQHS4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 03:18:56 -0400
Received: from mail-eopbgr1300099.outbound.protection.outlook.com ([40.107.130.99]:52154
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238678AbhIQHSu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 03:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+P2wHTdikNqjwOuCeQZEO28W0J+mtZCkpT9V3QlMjhMwFdl/W1tReciyKDS9xcxyunCT1fNZ9HXCpBiUKk+3h8uyIM7G4bWIJh4gfYkFuifFTU8YwA5KqiAYdrB+qkxWl4x9WZpEgIKd0bgSq0rsyzfjicNcfv2XH+9XtF0Ja4DFrda0lUbE5nZd2aMTdGqlFTFT23w0RW0txNUz5YL0J+ve5lj7AwRNmoocIKs8Ly0KjK++dvTtz0pL50DaCBpwq4zo9dstzNLjbiczMmV8XOX/ZptX9F7ty+X2Vfd6kFaMJexOymtaAgWq8GalhDL7b++Vw/wsoBF+D8hwm4gfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fAM1/CPTUyPpjdPys6aA92d9GQr53hkuolsNWBeAJAc=;
 b=KlH/NZ78Qp/Bluhpjgol97mhOKqzcciSg+2unukt8eKcF6+U5r4pnrhtztXRhQkgNOd5cv49QNLaHddRTRDdN0YBqVlj6t3MD000Xf2wh+n1fgobWN3e5qHR2RYXAOLEMmuvdlVn9VFWqVKrmV9aIkIeRT1moVDCP9hXj4dZMs9u/I7GCbqlnxi44jFHULWXehykTE0iDZAxGN2PwHO8zln/9t3yzSgZUPokYWxi0fIU4aEI4L/5n7ab5FYMrMc1KiibFpD36yBjCNUY2wDvh4DBP9F2aDK2HLqltJlizg3dTtBR+ouL6Iw1l5HOBuc0HUePBtSRWNTzf8gl9H5Dhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAM1/CPTUyPpjdPys6aA92d9GQr53hkuolsNWBeAJAc=;
 b=VVBHSBJ2nnBVKv9WGwHi85CtEc/89SMq93mYa/A+AY+gymJLkUN4LGIjshVxFPhmrw6EK542iabC2ZEkkEScYNxWpHsCZGwJk2hhPjRERqO4uEzguFIz2wanZ4UrVord3gaM3l1jZDtyHBPQ9/UTI02k17yOEXqowFQ9xYE33C4=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3068.apcprd06.prod.outlook.com (2603:1096:100:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 07:17:27 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 07:17:27 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Zhou Wang <wangzhou1@hisilicon.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] dma: hisi_dma: switch from 'pci_' to 'dma_' API
Date:   Fri, 17 Sep 2021 00:17:20 -0700
Message-Id: <1631863040-10132-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0185.apcprd02.prod.outlook.com
 (2603:1096:201:21::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR02CA0185.apcprd02.prod.outlook.com (2603:1096:201:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 07:17:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29da2c75-8cae-4205-c7c3-08d979ab3430
X-MS-TrafficTypeDiagnostic: SL2PR06MB3068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB30683BB95E75C0FF329345D9BDDD9@SL2PR06MB3068.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYeSUwqS4CvODAw3zzBmsdK02GmXUc8d67Kg0qzK6Qmnju+5+7FAWNbuxvHAsKm1IxBHPUux4vRlmuYARlZnuyXtZzfvwxT5FEr6hB2DjdsQRuYaUDbqINmZhoXTaMw1GYiFlXDgdXjZ/xhwJ0yZ5j4zzIKrq673EpnOlBtWBHjGLM5JLOSzem9zfb+BHnnhVqFJ1sEkFDyXhrVN77gtHheByGx4Ad82370pVW98MBnTrPLpaJbeaX6OrjePypcBlCG2mz+mD/NAJwlS5aTTHTJiYgYKXu5NNI2R1utkLhhJIobIwRktTfVtZGP/Rfd9B43Q6Z2GbPx7a7T5A0HtJMwzeq5UQLotAF3J0ArBhzoF3SnDoA2dPz8oIMSje6ODTJvuK/o8rfeQb2Uqn1EvSTP30XbNJJKhg+2mo+s3t3s57n6eikmSXZsa/PQBP00GNajWpICUOV1UTCy3wd1OGQqk9ff6TzorrwLx+5SXFjC1nEgGfezUavdaD7LckyEWRMH9Kwv0UCnysQ+kcd+v9lMlcxJuL27QYZOLLJYT44cn0KpWF5jnxBiepezVsOFlokiWPH3+SZRlNSoVwck7M9Ir6QFf8ypBWdM6Weh12MKPPhjyAp01OBXRhtFgfT6Ma6zOZ2dMxsUa9ymJZ3CFtHPF72W3g654i9lN3OgxW4d+h3PR3Kw/Rl0ePbFJZTM3u1Nld62VCRnit3YdANm209LB0TFadwup0Y5AFxLa0r9Gz8w5PE+V7LXJfBtAC/4bSlz+ADfO7FwqV6KqqxPD/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(6486002)(83380400001)(36756003)(38350700002)(86362001)(5660300002)(38100700002)(956004)(316002)(478600001)(52116002)(107886003)(8676002)(26005)(110136005)(966005)(6512007)(6506007)(6666004)(66476007)(66556008)(66946007)(4326008)(2906002)(186003)(8936002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xrYJqBIkwFXUs5BCeA0d/uiWGXHy9s/NMO1HbNc13FhGV9hemtNoGZRFBEbF?=
 =?us-ascii?Q?Hn6HUM7xEk9H19bbFTgrl7GzPUdCt+a++ZIGF3E+BAfW5pDmDwoBcL+rs6HO?=
 =?us-ascii?Q?3JNomNyIcVYVaeMFoas89u9SkI5A8U8WEQew7KtV2X/KxpR5dfcV/dclk9kR?=
 =?us-ascii?Q?SJBB4pThz3qjpxRD5MORPEJxsQKOM8GDMmojL31kPQME2KGMn5v+3UdTGhZm?=
 =?us-ascii?Q?nkWtJW0CGVH/mb/RW4CxXqB0K9CjnQJwoFo2V9HTGugxgj9GE5hXCYbZyE69?=
 =?us-ascii?Q?gqd1BufV3rcqbAH6UfY7R8aHPf1ZBKR9tGLsm6cYlB06SYI3tTzS0h0bOYgB?=
 =?us-ascii?Q?Ak4J1Wod264HrS8SiBfFzc/JPAfjme7f7Xu3urR+sI4yZ4jbek0u7fuHSaeq?=
 =?us-ascii?Q?ucXldfvT3C0U4MSywJMeCx4TehYAr7OJjor723FgfHmErROuI/rYxf309N3d?=
 =?us-ascii?Q?INcP94PQCLNTRqS10Zu2f/VRyjygKzIgjHLW9QiTV17wJCdHH1lzrhEMRdcF?=
 =?us-ascii?Q?aGUkDSkzcyB6mb5qEhMGIuC5Uur2MLOo6FMLyOiOchGEbUerKb/mdnyLF2nI?=
 =?us-ascii?Q?7XvF8El9jOi6pA0kXZJ1kBPSNUqvcJhGdCQjOXowuLquPBvZeInxK8MXjsiX?=
 =?us-ascii?Q?EvDMi9WNw6azwL6XxJsFLOIj7MCML/obyLzHYpjPu8G07ItLL06nAC9IMZ+L?=
 =?us-ascii?Q?Efq8t7KrxEM6+Nem+Hu9VjmBGLpV4NPWQtKPg3XA8rJZBs4HqkTPYKuKiFTk?=
 =?us-ascii?Q?eFn4IGH/4yOK0/mjJGQGJxIsZIGj+po0LdZrpMeRKI/gxA6mQ7M8fXhkQ6ah?=
 =?us-ascii?Q?HOguOTjIGJiL0EJMK+Z0KkRtvvI2puWH7vZozGZzkfV7SKUkdWnNdxCkP0ik?=
 =?us-ascii?Q?8DdY80jFTTJmq3TdMbFiAHuyI/Cfhc/eS9lskhpGYjop3lvrSjc3blRrTu8H?=
 =?us-ascii?Q?cPuM2VEp5QVefOLQMWDym/O17eSu654+xc8SaMhzR+u+5ek30P9FtlJuYRdb?=
 =?us-ascii?Q?oiE7CIvPYgm+0NspSgi0mouTvb9qtNgNf63CoYBkIMgEbmiHXb8HThwZqcE/?=
 =?us-ascii?Q?ywbq6e//bQrB9lHO4kze6nk7JNYpEnEkHfhPyaETIBwmC/9oWLskzlKmEVMh?=
 =?us-ascii?Q?Abo8x7sCUIxiJwDS5Kr22ioKdzx1tWT5fUuwYTl2C6vBG7wv5cX3l8Oq0Xok?=
 =?us-ascii?Q?HwsVR9/YxhMrpnfRAXj9xggJl/yvdFU+HM/DCG+g8PLF2yhFVLKnHmbokM28?=
 =?us-ascii?Q?xu2rcnKQaHQusTxYKuOUARBymCIjF9vE39TeX+Ai9yNWFEP0wkG9iKBw2XFC?=
 =?us-ascii?Q?ukmfBF4eEZFXjGVDdPHXDV2D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29da2c75-8cae-4205-c7c3-08d979ab3430
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:17:27.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afAndGoaOz4kr5wPgzC8olrp7T2K6W6xr0zlM+fUVRPSlluQmElZjj9tBlWYBudVXwjBN6Pih9BFY7W+K43AGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3068
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/dma/hisi_dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index a259ee0..b86f856
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -524,11 +524,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (ret)
-		return ret;
-
-	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret)
 		return ret;
 
-- 
2.7.4

