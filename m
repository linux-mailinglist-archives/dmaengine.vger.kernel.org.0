Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C074640F2F4
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 09:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhIQHSR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 03:18:17 -0400
Received: from mail-eopbgr1300129.outbound.protection.outlook.com ([40.107.130.129]:47521
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237083AbhIQHSQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 03:18:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8UHGq55QBE1zsCgrK2vNBBYXcD4ZYUENHqxragvMTWwedx4tT5wVO0OOX1/WMY8wbtx7ppWo0XdlT2sOvvwnQyMnawQg4lY5UnUUjvRQycIE/98WQSxBeJQexzgW8a48hO63SJ64pQI/2DFvj0w6998WJFDRq8EapEB6bOVXA1RGsAkKwWzRHHQh3oaq+/B6UrJVo85lYR8gXNE7YpWRxHUFlVfMSAESHGr6C36zLNGrBsmVP0FeuibY0HasH1u/4AJXGeOkVv5maDJpBK3bzppBBhVBcKqwqAiCjsVZXD3XKTwABd/vDh3l7FD37JmhCtf8Ye9MKe7XUwfYxC2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tNLV4uu76RgqHPsnePpDIEuTtdr+Rtd0y7ZnJGOwtVA=;
 b=MEELmNOfG7uWSGAUhk6B4hEcIWiuAtIM/YqVXuk5lVTNN2kP9157oBapF9P/EH6jaIczI26+f7uDqw9QDcQAhfcVYLvJbisqQFP6e3O98nI2Q44yJZytZEGvZ9fGErp40NapX/p3lqzQe9wQgI6hgrm5rnPP3pM6pK3dLu0jk/XOXgsEPWE/Evvj3DReUYFd5hBP+EXrPen1EsmhZaXCjwR7ax/Z6OnAgzqH1Dh2xBZ/nCgXceXAuN7ehUjcdMVSgJI5yITGIkJjoPKy+QMWcz4RKWn0i1dc7XJPRXIurFwAOuUD2y/IzJf96hzLsJ1znWTdlHjtM6m74TcmiUBMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNLV4uu76RgqHPsnePpDIEuTtdr+Rtd0y7ZnJGOwtVA=;
 b=bOKkMgGAYp7zIANpNCY2YDdbhep545J5MGWlctAcO3K4nYTxjJacQRu96jptv9NloJAFZF7dgByN8FX+w+jP2yKoUz5JWUFKoLv5X3rbQAqX1oUvtQHcrcnMwdH8eo7rnF9CnNNjwgUhhF1S+L6Lyml8mOlZkFP6LOrXaXvnd2M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3068.apcprd06.prod.outlook.com (2603:1096:100:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 07:16:52 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 07:16:52 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] dma: ioat: switch from 'pci_' to 'dma_' API
Date:   Fri, 17 Sep 2021 00:16:31 -0700
Message-Id: <1631862991-10006-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.localdomain (103.220.76.181) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 07:16:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af59f46e-c771-467a-0c30-08d979ab1f33
X-MS-TrafficTypeDiagnostic: SL2PR06MB3068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB30687498D1FF029A4161E82DBDDD9@SL2PR06MB3068.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOsSiMt3eNf+R+fKorIzJ/T6rAmiPK/T7R7iUHQSEzBG+jNxszCsodiwb9Wxcu4ID2S9Ba5nBnjsEkt+ZavxBfTLL0OeaH71xS7n9jIaHDua8N5tSBvtXfFAXEijC27w18prRmMM13fqgo4Tjtv2shZvAYdJM4q+By28aXxoLgEg6aTcmK9D4ZTuB6K1etFld+eswPvs4I0NTgmBqowGS+odmtlU2Ooa8p6fl3KB65BvzeLwBSR9DEgmv7BPRKN1PKawRUIN6o29Ftd6fUPqwoVO8JILR2VD3t6deTIe+1Z6WaostoTuhCQQOc2EwNufwFOdCYQylazCc5Ua3BUJq6ta7rv9WwZ9uFj8aDs/4E123+zgQtQA91t4N9Iwnu8jXNAF3TxkeFCQXvzNdtLxrVxBIb0/cIgzBODUv8m0Ma3t21D0xl4dQ8TArlqnZdnelcNYpZvciVkM+A7HReAGU4LHiQu58olGqizJ9TFul6HE5qSifeXCUmjpmT7gFohBu6KUqLYsCjjYRi31IvnoMKjmW9bNI0w9cbJaA22OYNVNr/ewPTCZBZWBuPq+l+Cez538rHJGH0oL9TAhIHhs/unIfYMwUSeOFP6FRIdTxr2FiNgvZMn2c1TXebpdzNuvucrOHwHFOoMsM3kkBXSXUtG67BYYGdcaQJGP5Zs2zCrffA6rZLyXsjIx/veFAGzxQySE+hVBnc4M49AM4A4aEdZqwAF0iW72ZKELJ0f7zGiD3nVBGcfSOEDQB9ptRu6a0Mi4q4SnM0SZvMTxVgGbrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(6486002)(83380400001)(36756003)(38350700002)(86362001)(5660300002)(38100700002)(956004)(316002)(478600001)(52116002)(107886003)(8676002)(26005)(966005)(6512007)(6506007)(6666004)(66476007)(66556008)(66946007)(4326008)(2906002)(186003)(8936002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8UeRLYpMyAJEo8hhq/LEtqm8Lat1gK+PyudB0uLXTIACbs4zQvak2Sq4g+l?=
 =?us-ascii?Q?88w2hsmHINWNf+TS/el1S7iFjT/sQ/rBMR0TpGgs61t3m5aeQTXk8l85vMTA?=
 =?us-ascii?Q?h6QUMDgeM8RO9KgPZQZfCMkc0ai21n5ZbY2+qWgY1XtULv8KF1QfJVw+i8rq?=
 =?us-ascii?Q?XkH5sbO5d5JYAhqAFbTG6X+BMPooXTtrg70ZUPWZ9PcJUbPvEoUQclA6LYHF?=
 =?us-ascii?Q?2eeBvjWk0egcOKqgcGe+zSCVU+qD/4tQcoU4yNBA1vNte4aT6aOz2xEm01BB?=
 =?us-ascii?Q?sdSTQ/ltuyzM2lhv/HfLL2h8Uax+rjAy62xjiVFwUFfRl+DOHzX5N5nrEBJH?=
 =?us-ascii?Q?2ehTeLqvfDkiFskpUZ1ZI6YzRNAz2azgXfNc0yA+VpF0Vcr6r1nadhWtpk1M?=
 =?us-ascii?Q?cjHOXYZIYQvWZIbfU5eB7Seuy22r9/mPsb/CgoG36Z/AcP5vAONhb3rweA/3?=
 =?us-ascii?Q?2ky16gqM2bCYE9jHvt+43YSwQiAT5/9cpltRn2peszXd/1Z8bkc4cnZ005Kp?=
 =?us-ascii?Q?jKQDVouk3x1Hk3IzL0Bmfb3lt2lhsZMC1c0WuspPWA3u/7FuftE8hocW5DFo?=
 =?us-ascii?Q?ximqhSkIChAmwD21i79QcPlSQnhQO2H1/ytEVhQoJz7bHP32DFbtH34TjnIe?=
 =?us-ascii?Q?R22+q5TI1vtIKFDRSVE+CC2nwLjRemK7I9gMFcp+gbixabrI4d6tvtdT4Uzi?=
 =?us-ascii?Q?97VgPHxxLx5FSuw2M22gIfxQS/FLo/Qq3b3lvkEyks565jWATBCC+cM90oUq?=
 =?us-ascii?Q?VAcQxP+i8iaeRClZgRVkhS8QasKyPZyqcu2JQGHHbRcVLrA2SOBXggpEMvpa?=
 =?us-ascii?Q?JCbTVM7FdyVZNt3z5fOGbNvQNMQ7wj56t8Mx4hD484HLi1Jn0QQSe1AzD+sO?=
 =?us-ascii?Q?iikGtKt00kV3Us2Au9K+U4eTzxGAIZRiPLFhwus67ZDNbEWfFXIyS70UcjFO?=
 =?us-ascii?Q?qrkX8huuKpklum+IQUOqTnxop6E2Fc+FcrvJeJkVxH41OkPg9TIkaStf13s+?=
 =?us-ascii?Q?5LaDXSQzXZi6UAOTRmVx7PQUofhy0+YrVbrnacW3Pxn+4Z2VWGWQzaZdUxRH?=
 =?us-ascii?Q?rSKd0VfCYqqW3PfYbXssVnoqu+Rg/FVE5zgjV23IriP9ow8+oKw00AQRSfh0?=
 =?us-ascii?Q?v1KoRcVqXAgcfUpLEHVRFSuoYz6SdXZkKROrqNvCLc1qKaLDVHpOjLTbAbRg?=
 =?us-ascii?Q?cGH3rYNDLgnSd73Kouxz+3Nvqo3CAJWbYg8Kz7FpHP0QHsxf93cH5FlWak9U?=
 =?us-ascii?Q?9ow2hLKFADAQ8Kdqy4AJKMeno9qZ33Ks3YrqERAc51rabclUB2p7IiinZ3Ah?=
 =?us-ascii?Q?thKxpmsRrQIqG+HwZbKpoT97?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af59f46e-c771-467a-0c30-08d979ab1f33
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:16:52.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LR1Gx4JblggUtIN3T6b/N1X6vaXWI36602JHzX7zmNAs09aGjWSQg2lO/glyhkWYsP4vdBEVvWqtjiIicSirbA==
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

