Return-Path: <dmaengine+bounces-10249-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKf2OY2o+2myewMAu9opvQ
	(envelope-from <dmaengine+bounces-10249-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:46:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7988F4E050C
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBA87305EA04
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3773B19A0;
	Wed,  6 May 2026 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SBNLq4Va"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386F3B27DB;
	Wed,  6 May 2026 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100295; cv=fail; b=f2DiM2htcfl84Sy1LIfyWD6DkSEa1iW+XiOOhQ2aKOOqg0O1JXJJ4z+fD7/XRVBgy5WUnU1qUBuzXp50DoiYOw6ngvps1qARJ8EzK4S7/tGNtGsRE1vhBFoArtWZcvLANJ1OJv7iAZqVC5ahLaCoo4Zd2QhWvPLgJ5DvDr+5GXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100295; c=relaxed/simple;
	bh=fq4DsAz/7+TkYNMSTMX8x+1OeNPeVgxgyGRkYyi5Geg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LYYMuSu6UV3p4q+wPwBcxb7JRMheJgawm1cAXD0qiRPUhGwv2pgyvtrcQmUiIuvV6GQ5vdybKOfWXnhUdjquAW+wSFKrHn+VNiHkHOqGAqNYL6hWEJqHXtyVwiRaVmrTpYxZFoI2/zFhhkEpKT+iqXyE63MWfqHyGy9Bj3QhDsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SBNLq4Va; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSEcaMm6TduZxNYkgrMpdVnW09PPH4zXCJfdxXofnqTREY3GOofniQJgZBsKiSP+pYZzTiPyHvYIZZHk2N0EYs7CHtUyX7yTnHAtPghF1OA08V7Bqcz0UVNkMR0Rfl/hPxi2imOxqWEvozsLN7bA4s951AkLRUraxpa6aHMP56QuNYr8fz1wjN3D2skOa+WJ7d3eH7x4C8jB+EbxYysN/2VR6lxQCc5a7RkCoxoEc9Akyhxc4AZQlwq2fVvL5fDJehw7bU9sOh7PdY4HV8yOcOoZLDSwJSsr1VIUgnXHQCwO6aqMe5x5v7SwD0xGhXwvs3uT4RVFxYlhSdxBMurQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EnggZeh/BfmXm2uhBGNXSh8rEssHuEDnHJLpe2lV/Q=;
 b=WQ8qr3z2B6K92IlgG2oSrKOA32ESP1RxRX10187TTQizOTjlqLMD+bSb+CTAToUrCd6jSO4fOS9BrAhAEFPThzkBTvUsTuK3jJoiAvuFxl0ip+sKqZ9FSgJr8v4Iol0YoEBKLzXaDSsL/H9G6RkC9OyrZquAOC880vtkBWluEhVmAJxPZiZQ1XNWjmplgV+f5uYkxJ/u+ZV/iUpCzmQGRsQbpC12A1SEgfuzA4ofcIzeb9Ql5Ymp4h8vT+CxKe56hyPNbf8gDfbXxB6nb657po4IrGvRTOD9NT3NQ64tWgMDor4vlrr+CgTu03YWLt3tMhQb8IzJpbgmufF5ANjcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EnggZeh/BfmXm2uhBGNXSh8rEssHuEDnHJLpe2lV/Q=;
 b=SBNLq4VaVUvSAz7DwDAOp2Y/C/McVK8Sg0gukB+81zD00L0q9IWWKZj9+DLz9N/bVPjNIPkY3zzw+7sYNnL2FLApL99byTipVWBaWcqt85Ips/MgffkS2ArwWyvi10UAseef1PCbE3jHPRpO9+uVJuWim0eJkbBmCKIOZAQmqGViQVRno5Mzl7REkNYrFd3ho/43AzMH7UqMDEFrIhPqj1m0WGhFbhJP0X9GOrU5cCNB8gNZQo9gwDcmGj3hC90UIUmesptUbxSqncGikMYNyqedtNE7ox5BbjeCYzsuTdZeMcRWvQBICQ2kDJ8fHiRpHwuUHYHvbUpC0ToFfZZK/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:50 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:17 -0400
Subject: [PATCH v4 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-5-85b3d22babff@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=3033;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fq4DsAz/7+TkYNMSTMX8x+1OeNPeVgxgyGRkYyi5Geg=;
 b=86AKtY6l/J/90EfIHGpnnvBrrzE1KuT7SxMv1LxRrDjNfHZABR1OB3/nosrEdDF2lFBp5/sRZ
 E2YiQyLE+/UCbtqPcsBn/Y4OarjKaNlXk4V98XBrsSAYAE4djsB4TDm
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
X-MS-Office365-Filtering-Correlation-Id: 0c8596c6-d284-41c6-facd-08deabb0516c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|22082099003|921020|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y+CC43Qfll1qlyI8EptGNXZwx4/PG0JEv1oOJPaX/gMaklGi47LXDlcIZN/QTs4LyjLZXEv7Z3zgyZ0PamWhbaMs/Khkv4oZB6HzOyiak25ab/iVT3XwazpAqUVfySTWjNsDmoJSq9C5ex4+cSwNESRvbDzmhWXqwIi27h3SwaHNI/EhgHbtDwjLI47D4IMrnvgqK62rKwVg7uLEzRK1d2GzoMxUgfkU1mMHHklLqUtaGJgvxDRY7Hcjq2Ro9bX88go66NGkxdZzyemO8nrMb6F5MrhB7pEhAEdWTCZFWEwcB0tZOtQwG5/BXmg9IwKgaBEz22dF4QbS6xqm1mY/Flj+vUSa5cTgeHVUooToX7rr/0PjOIswdqxd76OffUeCj4tQbLf1bbd/Vv54EoJ0D7oKtgHYbn9y6nAJZH4Nz7deCfV3kUltQKmWwZEJmS8fOJUYMu1CEAfvYkPUaHMmMrjPwyjHgCOLy6z8JeoCHD98iXRmt+e/PxsDnHdginleGRyQceVdQ2BOXl6E6DYOax03TVDaqVUaZVyBmZ7TUGsTsfChRmOJZLgQ5VQD4PG28ukbgis7Ja9DuA8ZxZx5hug1tl0mGZlXzPXlYNF8anWYO058gKSdbi0gDxJgjXGFae2a39OwSaGzKRt6rYFZbgzsVhaVewoYl1lx7x0DuLibqgIbf9WoSBBvhvl6nhRJOxlryCKehOJKNIdFNyc3EZWnUUoCGU9GIy6YKkU7H26J3OzpX7esdkTD2YHLbDRFewu/iUVOKH2zI8oxQ2PLdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(22082099003)(921020)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm5LeXA0aEk3MlgxVk43bWVEN2szOUNpRGhDZU5MaFkvaXpEOThrdjAxWXRU?=
 =?utf-8?B?VjE5WU90WU03QUpRUW9kYXFOU3drRGFHdFZlT0tyWk8xeWkzL1lFSVZyckFV?=
 =?utf-8?B?cVNXdTkwbzc4d0VwMEZJVEJ0cGM0cS92MnEybDlIWStZT1pVUlNtZGc4bklB?=
 =?utf-8?B?NWNWdkZvZ0REeHB3SEZrWVUxVEFUK01sbm1kajA3UHBlUTkwWjVrMzVCekhE?=
 =?utf-8?B?cGxmREpwazhNT0YrclRtdzNkdW90WnF5aXJWV0FoRVpnZW5hWEk5SDJoVENj?=
 =?utf-8?B?YVBuQVlIWUIwVVR3WlAzTDFjL2sxSzBpMGlNZDBrdkN0QWI0R0tLaWVJYVVs?=
 =?utf-8?B?MkJPcVlTV0x3bDNDVzZrZVcwUmNHS0t5amdxYXFQN0gxbVJMa3NMNUdyQTY3?=
 =?utf-8?B?MENnU3hRUHNkVUVXUG96RUlGM3owNyt6OUtRa0FnQStoRVJpZ1dvZElMNHRN?=
 =?utf-8?B?ekZXNGU3N01rQitBK09Hb1NaeHNkQlV1V0FOcUtNRTJpWG5vdERxYzc5OTJU?=
 =?utf-8?B?Y3FQR0l6MEI4MG4rSG1YQlRQTmFwNmR6RUV1Snh0VnlaUjd4M0I0NjY2VFha?=
 =?utf-8?B?a0hIYWh6bVRLRGhiOUpVZ3NPT0NndzA5SGF1L0pzbXJIN2hMTmVySFE2R1pz?=
 =?utf-8?B?Yk5MNzJ3SVdPaS9zTHlXT3FoVXRkbndHeFkvZTgzcGcrN2o0WDFIbVFvcmJU?=
 =?utf-8?B?VUdRN3FOUzZxdFd4cnozNTZmT1duQy9vdmNIUGtLNVBFZGRoSEo1ekJHYXo5?=
 =?utf-8?B?Rk51d3JoMnZIMmZTRm0zakhRN2tETVYrajBvdXM4bXBhU0QvM1Rvb29IaFF0?=
 =?utf-8?B?aklMc0Z2Tk1jYU5tbUxIVXZydWRnU3JwcERWVklhQW1acCt2WERIaTB3STFC?=
 =?utf-8?B?Yk5ZcU9ZWkluREZSL3d5eUNScERzWndWNUdHb1ZTMm5kSCtrOG5JMTMwNTNr?=
 =?utf-8?B?ZGVQN2dsMlVlemNNbWl5Ri9TRUE4blAxMVdoU01VZW5YRGNmcHhkRkZhYW5X?=
 =?utf-8?B?SVh5SXpzbEdQYThKR0ZyS283MUJaOGZORlkvUDZsaE9ySWUrNUVXbGJDQWNG?=
 =?utf-8?B?UTU1eVQyK3pFZEpLcTRaSW1zU1JZYkJtMCtqZ0RNdEFadis3V09lcE5KUk85?=
 =?utf-8?B?UTVxQU5wZjVYMDlXVXFWc3pFMUN1N2FhQjBFc3JtOUtZZ1ZmTjFOSkRaSkxS?=
 =?utf-8?B?QUpXeWRGVWRXM3EyYTYyRXA0aVRyVUR0MTZZcHJkc0ZoZk5tdlQrdnRlYzNN?=
 =?utf-8?B?QWNTM0t1cFBEVnp3MC9nRm9SZjJTMXpxcEJnUWpMQXBFOXdqaWRjclFVV3B1?=
 =?utf-8?B?bmNOTmNBVDRwTlB0S3hhK2djN0drcHA4Y1NFblNJNjhDR2x0QVNQK09nMVQr?=
 =?utf-8?B?b1Y4cVBGaGw5MzgzaXpzR1pFU1ZrT09STlYxTEtBQVJaWHpHc2h0NlE0SCs4?=
 =?utf-8?B?ZnMxVVlib0I3N2JBZVYzY05LNUpaTDV5TzRyMnJRR3h0Ui9ROGpyNW10U0NS?=
 =?utf-8?B?RDkzbVkwaFBpclNWUzFyb1VQTHk1aG1kbll4cnlpejB1MHRUWFIzZWRRTXQ5?=
 =?utf-8?B?MEdXSHhkNzBPQ2dQNTI2MWNYT3lTcnZXbFVjVnF2TXZVcGJxQ202cnd2QVdN?=
 =?utf-8?B?ZTBMZG9JTWliTVlNVEI0U3FQeVYvdTE0TElhUHplRDhBMTNzZG9QVDlGRHNX?=
 =?utf-8?B?cGVMdnFsSGVuWisydGZ3TG9KMDc4YnNWeGRwN3hqYjdQVElncys0aHJNNmhr?=
 =?utf-8?B?MkFFS21VK1lucXJlb2ZOdk1aVTlFYjBQOVQra0ZvMEhOUlExMW9IVDJnbUVq?=
 =?utf-8?B?aHRlRHNVbnJDaGFSUjZtV04yUUZCdExZUGFqMW5jYW5IQzBzcmZPTUZ0UmdF?=
 =?utf-8?B?RktpVENRRGJmVnZVRzB4emh1RmF6dDNGU3NSTHVOTXU0N3hTTlROZWdhVmVx?=
 =?utf-8?B?bHh2OUNLNE5URGMxNE5mTThMOU9QOEIwQkdONVlhWVZva09ZbUNFcGFNZnlR?=
 =?utf-8?B?NDIxY2dLT3pSengrNFhtQ2h4TWg3cEQ3TXoxaTNwVkRhTERVNFMra1o1Z2RF?=
 =?utf-8?B?cm5Hdk93VjhNNmZRUit4dXJ6K2VkVmpRRHBBL3Q0Q0pDc1pUNGFkWGNrUjIr?=
 =?utf-8?B?U0ptOGthRVhhcHF4OTllV3A2amJCRk9pRFRDQjNscFZzUWtQMEI5Vk9PUkNv?=
 =?utf-8?B?QjhOR3ZJd2RYR2FPZHFtUStkT1pGQUpOb1NGejZRQy92amJubk8zaHpyODF6?=
 =?utf-8?B?TUU5NTloayszeUZQaTlEazc5T2ZNckduZHhuN0EyQjVwVk9Wd2Z2L2dQeTMz?=
 =?utf-8?B?UW4rWFRuRFA0ZHh3OGNiZEE2Snd2YWl6Wk95Y3VTaXV4dk1wS3RzUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8596c6-d284-41c6-facd-08deabb0516c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:50.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlNLcF/VZTp+/uXN4P8ImIQrnY1OlbxPSgE044TFG4FpSFggauTmtFcG54mC41j0YFC3+XVnu4cWX9I+vGxhGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-Rspamd-Queue-Id: 7988F4E050C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10249-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Pass dma_slave_config to dw_edma_device_transfer() to support atomic
configuration and descriptor preparation when a non-NULL config is
provided to device_prep_config_sg().

Tested-by: Niklas Cassel <cassel@kernel.org>
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


