Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB7E40F2FE
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 09:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhIQHTR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 03:19:17 -0400
Received: from mail-eopbgr1300131.outbound.protection.outlook.com ([40.107.130.131]:6797
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233196AbhIQHTQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 03:19:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHo8mEj4oS5X+E+SWjl7riELyVwXJESfeDNt9PxgxMgsR6mv+fM0UCl0PDEHGtGHReIjtWw/9x2mdscO7hQj9r8YXB3Z9QFDgkQ9yAz+WTXcgxbCBEpZEUYtJ4vdMwcuDxJ3jWILZa1vj7noqqx7DRNs5zBE0KtdHaS4/m2naUJf5KIN4frlbWJRbJ8b400FQD0XE9GNobRPKkw3cWv3CcpqoIrEgi79PDI+mDeJXkoHVolm5ZB4wWPwOzOPVmbGuqJr3Qww7aLc/ky9dxpd2LwpXno8VrXFrSDZ7oYveUUnxKDdlvJCco+bV55Xw1tVMPJvaPQUEMtPnhkawol6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yrpGqPgA4sb1rg2bKlf8wEwzFyxpWqcCUWpSJOUQPNs=;
 b=EG4+Tv63uwxlpeE2VmEdLERFJ1l4RJ7a6niRgkUJanWBsAxfX4A32DDGIpj+qMFho89t01ma6zv7oJQg2svDOE4S0alF17ew7SA99K0BSAk69RmO7J9aoy4xj82y/khnecTk2UCMLG3dyBA3kfDeJYEXXIwPE/ocmljWtBtyM/48OXL66P2ylo6MUGVA4NB0KDbetqEo2FL+DeAGY3VMPa53KUrRQGQJae3sez0HkSWJ4E4ZIjFvzp2QZnhrrztWWAe54wzsXgehwxgy332HXeey0IvflnwshHTy4SoYQPwR7E5xsscXqMkammLqNO7xlyYFdUYRP69sQmI8h2rwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrpGqPgA4sb1rg2bKlf8wEwzFyxpWqcCUWpSJOUQPNs=;
 b=Mm+Z8mC6h0bGR+ilaD0zfd/Asf1/H70Fg0t9xrSEN1WhHdy5HGWOEcnEqzIGIbrS5yJTwJlKyxx+G7bEU/78Cm4ro3u4HYCx5sP7Zr6vZg2aPhCqXCyaRZ/G0yPSp83qk/wjF9fU1vvanKYdiTj2JqB78HbSaDFs3kysGL55n0Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3068.apcprd06.prod.outlook.com (2603:1096:100:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 07:17:53 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 07:17:53 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] dma: dw: switch from 'pci_' to 'dma_' API
Date:   Fri, 17 Sep 2021 00:17:45 -0700
Message-Id: <1631863065-10181-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR0401CA0011.apcprd04.prod.outlook.com (2603:1096:202:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 07:17:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3925c93-7dec-4b9b-e471-08d979ab43c2
X-MS-TrafficTypeDiagnostic: SL2PR06MB3068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB30686844322F3579D3C66188BDDD9@SL2PR06MB3068.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJKX90Q3kYvaVA1vlX02I6mATpXa6z8oh+luInej3uOP+L6VLw2daAlhvKcanIEq4q9lPpp4n6vqoLoPuLHWW8bJBAluUsKErnBxYucX6fxbgkwJYdEtMtyChSzsKjOCt633LTu5X3BnUXiO/yBRHHEE2Wf1oTY+bshqYUers8spUm9onT3h2Fv8SCHb6jJ3C9UlFwiEHwpt2MlnN+kTua0yy4zQNh+NNrmBwTpFicBS2N3S6c+UbGFWE6TCFBxhzywTxPNaz2optmPXA6njxIoMSRoq9wehlWU0RJwwb1Qor5HJBmwzy7L7cToWEd2Q8r4nV+rwAndwu04uREszr4YLX9hhKfNkl6yYI0m47Ut82eeC5YHilknQYd3ujQC300C9PsnnqvvPwa5OYRcYVUoptBWJSy2JX40HnGYyJWdd8f9xHEtNhUmKYHWKd0HGCJxSrSbslQY0V79edcjWPxbBPL2A+XEzYjtqgoNjNX3565Q43fssUk9BJ7Kr8eZtyX8eGhazt9Zw5NBTHkO54jwOrCDHUhOm6rSmKM+Y2fwSHK0+xABbH3ol7WXd83DOpyRDZm1fA/yqoKOUiZSOGLHYbaSxjHGN9qhGNqjYI1oODDD4pPcolW2Z2SuSf1lYnHPG3oUqSptklHzgb1hDjE2PadQXy/Iyj9a84y4aXts3Lg3PHIPzMRhhK3WVW0lZVvEj/RL5HL269A2l4cLZ8U8M+WxKLeNr9ygCCCDSLuQ4pwta4JKMOS/9M2M+uPgffrMMkRx5kEe/oF/A4ia77Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(6486002)(83380400001)(36756003)(38350700002)(86362001)(5660300002)(38100700002)(956004)(316002)(478600001)(52116002)(107886003)(8676002)(26005)(110136005)(966005)(6512007)(6506007)(6666004)(66476007)(66556008)(66946007)(4326008)(2906002)(186003)(8936002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFI4lu9JYl/jjM8Q0D1pUBEku9yyEkmnJJ3kuBT7diODOiIpcF7VxZYb3oRy?=
 =?us-ascii?Q?q3cG0+BgUOv2cv1zidLEKGNL2wBh2fiQ2+vsus8dSQoIWX5jBlCZml7WeU7t?=
 =?us-ascii?Q?J2+LBMU8BNorn97AU0NssS09Vs2ot/oOJ0Pj7ZIOSftS+jfAmuaIHPTXV6wp?=
 =?us-ascii?Q?AH8j8FVZwvCHJU65eCwAYXsb16boGxm+nqT16uegJ8Dc05zh+ucfq8laCsqB?=
 =?us-ascii?Q?iB/RKyXvS6bxmDpfUAKs7M0blFx9ZnfZpL81UiHLA72/ykDhx4tW7H76bitk?=
 =?us-ascii?Q?VAwJX433hCgR0pu2vA+szaS6FRKj3urorWM4BVX0AFaKwqwmmlhW/Brdjaaf?=
 =?us-ascii?Q?CScVGU9mIT3WIeMEarC6XIVStsTvi+Dp1Q7vg+UfGcnsFwIPeilcT3AvPDQv?=
 =?us-ascii?Q?qNtu6PfitxxvW5eFtkmjCCU6jxBhQA5D5vdvb11BwFce2cbf8MUGpYHZ0Zzu?=
 =?us-ascii?Q?2+qfDIPuzSu3EaxzdoStDDYrFxaYKARyLnG209Cdfu9NydAtoHhHWqXVWiFu?=
 =?us-ascii?Q?nWBiHz4WqaCjtpcziBE0IMpGSwwlNzvV4KF5ttyJi6V03cCtp87KQyaLXIbp?=
 =?us-ascii?Q?9+DC1XfKgQz5uECSnFr6yQ9No0GYCsxHHKRXIjmV2y8H5f7G3qpV8WjQo16R?=
 =?us-ascii?Q?wVO3CqktwTHxz9evS6N12rJoG3u9gO5eC495BxzFhRYcNsZyUXSv6vhm6otW?=
 =?us-ascii?Q?3cRcTr5ag6NP0Z5soZFj3L20Okf40iLqdTU2RmSzZ+kFV4CnZNLnF0seYsRU?=
 =?us-ascii?Q?5tlzevqiSoNKXXEe6WVbts/+Yat4mmdOyybpYGHh+ZE3PAZU80IZp0AOGTsV?=
 =?us-ascii?Q?8KETJ4wOK5OIeJgpW4OhfU9oNxB24rCSoQxqPBtSZMdWvS1pGzATxNW85m1n?=
 =?us-ascii?Q?ajo80D2WCJ3NCR+qi43qpApuvbXne8cTvxhTV0o3dsEDoSLPImm2ST6kyq/0?=
 =?us-ascii?Q?m90pMKDRLYeuuyxVpp7spUmaAEiAjlI9DovJkgH7PtHuY87MqLjndu0Y3RqN?=
 =?us-ascii?Q?uKOkNyvpcNOheS5XPfO1QABhhqaSQ7PrBsSDR2IO64nSj6AZBvxl5Dp97Vqt?=
 =?us-ascii?Q?QaCmxDUgew1kah8FIV+VedIG1JizmeroLAHik+ghrDtBhIHTwIVjuQgb8Oh0?=
 =?us-ascii?Q?/rcaxc0z87+H+I0xxb4fv4ZvHiPHEKnw0pbRxv8vjnLoZ7GYBWIONeIQepqZ?=
 =?us-ascii?Q?Lsg1wxagD7qCcmL+u/AKnizClwPxD3242zSqcpYWN2Jfl4k1vADphb8GqVRS?=
 =?us-ascii?Q?3i1IbfCZhpIk/RBlGQEAHt0IhGi4MXgg8gI90aLiq/d8tYeb6uR+kPM7tUGH?=
 =?us-ascii?Q?k/MP1p6/JPHUpHpyZwpNoRti?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3925c93-7dec-4b9b-e471-08d979ab43c2
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:17:53.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNNZZfZhiEZfhvWENpYl6oix6TuiIPhu0OvIqnhc+AgJV1Faplelt0u6C5K000CXMIivqvop11hV4v6px1JdOg==
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

