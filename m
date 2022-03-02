Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920BE4C9C07
	for <lists+dmaengine@lfdr.de>; Wed,  2 Mar 2022 04:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiCBDWy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Mar 2022 22:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiCBDWv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Mar 2022 22:22:51 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300117.outbound.protection.outlook.com [40.107.130.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FE8B0A75;
        Tue,  1 Mar 2022 19:22:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWAzgBfCAhE/doZQ8AAgLY5EMCmfSWz8QXnZlofXML/RzvYleh25SbuHd5EDxMayJtnILciXlNDZSEr5DPJw8I7LLOyUvtYBNevA8ar1xZAla6coeJn/nMEON6PnJiCXgaoxBxCMpxhKIhkN1RNsSMeQmh4xF+C2sqV7z1dTZQ4trJY0JPg7E07LHL2KsZ6hVar3v76WCi50sXNC7joHW6antnlRtLZsu1zFZn+LTdt9UPPrhGXJCPZz2kXn4hLuViESucQ78PQGiiLNgsuh2VXRrQosoHJGLI2iEKFOmgkfPhs5OahozTO/8KrSlNdbxJlS6Ka15frUU1/GS+ywtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW382J2mvADOQNHnGf/agml1Kz2kk2lFAG4v1eZRulQ=;
 b=B3KUS07uFQnAC5YzR5tvm4rRNC1q5Nr6hwWOy4DQG/CTun9sOmVJyBamCGrJHl/Rv8z1NyZF0dP5umUWeAvOVsLSVjyp7USSkqMimzzLrWd45Ffyx22J6PIcjCR95XqD22Q/XsdPfL9/ayDdpvghCoj51WUGXd9hFPdqRQ/okyMTIYWHdsBN1rfLbQPVxy/jgU0CjFZlofcqY3b/H3cwgNF3pmqzzIjSLTL2CJy9ldtlaJipLJugnuKjxrGEltTKCbV3hqqsdO6GUPbKA/JYLf8nNsJKrLeqRfvjr2hCKSEDf6tPlUaoGLadW2H0NIOKtbqAqa92F+VnF1WsaaPXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW382J2mvADOQNHnGf/agml1Kz2kk2lFAG4v1eZRulQ=;
 b=CjlhELw0MtJdIAcl1+DXJKLtNr+h+hUAsANb5vi0oq/dFLUJQwjS+KbsBZQna0ajpeX9+nHVF078DpTlDuTH3UoBGP+lUvo3nJjNA1XbLlJ1X3mTR9KZRqOEskiriELtKr/ApbrbLNzuwRAQJv/+xYOrYucdw+O8Fl+xikG3Bic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SG2PR06MB2924.apcprd06.prod.outlook.com (2603:1096:4:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 03:21:59 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 03:21:59 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] dmaengine: sf-pdma: fix platform_get_irq.cocci warning
Date:   Tue,  1 Mar 2022 19:21:39 -0800
Message-Id: <20220302032139.5416-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b19c6a6e-4540-47a1-ce66-08d9fbfbcfb5
X-MS-TrafficTypeDiagnostic: SG2PR06MB2924:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB29243CA9BD9484887C0507EEA2039@SG2PR06MB2924.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4oVuoutoxC6VxVsy5ytcDf9078o8UzerDfmcdf7n7qp87JLQvP72k49oLnlngDjkgRsdqOTq4bnfDsj4Okv2JGMxnkttKTTUJsGpM2S04F148RwH9CIOP3qhSH7/TQwAWYqqiKiNjyge02KxunDakSjBhDuwztIzafoKghRneQc3FJCT9ziAqTIhiDjtsBULRqkxpXfYa0lnGs9SOSOAejzK9HbyrmMz4Tpb7hX19t2ATrYUOJmk/BQW7JULm/UCoh+RID97HwGMXriciJOPjIsICLsC8Q8le5/JTJa7Myx4UFvtMh7L1eWboaNK3UGLvzNIynXFPiPxIB5auSU2LE6fUFLMJJEDLGtJOVWF25izTRDPo0vw990aKuoYnyKI0AayBJUFAS+aeQ3l9FMLHOWadMxfnbqbvt6Fii+eLcvnGbvWZMjHM7VOplrBI26GMaOAQjM04utKwN9QJ0oY6URPszR/rO0sq5RpAY3RGovSToEofMfQBiXMdbuahdxkDZ6HvVwXqCLs0EaR3Q7ToOFOukYXOcJ12PT3F7KCZfqkhFL1UYAZFCrIWzYYwUE0ksGSR0fPwC7FMbEUchZHE7dU+Xl69GS6GVvSjusblfH44+iZ3fOe3OuchFu7rw56nvEYntH3WlCqOZBfkHayL5u2EILyrNjOPcSpmna7+dGx3M7cz5OpXFg21x6K7g5ug6R4ap5U9SIJe5Ikj/Q1hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(86362001)(38350700002)(8676002)(6486002)(26005)(508600001)(38100700002)(66476007)(66556008)(1076003)(36756003)(6512007)(316002)(8936002)(107886003)(6506007)(52116002)(6666004)(83380400001)(110136005)(4326008)(2906002)(5660300002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?caaLdbe7O0g/QgZ3zsqBpqR53sV2En7NOL3cktDxhRxIRiDsOghMeeR450jM?=
 =?us-ascii?Q?EaSEGlyR5zwhVB7c/BeOrL49QoFqNsEQlMYhBasIPDWOF94+7XxIgAWLEk7K?=
 =?us-ascii?Q?1P5lXuLLVjyjN3Po6CJgQcBfbBfazjfClFU5jRvlZKE78F3rv7I7Ng8Km1yQ?=
 =?us-ascii?Q?oZyNxpeFoeR9Zxe0OhbcsLJE+p3eh1UXwM6PCI4pKqOSibTuQLSMYeBGTMqi?=
 =?us-ascii?Q?Kezqj4apCzmitlFcTdpwI9XZqSYTQA+zUQns0C7CreBZZT29EtVYOB/4g248?=
 =?us-ascii?Q?Ncu6i+XOOe38mmR/hjHHnd3LJmKdYbY/Ndf7NRkJl2SGLVsGkDN7GoowdgNA?=
 =?us-ascii?Q?XQXtaq+MjW3CmrM2ZvSDHFIpxnzAoyFExs+IDzYrHdpBU1nw966oNN+cnbB3?=
 =?us-ascii?Q?g3XE7RPnsJXLJ1GOnWr9E3MDEManSGjxCmJSDkSCOKB2EYB+tRxQkNv8sDDH?=
 =?us-ascii?Q?rQIv/eF/s6JFhgWb/+6EAWT1/o8yZjF0VUk8pJflb9DtE34ieqaRNm8moiQ1?=
 =?us-ascii?Q?neZJKEvcya1yd7CHIWy1SexDMBv2CAeL5O7gzNVaO2t8nyEkIeXtDZT+T2rx?=
 =?us-ascii?Q?WrYt2mtDlB9GbIpgXRl1VrbfMe1tDYdzR3QEWb/BrfIjOJ1rEuAdPDIULFJG?=
 =?us-ascii?Q?jjowNQbmAbPikX4VBcL7g2wQibjhsTdXHe9AwkVRSCmn6/XOCwDcmQLEvmwO?=
 =?us-ascii?Q?FZk/nHDiOl691mP7+nFXlrRHhm1cWuXltA6pUq9g495aRfuVg5Hjacu1uhd1?=
 =?us-ascii?Q?E16iK/WcNXymUz8K5fz/6GAfhjL+XYpOl54/CLrflR0gZ8mdWQYboFRAmwgH?=
 =?us-ascii?Q?7VdTPVJiLndeybcXEIXil8Ea6qOOTxHPbPmmM8fJoEYqmnnDIlfgs0+EuQHZ?=
 =?us-ascii?Q?aKsI3tBWfdw4Le3H8eIOVlx/K6kvOKS4+J1jtEXKhrAWn6nYi5R/HggRBjwQ?=
 =?us-ascii?Q?hH4er4lv1Y5g4Mc9td2+U9ShkycGhyIUrb12pFb1cPAFtbwP7aBhFlq3C8dd?=
 =?us-ascii?Q?avs7cAX35sIAHG2B3Lo8vwLdYUxhEmfbx3nbylHl6CB/3lRAwAimCIrJ/GwE?=
 =?us-ascii?Q?iFhU+6qqk44GkfJrXGHABSFmRY4vBdmHgfrymm4U9nKBK8Er2lZVPJ+aB23A?=
 =?us-ascii?Q?bzu6NIkoTcrDClnKCl4z32EQ0fwnfCEkxgdFtJUt0D/9CQM/yXfp6nNc1KCN?=
 =?us-ascii?Q?OHOVV973jhNCbIq98Q/ls9WBn2KADScKVYylHoIXyb3t0hY36EuiGYuwE7bv?=
 =?us-ascii?Q?xvx39ZWXLv6NeLGbJSx3sWiRKLeSBW0Dntgm0+D0e+yimuXwRYEfTPhtWWu/?=
 =?us-ascii?Q?x3EF29FC64v82kmpcE4bUQmVFNtqKr3J/mpsqoYWtHVBipNw3TvORkTmCMha?=
 =?us-ascii?Q?iAkBOrKUHTAazblIW1Q80G94IxGqp5Ckmspy0R4HcWIzYqTL48TkIfvYMfM4?=
 =?us-ascii?Q?vdIVU0UcP5BqQdaJE8qDIWqdyKPNE/CL6OHJrrVkuv3tDcy/DMAGjFzmpK17?=
 =?us-ascii?Q?9ZQmXtr08SYlPobBiyecppljmmdx6lVqXWfaNiOQmx01vn5hJ5HEDYWrHq+l?=
 =?us-ascii?Q?By7iY33FGGMr5Tg4gwHPemeaNHfLc5BKO+pFTlop+Oq/ZlhXhF+7oz0HWWRt?=
 =?us-ascii?Q?o+MblT6GTfWgR7PBeNbVUY8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19c6a6e-4540-47a1-ce66-08d9fbfbcfb5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 03:21:59.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek647+J7elNidzpjLol2dZoAXof43S/ObjFikd4x247FHMSn1JHWIjQV/VfvqpczXLmiLuNXu3R8DNkGIAUT4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2924
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove dev_err() messages after platform_get_irq*() failures.
platform_get_irq() already prints an error.

Generated by: scripts/coccinelle/api/platform_get_irq.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index f12606aeff87..c2e40849f2aa 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -389,10 +389,8 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
 		chan = &pdma->chans[i];
 
 		irq = platform_get_irq(pdev, i * 2);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "ch(%d) Can't get done irq.\n", i);
+		if (irq < 0)
 			return -EINVAL;
-		}
 
 		r = devm_request_irq(&pdev->dev, irq, sf_pdma_done_isr, 0,
 				     dev_name(&pdev->dev), (void *)chan);
@@ -404,10 +402,8 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
 		chan->txirq = irq;
 
 		irq = platform_get_irq(pdev, (i * 2) + 1);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "ch(%d) Can't get err irq.\n", i);
+		if (irq < 0)
 			return -EINVAL;
-		}
 
 		r = devm_request_irq(&pdev->dev, irq, sf_pdma_err_isr, 0,
 				     dev_name(&pdev->dev), (void *)chan);
-- 
2.17.1

