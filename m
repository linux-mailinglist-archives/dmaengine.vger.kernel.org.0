Return-Path: <dmaengine+bounces-1235-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545AC86F93B
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 05:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD361B20A9C
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 04:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD08C1F;
	Mon,  4 Mar 2024 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bTP6wDB+"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B57499;
	Mon,  4 Mar 2024 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526820; cv=fail; b=s10KgC+DNLGK5GyRK90aSXmrFP5Hf/Gq3qoGFP38SpgC5A+WeQcKeICeNUN/gztCUqbawN0WtHISoA+zLrBSjThEg6K6KxySirzCDBGttWc1gt64B4bc44KcSGHEKXTS4Gd01dvtMhDPhQQ6ZWyp2kswtddK+JGuo3eXTcxzwjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526820; c=relaxed/simple;
	bh=RpOrgfVsXIv/QMUY+ZIbeIb+iq/aT+b++LFSWi+q8Rs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Li9mnyvATOLmTJtoM1Pc5d1DTV64ant92cqnFtiGAw4BCTNq7m3uM8fU89VdVKZ3poxZx4S2v91PxrkOqIEOfQNaz4uiz4xSK5AOZJnfDg1FBfpGamYez/z1S6GNGqMEEa/RAZI8demWteTX+gWGmMedgDFPlkgxaqVkaooAL9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bTP6wDB+; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN+6ifDAMrdFn29dtbGOqy5sXRSou1fqWCR9ikkJayVD/E/rw9911BeA3wg995PpCv3YoivS6Dkb4Dh6A7javzrmqDGDCe3hMmuiFZ3XjcSDslwYuOrMZp4PIm/3oRKvU6+8vEG5ZYVACjKUHIdhVh8hQ/XfaV0OeziOd2GEEPCvgiotcA3zsbtb4/XHN8BsPllOul5MGHXoGHBv/OoVphFOmId6CPXCP9HH9Tv6hVaMjyF5omcuMMjjpO8DfpGXqzB1Koy1CynB7ZhFDxNqDcuwxbMqhck2Wlnm12Bx3ZJTzUvX76Gg7cTfXnuFe1xgRE+X2Dxj7H0LSwVuiy0gjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2EJXTbBV9/6Y4fPv3TuChxYcIeHEADlNvS5YYhKj30=;
 b=PEx2bKC2VNTxWkSGlsuqac/3Hc4ihWo7iWCpUs8+ErK/qwjR2W2BuLtvQsNvL/Fb4bB5FPeHvPROB3yKsdeVLw4yoNa4PDY15909QvV8x/TdIryqytkCPrEbIvF789wEKTDTllhduAVXwG+UYM2DSvCU9Q8epoIFInD2Pj2CMv534v8Gz2ZxMjJ91Yk/mSVXTL7ArEDGkvp51zVpn5O66AAC3RcXBCi2az80+ZyC6AupYev8KgMvfHuw62kyoh1nyCgKk70SCpu6FOJI9cdXsp7ZREYn+TCqH/eoaShdflyuCJDG5TDhWlb9LhIeOYQwUuZIQoaosX+QKyzIoDtVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2EJXTbBV9/6Y4fPv3TuChxYcIeHEADlNvS5YYhKj30=;
 b=bTP6wDB+B6JdYJws/7/hM51EzcjApF3Coa8IB+B2+Hmt19PqnFl4UUemoo0pWTHXxDimVVLU+oDdz9pPTKwmxeLR85oolVmfiA88lErWpqZOTLdAaXH5qY34S8W7KbXaLLGVKgfgsVcKpUOLNA335wxboxOy0j0PilQ9l6LPrNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 04:33:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 04:33:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sun, 03 Mar 2024 23:32:54 -0500
Subject: [PATCH 2/4] dmaengine: imx-sdma: Support 24bit/3bytes for sg mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-sdma_upstream-v1-2-869cd0165b09@nxp.com>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
In-Reply-To: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Vipul Kumar <vipul_kumar@mentor.com>, 
 Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, 
 Robin Gong <yibin.gong@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709526805; l=1187;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hUhj6XhOGDMEIuRxw9GM1hd9T+mXOn/iwu0f8U1eEWA=;
 b=Cz6ZQYNnrY773ojOsOBGVOI+wHg5Z2kx2WOaN/X0gojKM+FtpIV4qXayZjB2OXp5FWBcxrO6l
 ZKeKcrGhmEaBvVCJbHWEnYx9jsozxk6tk6qRu+mEt0bXM0gRcfxrgul
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
X-MS-Office365-Filtering-Correlation-Id: 4556703f-c102-4c1f-cb52-08dc3c0441f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HCLxZ0ENn4M8rKDkyD2Iq08R3wnYU3GUHe/9W4bA1hiKVXERvetdP9P+rgZyp3bfxtuHJu+P+/JjDZTgdFilv1nUBQntrT9v10MM2UpkGUSASIYTZ/PwQeSHmvmaaX2MsPI6jgIMmzuRzNFtLifAZkS75bCkoJ070XB/AoToIUIqlw8OAOxDzSgTpXaBkKI/YOsQEGw3tNwEl14LZsJxbsYgZ5M1FMXXrq610An+s/wpC3dsdu19tdOohrJ15kOtYT2VQ/d7hwoo3S7mzo7TjWrq+UYRFRrP0hKJYwRars0Kuwd6LVDV5Iy4Vj0u+o+ZNMzIxMylJV6yHs74yhPR2CKqsJ8E+ZTKQwbzPIccriE4/M3E2kgrHr7D0PE5vrIIsUJeRm6s8ce7CgYE3kPdEHFQF0oslo20HWoSsRXLyd3YrPy6CaMKzMUD49jlMbR7DSUR9EujHaNPNw9HWeXTqKaJufac0xeHq1dQSW9OwUnjpE/UvbPkBRW2mPZrDRAT2mLi4Uj7k+bwypFdqo6umo4uwbc5UnkEjvcJHZRqxuCcy1pOMUtwpkRsD+gYts1YKJPZV5S58dxiNOZPE6owDSzOEcRdrXj8Bj8Tt9YsUNfxY9lKmXQQEcdaJEzSwKj57COgDWGlpEFfmy8Cf97oFIqrW+wdktYqHGaDzkOdmRcnnN5o6lvmomYrUSPe+gpGyVqEhNR0cSFjrcY6jR9K3BKnSXZLO+ic5z3qngVLYO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3dNOUZYeXl1VFFLRmFjc3JkUHl6VzhMOWNvaVMrWmhxZG0zSmJYazNaaktB?=
 =?utf-8?B?UjI1WFhsVVdzRnFkcjlLT2QrdXFqNFpJckZ2WkdFNkpGTnc0M2d6ck9kYVZs?=
 =?utf-8?B?M3ZGcGtQMVRoNHBudExkZHBmQ05zYk8wcHVUbCtJWlZuZXpPRzBkOFlPYmFW?=
 =?utf-8?B?VE1LU3FuK2lXSzZOb2JaUVhGRzYvd3VBOTlDMU1KUE00VTlRWU5TN2V3ekZD?=
 =?utf-8?B?RllSdU14L3hiYWtEQ2JsQmhJQUNsVlZqV2swQ0RGM1BETHhPRUZKWjdQcnVh?=
 =?utf-8?B?a0h5T1pNeFVlY0hTKzN1QXlXNUw2SytvK1RWeHFKMUxxWktLdlhEZmx6ZzZk?=
 =?utf-8?B?V01pWUhyWjNrcThOUkg3RXdaQXBSdzArUU5BMkxYbDgxUkFyZU9WdE9Ueit2?=
 =?utf-8?B?eDl1dlgwSm1iTTF0QnBLaU0zU3Z5V0lWVDFJbHozUVBnSERVUW11RHFKT0Fh?=
 =?utf-8?B?bVFITW84RGYzZG04dDJqeGRDdnlRZWJFSmtqZDBMVGFMcmx2N1kwUS9QdEVI?=
 =?utf-8?B?WlNsV2NkNEhxQ0JMRjE1VDkyUlRHeEVydVU4aTVLKzQvMlFqdGg1TERLTkgv?=
 =?utf-8?B?ZU1iVkNZSHczazVvU0Vic0U2U1RiemtlNVo2RkNGSmo4dlo4dGs2YVZ3ZU12?=
 =?utf-8?B?WkVkZURkRDNDa2EwaHVacG1NM29BR3dudFdKYkJFYVM2T3hzVlY5TjE3ZTJo?=
 =?utf-8?B?bDJRSUdSS204Slo3dUVlci9od3RjQnhSaWluZkFjcmJIZzROelUvUlo2TnVR?=
 =?utf-8?B?dTFyQUZiMHVQNjRvK2tuWW1ocmF3K2JnNGtnT29PWVVLRUNObXRqcjB0Vkdh?=
 =?utf-8?B?UGx2VGZlNVp2WWpRbXpmdFl4cHl6RlRIT0JNdnRjTUgvZTFaUzdBZHlWMlZ0?=
 =?utf-8?B?aUdtdHhNYi9rZ2hTbVVyYUdUSms2UTljdkdFQVdMdDRRbTlwWnJCOXdTUjVL?=
 =?utf-8?B?ZGhCTG1rWVZpZHExdWpPZVhyQlEzQ0ROMWxTZjUvaDVjNW9NVEdMcWt3My9F?=
 =?utf-8?B?WVA1SWdRak9IL294ZXpYZG5tZS9ZWjZNdWkrbjg3TkNmaHI5ajA3M2lCc0No?=
 =?utf-8?B?VElNMGVOVFRSOFNvYXQ3OFhGTUh0dkhhMEUxQjNmVmNaMzF1MVVYNld1MmNP?=
 =?utf-8?B?dTNZZ0NiajVmQ3RlbFczcFBKTnM2UnVpYzJMaDdzSC9Obnk4TVBTYlM1aGJK?=
 =?utf-8?B?WjJsU0F2YjlWNWd1cXFIWnRWMEVxb3ZldmN2b2hoSU1oSm5nVDRPV1UwU2NI?=
 =?utf-8?B?VmdnTTQ4dSs4WU5VeTBKVVd2NFQ3cHJxTWRmS2JyYk5wdXRHMHJqMmsvVE1O?=
 =?utf-8?B?UlhxSnJUWWRCSFlJUEtmV2NKQW5vZkhUbEFZS3JsOFdFcXd4dytobXJGM3la?=
 =?utf-8?B?UEdHTmplaFZxTndkcW9yVGZWT3VzNXlLaFNucnFZWjhHaXJJSGNIQzJpSU01?=
 =?utf-8?B?R0NhSlhPUWt5aW1oT3RXQnpscXl3dFo0S3NqeUI5NStYeDR1eFAvbHJZMW5B?=
 =?utf-8?B?VGZrWUVzckpDQjVncVB3QXNmaHdiSDNqRzh5aHpaV2xrVWRDakRmOFZ3ZHUv?=
 =?utf-8?B?RkZ3cDAyTlo4eU9UNmFraWI0THhodlU1MUtHSWRkRE03OVRjakpRM3ZVVDF1?=
 =?utf-8?B?MWVLc09WNVJwUGJXa1ppeXh0ZUdlRDd6bmpscmpIMU11SkRTbUZqUzBwanh5?=
 =?utf-8?B?ZnA1NlMvVDhNU0VsR0FsdWhvbFpXbGxvYnBVVzZGSGFEdU1iNGN6eFBzbk1k?=
 =?utf-8?B?Q3Rjb1F0UndXcW83WXhJenpabHZFdWVsWmUraEdXQUFKZGUzcU9jMlJ5ejh5?=
 =?utf-8?B?cWxJODBwVzNkL05zL3Rkck9FS3gzaERKdDlXRXdHZXlmT3hmNGVyUWdvK2x5?=
 =?utf-8?B?dmJVa2VyVGEvOWVYdE5JcGt6UVNTMGI3SHlDUnRPQkFnMFRyYk5yU3phRjFy?=
 =?utf-8?B?aUZlRlFGODVXZUJGU3Ftamp2MXo3WXBXMkZhRU9JdU5BR0hSdHZsaU9MMVFW?=
 =?utf-8?B?QkUwTzcwQWNsYVVtbmdWWGhIckJDZi9zaTNFK2JoMmxHTzRiQWkwZFlqWElr?=
 =?utf-8?B?MjZtTG44UDYycEdRSzRpMkM3NDBIYVNjdi84NHlGV1JaZDlPYzBXVmg4aUxF?=
 =?utf-8?Q?elbRUi0gztVK5N1jF+r/C7tVk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4556703f-c102-4c1f-cb52-08dc3c0441f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 04:33:36.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDVJHN9q6TYqn0ZSrK00BwwfPGmKeTR8bpdrx0klapRIb7V8RW/dFV4+ggNuPntHTPRgUiGwpeznfNcHP1jrxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Update 3bytes buswidth that is supported by sdma.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
Acked-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9a6d8f1e9ff63..ef45420485dac 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -176,6 +176,7 @@
 
 #define SDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
 #define SDMA_DMA_DIRECTIONS	(BIT(DMA_DEV_TO_MEM) | \
@@ -1659,6 +1660,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
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


