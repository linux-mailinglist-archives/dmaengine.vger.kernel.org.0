Return-Path: <dmaengine+bounces-1293-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A3875544
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 18:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242251C233A7
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 17:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D6131E41;
	Thu,  7 Mar 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M98HU1Cd"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3A131E2F;
	Thu,  7 Mar 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832805; cv=fail; b=vBwbwFMwA2t95TZWW66r52NmHpSU0+JHQnJgBTrlAmp0wQTMLFZJUW91FOyxDt3RnkuW1cRzQCXYvCGAZ+tQqn/87xJZAfXnLLCCNOdrLOHLPCdPm0Vm+GYLrWCgoIFD0Z3sOr2dKX6zo4uAVnqdS8n5MQZHnTfhdK5jl0/iZp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832805; c=relaxed/simple;
	bh=YxPotRKKsv7AMML7UR0EJ+molezhbRr6Jj7xbU0leI8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=O5SnpizUun+DH0HZcckI1udfrGB0NrU3Rs2UidNrLgA1oj0mXp9muqewULP8KJgNAUbZi7TWiPqaQV3J/rWtlauXSKgNNds2mq4Q37t5yIzaNdZxDotdlJNgoEB83N2W9kQdPXfFZw6SDf6HiWZ59T9zUaCpZwOoJ2nP0Jpmq9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M98HU1Cd; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDQww+5cwlVngMa7ncEMPKPkUTamJ7djFJfbMdmM1BB8SoS45U+Y/jB/ecwk4oEcGTGjmiQ3jATRSIpzfQ5QKxmZCs3I61A8EopzeMNkLmBTtiS7CkejTSbvK/pzqlkPgp5PS9Z3qBkPKLHKPn7Ddb2DBW9O3jxxewUeGEjjLaJL+S1Q16eFiA651GJs+2MR7p5XpJmgxZJSNhmqwR0ErkRlihJ9hlBAHfJc1dIO1dtGui1hzn9UHg5eVM3wOwKgQybnRUThGixkR48D9IzfZKUBcaN7uRRtEeGzx3dEFRtlQhaod71j3pL7W/8ZYcBd/A7JemOE2AybYpItFH/0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNipCopR1actSPpQ2YFnLhWfTN7OElPPaWSFF7H3oS0=;
 b=VaFNsVDj1Ckyyg3EuabvIXWCn/GgSbCg4dXUO0h5Ri7FtBXKoekn7di4tDrfRobEMtcTogag4Ed7eXbFVO9UtJ9dtYdqBZDJhf8qz31udnirZ11jWwcg1Q5tGwu0WQkCFmdmKmEJDxBTFX/oe4TN1Jfq7nc35HgDsyTedK2PW/PBFpzE0U27QY+MCrdE+yLMq7nwKnPFf7GIU/dYREMTSlIZLKH1ej5yqRe1z4Uq3L8FOtmxVu/yaMD27//ZyIyqCdmcOVDtBPDrYPygii6qpDFrfywkwvLfK5GXUITOEcJ5R4r3AZlcZQ7edF2OAmBSu6UQIpbUxdSoH0aoZSUxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNipCopR1actSPpQ2YFnLhWfTN7OElPPaWSFF7H3oS0=;
 b=M98HU1Cd3MFw/cNW+hniD/yU0peWohShr5Otmy2uxAlo0o3U/aUrHsW/eC4CoOyduyXZpivHHlG8/NL9XC1l6bioy9rwZFGL+boApBn7xvu7z0mIMA6G5i727WMroDMB+5Z6iU6gBGYY4rxoQ8xL8ybLkLFdwrfubUhGPhbzaPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 17:33:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 17:33:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Mar 2024 12:32:43 -0500
Subject: [PATCH v2 3/4] dmaengine: imx-sdma: Add multi fifo for DEV_TO_DEV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-sdma_upstream-v2-3-e97305a43cf5@nxp.com>
References: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
In-Reply-To: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709832785; l=1314;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lYqK9q+URTn4zwdOYmJPQcGPKoeaMuMJQOuUDFYyhpU=;
 b=beu0/DrhG9b59bHhv6VSc7520pHz9w/Q5utXqsj5/jxu0ChYUXWIE4PD23Mk9YvLKY5R7h69h
 hhQDTiGY85EAV9sMMDkFxT1cJJJww5+XIctlamy6U9aiVbb8CXYzXkG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 694209ee-3837-458a-45d7-08dc3eccaf60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5ZeXWdZrGKRrE6JQivpC4d4dDumYKnwmJfcYmrZ8ucQYpSGsscUm5MBqC65iREw8mO4N3w4ndyKTiM4Zt2kcKZxiJ8cL89m/Rkci0gwtcSZ0Sk0UvWk2M5WgC1YyyOmeLH10wKePAlxd/sfOEZU53LHvLUr5rk+G6CL++kmgjLOOoVMyJEYPoDjrcpYYBWY2yjIPgnv3wIOWDdVwrVx1UwMMLjSxpHSO1yxt15jqv3Ey+QpVExAUIc07mnwc/3/V7Rj5b8Wb8+kM9ZfWWHF45hA8/gEVoV7K8Ups4VzX18YoLnf0ZTcu5z3REsK6BAb2vlAgaRQ+hra7MoYk2/sS8sTxRP0vBZGl2HtqY4TJAR0TQwQVMyuM4fPmprTXNOZ/mtgLWnfqjymTtneK4vvM3l/Mc/UJf0kd6Wlv5es9pR4ClqkJJ7llqKe9mX1NhtwzZVz5EX8tT3qtlDpwzNBVkgdhwtqFqSwUZNx6+yLQHAYPvP2e+cj8aRt1fc1NxkCa2SiCKphdPyKuv3VVA4qs7rNsmBcuY6WLu5qLNnNRZZH/Kc8nPz9LnT2wbP/WHpmmDZ8oVeT18rEYAhNZpc2DehlWjSW74kMPh1l2vIQHTZMXlIXTzGNL2zqZMSpa/9MHc8byxmutNgUvsZTOd8pAUXGhphQvcvWUjasItTejSmSNqjBojxpvH9eooLpvc/lkKFAHrow2i9cawI7sfiVJyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGx1TjRNS2FuZGRPZ3VicllHZnhEWHRtbFhCbkJ4eldGMWMxc0VrNS9RRXlv?=
 =?utf-8?B?ZHpleFI2cUgzOTJDdHFhZU1obktFT2pXbHpBVjJTa1lSODNnaitpMURucDJC?=
 =?utf-8?B?QlRLU1d0R2V5TmlJalBGWXA1MUdMd3RVTWxuL1V4MU1KKys2RC9hZE9KYVQw?=
 =?utf-8?B?YXoxUVh1b0daQmx0Y2JsOFFYczFlM3pxZGRFdmtkSzZZdVhaRGx5dkJBRVE1?=
 =?utf-8?B?VFNDNVlwV3AzVEp6Y1p1Y2xoT3VxbTF5eGdycmI1VWJQbTc1VUkxRld1ODVs?=
 =?utf-8?B?RFlHY3R6dFQ0cVBsTml3RGY3Tk1HVEUxVDgzbXVQaEdwS2JlZDMzbUQ4T1lj?=
 =?utf-8?B?MEFCSWZlSitXRkdNNnFQWXJJYkZWemJ1bUFvbTh5SlBVNWVibUlzekZQbHVD?=
 =?utf-8?B?Yk9Ba3NXK2F0aHdBKzBjbGlaRS9HaWFWK0JSK2hxTTlpdUZlQStWUHhJZ3pJ?=
 =?utf-8?B?Q3Jya3B0MnZMcDRqQURxV3QzRWJxNGxxdUlBSldvZFNwUlJxVEViNWhFaDBI?=
 =?utf-8?B?aCs2bEJaOWpqNTg4akVILzNZNDFGdTdHMHlManRsL2xMcFR1eWIzUTlkRUhv?=
 =?utf-8?B?MlR6dlp6UjlJVmlUcmpkQkFjZ0RCZ2FjaDR1YXVsYjVXYWlEcVd4bXVmMzBt?=
 =?utf-8?B?aEdYUk9sNWhkeE44WjNwZklFKzBhci9BM1Fsa0F0T1dJK3NJUGx5dDRDRmxx?=
 =?utf-8?B?cHovNFQ5SkRHYStDVy9mNDFFUGhLazk0YWFsTThMRG15cW85QW5MNnp4anhy?=
 =?utf-8?B?eWdmWVAzM1U0cWpuNjZEaFRkQ2p1VkJDMVpKeUdrZ3cvN3B4dmEwT1FTdmRv?=
 =?utf-8?B?ZjJlbTNJRWJjeGsrdEFtd0tueDhhQTI5K2lYTHVWTy9tYWZkNFBBdCsyTGo5?=
 =?utf-8?B?SzZMZnFQZWd4bWhWYmxkUWF0YldkYTYxYmFHemVRTHlZTndiMTlDTi9sdUYr?=
 =?utf-8?B?S3dSRyttYVE2ZW1sMTFHRzVzSlNaZDF5NHVsd1NQdDlNSlgzQlhlTlduV3d2?=
 =?utf-8?B?Z1NZU09SdElYN20ySS8zbXhoMlkzdFNROEZEQ0orczcxSXdXR3ZVMUFZdk1H?=
 =?utf-8?B?cHlDckYxNVBKTWVkOFc1NUQyQXJaa3FVTnhMcUJ2YzAxc2Q5SzVwMTMyYlFu?=
 =?utf-8?B?MW1BaVlERWJXdW1wa3lXa2hWQktWTUF1ckVNUGVnK3ROb2ZDTlRWd1lEbjkv?=
 =?utf-8?B?RzBteGlXdWVQOW1xRTRBU3FoV1Y5Y2dRd0lJR0NvU1JXdHBxbGFlREVHUy9h?=
 =?utf-8?B?Q3MvbjBCQ3gyQXUvVkhCWXFLVWwwdG1zK1R3QTdLY1dBZjFlL1ZmUXpOWjRX?=
 =?utf-8?B?SDRHdHhBcm9uc1pMNzhDaTVCQmt2WFl4UUsvSjVmZUp6dVU0azl6QVNTbXJK?=
 =?utf-8?B?NDJhSEptMmUxd3IyT0dVUVBac08wTVA2UHN3TEhBdHhxdDBPbDB5ZFJReUJ3?=
 =?utf-8?B?UnBPUHd5a3VmLzgxazhRVGdVazBKdXlKQnhpcEJrYndCWFpDK3JNZ1lpQTlz?=
 =?utf-8?B?ZTdCK3dEYUlXNStzWmxFZUloMGV4YlhSY1VsaHZNaXZwNGtTUjAxRWprSmNL?=
 =?utf-8?B?eWh6UEVpMUFjeGNiWTgwS0pJcC9nOU1JNUFMUTd1ZmZ5cFlHOThzK3dUL0Vx?=
 =?utf-8?B?Sk11b3RDL01xWkE5QmkzeDFJb3h2V0lCMEowSGdqVTNCa1hNb0VsbXpQTHlk?=
 =?utf-8?B?SGtwRWo4NmxuZFRaR20yNjlGQVNRU2tIMFY5b1IzRTBhWVU0dHpGNkxoSSsz?=
 =?utf-8?B?UDlpOWFHZS8yenJSQW95UkRrVkdoU0tNQUFIc1d2MzByV1VuNE1ucGx3QWR2?=
 =?utf-8?B?MjEybXFEa3dianZ2b2Jla0hhSWZNSnZIK2RUMmtGcjgxTnY1cjkzWXI4Z085?=
 =?utf-8?B?SXIwdnQ2eVNOQndSV3d6VVR6LzZLd045VEdzV0RoNlFrUjRHT0JrMXpmeWE0?=
 =?utf-8?B?SExrZDVLTkVkZDVxNXRiRzExTXVYWXJTY1JkSEthWmhEMWpTVFNJSDFGRDhh?=
 =?utf-8?B?WUJtbWMxam5yeVJhMXZ4V3ZFeWlYTk01Q0ZQWWl6cnFFUVY3bFJVcStuNjh5?=
 =?utf-8?B?aWxrUUdCQnpiSlpZalZHajNQc2pOS1hPdXk5TzJUMGpGWkgwakdGbEd5Nm4z?=
 =?utf-8?Q?gV1QZr7j+YjUSGfXLnTn1sM72?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694209ee-3837-458a-45d7-08dc3eccaf60
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 17:33:21.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BlNZyZyWxadOsns7+SVbyMtf0uxgRiC6416AtDqqWPLATdLg+ZwfFuaA1U/Y1idOXuzU8KFPijxrYDzcCucJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794

From: Joy Zou <joy.zou@nxp.com>

Support multi fifo for DEV_TO_DEV.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 6be4c1e441266..35fb69a84a8da 100644
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
@@ -1258,6 +1260,11 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
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


