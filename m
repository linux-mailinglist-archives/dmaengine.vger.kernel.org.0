Return-Path: <dmaengine+bounces-10375-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB23Gb5ZA2o35QEAu9opvQ
	(envelope-from <dmaengine+bounces-10375-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:47:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 477EC525075
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0936330A4F27
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0813D5C1C;
	Tue, 12 May 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bvuDG83D"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF63CAA59;
	Tue, 12 May 2026 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604178; cv=fail; b=FvWwEVsRgC+rQxXgcvsomsJEZ2zKiTRsYbjijdA2EN19ywPpFpI7RGkzKkOlG8UuasUYYnecrQf55XiCRZ39TN98UT22B+kvQO69fQ4l/zOJkQWCQCHRgECoeUNWJbO6bVdO1lMugYNKdBVDRtOIKp1ktvw1H9VKhffUMwGFOf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604178; c=relaxed/simple;
	bh=9xZ8NWFtDSzLbtt5/gJvHTWKgKPQEfniKYeMZkeC1HA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G6Mf3l7KASbQHCzFi2e7/0h/1f3ys6UUTb1OL3CJdjrm35ZCr+pdK3RrDH6FvE1iClgdcZbjyqulqy2PjTsz2U+zW2wjFro29RoUmoBUIPbqBgZbCOrs49V7XVHExUpRhVxZ2xlPAT8jWJ5H/bdwhtcLTJuQEMEWFYemx58Xf/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bvuDG83D; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UejIcJQpFx+NitJB8J1FISdHr5fR3AVry16XjSy4beVBCtFOJ+RJQtAk2Sp0GvOe+diszGJhHjx/W6PPVTbkyDELI3rglKKbFhQWlDZPHJEUEcSIE1eq+aFX9ICgxaQAPT2KCa8CE+j272LxQRGKKAu23C/D4WHcWcEOey/zDPjMQqZdEnQcMvzvtu00HxACOE7ExHKKoksBasr/XuUCsZKtDhlyOKKsETb0tiBBpZohR3IN886I5fKIqi+ALPefzm7DxqxM8toSrc4hXRZ/pp6rabLr4Tf+5rbs1aYdCQMKrWaJfM0BtrREV0fMtq/62hoH7Zrlcm7LmV+rJdx9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZynlhUfYIYh7ZqkXVBGiBSA3aD95KelkP81dYe4g5fA=;
 b=gnDlLRDvbjaloH3dm6p3v3O04dQZoQy2c4h3yHiF7tEJrPuAgQVu+4f9pZ2htER83Xw200KaeEXAd9oJf3gqYerwDX8supf4juk7twxmrDVm1o72bm2Fe5FEuP5Di99wM7FXlrrpwumyxDm2Sqr0eAg/W16ukBDbl+EiflAD9gyYoUhi+OMZzLGeSXybs1Vn1KnjR9Pi3md9PXdachi6X9Ey07cu/V66uhFhMNmSVRVbix3HAZCjfjfqOfzXX7131UPrB0PwfAqZMqKmsXDhAzX5cRq9ILbyG3FTyWsDgcqHEFe+L/+U8CjVSRufLdobnj4abo+GLn5SmPwvBMOmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZynlhUfYIYh7ZqkXVBGiBSA3aD95KelkP81dYe4g5fA=;
 b=bvuDG83DtcjJLWa96dEOwWGRQew+HccJe93JFx96eYKPdJcPSj+naHolbRYciMGT37kl4rsrwqWZaY8GOI6WDPRQEniCFO7ohOTfDcgSwZeXc+f7N4tIPQXmyWOmBURDcmOiH+Hod/DNwEOlVsTaRkP6Fp/WdIKY+9LabZZWy4gZXmMDtoZfsjMvlDVGl7wjx0fsciUx8nXQ1NEZkov1hoICULHEnSKB0eBsTeckDApM6swFVjjtXZVsCkWHsGVQMZdRRCJF5VvMsaGbw7Au9lS0y/NMwpRnQDWD3IVDR3OwlvOGgL1DGJdFiycqvShLDJfkBj/+OLcDxEs1x5LG+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 16:42:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:42:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:03 -0400
Subject: [PATCH v5 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-5-26865bf7d935@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=3087;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9xZ8NWFtDSzLbtt5/gJvHTWKgKPQEfniKYeMZkeC1HA=;
 b=oSXOyPbbw5dZpD3r1uGmGFLLSap4M0blXe5J21wyDnYvpvFJaGfjXb5XU5D+5ISHLMbp4Girr
 bdvN8YpQ5GCBglO6KSdcG04bpQ3kU5mFNYyU8duyJPYGboSKTdEHyf3
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
X-MS-Office365-Filtering-Correlation-Id: a334a4de-316d-44de-57bd-08deb04582c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|56012099003|18002099003|22082099003|921020|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info:
	MGYVzdzfg3kdL40+c4u6mFFMiF7cF2EIXd7jAQ1VkOdiEmJKcO/uKLqkyOTYV87oR2ENNvztKZCb/a0u9hptOXe966wNBndPOGmaKq76hgfCcp1xXqgVukfp26ElRwJGF41Co5lOIRxay1Vuje/JrUDGnF+euDwaChLULUiFQ7UHopKSusATMVX4rUBgU9Hnif4E9Db1KIwdpsw6Y5ebudKlNEbK11DgYnhuHehGZ7u7pVChWLBtu6FQNt0CucK0PKDdnTT1Y5JziCmMqowx1TghUHjawOD3wckOku4REpGxtIw++QwHcvRfGKEKx8qRLR6WdvKduz1W7QwM11jqUibOOsxllvvk0zObAGYbl7pIqybZQgBP0DP44x5ZONLroaO7w3zwQe2eqAGpHkbUamU5vAR2BJH0cx3rvHFSPb41+e62sL17agDRn4eCtDXYOqqO7ONIy5Nwrdje/AR9rKINTnSiAmlGcYWUP+DV2QnC4nVYmlPmvsaxZR/J79qfxetS4kPkmzAR08f3d9PohzbRQ6S6fsOH+s1j6wCakRQsVZ/i56YxP3uc2Befij/9RiLlQjxhYHRSXXooWnj1GCN0cU9CjYhjVAnVS42G1jhqfjZHFnqI6hUvrN4twoD+a/EBJohYSwqANfS7s39avzkXOM7PFTN9KHck3HNgKl6X2f7ZRJHR2foQO9FYH4nl3MU27virnEIjKo6eIc2R/ZVq6EVy4QTb8u9NjPSqDBL0bF4r+PCgYbMNj6lb+B2pFQNviAwR7yECHTUZ0hbRgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(921020)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clA1Ry9Ba0FGaXU2QTNtbS9objF6cVZOOUk3ZXhxWHVXcXlaS1c1ZDBBNG5V?=
 =?utf-8?B?UzdUVFZlWnRVMmRSdW0wZGhRR1p0c2F0VU9ZT05UT0VFd2djaEV0YzJTdEk4?=
 =?utf-8?B?dWRtQ0dCbkVvRFpCVEZhRmZIc21sVEdldVYwajFxRFZpZU8yblpGTDVBWVUy?=
 =?utf-8?B?Zmc3Nk40VEhUSEVqVWJzNmtvUUYxZ01KVmJFeVdUSjF6dWtROTFRUDVuZ215?=
 =?utf-8?B?NXl1T0tyTmlrZDJ0bTZ3VmlvbDR2Q3V2Z0ltemNuOEdBNGFIY3JnY2ZjNXpP?=
 =?utf-8?B?S0J4SEFyNnlFWVVhYktDN1Eyc2d3SENva0hGUFpIK3dsaHRRWThWZW5MM0pM?=
 =?utf-8?B?SXJFUUJaeS9EOXZuOXRReXlGZjl1OTR0OUoyYnRHMnJjTFIwbnZheXFkTlVz?=
 =?utf-8?B?Skg5cmhiblBDaEJ1dCt3TG5rQ1ZsS05ZeGVxY09jQ2VHbDhnQ1FHZks2Ty92?=
 =?utf-8?B?VWdxY3dLTzdzZ3M4QThrSDBwL2MyTk8ydkdLZXdGTkF1c1VJQk05a2ptZTlC?=
 =?utf-8?B?bTY3Q0QwZncxUXE2MGhYSGhrTXJySmlZL3VzTkk0MFU5ZXFMQkZJUlNScHZS?=
 =?utf-8?B?ZjBzcUNtQmswbTVlR0NwVURtbXlLZHphWFg2SmVGREFjZGhtQmFWZXh2MmU0?=
 =?utf-8?B?VjBxeGMzeUtkbndDVW5tRUZoOHZLZmNvN3lNTlFPT0tJSkhBTnlkaTdSNXZC?=
 =?utf-8?B?cE12dG9SSGY3aVdPOE5TK2oxeUdUdFZmZnRKdi9jM2E4dHBFelhvNmtOQm1M?=
 =?utf-8?B?NTZULzZWWkRJRHU2a1M4SHB4Y1M3VFlFNVkvK1NPSVBNQkZWR1RsMEozSS9m?=
 =?utf-8?B?OU1SRmFpYlIwbURweUtCc0FkVkhpcmZmYTd0UmF1YyswWlEyU3d0QU1nYXhJ?=
 =?utf-8?B?ZXEwUGZteEtZZnhTL0dqdFRTRTR5QnQ4TFVjNW9xNldVMk5yWTZ1S2srUVpj?=
 =?utf-8?B?VjNHa21HRkpaUmNsODZIR0x6VmNUTUFvQk5nTm1OOEFvTnpjeUZBZWRWbGh6?=
 =?utf-8?B?T294OTlGK0w5R3Job0pzYnZ3ekJKTXFVMEVFQzNpNSt2bzIwdzYzT21idy9U?=
 =?utf-8?B?MVBzZnIzKzhSVjBBTk4yVHc4K2hNN1FESWhrNW5kd3BXbEtvamUyTmw5VmR6?=
 =?utf-8?B?L1RScXNHbHBFTzcxNTdXVnB1VnkwYnhqZ3laWmt4NTk4VHJFdFZha21jUzlm?=
 =?utf-8?B?ZS9TZVZiczJGbjBqaWNSMnUvWllnaEY0QkJqODdMV2FJMXVXMGZnVnVNOFpX?=
 =?utf-8?B?cnB0QzFWVDN2YVJTZ0YvNW52MzIzU1FsY3JRdE45NUtmSnMvSTkySlVVb1ZU?=
 =?utf-8?B?OVNITFBwb2dINHhLY3lqckVsRVJlaXdoSW8rWlpEMGFwNFRlOWlpdkwwUFV3?=
 =?utf-8?B?YjJRenFJa1FUeWZkRWtZWHorT2hyN1EyZ0dUSnlDZDl6UUhkOWYwajd4cWl0?=
 =?utf-8?B?NmJxY3A3YWtCb3hzYld0cmE1TWhtVUNkdkRvWlRSU05zTWdLbDR5djdmd0ZQ?=
 =?utf-8?B?RGtHS2V3eWRQV2hEMktkc3QwM04zcnVwbjArb1crNTVZUDEwSXBCL1FEakFB?=
 =?utf-8?B?TzgxYzNYb0pNY1BsWUF4c1Q0eXhmK0wyRkhmT292MTZOSGF0STg3Slkvd0NH?=
 =?utf-8?B?UFU3cDNHRlFYTWJUZGVBNlpkWCt1MHRRUGx0dlZac3pVOFRoRDVOT1p2YUNx?=
 =?utf-8?B?RDcvTnV1dFR1cENaRUhnaEFGb3NNV3c2ZXpOOVFzd2R3M0c0Rk1vOEhNUGdl?=
 =?utf-8?B?ei94T3VaeDRoUis5cUw5ZUphSHBLdmJ2RVMzZ3Brc3VlRHl3MC94RXBUNkdJ?=
 =?utf-8?B?ejJjZHBQbE5GQ0NGSmFUN0U1UjM0YlRBelJab0NveWE0ZUt5SzM1RUpuanFF?=
 =?utf-8?B?YldUQUNENThUUitpV1RQZEU3cS9DV1RONmdkSEtIN3BpbmVVdkpyMlBRcTdp?=
 =?utf-8?B?dmZnMVF4a3lSK0NZN1ZUb2UwMGtVbkN1c3EvQUVodTJOdEt0TFBpU3J0dFdP?=
 =?utf-8?B?RFo1Y01nTVRHZjVQNEh6TktMSXV0U2RpbXVlU0Y1ZjJKRTJEbDZncVJ2ZmUv?=
 =?utf-8?B?c0kvOTNRa092em1RNW05UHVNcGFxTHhIK3crV2E0UDNFY0hvbm5CMnhQOUdj?=
 =?utf-8?B?QmVQSlZDeU1UWUVJRGRaaUlOeWlYK0J0YmxZbmdNU2lqVGVTWVk3MWE0aGtq?=
 =?utf-8?B?dk80bTU0cGhCdHR6dGcrV0x5RlF6WERMZHRwdnBaWG14TTMrclY5dEJmL0hz?=
 =?utf-8?B?NlBLdi9lUXY0c2dzR3BtNjFTMmdibTZZNUdrMEVzL3hwTnRpdEc1RFFNOGwv?=
 =?utf-8?B?WkFacElWNTNaMWdZK2NWd2xFQ0MzYXdsS2dTTUREZDZsRFdsNlpMQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a334a4de-316d-44de-57bd-08deb04582c0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:42:52.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlE2BEFSw8kZB2FtJSNwr9h0yJpd1AyI2OJCoQuYuP5vZMyebOJjo4VaHcXAhW1G3lo5LgTVxVEb4A1N/4l15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-Rspamd-Queue-Id: 477EC525075
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10375-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Pass dma_slave_config to dw_edma_device_transfer() to support atomic
configuration and descriptor preparation when a non-NULL config is
provided to device_prep_config_sg().

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- rewrite dw_edma_device_slave_config() according to Damien's suggestion.
---
 drivers/dma/dw-edma/dw-edma-core.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f7f58b0010e26b529ffb7382d5b166a703587c71..ec6f6b1e482568a27ebe90852d5679672b24a1e9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -267,6 +267,20 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 	return 0;
 }
 
+static struct dma_slave_config *
+dw_edma_device_get_config(struct dma_chan *dchan,
+			  struct dma_slave_config *config)
+{
+	struct dw_edma_chan *chan;
+
+	if (config)
+		return config;
+
+	chan = dchan2dw_edma_chan(dchan);
+
+	return &chan->config;
+}
+
 static int dw_edma_device_pause(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -385,7 +399,8 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_transfer(struct dw_edma_transfer *xfer)
+dw_edma_device_transfer(struct dw_edma_transfer *xfer,
+			struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
@@ -472,8 +487,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
 	} else {
-		src_addr = chan->config.src_addr;
-		dst_addr = chan->config.dst_addr;
+		src_addr = config->src_addr;
+		dst_addr = config->dst_addr;
 	}
 
 	if (dir == DMA_DEV_TO_MEM)
@@ -595,7 +610,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	if (config)
 		dw_edma_device_config(dchan, config);
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, config));
 }
 
 static struct dma_async_tx_descriptor *
@@ -614,7 +629,7 @@ dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_CYCLIC;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static struct dma_async_tx_descriptor *
@@ -630,7 +645,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_INTERLEAVED;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,

-- 
2.43.0


