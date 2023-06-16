Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3887334FA
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbjFPPgw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346070AbjFPPgq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:36:46 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AAA3A8D;
        Fri, 16 Jun 2023 08:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkpx8cKljSlhzvmdmNByhK8XZliebmv6FT1QykmC0/T7Jqc1cyji1j073iJ7SKgw0fYmZTMgUtR+vTDk1Cyu0daHdf99seGwgkz9iDRtNhwZf6BO94coCXSyRVt1iKG639xT+QRZOiG2dQxrLIexD+ZNyVk4oF/1cQJe55/Z2JOBtR7MwK3a8Ymnb+ltMhfKvGXHcEFLrgXm4iqCakt16NXwZpQ/9OKwOiiw3x5jZ5PqFnwr56ER4W+DsoefXHGfZ7j1N0Df/lnVv6qUTSUZscKNkVRIOCqwEj2Zp+RhJpvBcRkJdG2pPl+dBWHZfLzVOlGHoDLUiKfuMo5N416FGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=kqiFGiCq0NUsSBDbqrK8k+mt5j76vHtqGRfG2v7lhJeJYpnvBXrypwKWwiIjHGZYzADzOzV/7PWkppHbW05aHmKATLi0RDHjmn5a2cc2mY/iEJdeInMKoVG5S/2VdTzVCeu4NUhBs0L2xj7ySgHySvmtE6GIyUrXKL6iedWHZbb/nZQwF9mpVs56gkRTuONwI1uahN69ThUTr6oM0rLHtWRVXf+4jZ3fLiom8RgV8fxaixTb/Jl8aoDunQMnyVfnro1VjTmHK6tVUnY5VZPVxrGC7QpQXxBtfgqcSAY6iIRJyGjEWGouR0QC9M+cqKnzLe8B3MfnhhY7fCEmc8aPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnuduEe23aVNqNQ/tr/oGRmipeDq3TVAdHibMWxJevg=;
 b=FCh76l1eGUYS9X5ewCXDYlPbQYVBB3/OFiYZcCO+3zxumnG6PexnCcFnS+II+BKPdNOz11FBtj0qvayllb/rKu+EUkVTJLwR1EXf4NocWGyVZplGbxL9tCSFgFBfNPN8uEeRXJbw/4BUcXJD2ZeTEHYsfgZH+boN6ecn2wku7OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:20 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:20 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Fri, 16 Jun 2023 11:34:35 -0400
Message-Id: <20230616153438.2299922-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616153438.2299922-1-Frank.Li@nxp.com>
References: <20230616153438.2299922-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 4873edea-fbfa-407d-2461-08db6e7f4b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaPTIIY/oXFmUAzJO8xKjeV3l3cCbo/Q7XjPANDKzC2OMBpTlemWaqsN8UUltrDhJDHJ6Bk3+upXu/yQPlCXehfLmdhYRlo5m4zu/3R6rtyvn3dcOh1Gk1UAq36FzcSfdGeqtLuIRwzY0zSTCSOLwZ8a+ut6OrC8FZTV9oVkQCkfjTEEWM5RsG6TkCIS0s5C/4pTCLegJqP+KO76vrnGGQysowhIdQYnqIZdrnXcZRm9l7nZ/89euQvjqwqrYPalQW1l7Y5zvwUuGK/4NbugdkCfiqiWmUkpkIBLTxqqRbFjZtvB5PYPYrjXgEUcnGuXXq+3f/x2k8NiNqSFStBw3v18Pd20JuFvU6nfdVA64OEctMnRkFtLP8m9MBtGXBEttE4iK5lELYBv6ecTroF4BJnxYmh9TdyarS3b7Sg8h7qrZk6sK6yaGpK2JRw6DViMSJOArWLosioYYbFgd4rcRgYu7Lzcw9UzNCkkjXqaYNMfmn+qLYiw4UXcBYMEHY3SUcqZHys2NyMiLvAl4ZGI8ynnGQocfW+a+kf3s7VoAbk1T5G95m6iyjAaZWk2FslNzT0zyits1gwjyUs3rjf5Xc8kItnY4VXzsU8wGeC0BV3Y0fZOyGRj+h/xXXXLRtrkBbE5cOFj+jeMtqAe5LgrrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(66476007)(66556008)(921005)(66946007)(316002)(2616005)(38350700002)(86362001)(186003)(52116002)(36756003)(6486002)(6666004)(26005)(6506007)(6512007)(1076003)(478600001)(2906002)(8936002)(8676002)(5660300002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ss03I0Cn04E0CEqIGZ3GrDeVtzQfHPFuspo491rapU7aw85pPXaLZuZ3XRlc?=
 =?us-ascii?Q?ULJvP9eIax5GTJqBPpEcJf+BUar6drlMkR+cofx0E/1nwQXOF4wF7308KbM+?=
 =?us-ascii?Q?H22Zzoxr9EBT4XeqWZuNHUCTz9id66Pu2weYrVsn92qR+ZrjXKsky7ATeYYz?=
 =?us-ascii?Q?fYHwR/3VTacZ+qKT4abbK7ijuD22ekid7/6xHgFOoaQ5oHvrlbCk/TzJDRh0?=
 =?us-ascii?Q?NhsIR9zcllKPCHFQ0Mdqf7TtjplaxGIm8uKBfo52y0/UK4RaCJMNMov8m4Le?=
 =?us-ascii?Q?JQ76/8VobWr7hFhDfGFROI1jzrlTA13TYyh+BfnOZ1GduG4myu8rxc+jfhfB?=
 =?us-ascii?Q?GIQLSZXZYJohH5JtSbS0/TsT9lH3pNzfP6W/Q1QxBX6jFhh/4yvD+Z8V5VOO?=
 =?us-ascii?Q?KtVLJAA7RgejKzMfTlj4EMxgxlNs/M1AG71AdirpmHVHOYQp1luCzh5ctMLT?=
 =?us-ascii?Q?DAsbO4FkXZS53JCvmViO6TRq8S8gN6pC/wMD87tFSPa69l41alfa9jm+kNqA?=
 =?us-ascii?Q?D2tFj1XITHy9+8ll/41FEN14/wvX/gIVfmHSmCL0iAg/7Gh5Jul0P5TYvvU5?=
 =?us-ascii?Q?0rLueJwevjXpy4PzWiyhhY90xIBbXTabfvvJcKPVlNOwuzICyPCVXPXKgq8h?=
 =?us-ascii?Q?EAGfwFnpBaEhwTM6aD/B7n6ycIM9Ii5GaIJcV+7c1UVosGoSnSyHcHiAWfi6?=
 =?us-ascii?Q?J7oBPvYYS80C1qa3PbSgkN9McfnVBguozxjpgbrUxrjmLJrNh1sgt0c/VaZQ?=
 =?us-ascii?Q?3peUz2rizqB6E9jcbBA2CIo1VwiZUWaQ3q257IRb24YsHT5a/nqI2F0enFRw?=
 =?us-ascii?Q?NSS9jSSz6oNYztFwgmjtv9nZhAHArGQm+rHXkjH2cgrYQsDdzNRCgG7V/N3e?=
 =?us-ascii?Q?DXiWIOlQt+3lb27NtN0RO62ekUSJvx5u7Qud+aK6TyQ8GMwc8oC1y0OjTCWR?=
 =?us-ascii?Q?NZccNHjt0bDNPrlaM2TX3gOFIFuupnlZKdZownqXsuiQw9fpZmd6iLvEkobN?=
 =?us-ascii?Q?hrkBX0GlYqqNTGILkd9jI889m+Dajkf+jylrf5I8BnTfyxczInrKgzlJ+dep?=
 =?us-ascii?Q?is85flzPdMphoQFlzVnTA46RP4vdGtYJs3BkLiGAFkBKhZXYJnR9fwNE4Nj6?=
 =?us-ascii?Q?vMsu1zU3gbZFw+9zNFQAvT8zs995zvLGK6Ix6EBl5MeB+UU93tonL91z0Sx5?=
 =?us-ascii?Q?0OXj1Ucb7vGqyQoo+S+RJm9U1rxrFGEuIi5gVdYYySFjB5rBa8PptLMxMRaT?=
 =?us-ascii?Q?xZBzYaRRIngDa51j09M7xEuaPdtB6j9pLJE4YIN7alkb8cOBcoo0UpDPpoGJ?=
 =?us-ascii?Q?RmonX4uAJswbwurGG0TtWYtll68pzMMiYVgDg+Gr4vjSHmVUUQapA+klao1N?=
 =?us-ascii?Q?mhA0HPAVvvpI8NfQX4YwextfvZO6YTgFfmU+qi6/+7UfdRiuvwW+NptKTCBd?=
 =?us-ascii?Q?68XeLi924dqnU4u5CRdDVBLdoEy9OLkbRTZzzm2RVHeDf24/K2ZihOy6TBl+?=
 =?us-ascii?Q?OIz2CEUUbTO51kMEOb4DZFASrCPgVxK+U21HmJhU8zM/xlfLglq3uVdfVqte?=
 =?us-ascii?Q?RR8LTtIHHD6cGHe8OJI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4873edea-fbfa-407d-2461-08db6e7f4b54
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:20.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNOEkstwVxuOXhWwMGUwoujR5Hjmm/jZr/XWQimaGWQ0cqiOz9FtsQ4Vbgx3UCJ9eLDZ4djbOyEpa2v/k3Blhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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

