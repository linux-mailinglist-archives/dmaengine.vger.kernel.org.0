Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A496A747F6C
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jul 2023 10:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGEIVJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jul 2023 04:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjGEIUp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jul 2023 04:20:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072a.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887002113;
        Wed,  5 Jul 2023 01:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK34RRxNYn1XvbPP11Gxu2uy0q8RBMYDZD/RcfJ4RJFsT/xGTiHVgFBpZW9HcbNaAc3wfK5NkqqIk97Ac+6g2KhKfQ7UNi6w/vfQqyIyGDq/o97I2dbQBvxOQnM26Zar+/ohZH/7Y8TPE6XkL31h0pGtkMPpSaHYPyJ+GgzHgcM4ynSZ9poY6FtCjZcaKKWpzRBF8egv1YrqxpZQLHmJl1w44j1kN08dLxhYYaqGyvoQVEloRdlb77IbJmEi1D5dR8L/86T5wI27KNZUKvYLFfydaphCKfHTpG8LTpvW96Gan+/U390qpbfqglMHVncZgh9GGdbATjRWSYrqq0Rf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBtXhkqpY+MAbVIK4ZrXO0TtwYZpnTQ741WVcjdyNWQ=;
 b=e+Q4PibW/XY5yFHp/o0AqRQFMt89hOIwiRaomoNJOmymX2nqappgsW5WjEWF8LNw4enWXmV9EvuTzejrkA8jORjr6WT1vNkyl4ujJxrV7WyQLPTLmtcXeuSDYuCT1aYxKKJ80WaHHq1rDo6yz0XZWQgXi2IyhAxEoWHsBoE4Oi35+SwbY5VXJJniPXvF78F1ygGxqp/JeHn9i0qZvvF5k1x0H37MNpSS+z6G4QydJD0FJGSTXgHfWSOo1bJtkP80TiPVbsFHs5qUnGZlY9Wh5ZEdoCiwanke8CkIsf06jwrrlKodjv5irXF6bItI4VUcJVidbWSbNWM8zNAHp18X0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBtXhkqpY+MAbVIK4ZrXO0TtwYZpnTQ741WVcjdyNWQ=;
 b=CpCZI9QD5XgTIaaRI/Vnx4PXvc8imor0fnZfM1vxXCC24+LSXxqA3lawRLjuDF8h8e8n4iTo5uH4W5uEda7n/fQIiGkpfklNIhc7rVDREyc7/qCopQy1CkXq4V6yRG/xs7sXJ+x20ZSm2HtKKXbKApBHICyXojbeFP3eiuZU9eyFSCS3L+hEUt/I0vEH4l1mur/fx4AbauJ5mOvYgyhW1NJvLdj52atZbfjHGhEI2mpSJYWGC0zVonzw+e7ykGgULmnVd7EwBdIvYklBvVkjuINhswY/fz0vnLiixmU5rfzsCCoDldBF1LRfh8SpcutSzPhr2YcFh6goIy0SCyykcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5119.apcprd06.prod.outlook.com (2603:1096:101:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:19:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:19:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dmaengine: shdmac: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 16:18:55 +0800
Message-Id: <20230705081856.13734-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705081856.13734-1-frank.li@vivo.com>
References: <20230705081856.13734-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ff06c5-8f15-42b8-fc1c-08db7d3084ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYdLAEzUn4NPnqK4E7z1SnUSfwdmKXJuG4ymnfRzlXEXTryc3LLiv9OnB1gUqACGYt5uh1hNr1TrKI2Sw43/tdVCBEnoIUCYjaHJ16j3CmjA67KtfqxKsF958JsyAKbxX2oBMwcUHrtC3HllKMungooWu8t1NGPZeoD12elbelId3u6SBl6PYZV+UeLmHgsN4/pDM/ur3ti5PCqTl342O3cDzxcESmO7olDv0PMNUcgI6Xi1GbvssLA46YsqwLcYzJYaYa86binrW6ho/X0POCx4d05HyWmvEkbFhpQNs4JRPEUjtNcEUNcFkMxfiT73VLE5oPg4AWSSz3L95FAtZeoCbF8IfTOO4hwjSiTvSOL0sNVGFtOFQHPipqUmUM4OT8XSr6FFthHB/XJqRI07eex/vhXA2AdcT7upocX8P5vwr+T6wigF3pavTIdCncw5SOJ4hD5YDNttQAr/zmBqec1kzVGsvfjkk0AE1ZA1e7Ou1ycGpvSTQSDMKBBc12Unta3h6Pwvsxk+XcGIuwurOZan0fwDDYAFLxzT2vKo78iD4KV07BqKAKENaq7eOCfJZbSylsvJ+itYXD5LWxEAp08VrN0K+C7knV83cQnuEPQi02vx/hcC75OYWhjBNqAO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(316002)(2616005)(4326008)(6916009)(66556008)(66946007)(83380400001)(8936002)(86362001)(52116002)(1076003)(2906002)(66476007)(5660300002)(8676002)(41300700001)(36756003)(6486002)(6512007)(186003)(6506007)(478600001)(26005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+kIWSsbP1bNDii2d5nuYIWKw2z54ZtkLnK9orJyJQ/MUjQ65jbbJ7xbTegt5?=
 =?us-ascii?Q?X9XMkDZmZpJx3RBitCWWMY3qqMLOAeMI6SnwiIJu+6JfaPg8mfLgLfk6IMfQ?=
 =?us-ascii?Q?ITmJzvCH9O72YiBZGa6uMUKVpmYyISssJN1xpB8gUCB8zCSVDxyUgEMRqtLo?=
 =?us-ascii?Q?NCZHdMwm2zXC+oNhWZIXs/LyqRnEI8G5QFl048kB0cVsh1ErFm4+ZLvcUfJM?=
 =?us-ascii?Q?KcjxY6BYJgkNfcbZiC+uh2i4YHmPnaJwinhV1pPywYgUIYKfxxCTuXQM8G2z?=
 =?us-ascii?Q?kcGw0w6uvstG4oTsP5giqLBw2W/bk0/m+EjnhZ/ImXrhY16Bx0e8jukj1yP+?=
 =?us-ascii?Q?sGd5nQB5+r3VRiK+ho3SB8qkPZCkhp12eywb3h5F6zFpYPXeAdkSMewa7Nd6?=
 =?us-ascii?Q?vU21cW4yZdUH1WVKynCA7vzQlokBMYAkbD3z3pulBwEwEyffxl1Fl+JnDFN0?=
 =?us-ascii?Q?4V3ubQDlw4baqJOOYG5RkJ4DgWQDUqKKOvUwHkCjufo9ORYLyOt0vkxye7Gr?=
 =?us-ascii?Q?6a4c1ybUxyeUz5Fo1sPG8iKfv3QlPjKgF5HqZevuVP832srhlONg7crfFPLQ?=
 =?us-ascii?Q?hhROmPzTFLqvb+AMKLo/zq1RmoNApgnmpzwtCarLjzA0LJqIja6DagRHHt/5?=
 =?us-ascii?Q?5gNMASCcNZk0008oKvIVKg7BGiSabXo2zM5kGdix9UYghD2CQ2IOke2EyJeq?=
 =?us-ascii?Q?+luJfPPKGjQzJxPk2pDH6N2hk9tAfegfNziI+8a/nxHY6l789piWZiqz+gxq?=
 =?us-ascii?Q?/jaqsKWy3Z8DbBY5rju+2KjSXaqjkSx53Y614faRSQUCOmB3EPaSNlmAT3+v?=
 =?us-ascii?Q?oW78f80wwLJb49TJjHmqJpR/Y7rxZRQFtmv3oHfSzakbhE2drhJCuyxIOf+T?=
 =?us-ascii?Q?sMoD3EuZXwqIE1qgQQfnwQ/iyTbhiLOXD9DL6AR7AcnnEzYfnNFR1PNKPASS?=
 =?us-ascii?Q?v9dFakCkKe/uq4IOH6hTPB9KsKpkzYqDyb8q5HW3NMYXCfgOuoxvFVS+06Ak?=
 =?us-ascii?Q?WhJ0E/RvPCpRlRK/yvJuytj8Pqh/qQhVfXY4Zbnwk1pzADgNvuRDq37G0lya?=
 =?us-ascii?Q?cur8y2TfzXz2U+vtMGIog1YVm9tmcKXZYKx+a7uSrytveQRH7Oc5Ms/33cX8?=
 =?us-ascii?Q?UDl9MUd3dLwPbSibYCr/S7GyU6OcKSaPzzgvw5nrupVYbktJmaWIx9hY0V0Z?=
 =?us-ascii?Q?dV6xx6sFJKBi7e2jCs/KkH8PXhUtE6XM6V6jMp1M416pisB/kyYqSCgGXcmg?=
 =?us-ascii?Q?5KxlNgerY0eouJpQmDq43RxjFsTQ1tRz/TMymcEnYpbxmzRB8UbBz3a+r5ol?=
 =?us-ascii?Q?n6AMQpVdOlwFDG/Ztaz5Unub16JXiImcbmauOOPDG8+8GUcojuKZDybupQMj?=
 =?us-ascii?Q?x7KpkcR2tbLNE84zKhg0RqPcEZNnPngECgHQfjMeTJATi+0xs0N2/PFL4PrC?=
 =?us-ascii?Q?mzCB2ldCeYDajMUF1SNkp8+lHhfMaqNrD3pUBqmXC9u0ZIuI9HHHuaRboNUK?=
 =?us-ascii?Q?VXG+q4X8lTcZlUIctamht+Sc5ES/vI0ZPAFPFfPNq0tUh5n9j+txTFvrr6Hp?=
 =?us-ascii?Q?vbnrKhyxroi7zVvFUgsOH7tkD0eXKOg337fj1Aeq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ff06c5-8f15-42b8-fc1c-08db7d3084ee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:19:14.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WITXp311hdLcxW4+0t/1J3aN2WflQjUI9/jV6YOtGz6A/vCZVbFE3D7QnCptIlCinj4MMIt9Cmk4OyO45SsMHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/dma/sh/shdmac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 5aafe548ca5f..fb3c56a416d1 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -678,7 +678,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	int err, errirq, i, irq_cnt = 0, irqres = 0, irq_cap = 0;
 	struct sh_dmae_device *shdev;
 	struct dma_device *dma_dev;
-	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
+	struct resource *dmars, *errirq_res, *chanirq_res;
 
 	if (pdev->dev.of_node)
 		pdata = of_device_get_match_data(&pdev->dev);
@@ -689,7 +689,6 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	if (!pdata || !pdata->channel_num)
 		return -ENODEV;
 
-	chan = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	/* DMARS area is optional */
 	dmars = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	/*
@@ -709,7 +708,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	 *    requested with the IRQF_SHARED flag
 	 */
 	errirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!chan || !errirq_res)
+	if (!errirq_res)
 		return -ENODEV;
 
 	shdev = devm_kzalloc(&pdev->dev, sizeof(struct sh_dmae_device),
@@ -719,7 +718,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 
 	dma_dev = &shdev->shdma_dev.dma_dev;
 
-	shdev->chan_reg = devm_ioremap_resource(&pdev->dev, chan);
+	shdev->chan_reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(shdev->chan_reg))
 		return PTR_ERR(shdev->chan_reg);
 	if (dmars) {
-- 
2.39.0

