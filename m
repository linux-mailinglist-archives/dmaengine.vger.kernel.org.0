Return-Path: <dmaengine+bounces-11699-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2PdVLTRjOGpTbwcAu9opvQ
	(envelope-from <dmaengine+bounces-11699-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:18:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AADC6ABBA5
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:18:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="v495/cqw";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11699-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11699-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C4B3021720
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 22:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58447376BF7;
	Sun, 21 Jun 2026 22:18:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3381DC1AB;
	Sun, 21 Jun 2026 22:18:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080306; cv=fail; b=mPQ6rQnUDmiOHbeWluQktopaUuusVOeoPQucZ8lyI1Jqkfle3sgyRs126UlbuyV3oq+phyRlfwnU0whwQ9syRJAYjEYEc8PyZV82Rb2OiRVMNfkSZumXrhMZ1bI42BRqwBlL1Gk3J7yUdI2/CGQwVtBBJCj8iRLkuqDXHF9HOeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080306; c=relaxed/simple;
	bh=7JHmk1TzWUvtWg1BacEwKBXNW3r1ibEsZJqLtEEaioI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BUvLGuMu9+VUOXnOdVEfUwHmGnmiD28BEoC1tplU52T+XFrej9FsL+gQpqTrlMSanrTXGsEq/TjgnIXhWyJ0gnRcHq/R1LJwK9+VWmuwpPGqaywWkRowvtBXvQwABLZ/wCyKpMKhCYDreJDAOHo+9qfwRzRdsKPedsL6cVksJqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=v495/cqw; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5yQffc7NFxGS1aGlmDHRdM8kUqskOqmJpa4ZrkVnUhzfStny34TUFGf3H8NsHeE1rFecLRp14k80gRrMyG35hHTFw4KfHGKTTJKkAVzlYWczjAMXWBprQEnebNXtzWl+0TcJWaJcw4aFCLPXFmUWgJWotgBKr+zX7kF5U1t8Fs9PLgeTmCN+UYNwWjCrkKd8/XQnZhFwWa+dloQT1FTT4FitxIr8Gee/4OwOZVjPbCMvNv/3NLlGm5p3M7rss32byKrmKpexQhYB2HCT6lf8r8Zd9U8cK/vu9K4QobcFw8/Oa05Bq6FE80MqGKSLpGzkUBeY/ZAETlFXkB8Z0+wIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPE3uhcVc/DW7p5y1qyXaJBjWmMMK39ckH12CwXqSx4=;
 b=y/uXzAzkR8AwMi6PY9ARGb4/9TzPmyaAE1K9Dp5TnfLbT9Sl13PiTWyqSpWwFOxJJVTVJcxw727zmQRA4IShWvO5/ElkTY/W6vSDK4gxz9VMnXObjWei1noTs+j5aAOdzPDpADOYiGx8i5QA+yuF35ZZE5BUevH6+E/teTPSiFUn9QjUlcRaaz/1hkywQg6l/iPI+T+31LA9EMMawJNMWImMCjXRsTORVy1qS6CU09vgWZD8n1xZSLJXgC4qKmd+fXwBg+bnN/u1ieawzIQSmZXjUO9gGkirykPgPgjsUw3v229ejG8Uf1IbWOMeWGKuVm8vsmoGp8/NwGpTq1jVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPE3uhcVc/DW7p5y1qyXaJBjWmMMK39ckH12CwXqSx4=;
 b=v495/cqwWzlfv+Bi3x5zEFnb8JI+h/6lbmfDJL1ElRBkbh+4IMQjfEHNGBsrC93c5vrWZlVvVJv/2jrH9MVZpulM0s3OUQNCnPOisr11ZBvfBm+wOrv40CnfhyrPqFTNx7BSzDC+XK8OAuod7KKCz/K2cJeU9f0+H4oYunpOXQLcNz630u60QGkzJ+r2OqdWU1vc0qgjCHAPtzPpzXoB2fo7JisB2j0xOYtt1fWaEsUo0TFQ6XSgkOL7UBcDZ5dGw7mowObEx39HRaOBvo9Wkzp5ggd0S8A7e99cGKf4BOlN+cNURG+3Y4tPwJCMQs3r8funumBsMIi3dlM4Coagww==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by FRWPR04MB11246.eurprd04.prod.outlook.com (2603:10a6:d10:171::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 22:18:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 22:18:22 +0000
Date: Sun, 21 Jun 2026 17:18:10 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dmaengine: sun6i-dma: Add num_channels_per_reg
 for flexible interrupt mapping
Message-ID: <ajhjIvSTcimv8QKZ@SMW015318>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-3-340f205891cc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621-sun60i-a733-dma-v2-3-340f205891cc@gmail.com>
X-ClientProxiedBy: PH8PR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|FRWPR04MB11246:EE_
X-MS-Office365-Filtering-Correlation-Id: b93667d1-58fd-4c97-ceb8-08decfe30142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	o8Y43KjRONVevY5ET7LaUJYHInhy8hHwxPC5i8VWktEFH7FbnwEWEXRGPid1b3xW/qs3oE2gddm4GCc4y5eCy79f43d+aQOoKWPGFscZPPQD39+tY9hY0+P45mDmLFU13FGfZkGpfVWd57IX6dwjaXtwpJ7QTsZZD7HlziDymYW32kEUlGmONgFpHj6sjslBUkA7jrEhmDU593snxJVY81PKs0MHAStTcqhBnkhWF8htG7ucojoPIXgeJ//L+TGFMu8bRHwCMlbdqI0Ko5PRYw7YhWEiW7AreRK8QggTiARWptyUtnK7QyJVzvgazADMqFu3RO6DHBGioRqT4tN9pn1zHJZczB0SmVjoKcq8mRMoH8MvYIko0hOWml8QC96TJ0aB1YsophKETxaJjzPF0aGXUFnVbgjENuZCx1DzXEnUvE2rJ8JjPrePPyiP0oXAsq8H6+Wnf7hWDN/e0UPt9zuPwlbxvSXW2GOMUUxnGYZ7QeBfPSG08xMc90DivSYU5rdlGzgRpUgQvfWKY70zg7Y289rt3OnGE0KTSUUVlmTSjIysNnadIwMo3VxdbSzQ+vNLYz98im8eg3QbaC1E3hR3htzPMFPW9rPkEwv41hSC+HxFOrJIklYBd+dH/71391/+FiOZWm2+0J05MtkBJlU3Wdu5WqbFBZ2qKVj/gAo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?05PX6ZGEq5ttRSMysqpSUfC5QIgEKKYcEfjJhR0D4P3NwcryHK3FRrNRp/T0?=
 =?us-ascii?Q?cZOSwQM6aFZyY0Uv76MLyZhaFlN1LJsfM/q6UbdaXRIdax0FUR3VO/+Zp+U3?=
 =?us-ascii?Q?g67VCBt5+pLlgyb6Y5sfHHc3f8VD8XMLEm/BwYunKPMedE2+bPZFpr2D/pC6?=
 =?us-ascii?Q?oUIdAI4omj4HLEmNCztTC3E2bBR34cyDgP2aHxQSl2lPvY2DG5RPv8Z3Fh58?=
 =?us-ascii?Q?eMw4Fso8WZgO1Ps3RK4MLUcnP9BmKKHMxe8zisOsv329WPX7RhQ4T2Bv0nlO?=
 =?us-ascii?Q?0TUWqCInZ0oHVOlgKpyy9b4Oh2bdYYY2FSM7KdY5LLCa4Rb8E+yLp/Ov1L9T?=
 =?us-ascii?Q?PfdfCxn+wKIB9T324gBhGuLZEujuDu7+7Uaxso1sVnBe/hw3blnBUR4h4eUY?=
 =?us-ascii?Q?BpnmZuwmlJ9uTo//7h2JhYwVZrbwXYpmowe3H9TInU6EY53hAcDnkL48GvBo?=
 =?us-ascii?Q?HlcmmL7/mQRbJhRUbaojuHls0CmJvfoQ/BdRImjP+p86WQ/NFd2AW7ok6wsp?=
 =?us-ascii?Q?SyounQxf2kiZ6S3ru8w/2nMoOTVoHqd3Z0jB6EQA4C47d8SrU4LHxS+KJ+cn?=
 =?us-ascii?Q?YAPbjB71HeP53Lhzz7gwbUnaWHQuPCSjW1c90Y3gLwZtoeV2jBFlNOWQsMJZ?=
 =?us-ascii?Q?fO2FMQ8phHOQd3fPtqARzTP+YLredRoMhqjlBC2wmzAUBc/j+qYY8HhUWEPm?=
 =?us-ascii?Q?av3xWtHO3Lilspz0vqN/UwmilRQIBfXwDa9YFIW9M52Cz+6V9tdqTtSRUXl1?=
 =?us-ascii?Q?kgWr/QQ5kUucvvj4XhM5DEi9rQ8ORaOYibxxIhFvdTdb9wthOiHslh6BT9LL?=
 =?us-ascii?Q?61EKJ1Wl2bJZRfEukiTVU8W9dSbVyJUxlZ1Ps0gtc2XqCsS2bpWZfxu+a8tI?=
 =?us-ascii?Q?F7xR2PQzkp1MobJWbHW70hu2/IfhK0dZ5EIbDVSrHHZ0A2EEe2HGu/TltvHS?=
 =?us-ascii?Q?Qdff8sF9Xb6NRvUzO9gTcwWdddhyVgFiMRzRmuCU5nwqhgC6kcoVcPbOJNE3?=
 =?us-ascii?Q?+AF6Ts9qRwt0POtcVDOqKpEECAtuYID+aKg6PuqN63Jrw/BWeVf+rNlksJjb?=
 =?us-ascii?Q?maqOGPWVECMIxwyHTQqYEzaiqJxd4+XYuegDwPeyEwJ77x9SPRwrU8MXPwUR?=
 =?us-ascii?Q?0qdM0y73EwSXJyflplxPOX/lpYGIjcyvBoumE8tiqDcpv0GXFTbBTbJdFeq8?=
 =?us-ascii?Q?ongrPLDyk4swD/WOCI2E1kHfT2uQYd8ldpnfU0z8vNkcIbbWWNC7w1ZvBMya?=
 =?us-ascii?Q?HdA6IGSidAV9Kd3bu1D/JmqQZoNstaSKAFcQFp4SWdUxQOmtEAsZQm4XCyFf?=
 =?us-ascii?Q?InLmp2y8jb2BXGIMVEaczJHbs5u6P9YwOAjxBf+rNXj5IsVgFxsv/GVhIjW+?=
 =?us-ascii?Q?fSs4GMbUR4b1TTT+0K5OQyqwd+JO6iFmR4hTF8UGLgzS2LD9xbgzn1VMHgQy?=
 =?us-ascii?Q?ZQFyo6E5CJ7SCbZP0wCLRgqo0ob7AqqR/ihkEnLChTIzdhK0Q+lirphMfeJ4?=
 =?us-ascii?Q?X6qXdhQNK9TQjHB4FdVxp1t4em/MJNmdGjdzjxjLnFOchRzxnTEGziR708qD?=
 =?us-ascii?Q?fIm5CA2wJwOsb2pZm1cEqzQArTV89ki1K/DiaeUy+52wKf07twuai+oGdcTi?=
 =?us-ascii?Q?nC+l9TAEcz8EQPjolMw8zPTWr9YjpjmhhxJBOme3YIx3nzv0zdNfQt5pNfdY?=
 =?us-ascii?Q?jvxuer3PvOpm3S/+df9kikGqxyMFedo5ha0aNV2P+RfPRIrIw9+e+4yXalwf?=
 =?us-ascii?Q?H2Dlk1uRqbAPdxhLYtftfVLwaSYywJvbUwgt59KYnmt5lFWfJpx6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93667d1-58fd-4c97-ceb8-08decfe30142
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 22:18:22.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeVBoCP0mL4/iSxfviNqZ+IeRIekjSg4HlFueOS0odpJ3g4ZdhL7dvY6RsM52upUXI+M3UcdCQVvSbJIiQG2pU5lS0fdTPq7AyjfXneINj+zi+sJa/fKC5Me5Ce3XdHO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11246
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11699-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AADC6ABBA5

On Sun, Jun 21, 2026 at 09:40:56PM +0000, Yuanshen Cao wrote:
> The previous implementation of `sun6i-dma` had some implicit assumptions
> about the number of channels per interrupt register. Specifically,
> functions like `sun6i_kill_tasklet` were hardcoded to only disable
> interrupts for IRQ 0 and 1. `DMA_MAX_CHANNELS` is also not in used in
> the past, and the old SoCs never has more than 16 channels.
>
> The A733 has a different interrupt structure where the number of
> channels per register may differ. This patch introduces
> `num_channels_per_reg` to the `sun6i_dma_config`, similar to BSP, to
> make the interrupt handling logic hardware-agnostic. It also sets
> `DMA_MAX_CHANNELS` to 16 to align with the new BSP code and ensure loops
> over interrupts are correctly bounded.
>
> Changes:
> - Change `DMA_MAX_CHANNELS` definition to 16.
> - Added `num_channels_per_reg` to `struct sun6i_dma_config`.
> - Replaced hardcoded IRQ register calculations with values from
>   `sdev->cfg->num_channels_per_reg`.
> - Updated `sun6i_kill_tasklet` to loop through all possible interrupt
>   registers based on `DMA_MAX_CHANNELS` and the configuration.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sun6i-dma.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 9984b9033cbb..196a0d73b221 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -41,7 +41,7 @@
>  #define DMA_STAT		0x30
>
>  /* Offset between DMA_IRQ_EN and DMA_IRQ_STAT limits number of channels */
> -#define DMA_MAX_CHANNELS	(DMA_IRQ_CHAN_NR * 0x10 / 4)
> +#define DMA_MAX_CHANNELS	16
>
>  /*
>   * sun8i specific registers
> @@ -151,6 +151,7 @@ struct sun6i_dma_config {
>  	u32 src_addr_widths;
>  	u32 dst_addr_widths;
>  	bool has_mbus_clk;
> +	u32 num_channels_per_reg;
>  };
>
>  /*
> @@ -482,8 +483,8 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
>
>  	sun6i_dma_dump_lli(vchan, pchan->desc->v_lli, pchan->desc->p_lli);
>
> -	irq_reg = pchan->idx / DMA_IRQ_CHAN_NR;
> -	irq_offset = pchan->idx % DMA_IRQ_CHAN_NR;
> +	irq_reg = pchan->idx / sdev->cfg->num_channels_per_reg;
> +	irq_offset = pchan->idx % sdev->cfg->num_channels_per_reg;
>
>  	vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
>
> @@ -575,7 +576,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
>  	int i, j, ret = IRQ_NONE;
>  	u32 status;
>
> -	for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
> +	for (i = 0; i < sdev->num_pchans / sdev->cfg->num_channels_per_reg; i++) {
>  		status = sdev->cfg->read_irq_stat(sdev, i);
>  		if (!status)
>  			continue;
> @@ -585,7 +586,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
>
>  		sdev->cfg->write_irq_stat(sdev, i, status);
>
> -		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
> +		for (j = 0; (j < sdev->cfg->num_channels_per_reg) && status; j++) {
>  			pchan = sdev->pchans + j;
>  			vchan = pchan->vchan;
>  			if (vchan && (status & vchan->irq_type)) {
> @@ -1116,9 +1117,11 @@ static struct dma_chan *sun6i_dma_of_xlate(struct of_phandle_args *dma_spec,
>
>  static inline void sun6i_kill_tasklet(struct sun6i_dma_dev *sdev)
>  {
> +	int i;
> +
>  	/* Disable all interrupts from DMA */
> -	writel(0, sdev->base + DMA_IRQ_EN(0));
> -	writel(0, sdev->base + DMA_IRQ_EN(1));
> +	for (i = 0; i < DMA_MAX_CHANNELS / sdev->cfg->num_channels_per_reg; i++)
> +		sdev->cfg->write_irq_en(sdev, i, 0);
>
>  	/* Prevent spurious interrupts from scheduling the tasklet */
>  	atomic_inc(&sdev->tasklet_shutdown);
> @@ -1181,6 +1184,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
> @@ -1206,6 +1210,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
> @@ -1226,6 +1231,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
> @@ -1255,6 +1261,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
> @@ -1278,6 +1285,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
> @@ -1301,6 +1309,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
>  	.has_mbus_clk = true,
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
> @@ -1325,6 +1334,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
>  	.has_mbus_clk = true,
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
> @@ -1351,6 +1361,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
>
> --
> 2.54.0
>

