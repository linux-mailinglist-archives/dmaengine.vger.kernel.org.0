Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B65734778
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjFRSKC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjFRSJz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:09:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E2E110;
        Sun, 18 Jun 2023 11:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDhdI6mfwJcYFkJ+9Uj1K7DccacgKEzwzmdEXdlcB8rTzxvovkytmcnmi2zy0giah2ewtswmysV4VtZbDZk/mhFVkLnqKfnHMWtb8x4Hl/bzh0nvHxiAygiPS8fyP2YJ6M5KLh4mooFBy+ALM5Fc8pDyScrwdvhRB4ymqNIIgB005LOnw8qb0CucJi9YUTUV10L7Q3gXLlMW0iN1JCRnl8Cyo+HF100rxcN6hSxlJmQC7hDcBfBuih1gOwOw8YF+8PUdoNcTmnGoxLFbkPuxDSQhfhLK2uTr+ODsE3vtMY8wx06lCmWKRqtP6VmVES/x1xEmIFZaEQzG0nTCvahn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=dULaRXpejpkk0GvQFnfP+HlaGUYISXTNomJGs626pYRoPBYc1ZPFTBXe+pCZcd8feJgffJ3/xJHBUn7r/EeEBVDgiCUyIAH9qmwuaFNG+3+K5lqAbK5Z/4DV63Szu8Q00Mvo91yIc4y3tAKEWWoWRi/crofvHtC3iGdK2817DXG9suwD750fojPXlbYlutP0f4QIbVtWrSiPYanTP2iDqUKN8I8jAu0dOoRyVPoVvqvnwaaOgPFWPrJQaTj6MoF1yut08jbglLnfkApg/y4WsYzSOsOHoM5Z7z02qfacHIqVj4T11jEl9Jxn3JB2zrXkamugvd+EyK8fmdsRWCRWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=NkjCxHrVTXO0RfNHfrxp0UcVyUHZqyowFMkmHRbFvCPOEY3Vh2CkGM/8XtgmQETxDzb3X4RzqBlgvGyPBF8YSKJM6ldfQ2hO5ayYKMo+dAQyZ2oGg6VvHa9WrwLKBR6+WS0NSCiPPGF938kr6LsbUEABGOcX67CHxroefnPU9lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:09:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:09:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 02/12] dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
Date:   Sun, 18 Jun 2023 14:09:15 -0400
Message-Id: <20230618180925.2350169-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: d7678c36-ba37-4b59-ed45-08db702735c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAh1UiGDu7MpD4/kmuPUXOlgYecD+LW7wWnB7WAcKfFW5plqy1CUN/2WdtmuIVwR3/P9Q9EJYTIjAYj0WP1a1d3SSwaQQJTOa/XD1i9nkCxVWxqle6n7i0PeWzmzfEe9Q3eJur2uaT4Ip/MhKOKgCt5fESefXvBb+rW3KEY0lyUakkQYLh1tnuwir2860kVdRd+YGg5QZrhYMOvglmx8oj+P92SS7GznfgZiQPVnKZ4D8rdnyEDuXAvqji5FqvGf1dQthvs+aEVwfdk6bXHsFoR3CCLKyiwVQAB6kIS7UHUWT0iMIH2Mwyvb6iT3Ez2KRdxcYhdKTrxvn06VpU/qVBQaw+DGGIkTdc9evH1ald1Yg3I4AvIdgFFYTrXjv741uWrlcMARX8Up+NyPKXFlD7FatPZpqmE94Kb2rxvkWgE/W8dAy/wYWOV69Ktdk2Z12T2JiFcazgtQrFjrmQ0dsHL4tkTLdXIypWyLSQeBliTXGx/W8sAYHSbudLX6vvIRMod9aYMaerRk8E9Z+H+mGL3I0SaTD041HKDX5KBxoc2jLO4TV5l+6MxY1HDEoioQhx51q313oopgw1+eD+prmIYET8T+zMiRbnRJw8MDwAGakWIdtF6MqvGawI+kyXb1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EhrGb7/VvxNWQNy1xnyOCOV3e1510Yc7kozvD83lYq1BqFEbRW1cPulKIvhd?=
 =?us-ascii?Q?m9oO1eP6UB2Jt6D8Z4GEro/D9+1P6vNebJ/zhEO3aAttklBWRaWXykcnSXVw?=
 =?us-ascii?Q?jsvZrDrrOt2TgmjqkD1t5IOClvTc4w0AW/SJ/LBJMW0wBYoczXBOtVS2b+h5?=
 =?us-ascii?Q?tgBkgfaorKo1y9lpvRiyYndeXKKLh4Sr0h4ctaK+pwHbLMTC8BtYkgYMg15x?=
 =?us-ascii?Q?NoAfOCS/hfpRSolpHmKcxjDsKiF1D/fBIYXTDoaF/NboLGzz7j5+u58+EQQt?=
 =?us-ascii?Q?WcgLfmrGU1q2QE+rQ6M32ZOs2AFAJQ07czS/6XySqXHVzvDYCCsZn0IwBJPq?=
 =?us-ascii?Q?9vawRmKBodeIpKFwv74+JtwZDNp50TnQOnHRdGLvbQHd8Fe1k259eU4cEszT?=
 =?us-ascii?Q?Vp8qAHshbeEDKmn4QuS2cq8FSJb6cv9IWwIDw8BOri753IYy5BLNrs4KzBiT?=
 =?us-ascii?Q?X1Rnn+yPKpA/XcvCs2iBKFR6cznI6okZ1XD3WT8Qg1Lg2CfDXLLQWtOJfBb3?=
 =?us-ascii?Q?9RzWRIn3AMmGdhdqccrJInPXgr3mvmhpMbgOpLqEq7dQb3auIByC4QKnJmX6?=
 =?us-ascii?Q?KB3xk7C7Sl30va+vhDU+vVveKrolQ07ESZLpgQCbOOCuccSBjqLwQ+iSwihN?=
 =?us-ascii?Q?RJ/os99BbzWb4Y1F4RgcGqj1H+4MThtaVtD08ubysPNjvwL7JE+Z/C1+JhqP?=
 =?us-ascii?Q?vlf3CwW+ptRQ4KgEmPvZGq3CfTyDo4/JXYfBd4N4aHjM2eyeE4DdG1+6JE4E?=
 =?us-ascii?Q?ZQqT6z5JOjNkf1jSB3Sm8UI6LQWpd2MsvQB9LaFlX+1wGpPfEbcOQLdg1c+0?=
 =?us-ascii?Q?ffYF23dcDVMSevh6ixh96GN3xkkK5unz54qhZMJegYz7YURLCnOfdfi0ZnEF?=
 =?us-ascii?Q?Edt5FmaKxTVvl3FXT6GmryB6c1CO6nbY14hGYbckdIf3Ew205oNtBI7fLOVZ?=
 =?us-ascii?Q?DJFRBvPir4tnx8VxcawHqjo8Df1jFLapaQO+4MDXZC3XNPjJPijfM/hSCEDh?=
 =?us-ascii?Q?CW3yIpjXKZJfSESmQXtbp+NS3DnZBc7o7yMXc+e8scVXLDF2Dq4xdkb8YlOs?=
 =?us-ascii?Q?3fI6nF8rw+ivAvdhzufYGN3gub4IjXV9MwMGkc72r8qti+JFgS85uTn0n13s?=
 =?us-ascii?Q?d0qrfzCcXW3EXrk8qbZWl1lOPtOhNoiVL0VI70e3PYYQTgCwTKc4/iasURMB?=
 =?us-ascii?Q?kusLjDwVKjPpoQapYLTVHTcsQRacba2r2kbpKAv4nxOBnA6Y1VccgWdjwH3E?=
 =?us-ascii?Q?9EA7vWzGOI6mVZiaV18OZsJWUlntTJopo5rZeQQpe2plC5B1wrXo8M6os+4u?=
 =?us-ascii?Q?DHqZH6cVlQoAoMfm93jTv+fOQZbPHPSabG/dwQZt64t6eZ1uNx1sHLeQ1/QK?=
 =?us-ascii?Q?tcsfX7OIzwwHxRZ0GXr/5CJ1ekEsdZLdMVMxCiRVx2C9/0QRZo8TJc5LLGLp?=
 =?us-ascii?Q?8shp9GhNomtXIGAnH6esPdQd9VfKcrkpkJphsT9MZ9QuBOLpXcBS5ZdL4Z7K?=
 =?us-ascii?Q?Zn99zREJk684zt5yUI0MWgnyzTVwZ9GMULrxFD6IqTUwmrGXCaQFggNKF+xG?=
 =?us-ascii?Q?CalyAjGTawHg+icqW5m+cHspaWDu1tGY3Q7Q/H4o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7678c36-ba37-4b59-ed45-08db702735c3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:09:51.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uhp/A3DRRvx/0tyV/AUIliGAJKGq6PHoMRnK9HX7WJX7tHZuhBqU+4nhRAQsGKIPMqslEK4AYP79umwa+9d6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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

