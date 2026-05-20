Return-Path: <dmaengine+bounces-10580-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KtcNo82DmpN8QUAu9opvQ
	(envelope-from <dmaengine+bounces-10580-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:32:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 199F559C132
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94C383060B1A
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57693BA241;
	Wed, 20 May 2026 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UETwVWi7"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6B3B38A2;
	Wed, 20 May 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314473; cv=fail; b=GS75crUkS/e+tb2QF/vcj5Get59Pc81tWDu3UX6WN/smvo6migbHvcx419t+6pMIqQWY+sxmNUsH5lH5PXf2zu6tNg8/S3N0BPITCRm7+kNd4uXgdefjuVW1/16dpUQHhNuCXN95ZbyKF/0a7r1tkB4UjYPF50a8wUxTPwJGK9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314473; c=relaxed/simple;
	bh=DuNybtpG/IsX8qkRt2lVc3IqI6FNh5BvmqWuspOXgu8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A5cy6SRraqfvx8AQBmeWjYsj/s/l/8LJSt9Hbq4atqIZRTuV//xSD6EX5Mh/X3n8IOVedMwFNXXICcMK1dJ0Lv1jwaC/ie+KBUqGre5eM7rGi8E+5C+0zXviBQ0/LSTCguPh9HBeZm1/ElOY6/O/z96CUKdhKtVHwuZ0piU0vvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UETwVWi7; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUCAHG+aR/BQd7C/8/uqtK7yfQvsarGN3uWoEIwH+Cv9SoPU3G5Sxx51BWW9Mel0Mez6kpcsUglDMFWgyV8kshhGDtfa1Wny9i9WbmFc0GSwjuM3a3H0x5W6uViqqvF7/rckxyOrdGNfZP/oo/i9tn3OQhjYw85w+l57ikHJtQ4ovihKwKWUVsdL9qnKDYq3h+DkNlNi1vBhIHoFpFLCzhbUb1EgjdFYmBnRqZt4NfDb1aK45IIDcSkmJIlYu19wZpJC8WKafkfOhoUQ5rGBLxa4Jq6rS+d28+Np5K2LNUTs32WZR2JV8xl0EbdHdn9MXNp3qieORGalvLvQWafaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCLQm9FMKtJMjBMaBxP7B2O2if8dRGJIhhVeRDVSeRY=;
 b=w7OS5jCLo46qQu5uqeHPYtU/KKfgE3ZGuzNIYAfc2Y9+b1xmKfcOMSxcn1h81dRtanTB/v3cPxZk7838esDlkBvQu94VnlGm4r88U9Lm7cTL4gqNwuBnCiZJHlfPMblh5a6TWvx8O1ieJ/EJ540fH85WtL4aZ79uC3yWXvokZE8mDubLJI7l6CDz6BzmxCyowo+OJy6cX5zjA0n2k1Gh2LAnXnIfkfE38nL319LxFRTzeNydTvQ+zsH24ydd1VuOcspWAub+3ZWpW9r+2GPErVTOssR5TgZ/QPEXC+Pl5Ai4LPHPla/sIXF8qhE3X87hZ/3F5abNu2677Nohh2Q3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCLQm9FMKtJMjBMaBxP7B2O2if8dRGJIhhVeRDVSeRY=;
 b=UETwVWi7CGXqwXiPFIHhqX6sTvV0PfjNOcfY7QTyOut3dv3Ga3z+Tsx1EnAXzvIcTL1/X1UUjfyb0rWWpS+SeEtA3SiKeTGRvmuK9zKexFeFis0v2Pc50ydQv91ali3vafuMz9UVW3K5G7EXNJzBWMaRNOzAYg0ONgzTs51ngGHMkkKK/nY8Tdpb9itW72bLJY26NdsubQrBKnjhfVNbtPAzhh9dn4gmrLykoyOoyVYRXlcMvxE+ldrDKygVree9e8OLSjnsTEeX1uv57n860611c47u2HDDyjP6UYGsX5CL2Z2Hk6DSUMkZn0xRExQJYxkyt6II59tZAh9RFmgZCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:01:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:01:02 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:44 -0400
Subject: [PATCH v6 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-3-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
In-Reply-To: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=1239;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4g4bYv7hszCtOOju+tB1akaHeHJJOwC1TTsFpz2HVcY=;
 b=fc7m9kKimcY6B0VG8c0yUVKPV50cEk1ue69SeZd7Jmj+8/Dn+XfVUyeQCQW6U2x7AFEYW8JKW
 QfA2dWBuEgNBB0MqkCpDmnUZco81GVTQ4YEnPhF9TR1uu4wDlh4uNVT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN6PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:805:de::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca1a6b4-3fa7-41e2-1649-08deb6bb4855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Dlm4h8EArTiRoT30X4dztu5botP1aPyBZ6+iAglprFfF4eiRlENBVYzjMGaI6nDMAATu3HqLL9GVl10yLvWsocf6IItL497sivPClJjz3YyiebkznEGUer6zKL9TTCOyqvn3BtNcI2qT03j7a5eCGYDLoBo9x04QD0BJT4UNscHD26/u064Ykd56yIBBjDD/k/XenzaWuBslyNc+IT/DDYdOKgIj19+9PZqzsmcj8QgvkbQVtmzzi7DFLZyVSdfbHgghVHa58C4TB1ZfOSo0YMmO+ED4B9+HHbVNkgHlak1RRihRqN5HlfQ/4UUohQWtJZj7/wDaPCI3DouA7km9BYDVjC/5QD6YOjBqtcCvPU8BlBjaiKFsxifMpcR1rTaq8BQbwgwW71q3sUeMheiGoBUrfg4bry2CAnySHi9Wh6qFyczcRuGln+Dq72QhLFzOHs8Os15jncZ29DnXeGF46a58AeknJm4iTdQH3xzJfE0vGDAIbZuqy2pX3RttmHAlr2dY0kTiSiI1ahttn/eEPgKr7gO2KDIBdx5fBr4ycESd77kP83zVgvnqH2uvX94rrIbp3p1u8T6cVWFnCEhvSgFiVFoKhmByS0pyme6aQ+G07hAUqGW8VOT6s1A1iT0255B7vFVhObNfrW1LzlH0i6v+tXWK3k5pDY7yzEKSuoiAsYzNjx7ZIX1IU/BBUyyE7CYCoJ9TYUvzwU2/CjQNj63xnQpkOufzWB37eDoRlxc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rnd1WWxlQVEzR0tIYk5PN1VsZ1A2Rkk0WmdRS0hmTUFibFhCenlZc01sMUxn?=
 =?utf-8?B?TjFJUmR2STF3bjV2QTZIT1VxdlRockhJM2ZLUXNNK0lDN0JkVDZiZmVGWTFp?=
 =?utf-8?B?dW0zdXpLUTQrd1pBZ3RHNXhDU2pIRi9yMkxtMWJqc3cyMHRmOWo0Z0xKL1ow?=
 =?utf-8?B?QVF3VXBBTWNqSW5SaDQ0VGVObVdldm1ybVFQbzNwRE1pNTNrT25OaTBOczdk?=
 =?utf-8?B?Zk9PVW9SN2hQVHZuR0xOYVZKU2RyVjR1ZEdMZDAycjdCYThocW1YcUczNHVU?=
 =?utf-8?B?TEZXVmdMbnlua2drRnVTVVBYT3czclVMVjVFaEsrdWhBYlBjdzNjakVEWnl0?=
 =?utf-8?B?eW5Sa0taZzFYYUc0elE3M0dVdXlTa2tDeTVmSEVEd2hGbFZZUEFYdFBUakZt?=
 =?utf-8?B?aFQrRmgvTFdJUGRwMFZCT3RUWWFOc0dWbDMrNWMwVGJseCtsQkpJNjI5KzlQ?=
 =?utf-8?B?dTgyV0dYUDNBYzQ1bHFQdjRmNnk3WlozSWtCUjB0djR3d2dUcHVseGkxVHpZ?=
 =?utf-8?B?MkdBNHBqQ3BZMzl6WFNlbUVhYldzU3dsaHZpOEltNVBvNTl3alU1a1NyZXRZ?=
 =?utf-8?B?ZzVQcEFYNWdwWWIrNW1QSHllRzVGREtzbUpZbWdSR1g1QllLOURnRlJ1c1d2?=
 =?utf-8?B?L2JNRkNuazlZOUlwWUNhdEZnZVJ2WFJEQUNkV29vWjVQTlJ3My8yMi9CQUp4?=
 =?utf-8?B?WFBCSlhicklxdzNiNHVLcllBWGlLMkNsQVh5SHAxRG5aaWl3cmFwcUVSQ21Z?=
 =?utf-8?B?Z1grOU1VaVk2alZWS05lSXpOVWdYQ05jNlhqMk44R3VLU2pNWDl2TmdZYkVr?=
 =?utf-8?B?M3lvN0x4ck1TdmVxK0g2MVpaaEZvWnVSM2k0MDMyMmZZbkZ5NmRlYXNBcHhD?=
 =?utf-8?B?citBV0ozUzdUMnROYi9QVFlZS2E2L2VtTHQvd2dSSVpDdC92OGE1Ulp3QkMr?=
 =?utf-8?B?K1IzZTJ2T1BtOTRaTXByUk1vRDFnQVV1SzBlMkliSmRDNFRKckkrM09uQ05O?=
 =?utf-8?B?dFFNOW5iRVNvNWNxbmVhdWlYdHZzNE5IYWdCZVE3K3VlSllHTFZrcHFBZVd2?=
 =?utf-8?B?Wm1XazBFSjNMM3ZCaGxJcGVPSGZXT3lrVm5FOUVqWjFRY0c5TkpCM0pBTGQ1?=
 =?utf-8?B?WGVrTjhucmw1TldRNmM3NFYyNXVJWGFGK2ZNVnpLT2RYa0NaNVVGQm1RYmhl?=
 =?utf-8?B?VmwwbGtIWm9EMWptbHh0UnZDZS9Ma1ZoL2QwakFNa21TUXYrMXpOWVNsbk1E?=
 =?utf-8?B?M2d4T25Od1ZtM3doSjF6MW56YkQ5RUVVcW5DeE5JNkg4T3ViRVFFQmlsdHov?=
 =?utf-8?B?QmtmaXFFV2xnQi9WWFRVUUh6S0ljV1EraG5tMUxwUUhnQVl0MDNpc2NVVHBx?=
 =?utf-8?B?TnhrMkhDWGF3azAxZXBZWWV4WkVPNjZXaEwrMGo4QUJndUdpS2R3ZGY5UzQy?=
 =?utf-8?B?Q3ZWQ0JOSXpJUzcvczA0ZjBoV3hLRk84bDdXOEM5TEFxdWhPS2k5ZHFYZXZN?=
 =?utf-8?B?TFF1V0JXSk5pdHFaUjRvVloxTFh2bis4VnlDbnlwM1Zrc2ZiUXlQU2VPK2VU?=
 =?utf-8?B?UWNFaEk5YUcwa1FGK3d2TVFSNmpKZHNUd1hqOFd4YmhNczdXZkJDVkR4dkdB?=
 =?utf-8?B?b09Ca3VCeXVBdXdhM2FvRlkweHlWMklYWXJjN0ozV0Z5UlFnL2lRSHV0ZTVj?=
 =?utf-8?B?T3RtaW56ZDZ6MHB0Nlcranc2KzMxMkd6OXI0Ykt4RFBLR1E3NzJGbHlYUENi?=
 =?utf-8?B?WXZxYWlCcWtZYnhwSlBPeW14TmxqUzVuS3RxVVNjcFhiRkZqbm9pRldnTTdM?=
 =?utf-8?B?QjQvbkNwcy9hTG9SczNIdmRlMjA2SVFNcTFqUFdTWHlCRFQ4Z0Zka3lYd0xC?=
 =?utf-8?B?OEQxb3ZVVkhLQk5lQXhsODR6Mnc4RFRILzZEcHM1SDlkUGNJZk5HUTFLWDBC?=
 =?utf-8?B?ZTdaYmJqbThzdDZZLzlCd2szN2xrWTF1YVdWNVdTb1Y1NHRtcjFVaXJ4dGx3?=
 =?utf-8?B?cWMrQjN5eUdLVGNMbTZhVzFjRHpmUUxuK3dTY0hYMzRHNW5XZE5OQWFHaHdF?=
 =?utf-8?B?ejFOMHkwcWgxazBORTZwbjRYd0JxNnRCVlE5T1BhZmdTM01SdFJDYmhsSjRI?=
 =?utf-8?B?Y2t2WTFSQlZobVRTR1NSUDFwaWhDWXljRnZ5QmMrS1JwWVl0WEhWakFEQmNp?=
 =?utf-8?B?TU1OUy9tVURtWm4rQTQxdVZIU2NlYzloRG41aUFjb3JvWEFJZDExcStuS3Iw?=
 =?utf-8?B?S3l4V3laNzNKWFVKYWtCSC94amZTZjBRUXh4cHpWQVpkaW1lR0dLQ1B4QWNt?=
 =?utf-8?B?Mjc4TE9yZGFPMko1RWJtNzZ0M1dDWHpPNXZPOHdMZFU0QzJSMnVYWWxBNncz?=
 =?utf-8?Q?K3hMTfqT6Twm1lWjjVEhWTLiL+iK8YfvNhhXs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca1a6b4-3fa7-41e2-1649-08deb6bb4855
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:01:02.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgveHYg8SRuWTgVYbl16EGN3AL2G/UaouX0BWzwUi5/zzecQuB5v3c3HpkL+MxQFMR9BBGoACaTfArDqtejJMWIaxuwXU9cLwmN6KcNUQ6yj/e+ZGe3QSr2uRDCuAkHm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10580-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 199F559C132
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Use dmaenigne_prep_config_single() to simplify code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add Damien Le Moal review tag
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 591d301fa89d8..0f5cf2d795108 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -182,12 +182,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		else
 			sconf.src_addr = dma_remote;
 
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
-			return -EIO;
-		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
+		tx = dmaengine_prep_config_single(chan, dma_local, len,
+						  dir, flags, &sconf);
 	} else {
 		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
 					       flags);

-- 
2.43.0


