Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32D7375D6
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjFTUPG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjFTUO2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:14:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FB1729;
        Tue, 20 Jun 2023 13:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMsqmxwTDhHRpMT99HcvPOZot5mM0ccEP3Kz3uXb7DiE0YIr5Yup77DlGHJmSswjvzv4F31Qb6EsePLB6FFzI6nHaPCawAe9+PFGcYv2Y5XgD9qYXVwqWS1PS0kMWu2k7+I3AWcOK2WeZ+wYNrIoN+xmG73tDs4E/uoSxJUC2vE+ADGK/+3BOZT5qnQItYAeCQV+IMED2qrkMmq0EmSJtwdUw3eExz4MZo9rscitAiGGHtkYWJGoGlDR0xnSj86T/QsLcaWUhxe+2utbMqGtJWgxAkfoUkI/jHnqgkIcUGTCYRaN7fbQbuDtyEqxA1zLOn7r4KfhOk54hxJK18qy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=l3WCknxC0PbTEYAgmKkPv9Th1/Jayq/kJb6hnZDJ2ALTat0Z1S3WgHNQ4tv6v9JGYl9oMpgYW0XeXDm1kDIuLspYrP1tY10pRprShr/PngAvfA7je9aFCR1ZDo1Q8SspK8DyIM55cm1koKRgSHtipVaLJyTty8f+yb/s0TgT58By+9vEKRG0NhmarApFli7xKa9dZbwr8m/GK9hS9ivSGDxUwAn0DSCcyrbx8j/3XkSkPZKeuE/PDJrs7Zs9MUDtV07vlwA9DORac2K4behqy6IB138bD0Yhb3AWeVt5dswCOLziRJvchn8muQPXZIkhJ/4tV7mo+Uq7NxYrvwCvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=GorKs4p0HEr5F1551M+NiZYzQIU1FHGDJ64DTzF6WOZ4vmfmsgv4xDey29VesRetME7eHiCjoT5Q+RC0pYc1dHshL7BVHFuiWgxIO0CWqcUtpzB05JGg6COroUk+jwCMhG5MbaYq7vogCIdmSqi03U+GCdGzVbv3d4eDjvHcQgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:13:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:13:05 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 10/13] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Tue, 20 Jun 2023 16:12:18 -0400
Message-Id: <20230620201221.2580428-11-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96a15e49-af97-40f7-a197-08db71cac1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFv6TI4l8g8R5yt0bEAzlKf+4hwMCdL1t6Qc6kLXnCuKauQpzBSDLWOt3N1nxNFchOqUBtq0utP1i2J2jQIOWxoPx6yK7fJ4JiY+va90uHTN3EJJ4fW92iQczg29y5kJS09u+i+GT4kum9+QE/Rh9N+nyjh3J+ondGiys3UvCHJtT3gvRuyYL+d/ZJ7Q4cg+OeDoOtISbJ45S8hWn+BE1qzEP+Ra/QCEdzjqHENRQMRNT6dIdM0XRc6Ztb00TfJP/lSWaFr3Qgh3KwMEfg2kJgOocL3GVgqCLSH5C0dlresUHEGlTvHkpIKBZHJhoz4paRzMbJwp2QaKRBechYM/VP0bJYBPbqxGkb6RtajtoLzqsPdhs8CYIzXdldSJTR0laMmnTzBedmXXO711/ugIAieiYeRI4nv6i9isOL0r8dx5+9YZKc50ojqiWDkzWe5MnnsVJHkCAqpyJMdqHR1X5RGJz6K6sjrPV0jzJLRME1h1j2tEeCkB5fS2fsLDUu1wT3pgkPhttHb3HqhYe9sb4XIc5dYqeDQaOCrpNArt5MwpkB6xMr0ux6mALLokm6pGlPc+5PD6Bje+hMHOS1wTblRdM8A8uD+sKmDSFNDtG+dGFF6m6E0rFogKaaIuNoWkZtdW6VLqqsMQwN42H+R1qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q78+3ZOMP9yXw3KEMJNTGBWtDxRe+APCgGHNt+4GvPGzTx4oLgxqbcZauq9U?=
 =?us-ascii?Q?l8qQ16LOYAvHJkQcV8Cz8yOPOfus18EiLxS//hoIozU+CWELoVWI8FNoNhu+?=
 =?us-ascii?Q?o8qfPN4X2HxTP1zsdX6QAKNJUZcvrhbR8ctmg/gasDNEmr3dD8J1WmXS6IZ+?=
 =?us-ascii?Q?qURg+8NFaqyQkb88GS8aDzgL3g9VBj4aJKR+13AHZ0KbkuYLlxM0OiFABwSF?=
 =?us-ascii?Q?dB+sAhXo8E5m+DP77E+5hXyEkxsJiKhIQWAPw8EmDkXwPxGVFOjyivIWkQ4J?=
 =?us-ascii?Q?X5tWWv9Tsnu6tAXOf8ylLIeY15RRLhVNVX2jjregoz0wywFF3SOlyhB5CDtY?=
 =?us-ascii?Q?6GXfpqs+GC1qJYBUpNsB/qIu6fW7Boe8uVa8/aXPdYFhyglGIOXd2tq9dC0z?=
 =?us-ascii?Q?YcvWMhj7eP5jGFpaMz3k7ZFuKGG5DyVFY5Wmjd1NYN8bhsQrQJQViANeQXhV?=
 =?us-ascii?Q?3YYZMXleuCjB9XJegAlf2LXrL969Hs9X2ztzFKza3pvloQZUybA/n1m4TlT0?=
 =?us-ascii?Q?JdD0NrSZvVDmCznY1JGwfTX6YpmK0ExGiBZ9J41sq3/i+RJCSggoZuSr8SHc?=
 =?us-ascii?Q?KhQC3jnc0YxczFSjyrxyHZdLxCsw6+as1gO/KEk1aT0L3aV5UYBVvVAZHUcg?=
 =?us-ascii?Q?58msFn7eF5Jh8xkGVCuYN3u2x9UMqyqdYsjqQvy8Oa11WfzdMMZRo8iuAWuD?=
 =?us-ascii?Q?D13mIqRw7g0bIiFnhjD3yz4gHmQZYtKAcTj1LaltCRCR25MdEEReVV2/Pac+?=
 =?us-ascii?Q?YcFuvy6La5S9SOPSXHB8nQOmlT1eXJHhXSCGUjRePrppVo06DjOCOMCvbjpA?=
 =?us-ascii?Q?ZVz+m4/RBE0CZIzcYTeG578RPcVL1rP80QUwqQiQbmTPMGR5NnLKkj3qJmVk?=
 =?us-ascii?Q?AQyopMVai2/5XEb1mZh/HYepPrZ1V5q8eFDvmssl9uwfUfmXDa6rmtPfnIsO?=
 =?us-ascii?Q?5aTR7PEY1gINX2QR+3lI50XnlV9tfVbpwEIdG6M72WEC0zhILp8OlqZMHuU2?=
 =?us-ascii?Q?SEeD63hlBz8EwavYvX7An75vI9EBatbsAXHXJYmRedo1v3e179cj7nGmocPj?=
 =?us-ascii?Q?UdpkoWUxfDgjYxQLWW4f1pOTpAtH/JRnZEJvondC1o86ZgeeBtwUUSsq7kA0?=
 =?us-ascii?Q?WEftYbWCuc/bkhANf4NSq0v5HlMg0X2mPjAC8KoZLwdg++AR4JXTvpXEjbJR?=
 =?us-ascii?Q?y0lOQO0E1jd+5tv/sg8jRJk2kHU0FDnH6Q7G5uwj8NgfbOcaOJI2k57jKOG/?=
 =?us-ascii?Q?Gf3SHnq8imPTaGKNQCKjsBbZ6wA/ciTcogFO6UA/SzaJiqrQnC10WpT96/x2?=
 =?us-ascii?Q?RhprGH9Z8TTGa+/Ur/FIo0IcbLuoURFmsRSzEBoVSJtvVLEUKqcmqXbmCIPf?=
 =?us-ascii?Q?xAiPrxy0ix9D7aqQhmtbRog7MHNdeHKXOwGjW8hg6Dp7ub39phj++76HErI5?=
 =?us-ascii?Q?/MKzGqFxpwZiVXHh7uAVqsK1R7pVReQm7DrLucWLJGi33DBE4gykoWjLSvds?=
 =?us-ascii?Q?3uOMRbJk5rpbx+pzrEvyjPR96viecTr4dC8m4vSIz2dqiPUXzwvK6aXSrjUy?=
 =?us-ascii?Q?mcid4S3E+kvvD2COLCkr4ovHPwW2dLXfq1+VDrLB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a15e49-af97-40f7-a197-08db71cac1b7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:13:05.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nlHxiMlV48v8qviwV2NUtXKnzdst3Zpqh03KC+ticbS8YYd9fPVmAz/MTTfjotsp+H9JBhpGebEO1tGaNlo0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Relocated the setup of chan_name from setup_irq() to fsl_chan init. This
change anticipates its future use in various locations.

For increased safety, sprintf has been replaced with snprintf. In addition,
The size of the fsl_chan->name[] array was expanded from 16 to 32.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 2 +-
 drivers/dma/fsl-edma-main.c   | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 521b79fc3828..316df42ae5cb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -116,7 +116,7 @@ struct fsl_edma_chan {
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
-	char				chan_name[16];
+	char				chan_name[32];
 };
 
 struct fsl_edma_desc {
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index e67aec3f76b5..e2fbfaf9155d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -175,8 +175,6 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 		if (irq < 0)
 			return -ENXIO;
 
-		sprintf(fsl_edma->chans[i].chan_name, "eDMA2-CH%02d", i);
-
 		/* The last IRQ is for eDMA err */
 		if (i == count - 1)
 			ret = devm_request_irq(&pdev->dev, irq,
@@ -303,6 +301,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 
+		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
+							   dev_name(&pdev->dev), i);
+
 		fsl_chan->edma = fsl_edma;
 		fsl_chan->pm_state = RUNNING;
 		fsl_chan->slave_id = 0;
-- 
2.34.1

