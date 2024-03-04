Return-Path: <dmaengine+bounces-1236-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7498286F93D
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 05:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FADA1F215BF
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 04:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81255B667;
	Mon,  4 Mar 2024 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TQmLu4Mr"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E68F59;
	Mon,  4 Mar 2024 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526822; cv=fail; b=SCABUjKy6TJ24FaGSyHYi5VekJZH/S40nRgpCsFNSR2FC+yvzAEj6P54SyXGLSxxvIhzNdu4uVcklxF2Wy1VGriXikUrT4VQ7VF63xQo1VlRLrO+HmRsDnJlWICH0cQibTvtjYrvFosh9qfg2hMWLhLfs8vaYMD5guKtVgB+fuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526822; c=relaxed/simple;
	bh=06wTnnbrBAdqoSBatT/mjGZX0zrv5vZOioAvhfrT+54=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oN1SEwj6vL7nI92jTyWCFQpvnVi71F9fRdjufNXiMWSjxOprX9xjyuPhqZlGiMunQtBpeYWlHAmsehlHQCMD5M8bvUs1XRj6wn4Mn7GspDDEKsOgjwD60+8bgtRedYi800+Q1VyZ2WWW5VzDYTWGjf3YV6j6k3GYd0BowP61Eeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TQmLu4Mr; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG3DJPagjbH3O46TBTHovEo/LztYWAPiMyfOB3q6K1xTH6+5j1Tq7v6VdUhMue1gefsoilfG2pRSW9UUYDJL224ANK1wvtuevIB0diokZLDhAMJTHhQEh3DWJU5xlhTjXycvXb7ohu4QbtXRfCoXgIKmaueXBnPWGycLa7KW4fOG/YMt6Gf5iV1ZoUr1yLwclzhoXId0J5+/QobJV3ONWeyewjw0Vzsmb11y0Li2Wg96xLa0PSUr8/P8NhNeX48yPOkhViScRUjuC7yc2uJwYyhA7wlxWrHE9ITTZ3YO431CN7/ah+DGoyRGvxAcJRbQyRsJpgopP0THW5YRKFnBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz8SCtfXI5+U71jF6sH78bb7ODttSNhkG/ike5YIX6k=;
 b=SZRu2o6hk/lU73BLP6vDvPXqgrOWy2GhS24IQ+1UC0idnJ8sPW0oBFivToDRzxqkaIT34AQMmBSNy4NLZny/xVHFbFfqP1H3ZoAIGucKXlFEdRDwWmp02b0PZIzTMNNAgwWwfKuASI8imumwqumcCWZzlNv9aAUVNE+O/Wb7vcGaBwZbsjWDRADf2cGAfcWX0Jv/rv5uRqJOR6rUapFhtAi9TgkvzCfMhDrYWXc0PTYaFbGQqfnIfcB82E9xxfSHU8Ay4czFNNmJI9g69iJsNybHcyG3BPN+OQd+qImaV+Vm3zwTSNu9CqbQseAB8KWCGXso/324QlPJPaXiXsKpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz8SCtfXI5+U71jF6sH78bb7ODttSNhkG/ike5YIX6k=;
 b=TQmLu4Mr2q5e1+swVFJdnlhJyNtp6cQol8cqU4S8op0B4dssJbmGvx/EzQBkieVpDpzq3jtpMuBo4rzoiIxpJ7MTWJrEmlUuAmwNvxvhikpVh5uSBCqSjpKQFwvMBKIYYWe4njFKPohlJ4IwJw+M/CV22S67dmsrCUpPth0iU4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 04:33:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 04:33:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sun, 03 Mar 2024 23:32:55 -0500
Subject: [PATCH 3/4] dmaengine: imx-sdma: Add multi fifo for DEV_TO_DEV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-sdma_upstream-v1-3-869cd0165b09@nxp.com>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
In-Reply-To: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709526805; l=1222;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YaaXAuvCaaK84kiwIUendNjFizt0HTaM7GccMsgIaa8=;
 b=6m6kj0LyEPt9m7OLRxncLNPHNOpexDqFPyXm36x9kyYUnOmcJbg6uTDWiJb79/lAZCf75ItqC
 dtOH6WaSRDJBFGX2YxZzXdHwtRgAbXiwf618AZSdpysRyIQuQjOZclw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb47818-e67a-4b89-e5d2-08dc3c0443b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aQLO9bGskBqnmN83tAaMQV5IHMPWpl01XF6HWBvAv0PnpyfDNfg1xMDYkydniR+YdCH04QU2O5klpoCHl77XXQ03Sl3PdPB1+J27mdaapPfNdyBybjeZjy5aLLuN+oeR6HxigLzzat5z+1TL3OeCArowiHAe4TVkK29m16ZqvB4e+MEZMByI2qwpLHYkPldT/Z7BFVbba+NjN9Ps/QBxGFrA7FF5MBYlz7pAVyTvQnYLQjg30x60NiSiyUGxSzk5wdiSqaVUrL+RXKHr9DfLuMXij+2rSOV7zhbwpXFi6Aa7igmqSGVfXJqBZS61lmajkveukS4aXAKg9VF9q1vhoCC54xlL9PxgQUvOJD+fljhRZC/honRpMRfdDZNvzuzljxCBgh2UFTE04jn55J00PQJykTlE02NlKRzoHP7kE2NIgs2esiuz1XcFx3/AR4gMJpxozjWbOFg78Sb49sY0y1pP49tIU+qVgdYHzR7jFVIP2l6EUwziPf8S3OVNKvW5R5puo9MRyZHbSvt2DrgsAKuTyzNzcAWvgHvqwekyZwwNbwowTnd0L4YrwepSbhpDDSmwBo/P8MwrIb707lcymDq9yhSepe3r3gRQVQFyuAxhrVhsqBCLEPXZvv74bCMKr7+Ay/IdYqcdjJv0HEFpJ6uiK3dQLzEoKbdifWiLcme/cim6p+6RiBSMJcZLdZHQf9hV3HXHAKAiZgdoSrK9qQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1JOcTRKZEJjTUYxL2Yya1B2a1ZWRVkrSVVlSGgvSmpzSFBmdEdRNU9zM1JV?=
 =?utf-8?B?ejdmWnluZE0yUnZFT3Q4TklCK3VPS0xMKzhtVWFaSk5yNDVyV29pZUc2ejIr?=
 =?utf-8?B?a0lpR3hBRlAwVnQrbFYwNVFoMmRFdkFVZnUzZDFGeTIzVEpqdTlzUlNwNEdZ?=
 =?utf-8?B?ZjMyTG1sTTBGK1dJK3lwQU9hcnE5eXc4UG5uRUFkSDMwNUUvY0R2c25TQTh3?=
 =?utf-8?B?NnRUc1Q2VDJoem0yMTZRS3daZnMycnNUMnkvSVRBbjhxS0htWnlaMVRCZjJN?=
 =?utf-8?B?N1NwNWxncWVYUHJKR1A2TENuNEVEdjYyZ1BBTmdqVnlXSjYwTStNcUlTNVFR?=
 =?utf-8?B?UkljY0oxTnhrMVdLQ2FTdzVDWWQ0OTlqbGJaMW5JRDN1T1N1KzhCQWxOZmg0?=
 =?utf-8?B?SThtVHhLZXhkR2p1R28wa2p1NktaWm5tZXRJMkdDUU1GWVJKbHU3R1dOd01p?=
 =?utf-8?B?dS9CTHpUYkVXdTRMWmZCQzZlV0RjKzdmaXhpaWxiU2grYkdtR0hTcmtBWHpW?=
 =?utf-8?B?VTUxQWFYNWEwU0poRGVsMTVFR3dydEEycFllTkF4YnIzM213elBtbTljMXhp?=
 =?utf-8?B?c0VxSmUxWEp6clpqVlV0RDcyUGE1eW12SE9TdE9GczFZd2NYUGRHS0ZXRFpR?=
 =?utf-8?B?QUdPbUlOcmxBaTYyQTBSOVloVlBuV1czbVJFYzJFd2cxWHNjK3VNZzN6U1p0?=
 =?utf-8?B?ZW42UjBFbVNoTlVJMkc1a3UvNHlTdXQ1WXFieWtvRTFGZlpNZGxpcUNlN054?=
 =?utf-8?B?SndHTUY1U1plUTgvNWoxL01RTEVUak94UUo1ZjRnTUJUN1dmbEpiYmZ6MGE0?=
 =?utf-8?B?bWFkS01aY2JiUnlpSzVORnN3U2duRWE1d0Q2UUdBOVZMSlBodEpNbkFGTUth?=
 =?utf-8?B?TWZHVVlmYjYrMVRjcjlHK0g3eFBkbDVjU2JCZzZmOHJVTnI1WSsxYlR1YmJx?=
 =?utf-8?B?a2YzeDl2bllTTWMzTXArcWc2UlZyZElJaG5BaG9IWFVOQWRaeUMvMmJRY2NW?=
 =?utf-8?B?UnM4MUdQUmxLcHdCZnZpdXVCVy9HSmxmeUdpTmw5OGdnbkVkMzgrK1BFT3pV?=
 =?utf-8?B?T2k1cGlKMEd5ZGorb0JkL0Q2UXpwSW5QaU1uUzVmaGpLY0hGNVBRaHJsU1Fw?=
 =?utf-8?B?Q3lBdEg4N3ZRZlRoNzNmdEpVclhRQS9MZExVR3k2Y24rTHVrdVlsYUZPNmMr?=
 =?utf-8?B?QWYyN0RzZkt5RGN0Tkc1MVQ1TS9ldHkwSGh0Z0FCV1RLSm9KcEE3bHQvR2Vk?=
 =?utf-8?B?TEdsdFBFVmJiNmFGQ01kOFY0a2tOa2Y4TXdiK2Jud1FIN2xmT1NVRjI3elRE?=
 =?utf-8?B?RzdHbDMrV3R6TXdWcHloOE9ycStOQ2RaR2wyNENkZDd5eUJXRURiaURhVEdl?=
 =?utf-8?B?V1RMRFhWZXg5YUhkTnQ4Qzl4RVdZZWMvYVBMZzVSand1ZEhNOWhneVVPTzZy?=
 =?utf-8?B?TE1tcFZUN3ZzZFAxL2k2TFFwdTFKblVhMllNVU9sV1RGS3NCYmR4VmRkeDVt?=
 =?utf-8?B?ejNzYnhtamlFVlMwKy9ZdkYwM0N3QXhmRVVyRjZTZ05VUGFoOEhxRU9mTzVu?=
 =?utf-8?B?aUE4SHZhamo4amppOEFKL2pja2YxRjZTMlFaREpyRVJNUmNFNEJjUnlVcm5h?=
 =?utf-8?B?cmloSm9uL3UzQTk3YTkvT3N5ZGp2N0VkODFxYUlCR0I4ZnJxRUpNN0JYVFp5?=
 =?utf-8?B?TENxWmdBdFNIZnA3TnBmdWQ3b1dwVzkwaVlSbDMrMTZycWtqZHcxVkg4cUhr?=
 =?utf-8?B?dFVnMUYwREk0Sjc2TFZwWE5CdFZSSXQ3ZWZaSGFTOWphdm1udTJXQTFSMU4v?=
 =?utf-8?B?Y1MvV3IyakJJaUVCWUViNHltWUFMaUVVeFh1djNHakFmNW9vMWdYUUtveElm?=
 =?utf-8?B?Y2MwSnZDNHVxbWRtaWdka2dOaThQcE9yb2doMGhwV0tpTGFiT1UvejhqbjFy?=
 =?utf-8?B?Z0t2dXZHOTN6cXNkSlBybEFDZUl2dTZaakRrVk9veEh4TXBVckxlSnZlK3pu?=
 =?utf-8?B?ajdyQkhBcnlLWjJuOGVCQklORnh2S3liV3VtTUsrckVQelpvQ2w3MjFvaitl?=
 =?utf-8?B?K2FhNDBEUFd0M3hHNzVKOU5ldUdJQlhMNGhiOGtzejVCMGNKZVptTWYyd0pP?=
 =?utf-8?Q?eRB/txFuQTHJUEfoEuRhRFrlW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb47818-e67a-4b89-e5d2-08dc3c0443b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 04:33:39.3712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxG9+nZkdaV8zpVwY89OO5L+jeQOwuporYRG/ENbKcv/1CcG8X6rPyXzMH5mKo82RGw6VRLs9ydn9aKfVXrZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234

From: Joy Zou <joy.zou@nxp.com>

Support multi fifo for DEV_TO_DEV.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ef45420485dac..9b133990afa39 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -169,6 +169,8 @@
 #define SDMA_WATERMARK_LEVEL_SPDIF	BIT(10)
 #define SDMA_WATERMARK_LEVEL_SP		BIT(11)
 #define SDMA_WATERMARK_LEVEL_DP		BIT(12)
+#define SDMA_WATERMARK_LEVEL_SD		BIT(13)
+#define SDMA_WATERMARK_LEVEL_DD		BIT(14)
 #define SDMA_WATERMARK_LEVEL_HWML	(0xFF << 16)
 #define SDMA_WATERMARK_LEVEL_LWE	BIT(28)
 #define SDMA_WATERMARK_LEVEL_HWE	BIT(29)
@@ -1259,6 +1261,11 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
 
 	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
+
+	if (sdmac->n_fifos_src > 1)
+		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SD;
+	if (sdmac->n_fifos_dst > 1)
+		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DD;
 }
 
 static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)

-- 
2.34.1


