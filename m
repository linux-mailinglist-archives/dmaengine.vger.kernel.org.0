Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2FF36E54E
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 09:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhD2HAf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 03:00:35 -0400
Received: from mail-eopbgr770045.outbound.protection.outlook.com ([40.107.77.45]:39079
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237447AbhD2HAe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RekAjfY4KvX6J5vtIm4li+Zp4KpYe1gRPA4wtqlCCebGPjAzFqQbv+ozbE+K9ifi3iFnOYq0fAgtDeo9qCWP8usPMM3fG0V7BE/qZAeeBwmnnR8i1GmH3ENlHW6c3YxlHzKGywlZpj5wqALm7IfRzCF4D56oUUbXXyCE5BlMO0xcTi+Xs397ePCNXTisNmQYOCe5JoJyOIyMKcvRvEL2DKGlnhUvEz29GEuVJAxFCNGuIShgRolaZLi076ELVu7PxvgviJQobUaeuJ2s4AGr3iRfyePf5VfnVkMWSG3GYSMG1UwfdK/ooMH25z9qjL9fQv9G6pTmnM1e4GQorYiygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu0qUXNHtX3gBZHb1Dh+6uX4Tb844dG18QKgmc3p1bE=;
 b=dFFe7D+mBAceOY+yFljxnhUSZKri6c9v+ZGt6rCrUKKf5rGWI05MYySVKwbBKMLSt9hLsWlOBoToe5CUNrqRc4lay6u9rvSA+Bo4CKVx/hJR5MpcR11cFGsoUs08PFLrIc8dT4H6Y5DbthphaFR6pwoBew6PQxvX8OrR7F9aMw06kR9euQ7Qkupv/mbdjRMz6yHbljJQTkyeuk5nrxIi6Jlxhq8IGklFQOVZ06T2b/tGnn58symqahRnxmh4PCWFWoBzIa8fzvy4+jYX4ccloPkCp/e5sbwjaPO0PWd2UoMIfAzrtJx1sdmflaw8HjUv3ywcJNSoU8Y7a2CVHavXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu0qUXNHtX3gBZHb1Dh+6uX4Tb844dG18QKgmc3p1bE=;
 b=iI5rEA8OdJ+AVxQCMzcrCczeJkJ2yuOA6P6Req7bKZPexRGgHxVrOpcdjFRwEwh/jEH+TfEaPhUlYuG0dA9HvMXWUPbCQGioG5SDbqvrDnOlncUzGtext6IB+/5wh+qjZdDEWAxRR1vKJXsCTIHNhwOuxq2ZVreQ8wkwUjImbkA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2102.namprd11.prod.outlook.com (2603:10b6:910:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:45 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 06:59:45 +0000
From:   quanyang.wang@windriver.com
To:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] dmaengine: xilinx: dpdma: request_irq after initializing dma channels
Date:   Thu, 29 Apr 2021 14:58:21 +0800
Message-Id: <20210429065821.3495234-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::24) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by BYAPR07CA0011.namprd07.prod.outlook.com (2603:10b6:a02:bc::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 06:59:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1432d8e8-1af7-4391-c559-08d90adc5ef7
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2102:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2102401584764ACAF1F26971F05F9@CY4PR1101MB2102.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OH5bD6HfVlsajqKzcyTVeUaHhgjKiT0yn6ECFDUY9fY5a8MRUHpV4R3RTFgjHh/msSxg7MYNu+wQCLIaEn90G3OKC25Egud0ehUYyWm3FooCxr9jepCUrf+PYrXWshXpTxfjEj9UQI6dZd7ALM3OH1JPQkfJmHS5M2F2LS9RfybHTHq+DxhSecioWNdA58MqxVWew2Nw19qiEFJPFh/SXP6VFim53fq+zDFyjcaCEvnpPqJIg6RPmVYhlA0T5HctTVgJMdQyoiMGiVQ1tj8dz4f942xVgE67iRmr21SvKTht8uMbDTWD9GJflfxEe5HNo0+uH/9pjS3bafxnY5upRAX6ruXt37Qr/fNTRONkYj1jpOGyHj3rNKhT0kVOmPoBSeMCmzktv39KryMKklxGR4qlD33h+MtrUfxDEBVnOLN3lDg/ami7zJliIr9jnGVZ6wmf5EVyuhTGU8MUxz/RIb1D74ElbJE/okcfCWGfjvP1vT5tALow8L/GPJlEKjPkyS0hY5gTfm4D2TmfkbULLG/jde/1J48GuLrpGVyhH1kVhBOHtfExaYxZ0cW6yx1jbGTOwGhB5BN0b2Xl7Glwack1jvMNjBUaQOQd9Ls4IKKkyBBGj1fz3Ho54RA05x7EDWvvG67MR5bZdyUs3gJgbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39850400004)(45080400002)(66946007)(186003)(16526019)(2906002)(6486002)(66556008)(110136005)(316002)(1076003)(26005)(478600001)(52116002)(66476007)(6506007)(956004)(86362001)(4326008)(2616005)(83380400001)(36756003)(6666004)(107886003)(5660300002)(8676002)(6512007)(9686003)(38100700002)(8936002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nb/qlhX1RS+6iINUZePIRT+PNlXZo2xwV8RBhZu7oEIdZV6KJH90E3ZLe5PS?=
 =?us-ascii?Q?eixNKKNijSkXrwC2MXS/eaOxWTd6DsJaKBijoFShBvfEPf9nTWekwiizuej0?=
 =?us-ascii?Q?KisosWnpux6NGjFcqy9ajyANQ2DV8v3sNi74pgVwD0ODIi2VaSyF7GRLDmFH?=
 =?us-ascii?Q?GVewne8BpANCW57axnYMXMSIXbXKxwT7TOY+idYvdQFHQeFXht0ldlKsWIFh?=
 =?us-ascii?Q?MaX5M+IktO2tfSIplUloyyx8jMndj4TvYDLIpYna+u+kHS/BXXa25/IsRcHS?=
 =?us-ascii?Q?PHVwUE1odCJ+QY+4hOPpvuNwjrPFP1lyH39c55/B2hRzYbN+DvCANEc8CTWc?=
 =?us-ascii?Q?atQSBENipTlvuMMVIL0/RqRQ3tplFWa5B8tXC/M7R5mBH12QwkFtIVAs0/Hj?=
 =?us-ascii?Q?/UiaJEmy/5HfwrY5u5jul8R9KegZZ1KWgD74K/Fmwu2gBf7dOjJbUcLWNOQB?=
 =?us-ascii?Q?00FNmyUFuxl1SpU9iC4KX0xpzFZ6OOo2EP+SI8SCtVz7AFGBc6uO6wrYEl4Y?=
 =?us-ascii?Q?fRNFasUp4yUo7UPBmeUpPFJr7T32S+cKn8mGS4jEm1/GXlRkThMZ+ubvynpA?=
 =?us-ascii?Q?mYCrqk2jeJXMtbGdw2oXaDZdOGpl9Yl/zTfiOKjYw4p5Cl8MmRrGZo5LD1kB?=
 =?us-ascii?Q?8xoTMCl+5pUizhaoUG7Pkv3NXqejpZesBLewxGH2BVazvJra6kxsjfU3k648?=
 =?us-ascii?Q?G8yJokKaiClVfGRcejXb84mHOO1Qhc8SuOLQdL7tV+V8Mh40OqJjh2lu1wyP?=
 =?us-ascii?Q?dD1MzBv/Ti2lPdjldb87W5KaDZe5FeZmCR7bjAcZzWlb5SuvTm7ypChneyhb?=
 =?us-ascii?Q?gOYL6gg9TSLfKkQWM9tOsdAkLj6c365j4h4AInvGbNfHgxue3cYlIh4bbR6c?=
 =?us-ascii?Q?nE7UGUfyRVyAC6KkskY8SqXMCKrNGFRKmTKiekCubVczZXkWegb/GophFSRL?=
 =?us-ascii?Q?k/Gktum0WACYXGabBiyEYlhtSgSCRTPl6CzdEm0Oc8n/4VQM7BM3AxQEfaW8?=
 =?us-ascii?Q?BvsWyMvi6ZSphIdRHw6JJwuCeranwECk1ugMfaxqX4gi1d4v3OVycp4lLe7G?=
 =?us-ascii?Q?wvs64I13D28EtyDS4wpCkq1/pKYsfvtgHFywbrtVhG6j7qdIx1uZiRUETpW/?=
 =?us-ascii?Q?ID7mvZWftTMQck7xYING4NV4U9+kysg7p4R9eYnXTs94QWVFxed4M59vTJHs?=
 =?us-ascii?Q?xEQY6XnvtKe9TDTd929e5Uo8uu3/3JG0TLTC7BCjIJBbpyJHDiwGMxGFRIuZ?=
 =?us-ascii?Q?+qSAAaXvr5Hn/T6khggKZsoTXdYG3nCCrHEQYo8AfyvW2LjYBbPzuLjbzqRv?=
 =?us-ascii?Q?xGrJLjAeLcrrv/u2uZvBn5C3?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1432d8e8-1af7-4391-c559-08d90adc5ef7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:45.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dOYT4b08o7FFX88kQi9Q3RORe0v1rmKHSHJOd8X4/wZmknWW4y31g7EwtEfmeE3RBy4I0+qe2jLQ/lz4rRoi5xQrm9UKCByIYHgLUGemuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2102
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

In some scenarios (kdump), dpdma hardware irqs has been enabled when
calling request_irq in probe function, and then the dpdma irq handler
xilinx_dpdma_irq_handler is invoked to access xdev->chan[i]. But at
this moment xdev->chan[i] hasn't been initialized. So let's call the
request_irq after initializing dma channels to avoid kdump kernel
crash as below:

[    3.696128] Unable to handle kernel NULL pointer dereference at virtual address 000000000000012c
[    3.696710] xilinx-zynqmp-dpdma fd4c0000.dma-controller: Xilinx DPDMA engine is probed
[    3.704900] Mem abort info:
[    3.704902]   ESR = 0x96000005
[    3.704905]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.704907]   SET = 0, FnV = 0
[    3.704912]   EA = 0, S1PTW = 0
[    3.713800] ahci-ceva fd0c0000.ahci: supply ahci not found, using dummy regulator
[    3.715585] Data abort info:
[    3.715587]   ISV = 0, ISS = 0x00000005
[    3.715589]   CM = 0, WnR = 0
[    3.715592] [000000000000012c] user address but active_mm is swapper
[    3.715596] Internal error: Oops: 96000005 [#1] SMP
[    3.715599] Modules linked in:
[    3.715608] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-12170-g60894882155f-dirty #77
[    3.723937] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
[    3.723942] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
[    3.723956] pc : xilinx_dpdma_irq_handler+0x418/0x560
[    3.793049] lr : xilinx_dpdma_irq_handler+0x3d8/0x560
[    3.798089] sp : ffffffc01186bdf0
[    3.801388] x29: ffffffc01186bdf0 x28: ffffffc011836f28
[    3.806692] x27: ffffff8023e0ac80 x26: 0000000000000080
[    3.811996] x25: 0000000008000408 x24: 0000000000000003
[    3.817300] x23: ffffffc01186be70 x22: ffffffc011291740
[    3.822604] x21: 0000000000000000 x20: 0000000008000408
[    3.827908] x19: 0000000000000000 x18: 0000000000000010
[    3.833212] x17: 0000000000000000 x16: 0000000000000000
[    3.838516] x15: 0000000000000000 x14: ffffffc011291740
[    3.843820] x13: ffffffc02eb4d000 x12: 0000000034d4d91d
[    3.849124] x11: 0000000000000040 x10: ffffffc0112d2d48
[    3.854428] x9 : ffffffc0112d2d40 x8 : ffffff8021c00268
[    3.859732] x7 : 0000000000000000 x6 : ffffffc011836000
[    3.865036] x5 : 0000000000000003 x4 : 0000000000000000
[    3.870340] x3 : 0000000000000001 x2 : 0000000000000000
[    3.875644] x1 : 0000000000000000 x0 : 000000000000012c
[    3.880948] Call trace:
[    3.883382]  xilinx_dpdma_irq_handler+0x418/0x560
[    3.888079]  __handle_irq_event_percpu+0x5c/0x178
[    3.892774]  handle_irq_event_percpu+0x34/0x98
[    3.897210]  handle_irq_event+0x44/0xb8
[    3.901030]  handle_fasteoi_irq+0xd0/0x190
[    3.905117]  generic_handle_irq+0x30/0x48
[    3.909111]  __handle_domain_irq+0x64/0xc0
[    3.913192]  gic_handle_irq+0x78/0xa0
[    3.916846]  el1_irq+0xc4/0x180
[    3.919982]  cpuidle_enter_state+0x134/0x2f8
[    3.924243]  cpuidle_enter+0x38/0x50
[    3.927810]  call_cpuidle+0x1c/0x40
[    3.931290]  do_idle+0x20c/0x270
[    3.934502]  cpu_startup_entry+0x28/0x58
[    3.938410]  rest_init+0xbc/0xcc
[    3.941631]  arch_call_rest_init+0x10/0x1c
[    3.945718]  start_kernel+0x51c/0x558

Fixes: 7cbb0c63de3f ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 70b29bd079c9..0b599402c53f 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1622,19 +1622,6 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 	if (IS_ERR(xdev->reg))
 		return PTR_ERR(xdev->reg);
 
-	xdev->irq = platform_get_irq(pdev, 0);
-	if (xdev->irq < 0) {
-		dev_err(xdev->dev, "failed to get platform irq\n");
-		return xdev->irq;
-	}
-
-	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
-			  dev_name(xdev->dev), xdev);
-	if (ret) {
-		dev_err(xdev->dev, "failed to request IRQ\n");
-		return ret;
-	}
-
 	ddev = &xdev->common;
 	ddev->dev = &pdev->dev;
 
@@ -1688,6 +1675,19 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 		goto error_of_dma;
 	}
 
+	xdev->irq = platform_get_irq(pdev, 0);
+	if (xdev->irq < 0) {
+		dev_err(xdev->dev, "failed to get platform irq\n");
+		goto error_irq;
+	}
+
+	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
+			  dev_name(xdev->dev), xdev);
+	if (ret) {
+		dev_err(xdev->dev, "failed to request IRQ\n");
+		goto error_irq;
+	}
+
 	xilinx_dpdma_enable_irq(xdev);
 
 	xilinx_dpdma_debugfs_init(xdev);
@@ -1696,6 +1696,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 
 	return 0;
 
+error_irq:
+	of_dma_controller_free(pdev->dev.of_node);
 error_of_dma:
 	dma_async_device_unregister(ddev);
 error_dma_async:
@@ -1704,8 +1706,6 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++)
 		xilinx_dpdma_chan_remove(xdev->chan[i]);
 
-	free_irq(xdev->irq, xdev);
-
 	return ret;
 }
 
-- 
2.25.1

