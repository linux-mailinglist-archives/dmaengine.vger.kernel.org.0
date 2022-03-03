Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15E34CBE6B
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 14:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiCCNEx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Mar 2022 08:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiCCNEw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Mar 2022 08:04:52 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344544F9C0;
        Thu,  3 Mar 2022 05:04:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZhOPKuzQekOwxzJWKTXUgJa/Z2q00HEsx/9gWxy837ojVe4vFLCzELFREAHTNNZ6TRfgWXgRQwry9QZjapdaFY3neW1CHHfaULqL8F/uLK25eF9kRdZuku9LpYMgCqDVz8BXWNLOACE1E4467arVUlrL8GRhK5E5Rr5cP/K/ogdUhIvdn8WOqNi3dxyKdxYmh7okrrPNYA0401N7HevtloQzyrhR75FFbng3kdT+h/204SZ2U/Y8A+nRd9lgVRQxvCvehg924iB7yr3Pvy7gvzrKqUbrRRW2oEbJgExnbZYYIleHe9tcxRQEia8mT+lFMle3Em2JZgnl581LwyyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6he9VWg/wd07svL05u5yOFu7k0L3k3HL2q5oNulQU4=;
 b=ia3xS7ijVNZI8UzBffU83K23d3Il/ytnAzpX9EK9/bW51D54D8Penqs09aq6tM0XC7LVAhmUcPL2aiOOmfJqvgn3Y2/zW/SK4ld6677D5ZwQQjiCigUeZf6DkdTKliiTZPueXaIR+mBXi5iPurbi09QlgIQ/g+nBAySFSIfutS/+p4RSsDGvO5n8Mbo0GmwWHY7TtEYKUCVenfZ0fFusCYV2olETlgDzm7Xgs1HTThhLHtIwJ1Zek+uNRkyFF71y8/oH5Bfq/LUPHZ2OaR9DsRUFBm/1NiZtGLUzXV/xdSicVN1Dlbrf6fSEG49jYCC3m8kv1SyaLjv4ESqV7iXREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6he9VWg/wd07svL05u5yOFu7k0L3k3HL2q5oNulQU4=;
 b=n1ugMaaUbD/j9XJFIElm6Bt2IsUDRzAngac0yZrafO5H7uBJCN+0GZlQ/dBMtY4UxdCPDO8ofDd9Yn8/rZDncTxmnQIfW0QdGCzEOy/geht4fwJ122YReY7d6Dql52bjlQYrC0hvspQD1lex/dgZtaoLJiezdU90/djm7e7mh0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SG2PR06MB2779.apcprd06.prod.outlook.com (2603:1096:4:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 13:04:03 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 13:04:03 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] dmaengine: xilinx_dpdma: fix platform_get_irq.cocci warning
Date:   Thu,  3 Mar 2022 05:03:50 -0800
Message-Id: <20220303130350.3929-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0216.apcprd02.prod.outlook.com
 (2603:1096:201:20::28) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e536be3-bc4e-441c-e092-08d9fd164acc
X-MS-TrafficTypeDiagnostic: SG2PR06MB2779:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB27794A699C84FA370147B550A2049@SG2PR06MB2779.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pq35d6QDvguqhuLzGfuqGS++oTtKi7yzbruZsuV8aj5kpj0ij5W9igeGzOUVnRimxKNuYJ+nUcM0fmyRYVPlN+I79iqnix4vpJF1fJt2q8mcCxXyBS4WKQEJPRGKL3H0NV3r2yAejoxPOR/YUxyRd/CrEnby+/A+qGfMDM4+BIBwo4knrY85ReO+o/2Avu1D2f66oxBOoi28GgPa6dpBA4TXJ3Ow7n53GeU1hdVH1DiloR/034D5RRdtIm9BVghZ6/Zbo3c3LXwewWkCJQDMlccF27KjajR7jnSK7LR3ERCwqy8hVmmc6XYrc/eGAXAEyCITXIg6xEbG8JlWmoxx3vFnU3EBYA3yEKb1wDed5BUfUb3YoBhXH7WwCEVlCN81eAiiimv7LdxRmNqcmkdIqskZtue8HR/dzxJj+4fOVeLSqZTJvnZBZO+IbydoTG5tkv6OG6/f43yRwMgtZ2RZdvzx2QROmNdj5uqQSxRGYyGXzaklq4loXgxgEm/xkDqotqT3r7zHp4qNvI04LeYexmKg+Bvoa+tFphA/LAHAv0mceaUza+uxdPXJx+/71LarDz/ZGlgMyg/4dAo7Zs0d8bNSmWxhiUUlSbXreFDAcvN4kAnPO6swT/UUib3AoGtRrNNhb/CK2HZf04M/VnDS1SwOkTVY/dvQzd9Yvva/aRxQLuRnSWowaplpK/hr1ZSLDO1zd0IXlx8aaOYbnUzABQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(1076003)(38100700002)(38350700002)(8936002)(316002)(110136005)(6486002)(86362001)(2616005)(52116002)(2906002)(83380400001)(4326008)(8676002)(36756003)(66946007)(66476007)(66556008)(6666004)(107886003)(186003)(26005)(4744005)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t4s76hZc/AptLuUn31D3yvBeGoFh73TXXqY5yNVUMIrYTO1H8iBXNfD/F0kT?=
 =?us-ascii?Q?poebIwWkv7HkMshaecS02ucoIMncqsDBAidpK4dlr86WoVGxWmMinelb7duP?=
 =?us-ascii?Q?jzLx5U3EqY03h9m2Qxr8BuhzpKiW9x3YP7S++GrO+nOVp5Rz3vL48LjCf/10?=
 =?us-ascii?Q?Dd8Qked9Csc7eNj4OwiRm+pjzY9QPAhSYJRMRI43UH0EUHZj4Xy3Ogoo3dVK?=
 =?us-ascii?Q?IBqc5E0hkr0mQNlpS+Qe1oInyQEifeEJ8UKcI87aCqWIPeXehILsyG7Pb/if?=
 =?us-ascii?Q?z22ViVoxvU4dRTOBouMdd8sg74ocrmQzLHCNmnWftnwbcSIRYyUbJFGbrJJc?=
 =?us-ascii?Q?rKWfnbJBM/cwRrxPFnqe10i8lnTni9nYN9vFt6z2NdI9+S+m7d5WFd4qnYhH?=
 =?us-ascii?Q?VGwJdf3Od5W/Z/zVdTeO3FHMUa3yXy9mN9BCUE26v36afWZUs3fa1ob3xAE5?=
 =?us-ascii?Q?PACdF6hvek2UR+LORm9PSwTdcC9Pu0zHPv8xhHhkNVuSMa/izOEzf1ejAT0m?=
 =?us-ascii?Q?q3WKDOxoPnAhr/DjUBvi9FWr+DqnXXtLaDqEtMoxfwo/BTirocs90B0xqiwm?=
 =?us-ascii?Q?eM8UYi6rQXik5syX5m+JsXDJAWtYByLKB3NSUt1vujmH1MVMpRt4e9f1O4jW?=
 =?us-ascii?Q?VtY3nax4zO4tp/aUM/0SyubWZuypkZJDxH3bBcLNwmVJptkUmUBjmwk5QFGn?=
 =?us-ascii?Q?v5F/sNbSOhih9HiBfVbc1JFI5l3y2EsAPZIWGKjMY+W8WVG4NFFDV0X9ODkG?=
 =?us-ascii?Q?4cM+vtuMliqNgjfx3Esv3xpcYOadqOUCSkZ8psQNYt7CAAQTznI2UHa7K6mC?=
 =?us-ascii?Q?y/hmgYqna9cAYkhc2Zyg7/iiX1uFvpdhBTKhS4wGD/GiulN1+tEEo6+7ss5+?=
 =?us-ascii?Q?DyN1auXgVM2umOix2ORkXGVgoaLTrpgeZgYDa/Cn1vwqxR1msM18FJCh2eQa?=
 =?us-ascii?Q?scgiPGsMOkep+yD8LBLakuV6vhzZcgqAJCaadgzBNA8rOyEe0eK5dySqfDFY?=
 =?us-ascii?Q?ugx830xJFRGjdcR8Mh8qByH2Y8JbLEGBLUSoF10cYMm1TfuHqt1uOI64PB5j?=
 =?us-ascii?Q?qCvOhfWJ2Odu6zXn3reKQOwqFEE3uGImWd+EQ8Vnuu1PD9MGIYF+jqiIEjcZ?=
 =?us-ascii?Q?JVzSUlHVHcAVXHhqcJ6H6FD7w57Gd6y7zAYGc9ykwFQBFINrC1AIAjQuz8zi?=
 =?us-ascii?Q?fgj1lv95GOiJRiM/e3IiOtKZXo4sDS053FisFkM8YM0sqO1yxLaK8j35JiUw?=
 =?us-ascii?Q?mghVHO4p3l1t0VA5kjRL8YD9BUmUiOgIvmiu7UsPScBtIblxam0mNmVaiZNN?=
 =?us-ascii?Q?V4F6rVZZ0n3k6fkrezjDGEoanVTQ2AqeVlq4Jx+6adRnXvnOKHrsKS1dKpM4?=
 =?us-ascii?Q?9uQrDxn8pUmPxrGu/oc7f2ZJg7pKMTGxg2UQOsZIAC2SQjpC6H7++CyAQOVN?=
 =?us-ascii?Q?WRImezjtpRX8lip7vt1Pc8O29f5F4KWaUt1n4F9qsyKuhWg+GdqPpwZdcwPS?=
 =?us-ascii?Q?uoNM+AWzs6hfmVnII/NLcXIsjXD53UORGB4rh8pHKp56reVvdlM38fZBvssQ?=
 =?us-ascii?Q?I716dYVqxKGscrHz20zvdY06NM7YIiNH+JTZX1/p1UeH1B3q5JklqxigLdYE?=
 =?us-ascii?Q?jNUBz3jrEXlmaKiWPwoLgtY=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e536be3-bc4e-441c-e092-08d9fd164acc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 13:04:03.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uccEkecK2I6+ZPb6jjgPng6yYb1M+VxvbgrvzpozND6rhct2IVvRuFxX3Q9sJJPHj28+CDC3QMEhbb8zQIl8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2779
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove dev_err() messages after platform_get_irq*() failures.
platform_get_irq() already prints an error.

Generated by: scripts/coccinelle/api/platform_get_irq.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index b0f4948b00a5..f708808d73ba 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1652,10 +1652,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 	dpdma_hw_init(xdev);
 
 	xdev->irq = platform_get_irq(pdev, 0);
-	if (xdev->irq < 0) {
-		dev_err(xdev->dev, "failed to get platform irq\n");
+	if (xdev->irq < 0)
 		return xdev->irq;
-	}
 
 	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
 			  dev_name(xdev->dev), xdev);
-- 
2.17.1

