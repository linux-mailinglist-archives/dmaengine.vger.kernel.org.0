Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6B72D095
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjFLUfF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjFLUep (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:34:45 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2E9E53;
        Mon, 12 Jun 2023 13:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRGF3q6NeO/S6AVhIf+AvWPO1sNgVK6sm6va1rem9yUOexEmWKzzOF4XbhWfXOTmZMzAzjDQsvoHD9swYL1kfnjZfGnIWfNKvRB7VkCoRxxZxZzseSPSGs52u0f0xJK7Abf6WKvwGVqbY/GO5saeD6jUdZtBlWoclFwVLQiPWXN9rTlvUj+4/1nn4smY/o1LLLdW0b1jEZobHHUGmXkTJRMalYoF+gmNiLioGx/Y6wacDTylcbVg3h+aJbvQQ8BFt/QnYs8mc/nD0jKrTiSNBawwnlYPLE0FsLxp3hUyQUspraugs+SmAh6b2g5zzIIoGxBN9XpNctOEdESeW1amjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=kGfY75RWVQVRoOMbZk0/ao5e5LWkEfqaAyVknMBFk2mowNdu2MInyW0nKexvBdJLxr4XDXXkRvst0Qk2oYz0ns1fqdBPjxLft7UWHuKTMnZdOlpL1huk4h4xZwZ4s1j32zGzqedB8uMoKDS48aOvn8pxDu4djEgxV4dQwCx9S3oFSAGol3scGAEP4yZSxrQ9GHVQaaVsQeuYmLv/o4VUN7Q9oGE0JKQ3Qaep4u80/LdnxxpzYme7J0+jpiZqmGt/Z9xiTxWNnl0ifKtw/9ZA6mzUtZywUxuGyB694k8NC8Rh+Po4h8ESdeOwarPIc1KGJvqKuqIXP+mkCkuU6cnJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=X7t0ef/0+I00tFFygDpPcw4MFKf+8qHlp7G+9LrN1Z9QL+kNs9MYXp3+kyexNd5xmWZACtsJYgpZiDccSsFrkTQhh32hmpFYwll6e9vOWvjVVSF5Srw6DFuNFs+q3dtzix7vVK5GMOTFxWvkU32cDsM0Dh7nwtj+2lc2CgHeKac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 20:34:42 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:34:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 02/12] dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
Date:   Mon, 12 Jun 2023 16:34:08 -0400
Message-Id: <20230612203418.2017769-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612203418.2017769-1-Frank.Li@nxp.com>
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6de7b5-70bd-49b6-6db4-08db6b8473dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vtiZcESxeow/w12Kld5NXkODeJ0dz5Icxu9WH0oYvWNIHPkmPLYZMG19qI9yijoi69t9YhnimIzUhNOp44B5FM8rbockcrL1arcnuKM124+Db7o/rN9AM74IGuLnoiNckohdDIczlAW7TyVxvt3vpgpHTKcnxdkZaPebLUMuME/BSUzxo4D36alW1AfNaYIkYshyfnuG7HjSuniNWfagtd4I8JVomY77dYm6jPv2WEtg1w2FcG91zfuDb8G1y9O0B1tf1JhvTTsuKyoPmALe0h2BsMSkZffxfA02lNsMmNzqoVf19OmLbSIJabZCI8m2lU5anabm61aGp+VoOUIfxW0ebJ5ZmRmDYcwRsenWDFBbrRoBf7RD4Wp0U7Qjn+o24t26P0O+4nXeLMPlO83fE5axn8ysCjUhzvUX/yE1eql5mcTKO4aJn9ICWGtTbAEUJDGANLEgzFOYMRCwqBrznQAk4x4gLIay5AAGJ1P24+ZfgPPGg0FhP46B8gFGq2p08K6GoRyC/F1s4pGZJqcdqOlYZ9NV8tRK9myPv1kWeeI28UMb6w3PV3aqrNXI3Zn+ObidITAmg5U1gJhI4QhNKo9FqIBY5bwh4Zp5lJeFkGMLCasW09V7+zQxbllsFfe2B8iz4H4aPefcjTeBDuf8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(66946007)(66476007)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(8676002)(316002)(41300700001)(86362001)(6486002)(921005)(6666004)(6506007)(1076003)(8936002)(83380400001)(5660300002)(26005)(52116002)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bANhtFmkz8h5bPQSGinBoO96HhhaqOo6Fs27rkg2Iu9HeIliI1zpGHW4HKTQ?=
 =?us-ascii?Q?MF76JfDYfPBwzKY1XmacuB2Kmivh4jf7vAnGe409TAL+jnbJxg69sNmRh/U5?=
 =?us-ascii?Q?IxJOCEG6onDjel7wo64q8Q/w9Ys0nAP3Iry1l+ftGQ2OreBRkU6r5mvzVkyq?=
 =?us-ascii?Q?OavWGqvBbm2eaVadQHHXErSkDn/2FIuzpgozRPQaW5Pno7LnErfUYk+6T5J7?=
 =?us-ascii?Q?tohfA91uB4yuQr/UhwZnMpsGoisdfYhxXNs83SP/7smyMCdWty3qqZfePk4S?=
 =?us-ascii?Q?F+lp/kqGLX4du+gt57PipYInXsFBDdid7AXRYGgsucS13ESzGdt7WuLAoXgW?=
 =?us-ascii?Q?WGE4POekhSm89Shu/4ONVDE1YmXGEYqdf7l/YhOU98TQWFRYDF8s+u8EjCh/?=
 =?us-ascii?Q?fA0/mPtF1COe+hN0yALLbed5BTjRu/bIYq4wHJ1rHZM7QL7MNjBF0L7iQC8/?=
 =?us-ascii?Q?9RHoJHbJ77s1gBoen2Exk6Q0AP2ihXAAKMRM/GUujGrBv/VcLkPd1e71UIMk?=
 =?us-ascii?Q?bFl8sx24vyDaNaNxvolcBaRDrNWPqdWcBD4QSMciRKUAOZSoI3UUgPBHGfTv?=
 =?us-ascii?Q?OkT9gKN9yl7ig6YKYe2RK2UuFsGuJXs4PFZEEnwGQSJYSHYXbm2iokmPIMqK?=
 =?us-ascii?Q?D56yTI6lGpWQ3owRqKSJN/I+7Z9C0ihVDawvAjO4TP5BLBWuji+yOITbsBnp?=
 =?us-ascii?Q?T4rMn6+O+JCwwx9n2ioYU/dG4ddTsWDnB5oaroSSlaXoj8jsG7NOyUb1G+Up?=
 =?us-ascii?Q?3pND+nuNDT7d5MoGP6d5W3rIHrtzBOgisPnJWZoW1hJE3f4rbXFQPCBGg8KV?=
 =?us-ascii?Q?LZf7jdvyUXMSdjPuS/L7l3Buz12XGklM8nv8PiVHbNk7u4ge7bCGUGp9LsU5?=
 =?us-ascii?Q?T4GOV64HXpBU7Y5uyWOTZT0VeGB0vUAIRcI54hEHNlxzX98nUmAAFPzvOvgA?=
 =?us-ascii?Q?f+FxO8NGlT8FdGQh9yz5lAqDJrHvjYV5ZpN/wCXgM5WFRAt2gQLM8OzeNT+R?=
 =?us-ascii?Q?Ln0GEkgRs3IqwjCgFIglxjj5ehW2A+XTWAi0q1E9zTjTVz2dl3BFCf1Bu3My?=
 =?us-ascii?Q?DVpkbscuGr/sqs54Sk6WB31cCQRKIGmMQtCEeVP6Kyw5LsBaV+3DbGxM0NoH?=
 =?us-ascii?Q?pIqePX+0rb1h5D7sa1l+b86yH35HpYC22/fYfnYR33giIfhEND7yIefRYvLf?=
 =?us-ascii?Q?cMZ/4Rli2XCZNks6AjhmyovHF9zSxHmaTqQKh0ILDQ9JEoznbbRsmzNwIX7B?=
 =?us-ascii?Q?xr2Q3VA/Uz5Giil/s2XHn44tmgGigJn7w/ip2DA3rLwgHjU8j5cR/KoJrI5W?=
 =?us-ascii?Q?md28+w4mUY5O5F1kDbPoBMJr8Pp2ZmM5MiWaU0CAmeGa4XJGbkJeRWfXbLEP?=
 =?us-ascii?Q?R/PzN+nO+k/dxmO5AxpXRScgYbesT/wamOq8uPmiu5ND2jVDC0IGeNHesnQg?=
 =?us-ascii?Q?hIIKUHlhmTXxUSsYtqMdRhC0jp7vhtjyh1p4+Wd5PXodEsND0KoSTAtxFj/u?=
 =?us-ascii?Q?TXHEOnwXD1t/tyO4sY9Z2G3G9qw/P3IoUto9ZNiVfCQMKmesYfctZuSFRxIR?=
 =?us-ascii?Q?SmWPtGEhWJjE4zO0PLpKNBu6w5JIlTk8gQZ0cWX/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6de7b5-70bd-49b6-6db4-08db6b8473dc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:34:42.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXuuCXULRuwsuCUj3HwjM0W1Bg11shQDkNd9BmIulIZXfwx//r3MK/xjR7SNDPitcsxwB2IHqK4nJoThbT5Y3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

