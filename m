Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CDE71504C
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjE2UHQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjE2UHP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:07:15 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2044.outbound.protection.outlook.com [40.107.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5DF0;
        Mon, 29 May 2023 13:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6Ty0sOJmlA46Gro5uH3gH+tOFhQtnK7Jqidt6tZKET4cEb0twHMdgJTNpl9O8lyzuGAXlh/z4eZInamQ7DaTIL+6g+h5uK1VfMhnn8eF3rFh2mrOslA+pR7YRjeKN9sgOIOEqKk6WnS4GIPFi4HQFBsqiYR6dZzSisaDeegti/MJ8is1AywfiqUT0zE4P+hzAUdXamNrUfKUIH6LEI3ouTZgXbDrHn9bkgkE25pD+9U4FPwDeIk2WAoLb73anIvSLryHeeIGrD7fFMxSO00K2QCQJQwfOwWExz4wuVcVEfcM+odnr0iZt3TB4JDJJ17EdBIpn+YleeHAi1CupMT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISKgrdPrxzKwoDu3CGTHqw8SLWtu6pWcUHBCYREGJL4=;
 b=h1esUkpDAISOtIIki7PNyb6izY68+7Ejgc7zCtVX8JOOmBzHFDdmrcamqcGEnwTrt9SO6IIzCS+fIDT1E6Arg3BHVRU47ZSNslXUUwlkZgbYVHyKy0j+3E+X9lS9S5XyD+O5SiLLaqFlx7XeXklD8x0PqkrThKLY7kJmX2zPn08QvJ0NxgAl9TXwtaFpiUD8pHAbp1Z3lfW5nshbSgt9fhZUM/oHKOBQePnvNIjoZyDsE/zdm8sExOJpDfM6je9Fo0leXpM3LAEdbsVuEC7dOJ/I/xcHjiFSo/kU36GKq6CG8DCuDTnS1o+U8WHoZy92AvdtWZRD8S3uMHsAF/0O4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISKgrdPrxzKwoDu3CGTHqw8SLWtu6pWcUHBCYREGJL4=;
 b=CDzKy6qKgq/bAvxvDOq7dF/O7+C2k8PIAgvIDgGsYWV1zNon1FXwHkrbVNXwNTOnqdRmJiWd0H2jysdc9Nha4t5wK5LpG41jLaslBUeYbWp9dNG78HJo74mgjDIdFi4zqEm4KbD60Ev40g4mPLmcmGjVOho4cDsRmg4B5GJJd/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Mon, 29 May 2023 16:04:50 -0400
Message-Id: <20230529200453.1423796-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24561677-2850-4824-8fe6-08db608012ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWB1KNm169G0LqIDUMr9rDXbd4UL8iVZWw1QwYadTxiOlKd2+DRcG3uS2Yg5cIXBUTc8OgBNAVs3uUDRcLnW30H/ycrIsMKsTJ/3tHvTMsQ+vl3kjqM0fFqUehnqJuWqgjDuJZxSSX2IAqk7fE6DXM0FyfjYlQXZDj43mvrdonM1iUYlrrFoGVz1PN4Os0v3ON5snvZ3UOjuaUwm6vBQ10WpFCfKlr1f9qa/6AtXtAGUMbp2GH/wvvg/pCZyLFh21kwtPL88elIRY4V5l9OFfZBfdK9m2IRstzR2+e6sq6IaoJgJHTwMILlGGcwS2JbmMbIDs3HvQlbwC4uce9cFRCOCC5AJlq/MUUMZaJOyD1mX2ybn9dW7N39cTj1c1fjsAVuzWFlHVmahOjvttvyWhqG6LxGULARAsKXgfSNCPb0TYcNyDxdtz15bV7HtqmQzAdU4AaCKB/IkiWD92untre/LMuEMuAzqonrljJMN4/5SAI/2HPfJDDJnSaLzBO1uqOZQ8HAIE1PpneDcqdNSsLn31UgWS8JVTW46c+l4ushVHYBHpREkS4z939s28I+bM4jE6k9d03spRdfcrLQar8LLYu15FY3LTRKmy2KSf1Ry+/UbsSX8G7/YFnKYjEVH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6JgEcWxyCAxw0HA9GN4/ZCjtPK9fCC1+h5MlUz9iMkyXHCToGOfkOCqYkiHi?=
 =?us-ascii?Q?B6g+un2eZ4WmGdpOKZ/I/JwARk9nMwQAmP0KHcNkG/M5iXBVOdmad1A+9TF8?=
 =?us-ascii?Q?il99mkjqkmYl0qJ8onIBqx/WZEByMA9V1mSAVIvhdMK/5GM2hf3TtXKatE4t?=
 =?us-ascii?Q?fi58Q04PPizSL6EClJFvUSnsHsY98cr15hdZvcASpthjO2BDM7K+Vq4qVwDK?=
 =?us-ascii?Q?aB/JHl7fNuxMK9eveQl9wxiHBazIwJb7eQFFYMpwYGsIcZp1lBmS7K90017b?=
 =?us-ascii?Q?3Xk6A+mHN02Y1H2JVKNGoJ0SwX2Q5yxW7btaxsgGGxxIUjOJIn4/OpZNHVHl?=
 =?us-ascii?Q?Dr/U0L7ydXlbCcVZiQH1fDRash78nVtkbO+6Fxltmo4QmpllEOhzy3POHjvg?=
 =?us-ascii?Q?6t9KP9JfFKThKyCeYjXAKSYJ1rzK8FOUTAyUS8aEjfJISh25/kBjRUkCWTve?=
 =?us-ascii?Q?Ohbkc1Vu8hSbfIw0UPuSiDvHs5n/SpGYvHyEMGqGvfZgv8oNnVKEW0fSwLzG?=
 =?us-ascii?Q?6hTYb/0csfkWmPcq9flnC4wR1XO2lFcocXxkZ6B+6F/cl7km/1bDlVNgNMyf?=
 =?us-ascii?Q?ool8sJf+7On73gJfCGIyIQkha+D2Dy4S3m5vRHYZQKJG1FKwBO0TIuCuvEz8?=
 =?us-ascii?Q?57HefyHDhzK2Qmq00XnRIRVb1H196Wr5NtWyBoedGsUWj4Zp/7+e9S/rTAZ3?=
 =?us-ascii?Q?WRQBhH/+SHo4e3OVib0tC2AAyhWm4wkkUltqMJY9WLxaZTtAGHxDFuIyJs0B?=
 =?us-ascii?Q?MmMPigDi82krivoXlPvz7exu7g3a6aL9NfRyr1Q9XMjHORUcKu6tN5r8fNd5?=
 =?us-ascii?Q?UGACFMYWGSF8IyAQcBRNlIgA0fcBGNeeI2N5tK9jja918IbXzmYUU7iS1u/e?=
 =?us-ascii?Q?mkIgE8AeYZmZNK5IwFQDNUvkvoh9t83I1Im2CtU/7b9UeADrrXpzWY3Nc6Vl?=
 =?us-ascii?Q?jER+3hi5uw4fg66QQ9IsCP00n0DnRLoOzG6MUwUMO4GT8je4klEE3kHAECMN?=
 =?us-ascii?Q?VtZH89WiORvCJonyav7dF95mlpFrnGVdQQCOPZypk+VdzJv0/bs6qgZJPWrz?=
 =?us-ascii?Q?rlMrQormK4Ato2e4vfT7WUWYLh52Qozpb0wh2yTzl8s5MdYSOzCReQlup3KU?=
 =?us-ascii?Q?3S3grSco5rgVqOBH/GXYy+94GHJzzQj+N9V7sqpOOdbTK6vscb+UAJSTz9Xy?=
 =?us-ascii?Q?xyE4+G2YPnH6qya52ptUVqqJX2LYvljVJiZTEykxK1imamE3KU/4mt4LNIHr?=
 =?us-ascii?Q?MvfTpG7QQiSHcpKFiEzn1XU5npn1y1HB6SFQ91OZpdcqnywdWfg0G71fmlZA?=
 =?us-ascii?Q?drXACPAKew5PXlB0zxbMxZSt+3+xOsqtNPkrZT1ctjSNrFnwuExgeHEUaaBj?=
 =?us-ascii?Q?F4rnEI39sVSYq+meuG67/DJ48og9ZEz8OqHOyukBKawtruEdarzI1FTIaIef?=
 =?us-ascii?Q?V1Se4xk6W+kc6yvf6T61UkVTyQHv8Cv+/IVC8PYNadq4j4x0A6fenNduSTyr?=
 =?us-ascii?Q?3LrxaWB11dvARUuFfK4P3HLDuA4TxtwX9MZeo4jHv93MQfUB2TeEBRwF8xkF?=
 =?us-ascii?Q?07Vmg+u6hQONJ7KgstwTQbqkp0cf/6D1Zvojo6ay?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24561677-2850-4824-8fe6-08db608012ee
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:39.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDhq1+tpj6AjNyjkjCfcbkosHSTHdoGN2E5Jn5a8GU6sJpBtdkoiVVqtjx7nXDdF2creHF64BctHSCKLekDRwQ==
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
index 3991956dbc11..39b5f903ba87 100644
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
index cd734779f2eb..722ebecdc894 100644
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
@@ -305,6 +303,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
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

