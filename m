Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BFB70DCC9
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjEWMmz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 08:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbjEWMmy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 08:42:54 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2096.outbound.protection.outlook.com [40.107.241.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8203DB;
        Tue, 23 May 2023 05:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqsa6bPwuILaZS3EATgBm2j3tmb7tvnfQieQqM5221599MMmxRTbwoLOAYBzbmfTijWQJqRE76kh1zklQz1JDappLXrItXAWMG8Pi5OHVr99L+RhH07XQFOdEo1efABn1aNrCa4GGbJ9hXxOT74+3mmuBjcPjAEulGjpZT4atPrJQvYvQyhcxTLoKO53LpgUdfbgFGvlr64xXxioesOzjjpdPgHAjk+COLPYHjb/KCv9bRl8z5MCZ74MeSR3N8ikkXpsvr7DqUN+8UjU7gIAKF9U3aieMNaO5T1ioU47uWR1h4Yb8ayQVf1L0gM3hL7pOtejxxSX/zJ6unh3rSxqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6LT9hG7keXQQuPSIBJDRVMCRJh1FSVbS5i14LstFSs=;
 b=hNnaKubn4HuLVYC3j39okB/Xy5Q7Fa/mJVWsgRj09twXPdc7slzUhyIGzi+e0lLfDEgHAAvXosfvcxm4XnTrDx0hx5YIFC37ziM2VcEAIz1eyNM35Ml9OtO7rwIlM0Slrdi4p0RYb/EMYCkDS4ncduszPXfb37RmPMAm/+4J+B/MDWVSTkBp3iBygmFDwXH61LviVerwvNr/cLT5Via/N+E1n1Ux9LZoFZKWRsiP5JJvBVUGyansXhorIhS37hFAwQXBvc+WFSq6cADCTz7gXviWLFIQpn79zWVR6cTPeeQoU8lW9+J9vS19P+YjCBc4njQdMQFc10diMVQu/Cjaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6LT9hG7keXQQuPSIBJDRVMCRJh1FSVbS5i14LstFSs=;
 b=R3gSe8U/sQFVQlRCilu/qp7gtZ84V+caNgDZnVaECqy75/g+XphIogdqbmK4BOwhPuHNIOTZ3+HHE5gF0ovHHA/xjNF68T8sKlZNKXpNTTkt8CFqwsu+YQP1nWw+yDFqB0fIkVbBW4Bf56VH5Atd9dJqNFmxbX8N/uKXjr+596Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by AM7PR02MB6145.eurprd02.prod.outlook.com (2603:10a6:20b:1a2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 12:42:50 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 12:42:49 +0000
Message-ID: <68b70631-07b0-f4b2-463c-b8d3c7b9dac3@axentia.se>
Date:   Tue, 23 May 2023 14:42:46 +0200
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
Subject: [PATCH 1/2] dmaengine: at_hdmac: Repair bitfield macros for
 peripheral ID handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::28) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB4445:EE_|AM7PR02MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 219d047b-41b1-4e29-6f22-08db5b8b3794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRv+PqNN9di3IpiPrWYjcut5Od8FTJ85gsMcj/OwXREdsZ2r6Me1+WVdJRW+yg8+ut76dNVAwlxbD164t1nSnLdyTVi9AvMCU18pzXS2YxcGs298iq3L8viFeRa+C5OUOVpkvOWj7iiMz77x4waIV/DUYFMTiClv24KS5P4QGYh8SF+TnKLAVqn9PKETrzKOubAPRR0mNz4EZSnmkiwudHO1gfMmQM/I1sWvtnCRNLak22koiB0YaMJixkR7kC92nN3KhqHrPSwITJT19ztB9XDg/Ogh2AOxQMF1hv/p+c8JYHbArvkZLsiJJ88YELYtJh1wkAtJMmCTA/b29554MDnpIUkfFfEJ2nrAVBeUvjwDAc0qv8Qz380MS8BpU3/VHclVe/fOSXeduYJLAn8hobZjuxbEcQPbmgwIHqML4KDQkJEzYsPAMHn/A6VQMiZYXJfpXMQgqXVt8ASqrp5Xk5xOZnSAmjX4jSWnQqG+JpV/EopE6OWNU5PmQbGEbLkdEjHmvin3tYmpW04ItFhPai7ELMT19OfRtDL8mkg+iixB78idT9DcOTV0fQEjLMjDe3Fb3wL3LmWVDeRoyX+QDO9Bglj5XjgEEjG2UiQ3YgX/tZSopQlqH4QV8d9AoAxnrKRiSXQDCjJctL6i1pL7mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(376002)(366004)(346002)(396003)(136003)(451199021)(54906003)(86362001)(41300700001)(6486002)(31696002)(31686004)(478600001)(316002)(4326008)(6916009)(66476007)(6666004)(66556008)(66946007)(5660300002)(8936002)(8676002)(38100700002)(6512007)(26005)(186003)(6506007)(83380400001)(2906002)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmlYZUhCWjgyM2VzaldXZE00Z2FqcDc5WjdSeXpCanNkN3BiaHh5UE83V3Jj?=
 =?utf-8?B?WW5LOGpvN0pid1RCTjd1SjU2c2tWczJkUmZUQ1VKbS9GUk5MSWpxZGtMV0pq?=
 =?utf-8?B?YnQ5a0EzRDVNallIZFg0T05ZOWhjejNzbkw4Um41VGducU0vRHhvWXk3NXVV?=
 =?utf-8?B?T05HbHNBejNqWmVIemhHcGJMT05RYWVBUHVESDlaUDZwdHQ3WEprL0ZKcWRl?=
 =?utf-8?B?NnFyaVpVSHVBb0kyQ2hzSGN4dnkwM1ZCeXFzYU43YVdwNW1EOC9zTXU5K1NK?=
 =?utf-8?B?YzBCMm9TL2pmQy9la2NrcUZHa3pud2pUdkZTbzUvQVVFczcvSE85RmNQVkpI?=
 =?utf-8?B?enY4UjEzTk5oQS9YNlM4UHFqb3Q1Vlg3cm9pbHkrSzVFZ2JxWk9aYXhlRTM3?=
 =?utf-8?B?cUMwRGlmUit2MHhOUU1VU0l6MVJiemlHQzczR0dzRFVPQ0RQcERZcERUTzU3?=
 =?utf-8?B?ZE5wQWRqcGdjWnRLbm1aWEpoQkpRekdocmVQbnI1OVFjL0FXcHZwSEdBUWZp?=
 =?utf-8?B?T3N6cWVxc2pESnphNE5OT2xrdysxQng3N0VGV3U0MzB3M096WDRDS2Y3MHJQ?=
 =?utf-8?B?U3VOWlRlejVwUGYwOGxFMW5KbStmWG0xNzYvSTFlSU1KK0ZSVzc4aURSY1hP?=
 =?utf-8?B?eHdDRmIvTGhpK0JTZ281dmpOdEpSOFlzT0ZNNXd2TnBHZlFFZDk2d29qN0RN?=
 =?utf-8?B?OFJ6U0NrS2ZiS0gxZGludFhpTUZYeE1oeWNiQzB2MzZ6aE52ZEVNcG5mQ2gy?=
 =?utf-8?B?cUxFS0dEcTJmOXZmSGVPc0UzaThrUnRaT0lWa2Rkblh1SWUvYmVwZUMxVUwr?=
 =?utf-8?B?d2phL1BuOUorNk53dUpGS0h6VjQ1TkxGcnUyb3NISnUvaTNNVElzSmNwV2VO?=
 =?utf-8?B?ckMxWVd2aFlGaXpZVnNjcHNhS1AyY1hrQVJGaVRaekxxL2pOWURRWmtWWGFB?=
 =?utf-8?B?T25BdmgyOEZsQk04bFlHQUl0Z1dEZmJvZTluWWx2WThTU29xZVluT29yR3Vl?=
 =?utf-8?B?RkJuY05VYTJYa294OWJHbWNvdFg0NVN0MWlNcVlkNFB5N0QwM2puZ3VjV0sy?=
 =?utf-8?B?QjhoWURjV2N3d2YrNnM2MFJDZi9ZMnBCdFI5SzA0a0tBVFlZcFk3b0hPV3ZX?=
 =?utf-8?B?UHNrTjUyRlJJOGEwb1A0MDdzbkNQOUNhdksrRjliK2pIN0FwNU4yUDJJTzE0?=
 =?utf-8?B?YTNqcDNnQ2tYaXBqUTNTekIrUG5QNldORitCYTZwMjRSRG42U0ZEenBoK1Vk?=
 =?utf-8?B?MFZiaE9yTzAxbHZzNDUzOUJUN2N2cTJqR2xtbElheC9nd3REZ1M5VDhtaTV5?=
 =?utf-8?B?MWp0RWVyRURqNEtDR0p6QXAwTzJnUW9KNGMrZ3V2SFA4ak11RzFMUVpNN3BK?=
 =?utf-8?B?SkttRHBPcFRsK2dwR0pFOEJZSGx1NkM1MjVETWo3SlN4dXBDVkN1enZib2ZX?=
 =?utf-8?B?TEhhVnp2Sms2NWNvZHpnajZnQ3RRYjNtWlNkNlJFODFVSklkSTl2RmoveUhN?=
 =?utf-8?B?eXFwZEw4UU1JaVNkUHowSVFpRCsyWFdGckg2OFRpeXd4a3BZR3UrTi83bnNz?=
 =?utf-8?B?dzBoWFc5aFNGUzRkNGFSdWxaSkMyank4eENXWFYzUjFWemo4WFRKRGtaY1h2?=
 =?utf-8?B?SUs4Skp4M3JESldLbml5cjk3Vm5BMk4vUmNLb1VCRmZxOXF1MzR0UFNkR2xs?=
 =?utf-8?B?REozUEwzMnhjZjNGZFI3eGFUQXVSWUN4NEFxOGlMR0ZHRTRFVndPSUVIK3dB?=
 =?utf-8?B?eTZiVEczWmdCTkRXNTk4a0lUNzlIbGFKcXY1ZmR3TzlNQ2ZEY0FGbFJWUDRN?=
 =?utf-8?B?bVBoSGc2YTNmNUt0UVZSZDl1UWNFQTlCU0RBKzhOb1JDdHBCNG15SEErQTc5?=
 =?utf-8?B?RllQUCtIL0VnZHVrWmd2ZllSem10TVRWNUEwS0VGbW9GeFBSMjFjWlJtYXox?=
 =?utf-8?B?VHdrVXFEMENOWHJkdGUvZUdXRlVuK1lTdnhIL2Y5dXBLdE5Yak5LRGhCbDVq?=
 =?utf-8?B?RGhyV2RqcmZ4WnBZd2FaRTlwM3BFaUVzL2RaUExmZVdCNU1xV3VscGljTExy?=
 =?utf-8?B?a2U5cEJ0ZUErOXRWdXUreEJqaS9sbzlUQVBZUURvaWF3SDliT3lucWtIYkhU?=
 =?utf-8?Q?1TtqTffhEALnwpCJoKi4o223G?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 219d047b-41b1-4e29-6f22-08db5b8b3794
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 12:42:49.6114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAtyQ3bYSkHzqIdxoLH8HjD8sfjpScDfGMMYC3bkrlCZhdGkK3+5LORWLQuJ/A3f
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

The MSB part of the peripheral IDs need to go into the ATC_SRC_PER_MSB
and ATC_DST_PER_MSB fields. Not the LSB part.

This fixes a severe regression for TSE-850 devices (compatible
axentia,tse850v3) where output to the audio I2S codec (the main
purpose of the device) simply do not work.

While at it, rewrite the macros as inline functions to evade checkpatch
warnings about argument reuse.

Fixes: d8840a7edcf0 ("dmaengine: at_hdmac: Use bitfield access macros")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/dma/at_hdmac.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 8858470246e1..6f352160bc3b 100644
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
@@ -181,10 +179,7 @@
 #define ATC_DPIP_HOLE		GENMASK(15, 0)
 #define ATC_DPIP_BOUNDARY	GENMASK(25, 16)
 
-#define ATC_SRC_PER_ID(id)	(FIELD_PREP(ATC_SRC_PER_MSB, (id)) |	\
-				 FIELD_PREP(ATC_SRC_PER, (id)))
-#define ATC_DST_PER_ID(id)	(FIELD_PREP(ATC_DST_PER_MSB, (id)) |	\
-				 FIELD_PREP(ATC_DST_PER, (id)))
+#define ATC_PER_MSB		GENMASK(5, 4)	/* Extract MSBs of a handshaking identifier */
 
 
 
@@ -1780,6 +1775,32 @@ static bool at_dma_filter(struct dma_chan *chan, void *slave)
 	}
 }
 
+/**
+ * atc_src_per_id - prepare the source peripheral fields of the CFG
+ * register for the given peripheral handshaking id.
+ *
+ * @per_id: the peripheral id
+ */
+static inline u32 atc_src_per_id(unsigned int per_id)
+{
+	return FIELD_PREP(ATC_SRC_PER_MSB,
+			  FIELD_GET(ATC_PER_MSB, per_id)) |
+		FIELD_PREP(ATC_SRC_PER, per_id);
+}
+
+/**
+ * atc_dst_per_id - prepare the destination peripheral fields of the CFG
+ * register for the given peripheral handshaking id.
+ *
+ * @per_id: the peripheral id
+ */
+static inline u32 atc_dst_per_id(unsigned int per_id)
+{
+	return FIELD_PREP(ATC_DST_PER_MSB,
+			  FIELD_GET(ATC_PER_MSB, per_id)) |
+		FIELD_PREP(ATC_DST_PER, per_id);
+}
+
 static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 				     struct of_dma *of_dma)
 {
@@ -1812,7 +1833,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	 * ignored depending on DMA transfer direction.
 	 */
 	per_id = dma_spec->args[1] & AT91_DMA_CFG_PER_ID_MASK;
-	atslave->cfg |= ATC_DST_PER_ID(per_id) |  ATC_SRC_PER_ID(per_id);
+	atslave->cfg |= atc_dst_per_id(per_id) | atc_src_per_id(per_id);
 	/*
 	 * We have to translate the value we get from the device tree since
 	 * the half FIFO configuration value had to be 0 to keep backward
-- 
2.20.1

