Return-Path: <dmaengine+bounces-8036-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E004BCF5DFB
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 23:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C45583038358
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800B12D8771;
	Mon,  5 Jan 2026 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gRxPmbeA"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACC30C62B;
	Mon,  5 Jan 2026 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653251; cv=fail; b=DJH6VWrGS+ByWs3N2yN7oglerwSVjnLmilCtAPKEWrQYx3IpWJYFTlIonuoK6Qea0nIig+QJsKgyupfQCqrfAIvjZs2edXCN8d4k1ol7BHwhEwzxfyogMk50K1zjMdc/IV/Gp6aWzpOz+xm/w8fAxCQQhV0kF2VMudeGVtM9hqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653251; c=relaxed/simple;
	bh=IhbjoaTN4TKmpikqq/9QhuWJkb0HuUKcb8ZGdXj8Maw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dRrJP0sDcUTpofHFA29IapTTw5HntD64YMlmvtYAYjEn3SF3hXhAlih/zniGkQtb+8xlISdlUFBkM8tq7EY95d5c2wUAqf2pKiLcdERJX5OuBqWcqQv3aAEmuF46bL17M7z7xQ50yNRDxMykV78Zb0UW8fw4TozN/0nRbRXuIZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gRxPmbeA; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nib28xgpaX6LQjq8X2B6J7dmb8KYi8nhIiUgrufzIV9H30ACIbVgRYkSoZbg3AVt4+6hYwMFw1nf/p4nya17cOP4yC3NOvTaMMqVERoYb2WbGjVH97/jmprAucewPezydt9X6SostsIjJxt4M1CJozbnn5S54F3fNBKV4wFZNzHmbs++CpCRCMKsRaICZ29MMaqHMnBLq3g09QCsO+IBuGygw1sQGIa1gPD0HfQQJpzwn62gklq1+nX4KjzWMDwuvFkESQxgsOjDkMy2wT1xlCH3gOpZ+dHJDjB5ZIMwXaYLymyapm5meb+xjiDoTJHAFOxMblFa7XqZo6H68Gd/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YJQfC91EGCdxB0Sjnqfp644zGwV9WEsFDpUivQKzPM=;
 b=c28iMehuIsTTJ+PxXQLEQ5eLIaNk6HrMLvsB3/fONDUSz8SIUO0Aei5GCmn6bbYF9GTxlEPCz/YLrq2Ug6ahcYiqmSf8Kmln8sQgyVKMfcyT9rvlonxhwqOZ4E40WK1tn83xG90PbI3bNECFx+cwj4mVZJ/6n8wBMht4XS6yhr0itgQg3lytLf0v5ka5yatwtYKUi/zLCQNY5nEUXx6xiVuPOzuSiMrur67JTMaBV+8bD4/TBtgXtUtQrlkyO3oXVXif5VrKqhRfTernCIN+oRM0XN4dU+S0yckRBJ7papbbF6uPyS2ppqxMH8rXufcRD5Tg5gDxNA/nD7zGwuIHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YJQfC91EGCdxB0Sjnqfp644zGwV9WEsFDpUivQKzPM=;
 b=gRxPmbeAuSBYOMEQAa/TT/g5qsc/nj51PnbkXRWa0lLHzAzRDFnsGUz/C3dPNboBzhmXUs+TBhr2qnPSXqJjNrRz7H9S83EiP5U1cZkdyEa747Wnr1Gon2m1rwyLduOrh0AsFuOZ0IVANLi9fYn3cnfMoBOCOGVG/Y18iugy4qS2amp3i2cOKHn6r9hRpcJprJBPZ92+wlpkJ2+PcBPbX1CAuOIp28MiGe2csDsjOVgHIM5pW69tLO1WI+bayDvrdiL8OZ8E2CMTNDpoCOIGcS+LsOeQpP5m4OmPPMp5099QuIP+o1ArwBkm6BEFu+we7gHXhkP6gnv3i3BJYEPTgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 22:47:27 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 22:47:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Jan 2026 17:46:52 -0500
Subject: [PATCH v3 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dma_prep_config-v3-2-a8480362fd42@nxp.com>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
In-Reply-To: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767653229; l=4406;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IhbjoaTN4TKmpikqq/9QhuWJkb0HuUKcb8ZGdXj8Maw=;
 b=ZKg1b8sadxFt/bWLSxYOoddep0607yg48HyrnBswfpnSZ1/6grlllNsbdeO42dwC1LU1qe/LG
 cKNlI12aJgAB1zztg1ZPuDQ9cV8nHm1kJUCDF9g/ydjqjnL6IQnrGV0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 512fe81b-991e-4287-a35a-08de4cac665e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzM4Y1RnMG9oMWg4MmZMd0F4MFpSNm40UmRtTXpzbW5CY1RXY1VuTWQzM2NY?=
 =?utf-8?B?VTROM0wxL2NrbE1CTnIra2dObDhhYWNoanRTS3pDSFBPaEV0TlRZMTdRSldZ?=
 =?utf-8?B?SEV2dUdHMXE3d0E2UDRibWZIK2dsVVZURkVhVkVaSzNhSitlMmFXUHc3QVcv?=
 =?utf-8?B?c0J4Z2haZzVSNndmakxKZEFRZUUwSWNHcDZQeUpDVHJsekNIaHJ0bGIrbHVq?=
 =?utf-8?B?SHFCMmRBK0hoWE1sRm1JNDRBSG5NNHppM3FudCtVTmxvdE9NWVgramZpWk40?=
 =?utf-8?B?bXYwSGFpNzJ6Z1gxY0N3c29zOThMYkg2RjJJQi9TSytxN3R5ZWRCWDNEa0lk?=
 =?utf-8?B?SDl3T2I4NzdSWkNRN2djdUVPRU1UNWhGdnJoOXZyNURTb0dOc0ZvbnBOZTcz?=
 =?utf-8?B?SjNiR0pqbkVpVUFac29RQ2tqdWhUUnJYTjRkT2JnUzMrNE5scXkzS1Q1bTVW?=
 =?utf-8?B?YVhSV0VRVW5lbEF1TEo3V1BtWk5MdW4vckRhQ2JEV1JDL1d2RTZ3L1Q2RnMv?=
 =?utf-8?B?OGttSUFLTW5mVzVzdnRsRkVDT2NXQWJRdWZlSjVVNVNub0J6MlFKaDhUN2Zv?=
 =?utf-8?B?TDFMRjcxTWtNVGx4NFNwUzNBMkFJSHFhbCtwWkZKVUtPZmpvbTNxT1ptcWRU?=
 =?utf-8?B?ZUpLRGhxSGpqRTRHSnVDVWMybmhQTnNHTmxSbDBLV2MrWjJFTjBCT1ltTmZj?=
 =?utf-8?B?YjNYdkM3dzFqb3htb0NuenAwbUg0ODFCTy9hS3U3cTJvd3NmNmFndVZJRFVn?=
 =?utf-8?B?VnNKckc1MWlYMzlqdnpxTHBMRHZxcmJqcm1IODhnWlNsd0owZ011ZFVLQnQy?=
 =?utf-8?B?N2RYVUR3WXMwN1p0UlJYL2U5STY0Vjg1MU55MytHVmVhbnh4MzUwS0I3U1Ru?=
 =?utf-8?B?SE52UVcxcTE2MkJTd3hwWGdZYUxOTm0vVk5nNnJ5dnp1clo1Q1pQYUhVWUtM?=
 =?utf-8?B?OEFNYjdNY3hwM0xTOWFlNHl5bGlwSlgrTituc0gzaEFzeE5yZERrMFJMQjhk?=
 =?utf-8?B?RHBuaXVwaDc5eHZsclJseC8xaERaVVJRL2dWbUdyTkFwWEJnY1BwSHlKK0cw?=
 =?utf-8?B?eW5ndzBSOCtPZHhjZDg4TDFiaVpQV2pjVE1KV0Qwd2lCTWQ5Q0FWUkU0VkRR?=
 =?utf-8?B?SXkxbjlWMG1tU2ROaE82eHBRRUh2TlE3WXpSZFRpOEZ2Q1ZIZHJiTGpZTjZE?=
 =?utf-8?B?U1JmU0ZvOWxmQTJqa2pOU3RUVEtITG02NVhGRzJoMDU1N0dCUlY0d1RQZVph?=
 =?utf-8?B?WVZJZHF5S0JYblRZTFFkWHA4MEtRUkJBRXEwZ0hyZ2YwNkxkY0FQc3JYUU9p?=
 =?utf-8?B?Yk8wcXNMVXFLSHcza0IvemE4RVdJczJ5NU4zcTcxSUhpT1dia3g2dmRhK1ZM?=
 =?utf-8?B?bUsrTjQ5bExMSFJEb0g5VmxwRDc4MDhiR0VmYStGVEpmS0ZYdDRpT3lzN2tJ?=
 =?utf-8?B?d0dRemdsWkoxRWJacmNiR0hjaTdCODRHbnYwRW9VaHl4T0ZOaWpncHhVTE5h?=
 =?utf-8?B?SnlmbzdZdHBudjdZaWxGWmFOUlRMZUhneXNDU3BLVUhWQ1dCbW42WnRYQVl1?=
 =?utf-8?B?cHJ3SzZxOGhaaEE0N2pwdXdETVNoaG5GTzNNZElNKzlCd1c0ZHpJYTd0Z1FM?=
 =?utf-8?B?ci9hY2ZhcEg4a3NtbEI4WS9JOGFZOHFIUTEyaGF4aWFhK3hBN3M1TFNFSTZ2?=
 =?utf-8?B?UmdKTUthcEtacGZ1Qm9YSDhIWVFXZ255ZlAyN1doTWwvckwvdEl4U09vOTdm?=
 =?utf-8?B?VGpsNHpTT05sQ2lwcGVWbWlwYkplNWU4anA2WlNhaU5JTUMxV1I3aVcwa1M5?=
 =?utf-8?B?K0RyWEJ0RVR2QlR2QkNTRSt5Ty9lOVNSMFhLditrNWpSZHFLWWFEQVdJb0cv?=
 =?utf-8?B?dkdSRW5QR1JYWW4wQkUyTFpQV3dPb0h6bGFNaS9yZlFoYTRiU21wYXZNOVJ3?=
 =?utf-8?B?Wk9JcDdsd2NQR0ZNcEpZblVLbDlFckNKOTRCc2JqcTdJc0hhZzFXT0lSU25i?=
 =?utf-8?B?Tk9id3d4dnZCVmErZGxlZXJzbTIzc0tVRWYrOW4zMWh1TmIvSnVHY0I1Nk5M?=
 =?utf-8?B?UWVFd1hwaUJTMHcwTDFvajZXdzQwWGRRbUtNZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YktnR0Z3TCtqKzNiY00vY0NmSnkycmIxM2RLVkdpT0JRZ1MwZUFOU2EvWGow?=
 =?utf-8?B?L1hrdFhEcXBBVXlCUGx5NEdnalZJaFUzOWJVTitKQ005SUJqV1o2RFZEQXJG?=
 =?utf-8?B?L1h2NzY3bHdMRmpvZVM0eFlud2dXWFFtbURRQXJVbXdUR2txODZ4cmtDcS95?=
 =?utf-8?B?dll3TUROTTQwT212ZFJKTEJmeU84YmJkRVJxWWoxeFZFUllmM2gzNmdCQitn?=
 =?utf-8?B?TWxFUVFrTlJiakhSWUFLQ2RRY3dRRktxUjdBQzBDbHd0UmxaK0hiam85Uk5J?=
 =?utf-8?B?MXZ3YXdJTEhJcy9wUm81WXh4WTF0YVNNQmc0KzVRZzlDc1gvK1RwOVNVMXZS?=
 =?utf-8?B?YS9KZ3MzWlFsaWRYcXVZRFRCcVY0QmVqeUh4Vnd0QVNrZFJKR2V3RGFWV0h4?=
 =?utf-8?B?ODNEdDc3eVJmMjJyaXFvRFBiQ2NFWCszYit0NVluOUQxcFBTZWJZaHN6SWNm?=
 =?utf-8?B?UGpWY1hiRE1VaFkwc29pdHkvejAwVnBsK1JTQVZQZzMxclRnMjFobyt4bGlm?=
 =?utf-8?B?VEY4U1hoZ013RVF3eUhUMlVWNjF3K2w4MlJRVjFqY01HZ04zZFRidFFHTk9w?=
 =?utf-8?B?MU5jRW14WkhjMFg3YkQ0MkdDV1VvUUpXMzZpUU1iWll6YUdEL005ZGJGWHRl?=
 =?utf-8?B?Q3NXdUNJMmxDM05mcDdPWTJhYllmczAyUzkzMjZoVUZqVjB0RTBudXB0MnZi?=
 =?utf-8?B?U3p2bzJCU3I5R0hyNkE3SVdmVXg5ZzJwYmNVL25qZkNkUXBzZVUwTHgrQkk2?=
 =?utf-8?B?bXZ1YWN3dDNPTWNkcVRjZEh2WUtyT1JseGJaSE80VmpyYm1CdFpneDdlY1FT?=
 =?utf-8?B?MHJiRXFOUEFlZC9mQ09DOU9yK2o0cW0zQVU4ZWRiZDViUGVUS2FLM0o2Q0Vs?=
 =?utf-8?B?T01zUHZ5cXBKRWUxdkFDSGNWOTZTeW53M2NyU2ZhY3oyZGRZWXROR3RxZU5w?=
 =?utf-8?B?MTRkOVlmbmo4SjN1VjE3aloyMExuRjc4aXFBRkplUXhoajhTb2pMSDhNZjNL?=
 =?utf-8?B?bTNLRWoxeHVGY2lDd3FFVUcxN3pVQWYraTA0WExHMndQRndkK3NLdjJMY2Vn?=
 =?utf-8?B?a2RER0pDbTdOaEcrTWY4MlFQREhIejdaKzcybXNlYUdxdXBZb2orTFhScVZV?=
 =?utf-8?B?SzVYVmEwYjhtU1NubDdlZkxLaFNmZ3I5N041czhDaUE1cDNhaldWUDl1dVA4?=
 =?utf-8?B?TkdKRWYyKzgwMW5FZUc0bzJZbXhDTklKOC92ZDliYVczTXUxM2QyMmZtcU45?=
 =?utf-8?B?K0M0amFBczVOMnA2Q0czbUE5OHNMblZxU01GRkRud2dINHhWcXZqdzMvNkFD?=
 =?utf-8?B?bjI5T1A5TU43RElxeHhlOE56UlBBUWF6NnBqNGRyQlVETmFSczJyZi9BQURJ?=
 =?utf-8?B?UXdJOHA0RVQvMWVvU3NxKzBJdU9wNjA2WGJtUG1hQ0crZitMWWI2NHZyRFdH?=
 =?utf-8?B?ZGFrRlNoRUVicE9xOWhZMlp1U1RXSG4ySEpDVWRFQUJKSDZRdzR4N21kQzBt?=
 =?utf-8?B?bmhJeUtVQ0hrN1FnazZCcVE0SzhBR3lsR3VUSVVtTVQ1dk5vS25yNzhMNXBK?=
 =?utf-8?B?QnJVRWcrR2FZd0c1b3BJV05JMnl5SVJNczNNK1JkSkxpNW9Mdnd0UXZyQWZS?=
 =?utf-8?B?bzBlcCtNT05ScUs5T2dnem9iUXppRllJUVl1dk5QYWRvTktpOW5ENDZUdXVC?=
 =?utf-8?B?QU1uUFJJU0FhOERTcXBQdms3SVdmdWFZQkwyQ1N0djRRYmtVMHVEN2lOUjlH?=
 =?utf-8?B?SGdyMFlpcXFMZjFkNXpnNFZsMzVBYU9rTnEzNnd2ZURwRklkNmc1YS9EVHRs?=
 =?utf-8?B?U0tkSFJKVkVnQU9ncE5qOUhGb1NyZit1Wk44bVNLZWVDZDJTcUVVSU5zK3kx?=
 =?utf-8?B?bHZDTk01YWZBYWxXM0hCUCsvVU1ES0ZjR0R5dDdhNDByR3JGTWV0cGtVOHpZ?=
 =?utf-8?B?TVdpdEJTOVlBK3BaS01UZEI5MjJzUFhSc0V4QlZMYitlS09WV2g2cDVEeUgz?=
 =?utf-8?B?ZFV5WjNWTDhOd2xiRmhvTHNIclRNNkp5T2ZSWmRtamVHblNEWlhRUmZLTE9y?=
 =?utf-8?B?cEZDaTY1a0tMREZrV3p6WU9ObkRTNVJxcVZwOWtJWHRjRVFRUXhtenAra215?=
 =?utf-8?B?cDJVMm9CWVo4a1JFRjZkcDRRSVQrTXRQRGNKV2ZaRHlRNktJRytNWXZqNGhl?=
 =?utf-8?B?cHhVOXNNTzBpRjlGdUZsRkVhd1hCQ2llcG0xa1M3dUhWcUJ3Mk91ZVdlNVRY?=
 =?utf-8?B?NmQ2c1NEQkl6dTVrcTlqTDBCTWp0dUVZNzBMTjBrcUkwMkVjYUkrQlIzTjRN?=
 =?utf-8?B?NnF6M3ZQYmV3bFNkcTI3WmdWZVBnNTVPZ0FBK2o5dVVENlFHcHY3UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512fe81b-991e-4287-a35a-08de4cac665e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 22:47:26.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nOKDpMYfFXLysA9c8kO2X/BMuUxSVrHCg0yQpKXmF376HWYRddHNZef9+2NX69aEY+7R9s4W7ghEp6Gxwyhgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Introduce dmaengine_prep_config_single_safe() and
dmaengine_prep_config_sg_safe() to provide a reentrant-safe way to
combine slave configuration and transfer preparation.

Drivers may implement the new device_prep_config_sg() callback to perform
both steps atomically. If the callback is not provided, the helpers fall
back to calling dmaengine_slave_config() followed by
dmaengine_prep_slave_sg() under per-channel mutex protection.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- new patch
---
 drivers/dma/dmaengine.c   |  3 +++
 include/linux/dmaengine.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330ba4d822baaab412356a166b656350..53116300e61078ca89e78109bcf24a5f8c7e3369 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1097,6 +1097,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	chan->dev->device.parent = device->dev;
 	chan->dev->chan = chan;
 	chan->dev->dev_id = device->dev_id;
+	mutex_init(&chan->lock);
+
 	if (!name)
 		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
 	else
@@ -1147,6 +1149,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	device->chancnt--;
 	chan->dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
+	mutex_destroy(&chan->lock);
 	ida_free(&device->chan_ida, chan->chan_id);
 	device_unregister(&chan->dev->device);
 	free_percpu(chan->local);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 4994236aaadc45dbda260b63abe1fef47aa3d51e..abb4a7424a0083c00730a945c1cb645f831fbd6f 100644
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
@@ -340,6 +342,7 @@ struct dma_chan {
 	struct device *slave;
 	dma_cookie_t cookie;
 	dma_cookie_t completed_cookie;
+	struct mutex lock; /* protect between config and prepare transfer */
 
 	/* sysfs */
 	int chan_id;
@@ -1068,6 +1071,56 @@ dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
 }
 
+/*
+ * dmaengine_prep_config_single(sg)_safe() is re-entrant version.
+ *
+ * The unsafe variant (without the _safe suffix) falls back to calling
+ * dmaengine_slave_config() and dmaengine_prep_slave_sg() separately.
+ * In this case, additional locking may be required, depending on the
+ * DMA consumer's usage.
+ *
+ * If dmaengine driver have not implemented call back device_prep_config_sg()
+ * safe version use per-channel mutex to protect call dmaengine_slave_config()
+ * and dmaengine_prep_slave_sg().
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
+		mutex_lock(&chan->lock);
+
+	tx = dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);
+
+	if (!chan->device->device_prep_config_sg)
+		mutex_unlock(&chan->lock);
+
+	return tx;
+}
+
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
2.34.1


