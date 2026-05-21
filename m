Return-Path: <dmaengine+bounces-10681-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMfCHMwuD2r+HQYAu9opvQ
	(envelope-from <dmaengine+bounces-10681-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:11:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC5D5A8F74
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 066D5317DA6B
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F58368D41;
	Thu, 21 May 2026 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aOnpo30E"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C8368D70;
	Thu, 21 May 2026 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377600; cv=fail; b=YGYyCictlDrZcK96zVCjKdOUSZsL/GjTl8MuwlZV0K2pxAse9t0g3hufrneZ1hUUJ0c6DzV+0r3HjWhRsamF4dNJpqP7eTWJG0eZ8zihhhqJBliO1n5XgHQ2ErRcsatfADWpfLLKWupEJLKi53r01VMzSZIRUVRvZ2b+FRxHcRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377600; c=relaxed/simple;
	bh=DuNybtpG/IsX8qkRt2lVc3IqI6FNh5BvmqWuspOXgu8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TBe9IHXUzaEGsWTcWX/62uy+H/4gSvz1mNDniD7dZFkKZoiUUymPEUmi/4fp20ifGwutrk08ULqaMnItbHs08YbBWJsqxe0hvVO9RNn+1pFlWn9q5lvYziZk9rLaX+6CpwuR2FFppxQQ/Cnn/6CfK8DRHgQsxMf4UJihqTlMoek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aOnpo30E; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM9e7L1xgWYrCtUh75mlRkX6kPmKMfMWYGsRVh1tAo+IQX5VyGogMZqqbC4tVe3OzlpaXXjHPLswvQoSN9mHhAYqHJqGbpfkHBbejg/Awc/wWm1hxloqc1+HtCwAgc3lZAZLH6Zq/laGeIcV37kw5MaB/ucuDG4ZgC+zyIBklbP+UM+klQyfbf6RkQb3OaS+ijjFGUdxmqAtWPZxageijcMrZ6SEE1X3pArDt7VUuPMl1yyH/eU8DAKsZzIwYnY+J9iZx4h4sAQXJv3ECTXAwvc7hcdAdOZPGn1QS/0tl5ZV+eNXWdcV/KglduPqEOrjJRj3+5j0D40AhuCMWC+Mhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCLQm9FMKtJMjBMaBxP7B2O2if8dRGJIhhVeRDVSeRY=;
 b=iPAHD5JEjfoAPnpot084ZcK0CMoJXR+weGeIrvbC42/DbzTNk6rK3/W34fOgOFyj8MMkhHabBnVt9ngApV2FGTWFyM39Zxgl9SkHmuWmjokW6H3kzt1eEBpND+pt2OeGwMaRNIJ5b9mR36V1t8JW04RMcs/FVEOs04OgabQBjW7Lw1Sw2sEOy6zyqSdu8heSTnSNS7/FAKKejzQXp8OWzq7xsyFLYwy2BgCKMOwaTtLEvTw83gxkxch2AIhpybVgyqMMDFaz6E/CArI32VaoTqWOh4zVMSDM4R3OeApd2IIhhVpWtCOdmG8r6tdSAC0PX9mCiWqMIyf2Uu8eGryiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCLQm9FMKtJMjBMaBxP7B2O2if8dRGJIhhVeRDVSeRY=;
 b=aOnpo30EPRkU3rbaxGbn8SmP0LGIqwHu+tmiBYvmCJb1CmTyI0cfy9PcUQerTnY/Uvq523nFRt2r/aqQaBLEFLPx+axy/28PjLJs2RdOcm0tBVzdKLBv7W6HAyI2QGEEh5ATywnV/tqUVzkLvQTHCeq/FRbv1HzowYAV+hM5X/rlUcrrzonf23xUS1I7MnIL/1qsP51Lmjg+0jWvMDNLPNz1raeB5xzkZoQKK/axE7w0TYiw8fsn1i8vPco5M1FjQ9K6CiezB4D0y8DWYMWO3HjQJIfHnJ0GN1vbhiMzqakm6mlFpzaHwespm+uv8oa8EgiSufi/VylqvxsoC5DD0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 15:33:14 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:33:14 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 21 May 2026 11:32:49 -0400
Subject: [PATCH v7 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dma_prep_config-v7-3-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
In-Reply-To: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=1239;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4g4bYv7hszCtOOju+tB1akaHeHJJOwC1TTsFpz2HVcY=;
 b=/tPQeQ6XAvft2vregRM9KhB8xVZ6KnL6cJGDsU4pCsaeQXnvc7N8krUyf8m2hODLNiOMva+Hz
 1IXZ+Y1K/PdDNI7f4K65qnqZvbBh8A88pEM0Gn450oNms8Z7C921+S3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 94777b5c-88fb-40c1-c6ce-08deb74e4607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|921020|18002099003|56012099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	tJpJ1ZlFE8HQ+u17tQcQpeIfugHZQFbSguWjpEBBaMz7kuDA6WDo15IevP7JAtWimFl3ge8OEToxStD5oPOffCb+eeNqoZUFfyKiGofAPdUsuaQcL0sQqj5r+VoffaepPv8v+OKdGcHivAXGjtj4Vl7PjDJZIvqEfCJSOviXC2O9y+D/o+IeSUcx5uej9BYVFgX8pAvJMnuknzmh9zbufMBun6tuZQP/yw3U4pTZLR8PeY9VK+QN76nTeNE31LJeXs/TIMuDBvtquCO7xIoCbqY8UPpQvjy7FWve1VB7/cU6GjYS+UieZaGMnbBn0dlLTHUP2omnwHD9YIqsvu9WZ+QwMvukPGym6SDJEhIfRMZp37NOgOBmAEphAH088Ww8wjSdWOtLEsYOtHKSiqDNInn/ypTE+7ohbwbv9L53emvj2Ru6GhTFR2fdFjGjz/sl1pnFW1DtRKgk/Fpd+Qcw3B3pi2kWQauSSXoLGybTVHxTjgwU426a7GDFcQ+Oo+LWNzzbrius0afmHycxAYqNiVOP97sfvEJGHo/hRntIBs53psl2ssn2JQX6FVbISyrCLDpUGFxmsD/hy02MgHcj+UVOJ6gA4bXQAYi0CtWoDhlcQMeaVZajPf5G11zyjcpR9YyHzGkHB8GTJ4iYMDyK26ORdX1aPXMPE6RJHIE67ZJNhLBrx/twXibHpMD5ToUpyb4Wx7Vt6KPx1+/0FquKVxMpvZVhtvUijJMeV8thiCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkNrc1VWSXNZRU1udkExRjlqOHlxY1N3Zkc4VVJjaC9IbGRSdWd1Y3pzQUts?=
 =?utf-8?B?MEpDd2dHS3h6VzVGSGdWckhob1NJb2dSZWN4d2JiaDlrelhZSi9YOS8rMGZk?=
 =?utf-8?B?QTd2NW0vNnhVTmZTa2NaVitmWXdYNGJ6RUcvSTNRRVkybmg0NlVickNPN0U2?=
 =?utf-8?B?eklEcWlGQW0rZWdWYzBoY0hvbmFxUHZxUDhmbFpNb25JQUM3STZmNWNkZTNl?=
 =?utf-8?B?REtmUUxDQnN0Rkx5dG1QZHJlRnNSR0gwTmJ6ZlBqQ2MwMXhEL1VOd2RLbjJ0?=
 =?utf-8?B?NnNYYVRpNTdnWEJKbXVMUFBaZUF1Qk9STnNQeWVjNFpFa2h2UGIwM1ZwRXJ1?=
 =?utf-8?B?VTdZVWFiOHJkTWNXY0dHcUpVU05JY2VFc3pUU2c5OWYwekplNVRCSlppdXdF?=
 =?utf-8?B?L3FaVWFURjVEUTBTVnF4c3I4cUhoSytFdGhPMkhVNGRla0ZadkxjNlRtbVVq?=
 =?utf-8?B?WFFxUjJaVnpTcktuYWZFVkl2VXAwT2k2VVc2SmtFTU53djN2RXpzbVlEbjA2?=
 =?utf-8?B?T0crcnh2ZVJuMmlVR3lzVGlnUlA3NlVFRGYrdzlSVHVyblpoWmFCMWtwdFBy?=
 =?utf-8?B?dlZwbG42NURMcHduYlVDSnFlNnhUV3JVQkRSbS96Q21kc0FSdisvSmRBNStV?=
 =?utf-8?B?M0hMazU2Vmo1QTdPK0tqd0RSTk0vQmc2UU1pVU1VTjFPaGc3a3FzWkFxMmw5?=
 =?utf-8?B?R2c1QnRGcFJ5bkswWm5ZRWQ1am14L1U1RVdKTElSMGFYNSs2U0RzcWpwemUw?=
 =?utf-8?B?dzlwRmpwNHVPclY1bTZFSTlyZHovWXh6dnE1dk90b0Z4LzljVEpNNEZDcWxZ?=
 =?utf-8?B?T0t4aUJSNkp3RXBwSzRjRkFockMwWG40cW1RbmpRSjYwYnVVZE9EenRqdmhE?=
 =?utf-8?B?S1lyYkFxTEhtN2JKcWZuSGZSTG5LK0tHNWVNNXZXVUl4bzJqWHVCbklybXpS?=
 =?utf-8?B?RnJQSGd3MWkycGxzQ2h4Ukx3YnNYN0JNbmFNN3ZpUGYzRDBhaE83RWU4dVRF?=
 =?utf-8?B?a3ZwYml5RWRjdnlSc1ZMRWVMckZydzQyaWRBV3FBbW9TcjdjVmkwRjZuTTcx?=
 =?utf-8?B?OE9Cazc0V0JSa2NmdmZRZlR1K0RoZndDcmVhTXNZZUdBUFFCcmtEa1dvNml5?=
 =?utf-8?B?YW5Rci9jL0s5cjFUSnVIcjhOZUh3Ky9KUlBXei80Z1NqNU5lWFd5MWpGR1BR?=
 =?utf-8?B?T1RWbkFhM3NkWXhiNU5PYVdSN3FUR1VwY1V3TE1RZmxERldmeEV4eDQ3bHc0?=
 =?utf-8?B?QkU2Z1cyUUtydjc5SnpVckdWOWkvZVRUbUlVV0JiYlBqN2FtU0J3b1JiK3FK?=
 =?utf-8?B?azdEWkxVRnM5WTNBSU5YYWIxWUl3TTRJRkdXMFBuOE0vY3NJNHp0RWhnRGM0?=
 =?utf-8?B?MkZqbWh1SlEvczIyY1ZYV1kycGc5T2N0Y2oyRkVtNlFUdG9JbjN3QWQ2ZEZl?=
 =?utf-8?B?U2VzdDJ3U2pDcUdieFppY0o2VHI2dnFDTFFWSk9QdjlxSWNXa3FtaWgweTRs?=
 =?utf-8?B?L3pWMHBtN09wNjdhYTRDc3kwUlV0OHg4azBuM2ZPM3hWUFU1ajdBL3RPWVBa?=
 =?utf-8?B?S0s5MlZCN2MwYXYrR3UyTEN3R2JzQVhNMmVUNGEwZEc0NnhNRTM0RStlR3hj?=
 =?utf-8?B?TStZME1PWXRUSzlyRmJ1L0RkK0xNRkZFZEhwYVJSdXBzMkN3cDVrQjIwZGdz?=
 =?utf-8?B?LzVvVkNxM0ZvM3dvK2xhU2k3RnlpbjUwUDNJcDhnK29EeTc4WUljWSs1OUxY?=
 =?utf-8?B?OTV2dk9Pa1dBU3l1ZlhwcSs1TUdQT05Lb1dRUzQyOGpDUUJSbWRKaDlRSW82?=
 =?utf-8?B?S21WRFgxUkU4YW12NnBpa000dVV5OFVXaCtvUFJoc0FjTXNSRjY3WXNpbEho?=
 =?utf-8?B?ZWo3b1hucmFBd1RRR09YSG5scEwyUTNwN0tqSkMvWXh5ZGlnQURNQkMxQWhz?=
 =?utf-8?B?cEhwZFordmhCTkRqR1J5MGVmVXNJUmlxSmhPR0E5SDl1ZXB2eUlGN1lKYTNU?=
 =?utf-8?B?YUJXdXk0WEhvTGRWeUY4MC80OThYNDR4Yi9ZUEdzZFI2SmNvcytCM29ZN0hX?=
 =?utf-8?B?elpQS09lZG0xTDFqTVkzMnlseEE1Z0JpUnNZWE1RbzgzaHhNZ09lanU4M2dj?=
 =?utf-8?B?aHhud1VOZGlPeDJ5bDBjSnE2RklUWUg1L1Q3Zk5SLzN2SGJuMWt6Mkl2aStn?=
 =?utf-8?B?NVFjRk1hbGtJZTBYaG51WDVqT0JtVGZNbXYrd2REVEt4N2h4bXJJamdPb09G?=
 =?utf-8?B?b0haTGQ5Zk81SlZiZERJUDY3WnAzMU1RQ0VrU21lUHdKOXNoNjd5c2w5S0x5?=
 =?utf-8?B?OUlJOTVHdFlwYzVEYnFCMGZud0xiV0JFcko3ckhxUElwaURjYnNmRkIxVHhn?=
 =?utf-8?Q?fcATZhqckOXfngzg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94777b5c-88fb-40c1-c6ce-08deb74e4607
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:33:14.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tb/+F88gpBsNBnbZxI3/EtyKjaBKVu6R1VmjzZGJkr9j3w1n1gmg43MeZCrJ0O7COHcPyKwFsfdCaijUTFWZnlSxHvTifryTw3qRltrKSn56IZ5t/Z3zVhdOYrKsR7UV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9654
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10681-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 0DC5D5A8F74
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


