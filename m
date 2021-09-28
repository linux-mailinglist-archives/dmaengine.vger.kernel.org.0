Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E741A623
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 05:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhI1Dot (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 23:44:49 -0400
Received: from mail-eopbgr1320137.outbound.protection.outlook.com ([40.107.132.137]:61344
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238849AbhI1Dot (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 23:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwnZgbsP+5XLctQAV4Ma+CgWaPUActx0aztylyc6GJILkqsxddkpUsJWtcoOzhtLA3RpN3qQ3wk0b2MIyYVutzpkN97mgO2EfCxAXPVf0gpYIZTyQiyahkwoA7sfyM0H02pEDpYUkdGZMPFJmnkllYQIjjDSrEpeaw0l20MB30mbqA2qZM/P++1vByJF3tTPf6P3VqmcLZkLlGhTFz/sFdme37/up2qTfkWIt9m469fLfy6HMiR6kHHW+qN8+0cjsGXU+neXgZRQOZyj18E8M2nz60WruLD878k3cTIomg6q+uw9lh62YvwH0//AOPGq4SQ9+wJE+7E5qps5W9ZKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AGpK/Xez6iVkItFzl2s32DTq8s7AFC5oGCfeeMec6EM=;
 b=FHqLnrwM8i7FkxPX0XhhA26FTreqyzQsJ9Py8A2MET/bVWo5BxF4f9nSiPfI8eCLnXKLcxx/6rVpB8iDP0Tu3ce+kfDc2pjoSTGJYwnUdLIAAY5+c7EXzn1gvPOHY4HMooNKrIywxKNSg1YFCNd8Tpna13RzC1ASk9qZQwXtpnDqNcnt4DJMoWI69h9yHdSJoReyzQAgUGJ/1t4RSbiSyEOOiG1RUXnx5NleO+AjsNukO1rrBXzvo1WwQeflw9i0UU95ViIsTN+GACkTpL/7p1jeLnOCvkxRmX6bzgHSYAUnFWdwRV4M2kXh7wUEZmjJUI+fcnsyOYgS2OLqs6bVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGpK/Xez6iVkItFzl2s32DTq8s7AFC5oGCfeeMec6EM=;
 b=MNcpy/nxHKNzP6BVMqjtswt507Vs9MpwrzshUkuWNuG/lyyhEQdp6jVQ8fOwMDMLBg/M9eHT5mdCOazb2zriawCF1gh1L0FwRsDqdi4iX4+cGOMGDg+AsfTYxuEcdBBfbyfr0QNL2QcH9ljkC2HijI+3bIw8nou/JIlNk+UPWiw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3401.apcprd06.prod.outlook.com (2603:1096:100:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 03:43:09 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 03:43:09 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V2] dma: dw: switch from 'pci_' to 'dma_' API
Date:   Mon, 27 Sep 2021 20:43:03 -0700
Message-Id: <1632800583-108571-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK0PR01CA0052.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 03:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b18c2822-f38c-4685-66ac-08d98232167f
X-MS-TrafficTypeDiagnostic: SL2PR06MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3401EBBE5C8986D4F9943237BDA89@SL2PR06MB3401.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fJuVFz0/48aacr8WtcWmEy0Z51uAkgazkRivtSzsYo2qoj/A6rGYoFFVFKxD+PeEzv5YJcb9y9iOKZw39PlbN8hGGJ7v/eQRugsSZnME2RtgtJZi21Cw3gtr8DgySAGRHMVhDscN56ytSyTSFbM3xL9knL1YzmLSK7nS7pZVKsujPSHKjhKrfpQ/08pHs4KrRCaX2xb45+DVFDI9ekMPn0P8Bqp5tG7vS/oCWhOpF9xpxXiVj4en7F2C4jXvGjMJOYBoeub1V2JF8sZkNIXrnCnLylQjlF5BnKqymee0vOv13/axxmfKbFQymcKt7it8Ax+2zrm74140NB9DWbDTb3AMIWSEgA+bIct4qgzYugAqezWDFH07NK8lMDvEaQ+/2fla2ys2hNWkq3K/fRnlbyC7UEng62S31ikS0rp0qOG3mxeXcELaOSlFpGYK0Y/GigwZyJtYYSGdv3P6KZLVJePbhT50d3e+xIZiqVqGqVcrzW9QhmOuXKgTAhgGAL+sApL96EvmzPmBCpoo/FeA1an6UerKprC59nn4gWvI1APakkidNeCIzNoQ74ecGqWsS8kayhfRIvCGf6B7vlqShwsXORzetydp5jpMppVnHkwIW4jzuZ9E7RHtn6r6JYCL05CpklDDVU8tpGSDkLRSTrU/MghzyXDpT0ZT6tKgQZBuKqqgqedl7JylwLt4oIFHWKpyoKO4xjEXluVdtYr5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38350700002)(26005)(6666004)(66556008)(38100700002)(110136005)(2906002)(316002)(66476007)(66946007)(508600001)(6506007)(52116002)(36756003)(2616005)(4326008)(6486002)(5660300002)(186003)(8936002)(6512007)(107886003)(83380400001)(86362001)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?536b9oU5IYW0UGr6L1FlCsH8a6s4CYMJTvHjij987kTAtbiNGaIZXf0j0tty?=
 =?us-ascii?Q?hYdBrtvP54laBABGq1z8VvtXriauF9oHq8oFZzCRJJa9nVVC5fRX8DBSj4j5?=
 =?us-ascii?Q?u1hjvVNT9vNpcutc36B/bnJ8XeEOYdcPqcj3Sh4EYwdD2naBhAKfc9hBg+va?=
 =?us-ascii?Q?r6Lux1uroqTqX8cMe7k0JEy3Zgm+47UpoJXofxaS+ZajPUvnvtMOaaNICqEJ?=
 =?us-ascii?Q?4v+juAqg5SN7e+QRg+Duvf6at6qvc5IqfzqAlucGgshQQnOx7d+crnUlA3dm?=
 =?us-ascii?Q?RPNs/fnbmq9VfuVeZVHfkIrbY1fDoLeAo2n+FIMtN5otx66GmegAsScXPO6I?=
 =?us-ascii?Q?BZuvsfVFYft/GJsRAh6pzAQli0eYR75bU0FAzawtMwhYVXdp1s3Q9sr0thZO?=
 =?us-ascii?Q?jiBjcl/yIbrduat8yW/f9U9KXVHGbtx6TWuCr38MSDg3DmzsM2V5YGTql04E?=
 =?us-ascii?Q?NNqXZsTlZhIOik28tKQbhHskWiT+LUbRQ1ijMudfDW43oQt/Ukrur48k7CVi?=
 =?us-ascii?Q?5A9ppcCHN4+IHccGEk+BlyMVyKvGOR8lI8CRVBJcnNFrej/CI+DukTsl6UD/?=
 =?us-ascii?Q?feWVkWl8/GHR843Ag1Xmpn200hV9aN6h0WY5Bq7Sb7aGANLny/fQ8Ro4x3pk?=
 =?us-ascii?Q?KQWBgCoz2+CvYJHa2RqceGEBnp+rmzCkmUChsmR0unKjZq9VWvUbBRZJ+h4g?=
 =?us-ascii?Q?rUbYeYTUY3ApiFLyBgzmNqT2MkanZuUgn5xjxzv16DurScqjGsaWhhWl2Z5v?=
 =?us-ascii?Q?onaFaoSiHC/X+LccbdYp2gtPY/uxtFQtNUJVWwZhEuUTu8DI6FUI14MiaEJf?=
 =?us-ascii?Q?g/0gHlX47l3L6klISRPcbMmIu925eA7A4Gu5le+dTOcG1hspE1+HZlcm9fic?=
 =?us-ascii?Q?cN/eO70raapiGVV1hQgC0J59xF8Mpg2H5XRT8adUbRuHTEL7Fl4WY+KCBTIV?=
 =?us-ascii?Q?lMP1Xg1JhwWr0BAUScxo34By9lyMT2Hdcvc3/mHW7R2xlHAI0qjszy4BSlrY?=
 =?us-ascii?Q?+yilEj4PZAcd+bSbQe9pUMgtg4PF4hxyus2+aYpW7jynGuffNU5iM26XkamN?=
 =?us-ascii?Q?0cvoE3LghI1/llBknBGp8kebk/kYRZ1QChBAaC/2pqltXl7rX0joBE0UhyEi?=
 =?us-ascii?Q?K7a7eALJp9mtNsRBNvwpFUcuxbaVHSc4z8MrAXZ/BH1rHxjGwd1H+d3yrdh1?=
 =?us-ascii?Q?K1YjL8+nFUaAM7hu1Z1VAMgIkZw0uWVXegD1vC7jZtAMVmpucbAm8mudSOqT?=
 =?us-ascii?Q?12OwiIO2FlgrIPH6PbQnCvi2nLeDNwJTskC06SAyfSKHDnW4F+ktya4BCvu9?=
 =?us-ascii?Q?0Jt0L/Nf28eXYI7DhAHxvI1p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18c2822-f38c-4685-66ac-08d98232167f
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 03:43:08.8598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/UjezlOV/TtYaf+RcL5cKNcfBP7mCkhF6/XPue9CK6zCu3jYtRWlnWhC3Zdmx9TUIM1R6h1ppRZ5SQ3SMTIMQ==
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/dma/dw/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index 1142aa6..1dec1ae
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -32,11 +32,7 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-- 
2.7.4

