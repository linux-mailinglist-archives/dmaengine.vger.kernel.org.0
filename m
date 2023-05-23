Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2375470DCCB
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjEWMnE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbjEWMnB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 08:43:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2109.outbound.protection.outlook.com [40.107.6.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF4C109;
        Tue, 23 May 2023 05:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFFd2aXStZnojCwIxoSEoIU5wtAw9lvlwlfusUbxM3+5S+uzbLISmSozKXoNWLnxcstXj44kT5zXSObKETY9P9W9MOCrO3RSmU14EbHB4fWVVgUS0kyR2tOFeQbRfMMutHz+eq2EfvIhio1UhAFWuynEItCFpNicNNzlc8vawoD35pagg7+FTGUKbV7lrlZBn7IIthginMH68nMykPDEGLkwts87FNpjtnGOWrB3OG5fA9xuR63F/S3FB0nusGy5lWjY9wGd4GKqKsViDGw1RHlIgqNWRpgJTZKj5PXPHioViXctOLEv4EwR70Q6BRUkiEKsSH98YA/6iXpKivSugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXMoADEGlM5mjtizpPzBqbTJlAXv5uAhIfOFZaVODkI=;
 b=laGTkVN4eRXTD8HdQrEpjmnUpGNMZI/eEKcQAh00VmVy6n3kjoADt9cvylbzQZK/nQ4vr2Etn7qFoqHoA3Op72HnXHTUO7/rIaofjWiQlree+SBX38RPh2Oa9zo9MGkC3e4BrrnhfV97FUZBO6z8TCZfwnzHPTMG/Vl1HH7Xa01ZX5zpSJgLVw3XKASJmYWmQF/PHZQu8SgQ+DpOZhAekhDnoN6g3PnDeuruU8CywWiL92D5WaIGppEB8d+aXlCJhorSIQXhQPvheAU2rXK3oTX1mxV219hH/qX7DWJ83jBmNv0ni1CaM7oKIQMmbzbbsclL9YIWJBMn8W8VXINdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXMoADEGlM5mjtizpPzBqbTJlAXv5uAhIfOFZaVODkI=;
 b=goGawR5KTqKWXTvQ66BkIWYu/lNY+1BwfFmFwWM6YGgIQLJ0y4v1m8zFtUtq28dtCnvKx1Wm7+slmq/3+vPHq06sV/Kfb2RfKfP+JaygyVzMVFDZosZR8RucVCrK4cDFTN2OF8iifYqaCDbCt+MaAis+exxcarl7hpuAnFV6gcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by AM7PR02MB6145.eurprd02.prod.outlook.com (2603:10a6:20b:1a2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 12:42:58 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 12:42:58 +0000
Message-ID: <5070ac45-2f91-c9d7-de7c-31d38750015e@axentia.se>
Date:   Tue, 23 May 2023 14:42:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
In-Reply-To: <dc4834cb-fadf-17a5-fbc7-cf500db88f20@axentia.se>
References: <dc4834cb-fadf-17a5-fbc7-cf500db88f20@axentia.se>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] dmaengine: at_hdmac: Remove unused field values that do
 not fit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB4445:EE_|AM7PR02MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1d93b6-c021-42c1-b9e2-08db5b8b3cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3zTRBXd3fthozqvhiXQy/DK3mZPIu/p4jEryZhaFgjm+dQoUqvrWwOrN6BhAaaxaB3QFZ8x9Hdg3kn1b2yKWIpfCGWCLPMBF9VNwp7K5KZUYm0ZThrI9UpuYIzDebfm3IbMQh14mTx7obBaTFDq2y7+pW04uIWfeg9QLPLMHPweSvQwTeNzyMEveNZ/ujAiFeI8Ef6mVoZB73DHvRixAel/boc0LNAuvFahuLF83x9cGRiKlzQevjedwZNwizotMRLf63cvATXUzlTMQbWBjsi6iHkhMTH37Sd18yjyBzFZaPaBqC4K3gySCFgQcyIun4dciVjDfXOen73RaTycKXFn9Z2f3jm4kBwBipleY4aNm9czVnnQe5lY813/1bwNCkasMNBiCZrdSRVP961oPIJRWY/fpG/SeZN9a0ai0d640NnWYrqwg8EBkISuGjOIpxcHsDJkMqHmfgunBA84YdHTmey8y50BmGTUC6A1prAcrLHWRvyszClpEEJYl9/dku3Fj0cbhWn56NsTzT492jaEoOaM2ELnCDQHTXwDp5SbYHzSwsnFwCFZk885rpvIUF0NARs1+Flp+l7Qyb/BgZgEW1+dW4j/D63sBFot/k3LoLwsEf3ljVDg6h1oZflNAIBBOdv6RLRjMKK8vy8mNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(376002)(366004)(346002)(396003)(136003)(451199021)(54906003)(86362001)(41300700001)(6486002)(31696002)(31686004)(478600001)(316002)(4326008)(6916009)(66476007)(6666004)(66556008)(66946007)(5660300002)(8936002)(8676002)(38100700002)(6512007)(26005)(186003)(6506007)(83380400001)(2906002)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGMrTitXaEpsb0t2TFhJdVFTMDdlNlJOR3VCMWhLRUhFS1p4TjdQcVZwVzdH?=
 =?utf-8?B?MlRQTEhkNzVQem9hWERPL2JFbTlpSVVDSnFubnFhTmllZitUcFljQVNVL2Nt?=
 =?utf-8?B?ZHhHM0FmS3ZVdXJiai96Q2NDRHZtVG5pODhoRUIrYTc1Z21GcUdYd1hLSmgr?=
 =?utf-8?B?S0o0NGNwRk5sQnUxWUY4L0R1ZTNnK3RYUmJTV3Z6TXBya2RvK1hRWjFoTkk1?=
 =?utf-8?B?RjVKWWxhVXZ1UDJ3Q0VkQXlxeFI3d2Zqc3phdm1uSGRhSEgzUWZVcWEreGVN?=
 =?utf-8?B?bVZPbmpaQ1YwWVhFa210QlNIZXQ1Rmwrd1hkKzlxT2dmd2g5Y0dSV0pYK2Nh?=
 =?utf-8?B?V1RTZ1VONnlMM21tZnF2R0UrYnkxTzduY0l1RVF4bTdLUzU3aVBkQjRQam9J?=
 =?utf-8?B?NHFHNjJqMlpKNWFZa1VuVGk5UTJrc2lWYjNCOVFGY3NlMUVjWUE5N3hMU1hN?=
 =?utf-8?B?bEpnbFF3Vjcrai9vaVowWDV5Z0l3a1R0eXE5TEFlRXN5OEVDUFZWUllIRHBF?=
 =?utf-8?B?ZWlnNlF2MnRKVitNMVBHZFVVUERscUE4MGJmVWdYckNIREpiR3p1Sjl3OS9R?=
 =?utf-8?B?Qjl0SFdDSWhlV0ZJNmxDSXJDeGUrdTF0NW1QdzhTV2Z4ME55OEFBTzhaTnpt?=
 =?utf-8?B?NWRSTzJIQndqb25JNUpybGEyb2JyblphbGZzQnBZcGxrZ3VTUG56K1BnMkI4?=
 =?utf-8?B?RGxPY3BpWDBvckUyWVl4VzFiemJ0VXdkNUdTVXhQa1lqQSt2c3BTTUFsY29h?=
 =?utf-8?B?ZVBQNDRRTmtBd2dDN1U5UVlsazNRYVd6MWpIbGwza0ViZWgwbUwxRDN4U0Q0?=
 =?utf-8?B?NG9YNitIM0RNbVdnanlrVllJemNmU1ZYa3hRamNnSUQzdS9CTmttcDZVQUJW?=
 =?utf-8?B?MkFCS01tSGVWNnhNUmI3anFNOWlzK2RFbkJyMXEyQU1iVXBXbE5HWVhIV3M2?=
 =?utf-8?B?bGpjMitUSUNEZjFwVVYrWWhrZWdQMTEyUXZobDdRR2pQVUpCWXVOUDJKOEtZ?=
 =?utf-8?B?UW5hMlJodnRnZk41NmttUjhLQnF0cm1qR3kwUEhWWDVobm5oWU01czVJZXdt?=
 =?utf-8?B?emxhb1AybGdnSExyRkxOOHJ0Ym1vc1BhZTFWQXFIQS9yOERaMU9VaC83bUVD?=
 =?utf-8?B?QnZOdEl1YUVVV2pTSkdrRzFMOWhDa0pqYmI5RGR6d1JQUzcyT3FvcGN2b2pL?=
 =?utf-8?B?M2xDRGlURk5WTTN1SCtmRWpaYmJBYmx1ZFNzbW1UVVl3YXlqMldSR1ZlUzNw?=
 =?utf-8?B?TWtRVUs2SXFuM2tLbndnSEFJTi9jM00wZFQ0bXBxMkVUa3doN2diaHR1MkFR?=
 =?utf-8?B?NUROWUV4WFFFOTVMcGZBQTVmcnBhOHNueEo0NjFDZkNDYVR3TGNzSkllUVB2?=
 =?utf-8?B?cGNGRmRHc3V1QTRBcEZiNWRSTDI1WjR2WjNPMzFDWXRSNFU3ZVc5ZmZwMkhx?=
 =?utf-8?B?Q0d4THJpL3V4NWpMUGJlWlZURTUrcS8zb3d1L29LeWs3OTRuZnp3dUtsdEs1?=
 =?utf-8?B?clpLY2cydU9CczRnM3l5ZHNxVGRrMHdZMjE3aC94Z2ZzSXRrWDJwcmZOWG1I?=
 =?utf-8?B?aEZTeUdxOGxNZGZTS2NZNTdHbFpGSDdSRjRnb1ZiR0xYVTNOWDBzaWhpNVBz?=
 =?utf-8?B?eWxGNGs2RjFha1NZUEJnYkdiRWswSWt4WFVJUWYrZlE5bTVyYXMzczJ2QVl2?=
 =?utf-8?B?YkEwRnVjcXlyZzh2VTJ0a0ZydndFV0p4Q21NSVNFd0Z2UEJvbEUwelZmZlU5?=
 =?utf-8?B?MmtPSkhORFU5OVpSRlBlcm5mL0FMS2lJdmtUQ2tjRUR1Umx0V3dFZk8yajJw?=
 =?utf-8?B?MVVISGdaMTVGU203VllUSHU0ay9ZVHdPaytqUTBzZ1dHN1Q4ajFNbFQ3YU1X?=
 =?utf-8?B?MGVhR1FFYnBWazlNZk9YVkQ1VVpCc01qYTZqd2p5R1NuU3dUWTBVWHNSRWNT?=
 =?utf-8?B?WG9qR0oyT0xuZ3RyOE1qbUt6bDZpb2RXODBpUVFQOGxtRDZ1S0FVMFRWY056?=
 =?utf-8?B?eG9HQnlTTm83VUhqRlhUVVZhVTVLU1lFZDI5eVEwSEhBQzR5VlZUcVFuUysv?=
 =?utf-8?B?aW40VHhPRWlJR081NWF5OXZnWk91ZGw5bHlsd1B5MHVLR1hjSXJpY1BUSWpD?=
 =?utf-8?Q?fhkenyqf8eZlrCUcm9Vj4Y4mh?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1d93b6-c021-42c1-b9e2-08db5b8b3cc6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 12:42:58.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrEOhzMP57cKUcNboxYpqUI3YwCE4XN6DgvIo3vBfRJtdHhfKjVL8PjsdIdtv8Nq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The values are not used, and they do not fit in the intended
register field (ATC_FC, 2 bits wide). Kill 'em all.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/dma/at_hdmac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6f352160bc3b..51d0a0c7aaf7 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -137,10 +137,6 @@
 #define ATC_FC_MEM2PER		0x1		/* Mem-to-Periph (DMA) */
 #define ATC_FC_PER2MEM		0x2		/* Periph-to-Mem (DMA) */
 #define ATC_FC_PER2PER		0x3		/* Periph-to-Periph (DMA) */
-#define ATC_FC_PER2MEM_PER	0x4		/* Periph-to-Mem (Peripheral) */
-#define ATC_FC_MEM2PER_PER	0x5		/* Mem-to-Periph (Peripheral) */
-#define ATC_FC_PER2PER_SRCPER	0x6		/* Periph-to-Periph (Src Peripheral) */
-#define ATC_FC_PER2PER_DSTPER	0x7		/* Periph-to-Periph (Dst Peripheral) */
 #define ATC_SRC_ADDR_MODE	GENMASK(25, 24)
 #define ATC_SRC_ADDR_MODE_INCR	0x0		/* Incrementing Mode */
 #define ATC_SRC_ADDR_MODE_DECR	0x1		/* Decrementing Mode */
-- 
2.20.1

