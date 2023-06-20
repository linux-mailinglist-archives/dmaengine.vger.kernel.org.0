Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07F07375DD
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjFTUOe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjFTUO0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:14:26 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5FF1BF4;
        Tue, 20 Jun 2023 13:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7QWUHvvhOTeCjJe/BqHAYUDcfSd6PuuolK4t/ESBTnHDVpsR0bQoPwceY6EUpzuc1Xq0zaRLUMKFYrKe44op1DRaUZL1OBGJ8ZVWE5bN7QWPn5cDP1qFIp1vXlhdP9672b3Y055/7AZ1cM9xS1UVIEMZQWYOvlx6Dowk0EEtArxdmFpvcuS+PyMaR13hK1dwju+SJ8Y8H0bwuFcpWWVOmCBHNTkgz24sxFxCykSujjE6rpwGg68753Wy8MCToPCuEkqCO/WQpqlC0wjODRgKL4fpIJ+U6qYJ1OcXactG17PgWfToX5iTD4lQkLUN2RPvJj4sFSEWS9bsC+diP1vNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=gFefSbbR/WPmJIyHaW0hGE/Og40aPpTGaKlkgMXXQSK8lPzBCC04B6fcdFl3sSqjPjwdeYXH6YpbpMrT7yR9xBDS1EEBJ2yWbTedJvPXKF2j7/x2x2b+8298rsBN50MnM6Ad5bfOyIyORPRT/B0LSNQAJxp+OU2CGEADzLSBUdhbqnhhmV/NcRv+PLc0S8KYLB8Cp69U+WnvMObR91fAs1YNp17JoAkAJYrM3mQ3nL3vsDYNcse34AdUvTa0HRkSoaOAepnIz2t6V49LSY74Sn6hA8q8AObByjW64LKt0jdYRmfzLU3j1j14Xte7O/+vDcdDxH0biIhmixDFWceoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=j7+4aH11eCFyVij5R1SKuN6A1q2kACxtTHX5JKxkcKLPUldlkdeEKvM3lFNU4QPj5GGd3TKhsfizc695+jp5g5Ya9hjjOkRMYyLXeA1LYNQKD8IogJ6ZNiGU6jmD7EA2/4YSdkITLfm5FlNvO0i/yknpWgLtRKfxCEtFB09wpmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:13:02 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:13:02 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 09/13] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Tue, 20 Jun 2023 16:12:17 -0400
Message-Id: <20230620201221.2580428-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 10921907-3db5-436d-34b5-08db71cabffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5CS4KihdSdZeBKZQsd+bANubMvfPrfqPa58Dftilcfiypwx7wl6MlLDi7O5JR1AKSwPwgtRXakChqz3t7QrQ4nz6u6BcZ9LY7UUS39ZEEjvBp6jS3TSXxtsly+uiANOwzC7G3NEHlsa/feKIZmGjJ7APiM8bnQYu6AFCPag8Nzs9ovGGcaQMFOkLjwc8hJQ92kMXHe6CGA4SDhcruIy/tETizIrNSbMgaQmBBpAsFU66nmuf+b5i6FVYnhPKJs8GdrANrBG7jIdIFvsj/drKioJd+73lRHKZC1DLAPQyjgLGcqrbHc/vzxj3uVfz6Bnrupsf8MEHlX0aTf357dC/eCOos1EsrRpom29zQQCcCNy7y0AVWxrM6xeg88xrQI+2vQ9fk/AkUupxvAsHIVATqXq3ratqCZ0i3ZG3nk4HnA9QbN7s1os5Od/oyCz7/v8wKrzLQ2FUPF2DKQbRbV4Jgu6fe1bkZXHD0k6SUwJQYFRYokECsxnIZvag7FjDABgvfhNIbqspuA8gb828j4q+0b0ZC9+Z1wQBIAHb+ynMFAQDNXh1y8+QxfkCa182qA/Wvyx0S+V/0kIBmCZg7Jj3LXRArU0Kbd9jrwSmAtMbSr4aXKDGznTSC2t/TXRby9EfPrxjRGfb/xnb2JXqwOwzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLg+OuLYhjUU8RtTveseBeuMwfhcZt228ZUlFhiYRlPKCb4pvTGqh/gG5vp2?=
 =?us-ascii?Q?NuyxlrIK04XFp/IvHYXrHXdEaZn26HzLptibJIWNflFitbwXOwrl3ofHKD+9?=
 =?us-ascii?Q?MMk/GIZltqyFIvNrFxhmAZfRe1FCCHB7I/LjrtEhatLudvOSHC9GgnnyPHsK?=
 =?us-ascii?Q?tujTJ76Mh5UJZePnuX+uB2yJT8hsf0E8XcpMYAsF5ZLTAMqCpwWAUHHEMLfG?=
 =?us-ascii?Q?D/AZLlYHUByJ7zHrs4xItpQPyiI3NV8Ow7owYqVGBTJLOP9NFxzDQjyxoqa7?=
 =?us-ascii?Q?Tmt4c5eM+gTugoUI0RTiEMxWM7ffQ1sRkfbR/RTVP+k2AEDon7wqOcpBr/LV?=
 =?us-ascii?Q?BtZYfpmW3bb1zE3GgR64+tYyj4g73WAWYFf0vXqj7n4jzHygBI2ZqV5RCENt?=
 =?us-ascii?Q?x/R8LM/0PGwC5zwC28Kdhe3gNuV02BMJ9602AcWx3P524rcuBTtL84vMUOxH?=
 =?us-ascii?Q?/1+JTEFwuwlp24lYzbaj56U3ksako8q9yQC4t6etbAwozAlNp2mbk/FRmgaT?=
 =?us-ascii?Q?rGPpiqC2M+N+aXNxbGJtDKC4XQIphWWMPCAoanZGjEGaUb6S4Zn9ShtMmCmt?=
 =?us-ascii?Q?PrmffU6kcGV/NUlt7MclXCTMo5nxkiqU9ugsttL41Miv/ZKvrPxzsuZtvwd6?=
 =?us-ascii?Q?QJHbCqBlpe0VRLAC5XaFkNyPPk/vfsmbK5aCWV1QdUZ2u7akVfPy4xSNbE8G?=
 =?us-ascii?Q?DfUBCJ8oyyhQOy7n2vAsY81u2iSPCShnPzZcCB4SUZqMPz9jE+dIr5QS0myu?=
 =?us-ascii?Q?HxZrZFALUWkYinLOkoL8Rsexw+aa+HTXrnrFq8NsrMrCYlB1ORUz53WcP8q/?=
 =?us-ascii?Q?6R7YXYru6spalDX4eeTInWMNX08P40fcP08S3ALaF3EzQiu+8s2RdMQipHIE?=
 =?us-ascii?Q?BdpB2MNPY66bJGdW+2lFNC8t8g2/CT1WskeQA+1b5w9PZgcMHkol+OouFSaC?=
 =?us-ascii?Q?q1G5QumTzemVygCPG9sWbr4kpolDxmN1tGIZ2QbzsQpQGzzCRZdTBYtZmuB1?=
 =?us-ascii?Q?02AUvMFith1xPVIWavIC4GM50+cD9VNBRKhSeMAugG9TLYCoJ/DwhVIsLJrK?=
 =?us-ascii?Q?vCLFk5VxTAY/KwR9gCJ041QadxUat3ZKaIsWHG7fm8ziXsJIhvlPBTUi9vTN?=
 =?us-ascii?Q?kH0CGsfXvm2vFxrk26EghpvBj+42FoggdRo74wIdqUU+UUjYkyAvJ8ejKXhi?=
 =?us-ascii?Q?hyqUNlD0Rcs2M2LH/KjArRrOzGUz/hir2KBDDoc1N/lVp17G9W33f748tcTo?=
 =?us-ascii?Q?sbNr5VhgY2iVuABdyiuT2Fg7ow2CyxcviPNKorzZq46XPc1hnsppoJqmXVfd?=
 =?us-ascii?Q?qDXyzM1bgxHKuQGSBGsjc9TMuF+oF76omE4hJ4rrcqlp4YzGZhTCD1Q2h7XI?=
 =?us-ascii?Q?BsQ9gxiFfUKs7SiwmVyCFaaHxlGL97GRz1MOZxvZeGOQ90uq+5/0JzYPyFv8?=
 =?us-ascii?Q?T5aHzbv+VwDGTNXzielDmrvI/wQLUhJRlFfE6KMNy51FZ5F1WwRBnJraH+dB?=
 =?us-ascii?Q?BqPDyjNVm3t/sfe2Jk1gycsY5aWOYEBfkFGSnXzIwNOMvrCsocubGHdRH2jK?=
 =?us-ascii?Q?VSMWpI+Fgl1GJDqUinPbfpaAuNNEXyo9bl9ju0DV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10921907-3db5-436d-34b5-08db71cabffc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:13:02.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsyjJus/7DXwJaUCq6GXbVrDHZf9Wwyj0RcrAEELGGqqIMvbYxVF4meYiUXwYFpM6SRit0jihMF10aJEusuZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This accommodates differences in the register layout of EDMA v3 by moving
the clearing of register interrupts into the platform-specific set_irq
function. This should ensure better compatibility with EDMA v3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 503e5ad5a8dd..e67aec3f76b5 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -113,6 +113,8 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 {
 	int ret;
 
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+
 	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
 	if (fsl_edma->txirq < 0)
 		return fsl_edma->txirq;
@@ -154,6 +156,8 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	int i, ret, irq;
 	int count;
 
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+
 	count = platform_irq_count(pdev);
 	dev_dbg(&pdev->dev, "%s Found %d interrupts\r\n", __func__, count);
 	if (count <= 2) {
@@ -311,7 +315,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
-	edma_writel(fsl_edma, ~0, regs->intl);
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
-- 
2.34.1

