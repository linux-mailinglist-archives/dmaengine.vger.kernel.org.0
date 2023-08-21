Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0810B782E2F
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjHUQSn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbjHUQSn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:18:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49C133;
        Mon, 21 Aug 2023 09:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVX9j5hrxgUmPMHHj83UeWtEh9c+Ey0BDMBbh3hFrWLT8DM+bXr2e5PBbM9AYClyOFivx9Yr1cXEZ2tsE3dwTca/3qqUgLzlfjyrVFCTSYAFm/TkQZl1nO/UezpJOv9E/85MulJkj2X5xlT1izq1frrd0pvS+U03DjAT7Rm5YFRg4epSO23gLlq9LsnFGJGT8ap2+VJbPIvBPtj5I8h0ReLyKfjTxfjQr0Cd3AficNI59Cp9kabCNq6hJlaeGGYyR9Posc0G/efWpmTdcDDkFDbX09bt79i79p5QA0V7Vo1X8X85h5V03NuXJa4rKAu6gAcmU6T6l2Twixbl7bBgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AbFjUOBRpuNT7KWziW4nffTinTc+/kZIkHtyjsJwsA=;
 b=G96NdTtxD2nmRX7+zZUnI9WCfYr1bRyyyDfMzxLBsdr8gtKIW6aBzVP+DX7S1T8jpQLfZLn7w0I+5Cr1I9IH7X8nRg0stRUVn1yBs30LeDtwnN93PFjd/Hxu9d3UrPH1HYSXwysusyPVzHST8/vTDWPEi2b8Q6ZzmXvn/hYaTY0dGRTy/ODwcPqIKjqYvarl5kwl3dJCj3sAQMsqOL9vFGUEjS/E3UUKEF8cdv/FIB5Ak1Z7AIu4lmFScHMor9Jzs1jG+P0ovXatupJFo8gVdob0ze9Y4yViO2qdzkP74p9UCh1zbqDHGWwCFWjegMWICqCGPf4eT5XQXDoWggnIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AbFjUOBRpuNT7KWziW4nffTinTc+/kZIkHtyjsJwsA=;
 b=BlGzpcregwy7h7VKawF20B+ucDT12BnORQIF8WocD+m7HkqKyD7vnYg50kH+GZP+4aEJbyStLTmkdVqCYkCLLp40c7R9iQfoe9J42VmjWVZjHYxad1PY68dA3JUBHljH6fBQ7E1dxMb6RWrx6XTZTsG1ujR4yTY5mcFrBRyO8cQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:17:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:17:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Mon, 21 Aug 2023 12:16:13 -0400
Message-Id: <20230821161617.2142561-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161617.2142561-1-Frank.Li@nxp.com>
References: <20230821161617.2142561-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: 388e3887-98e4-469c-ebbf-08dba2620c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imdoOPfkOQvXFD4gsbRc8V6dXgULnYREu7hRHObTuXvXnMp+oCvmdWkSroTzpbeXdUa3FPuyps0Y9AW3SF2wp1eoRUSdEWEkVq4DQDASvnRS/0bAq4rDHVTVu9t3dGPmpJr2vTNHiW10UMrHAHdNNiwCCF8s6Vy98dmzc18oDs9G6g8vvx/0ASxCR0GvpOAwWPLGKetTO1qcTd2ILqnw6QBhs718VAsxjfAA0BUZwXZnq5M9+Mol1w4UCk2T6A28PWsiVFvJdY+YRCiSTB0o/AIiB9SuD9r05KTOa7mPS6vn+56+OKMyz46z5+2mUCHNHQbya63/LH5Sl3efXH7TssVgJQM7bXnnzev/QnSi2Lv9mHY4Fq9wtMb0ScFxieLHLp1g4m3a5CdFtArvza0Wmu14uzKNXP0y9b7bQlFcU69I8SmMKAQILM0QsqIx4PrXeEt0G4vN5WIdvyKzSG2GtdbHwDSqogLhOPVZ7gdPBmW+WqxZ+Br5TGfcA/RmhGUuCRZCsuy5p9soGuAjJ/lHkx4aItPj/cod5hJBA3Uua7+2XbUfJvsqOCh0oBj3sG1qDw2HSVPNijS2QMNzeMYj6jVSkbW441nMAjobLAXtRXow4uchR9akUUykO3CG8Tky
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BR3aY514RiNjaaGH/Zhxl1yDZXrxrijvTcxrMIQAvSmYDYH93MLQpvtzJM5f?=
 =?us-ascii?Q?WTY2d1GRTf4jmjkdfFlKYLUEndKSzCdgmBjFZRkGqz+C1U8A1pYfhjurQrVW?=
 =?us-ascii?Q?3Esex0CAdVkCxn4m8udd0CabgfLp/DqIqYdZcVVFWOB2WrWOhKsE+66aefqw?=
 =?us-ascii?Q?XMm1hSo3T82sxgqQwYpxFG106H/IL7wMubA5K/na/qt7Dnr+ZQXKr8GZtt7a?=
 =?us-ascii?Q?0EyOVXsFkndMQ8U/+lqyUtOUfHf+iyRE5ZQutpYkGEUBdzSwRFUGgz6VoDBa?=
 =?us-ascii?Q?rwnMbYc8xaCp9Qk+1Ykg7ZyuJ8wDQT7WgFuJbWb5OEylgUGFJaenFIn8npys?=
 =?us-ascii?Q?Enw/DV9wgwRwJMkmWBPIOw++t+xoS71iDiQHcyWmHiC+maSBMu0kx6p4puuE?=
 =?us-ascii?Q?ofKRNQU/ca4jjoKPPISOJYgdzHNKUIfdSEkyLnd8/Aehe0piso5fgOhMzSTE?=
 =?us-ascii?Q?934MIh+1opVY6d1Dlbe7FculSyRTFwYBRQaULvIyFZ3aoCf5nN5vWkuPu7rm?=
 =?us-ascii?Q?ltrYe6yH32+v7LCXVQgs8325k2gVuylxW08nKzgUTfpSlwf4hoNoLwOVJjAu?=
 =?us-ascii?Q?9629iDSjoW37eCIVbmhTTuLvsQGqvZzkVq/5gV6A244OJQieK/pLmRhTaBIw?=
 =?us-ascii?Q?H2LWTd+GiAyvFTIxcB7LB4R2O/D2haakBV+LJghCc9CZPZXJgzwGW0RDq8Y8?=
 =?us-ascii?Q?W54eKtnwgnptnTYOAQNE8c3Ng2d2M/N+luKCMh+gV59M/LfxU0cQ4B7NzsDa?=
 =?us-ascii?Q?v0re4FOlnXQNKk1+6wp0VETauovGayocMBa91ZkZ/JNlo6Y5/b0Tp3LsvFlX?=
 =?us-ascii?Q?gAEktPjm+Ss4nd9CLhk/RIPZbeJxZeVvC5HZT16zlCn/uWNAJ11XgSWaZP2a?=
 =?us-ascii?Q?3YAiwtbj5/ZC9aDJMIWuwxD063Ho6ptRD5VZ6l7Yz2J0emyHT5gIaCfhoQLb?=
 =?us-ascii?Q?2zidO4hJB6V2Z+5kELvljYc+MOjknCyCxjoocPhA/U0Pmw5E3adwd9NpHI9J?=
 =?us-ascii?Q?IzxQYnsKf1TxHMwAgVLBQ92Qf/9DuDrhUh7JS1CBljBB1LynoHbB1Xq6EoBM?=
 =?us-ascii?Q?q18i6QA1EtijfYh3K3ye/tEaR7toCdDZYhwo4ckfQZ+XgHmgUqowfcsz8nyH?=
 =?us-ascii?Q?dzFsi9WJF9QcwK0uunFwbNFjVZeQsnLD2Bc61FiZj3ZKBbPxWrq3KZUo8GPg?=
 =?us-ascii?Q?1ulncbRswZNRWNb48AypN/ZUQRnmvD8D0IV01kNWJxKDtnvOXq8YWulwiVwL?=
 =?us-ascii?Q?hWlE3Bts4gOSbTZfr4Fijy5MITRjIdhTNtCqs6A4qOti04S57QK5Ldlj4oBM?=
 =?us-ascii?Q?7xdxrB71BSogTHmarICYHJpJbO4MqkspEAR27ThZuNv5U7IoReKdV6rDEKms?=
 =?us-ascii?Q?1Ly48EqmbdEvgbN5Xw8VD3NymQUavnfGRiuFDNakGosPD8Wd/kAsO+nsJU64?=
 =?us-ascii?Q?XIkwKu9D74lDrnD9nHZJKqxmHVBZjaI0akOKuZUlc9ezGE7oR3FmPxz7sQWK?=
 =?us-ascii?Q?NcV5lgU98k+8iLP2WKfYfwzuzx4jk/TgWAbspH7+gqEwsuzqR/yE6UC1s5CG?=
 =?us-ascii?Q?tKkW39vK6vnbGRQZuhNsdwnugGZG3ybJv02jlvMX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388e3887-98e4-469c-ebbf-08dba2620c38
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:17:00.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsBM9W2axCVtz2vveuZYVXmc5TpraJsNsBnSq6mQc7rk95RnE7xHf5oN8sjm6vgfWUXLiHbttrCtUoHJdzhjvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 7dfbdc89051a..111cfa2c4572 100644
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
@@ -321,7 +325,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
-	edma_writel(fsl_edma, ~0, regs->intl);
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
-- 
2.34.1

