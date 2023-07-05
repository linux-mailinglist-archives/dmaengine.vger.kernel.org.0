Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531EE747F70
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jul 2023 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjGEIVP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jul 2023 04:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGEIU7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jul 2023 04:20:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072a.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3A9171B;
        Wed,  5 Jul 2023 01:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJftutNMve+utjmok8zQw7jn0dMsz6jCFNUnDD0zYQre5DZxkGDOZyXrI2jHNtkyPheCRkw+c/veWVQ/D/o1po0GDfzfrN6+ngbFsVHeaUmVJIEXfig5ycXvghh2SVrk3jHW/TPrVaRxUta9olw8qorSSO9ue2UiE9tJ2+6Qt4D4J+DKJpE1tfMNGGQJTa5ANbXdVihu2pWPPLFChhEz1FRKydZrE2+T0LUoA59hn+fO2MkhwiKepTtoE6zLDczwZeCI3q6oHiWvsG44lgN4IsvG4I43AxNeoxUm/KKj6JojRdotEm2jlnQrxtdBvrl5jzKHUNzDMbZXVUDlYzCWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFAjjT8+kNbUdbkIoD6wpN24vp28qG6AZ/yOH7wdkVE=;
 b=Ey6WW3oC+IpLTlPi7hEkJ5G5LRRWTGyIGbcJZlivKjMOuVEDHJFU+jAl7dS27T9q83LA/DaTLKLYwk7egsqhe+mFiuO5blSkbqWk7DE5G2Ogng41aQyxqCxuMV0z6jdiZImLJhcITgqbsY+cYArY0OFrI228Xkn2hLfT05XYgFs8ADYnn+ozD1EAeJseLtwLOu5+H/RW8s11dUBIKMCk5wrEOkk0fE8x3/Ss1ViRu+UkVxvn+BpM73Rf3kDCwPRk7DhOdpal3+01EDtuyRQ52pc4GvK+2mKxAG+a8MWnISOMItPeFMh7Nt7U2KkY+2nytXa1bTbVVXeVES6w2cTLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFAjjT8+kNbUdbkIoD6wpN24vp28qG6AZ/yOH7wdkVE=;
 b=aiHO0oAqmHwKZAaE7R992vDG3pGtUo3w8AgMGBJjeVXTB4I5i2oEwF7JkE/ASAmBBY5w14h+2Lcg6XF6+EmItWq3Tmx5EM2ppGgxBW1SeaG5aVyRCCmyaDWumViCuVHEwBkAgju5tuwqpPHBWbOXHDidfUW55/fuAslzMGhHV0gU960V3KaD5QG4+s/ejcQtYK8tuwJYM3eLehQ+h8yeWv7Ci6GjQovNvbSoD7yyHnBXwsdY7ZZLVzk1lWPp0Rio5N4nQL48d5KKuCzP+jDnLEwwDMPmIixoN+Tf5S1/g22DydGjd4GdcjzVdGZMs6tDpfBdXhIVdimaWPT2wtx4ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5119.apcprd06.prod.outlook.com (2603:1096:101:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:19:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:19:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yangtao Li <frank.li@vivo.com>, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] dmaengine: stm32-dma: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 16:18:56 +0800
Message-Id: <20230705081856.13734-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705081856.13734-1-frank.li@vivo.com>
References: <20230705081856.13734-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: c45f17bd-14bf-4038-a33c-08db7d308629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DA3+LGi/tP6hzixr5UEnuPK5SHCiLzdWM7hyIRpNc/65SZdFGb83d0PGpX3zoovmv+V8RqW5CoHGe9i9ljWaAdM9DusSHYlFrX9Ton5tSz/jhFamanDKeD4bu3AFwfKQ/vbxAcl6mVYcEmmNgtLihciXg4Ni4bGV2+gGYcy48+RMjW1d/H4rrnA/NCh6blg+ZmfaSBI28svv+lhaT5Q9hjmcXC/mSbr+cnDi7wsgP9isSDAdR1cRHNr4GuchZqv2mredmBG+YYa21bPT4t1BOS9vChUtCX2Z4OZSdu1wO81PZLgMvsij+Pa3XV6WwavqMNSM+Ow3AMuFMEuG0f5pwbHz3G+wofYzGlw5EqLRXYJyK57KNKpz7BO+hZo4/rDFeniAGtHYH1KaO+QC/VpP7rq+5rc8jVsZkGsC6divZ8xDoYz6MKgI00t+LY1AYYeEveQmQKUZUZYEhbeeJI3sKzC+btmHVvzoV/9dHmoGC/orSEWjp7nSPELUVV+Q+tYmLnmAnvovFYC8yNN4WBdOfCgN/YSmD88Fyv7ebfG6bQIfGNMl2eNI6ONPi3WOFnWqgxjic9/vRL81rjKYkCqX72Rul3pdyJeNe11PA4JoO4ZCUiJALrVwndhwqXqPacWa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(316002)(2616005)(4326008)(4744005)(66556008)(66946007)(83380400001)(8936002)(86362001)(52116002)(1076003)(2906002)(66476007)(5660300002)(8676002)(41300700001)(36756003)(6486002)(6512007)(186003)(6506007)(478600001)(26005)(6666004)(110136005)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VagdK06blecNeYS2mQvfZk7/zEELVpKCrbQU4p+i962dKAbLyj1nry06BpGN?=
 =?us-ascii?Q?Tlqd4da1FZ3h2hvZULg93afy7wWzXW2mH2g7qYi+kQcPqUh1pv7Uc4/4DCzW?=
 =?us-ascii?Q?9RS4H+bbvXLnI03IL1qnecFAJz1HWi/NyDqdKOsLOsYgXE1rManRcuFL4D9V?=
 =?us-ascii?Q?7iaQQGkMxj+njbKsAuAi6HrH1XsZr5t/XWkVmnY869vsA65NhOk7/zPNgPda?=
 =?us-ascii?Q?vspZ7EzotLH2LPbscrmpZ6iw6sZtKpga6DHlw6YIOVsDVA+LotwprYAlWNrz?=
 =?us-ascii?Q?1lE3cFrLbOHxVGITxbTcFTlJbiSkOrcODWs8kuxMTNz6onDMErjWh2X/d9KR?=
 =?us-ascii?Q?k3WYuV5QxhAI/qHwOqt73oviv6IV8uH1jg4PFkqC4xs2Nf2Etzn96s4cRjrS?=
 =?us-ascii?Q?q+Z2zX7uxPbzH7Di8Mmxs0dHGlypHLtMc/hu/mqabwdy/uYdLi1iUtvBjCMK?=
 =?us-ascii?Q?lgc2s+uQTeawa8ah/LF8+ojG6qEVDcm0tv/Exkt0XPcghBdEaw1BO2UbO6cF?=
 =?us-ascii?Q?7kyO6pkFZDmmnQgsQSEUbQar8GBQOtlFzA2ujkMvMQ9fBQjdDdWhGqQdLnf/?=
 =?us-ascii?Q?YLG2SrmblSE5g3boN1sMlLVg3HezPqKz9z06nDeuaL01BnXm1UhyXhcsEeJp?=
 =?us-ascii?Q?QEy22koPIdSX3sNl6wk9RtIrUMVN6bB+hVSXWyOjafg9AI2jFSskkI6n83tz?=
 =?us-ascii?Q?/4vxzDjY713rfCS02WfW0szDONDH4dW5gjIoC/YwvjKLKgT8Guxj/IuYthNe?=
 =?us-ascii?Q?doBnfg0MhDL3b8NEM+vmC3MpKLCSGnvCPfxecHFfr4QZcWpVE/famirRXrHm?=
 =?us-ascii?Q?dbjJazVKyxXFc4ZpdaVWBjqA8uhVDYaLtrk3jAXNOY+Q/3HLre4EC3ADpUS9?=
 =?us-ascii?Q?k1Tk7TorgF0wpjmK+p5G6uWm/Ez75X6dORPKtw7BC3QEpqJVjrgKGCKrGTVB?=
 =?us-ascii?Q?uRbKZiPrGmbKPSlptauti+wjCAwu4Ljgj0iwSsY7eCINYeSyHSk1CTZbJ/TE?=
 =?us-ascii?Q?LnHmowMhkE+9uvwnXEOkL0pyhwRIEzm3HjJ5jGQspbZGcuUtLJq/PYtDI4iS?=
 =?us-ascii?Q?CzJdKbi3ABNqwRl4mJy4TmzJqArtKplFr3v7gsZposjJm/UpvkLF3u7/4ApT?=
 =?us-ascii?Q?eULOrZCbPjizEjzWVloUXXUzkUN4aLi5778k23V+7RHnS9jvWgxEkpGeO9Xu?=
 =?us-ascii?Q?NZzOUp+tKWy4K4ptyJrsvuqPFlQl0jAY5fTHI1AhmzMfZGSrXSVa1N2wytNC?=
 =?us-ascii?Q?fkZJHmng0MuN5/9xK8FAtTpYtgwhzHEbJHvb2Jq5ovPPBfLPMtQAX1LRJdUQ?=
 =?us-ascii?Q?gZpHWAuqPH6Wj0UVWsPuLNlZ/vK9cxOEu3D+2t4MSkW53SfM6+94Ub4X/Xwq?=
 =?us-ascii?Q?UT75QYdeND3EleKH5mLEvyf01Ly5LIdUtmkv8i5AJS794dqFcqdUWN0NRMNM?=
 =?us-ascii?Q?rXnlcg2BkZAr3YptQSZuL+GN6ut4BKOEJjXpVfCpqOVb90Wc2x/BLD3cGXF4?=
 =?us-ascii?Q?L5SDQJn9vSy/qfJA2+IsJqWF4XD+2srZvacsrIXPOuXKVfgnzxjx5MQFdBeU?=
 =?us-ascii?Q?r09aikCQhtcjRm68A+VZmOx9iH8Mt5i1d3wiV2so?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45f17bd-14bf-4038-a33c-08db7d308629
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:19:16.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Yr5cXIvGTVjrNE6O6tKKkmTfw2n6FH624ef1IgRUv/Sbdodlkm8AZAyJqoryPoEgZp+ByMSCcZt+iyYuzT06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/dma/stm32-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 37674029cb42..5c36811aa134 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1581,8 +1581,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 	dd = &dmadev->ddev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmadev->base = devm_ioremap_resource(&pdev->dev, res);
+	dmadev->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(dmadev->base))
 		return PTR_ERR(dmadev->base);
 
-- 
2.39.0

