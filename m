Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5150270E35C
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbjEWRU4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbjEWRUx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 13:20:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2093.outbound.protection.outlook.com [40.107.6.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2955132;
        Tue, 23 May 2023 10:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGibNfBMlyJxFXfQeUGuJQn4xZBv8tP64vHw8/ZgyskFQ2euJPf7831hTMe988aCyTERB8lHisg/3AhKrE8f7no91TZmC/t1sUblihGPRUiLnV4o0cd8r/Mj0H9gY5airzmK9rYqBjpNd1QELUJYztPtTCqfyM6LzH00DK7m/31tQgqA78KwA1HVluS2eIAl8cqQ1D5/eDcGGRXtrHYPKrg+2wVro8p2zt1AFtOyuR0PGi3gu+sHvzJ1ZOKlpagvSWfX5dYWBVR90+G+vrPY1D7sah/f0UDm3y+E/czuY28cfIcQOGKPpZvwJb2kb0SVG9PQ7dH+Mcxro1CWe5vtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCmZY9WSyKFATcL1f3tMKVhPsdg8Fa1x3+yva+emnp0=;
 b=QJopUsXoE0osc9iGD/8Cn6gLUxtGmUy2CS+isXsvUPLbriBHFuLVW98hOG5C2O765azLlN8jc+oSaZx4Wc3mNPKwfEe6aFc7A4+zplaV7U79V6ZdzegOnRR69t9QLj1ZOiAx+b+d4SixSh1FlvEU0W3IawLa/O5U4Y7LfflIjGXz9IeYBzjpa7DL7wN/EnOYVHtC9RFgRz3snVizq38NGOSamLkcNFmSc684GiV7MMVhiwFT4+3/3ttTg0MKfukSPKr6CKwOqS9bDJP7f7+KI7Bg/cfInl8gpHHjsy2uum8Hok0JBbnTjJcQOkPxZTMB/S3H7NapVWDZAU24/TdRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCmZY9WSyKFATcL1f3tMKVhPsdg8Fa1x3+yva+emnp0=;
 b=DAU/DBB+Lg0rL5buaJx5Q745g+HwQhZcMEpNC3H8oms+oZsfTJACY+aaHeqUCY39+v+fUiQmx94jZJgKuYRa+kuvXS+TKqJfyPIpVqhfQdVqmf0Ib/FHbcnUa5fmukHfnAafdEHd7caHdtuIJlitjEe6QSIezPOAa1NBP00q/I4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAVPR02MB9205.eurprd02.prod.outlook.com (2603:10a6:102:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 17:20:49 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 17:20:49 +0000
Message-ID: <e2c898ba-c3a3-5dd3-384b-0585661c79f2@axentia.se>
Date:   Tue, 23 May 2023 19:20:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
In-Reply-To: <221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se>
References: <221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 2/2] dmaengine: at_hdmac: Extend the Flow Controller
 bitfield to three bits
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::21) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAVPR02MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: a58cfb92-e745-420f-6730-08db5bb20dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sb4k87muWCu7kOnzl1R4hzNkv1lAZJVj2kFyoIC1zaNzXJBMGm21js+7t2FMeoXG9K6xSj7bks6c5jD+Wy+yjERZkyrzTk4TYfR+d+FoL6P5zffwwH6b5EohBUm3ty2x5V1oT1e2eJmlMfIb7dljZ+Dw2mQnL/Nr/wMNSs00Ah1NTTJ7kT8F1d0tsAsVTuUfq3VYn7P2n9ATais5jpXljwtA76glyR+It2vuFpJSK4khtgHAJ75uoBr1BVfuhavx7j3f82t25p+bQQKkSYgdWW+h0IyDsZpZ01fii/nt+xlSKtTQDI33C1R0YKZV8+5BPQXAIoLM3cNohfZbpA8rguUf6AHs2IUvgWwA8sKojtU0PCGf5F0VzISob7siFcZzEpeUJY7Hp86vctW0SLMBuYNvE2hLNxCiX60snhdvkKS0EWSodDnigy2T9bwVEkx4CyjyUDelknHdTFDCFRNdOxFWGShMo2KIJQb66da32aFpgSR5vh7MDi1kHXDnIlqP2eI55+Ue5W2/AaeTXD4xckjlazNMKTyRlRO8RmiG8SVgVLw3aFNDk8hZeO8FctlEubORsIcm6L1lhBIwjF+2ZnoGJH+na8Yv0vobbOanvkNJpCQho96OrCXdS4bWA6yrKmby/wVFRq9+51vdYmD8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39840400004)(376002)(396003)(136003)(366004)(451199021)(8936002)(8676002)(5660300002)(186003)(83380400001)(26005)(6506007)(6512007)(86362001)(31696002)(2616005)(38100700002)(41300700001)(6486002)(66476007)(66556008)(66946007)(6916009)(4326008)(36756003)(478600001)(316002)(54906003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZobHJDalc5OU5Qc0RkZll1bk9QaU9MVEdodkw1RkxhckVob0pubnBYRTBL?=
 =?utf-8?B?Vzl6UzkvWFFHSnZPK3E4dmhLU3RzRDZHcTdaRTVMaTJtMTkxdTIra3hOYW14?=
 =?utf-8?B?dVl4ZUZ4c0hSSXdDUkJLRytlOG02MEZVQUdjME9aa2FvMkxNYVdkc1ZMME5w?=
 =?utf-8?B?UCtiMWZGaXpLTlVyT0lRK1doY3hKbW1hWGx5Zk1TUnZyWHpBMVBKeDNMOUwz?=
 =?utf-8?B?c1BYWGVjSGdkRTZwUjRoTm40OXduaXBkd1B3RDU3QUJ3a2lFUWMvVmsvUCtN?=
 =?utf-8?B?WkFUWjRwaDdQa1RmZWsvYld1bUlrN2dxMlFEdEtja2Z4eFZRWi96TmphNUVM?=
 =?utf-8?B?bVkvb3hPTm5kNTh6b05mR2FjRlFlT2h5RUFlVm9taEM4TG1GSUlLcmk0YWxX?=
 =?utf-8?B?S2VCWmk3TWhPaUh4L3E5UWptcFo5Z3pKTEhCNFJBOUd0Rk9xdlRWeEtvWHNF?=
 =?utf-8?B?N3BEMjlJcEV3cGdwRVEvR0QvTDRoL2dIQm83bEp5alVJTTFnQzl4M0todDh4?=
 =?utf-8?B?NkRONW1XSUZTQWZONGhnVWdlR0tTQVVYTkhBUk1pTVI0cWd0bHFzRmRKZEYx?=
 =?utf-8?B?Q0VGeDhCaS9iTUV3UFVKRFk4N3Z0dC9DQi9uUEJ6NDlhSXdLQ0hUSHhYWlJP?=
 =?utf-8?B?Yy9EUHNoN0tNcHc5WDR0aGhqUGVhdmpNM3JSVE9UbEI0UUN6dlZKcXJTbnN6?=
 =?utf-8?B?WXh6Ylo0eGQrc3FpK2ZESnlIQlBCaGRKNURZNTVISkhZdVB0bVFYV0x6Smli?=
 =?utf-8?B?c0tjZEx2bHArYURMendBZmg3d3l1MmJXdWVpUlVUMm1uKzZqYldycEJkcmhq?=
 =?utf-8?B?ZVZOQTd2bVFIZDB4MW41YnVJVkloZ3dsK0NlSWdPdnRnNDZiQmZlcTNxeEd5?=
 =?utf-8?B?TUtqRmtFeG5DV01lUVNwMHg4SURkclVRbVJjNVpRSEUyUHVLWVVwbVR3RXF1?=
 =?utf-8?B?dkZESnhuL0N5QWpmaUpXY09LeVZUODV1UEFLZXl5UXZhR29BdXRjSEpFZ0pM?=
 =?utf-8?B?Q3d5YkVudm96Q2tIVU9QZmd1ZGVLZXRGUS9GVWNWdUl3aTEzSUplRHFaL3Fa?=
 =?utf-8?B?em4zZ3ArOVdmZ1NKRENYUmZBampESWtnbWd6OTlnanZmZFJXQW1VbmJRRnJV?=
 =?utf-8?B?UHd0c1VjVVJaQVhkaUhvdS9wMWVxSE1zK3IveGRZbXN6SzZqVHdvU0lTNjlV?=
 =?utf-8?B?bHoybHJzMTlkbWhHT0lld1V2Y0dSYVQ3SVlVRnhXcmpVNlVUMStzTFFaVHNa?=
 =?utf-8?B?djZ4ZTdzbzdDSm9rVUhxWG5VS3RKdjRFN2tHOXByWmhiVzhNMnY1czdic1J0?=
 =?utf-8?B?TjJCQWRGNnZUdGlHemNibHY2a2t2ZzRRaEx5U0lpQUNuK29xNm80NlJTckEz?=
 =?utf-8?B?dXo4SU8xc1VNemoxMkQwRGtmbGtQTVZGSUQ2TWhGNmx0L1FUaUVaQVlPcnNR?=
 =?utf-8?B?M3FiL0NwdEh6bXpnWkNhRzBzRFUvR1ZyUFhZcUxEdDJXc0RhZTFqeEpjenhh?=
 =?utf-8?B?WkNzbmhvdUlEQiswR0E1NTU2bFhRUEEwZmtlK2RJUEVxSWhZMmJTMkRBaG9G?=
 =?utf-8?B?VzN6czRPbDd3NFlrQTRxdmZzWFBwajNmSnZlOFFWR2g0QUFpcVpEY2hnUWs0?=
 =?utf-8?B?NXcwY2RKcDBYc3BaTlVvVE9peE5QWVFuR0hXZC9CYVBhM2lsYXFEZFRtSEQz?=
 =?utf-8?B?RHlXODdaWFVjRnkzMUhxbXVZN3ppWDlSM1puQU9iam8vVTE0NWhpYzMyVmR1?=
 =?utf-8?B?WEJWR3RNcjZHYXJicUx1OTRxU0ZHNlBreHhPMGVmSWxHWGszMzBPMmxsc1RC?=
 =?utf-8?B?K1M5cUo3ZWZ6WHVTVnUxTXdraklTTU5ZT1NrcnBMOWFpNUZyWDRkT1h5RVpX?=
 =?utf-8?B?dlB6dWFUUTFMRWRoZTZMcmVFU3NiYVFTRUp5Y2IxdmRhbDZyb2d1UytkVUla?=
 =?utf-8?B?MzJ6S284RVZsLzFEcHpLdFkzbUtlQW1RamZadk5DNjdDOEtkZmFVRHlFMFFW?=
 =?utf-8?B?V0R0aEhTK3hlODJxMWpxWjFEZmRPeWloNnU1a3ZMYTZHNnJiTTFOWnA5RnAr?=
 =?utf-8?B?emZrMGdGOWs0THpYVU13endLZkJJcFJsZ25BSGtpUUxDcTJaZ3d1dEFSVEZh?=
 =?utf-8?Q?A/B7Ps4tHOQm799hF/kbPYycp?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a58cfb92-e745-420f-6730-08db5bb20dbe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:20:49.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1BA0tFG7My1/71ZEjkzMT4wHFUr9BlRbPt2PZwN68X3CDdISx4h9TVCq6vQMRU+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some chips have two bits (e.g SAMA5D3), and some have three (e.g.
SAM9G45). A field width of three is compatible as long as valid
values are used for the different chips.

There is no current use of any value needing three bits, so the
fixed bug is relatively benign.

Fixes: d8840a7edcf0 ("dmaengine: at_hdmac: Use bitfield access macros")
Cc: stable@vger.kernel.org
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/dma/at_hdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6362013b90df..ee3a219e3a89 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -132,7 +132,7 @@
 #define ATC_DST_PIP		BIT(12)		/* Destination Picture-in-Picture enabled */
 #define ATC_SRC_DSCR_DIS	BIT(16)		/* Src Descriptor fetch disable */
 #define ATC_DST_DSCR_DIS	BIT(20)		/* Dst Descriptor fetch disable */
-#define ATC_FC			GENMASK(22, 21)	/* Choose Flow Controller */
+#define ATC_FC			GENMASK(23, 21)	/* Choose Flow Controller */
 #define ATC_FC_MEM2MEM		0x0		/* Mem-to-Mem (DMA) */
 #define ATC_FC_MEM2PER		0x1		/* Mem-to-Periph (DMA) */
 #define ATC_FC_PER2MEM		0x2		/* Periph-to-Mem (DMA) */
-- 
2.20.1

