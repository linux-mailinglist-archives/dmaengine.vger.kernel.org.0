Return-Path: <dmaengine+bounces-1427-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8187F16A
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 21:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5431C2171A
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7D58ABA;
	Mon, 18 Mar 2024 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g1EMTJ6j"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2134.outbound.protection.outlook.com [40.107.21.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA5058239;
	Mon, 18 Mar 2024 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794723; cv=fail; b=LfsGR171D8+3Szl5JjFIy7XSJU/jYX5PWAP8iQp3QUePv2/V3SJ13TERXMVaz3vP9i9COn5TshYPjrRUg0YuaOs1yoEdoH2JvSIPXTTRJhoveeuzdMQIP4Bm49Ox/gvEED4N+9ZrDg3tQA1uCXFEwkM+H/KPqoIR3+i9y/0oXa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794723; c=relaxed/simple;
	bh=aq2/ULP0Acqkl5nMyq60djlyfH/8ofMH5hwkVDWJ9JM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bQGp3ZwBHVj63xkvPUQJzTJluqo6KJBfBC2BNrC0PbsNDeHCdLpToeDX1DXjWPiEi95zyfvc+PaFutLimxAZyjHFrvgkoiqGoHXTyB+cwzCz8OdYQjXwXqJkIm7pM1+OniYVCmqg5Z44FZfDrZKuW+O4fLTsiZE/w5N2GTKikUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g1EMTJ6j; arc=fail smtp.client-ip=40.107.21.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgFd8ZMDQD/p4w7PYbVm7VZyJwACjj6S6piWvfGfbyDgHult1dGG/bUuU1qkoAplOEt54UDzoaOVRrhJlHSzCj+AKFmrisT9eXXQVgw5w5l9sah2RY3umF1jUgKJvuw9DvY853ztpTpQm7ib2WpO4+T5XVXkn2ML2SooLDOj8TcBI8OGDPnotu1/WGD6sq5ukp5lUBCt6bWfi58c8virvztaK8F2/5E5N4lD9L0vtvfJjjYgLfmPCmRV2Y+AbAHrqejEag1/3jiXU/CtcfvPWkCUZ8CUuxocyTu27CyiUw7fvWg1swDvUY0vMnMzdnaxmFqX2njDg5kr4ucDX6w1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GroNJye/Yehgv2tou8mx9qaw1VtXSIYv09vStwtBzqQ=;
 b=C6QMhxeP0d4J5YHjLo9JGOGwMEa9QMLWqdQfZ4n3hxW4gX+EsVr6E6LVW1p9OIN9obBGqZL5wNfAxlVlukc+gLKcATX4078zDa1+eCiOfCSHlCwlbZj645RjC0KxfnQMMMMKf/Chf2OdgnRqx93sMiw3AGoq9ah5673mhQXhDHw95SPXXX/5pWGoHIxDi77nz3denY0FerYvsrETqsLJBOGaBSA1NzoRzJKurJUt6KjmU9Lli53yn+V8UfMw28h17cK/I5nMbUm7fAkrcqVw3hQuDLkHRSjUV20JT+wUfQ3BHR66vu5zHuYan8+BL7FFpSi7asqkm4DVSb9e8NDmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GroNJye/Yehgv2tou8mx9qaw1VtXSIYv09vStwtBzqQ=;
 b=g1EMTJ6j36L2WUWo6SiQfAVYdi9m3WkvUK+TxfJ5wRw7232tH/ADQIREJ+8uZ97dgrXKjnCYpkOcWdWWlp26WCViWrCHAt4Xw+xx1Ml9qZxW93j3SwjxTeB8xxbBAE9epHKnd6Qq2Ypl6LYyLqP/Bwp2WwiBiCj4Xq1OesJl2OA=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:45:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:45:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Mar 2024 16:44:35 -0400
Subject: [PATCH v3 2/5] dmaengine: imx-sdma: Support 24bit/3bytes for sg
 mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-sdma_upstream-v3-2-da37ddd44d49@nxp.com>
References: <20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com>
In-Reply-To: <20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Vipul Kumar <vipul_kumar@mentor.com>, 
 Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, 
 Robin Gong <yibin.gong@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710794703; l=1279;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/ve4814/ESKVFolOyuQukJbgmItKlbc7RUUIpEOw+Jo=;
 b=KCA6ImWvDlWjMULd/RwlC/t2tgzXo1BeSKFDGZ72nPp6up4KiBJcdXB/nxVrB0nfYNynct9No
 iKK2zo5cWpFA5h5TuD9AxGoQ2bJHYxpzv+ELRdSGACxJOWJyhDl19kD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8489:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LLm4YN0cPQVITGAd5/eXD2m3VE98pQz2VQO8kH2pqhz3PlyGCrWPAwZ4k6M56pDMfmeAFlQbFbXvuefzaSFgtwbEDEEQKBCnuucSd6W0KkIey5B6H81VIUtJaVlBpom70RtI2Lquc+ixaiR7gVQ+Ieglm6nnk2mAKY2ROfaPXSLxrh3l4Plg6kMbF0g2FVa47Pe6t2pS8mM/A1VCn+oEsH5aqMpFBxWuQVUldGKCuTkiVgI4ChgK8tOM2FDENI27FXi9MXDv0MORTa5R5hA8/sbDwZjYqWUcdKc9neD9njB+2YVc0B1pBFxFvcsTWv7J/+6gHRAECiIrRJEr7kKEhURAhgMBZWqSlfixyy+QrNloJJ4A3jUq7AFDF9cz9XyZ8Jb36pE+97d6Mo3pd/azCc9yutdl7qIeIZNcX2f87+KYXykY2TdMVv9JmI89E0qOFlC2KvOvU4AS4ivjlTUf7beNe1GwcbHEr6UMPHu3EGgpL3v88V4i2Jpe5xWjrrdQE1dLdePgcSvk/0pah6aSnN0bfkI+CCNsBK1Qbjx6rxvJyT9WBQOQBvVyZE+QKxq+PzjwXZtp8a7+G/OC+d0Skd9x/Hy7nIkTbhV0UXNFA2iO+MtmZXwlO+SivtynTJUmI17T8KuKlsyHjVUCKBMDQPRIo5E3kUfw4UmQK1W2zUJa12L8MwyumVgxB9jaMVonLqGnYfSz3yT3lioni0203Q6sMhKjoM3V285PM/yCIUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU9QZk1HS3E0QWRaRkw2MDBhRm1lSUlsOHNobTFRZ00vdld1NGZvdFhaUkxV?=
 =?utf-8?B?T051MTF6Z0NOMi9pKzRxWWVEaUhzUFBENHo3VFJ4b3NPTDh0Z3hhZERoclZz?=
 =?utf-8?B?SkFPYlZTbzRaSFlkbjR3QnhxWVVsMlhHTkU3aS9Ub21jUUcxVWFGODFuM3FU?=
 =?utf-8?B?Y0M2ckFHc1lIdkI3Tlk5L3l1NXpBYitHWUx4cGxvYXZVcmljUm92WDlzOXhI?=
 =?utf-8?B?ZXNXYnJTUXUvRDV4YVdYdEN2NWVQeGNpMlFyNkJ1WGtFaEtQb0UxdjdwOE9P?=
 =?utf-8?B?ZTUzQmVqRXpOTkVHZzk4M1d2T2tpNG0xV0trUnMrbENaR1hBeUd3cERqcERD?=
 =?utf-8?B?ZDI4dEVIelF0THRqM0JSaVpBQ241NzJZTU5uQTlIcXcrN1l4QmJGWVNuQ3pu?=
 =?utf-8?B?dzVyNCtYejZsU0h5b1FwNHVrMHlLbEdkdlBzN2NGWmNnWWt6U2VoRUVBdkhP?=
 =?utf-8?B?clRyZHJack5QQnQrT3FaL3EySXJhMU0xamVscC84Q04waHNuMVQzcWlaa2hk?=
 =?utf-8?B?WmZSTDc3OUVlcFFLNmFEaUkwQUU1UkZvNzRtcnI1cUZmRllCZCtQdmxoMFZi?=
 =?utf-8?B?UzR5ekNOQW5QWkFIZW1FWDFZWGlzRE1JaUdBUWlOS3dEM09OR2VaempEUS92?=
 =?utf-8?B?dnNUVEF3a0ptYkxwOFlQZkJSKzI5ZW92dWR5ZHR1Tmd5SFkxV3pNZS9UeVVm?=
 =?utf-8?B?ZFJnSytFRjFsOWJ3U1ROeXRsSnBqT2NvRmd4a3lJUndwcXhmS3JPWGp1VmJG?=
 =?utf-8?B?aHp3NllNbk5HSkRBd0RGVUZ5K2FSSkFaYk9pa0Yvd0NoVGYxYThIUUpoM1d6?=
 =?utf-8?B?TnBLY2RzZ2QvNjloQVpDbmRPdG1yaGlUdG1Vc2xjbG5EbEVZSUxjZUd4VzF3?=
 =?utf-8?B?QmZobC9udFBqYUcvS2UrRDZnZWM2TzR0d2NuUXVGZHJkNDVhYUpVRTh6NW0z?=
 =?utf-8?B?ay9aQWF6N0JlOEdoU0E0MzlkMjBya3ZLTSsyTUcwOUxGN2MyT3VXTVdZOEhn?=
 =?utf-8?B?ZHh4SlpCaU9ZMnZvK3BJR2ZpZVpzTnZUYjVQa2h0ZXk0ZDBoR0ZQdHJSMENv?=
 =?utf-8?B?Yk1aYWovVjlnT0QvZnZCSFRRdkpva09sMExpRDhDNnVRZ3FvUzMrK0w0RHpl?=
 =?utf-8?B?bldtUFNxWkZOV1lDam4rMnEyUldYei9mdytRTUZ6SGVWZmJlMmY0YmdWanBC?=
 =?utf-8?B?akxjNERtcU1sejkzK1hlaGdMTXVUSjl3ZEUzNmxFKzNTWmV6OEU2NHp4bzBj?=
 =?utf-8?B?OW1TekVJZlQybEJrUmwwZTNwbFB1MjU1WjdMQTBLWC9lUXBHN0s5RzV2ay91?=
 =?utf-8?B?WTYxS1YzMmgwdHJ6VUVkUGZZV1loa0x1dGo5NnFheWgyaHlkbXkyek1uMzZx?=
 =?utf-8?B?VC9zYWVWZTUvN2Y5NXVEV2VmYmY5aGYxVUtJL0hLV2hHYURhYUYvQjBod2Rx?=
 =?utf-8?B?V0RlWHU2MzNxK2g1VjZZcHBvMkVRb1pLcmhuYWI0SXZpQXF2ZDhIWFlmYUFw?=
 =?utf-8?B?NC9kSVJ3M0JxR2VhRzkyRWFoR2VXNFFES2ZYU0lBb0ZRSkNJTURWV2o2b3hT?=
 =?utf-8?B?bWlydksrTzJtc3duZ1p1U1htM1I2RjlmUHN5cFdaVzhpU1hTVlIyVk53RTh3?=
 =?utf-8?B?OE50bkhpWG1wTTgrdXowaktBVGpmVkRHUkFBSHlXenBxOTdIbVZGUTVjZTlT?=
 =?utf-8?B?Q2dUZ2IyQjJuTDdrWWdaMElVZk5KZUxHZjNxcWgrMEtIWkVKYVNDTkNjVDBB?=
 =?utf-8?B?NFJQS3ppTGE5LzMxMnRROWE0eTNUeGZVZUdRRDFzdEpYRUNpQzlFU0JZcm1G?=
 =?utf-8?B?d2hWOVgxVGtqM3ZSTi9HQk56eVd5b1ZYbVdhNnEwVWgyeDdNUE41cjluTHY1?=
 =?utf-8?B?OE9PWmpUb3RIY1lCeFMzajdMR2Z4V2VsY0lxb2tvUStvSWJhSEErMW9iUW42?=
 =?utf-8?B?MHRCeTl5TXArRTZySjlOT2JZREpKdFM2d0NiK0dmcWJadnF6S2xoMzVYZ3lw?=
 =?utf-8?B?UTk0dFhJYTFZOGFaYmZ1MCtxcGl2REhBWkw0RnRESkF5QXlGUG94U2hWNTM3?=
 =?utf-8?B?QjRjYUxkMU5qSkZLY3RqbVpWYnhOT01rNnZtL3A0T0FjVDdjaUttNDVXSVUw?=
 =?utf-8?Q?Fl5CAyIaN8HpjWs9CLlvDpSxU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c68e57-2b34-4637-74d4-08dc478c52a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:45:18.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPRjokNWG90bgCBq1wSU+20l6qB3g/7mc1FGrBIDvY2eNQKjCWL4ShIxH3By6QnOSdUTn+VZCkfLsa6/ef6tIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Update 3bytes buswidth that is supported by sdma.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
Acked-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4f1a9d1b152d6..6be4c1e441266 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -176,6 +176,7 @@
 
 #define SDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
 #define SDMA_DMA_DIRECTIONS	(BIT(DMA_DEV_TO_MEM) | \
@@ -1658,6 +1659,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			if (count & 3 || sg->dma_address & 3)
 				goto err_bd_out;
 			break;
+		case DMA_SLAVE_BUSWIDTH_3_BYTES:
+			bd->mode.command = 3;
+			break;
 		case DMA_SLAVE_BUSWIDTH_2_BYTES:
 			bd->mode.command = 2;
 			if (count & 1 || sg->dma_address & 1)

-- 
2.34.1


