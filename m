Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDED40F300
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 09:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhIQHTf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 03:19:35 -0400
Received: from mail-eopbgr1300104.outbound.protection.outlook.com ([40.107.130.104]:36797
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233196AbhIQHTf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 03:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvTrsVro9xzf9wTqwPH2qCJlqgYKQljdzjWLZWY48vgodOkpCO0FL9geVemaEonGSnwgYdFtqu8U+0Eiw+X951FReBPFugWI2QXGgQfcEOUa5wIuRKiCOuUNp3c4LQ2ub1bGaFWXiJIycF3aZpFrv7NrBt58ZtSMAb/QVGYPaXRxBY1dCZ8fLYxxZ+43xbmFto7haI3KabyKutj8yO57K5bfhgw90uJ48c2XZQSzHF9kkr+j69rvPhJJ61HSANTNF1dhF6Ss+35DVjtXXW+hHI4Do57Qq+wW2oNRbT0OLU+GTrKVOOXBhHxkMokR9biQ/hsjBe15ni73GbJjeslwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FzH8GcvRnYCGoPZ0LUmXjjwtAC6jW9SbjRm64n2H12w=;
 b=a+MPJeo/o/S1Fn6JNktHh+8oqmctc3fwZ4/+zpRJHmqfabvELZ4+1tdWnimCRiSC0DZKIW7ZqIoQkc1UrHcHUxtu37oee9M1p/iIP7Uw5CuHjo3sxnBXXKgd46AbqsiizCC/xHwxkApeWNHVCBY1nRknLDxXCZevjTyREzJ5HIrZPqzJNPEbDwN6vTPpi227g1rnkeBg78LZzTSnD3xRwgMTENoN/N0lQv+M/cmsfzaKB9ayKQEEWubwHFmZrzR7GGCynl0+kMfGA0i4HcJMAK2dech/SjEpLWFWQkYleq1l0GzdfLTXIaRV3hlGC2LTEAkgGhq6PZSFLCXvHn3FfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzH8GcvRnYCGoPZ0LUmXjjwtAC6jW9SbjRm64n2H12w=;
 b=aAcQtbek64eq5unklCDHNoNtQ4u33nYugCnZCK8Yu6DqRcaO6evbKl4B34oRo6s3djsYbmpv8SIdmCRQXwGZzFmhTc6Ixfu8TJNOkDDufanVX1Ub7wS4fxCiBr6Ty+0PbCIMeUjH7dvY3tEf+f+pqndmVKfmXsDKx6Nz2z65K8E=
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3404.apcprd06.prod.outlook.com (2603:1096:100:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 07:18:10 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 07:18:10 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] dma: plx_dma: switch from 'pci_' to 'dma_' API
Date:   Fri, 17 Sep 2021 00:18:01 -0700
Message-Id: <1631863081-10231-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::17) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.localdomain (103.220.76.181) by HK0PR01CA0053.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 07:18:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b823bc6-5b55-4e18-1ed8-08d979ab4dca
X-MS-TrafficTypeDiagnostic: SL2PR06MB3404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB34046A696B89C0BCB43EBE6CBDDD9@SL2PR06MB3404.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7rLKTF7L69F3fYVHGOkJFhmrA9ViszMyM39+XnS7x8CqcMIDfM5DHuEnkMn1lW7R9i/ydxNmBaYcmjIQBRO+ud1W9GSwR65qjiTM4IlkDhM6h/4Rp2kQzsfpy708tJJWfiKAyitNBTyMejxBM48iC9H7JU96eEX82dO2Ay90ekLaTvQJJMQP2u6+bNUWylEY0MgY8l7Q1JPLjShRcPjS61GJQBGB474SLBgiOhaidOdWDQuErQQOVKsxkCUKN9W6YpYkUU7cB0UdELp1shA1tZddgr/HruUnQvI/tv2Lx9MwVvGinFN+mP8AtKQ7sd/2OH4l9TG9zJrOAF8H2DtlmvpU67AbYxyeSvJ5D/h/omLTKq0j4Vx8QtlEGWGf8kUS+VcTW/46RzxMvnMjDPpDUg/rCe4/CAIH7bO/F3jhsWa/vZ9QFqScop3REpv4G668AQw8GBKYcYM2z3mkHKdmegYLuOzpMIXv7tjMlOyY+aKPyiHwB+IxCwmHMCUbQwxfERApRsMZ1v8xqChGbuk23I9pmljt9ZoG8/dAmAq2AKmpDVkGN4lr2oNOwPRIZY0q6jQPV0p/OZF7ji2SWlLxCtTm1GXNBc8Ly7ACEMwfX7WnUoYwwPmaPL6k2kQNtepws0i91kaTQHAHToisDY+vV2nmrnbYlYyd+CktX6qzmIEybEd/UYy7kmqyh+Rdd501V2zKTwu44UanEAP93mnI2ImQChcO/NV3XkwUlNeaQ7Wm/l0VBaYlK59mAIVXjZyQwgK8N7Qw71Zs5WB9RWEIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(38100700002)(6512007)(6666004)(38350700002)(966005)(6486002)(52116002)(8936002)(5660300002)(2906002)(6506007)(26005)(66476007)(478600001)(66556008)(83380400001)(8676002)(186003)(66946007)(4326008)(110136005)(86362001)(956004)(107886003)(2616005)(316002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u/goBW0IQAhb5Ebmp0smz5JdqWnVewClbC006gFVVh6Mwjau9834xPaOaJNJ?=
 =?us-ascii?Q?aL1ZQeTVW4o1o1GnpEfyOFoRMC4FJKmm/EI/uBK4rwLTRTSvzr06yumGfxCv?=
 =?us-ascii?Q?1TdMth13quSKbCdL+GlvvO9VuUTt89WZMJJ3xX2HnB9LQ9muJgvGI19sgwhH?=
 =?us-ascii?Q?B4I5dbSvX2ZyizElOeSh8Q8yhJ+Nkrg266f7DQ98DqsV3j681e7nXGsR1dF7?=
 =?us-ascii?Q?f6oAFJMkF0u9Yg1hpNChGsp2fc6gV6F1O45yFS77V2nBzxu7DS3Brrmh+t0N?=
 =?us-ascii?Q?edyjwJRpB0yphDR92TG7y56G0iNxVdGNSr7CpWU3BXr5WeFGbU//jT6m4rA0?=
 =?us-ascii?Q?cGHjCnmcQP6zZb7RXIDDiWdV4YLMrpcjNB5YdxTgA42Ot/Togjr+WAdYYFuz?=
 =?us-ascii?Q?DVekzH2DEgfI6RaeDvpn97QD2ZuX6vctQADSsINM5T5HnwDE3QMORwIeZ7zI?=
 =?us-ascii?Q?SAMaLBJZ7Fu6ahVB+qCKJIX59WDWmMefItDz7ZEAELrYzJFiFgIII1Rezf+G?=
 =?us-ascii?Q?opjHL+TexMpglfgKXFPJEscmU6RkhXzhRJu4ltbDaLHH+5iYQR3OrGZHN6Hn?=
 =?us-ascii?Q?UcmdlQQ0Gh4xcyZ5wtasMno/Wpx7InjeMebU98GwX3RDCQQ13pHvUifCuJei?=
 =?us-ascii?Q?q62Z6Tct8gOL8ErL4H+U6tjWnRz5TGTm9NkaSYdXhYUhNztBH4mlYhoGuVYh?=
 =?us-ascii?Q?T++0AfO488bLG/FbQyDcvs1RszWV/VU9GYMPgLlGJXvJEr1uU0rgmy84dRB1?=
 =?us-ascii?Q?SCjLeOpOw4urmSOxv2uYXUrRLy3Zn87rjLaot29ODm+/lqbQWkjCQa2d92oS?=
 =?us-ascii?Q?oS2gf9frSiecer74O81S2J/IPKEc6E2ZrwlSsbov7+OjuNotmtlY3vg37dsA?=
 =?us-ascii?Q?K/rbxzzu6SBydbvmFfU05CUFmNQ3sxw2JqJMXcirwXOrXyCSnXl0Pm7RUZgK?=
 =?us-ascii?Q?blipKGwTa/ownm5rzEjuKQzNSjjCbxj1gpNC0ZngwtKqmNp0U+jWBv2bylq2?=
 =?us-ascii?Q?JQZOyQDwW0AlpXSXbtpnMM+7DJeFYXho0MtRbBZXqrh8TeqStRgDDMLjzyL3?=
 =?us-ascii?Q?BNS1NmvZWSI5q9yG7tm17sdkTX/5GOWgKk14ynl87T0Gg1fZK1MzAaoY5X/v?=
 =?us-ascii?Q?FYbkdCDpSEIMdajS+JYtIMj/HUGJhAxVtezi///BuosUxewxId18ce/+CXOE?=
 =?us-ascii?Q?92jzmISMLzYr9KNuvPtCbB6w8jB+cSISYW5i7HQ9VuKN1diSIvHQk91K5VlI?=
 =?us-ascii?Q?jfd5zAlBAjxox3lZbffYvWm0QU5IEdyeHXOW5fTXc1dBbelkLu3Gycjr0nJ8?=
 =?us-ascii?Q?DB3rRBHdXQhReYbYooWNZWvx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b823bc6-5b55-4e18-1ed8-08d979ab4dca
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:18:10.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucu6L0EibgvnZjVTXWSJJzZc7gwMYsP6QdcL8bWEBjGoyYNETDrvJocoCeEuPulGrwy7aGCHdC7okm2Mp09wRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3404
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
 drivers/dma/plx_dma.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 1669345..1ffcb5c
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -563,15 +563,9 @@ static int plx_dma_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 	if (rc)
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (rc)
-		return rc;
-
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
-	if (rc)
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc)
 		return rc;
 
-- 
2.7.4

