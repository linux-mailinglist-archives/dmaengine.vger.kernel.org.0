Return-Path: <dmaengine+bounces-10379-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMS7B1VaA2r75AEAu9opvQ
	(envelope-from <dmaengine+bounces-10379-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:50:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B77525162
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9E10305E727
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC493E0749;
	Tue, 12 May 2026 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MG+86hmZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951363E073D;
	Tue, 12 May 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604201; cv=fail; b=X21aiclqgLXBCAfkhjOLnXR/7Bqv1B7qDKFBVAFOihYzJp1g8d6uhMgAG/YXnQJAFYcCynr+iwcZZ4f9mim6AS5Y+sHj4s/OOeTU11PZqmr9YQCVBvY618ZAV8m6zWev+chcdhQfEJ6ifFMOIiXp3ozpqrNMmyvdpS2hp4Ya+2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604201; c=relaxed/simple;
	bh=ewqGbq/a6Fri69k6AcMWiHQJDkdRRZkdZmXyxU701QQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IsxU5+8fddpij/w+N/5mNkrFn6AhSCJf+L3vkzYu1uizbZdUu6xgvCvAdWSviOjZNPZuQ9b7tLlcIfG27jkGaLC3Y+a6x2bp6H1kD7sHGRvtk+jusviWVuU9PHRYJbGztXzVHxGNXA9YoWynEslSqpGxV/svitnyc4T4gRNTMl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MG+86hmZ; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2KLm8LucDCAlNYhL5qGwowyugFo3guKc1fqK5j+TYobcmCfTpAGsr4Q2y4qdBuyufnO3l+Af7YUzleSXFOqdJrUuMehaFKFiLqFZ/soMajO3f+CJRpaNw9+dZ7YqlOs8GHsoJbLZ40o4ybfueYCdP5JIfXg27TadA5HHZdoBxcHedbQ2otlSpOy8UkQAfEq2QoPvfN6844LBYXE3ETYt/EOO8+pcVpEEmm6w6WN6GRg9wE0f/PvuhRnlIqEheKx/Z6pml7b9BwKF0T2XwmgmidnF0PWdFVidPh6gigMeYYaQZo2XAXdPriwEyTV8w+8ILhKWlzd1PL35vjlHfca9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqPY0p8jDgE74yvJfwdQ5/+zHgEN+pCu6Yjn/v91/tQ=;
 b=hs+1LO7MXmWUK/2PsmP5hNwaD8s+unqXU+mkpTKu8+gL12PDp/ZRLS6rQV87P23LdILIRAMZoOno5S1tq8KjC4n6Ns/BzC5RUg5zqh4x68GNmN98tf1o7lkF/PUQFosnPkLV4vEnQRgY0PQgqMjCyyMLWzbwsyU6Wksl2DLLIXQT67wJL5KadGzUmE2x4l2ygJ9GqRxL4LNwL1nP0NY8R2uxdSB11T+Usoz4WlF3V6h6OOccH7UJuq4WjIH64PoMz3AdokxAGKFFWPXTXAuCfufDnMqcWcxmMau9WT4qf1UQoiW5g8pDFNvokFYcIXNGA27SxeY1czGlIK9qlGjM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqPY0p8jDgE74yvJfwdQ5/+zHgEN+pCu6Yjn/v91/tQ=;
 b=MG+86hmZP/xgL9u1ax2dG8sVNwR9kcJlBVIYU88fNOMFYMELybPhJcsmVdfvR69SWnUR6MHhHgESpkn7P4yqOpprp+NQmYt6t4kMX6DZqPva+JVKVgdakcF52+HAMvsB3kfsrUaVBk7u6lXFhkiBDZSfurEaQiBzpgo6zr+U+SSJVNT0Y6HYQmZPD1Ks6jYIzgUwe8xP4VBUE9D/cC5UmeDW6ewDB1dDosWaS9TFlB4m6xdb0rvuf7fR4ztyDM1N4LQYpYhy6bnBZ4evdakJyXmcyyMrHy39lRBOwlcgPz1t3BRjbAKNm9c9MHIASl3B/GpP8nkGocvBpDQXk4/5hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 16:43:17 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:43:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:07 -0400
Subject: [PATCH v5 9/9] crypto: atmel: Use dmaengine_prep_config_single()
 API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-9-26865bf7d935@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=1356;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ewqGbq/a6Fri69k6AcMWiHQJDkdRRZkdZmXyxU701QQ=;
 b=Fv/7wIbcvuDccwqQs5ZHS54+NyoAH8H3QeKLmxrJkepNDkv10y1mcALoM9E6iTooUESxndJ92
 9Dto3KqnNyEBHwRSBajtmTaWIeJqefahLQm3pF7LguIzTtbbnqxmi7Y
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2539ef-9ad7-4f3f-47c4-08deb04591a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|56012099003|18002099003|22082099003|921020|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info:
	rpZ/cc5HvXS09bY2YJY63i6prm6BTeeaDBI1n6FpnCq3Eb5EyhfJ85+brzjfj9EXYdP/5dE6pllHQIcJ5xhVal8KTW51T1GXqaWTcPd8E/xxyN2L4vYPJ1yX8gYxS5CT0v7i1iZe2UvZ4mvmVPLyFTaS1LgODZfz/x5NNmsZhxlPhg8Oe3UNU/xUH5wyaqMUijN8waHQLSG+7aZfMcgCEl/FFfXqwnwPwnCyiGIGABxw6Mbv/h+5z4Y8+X9TB88GwZU0IXlXK7CYu/PQul33sMQQMdNKeZSUDu60afXe8Tadnusf3bPPpZgW+ighvq15iUJlA1a3voXUGUuqUfD/qWwLgCe9nl3hTM+dpRJ3UQSFsgHc8ty3w246BHdimgQzzqvC5oVRS94EDwRXHiH9FhSZBkHxvoW7dOiZyln2vvM7vQEcyJB5M2gT4Vb8vmxYTru0h/Uk/GXvcg6KUl42GEQaYpPWmB/igF/pnwmvAOLG2+Wlre4WoXrkONwhnvMKBtEK7bzVXuDOWYMDhH1x/SBLeDCh+ydr+8KC7MZER/9EIU1QE3vYuSlv9zseSco2UW+4j34BbZRj8TnG9wP7H5XoO6Sj/mdbiWcF+daCJteRUEwl2lUJhksHx8BzpNmS9jUwny48Ax1tyuLfu1kduwNHDVxjL1Mk9Iak3Z0sevn7xocOwqlhjemKjRKVFSvtJWxmueyJU5BCwovRHZFWuSL06cuwJRMyO2OqXGrET37BYowHezKmSy22r7d9wbBCjPc/gnK+h4sSJuOPVUsoTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(921020)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXQxVDNFVERtU3V3MWNERGUxZ3B5N09TdFhhRVVUN3pRdnNRQ0k4WG1lYzlp?=
 =?utf-8?B?S3pRY3ZzeitiM2IrTndoSS9sTlQwU2lLMjd6TitHOWpjaUNzY20zcysveTBl?=
 =?utf-8?B?TmhTZmxYd1VsMVk4aHZHdlV2cGJIOUpVRVBxSFJkWjRGakdDYVg3ampxQkZa?=
 =?utf-8?B?d1lGdTZJc2NrRXdXelUxL00yOXJqWEJSK2tpYlBTc3M1UTEwTDVOL3BRMERY?=
 =?utf-8?B?L3hzTWg2WnpjK0kyNEphYUdSWEx5ekQxVFdlL2FIZUM4cjBSOURuM29HTHpI?=
 =?utf-8?B?SVBmQnF5TnNtcFh5U285UXpHS0N3aHVHSHZCb01wSE1kRWNDQlRMclB0cmtx?=
 =?utf-8?B?REl1R29MWXdpZnl6VTFEUzhCTFdqRTJ3Q0ZOdUcvTVJNVVVsRDBpejB5NnFa?=
 =?utf-8?B?dzZWc2Y4S3ZIOXVqaFd3aW1PTE1ZOWtVYWFpVGZLMTRBdWtJU25YMHFKc0pG?=
 =?utf-8?B?a2E1VFJOaTBtZUg1ZkEvc0lhTnNKZndaR0NOT0hJci8yOEtEUE8zdnNLWW9N?=
 =?utf-8?B?c1dpZWZJSjhTM1dsZndDZ2drSDc0TWVEcFdvSDRhQUJqTzBaMjhSM1l4akUw?=
 =?utf-8?B?Vm5wbnp6SUx1S1Vnclg1U2VVOGJxcGJIc0lLOFZyTXFzbjYvcXJ2SWpldFh6?=
 =?utf-8?B?YnlwODVBQlVlWHRwU3paYUwxVTYrMUQ3K28zVGM0R0pWUXdKQmVsUE9uaHAz?=
 =?utf-8?B?bENZV2YxMXRQcE5RMEFhTnVDRXBrNXdydnVBZlZseUJma1V2VHNPZXdGVVZM?=
 =?utf-8?B?U3RFeDlmR2xjY1NIT1R1TGRvRnd2RmxIeUxIRnI0QncwZ2xxT1Vza05WS0Vy?=
 =?utf-8?B?NExjRktWOTh0UCt2eHluSkM0VHJrTHV1bmVIMkNnM01CZ3Ewc25aZ0J2ZG5Z?=
 =?utf-8?B?WkhQek1iV0F0ZDRPQzZHNVNQWE5aM21wQWRwZ0xQaUt1U3pGZSsvMk9Qa1h6?=
 =?utf-8?B?WTZ2S0FGd3UxUVV6T0Z6RFh5RGNOdWN6eGtWSlhoU3ZnTERxcEJBdWVDSFAy?=
 =?utf-8?B?WHNSOXZxN2pzS0JDWkZManpBZFFCQWwvL2p4TkhrVXhXZmpqUU53cE5NcEhQ?=
 =?utf-8?B?YlFDZzFkODlSSm1yWkNIdFRjY2gzeHoxdmErV3lPZU5uODAwbG5PQmJMazJF?=
 =?utf-8?B?NFdqMG5XbEd1S1FjZTlqV0xwUk9hY0M3cnEyVk9HS2M5OURqUEZLWS85czcw?=
 =?utf-8?B?K3UwUFNCT0hXVTR6L3Z3T3REbzB2eXpIY3dDNTcybnFWQ2EyMlBST0RxR0h4?=
 =?utf-8?B?SXRTcWJHL0xOL29UWkVsUlZ1NXpMbDNlT2ZKd3NYMDJiZ0ZtRktSTVNhazh6?=
 =?utf-8?B?S3BpTXIreG1ib0hzUjJoQnlOeU81RU5yZzRVTG1yQ2dHb1VCc3pOZ0pqQjJ5?=
 =?utf-8?B?cTJzelY1cnpacWYvcWpSMEJrN0h2b1lWWXhCVEt6VjZ0ZXhtQkhCQVhCb01x?=
 =?utf-8?B?eFR0cGNuUkFEZW5PTFJrVC83MEF2SzhUOFNIbUhlaFdaZUV2eDArMGdvYVFM?=
 =?utf-8?B?amVPM01oRmx3R0tMSFVTelE1VDgrM3h4V08zSmJ6NE0rRGI4Vko0N3Z3SGxn?=
 =?utf-8?B?c3hhYlRGeGFFZVQ2UlN1ZmJ0T0s0OWhuc3doWlhKbEoycWJaMmhXVlpNcU5j?=
 =?utf-8?B?ZkJuUEo4cytkYzdjSnVIWmNVelV5OEUrelNlaGRxN3FLRzdPczN3aEx3RERL?=
 =?utf-8?B?bzdqcFl5RWpOOUVSeEk1UW42SWFNb04wakZQditGSFhjSHpjZ1JldERXMXBw?=
 =?utf-8?B?dVFyZTQ0T1FqWjZaK2RDTnZhdTl2MEJyMEcyWUhhNEtKTUp2YjZPUmtGZUxP?=
 =?utf-8?B?VHNYWVBoT3UrclMramMrUXhScEFKVlMyNkNFbEdycmRPS2dzbGNhQWFQRFlR?=
 =?utf-8?B?cUw0VEFsYU9CN2FYY1FXOEQvVmxka1ZzYWFzYjdqdVE5aDBVNGhPRTJ6bHdj?=
 =?utf-8?B?NmVLbWl3U3J2SDZ6WWhaOW9OMlEyOFBYYTdVZnZITzhtMGtCMWlqRUVSSXFM?=
 =?utf-8?B?TkQrYksrZlJTMjA4K3NnT2pHS3dQdGE3ZEpIMmo3UC9lU1RwZWMxRGtVbm1J?=
 =?utf-8?B?VUVSS2ZLd0k3UHZocVJ5bm1uRHRIY25Iakp1N3E3d3lxUjBac0ZQV1lyRmho?=
 =?utf-8?B?VzgzV3NVZlRJN1FWY0k3VzQ3N2xYSmJRajExSDU1NHhTRzdaaks0aStJNm1Z?=
 =?utf-8?B?dHZpcXpQTGEzbjZIRzdEKzdzVnlXbGwySnU4Y05YOENkSzZXalljejZjc1My?=
 =?utf-8?B?aXNOSmlKSFdFTmt6bVVnYjdiNXFvTHdBODNCODZlVHlVTHU0U1V2U25Dcmtz?=
 =?utf-8?B?Q1ZmUjY2WlBKYVVKUXFubTNCanI1Z3ZyREpXMWxGaWZtY3Q4NFVMUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2539ef-9ad7-4f3f-47c4-08deb04591a7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:43:17.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYp5nDuVKAoDclD2mLtcA7cKw91CGeryn41O0hc6M8NaccxeOvM696ZWsWNa0d1BkPQjmcvGEkYQH4ho3s5aag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-Rspamd-Queue-Id: B9B77525162
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10379-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Action: no action

Using new API dmaengine_prep_config_single() to simple code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/crypto/atmel-aes.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index b393689400b4c17294cba73fcd16567fdd6687f4..d890b5a277b9c1394d2c7912bd663ff86321099f 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -795,7 +795,6 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 	struct dma_slave_config config;
 	dma_async_tx_callback callback;
 	struct atmel_aes_dma *dma;
-	int err;
 
 	memset(&config, 0, sizeof(config));
 	config.src_addr_width = addr_width;
@@ -820,12 +819,9 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 		return -EINVAL;
 	}
 
-	err = dmaengine_slave_config(dma->chan, &config);
-	if (err)
-		return err;
-
-	desc = dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
-				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					&config);
 	if (!desc)
 		return -ENOMEM;
 

-- 
2.43.0


