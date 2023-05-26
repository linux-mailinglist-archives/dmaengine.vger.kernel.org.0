Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADBF7128A7
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbjEZOj1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243917AbjEZOjS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:39:18 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720EFE4B;
        Fri, 26 May 2023 07:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1DHbHB5zsYccOPpHXoQ+q4KCF/C8ox8Eptj/x017ZLsDHXHKikXzfYNFO3FhKQvorPUjjdbyYoSo+kncSuAFH6fOeehSpkPDm7g1TmERYlHbgSRp55DqpUppR3TdkmEGdzlchaYB57LUSl6dFOpeXP8+3VmEzpSjT/qjhL4rwaM7+iuXfPByHqaZuPGmqaMrYdpGePsejHPOtrJo8VDwz9bWrm6CBmPMKOHNwObSVPBu4xlBWKkFYS0WHMc82oAy+ZeTajY7vVrfgxt/q7nj6aA9TlHblhuczbKVig2aU85P8Zw68phHNM/vpBY3I8VUBcZV1RiDCPlgVm5uY4f5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX5uQiZbWlSQBsI7bxXuEwcbNQRhGGX00lAlSQPYFEQ=;
 b=Jp8lr92T+O8DpV82C9w76IaadhqVDfFkOSEeT5Xopf1fwckJs/hUXGOuUNtMAYRvz2HhQ1vaL9QN/WDTXI1lkDCd4uMtpuh2RS9/2UABgHlVHvGH+62wXTz1ZYVLaVQnjlgEEgGkMDt8MFjVbxbV3gqaj33Ya/iPppgc65FVWGcBt8kJN15lGATvCoPG65m270nWKOiIBeIiQ4ZWS1A4BdwyEfvoyIqdJODHoSfDxuVsHDBFRmFUYf4WfeP8gF0oaS/IPK2uOTH8fOba/Rd2RLFnyBxEIwoXVtsXIy5fMAB/lWBhYHbD/YXSG9vVuv/ShXowv1ZscrCwStyTU8qlow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX5uQiZbWlSQBsI7bxXuEwcbNQRhGGX00lAlSQPYFEQ=;
 b=HbpQArk16VdAqMgLf0cZgA1pVPwIDHegxWsdJJk0AotikbU8ymFeW1t1tTSxxjWv8OtMydYWTfv7/VEFHrk9VL1T+zVihgnQFLAk8CIViqqyHsSmQ3FCVHN8rc8cnKFg8/ea/l5D0qEfjku+1VlM50OWyiebMAx9cbVfnW/AhF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:20 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:20 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Fri, 26 May 2023 10:36:35 -0400
Message-Id: <20230526143639.1037099-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: a830ae95-ff0d-4e70-12a5-08db5df6b5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtS85zSHXiBzBV9DnP8cYCZ3hhhifvwtHcbZWCIvrRBNXVZcwNdJtBu/lXStUQLOJLbMPT4W4BRA/yEqZJiByHSkFvyy1Gu+wUjdP7dy/RHe1cL4tP4ejBGMDscsMZWjgYIRLfpcZ9cPvxPehxyocj94k1OWE+b3qZz+IB0u+w/tD2z2IWMNsOAQQUP6cLr2FV4iNVfCTYeLn5Er6GaUZQF2a56ouRru6yx6zZ7ReLmmenkBcvxQfmw57Ck9VJxGS3YhH0LGLDAE6NC6wv5tOi35CxAKrgK0bIaJKtLtVxVif9aWhu9xW86rhoGO6MeoTSh9Ox+7PPYmkPaWha1FUHUGZRyku9s3qyf4v4sV+HZhPl1sSK557158qHQsKk22/AKFGxALDLUoToKYiVcd/mknv9Oe+58f8p9oa4zVyAzcsbByw2KKCx8uEjLdv6S15E32EyjyXu19rNt1gqFPoPtLC8k/5yxHMHUWgX63O/yYxo6mZUwyUMXhv8zIHlmCKqQbzfsKBtdSjUsqYBGoX6oNTENueXaY3KVAdMMpWtEQN5Cr9BMKobyOMAYNSpvdb1Lkq7XpWJ/Y2DhXm5Hl8VytuunsGU/HORBK6ZwsyQHYQYKGTVi4M5Se9nrgMd8wkCORWNMgvdXc2qyzCdFbMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qWMzA+i/BW0ClNMAJ2DtyzPPuw4L2ddbu5sw3zXnI2aEzYOejIvYuGK6hPEg?=
 =?us-ascii?Q?s9N2aZHkqFn/OEHUuQowXDa/fHgL2aj+9B9PKE22buiMZplV9+h9Am9pjcio?=
 =?us-ascii?Q?yNuJ2g0WCZz24H2mt+6wHYxgj9FmWQsJrLEZWkXZTiii6Z/PxYuwPQVM0bGa?=
 =?us-ascii?Q?oksAhZHgVhCJq1mug7t31AuanfhM5Wiy01ZKR4c8rVhv70LBt0t+HgcAQk8R?=
 =?us-ascii?Q?XYLfjF2ar91R742vW2icJ/oE9d+Y3iu907VZqoeyyTBgoc5B8lYn3ZlRO4Nz?=
 =?us-ascii?Q?eooIDET+3Tv3C3P6G/Dkba36w2IwCwULSG5cO2aXNPWvfLqu0v5aNUH/WdtD?=
 =?us-ascii?Q?ivLnUUQGBbtk8ZwTnoYITYviMrUcff+n56qTGCjTRwl1DfbEZTO5cmMy1MVz?=
 =?us-ascii?Q?JZ7ctbvU6pNXAlvOPX8s06HhA60cXdAzl3MClIanK13bVqceOgdDKghkeeLQ?=
 =?us-ascii?Q?m9F8qSLhMu5m3Y7uQ8wwsoDSYNvjcyDDe/bxjjVSS3jTnFCmdiEwimYvXhnn?=
 =?us-ascii?Q?Zobl7X0Jgr3ySeN7fkqKhKRm5CiBOh+gGJKGiQcxq6AkZKtcI70ypKrWRRhV?=
 =?us-ascii?Q?bxAiKH6wM7zJ9s/kGTYolTCr5azl0OOaTMpDJdC7kLmLU1NfayCFGN3L2dV8?=
 =?us-ascii?Q?pZZ1irJui2ENxa4ma6lw2welUSgnzmnpa4eFuMxD6C/ruxMdQL3K8mSMeJmw?=
 =?us-ascii?Q?1oir2HgQ2p8qamLar4hczbixISxZQ6YdLAOjiorAnCP9WmCCunL1XQ6THAAK?=
 =?us-ascii?Q?xQQbnIiTmYm6T/czCSoLZM3K+IVLTFbXmv26HC3vgcuVyuIUmXu+vZyNsrlB?=
 =?us-ascii?Q?lEQbGKk3WVfpGim2Aix0tYgyUIuM7QS1cAXRUploA4V9oR7BzqJkzLaMZAmU?=
 =?us-ascii?Q?vnXmymtpHOwJrZxsyIvF4JCzreO8u+qCiHP1w2yMMdIU8afH2Ixe/BLcns9n?=
 =?us-ascii?Q?Gv1bcOOQAUEPpmA70yvg1wz2evaXahkTbmj68i9D7ZFI0lSfiWoYa6rD42CS?=
 =?us-ascii?Q?LqCWzJdG0s+wMSJiBW4kzpQK9Km51d50Ye45Eg3sdSNhqJHp53/NO6LyqpV6?=
 =?us-ascii?Q?B1cBRTktPaMZIyjRVd8BX7gSEqFTQ7bzRZN+WAnuoiQYZXLBMRyo9QWxNnQh?=
 =?us-ascii?Q?/APOiTLJTEP9MIvWhwzpmRq948iobwZWH8Q+zkrabuTm4fHcAW1U6MIJdIi2?=
 =?us-ascii?Q?iMNVY3QmxfeeN0OtZcz2IxGUokoLBIFgGrDcCWY4TU7zRcQymv2yXMHsNXk5?=
 =?us-ascii?Q?abDr9TMQ705Ai9msFqQlNx7U4K+ZLxQKlCHzPucOyqjoUZNHaHIZozQEFIpx?=
 =?us-ascii?Q?527reE4HEhG9dDEcyFlOdRQRdXdZsZJPVXnaz6+nAV91O7/8cy8kQrm+P413?=
 =?us-ascii?Q?4xighwZebhzzYNjsdhATZi4fCsFrkX9aji8cqhKDgK/P1QzoWgUSIFzK4Xlh?=
 =?us-ascii?Q?8ckkMk9sstUfu6Nmx8gL1RksYJycIy3ZIcaZFrasuFQD02qiFwm9eDc0/j3t?=
 =?us-ascii?Q?pGZCwKOsRZoJ9yv7yQNUD36QzkcYytFgXH3La/KZk94UYTc7yLRv7oiSGj+5?=
 =?us-ascii?Q?7ck3LkeCw2fHYjKdue94CZby69Qm2IbzeIdcm81A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a830ae95-ff0d-4e70-12a5-08db5df6b5e0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:20.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39EBQJgNIiBcZjf4BZE7ohpWPwCQ44VmIRV8O3FKInPa1afTdflDoz6/C5zW8HrH8+g4DtShtQlNIxRnF9d3yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
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
index 6126717fc87e..cd734779f2eb 100644
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
@@ -313,7 +317,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
-	edma_writel(fsl_edma, ~0, regs->intl);
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
-- 
2.34.1

