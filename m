Return-Path: <dmaengine+bounces-10250-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COakJsWp+2myewMAu9opvQ
	(envelope-from <dmaengine+bounces-10250-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:51:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AE64E0692
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E91307F827
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58623B3884;
	Wed,  6 May 2026 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oXq+9uCX"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9D3B19D6;
	Wed,  6 May 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100299; cv=fail; b=WZi0i9xoXSHw+YCOC6IPLTpYs9+297EB2kNlHRiZj0/w4Ph2sbA2VhasUqAPpv0OS2yqCp1nTt/ludCaZu1MQtTx06r7g8RqXbtG9EFIyaxqnXy+mC9gNYmFyCmnDsRVzVaLfVVoq97b4/765YmWVj2rcy4Eh1iS0j+aKv4rUX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100299; c=relaxed/simple;
	bh=R8zq4xuUzB0SzlTrw3XEIcAhQyP6REHo2XyjvDNF+ug=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PyRg1K2PCvrNQbNhYGzU03AIF00ahaU8zO7x/0ooGuuMktaPzhrd72HOQeCLxMzoNDaP/k6oFjoE11vfteCHnDKR601oWXgLsXdon6MCPNy3CBRK1DK1t7GO8ZkeyVaGDaG5z3C+aarfYs6NL4vAjqaIc5q+M5P9crHyf5dVJ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oXq+9uCX; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHznvmTvG7OnZYPvt2SB77UOHcsjIsf06+rsd5tYRoFGhGBP+pGdeDOQbkUmK8VohH6wQANBPCrREqJSTmWF0RmU7/7YPKNtzNNGEfriNDWeNm+SR9XOCNewa7djZ1HZb/CjQIBFKZsi0oJoJ9CPeqHLH1eqEemAi2sIUAEZjEJhqKvpUFPY+9gEW4bxqLWwTxTGtsPCVGr3gXnRNGYSunij2r3knr1Po7l1gLmOPaBRky/TMMKIztpwhzZsIEr3bPudNrscPTeVnCghs1X8y05/04ekZe7PmFxDUD59knutdt2ORE2ea4+MDdlDewEYKK7FMYW6bo1mE90/5emtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofQVTC//EZQ7ydBnUB2rZKmNZhujOugIeXKiW+0AgBY=;
 b=VuX1Ehqy0jiqI2GpSGHwNeSVcR6grBmF082Ji6aUp0ggUGIByExZgsy8kBslhXtfiGFzmNjAI2ZRMjOOyVqRyRaIjxuBk1H9nk9M3PAIwSw91ltVzqmc15qxjQaVEQbkvKTJnoIJyFv7rp/dkFhsZj9XAK9hCBTq9V1YtxzL5Xvaex7byrGWMeUIzgQxB0f8cXzzLCN+ApX4nEaIyeVe/hMJnJKduS1xR24g+AuwnQ1NWa4I+k7AfEFixG2AyIFbvTtnLVh4KDZjGVY+eZVyBcCyN6UrgIITj3ca6Ec94AU1gDpdzq4oUG7ejfUavhqYB8TYm/8iolbFcshhRpPusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofQVTC//EZQ7ydBnUB2rZKmNZhujOugIeXKiW+0AgBY=;
 b=oXq+9uCXQoqXgNiriFB5CaMXXB7hs5mEgFjup139Fwzce7lw05hz7qBys3jNkUYvTeApEue4U3gR8yQMe1yAWrxPaHS+pxu4Y/pI/hkXG39+gfrU870w8a/YrGKnGzDpAba1MQiW5EmUEz7sv53t6siEZRzgpgpli3YJP+l/DDACVmT3QOuid7idXE6HqUhHdUPcSejzUVqWmBSmeS651DEh6sQzICxOSp+CwsTgQ7T6azuMw3txb3TFUKkSK5XlssQK+1TBDuq+vM1GwvGt+Y+cbr3bOIPGXx8I0jNgNT0SA+bAhzP7ULnZSX6dxSW7XRGprE1r4Oo8XgVcThuwwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:54 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:18 -0400
Subject: [PATCH v4 6/9] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-6-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
In-Reply-To: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=1297;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=R8zq4xuUzB0SzlTrw3XEIcAhQyP6REHo2XyjvDNF+ug=;
 b=FFoTFgVc0Hc0Tg7bKc32hBywautdN06wfHonXbaYROhXR0jVaJlYsBWSj2R/eKQDxQWb8esNl
 wxfu0iVqAiIBBI/5inzKSEPz5c3kVw+WTIdPpJ83PI2kAh5HLzXx4Hb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV1PR04MB10479:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f86064e-9403-43d3-97c5-08deabb053e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|22082099003|921020|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	UA7Ubv4nGa8VgeQrYBvksIRTUp33YxEiOB5ZqSzxW+PdqlXXIh2RiT/Q/vs5lQ0R2tHrL/ABz5WKdv+VD3UNMDvfTr54EyhvNpNslvTvAlLlisg9yjanXE7VP/fP+G1n4YQRx3zW3xT/F+Q79mBY1S9dAc9qJYDI/oCVrx6Tnfit+tWSlC8yL11W0JVdA9fh470DRQZcjPhJogly7ePnEMdVGCAg5pbt8D5TZ0jjie0YTM1Vh1qP5NWoL1hJuV65wCOqAL1/8pCXSi2jreawxNodRuRTm3BcZUqh9XKNqJSuvx+wbL3L6eu/+io2YC3hBsWzzgCUVPjxb9S1p4Mlvgl3zC6Ux7H9pxTMpR3sMLcx5QiDlUa5J4lTSSFw4qBc5BXkXb3/MsVTbKqJmJcY53p28cYadU8ljynYYtp0Z/vSbQzmVeSFSPIPJ/xEssdtqlcheIXcs8nRfCn5ewJ2BNDR2UFxwRhfo+QuRVtTcP5VG8MuiPKlVVkCb8/s3lcX5eaMHdOyUPJageoki+gQXv8Wxy8QPAjkc6i4ViOsvCSW46FNi1mf2mxJO3wGDGTqmMt2kemSvoBREvHgy5DkbnBQqtNEkB7sXoGwP1paUFRIFA8iUdFRzKnrn2sJGITglxOzjUAIezhQ+kPaWgPFdiDHZRAz1HoNkZ/xq+gD4zTzLDLkZbVFz3pG5mLNydgARZM+s07JPcLcds8o/kSMeVknpKY6sAG6omKpiTU8G8MZY4ekcm750olZodyufPPw0RCDKmDNW52C9S1tn5gemw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(22082099003)(921020)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmRvenlXUndWdFFJOVZJOHZyNk82QXFjakpFM0pjcUhrd00wRFhZdmwyeVQ5?=
 =?utf-8?B?YmZNOVFmMERrYU8yYWFTc2p5SlZ0aU5ZdDhWVG5JaDNydWhzRGl6Qjl3bUlv?=
 =?utf-8?B?OWloT3FpYzRLb1Y2MEZxSDZEaWRTMDFWaURxSjRQNHlITFNabW8zanVsMEZo?=
 =?utf-8?B?bEczVHJBVlBla0l6bXVGbUJ4VWZwYUNTRTUyOUZyc3doTUxRSXVydFgxbE5R?=
 =?utf-8?B?WnRTaW9YenBWWExsOHFEQVdna2hYQ2VXN0gyNWRJZGNDYkN6WTRwYVFiZzdx?=
 =?utf-8?B?YTJHMzFUL2QwSDlSL2IxQTlZQnBjUjZ4dkhtQmVFZzZkcEVHL1pmZmdYMzNZ?=
 =?utf-8?B?MW9CckVYeThDeHMxWlRsbFh6M3JObCtWMi9qc1MySTlKeTYrVjh0MWNiYmp2?=
 =?utf-8?B?a3UrTkxJd0NoalNEVzVKdE5FQnZuQVJkY1dMcHM4U0hSK0ZjTkdUZGtxT0Er?=
 =?utf-8?B?NjZwdmdwU1dMak42YlB4T1dwMGl4ay9uLzdsOHBGSHdMR1VDRFRlZU50NlNi?=
 =?utf-8?B?UVJqRi9SbU85cVFvS0dzRXkvYmUzNEtJYnh6T3cvU3lhNXV1QmhuenFMY0k3?=
 =?utf-8?B?dEc3b0VmTUdXYU9oMTlzb3hhTkp1YzNYTC9lTEJLMWJ3ODFwdWthaU4yV3Fa?=
 =?utf-8?B?OE1yZUFxanJ2UFRHRnpRYkEzWTd5SVUxYXk4UHM5aDgrTHN6Q1FDVmRqNG0r?=
 =?utf-8?B?QU1BRldRNVFmeUlXRW41WDhrRXoyV21YSWt4NjBoUVhkcFVJNzdub0YxQ1VC?=
 =?utf-8?B?a0x5RVAyRnRxejlBS0NzcHo4NStYc3RtVTRTY0UzeW1XRFJjMEZXMGwyb1lp?=
 =?utf-8?B?UnpJZnp4czB6MEFIZVJwQ1BRQ3RJSlhRdkUwRmZuS2dSMDRYeDJTRWhoQ0JN?=
 =?utf-8?B?dzBEMXF5RUM2V2xrOG02akVieCtJaDg1cldUdlozNHlyc0prQ2tmRzFWNEJE?=
 =?utf-8?B?NFZ1RXFJOHhDRjQrQTNKbEFpVnNWRHZEVnhXQzdVeWRINkcwQ25VZ1FxRlMx?=
 =?utf-8?B?TGVvMEtGTlArSTBTQ3lUNUVHRjlWRTNzNzFtV2dZUjBTUTJKU3AyMlpBUFdN?=
 =?utf-8?B?RlV4Z1BBYWVnMk1zODhKajFKaURKQmtPQmdtb3hpaHdDaUF4dUZDK2NJb21r?=
 =?utf-8?B?NlNMOStxVzBTN25Ta3JNaUNrSHdETWVtWnRDNUVGVU9mTllxc3UvN2FISVI3?=
 =?utf-8?B?MFhvc2lYa1Yva1lEMWJhN0tMR2EyRk9qYmxwR1NqMGEyZ2tON2l0TnBzai9i?=
 =?utf-8?B?S2JwQUgzQ1Y1ZENpUzQyQld4aDlXc0lwY0tPZE0xeDBqb1JzaWVSL1VmcmhW?=
 =?utf-8?B?MUdDbUtENE1VdWF4Y0FGVWMxbDdod1pRVkdrQzJjWTF0ZE0rM0RpWlRUbjl4?=
 =?utf-8?B?a0cranlZMjFJRmJVODZIUlY2VTFlVU1vMEloT1Z0SjRvY3o5UjIrcVR5dUI5?=
 =?utf-8?B?aDhpWHdva2dTaTFvbW84UzhlOHBmb0NRa0duN2ZCd2FXT2l3ZUVDaXQ5eHg1?=
 =?utf-8?B?TDh1dHNOaHd0RU9xcjRXcWVOUE5xVUlBU3Z6c3M0SGF6bVdwTWtXNDRjWFZD?=
 =?utf-8?B?TzE4akllNWRHNWlhbTNUMHlwV1JXYjVoOVJqeWtXNDF4RmVWN2NvZllDMzFl?=
 =?utf-8?B?clNSTVRpcDdZZWVSNk5yVS90VldvVUhXeTdpZWgxd25SY3JVS2VhL2cxYWg2?=
 =?utf-8?B?WnB6TnZHQTFXOWR0RTM0Z0d3VGpNWjVEUXZmdnB6T1FTdEZPb2J3TWlmaDNN?=
 =?utf-8?B?M0JqZWZyZ1M0QXh1RXFCUU5kYkRkcENtV3k3NzJaMU4zcnFZbTM4Yy90a21I?=
 =?utf-8?B?NytOM01pRzZaVHRCUkRKcmVZRm5oWStxQXJqangrZWM2TVMrVUpTRmZyYmxa?=
 =?utf-8?B?RCtmVUhlR0YrYm55Zkh4d0pDN0RnSjl6ZEh1Qit3bmVSSzA0K0RucHJmbWJp?=
 =?utf-8?B?QVFIWmgrTVhrWmRoRlA1dDlVTFFHVms2ckNEMnJ5V1NsRDEyT0l0b1pJbFRp?=
 =?utf-8?B?Q2E5RTgxZEcyS1VhVUNpZGtYL2s3WFFxNGhHTlo2N2RWSmVnb0NSbFNya3M4?=
 =?utf-8?B?K3k3M2pGam9aVGxlRkpNMkZESGtjbkJ2TmdRSEptbFUxV3BFWVpsM284NG96?=
 =?utf-8?B?NE02R0hVQVVQMzd5UWZQL01DMkVBZnRwZ1dwczIrSlNIcjU0ZC9hUGJNZDlz?=
 =?utf-8?B?SGs3Uno4aWVNS2FSNys3Q0doZTJOYVd2WFdtcHdUdUJzeDRiWGtRNVl2bENJ?=
 =?utf-8?B?VVBKK0tQdmROQ1pVNitOaU1IZXhDdHpnRHBoZGdMWDU0T3VRT3NQbTFYbU93?=
 =?utf-8?B?ZnNBVGovVEllbVZxbHNla0JXYldkWHUxUVFCVEJRMm1iT2ZJSW1KQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f86064e-9403-43d3-97c5-08deabb053e4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:54.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcH913KpywRyBKnbOQG/wxwhwJNk1s6d/1RuSzPUJ+grhosQAeGQZA0VXfElqlnTnQx7GJIltF8hdttyF63CzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-Rspamd-Queue-Id: 16AE64E0692
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10250-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

dmaengine_terminate_sync() cancels all pending requests. Calling it for
every DMA transfer is unnecessary and counterproductive. This function is
generally intended for cleanup paths such as module removal, device close,
or unbind operations.

Remove the redundant calls for success path and keep it only at error path.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This one also fix stress test failure after remove mutex and use new API
dmaengine_prep_slave_sg_config().
---
 drivers/nvme/target/pci-epf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfecd796244e5dc67c23e1abb1a14974..2afe8f4d0e46104a1b3c98db3905cf33e8c9e011 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -420,10 +420,9 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
 		dev_err(dev, "DMA transfer failed\n");
 		ret = -EIO;
+		dmaengine_terminate_sync(chan);
 	}
 
-	dmaengine_terminate_sync(chan);
-
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 

-- 
2.43.0


