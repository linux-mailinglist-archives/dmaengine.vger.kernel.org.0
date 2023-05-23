Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57970E324
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 19:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjEWRUp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbjEWRUo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 13:20:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2136.outbound.protection.outlook.com [40.107.6.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D990;
        Tue, 23 May 2023 10:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n47gtomelcj011q0pxUkpwpCr8adDTDMB4Tfx4ql5IFCGjM6HbWF5M596oig5Iue9mLFajraCLhbvsw5PUHs++/VssXyRvGbrQms2J1LxkuY4osdQ8OnlfUV6n2fjrW+5bI4YFnObH3/ulkCME3oPKUrNSUJJejIPHbByH8oBj4u6LFH0AQHSk6CI7+CItyPrqKoCqXxUbhcyJccQ7lYEM/8qdmPRCm8s/JB7Sm7sRxgfTSAs8XSCJVN5sMdmiAIMrnE/hbGtaTYx5o8+MAjoctNL8uggFHLumVZkQWbnRnr0gtq0wFI1dyfSQxOH52hxstGyegzn8JlBsj10Xo80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB58yjEPuX4C0k3fpbaGhxAt2iJZZExBLlkMV7jNHH0=;
 b=X1VCwAtVMi8g5b+94rK+FoRQ+OnnlL0Ac9SlGxsEP1vS67UFDH8GaEtqoW+InnOfSQVY91jj6lpt9IuAtpnMPN+cVLgclmz29dVKcUt1tqyU9Qxckiakv1/lfOv3EwpIlb7lyjet8B8J8f5e+gstRvaH6Ef4PGSZtNHKA0iQi8jLhdtbS+bgbrNGPyrzL23nNKJr0PmhZTj4wd0eywFDAZP115Wp29qIuKlgIavezjDm2mJ33dXRN3hcYnH+c85sckHBULAqBTGp021pcqX0MXKrpM63Kw82kHI4QTY0tANBTLkWDB3mg33DmcfHYUwRlWZ1Gkk6GQQtlauURSF3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB58yjEPuX4C0k3fpbaGhxAt2iJZZExBLlkMV7jNHH0=;
 b=B5Mpcj2Lbot2Hs98haHHVWnSb1d6JGEDggTvpx8kAS7k9twt1lYewqBxsuHI8iIu3KSV0/C3D8UkVKcQ6w4U+0QW/R1sYl12ggfvlokG7W5qsJV4pN1g+ug6DqEPxPMaxzEjw8+jTRwUyUanZDupgiJvIHWEHt7CCIjnb3j5EZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAVPR02MB9205.eurprd02.prod.outlook.com (2603:10a6:102:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 17:20:40 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 17:20:40 +0000
Message-ID: <01e5dae1-d4b0-cf31-516b-423b11b077f1@axentia.se>
Date:   Tue, 23 May 2023 19:20:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/2] dmaengine: at_hdmac: Repair bitfield macros for
 peripheral ID handling
In-Reply-To: <221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se>
References: <221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0071.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::25) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAVPR02MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d11365-e5eb-47ac-71c6-08db5bb2081e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXY3oiOC6APCUKfbN2Nm7ihJ4e+GGM9RT+N8mqIzs0tT4akpD5PlcO+WNDhncsRckydpbuobixOMDuC3rlD77Oqv6CEcZStPrhG1ZaI2cfsh+aEJ7tbvrPfSHaXwjkhor/f+ceUYpwaWUOIjpg1d9pj9Yu++uHXc5mesyBiWRI5R/sTaXzQ5vLetEA+NTc/yEBNjqzaGXmQ4AbJwOwSMDtDluJgIr0xS4IAlYheuOf1LLnRRKxLOxp1EDfBQhxd3WobTw/OSz0P+5mTcx6AI/6VGVuB1Gxxw6XjK1mPvwfpRXXj6cJ4j1oCQiRwBPQe+dkN9cCckWApOQpFx2S4cuY1pjutCjtCaxYvqKzyEO5Sl9AvrBNwxzafMLCe0co3piAlqbFdhR9dwL/fPf3XU6/5PUpXUTsO0crZPf6GinJlKiiZJaL1bMNeO4PbXdW6x0e0BQJATW3Tk+v+OfHv8hB5QHe1hRz7DAPVKXR7AvP8X8vk3TBEjQEfZJag9ZMXM37wcTsIpPw5F0jpXibme2iw6jgnnAu5PznevV+U6LEax6FnSrfagGqCGNojaeRYgrUQiJdqoVoBdHyrqX4gvTKLW8tnEvMq1Rxqw1MKmeDkw3L5gNldmWl9HTkKvs7VznKLId2Dl+WHCn8oENHH+nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39840400004)(376002)(396003)(136003)(366004)(451199021)(8936002)(8676002)(5660300002)(186003)(83380400001)(26005)(6506007)(6512007)(86362001)(31696002)(2616005)(38100700002)(41300700001)(6666004)(6486002)(66476007)(66556008)(66946007)(6916009)(4326008)(36756003)(478600001)(316002)(54906003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjlCc3lxcFdKZVRGYmk2N29qdHJibjhFejg3VTQvdHpCSnh4aDFnZVdDMGM1?=
 =?utf-8?B?TUJLQVhGdTBwVW4yWW5qa3RWa0xvKzdONE9CSVVoQWZSd3BxcGdOV0o2czZq?=
 =?utf-8?B?QnRUWGd6cERIZ21sTkg5akd1cXJrWStPenB5cE9LWEtkRHRzZFQrYmVkZ1Ja?=
 =?utf-8?B?KzI4SlE4TURIK0pjcU5mTW9va0daVmFBL0VWWHRDVUdoMy94d1BjL1ZDZTRT?=
 =?utf-8?B?VGFaWUM0QVdNVk91V3ZPRjIwR2w3V1grby9jRTRaWEhuZ1hsYXJoZWNTRTJU?=
 =?utf-8?B?NCtYTG9CQldwS05CdENIR0xHQ201TlJ5aWllZld4S2VIQmp0SUR3aHd3OVRk?=
 =?utf-8?B?UXVrelg5TFVUK1haVkpONGM5UGlpNFJoSU9mQ3pERGN2ZEtsS3hlaG1SQUg1?=
 =?utf-8?B?TWNnTGo3KzJXMWdYdWh0WkdVVnhUKzBxMlp4S1IxZWpzOWJZcGRwSjM5MWY1?=
 =?utf-8?B?UVEvaHRSUkpvanVyMVY2b21DZ2o4NUFxVXJpS2hUTURGaXFZSFd6WWl2YVN4?=
 =?utf-8?B?ZVI5bEljNHZIUSsyVXVvWTJyOEY5ODBPTGJpdEw0bVpkbUxNdi94QjZPVm9S?=
 =?utf-8?B?alNQcXFhVW83UlFnSkJTSUQyL0xUcUJqUzM5aUI2UndxMUFiRjc1QzR1akRE?=
 =?utf-8?B?ZEcyRTA3Zkh0MXNhUnE5clM2dmp2VytvbXk4QVdPdjUyYlkzRFo5WG5pQitu?=
 =?utf-8?B?YnNieTZxU0VqVVdHUGFRV0hPNy9pUW5Kb1NTaE12dGp2eGRXUHF1Z0c3RW1G?=
 =?utf-8?B?ZnhyM0RRdFRyQnRuNm5oSVlreVNGREVFMkJzeTdEY3FWT1F2S1F5U2V5LzNU?=
 =?utf-8?B?STdBOXgyZ1BHTVhySDN1Nllpc1p4YWFOdzgxUUt6cGY3eFZvdmEwbkJwUm1D?=
 =?utf-8?B?WWFYbGZ2WE1meWFIK0ZoSTI3cktVQlJkWFdDRlVUWXJ5UUc3VFhtYXF6andO?=
 =?utf-8?B?RGN6SksyNDlEYUVRNFlSbnZnYWpXTlNNbmM4Q3BEOWVQbGxROGVWTlNDY25H?=
 =?utf-8?B?VlZuOFVNNlQ4MVR5YzB1Q3J0R0NiUGx6RVpzcnZFREpIY2pUdlFXcE1PTTha?=
 =?utf-8?B?R1Y1UGoxL3hqaEVDUnVGY2h3MFBTQWpzU0tONmdXQjVSQTZBdGxpOVYzRWZL?=
 =?utf-8?B?M25zamw2OGV1TGNHbDJqQVpKMVl2SG0yZjdyc3ZYR3F5Qk5OWDZMOFpsVXlK?=
 =?utf-8?B?K0pRRDRQZ3FHNmdwajEwaXlqZ3k3cUNKM1FkcWlVcktCWU9udlJuTUZENnh5?=
 =?utf-8?B?alE4SzRXam4xbWhnNUh3d3YzTGdRM3NWQjFSNzhOVVQ2c1ZYTUVCNzdsSkpq?=
 =?utf-8?B?aGZuZENMSU5MVHNQQVZqVm1ma3NnaUdjR0J4SWNlbFg1aU8wWDNUMDFDMXRI?=
 =?utf-8?B?c3hHemlNbmdSd1JINkVFLzhPTzBiNzBpVmlaVGh1Nk5hakNIL2UrNmY3OG91?=
 =?utf-8?B?VzRWMGNxMzBTVk5jZE1pSCs2aTJmS3hwWjNXRkJCb2x5Z2w3dWUxS2ZTcnJ3?=
 =?utf-8?B?RjN4Mk5rVDFjWkpFbVMyYVo5ejM5ZHBwenM1OGtSOTFha0RaeDVSVUlSenRw?=
 =?utf-8?B?L2pVeXJNMGVIc292ZE1rQWphMEpYRVFURmJXdysxZk10UzdhbVJhV0NhOEk1?=
 =?utf-8?B?UEdOSkV1R2dnVXU4WUZRUEZPdldOVWJ3a0NvUHBTWTNCRDJFTGk2dVFIUTFt?=
 =?utf-8?B?SStvMnB3TXhwSGgzekJ2S1NvMjZIdmZxdjdUOWV6dko4Q2xZNEpmOUg3aXlW?=
 =?utf-8?B?WXlNRWU2VXZnQ3F3dTBabnNGOCtHOFNUejEzZnRyRCsvK1czaSsyOGRwZXlZ?=
 =?utf-8?B?ZkVkaG8weDFGaVJuZjVOMVQ4a3B2a3pqOVRTYjJ2VVNXUERGVVBvZElYVjdF?=
 =?utf-8?B?MUJGaWxpQ21CWGxraWxsVXRmWW0zazY4em5WNytHcU9OaVFCUXRVMDJHWklQ?=
 =?utf-8?B?S3dHZ0hTOUg4NXpsVWltTnRVMHRVU3NnYTY1T2k0Sis4TzNabFJDMHdBeFhJ?=
 =?utf-8?B?bFJ5QWRIU3pWdElyM01jWVEzaHNaRlVZWVppcS9wRTlNMnJybjBMTkhKa1Bu?=
 =?utf-8?B?MktIRjdjbFc2a0p0TkxKZzltVnk4WDBWek9ScXNUZFhuVG5ZZm5RZU1SWGVC?=
 =?utf-8?Q?8u0muGyVMdGt+hrJucEuezgyX?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d11365-e5eb-47ac-71c6-08db5bb2081e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:20:40.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgJlz3NgaJNayRtroz7AtbT8cWywv99pdskEbcucHomWvV0p+seXPv99CaWSj4Zk
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

The MSB part of the peripheral IDs need to go into the ATC_SRC_PER_MSB
and ATC_DST_PER_MSB fields. Not the LSB part.

This fixes a severe regression for TSE-850 devices (compatible
axentia,tse850v3) where output to the audio I2S codec (the main
purpose of the device) simply do not work.

Fixes: d8840a7edcf0 ("dmaengine: at_hdmac: Use bitfield access macros")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/dma/at_hdmac.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 8858470246e1..6362013b90df 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -153,8 +153,6 @@
 #define ATC_AUTO		BIT(31)		/* Auto multiple buffer tx enable */
 
 /* Bitfields in CFG */
-#define ATC_PER_MSB(h)	((0x30U & (h)) >> 4)	/* Extract most significant bits of a handshaking identifier */
-
 #define ATC_SRC_PER		GENMASK(3, 0)	/* Channel src rq associated with periph handshaking ifc h */
 #define ATC_DST_PER		GENMASK(7, 4)	/* Channel dst rq associated with periph handshaking ifc h */
 #define ATC_SRC_REP		BIT(8)		/* Source Replay Mod */
@@ -181,10 +179,15 @@
 #define ATC_DPIP_HOLE		GENMASK(15, 0)
 #define ATC_DPIP_BOUNDARY	GENMASK(25, 16)
 
-#define ATC_SRC_PER_ID(id)	(FIELD_PREP(ATC_SRC_PER_MSB, (id)) |	\
-				 FIELD_PREP(ATC_SRC_PER, (id)))
-#define ATC_DST_PER_ID(id)	(FIELD_PREP(ATC_DST_PER_MSB, (id)) |	\
-				 FIELD_PREP(ATC_DST_PER, (id)))
+#define ATC_PER_MSB		GENMASK(5, 4)	/* Extract MSBs of a handshaking identifier */
+#define ATC_SRC_PER_ID(id)					       \
+	({ typeof(id) _id = (id);				       \
+	   FIELD_PREP(ATC_SRC_PER_MSB, FIELD_GET(ATC_PER_MSB, _id)) |  \
+	   FIELD_PREP(ATC_SRC_PER, _id); })
+#define ATC_DST_PER_ID(id)					       \
+	({ typeof(id) _id = (id);				       \
+	   FIELD_PREP(ATC_DST_PER_MSB, FIELD_GET(ATC_PER_MSB, _id)) |  \
+	   FIELD_PREP(ATC_DST_PER, _id); })
 
 
 
-- 
2.20.1

