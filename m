Return-Path: <dmaengine+bounces-2104-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B998CA087
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231EB1C2127B
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76011384BE;
	Mon, 20 May 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="leyF2FLg"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C361384AC;
	Mon, 20 May 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221421; cv=fail; b=aPAKn1PScwvEBdx2VPRjZCy5apCvRuSUyBPDYKoCzCoWWy0bMh/so51r0i08TcQQMcH2xTSGTBwxzIDDO3+jIE7Len5td39kx0LMHmGWVO40AabiCZ10W0mw4hqN81AC0WgMd3QSThK3DA0hsy8MXhVJlDqvJHrZO211aTMzVw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221421; c=relaxed/simple;
	bh=tEWFhDjhtUKAug5WAg7nPU6hg6Eu3mFZf5v7yoTqdyg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uIz4bfHAwMThlYdx7y0Sd4Ygt9v6qFUWcCiksj1oY7lfLHKADrwVdcKw/yNmSJ4J3ETMcdN1Q6zrCpX5jo6xGXwnzLRdeUpdZkzdc0QOfWuHAHE9e2oUd2eY4oxee9or2zdPj4IBqR3nwywnz45B1DWjZNrKxJZumyTyVl5bAOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=leyF2FLg; arc=fail smtp.client-ip=40.107.13.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IznKnwfRA8mXeII1WCa9YZt/pWBM70ksdeXLvL7RrFaX2u8mrDg75pFoMNZYr5u73Rm9IXLq7phwUGiiBN4gkYpG0bA7+lhH5+zbAVWPtEU7V23F19vsERa0ShmVPuDETueW+C1Us/I23hKvew4kbGz3L6KAsyrc4GA6CYKWUUAkjpwODs7fjaONlBEEvghUPbuRuAlhztVa13pu25HJQktmSVGlZIoGw93URTJA4z1PPRPJdlTSSIHIY118I1ZJadWK4tcMg8uk0PxntV3VtG5ixwJ+G8jOfxmDvVe43DSvQKcdaCw4I8C/gMtFaWPybLVyy8/Rv+ddOqSeCIcipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frIX+JJp9RbZncA+FJ2gAHvej7lxIMqz+pvAH4izM2s=;
 b=QoH/9q9DpuyFAP3JIN9t3zAJ6tL8cy8giSwSzJugEyVNJ+5uaXCLeRQYZkvTZT2156mmZCW7+U9mrpkTRKFT5iBXnRAIWXqqgX87FscMNgXxdLPYeFdo3Bt6bI9M6oY2Ql0t6582iG6ABmR+60jciAuACFe6rmrs4LrDHbQRS4GyCTMOMjOG7+RLhu5zepFWS1UYHxXYWYLqe3d1XzGNCCuWCVAY4sFseOvjvKdqs3KF4zht0pppEvlZFPSxd3K9mkZEc7nzWUcEasAsn+a9aRbcMTOgwbQQz8SXDZX4FhevW+pusKEqfALUz4Hj6biQcT5JzhzS4RYWkso5ERlnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frIX+JJp9RbZncA+FJ2gAHvej7lxIMqz+pvAH4izM2s=;
 b=leyF2FLg9V3EcxVzcnJ3dAfgkC+AtfFZxigJt/Asvpqqz9k3XBswbq/G5tPpfKe9wkq02g7TMncGST8Vg/vNQH2NL+g4dikD3T9H7xJghGCmSEtGd+Bh0fs/vjuFwY3AZVlcn5EFxq2z2N+LgZ1N2sdeWesaKNO2UWpl/R9mSSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10164.eurprd04.prod.outlook.com (2603:10a6:800:243::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 16:10:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:10:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 May 2024 12:09:16 -0400
Subject: [PATCH v2 5/6] arm64: dts: imx8-ss-conn: add gpmi nand node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-gpmi_nand-v2-5-e3017e4c9da5@nxp.com>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
In-Reply-To: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716221390; l=3045;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tEWFhDjhtUKAug5WAg7nPU6hg6Eu3mFZf5v7yoTqdyg=;
 b=+80kPjSQ2gaiJ4NdiRjCgEP8xbeFyONptNY2mAx+rCy/WNaA9OaG+qls6s4fNW6oSX/0/hovs
 wqbQ6vi5ffvAlIJHhVrkgunu8jSHxaOSygj2Jridg0Ka5tcxXYEJHNi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10164:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ef792d-8d66-4f80-ed80-08dc78e757b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|366007|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmRHZitPSDZrS0huNko4RjV4M3MxMWNkdGNMMmtkY2lMNWhWNFBuQnluY0JF?=
 =?utf-8?B?K3I4K0prUVIvY3p0Wm1QaEtkR3drZkQxNmhZNzZ3YW5vQ2ZVRE1FbmhRRXVD?=
 =?utf-8?B?ODNuSlk3NkZwYWtONmZxenJwR2JIR0dCSmc1R29JQVEyQzhtWmR6RkhOSDl6?=
 =?utf-8?B?MkFVT2NyTTVsWHdXWnErd2lIMSttMEV6eTZVWWI1cVJOUHAvUXgrdlJjKzRC?=
 =?utf-8?B?V2FDSkY3Q2RlR1c1ZXV2S216KzFVS1pnSTRaU1IvNmY1NG10ZUFFNmZiNW14?=
 =?utf-8?B?a3lXQUpBMTk1VUpCY21sOGFoTm1maXdBd1BlL3ZNa3BrTjFDem1pRGM0NVc2?=
 =?utf-8?B?S090dW5uM1dkT1Avd0tOSzZJSm9HOHpoNy80eFdtd3dtWW5nRlg0UVVQcjBK?=
 =?utf-8?B?dTZYdVNxMTJNYnBTUmxVMlNjSTVwQnlNbkZ3STkxcmhDaUxqdEhFY2NKblhB?=
 =?utf-8?B?YTl5QnUrUGREUlVGeFZCM1hkcHVGT0k1Tmk1NGlhRnhYcEtvLzAxRG9pQ2xp?=
 =?utf-8?B?bVA5aVdkc1lEREhzYzZUUlVERW9oeWFOMTQ3NlRGakZEUWpEeThjemhkYUZE?=
 =?utf-8?B?d0ZMUEVINGlGK1R3Qm80TmVmMXl5a0NTNmFIZDYrNEpNa2ZSa1EzRThLZXlt?=
 =?utf-8?B?czBNTlRGWWorZ2IyaU9Tc2IrZnhIb0JKS2taVmRlYUhwelYwb2lqOVhEaGJR?=
 =?utf-8?B?LzUrYmhseDZicllsQ2JGOFRNUU5nWUx5ZGVHSHdVbWszdWpwWlh0RytEMFRa?=
 =?utf-8?B?NmlNNFpuL2NEUWdhSmZXMEpEWUdwMzhTdWpZb3IzY2xCa3dIWFdjQmtyOFlQ?=
 =?utf-8?B?YjRrcWRDbWVlKzlKR0hERHA1MXp1dnl4ZWdEMEpPSlJRTW1iSUhUZkhoakxh?=
 =?utf-8?B?VnIrOGR3WTNlT21sYVVtYUl6NWI4eHl3L2E3MjRDclQ1YlpmUVVQckY3L2VV?=
 =?utf-8?B?OUJtaHVJL2dZYUg4MkRHOUdWZGJYektsZ3FHZzFEV2VtUEh6T1dUR1lQcjZM?=
 =?utf-8?B?YWl0Q0RsN0R4UmRYTE9RSVZMSGxEdDlhR0hZbUxabFhnNUdKdVFvUjZsMllV?=
 =?utf-8?B?eVJ2dVU4WEJXNGF4UnVBZ2ZSdldyMklRbGRrMVY4ZXgrcDZPRXVOVXhyVHdr?=
 =?utf-8?B?K2NPWlBMSkU2RWtzMFRkWitCb0ZhUnhSN2lNYUkvNVh6bitoM2p2Q3d0cUFC?=
 =?utf-8?B?bURieVdVRmkzSXBIT1pjM2wrbHNhY05iVFk5RlNkc0lLMW1Lck50dTIyNVEx?=
 =?utf-8?B?QTl4SmYzRXd5Z21WZ1hsMytFMk5vdzJtUGRDRk9UZk1SWkxOM0hYc2pKTFZm?=
 =?utf-8?B?WDl4Q0F0clhFTjNxcWxWYmgwbmdtTUE1Rys4ME1yQnoyM1oxT3VSSDY1ZUlZ?=
 =?utf-8?B?UHdPYjlGM3NmZDVqc2s1TDZoTkt5K29lVWtwdVRENERaRk9MM1ZQRXpJU0Z6?=
 =?utf-8?B?MFJOYm94UittbnU0TGRSWnArUk5LSXZjUXJ5ODJsZ0lOZ2hJUHhKU3NFTjJr?=
 =?utf-8?B?TW9uUmlHaDJnUm16ZWpNM1VQL29uQVlaV25waDJtcDhTQ3IwbXdOZlBRWU5W?=
 =?utf-8?B?cVdSNlBwYzhJOVl4ZHdmOXdQUm5aSmJCcXkrSGJ4N0FneW4vbWxxSSs4NVFi?=
 =?utf-8?B?Qmt4YkQ5d2FLbXBxdGRPbkNwYStaQjB3bEd1U2toSitKaUNKSk9JRFNid1Fn?=
 =?utf-8?B?cXNYSit4a2NyVXVpeHJsMHAyc1RKTlpmTVc4L3pNWjRRWEQ2c1FreTZyMDFS?=
 =?utf-8?B?UmN4YmRoVEJCam5JQkh1cnYrKzI3NzJiY1ByMVdkRDZpcFpRNVB1a0puZHB4?=
 =?utf-8?B?Y2hjNnRwbTJ3c1VaSGpWQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(366007)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU1adzZFRE12RW9EU0lsUDJSM3Ryc2tqV2NhMFNNQUE3dTZFZzJLWnh6Z2pH?=
 =?utf-8?B?N0V5KzVRejlGeGxzUmVmVHRxUmxLeHYxNkZERXF1ZDhUK2JWTFE2alFlTkds?=
 =?utf-8?B?T1hPYmUwTGE2N2s2R2dDMStTK3FQQis2V3NUZkpSTmtYNFZOUEtQd295WTFy?=
 =?utf-8?B?NThZbndMNko5Umo4Vzl6dUxpUkFKS1l6dytIcm8ydHhtM0Z6NHc2b1pKN1FN?=
 =?utf-8?B?RldOYkRlNnZYdWFnQVE2VlFNakpERVM3YlFWOFVJcVhHcks1YktRdWh0RzFh?=
 =?utf-8?B?SkNvVlVscGJlaFhVVk51Y09iU3FDYnBNSzJJNzRtR1ZjOFVQVHk1b2xuY0Vz?=
 =?utf-8?B?d3k2Zy9NZEt1T2RLelhpZUJ2STdCSVdGdFA3cVlwZ2I1ZWQvWEU1RFBLbkQy?=
 =?utf-8?B?c0pjNTUzVGpiRjVXNVc1cXdFWEkvY3BiY0hvNUZBR1FoU1FoNlpodlRhVGJY?=
 =?utf-8?B?aUhWd0UydHJpWDE4VmxudEFsTG9VaXZhT0pjL3h4dVhFdEhidUI2U0lCWHdN?=
 =?utf-8?B?N1c0YmU2bVBncDRlQXpmNHkyS1Y5T1dGb1ROZzBEc2d6bzFJUGQ4QStvdEpI?=
 =?utf-8?B?Q1NiUGtrQXFidzdJaDhDb1pJai9zRGEyZkhMM3BpeFREQXZCMFY3UnIwaTdN?=
 =?utf-8?B?MXVyd1ZOMWNJSmhLdks1Q1dkRWVFK0Z3ZnQyd0Raek9oZTBFNGErK0NXZXJ3?=
 =?utf-8?B?STVWZ0U3Z1lMcjJDbTZCSzBYZTN0MnVOcSszOVBmRVJESkxjeHh6WVJ5aVJv?=
 =?utf-8?B?eXBIMzBLdyttWGlreDRpTlFKS2lWblpWMGx0Z2JaZkZQYXphMkxSY0JMRUlX?=
 =?utf-8?B?dXFrRzRXNEpXYzBNZVUxQms0NmxJMGllek11eXc1bklMSGpvaGM2WHpvYnA0?=
 =?utf-8?B?S3BjdUEvdkxoMWhPWDh4cUErWGU4MGs3VytjMmVOQkVVbC9ycWRLbWl5Uzlp?=
 =?utf-8?B?NWlPYmdOa3FFWXlTZUVQUEdjcm5tbkhBUy84bFVUMGJRS2JDcnRuNTRHNnJE?=
 =?utf-8?B?czdmNExkL1U1WDNDalRSd284WWxjL21iVXFrRlQ5Skl2VVdOUWptVDBqSFV2?=
 =?utf-8?B?OHhCY0YxMHUvSUV4dW1uNkhoN3VLUVFxL1dFSGdDb083VXg5UUx1VnVTN1Qx?=
 =?utf-8?B?aHFVM1ovc2FteVhWTUJ0TlN4YlczWDgyd0J5VEhkV085bFFuTnJPSGJ3TStk?=
 =?utf-8?B?c2E1QXRuNU1KZlVVYUw5dG9BaGpoMFlqdlV0NUdvaDN0UTZCcUovaGUycm9l?=
 =?utf-8?B?ak9qa05naWxwSVVueG1DcDkyY0FoTnBKZlBKZ3FFRy9LK3dkZEwyRFVHSXZT?=
 =?utf-8?B?bGxwRjB1V3RDYjhCVjlHU3dWNkdWY0R0RHUrczhaNFBVV0Z2OGhXN3VIb2Vu?=
 =?utf-8?B?Skl2Zm16aTYzOXNhd3B1aVRSQzhKRXNubFM0R3FaNXRyaEhOR3Q5S0JVNWlX?=
 =?utf-8?B?U3hFWjhEUjFVendSd0ZWRzlwbGFVOGI0dGRoejAyTTl4YkZzWDVrSmVTMnZ2?=
 =?utf-8?B?QTJSN3kvN0dXVFo2RG1KbU9QTnBtcUE1UGF6M1RHc0lUM3EzSDJhVkM2aFNN?=
 =?utf-8?B?QnNwUGZwOGY0MUY2bmkvVnZCSVZRU2EvTm9ZamZBbGhXekhKZVRXaVByQjRy?=
 =?utf-8?B?MHptd3YwV3NCTkhEK2VKenljZjBsaUtTeFY4OVdsck45NTcyUlFSRmRSTjZD?=
 =?utf-8?B?cEh3cGsrQkM3Vk5BZzBWckIyNG9URDgxaVFFVVhsaFlLZTE0ZmU4NEdoNzIr?=
 =?utf-8?B?YzN2R2trWE5nYUpNbDNqMHpDQnVCeUh5bjRRRjE0eWw5c1E4dWFVTTFXQVV2?=
 =?utf-8?B?NEJITk5wdkJWaEdIVVhYanhkTEdoRkJZWWUzQnZkc0c4a0h3d1RNa2VFUVFF?=
 =?utf-8?B?Z0oyV3dueWtITG1vTzhjeTdNZndjVm5lZzBYUlJvdG96b1dSUDl3Tmd3aU11?=
 =?utf-8?B?dGlRemRoT0FiUUlhVmlMYUlOVkNNb3RaVStlSlpBUC9XclJnNGNlUU1RWHda?=
 =?utf-8?B?Z0YrQ3Z0R1orcnNoZll4VjE5bDdjQThQOTlHQmM4Q2FEMmxjUjNrblppY3BT?=
 =?utf-8?B?WUxRN2pUeWZERkF5NmxWTWxHaUo3cE5SMHdxaUQ0eENnZUpNME9pZEoyNW52?=
 =?utf-8?Q?u/90=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ef792d-8d66-4f80-ed80-08dc78e757b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:10:18.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXqT9edscaPzS2vwHsdtM420Tk1mlz0ppxBHIr//BUNm5hUU0tFaPeGnKU7MXl40MGdR9t4r8rkrzd7rEQoP0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10164

Add gpmi nand support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4aaf5a0c1ed8a..a4a10ce03bfe0 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -28,6 +28,13 @@ conn_ipg_clk: clock-conn-ipg {
 	clock-output-names = "conn_ipg_clk";
 };
 
+conn_bch_clk: clock-conn-bch {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <400000000>;
+	clock-output-names = "conn_bch_clk";
+};
+
 conn_subsys: bus@5b000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
@@ -302,4 +309,66 @@ usb3_lpcg: clock-controller@5b280000 {
 				     "usb3_aclk";
 		power-domains = <&pd IMX_SC_R_USB_2_PHY>;
 	};
+
+	rawnand_0_lpcg: clock-controller@5b290000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5b290000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_NAND IMX_SC_PM_CLK_PER>,
+			 <&clk IMX_SC_R_NAND IMX_SC_PM_CLK_MST_BUS>,
+			 <&conn_axi_clk>,
+			 <&conn_axi_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>;
+		clock-output-names = "gpmi_bch",
+				     "gpmi_io",
+				     "gpmi_apb",
+				     "gpmi_bch_apb";
+		power-domains = <&pd IMX_SC_R_NAND>;
+	};
+
+	rawnand_4_lpcg: clock-controller@5b290004 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5b290004 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&conn_axi_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "apbhdma_hclk";
+		power-domains = <&pd IMX_SC_R_NAND>;
+	};
+
+	dma_apbh: dma-controller@5b810000 {
+		compatible = "fsl,imx8qxp-dma-apbh", "fsl,imx28-dma-apbh";
+		reg = <0x5b810000 0x2000>;
+		interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+		#dma-cells = <1>;
+		dma-channels = <4>;
+		clocks = <&rawnand_4_lpcg IMX_LPCG_CLK_0>;
+		power-domains = <&pd IMX_SC_R_NAND>;
+	};
+
+	gpmi: nand-controller@5b812000{
+		compatible = "fsl,imx8qxp-gpmi-nand";
+		reg = <0x5b812000 0x2000>, <0x5b814000 0x2000>;
+		reg-names = "gpmi-nand", "bch";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "bch";
+		clocks = <&rawnand_0_lpcg IMX_LPCG_CLK_1>,
+			 <&rawnand_0_lpcg IMX_LPCG_CLK_4>,
+			 <&rawnand_0_lpcg IMX_LPCG_CLK_0>,
+			 <&rawnand_0_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "gpmi_io", "gpmi_apb",
+			      "gpmi_bch", "gpmi_bch_apb";
+		dmas = <&dma_apbh 0>;
+		dma-names = "rx-tx";
+		power-domains = <&pd IMX_SC_R_NAND>;
+		assigned-clocks = <&clk IMX_SC_R_NAND IMX_SC_PM_CLK_MST_BUS>;
+		assigned-clock-rates = <50000000>;
+		status = "disabled";
+	};
 };

-- 
2.34.1


