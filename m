Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5841A629
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 05:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbhI1Dpf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 23:45:35 -0400
Received: from mail-eopbgr1320105.outbound.protection.outlook.com ([40.107.132.105]:44913
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238911AbhI1Dpe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 23:45:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr4uyfUT2+4Tl4vcjDS753a+EcAKZxAo3Ap2Aierg/yeS7m6c+x6IDlWEXVzma7ezGwZiewrl0EaeSS90YXl4np7inQlaEqE5qZ4T5wNWEFfgHvEvrUkhq+lU6qxI2j4+1T/Yy06uKHPaNtnK8MEAzKBB6IVaJMsXUydVgYo66QW3/GEcsrLTX2DcfgC8/v1ISyLPwHIR8p7ii6jqUN2pzPPPV0d4WiTHNa5c4vBzBl37yNAXIzvu2K3s/3hS9YJda1O+PF/7ywqgIBg/18VA39ZfEo7epYNtoLgjzxuHFaPm5r/JGLurse90AK0FGubirUoEa97RLkydDAmw0Ig7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YTgMhN+zTXazlJRP60EKmWCoSmJMOpOs92ec/SzAXGk=;
 b=SBMJlrSGr4juzDL03fgPo7FxsPIMYYPHXG+M/a5aVPAq9n8l+usS+CcBg3+5AAODFKbwV1a1ZJO6AmRwmHfZ/o1c1yXM0T32KmcmUqlWlNNsaI+i308B0G9p1ojYXqZMSSbV7Sfj0RzNZ/fTWtY/pKaqJ6Q+sY6Ai05R3oTLHbgftWIAW3EZYN9NY64vXX0SDUpNHoGE1/EinSHMN9bjwCsuhbT96gEL4CzeWlwGVVETchJkwJkCk4wxtht7fBpgB/jAyDCzcs1ns8MgH2fcGTqjpmgkkTpNgUFmUblsVMjlYVPjmw8A2x9KrvB4puEipgBPidwolifTFB+SKXBRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTgMhN+zTXazlJRP60EKmWCoSmJMOpOs92ec/SzAXGk=;
 b=VNRxD5PUZqf0POARoObe27TWJC2Q9v+RTz7GELZmSZ681rGBBHoIGjKSsihlOL8bYcaPKukHPgS0QSye9LMnxydW0IjPK+JdF2UrQdKdu1GPCvJCNJkW2kszyhi3KLD3qvyRulytbCrZ5st0Sq5WF6VF4jKWeG6cz1M6LA+Qj2E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3401.apcprd06.prod.outlook.com (2603:1096:100:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 03:43:54 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 03:43:54 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V2] dma: ioat: switch from 'pci_' to 'dma_' API
Date:   Mon, 27 Sep 2021 20:43:47 -0700
Message-Id: <1632800627-108714-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR04CA0052.apcprd04.prod.outlook.com (2603:1096:202:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 03:43:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19ef43be-e2a5-47fb-77b0-08d9823231a6
X-MS-TrafficTypeDiagnostic: SL2PR06MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3401AA9CFC79F5339504A3C5BDA89@SL2PR06MB3401.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6K+d4YWbNAsc3COWTHADcKgO1TDQVUtEOEvWmfi9rUN5L2suHaLZdJRubkxtf8lQicjC/mx657VX+u9nu1+jjO+AGoiGU1lhTgDaihQo9TfDP9dpi6n3mDFi5B7rhEjx5wuPYyxXe4UYwakSfgYenwrHwwbTKzcl6OO25hbVWKDdUoFr8hB1XXj6KEH+d05tN7m+sKwhU5hQws7TKesMKMq279NE06jrC1dNcri3uVczu3xYzOtPHb0QostMulRBkdmEeq9xb66Vov3wGw2obL/CWuUY5GCdyXvDd9KJk9ua2yN9RS7EPRomepX35rUOTFn1jLxBQeauUpi2THuMapoqKLVACsacWWZ3K0tLA+v/8pruCEJ5tHl0hWzUS9mcEXR59T4vLappLYxx+iGa04Z0L8/1z7GXbTImSPAivoTiFPY3dfthM3idB2tOinIJjhue10HOuuxrfmXPKJDAO6bkUwrYyBRpJBVUKrpVPqoAI4wzeks50H6EGom4nokpntfQdU8xRmqHBGic1lLNr0YZgO+V58kCiKP562QOpYgQ8pVAz+dzbSE5WXDr+1z3QDaa1i1/hg1uSOjcUEpyRpY/u9qk2cYmmtoCFHMA3IzFODtgcgHm9OQNYIosVSVnLreCuqJpHz7QQO61ShQthxWCjwm7AD1KOcohQRKAPZg45OlGJnJVtgwtl+0d+rvbAeO8UkK1CTj0KhGKZp7ivw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38350700002)(26005)(6666004)(66556008)(38100700002)(2906002)(316002)(66476007)(66946007)(508600001)(6506007)(52116002)(36756003)(2616005)(4326008)(6486002)(5660300002)(186003)(8936002)(6512007)(107886003)(83380400001)(86362001)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jM6MC0iM79nZq8QU1WRS9cy1TT72QlkjHk/uGki2q3+xKJgDV+PE+jwuf1EP?=
 =?us-ascii?Q?biR42WZbqSZICoG/WH3wE4nnxjwjvYqWMVscUJKdnayuWskfKZ1s7Uon+Wo4?=
 =?us-ascii?Q?+ZZcpTeIc8kdh+3OUktxVdqUpUQvxO5nlsR/vpjlN2/e/fsnqGTveSUE/fZv?=
 =?us-ascii?Q?GRojOSG31FWmLhWRXuvEW1Y645a3J4Gh9hK2XnSOnd8WXMKJXl6ZvkGo1Vta?=
 =?us-ascii?Q?YV2u+vIv22h5dD9nzuFBXFNIhN5VjMHTt5QMBpLtWToXUzclMXPWyZ0f6Ns0?=
 =?us-ascii?Q?yW2Ez5PXTcs4gsPf9cCieyhqgZkWNCZejtMZAOrfS7HNC7joR2WRtt1gSp89?=
 =?us-ascii?Q?dQJM8kMPMpBdELlQMSjWdUCIPS723fEtq8NgSgZyc7APkiRtW/8ahrvqUiYF?=
 =?us-ascii?Q?ZKQ9lVnoCuzS++dt0/8M9Jx0tVqXFrCxVGkI02sO4JBsW7Ii2gvPSG6CnA7M?=
 =?us-ascii?Q?KM1PoG62yDyRxwQ/xdcp6Mi2eItXdHoTPH+V/1R6QRYUvOzJTBBR1jPJgI3I?=
 =?us-ascii?Q?4hgkg1ldMNg4wbb2+a86Z9+Z8wInlLgV1fGOKwWzItbOk8ymJPKzzPxzvCOe?=
 =?us-ascii?Q?wwFL5XhSp/anfRYLgFtKD8XfgcPgUQbP9ARfEB7tNve063QQA08EUxsJO0Xl?=
 =?us-ascii?Q?PXlvgpwr4WrOkufzl6gyd0K54QJa/I7POZxgrT2RHuM2K52euBzJmYvVos2T?=
 =?us-ascii?Q?12+jgCAkwrlCjEzlIh54t6pBJK0cMCZiwl/vUku34HU4vBZFk6K3FuRxScrB?=
 =?us-ascii?Q?kxiKN4fseO23WbhMwt60olsQQQjvgm1UzIpydMHMD3LJGTdGMRBc40faMLXE?=
 =?us-ascii?Q?XGbvDiW9KG3EHYWLf2qy61rsA3ncfDgBAoWUBPchsUbXihFCWgfgjU/rnt5R?=
 =?us-ascii?Q?AB3XJ3uPEQ6XUlI5OYJ3ZoHYNHEMPU9qYvBXsTp0Vk63ZHUSA9oToCZOAYUC?=
 =?us-ascii?Q?ZXKst0TVcaVvL3WJzpLdAOELHmOvyYlvSYWd4D/vY5xZ9X4urvqHFUp7RQep?=
 =?us-ascii?Q?mIn2zzoWh26Puc9T+lJUFBC3E2jm2/r7crklv4r4sxVqmblTfzmjfaMrxmUV?=
 =?us-ascii?Q?K5rtnqcAmMq4uB6Z6W7qYcqpfGyeOL3J/MMKnCWx2vAfoVTXXzKwzPBlGEnd?=
 =?us-ascii?Q?KEj0c9VheTC8M17dG5zcfbVDygmYVNQlga5rhyi1GwE2nzinHy6ALS50Ej2c?=
 =?us-ascii?Q?rz28tg5pd9RoxUwQYw6y0LzDvt6AIEnNbansoqewcejEsfIRlEEtC6nwYVtV?=
 =?us-ascii?Q?B2rhgpZfWIHxZ5mOHDaU5lbSRiP1RooXKrbtr6GEDwTz1PuO1wLiBP7t4Ann?=
 =?us-ascii?Q?HQkKvCzwMBVTP098+fR8QZJ+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ef43be-e2a5-47fb-77b0-08d9823231a6
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 03:43:54.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5U5UVF85NlYhTt5TXkaElGg8virKtg1SkXCwAw19kqXHr55wfi2V1VpwkzqEcikTWJnmktoj7vDFOPS7QSk9Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3401
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

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/dma/ioat/init.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 191b592..373b8da
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1363,15 +1363,9 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!iomap)
 		return -ENOMEM;
 
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err)
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (err)
-		return err;
-
-	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (err)
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err)
 		return err;
 
-- 
2.7.4

