Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22733715052
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjE2UHp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjE2UHo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:07:44 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AD1138;
        Mon, 29 May 2023 13:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG6gg8W/HU1no2ZLESBtMtRxQDWqbcD3GJ3RzlOtVIzKhNm5MI3jcgvmdnEXqcpNqVrc485URydfDo2tq6Srf3d20u6mmeSanw9K/GfcKGl9XyiKJ/cJNbdNNJ7kM+2sKhMdjpwJwXsiv5B0byAJTzIr68XUNjtOA3WQNC6+k2TyvcOqeQbP1csmSsbcqJ4DkvNPjwYb6A0GKkj3QEkUDUuwTKT2871rnRM3hSopbBzw+H7qr2PcmzxUQv48yWEYPb9ZMKd1Me3xOJvZwdduAYyxsgdHVqveMXDMrLZFSYx3i60x8ENQKgGQ/4mMX0CKFEMy1BxILS1WiKYtYBRpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX5uQiZbWlSQBsI7bxXuEwcbNQRhGGX00lAlSQPYFEQ=;
 b=Tx7ZMLfilLFpdSE0VInqAD9Ty8IVSnSYaqnnliLqeObdX+MQFSNU3R44Oj7Mt8AoLamHxelJywACzzNTAvFRjYFzyByfpG8u7TvkZ3ftdhahdFqZYWbjgvm3aNmFVMRoSZOmeqh66x23MYmimQeKzf67j2qISWxe9g51843VnXPRyuZrc7jvCu/Y5+ZTeslsAQh8sJXRMdXADewh2NUbRSQMEPASKL5Es64o4ucXDmsfpArXZxJa8TKVFhpRTtvu8SNFZr6b44aFQ2I73wnDlZjxSHtwL1HrpiabvVKpy+oJRIjZbiZpZBjQOUaSBNzZJ8Y8vhy4J8SdyT0nfxKTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX5uQiZbWlSQBsI7bxXuEwcbNQRhGGX00lAlSQPYFEQ=;
 b=oNwp+4s+d07ypORepAGrmD393Fk6abFPIto+eoYscPXTz2NIFSrHsvBLcTyCsMZI+qaUv2fOLytofGehd1+N2n1hUO2nis0w/etucwk3N9DHNe0mBB7CgONOoSB/RtE3SWsFpTqVcoapPadI06N7rHzLZ8VWosxcachQmApLRZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Mon, 29 May 2023 16:04:49 -0400
Message-Id: <20230529200453.1423796-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529200453.1423796-1-Frank.Li@nxp.com>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 82effa4b-9143-4981-ed6b-08db608010da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTRpEqLxnkviaI1M+Ygvm26qCfX5rJxlhdfq2U9/9T0u/4RrRI3f69DZ5BCIfN0i1R2uEwHPJQSaQK4I8bbnT6d3LH39lNw87BOglTfj3k+ipLOSwSVL8v3mVcISWyc9prUPTL4hOQ1jMhlDWRiH0ZHMdiA3NF0Nzc3Km6JE8bezMP4rQtOlzDJuiGdHGs4eupQuoxehbCaTrrytu6W8ZIjkbzwUv+ZYLoGzWtelk3DOf3jYUpDm+OTWejMyt1Ys5O4TNNpYMSBCenSiszXSeaaU+gvCRwem1LjJe7MhB2hqpV8rfTDPR52LfnbS5WLtv74Ebud7foAgdzdqjlo1uc5qm2fGIzcBenUWol/a6hIasYJTRl9a2tbDVJm5mnXMcxjoe8QroZtD3yd/Ttf7i7mKxOc+iw/ERPTAgdANmW/343+60KhObENvrekPt+0Q8cCXCO/zsBuaA7FtgLFf8szEdKyMUtis/Kyx02zOQyYeR/7o1UJJZRMkdNn+TSj2lWpneBfWA/rGXSXjVik04Ucn7gLyswZs8fhtQtytkhgZFEdwGUsA8FJt4lHCjCoo895iNYeZru0DW4jCIqFWU2OcRADMHK5c41EqvXVOMn1eyG5DWqNM4XDAnowKuJYz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eRg6DO+I7+GtmHqX9vc6CcddX1i7qp9ZvEDCSCJuMYXdPd5XgzpZ/Tj/yRWS?=
 =?us-ascii?Q?uOU1sOPmi/fDWm5nC8WpIRgSXy4wLp0OWrkk7blULNdClmtUm7qcijA+q3BG?=
 =?us-ascii?Q?P6/CkGtFIlbe80tzViKPGHMct6cqYbdKclMFvvFipRFySmHhQ9cu+A74xVY8?=
 =?us-ascii?Q?k+/JaoCaR1Ifvwol6xYznu+WMpYl6lZFf234zvFcGwCWTkDXpLZGxnkK/988?=
 =?us-ascii?Q?DlWxSkBJOqBrkf9tv13m1mxF2roY7R7tMhN1jhrVtOFmTMgiNCM5R4F/mKtb?=
 =?us-ascii?Q?ntf0xWTGF6EgxrL8e3NshVV19vau7u3ZPbdp3VVBaV+GnpC6p2l3QqmwYkz3?=
 =?us-ascii?Q?5mhO7BfJMiyXB1RfvS4UCC+7ONFTreF7b/4wP8YLSxK2gUKTCktLHjhSjdDj?=
 =?us-ascii?Q?yYNgoqBaZjYMj2DR1v0mARJQ9E03MpWnrLV+fphyITtaopEwfv6XbtgwKSR2?=
 =?us-ascii?Q?PpjGD+qCksrSH8F5NEnXM5jBLCITysrbruz/ieCQswseLHCJaxKQ3+7HCwyK?=
 =?us-ascii?Q?CYtVXyByowzYwAgdV5dtuf9wn5FNUMaALcgQP+J4yOhsdJgIWAPVeA/e5zri?=
 =?us-ascii?Q?r659PB510l0JDpF9qeepGeg9uwA7YNH9T9x71cQTpDRBJ8cncDY2hMACGaXG?=
 =?us-ascii?Q?Bu7aLJJlZc7z89OqsPqG/hlAFBjiC3dxUwjJk18wh2MlQr3upSeGplu97WNU?=
 =?us-ascii?Q?mpLGy+RYve/CXtRDDvkYxoEJv3qVy79OG4kKA6XK02ISFklwUD+4OhbC2a7W?=
 =?us-ascii?Q?t0Fz6PZ8qme9srJGmvzXYXi8Cr3uBSEYJ5su1ZPjw39P4f6tcoQA+ktbYKVZ?=
 =?us-ascii?Q?bjxY0fB0yhrxVJ8UrjP/8lGwvSpiM+PhFSb21Sni/aCsMk63ILCBDfGbCiuV?=
 =?us-ascii?Q?rkTzs6/ITFDDxgUYW/kNg3RtxEziV3K7xKfGu1yhpW6A/yYL544wFbkAN990?=
 =?us-ascii?Q?keoTSTjFG+vc5JrD0MJ+AOufwMZnovzVWngFhcHlY6zNa4mVoNfN6g6ZGeN9?=
 =?us-ascii?Q?ZgRVNR4a4WQhbq3vWEfC2ZcUud7Ygzk9XzXs5xw35HmgxVQllb76zG1MH5Zw?=
 =?us-ascii?Q?/HCeDkn31BLWFNP/owLTcoiVitfDOHKV1//0hYaGjbPMGvS7VVvf0/9zig+W?=
 =?us-ascii?Q?wCiNEAUEpjXvDC0dVjMIbwJZmYRC2KHWi2FGw9xTnYL25UKlQHqMFEskU62V?=
 =?us-ascii?Q?I6wUKiHYRpQoIBRSo6B+RjzyY2DQ9snCDhrWd7miMy6uAWxEUqitRL9MbKug?=
 =?us-ascii?Q?11QXACZjNF2QKd2fOnkgQey2Yv15jDAMNk1LalfZJC0w+xaE4pT87BSkM3Jg?=
 =?us-ascii?Q?fxRdOVXYdIywm2ldQWc4mO3dgiGQ25eFFQDnSOT3SHRr4ploizrsOUfhTGWr?=
 =?us-ascii?Q?QkIbsnmELUFc8Qwwhd84lczWLFq3lutq1WnVWv4cW7pFb0O4jF2+3sI54Hxq?=
 =?us-ascii?Q?GjkdZu4D7VSgMkBYkGqeyeCrqs5+418dg4j+PAuKeD+MFqJ205ImBeHLCs2I?=
 =?us-ascii?Q?juxNddlm1EAksluXFAW7oYTl9lF2zfrW24oooJ1MD1Ri5KXBlMhAhv3r0Gwq?=
 =?us-ascii?Q?kCuYrvNt0gaIzdXEESMEoNq/zzSSNuu9oZzahCgs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82effa4b-9143-4981-ed6b-08db608010da
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:36.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FQQ498di3kYlnI0cqLh1fR9FFsRQACdu1kdJ/uNJ4Ok05fTOhIO/pPLllz/IXFlmYAF/ynHIX9Qvqokz9W3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

