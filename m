Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A7171A094
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjFAOlf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjFAOle (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:41:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C16C0;
        Thu,  1 Jun 2023 07:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av9U5XjAL9TQ7yeTQXAoixuqwfsFXIcRAMDc7nP+HNmV09aMX1KCOk5B0uWVlQgU337C+l4mqXl2v31Ydne82KlGvLCcDfEIBiyg/Ke6SkfVKjCcO96OOhRbTqL7G0s70PsOeS8oRauh9mmCxERr8bbIxX+x96KjkgimRBJkgQT1XhcVa8nETn/KpnB8wTFhp30zOJKYUF4q6nP4tvhPsoFA6R51rnpWQy+cLwlWtABpZhN7UiBfFqEfVR65oBs0pUJmPPnPNei/Encf24S1iwtkFU5h0L3Ggp+hdFQA6aMfpmw3vmeOCz/J7faW9srRJERcNFQERhAJrMCIQjtDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=EwPHmBuAzrfbg3kylkfc+Pr6k5/6pGVg4ah2ny54tMKIY9DaQbHOlsKKGoDoIx1Ll9fYCHyhCmn0ASZYsnovZ/DcKkaBFdZG06CryCvt8O9Ok5CDguhWsMqsLymRvBP1w6KNmDiS0H4Tp4WJDGz0FAIMKj+KlWS7FN1c36dKQuwFfxhUIqRqsnHKbK5cftKgRpKln6oIq0orC2W9koLFfQp2v+StbIOB0RSK/zKFc0MxtSrXRww1uy/Yw+Je1jGYRYys7K8CGizQsiAJ9OAzp5zEa+O7oBlMSLHK58mHDgP3+J7PGxhOTas6UOL1Qe6zH9a+qVcUca73wqyvT2laPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=TUe0fopyOHfLmDhL3ZskEn1bAB78yUtxRkt7TB+/dA5syqSL1J8xIcb1xHJjCm0qB8h8RprEvYVX/lNEl1lvxO2Tj4KLSOPKIay3kmmHYxUBJqm6enLCAol0k/Xttn9aIBwDXGftiNB76HOJbZtLwYtApe3eOSveW5j7vfj881o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:31 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 02/12] dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
Date:   Thu,  1 Jun 2023 10:40:57 -0400
Message-Id: <20230601144107.1636833-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601144107.1636833-1-Frank.Li@nxp.com>
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: c190c711-9a41-42c9-9a9e-08db62ae4a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zIphlLERM110gG03puYd+Lud+ysYa0CKzYRvXif1jyrLmOgJ1HkKy//Xns860DyJZ2umCviDADCoqRr+yG9bNNCW0lI6mjh1qD6mF2UWBao9CN8sSm33DXAnlBXD6+PcFQ8LGf9bFie67uJO1b1Khvf7K/ziZqRbnJ5Mg7egM+5Gjd37Sh6lCEQ5aJ3YyKrxu8lt6xyiGU1gKTkUcTuxaecFXEhaOgfNvsYBD2NYiiiTY3HROMMuOmt+MyKgqz/XVL8aWorjDxUoqPLegpyJZ1MnHGslB+WH87KE/d1Nnm2vqMztFq8XkXGjTbdms/GKAnxb9wX2xpgS34HmHyfoNUIEJ22rIWqkmlRVxVrI9k0dhQRPY6HkMo0y/s1SWDaPqVvr7ljHpN0vatw6dacZhgmR4ZiCguzg2JMA2fTFkpnV725oSw0TJLdrx4U7GibWWLRCR/fagDxR4HVKmTPj6J7uYH/DYtKRnxzQ5deQ+PY4d6RySqyiG3YvkqoovL0VmAlYG2pfd+y1OlsTtv9TDOCXWmovnaA6fTCinOtRIxlbPXPU+uaTebDVKT9btVxFQvXp73dQ30bc46A9kEG2EV1bec3HPsNpysMeu50by20sZjju5Gq7oVBggTYjG20bjdLz74qxUzxhe6iR5vcmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZPdgNj/aY0SAUCsMVCCO5/zHrgJ+bJgjbg6vXRb5uhxMwUueuTuVNGAqQHY?=
 =?us-ascii?Q?m5AvM5/olLHIKgXOUkJrNOtR8YBpDNOG+ccdGTcWFWdg8QwxHA9vvSXVxq6f?=
 =?us-ascii?Q?2EvE6EUZGsQCe1wj0hO6ZLq1YdsqQptD17sqlT7b0UhmnxiwJRBkTIgQGBuI?=
 =?us-ascii?Q?lZc5BEm1zgArVtzHdAefTDtjEiR+ZzkJt9QQ9KAaqjFDvJmb0yby3XM68PYZ?=
 =?us-ascii?Q?wGIFQwx5HTfa0BGnJWXl985aiNTI9l2AMtHkGkVOg+i51s52leO389ikLBcN?=
 =?us-ascii?Q?MHftLASSzOj9E0Ljd/eua8MYa2R4J20rdrRKCKtRJwtNnbcAZJw1TUtHjYkg?=
 =?us-ascii?Q?5Cq8lNJ5JggZx2Ikhbc+7fpXVLz3ZDZTb6VLMqc13sXlwMpqruastxdbo0v9?=
 =?us-ascii?Q?T7sVa1pF7i0mCyuguxJHGXxw0e595uE6aC9KsIL9HLTFIeB5idHDyqwwO1wz?=
 =?us-ascii?Q?ya6EgzlaeJSBHR/+MTPatAiaWQeWLZLg514ivj8ToOG3vXgrscVEX6g1cRoD?=
 =?us-ascii?Q?JeYWwLtINbwWjUSXhJT5DgRUGaA5c6f9d6uTeKe8YKMfa6/iypz9TkErPzEj?=
 =?us-ascii?Q?qyfchqm61mUuYlGkLTHl9io+m5wS332dEPADfeDw+RVbEsm9KyCuLWxcdQAv?=
 =?us-ascii?Q?4HjUfURxmlYrH8rVu+470B/68562Hn3GAR4RVeasL9XL2KZQXInAmZ0BKlQv?=
 =?us-ascii?Q?8M1Sk4T3RVZlX3iOzlht484F3mNGnusLtS8byubmToeelCoNlYNm49ox5RKM?=
 =?us-ascii?Q?vwfDAuEzIWoTIgtMiII0JVv8TErhhu9fyt8W2vKNtIgxB9e3X2udv5uzlo4J?=
 =?us-ascii?Q?bzQ4QtsuPRKkxrelCZc6Xnyf0KGw8G8sFpsIq/VSUUrdCFra8E26r2KwLA7E?=
 =?us-ascii?Q?1asA0zBEm8lAVyc6KE1Q5WoFodramfmCWPTL49avaeUQIlTSlcjcqjb7TlRU?=
 =?us-ascii?Q?Pwt05vC8/R+wS9fLSuc2k2X4a2pcgguZcWKdNX7YBjbEGkxUE6jZtVLxXcw4?=
 =?us-ascii?Q?1mbhXd+ymLQ2Kbx63kI0mlVK2wOKS2oad6hpqEy0BCWPC6WbdS3SD0yHCiYR?=
 =?us-ascii?Q?WQztn3G94Byszdfzh0e6qtc94WICG4ZX509PX9uAnbJ4JSt9Nd+Ms15aFuHu?=
 =?us-ascii?Q?3jl9xsojOHN274E8ySRYFM/UjmqrepMAUR5m3lrc83YtBaxmOzxCqhX55F6w?=
 =?us-ascii?Q?GfGVfRghZFtuVDxS8OAyiWdwfPS0CqX93nTArZgvM2B9IR2OWCl1W9WjnGqr?=
 =?us-ascii?Q?f4/CBIrJIi/Hd58pZG1LAkobpj6ds+rJ9ptbrlJOBVhwUiOSZmLNahORjac2?=
 =?us-ascii?Q?BZAXJDmzJMzXw+PXpmPaZwmAXusk9jVSLbzKaTPLVdFxkQMOWmVZ1c6SQnkt?=
 =?us-ascii?Q?IPOasyhjfpPI9qr1jhw7rY5+WhBUErpZ0DB72qz2yOk1shxwG60+s4suIfhB?=
 =?us-ascii?Q?v8i3lfqORI+j4ZF39CjHKJBNxndBLlmA+y8tR4WeG586KS+cwdtfkgIIJ7x/?=
 =?us-ascii?Q?Wt+hsbB5FaEN311R+VstYYK+f9G43viClBxbnv+uB6FBUXf+m5Zqfmjb6Pxh?=
 =?us-ascii?Q?CT44Rd1nsUZkFd+9ZZoqEtBqkQjbH0KUEarsDkRy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c190c711-9a41-42c9-9a9e-08db62ae4a26
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:31.3322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgOiyB12a5hWMfTwwiWO8obtkFpdgpo9tRLtifelhAHZqkyuYwUYQDaDYSajyRCaetz/gfjcGBhTGA/xvgQhjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the probe function, devm_request_irq is now being used to automatically
manage IRQ. It eliminates the need for manual IRQ freeing during removal.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index e40769666e39..16305bb9a2ef 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -216,17 +216,6 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void fsl_edma_irq_exit(
-		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
-{
-	if (fsl_edma->txirq == fsl_edma->errirq) {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-	} else {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
-	}
-}
-
 static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 {
 	int i;
@@ -427,7 +416,6 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
-	fsl_edma_irq_exit(pdev, fsl_edma);
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
-- 
2.34.1

