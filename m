Return-Path: <dmaengine+bounces-10372-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOwAGZhbA2r75AEAu9opvQ
	(envelope-from <dmaengine+bounces-10372-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:55:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F657525384
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5B5F307C3E0
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47F03D25D0;
	Tue, 12 May 2026 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RQdajMt+"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF103D5C0C;
	Tue, 12 May 2026 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604159; cv=fail; b=TyymKM1LeBA8YMMkHYV7qUDRq5RHNGL27yrF2UNLdIzTK2UH++wFd3yyL0bGUj5Nl8mnUi0ylYrN5uaMZ/XaNMVhH7CD21SSGRdsGyhtP8U6XpH8rBa3oDAiUKYcojnheeAs2Yao6dpifqAnskzpFCs9rkWCM9UHvnhRma9In28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604159; c=relaxed/simple;
	bh=p/Vc9KAo5kQyFpAdBK4zzRHhRAxlG2Ins3h0P7Wh1b8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BEeebcMVP9JO1HodgOytrS4y/5+vazENev9OwpSWhwEyvZkSDv/vX/x5gaaQRjgncBbNgUEKCCOhK8fyO1EtmVbG5GK89fRQ1vuKLTiZ7Vdhb9WR8Brt/uovxXaCP4UEg02rpvEaZlnHA932CCd9NF/c0UgcAB9jZ5UhKzX1KkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RQdajMt+; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm8s8PlX9k+U5yqfhuxyBe5cs+io4TwtiHxNviWcVG0bjHDhJ99BT3jtvu1EAvZBb2jWB0Of4Hn6UB8xZ8qLAmxUDxrDjosPvg7AkVoBvNIvTyR1J/DF48125Jig4mRVzWby9BTg3ymyN5rvT2pgJNMUuJMKLBUvNYCTGZfaAEg+B74IVxUwL2G8kkjkhV31T6CeuHLj28m0TqIwyspXn+g9xpbUvjufXr4MJ0HWEfeyeRljgNxmzC1eIehA+FX9zXn+Na3Qvn/SMuVJkxvpsnikKKKneHfV39WA/pcY9cGfaTVpVtz0QblY+b53oO0Cmvgw8OTvdLZNlbMOBPYz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltJbp/fFrJIDJOJmY1ZMyuaUFQk5k0Nwe2SEU7RVz1Q=;
 b=NcMkmhKDK90J5yvsb3gg8h59eVauy9yDI2FKg7HIJ4aMfqjwVBe6iLK15G+cw3/yVL3QxH9Igkle25DjUDNeRs7L++6pKHHN/9QemPsYPV3NJF9j+iXuExIfEjL4pZr/TCfAVJ3B4HPvPVXVSkhGGMJX9uskq14lpOCLUr8ScrlmuCFBC50oZ/X97UlMzcTFUsbq4Vv7aAFgNrW6yNqlWxYuuH5INA7iMb2W1uexgKZxituz+S0A87UQD6ZwzK/dtM4EtF7JdkFnGqFJwwa5FjYnbM5DBB0RMuLvOdIm0J31zQWO6KqD2Wmxhjpo70YEu3V+Tb5x/ZJiYaBf5pNiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltJbp/fFrJIDJOJmY1ZMyuaUFQk5k0Nwe2SEU7RVz1Q=;
 b=RQdajMt+wKbCIrUMZw1C6KH0JWgvt+sSvSNhDdIMiOPbrBdcLdSle5rrvGlCu4F1ECazshdHNfl0hO+zXhdFiqwp4gFfqEg6HugWcUrwpmSB1RSeUhiChjxO93bmeUUx5V4O7DtHbef1C9jsPd5ITBae7UMsodhRek9hue/IpXy8H72MeC8ue2aD7fFb6YQafO/It97k28skvTbg5ig7kPTKd+iTC+1kilcYpetooOTpPcq9f8/KOOfORgbw+eRNuvLp2y3REdPnv+yZcXLcPDdOSY4RVqBuRslMq6dG1Bob1imo56xfNM7uxEcJ+OHfyrRql3rDPFbWT9FmXTgcrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:42:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:42:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:00 -0400
Subject: [PATCH v5 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-2-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com>
In-Reply-To: <20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=5603;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p/Vc9KAo5kQyFpAdBK4zzRHhRAxlG2Ins3h0P7Wh1b8=;
 b=2L13yek6lg+1u2OH14UZNhIgTTw/4zR8WjD7Pkj6phTJDnmX2cDAC06ortz+HtfSflECuQeHI
 XkC7TkYmFy2BCxEJT0X+FCX2xXtAPIgghRkOh17SVoXVNZP4XeSiFZg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: 565c638f-2c61-4b32-0324-08deb04577b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|11063799003|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	uoEQcncIkh/4HFh5eJsnoOJmKKIKtWyL6JSTpyKrsipF0qJKlGCocwwe231sk+HiZfQD4vXCPq81ZmPEHMOZRqfoIQ/FfeQkliLnaMQ9F8EdJHjgdAUjDLSBeBnqBz56ISX0QLA49B7EeZPf5/FjEe3QhhF7hUNRjgFSaj/hfCc6pM3cFV9n2KSi0DctNhnIt8x3E1jDYyTYm+La3vZYY0zSKwoOFtWHh0+nnaDSXovLWfnQEz9jDIEvkSD9Lnnc+AR2BXyaL+bHLfPk7/gtfwmMTeQZ9VS5EmgvSnrOZzU/9clonjhemTAw3sL0slYkQj/cPjPV0xOqkW9n59b4ErqXAswOtOoyWUN87HfI3Z1Qq0Rm5wUzysnDUj5P1brkCRprw88xLuxnWM55PFg/K+zgnp7yT40UyGq0xv/dU2xd0xT2VzGl3w+YS0LrZ526g2fEh/db0ry8slix/knYZFpKcUEEV1IHU2SzNbS1oyKDh5uou5aLC7Ny2GzaOxeNTZ/9G1SByzQ4ACKmHF7gkLaUOvzoMVDeS/14czAl09MUWIocxh/pEvDd67uwPl6MtpNMNFn17LKDszM5vTIDDQA+C+FfXJX1cQUSQb3BQVK+slsOaEAYsE9ah+ScqWkJODLTxdXyS0nopWC90/aYnGIOK2nsLaLVq65IXYOeVJZnOFUeGIF7flvfOQmhYqEo3pa56Mcr2sIyyFDpB7ZS8sscG9GU39iVwQW9yagXQR0KJ/UB9UgFRoU/M9nohE3TOze6H5R56KDl+elHH0VCxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXo3SVVoMkVtYW5DeGwvV3BvNFRKSG9HKzF4Wk1kR3RKeno2MTRzdExMeTdh?=
 =?utf-8?B?VFk3VnhMdVRjWkdHa29RTTI5TXBFclEzOTR4eFVDdWlJcE95RDZGSGFYeGgv?=
 =?utf-8?B?dlhFSmVDQ0x2ZmhNNlk5clJTcXRIZHZUYi9YY0lxbUY1d2lEaW5nN1UyTnps?=
 =?utf-8?B?ZE42ZzdIYmZHOWtrU1ZBZmNMbllrdzRlNVRRc3JzWHNESnJKZFdTcTArWC9z?=
 =?utf-8?B?bEt3bzFoQ2lhdmY5TmRkbU0zN29xMnZhcCttc0lZQXZINFR0aGpqTkg4Um0y?=
 =?utf-8?B?Vzg1QTEvU2ViWDBaSXlSMnVFc0R4Y3lQelpOakxIeXRWSHFRQ1ZMcVBCdG5I?=
 =?utf-8?B?c3RaOXB5Y2FndU41ZHY3S3dtWXVkU3FzbnJON2FkVWdiRnhTbTlCNzlMY0NR?=
 =?utf-8?B?TE1IeFZoa1JLbjdIVGV2YUt0VW5TTVg1clh1K0FwdlY1MDlydlN6TjAxRm9x?=
 =?utf-8?B?MGZkTzEzalNWNFA1N1NqZ2YvNDZnNkNyRnlkVWRwU3I3TXNnSVM2SjU2VytF?=
 =?utf-8?B?enQvR3JiNWZOYzFPYzNXcVdESk5ERjZSSG8yMTJTWHRiM3hkUVZ6VlFiZElZ?=
 =?utf-8?B?UkFMcFJmcTZRNXRJekRpVWNWNEJIdXE0RkZsZHA5YXI5VzhWZllHdTJJU2Vo?=
 =?utf-8?B?Wjh0YkFHMlBPekkvdG9DcC9OUHdYVW9jbFF5ZUprQk42TVhML2EyWnJFVU0w?=
 =?utf-8?B?Y3FNQ2dOOEE4VUk5RzBKVElyZGZ2MEI0Q0FiNlc4TFk4bW1zeE9TUHJEbGxh?=
 =?utf-8?B?OHNkaGk1M1N3U2NLMmFwY0lYZnVMdk5TY2VYQWVKdnU5dDh4SVd4bjZuYmVP?=
 =?utf-8?B?YU1jbTRMY2lPWWpjdWxvK1ZqaVJNTWNBZGpwdTRManQyLzZqaWw0bW5vejRH?=
 =?utf-8?B?V0IwWGhjYUhrK0ZNVkxvY3B4cStKTmVRZFNmcUw3YkExMTg3b0tLemNqcWMr?=
 =?utf-8?B?S0d5dVJoL1JkYlhZK1IxeGk2ZFlLWExFMFZwUXFrd3JKL2JrSmUyT0JrUERz?=
 =?utf-8?B?dEtsa3Fka01xbDJjWVlLVHcvYkRhUjl3bnlRQkVyTC92a1k1QmxsK0tSdC93?=
 =?utf-8?B?RXo0M092azdGSWhpNXFHQjZVdXc2MEtOL0U1V3pzSmtZQzlFTG5rR3dqTUtI?=
 =?utf-8?B?a0ZLUVAxRkdWOFFmQ3pvZlhxbTNJWGx5Q1lRQXdzZmEvVS9IOVMyQ09KWnhk?=
 =?utf-8?B?ZUd0NmE3RGI2Tk1FZGFESnl4TllDZTA1d3lCMS94SzlVZXBoUXU5S1BEdTNG?=
 =?utf-8?B?WStyUVVuSDYzbFJaa2txKzBiNUlLeFVRcm01aHBmNHRPMmV2RXBUNHFGRkJX?=
 =?utf-8?B?L2xzd0ZpSldLdnU1a1J1NUxOTzMrU3NCQWJ3eCt6SEhiZ2pzSjg2OTRRR3B5?=
 =?utf-8?B?R1NUa0RjM3pNWmJocm9XZUx2YUNFWkJxUXFVNmJtTjhBTjFEN0RoTEVnbWo5?=
 =?utf-8?B?bWpjOWh1aGlyK0tESitEUjVvM0FCeGl2dnM0Rm02WUI5OW1CT09GK2xTa0ow?=
 =?utf-8?B?UzcvVVpZUHV6RmxSUlhZb3Q1WVBiVzVHSHJGazBtK0pXKzNEY1YrcDF6TU9p?=
 =?utf-8?B?ZENRQ1ppYW5ORUFiRTRvdEhKRldpTGtiN1pDRmRNb3Fmc3prb3Vzb1VTWEsx?=
 =?utf-8?B?Y1RUTCtHaUpjejNkVGlGeTZCZ0QwWXY4MzNpajFBMnBUZ0hHVURYMW93TDJU?=
 =?utf-8?B?L1ZLWmFwdGRXWkRBeXQ4T1NkT2Q0WnNKVEdEVC9abzViZmV0ZFBqMWd5ZmNj?=
 =?utf-8?B?bkc2eG9ibWg0ZS9pczNjQ3NNbmgrcHRpNitFdGxUN2QyVWVadjQ0QmkrZktC?=
 =?utf-8?B?THRRenRldGJrUXJTRUVuVW1RYTEybDJUeDNNZnkxOG1KWDRieWNZNm5BRDhR?=
 =?utf-8?B?Mk5CY05pMXJLamVOdGkvcWJHM0ZqNHNQd3BPa1NnKzYybUFuVysvWThMSWlG?=
 =?utf-8?B?VmlGSjdYYzZzdHRnWEJsMUZqRWRvdkNYaGhFSmc5M0dNOGZvdEdtK3VhYitl?=
 =?utf-8?B?OW9WNzhvQ1RBc2pmTHBpY20xMkwrU0IvSWxNenR0VmZ2cFpzUVJUcVFrYkpx?=
 =?utf-8?B?alo0cnZ5bCthSjZTT0pIMnVCK2YxaURrM2RWSG9nSGdmQzA1N0RBNEZPVGw0?=
 =?utf-8?B?VmFKUVRDbllJQnBCRG9odVZ4cXh5WmZDRlJWSlI5d29UUTJCd2tDVjJzc0xV?=
 =?utf-8?B?aEpxMGlJbUl6enB5c3czR2tFVGRjdFlpWU1RVFNYd3BDR2VmQXNmNnJpdlJT?=
 =?utf-8?B?clREUFNBcGJEcVlmcTNQcUVnY0JxUWsrRUpiR2xWZE5mdUxtc05jMEZMbDF2?=
 =?utf-8?B?SXQwcTdaUEdMRUNJT2dxZ2w3Sk5IQmp3c3V3cHY4TjAvdTNMYWR0QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565c638f-2c61-4b32-0324-08deb04577b1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:42:34.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IR1DO/BVzujcbToHXzEGv7kQs8nbwch5LJYsJQR06+OBouoxvVf8kfz9Mt2V+XoskOPG+3bsYuk1FTi3Ur/1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834
X-Rspamd-Queue-Id: 7F657525384
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10372-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Introduce dmaengine_prep_config_single_safe() and
dmaengine_prep_config_sg_safe() to provide a reentrant-safe way to
combine slave configuration and transfer preparation.

Drivers may implement the new device_prep_config_sg() callback to perform
both steps atomically. If the callback is not provided, the helpers fall
back to calling dmaengine_slave_config() followed by
dmaengine_prep_slave_sg() under per-channel mutex protection.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
chagne in v5
- remove reduntant lock commments.
- use kernel doc to descritp API

chagne in v4
- use spinlock() to protect config() and prep()

change in v3
- new patch
---
 drivers/dma/dmaengine.c   |  2 ++
 include/linux/dmaengine.h | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 405bd2fbb4a3b94fd0bf44526f656f6a19feaad0..ba29e60160c1a0148793bb299849bccfebb6d32b 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1099,6 +1099,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	chan->dev->device.parent = device->dev;
 	chan->dev->chan = chan;
 	chan->dev->dev_id = device->dev_id;
+	spin_lock_init(&chan->lock);
+
 	if (!name)
 		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
 	else
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index defa377d2ef54d94e6337cdfa7826a091295535e..83e8547de89bf56424f048c316bdc8d798791e25 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -322,6 +322,8 @@ struct dma_router {
  * @slave: ptr to the device using this channel
  * @cookie: last cookie value returned to client
  * @completed_cookie: last completed cookie for this channel
+ * @lock: protect between config and prepare transfer when driver have not
+ *	  implemented callback device_prep_config_sg().
  * @chan_id: channel ID for sysfs
  * @dev: class device for sysfs
  * @name: backlink name for sysfs
@@ -341,6 +343,12 @@ struct dma_chan {
 	dma_cookie_t cookie;
 	dma_cookie_t completed_cookie;
 
+	/*
+	 * protect between config and prepare transfer because *_prep() may be
+	 * called from complete callback, which is in GFP_NOSLEEP context.
+	 */
+	spinlock_t lock;
+
 	/* sysfs */
 	int chan_id;
 	struct dma_chan_dev *dev;
@@ -1068,6 +1076,83 @@ dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
 }
 
+/**
+ * dmaengine_prep_config_sg_safe - prepare a scatter-gather DMA transfer
+ *                                 with atomic slave configuration update
+ * @chan: DMA channel
+ * @sgl: scatterlist for the transfer
+ * @sg_len: number of entries in @sgl
+ * @dir: DMA transfer direction
+ * @flags: transfer preparation flags
+ * @config: DMA slave configuration for this transfer
+ *
+ * Prepare a DMA scatter-gather transfer together with a corresponding slave
+ * configuration update in a re-entrant and race-safe manner.
+ *
+ * DMA engine drivers may implement the optional
+ * device_prep_config_sg() callback to perform both the slave configuration
+ * and descriptor preparation atomically. In this case, the operation is
+ * fully handled by the DMA engine driver.
+ *
+ * If the DMA engine driver does not implement device_prep_config_sg(), falls
+ * back to calling dmaengine_slave_config() followed by dmaengine_prep_slave_sg().
+ * The fallback path is protected by a per-channel spinlock to ensure that
+ * concurrent callers cannot interleave configuration and descriptor preparation
+ * on the same DMA channel.
+ *
+ * Return: Pointer to a prepared DMA async transaction descriptor on success,
+ * or %NULL if the transfer could not be prepared.
+ */
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist *sgl,
+			      unsigned int sg_len,
+			      enum dma_transfer_direction dir,
+			      unsigned long flags,
+			      struct dma_slave_config *config)
+{
+	struct dma_async_tx_descriptor *tx;
+
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (!chan->device->device_prep_config_sg)
+		spin_lock(&chan->lock);
+
+	tx = dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);
+
+	if (!chan->device->device_prep_config_sg)
+		spin_unlock(&chan->lock);
+
+	return tx;
+}
+
+/**
+ * dmaengine_prep_config_single_safe - prepare a single-buffer DMA transfer
+ *                                     with atomic slave configuration update
+ * @chan: DMA channel
+ * @buf: DMA buffer address
+ * @len: length of the transfer in bytes
+ * @dir: DMA transfer direction
+ * @flags: transfer preparation flags
+ * @config: DMA slave configuration for this transfer
+ *
+ * Detail see dmaengine_prep_config_sg_safe().
+ */
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
+				  size_t len, enum dma_transfer_direction dir,
+				  unsigned long flags,
+				  struct dma_slave_config *config)
+{
+	struct scatterlist sg;
+
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = buf;
+	sg_dma_len(&sg) = len;
+
+	return dmaengine_prep_config_sg_safe(chan, &sg, 1, dir, flags, config);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.43.0


