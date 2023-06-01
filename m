Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869F071A0A5
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjFAOnM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjFAOnK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:43:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31089188;
        Thu,  1 Jun 2023 07:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV6//Rab8ZhASDImpl43pTgj9cPXVy8uiUzRoh+t//l8s5YZzifrQOGz2ngoQjnW2M9+KsuCO29wiGOL1iDcIM/60zEfbK9RuL6aicQI/yX+KHOMxDDNNlnBa7YMLjLYn30K6I8qo/wzfVGxGfwl2rH+ArdRDKs8dCFZLykpCPRipS2M5ao64GeyO7ukVbgIxmfG3O+sDhmPtX7QsZBdo+RWDAy/iADLSs3RSqWdRfXvh/SCrhv4LTi1Q5PMFUqMlkUDeOvGsjU2seZy42IBm8wE8sFKU4sk/rsb8q3PQwennChSIcYosqzpk/EPtBDErJ2tkaXl3NvponHz2n5amA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wJsdg/NqRQlFvlWBJlH67UCBQiAEPaUs7/XAYIYc78=;
 b=C2P58tExdAvpzFEFzLtd/JoRYQ6kAgVyXIh0EcXQSw7DTGlRgaT5YprlZDFyStV5NCijy5d7/XNDT5JICE2/yjJADXt/lGnJN7JqCJv8gf71FO3BHjKvXPedTxh4MLik87VeRADW/AqrbqWckgKPMDrZFpAt7pQFl4XVGpvFALTWFFIk3WOzPUzmcmnUH+y3S1sQkLSwebc63TWi/NzEqW1Whwu+0yQ9iSaK23fWqFU9ici7p/bLY5jJUIc3Cuv/ej2ZuytVaazaXap9OmkZsd02lf4ZhsUH0xIHAsM8r9MHAMGwSYJRQ7xS4HY3fGLxJqvpqLxsVwWcipdNuIsHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wJsdg/NqRQlFvlWBJlH67UCBQiAEPaUs7/XAYIYc78=;
 b=TWSoT8L0s+zx/o9AR87rbRWJ/hRtaOd9MZLqOfXjddRZiQtD+8S1hEse1spV2qxSNPNMVGx+r6MF42qzIrro0cV0Hg9r+gXT9rAjSngu361kY4CrPvbdR+vosuxdb+vEtpYjYIvt3SHxz0V48YnufmnZ9PZiz26tFfGclD4jBUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Thu,  1 Jun 2023 10:41:04 -0400
Message-Id: <20230601144107.1636833-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 474e7cb0-dff7-42a5-9101-08db62ae56a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzf4TSuheQK1Q/FKtpULXavaz1IIIaIJkFi6hmPJ/lsVQehG7ZduNS3F8dFMkl4tnnYBg5U4gWQbG+kdsDvZK4CKnMpQbLy1BUiOhCeKDiiu0k6WE29flFUkiBiGDmhOyIt8PJBEfVDCbaI34bGJpcbJ+9hNHL/sI9M7L6V07QpEQkGuUPvA+QVRLd8493UOjTgxJdFc5v6ZnkW5DPWHH1gxr/dQ2umNxlJ54KWwW2ztyow9fz2CLeNQh+7IC+8I7kDXURRj8Xk3Ux8KoCw7IOpETfn/DmVrVNue4ZqkO1mxJG+UvqU4tFQrVGJS8nERIvgaXvql5yztKAQILD3O9Ac96o6PyC7rlDWK/5v6StdZf+Yn1gjLBzRe/zoTR+XO84HxmRVG8TynKd+ECDQq1rWgmAoC4JHmnfkyyeHLn1S2ZSOlCITCzEO+Jz2Zic1yIw3Y+yJ+iYhjyLVa89vIkcAa1mCGCDOBUTbQHZFb+7wY0ZnipDrYAPLOiyhqrnLc5XW97gs9Q6ec4qVp1sPiuesrieVcelinwzMTmk/xkP/LM82PXuBummiduLXOAVBpPwR6AbwEv31vfBpgHWrRGH/jyXbFUzVnYe/gzAoA7maM+OPme+WACfJ9fPEkGKE/mO9uepLMQV4Sf/nvwx5ZTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1wbOBCGWe+x7GGM1fewp2lMdlyNMVEZ9q2D5msEMtbH2UUKxmq83izZMs14?=
 =?us-ascii?Q?gYoAGEmEftE8/cH+ADb7fqQfbLRVGX+nEuPbQE8fKSQgPjX2oNp0HsBoX4oE?=
 =?us-ascii?Q?D6xcZtTG7CSqL5pWBkBVj6zdOJ5dc+SQO3fcADwvive6UMmCtop8oHiuh0Cs?=
 =?us-ascii?Q?feBbsmpdoc+fFYBGheNDp3s+pSqg/t9wTxEXJgrksejRZJi6i0wPN5gpUTac?=
 =?us-ascii?Q?/6MPpeFBmHK5IU+YjHYY2nTJUeNELCXnvtRrpeKq6m4dPEAFF7hlvwTNoBDx?=
 =?us-ascii?Q?POeYOLdqaXTI4FCVUN0j09wXQPlGaHKW6EVXc4DUr1y5ML5rgy8AS7trv+TR?=
 =?us-ascii?Q?u2lT/EEpjDfyXp72BI4QFf65yzNWz8yR1JNHTCF1SlnKSepItNZzSpyW0nUJ?=
 =?us-ascii?Q?ygGfS4zOH+0yZK6tpfBm6isl6Kw8tTyeeDZLBxA4qz+B6aDZK9Bu8zJpNYXs?=
 =?us-ascii?Q?1RTDLPLblJhTSpaPwCLRicK2qvCz55XWGyDJPLsEC2yv/7hvPydyHk4JDlUq?=
 =?us-ascii?Q?/xUeaNh2k0R5nOE3Hx5vseCkCFrQwrrRn1CgHGQQddUSa1Pg6Ll1+4oRimEQ?=
 =?us-ascii?Q?k02/+F9n2ACM6HYV6e85H+0+BJoYCvWWjOGBFUgA+5ogA0GPm8BoK31rXadH?=
 =?us-ascii?Q?hUvAoAxuXCu1T7BudWO/PlaRNv+zQq1PHisA3fWP05ud+L4Nl/U2QLojyUVH?=
 =?us-ascii?Q?jLxkbOlA8OI4SqC8OfBg04f3NzDrAXORO6Goit1VPwt/j/dKutkKEqVasSdC?=
 =?us-ascii?Q?UuGV0qzkp40ZALu1FSGi/3T+v56k3bFGDFP8lj4t8lOImQB84XVnxJbPdIya?=
 =?us-ascii?Q?GpxHHGWG+zKhMYk71anHMTRHuM2mAQ++pH2yzQE5cXVf0ECOxhJDQsqCO9dC?=
 =?us-ascii?Q?pAQagVlDyKSC07ZNaCyL7n2+mVeaLNKX6ENUcJbbyzubd5p8FbjE2S0mNuPZ?=
 =?us-ascii?Q?YI/eRyUfxpEaSlrPH7jUq7GmB/5cUziQYWFpRe1DwEMrmKFv6rsiBEVqpq+0?=
 =?us-ascii?Q?Yw7RJcpjCpHEQf5aZhjjdi1lCQiZ/m45h9S/6V0ML8+pvEC1Y6x6ejMmF1qQ?=
 =?us-ascii?Q?nUpaWhM3/NgfD9Mf5N+JXZaqzUj8hPqogiWkP1lUlZ/M3LB+G9p2IG5RZCzG?=
 =?us-ascii?Q?wtRlZ/+rI0gQu/4xucVGRE4pR0Hi56rLdqbMotql/LpHQVVnfoOUw0MXxwm+?=
 =?us-ascii?Q?d5cjkinDV1B9sCzXLrAymIG6fP47A20n2D6E+FsXzEOdYNZgxB3TpbY5dl8P?=
 =?us-ascii?Q?6Ji/4Khp7Is4FNyQDCKD0nIwadVuos+fKSECQHJmbaAh3WyObOKZjuI2uiZK?=
 =?us-ascii?Q?j9aD2V18E0YBChje027/QRpGOXt4jz85W54/jfLC7CUnHRVuMiWAI3pTPLCY?=
 =?us-ascii?Q?y4YgVvy2r6Cb/VRPfJ7ZYdKGnkCjX4vMaMd4VvUbsz1RzzPj/DNeuP2au8KJ?=
 =?us-ascii?Q?w4l/Ud3yBzhoufL/G0ZdsZs7AXaHM4gdLHYSI7swuNkK47fFOcO4zbiz75fh?=
 =?us-ascii?Q?K5IBxXUVdoUavrA2PTvYLVO93l/PYLBB9ye5gt+NcF6+LKNDnJJ8rs1zDH49?=
 =?us-ascii?Q?9P2cBk/VmkNpltjabIEMaHYSzmm0WECrbKqwWY85?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474e7cb0-dff7-42a5-9101-08db62ae56a3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:52.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLsvzEYSTLrx94VjDnVdz9GvLt1Kib1g1NrOt1ljCnveMG2s3NmdF29hhm4OlOWcDxM26PmidJSYz0wPMfrIUg==
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
index f7f3373989f8..6bbf9c2cea2f 100644
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
@@ -302,6 +300,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
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

