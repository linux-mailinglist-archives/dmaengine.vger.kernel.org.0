Return-Path: <dmaengine+bounces-8151-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E165ED0AF0A
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92624304FA14
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E12363C63;
	Fri,  9 Jan 2026 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fqcL19AZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33783363C5A;
	Fri,  9 Jan 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972549; cv=fail; b=c6mbEtBC7S6DUVBBxa43naLvRqgqsImoNlRUJdiVcoKixA2TtZ1CnH85rN/dabVdD6hm7Ex+MP1Akrc2o60vCsARDxgLMBSUQ1/a3YiKWubiV3gZdlQ0f/WEELcjq0/ARG4/QN8ek6Y+KoPHeifEYEaGbqgQfgXGD43xJSsGZ+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972549; c=relaxed/simple;
	bh=4IOZc5bn/cXuVYiNt9uCCiSLEc7b5zqzANKyR82eX7A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pQDqbgAGpD5Jao93ye3SYZoCoLF7SQ6D5gDDt2w/oS9yx8MQ6EmmeNEcC9tJo0s9VQXIjMem1rPaEn1BnhoyVmhdwtnsQUNrtEbThzwqD16DNAatF7VWLWN5ocHl9I+Qlx1DEyh44dpyHGN3HHe1Eh6kOYuLGv8YpbKG++5nB+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fqcL19AZ; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnuNUWW/hS96JcdwmmB/ZiVZkBUF7a2b3X83q3vOT+GKyAw3smmG7/yc0LJc9/R3rAoN1mS0SP6qHmqxCn1tyOGG4S5SscKlsjW536nI1YDS0v+MHShcJ++Ef0xtpmw7Sqkzdk8hFCEnfBcCANQl8+g8PZ4R8ZrhN7xqn+pjdUV8jKHli6PQTqOcc0nJpMHvRHQZAW6bvx+RSzv6WsCGQdls/cz808hTVfy9lytgdZOW3Pvk08WASuVFFrzRsa28DqpQLHkTfu4GGk4a0FymbftBo7iRGGlklE18BcV2azY+m+9OJb5CJ9RNRVNxpWq8qYhrgI6OOf7iGcwyenZIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMM6RnKeP9dwko9pP4440Xhy39FCuGEWL4X4if0SsO4=;
 b=xTL5g4bYV8t7P7we6EGKIQxNm2QbGmhuXUSEod9pcoAVvnevG/XxxObHfYhwRRIjb9lKBsZn7fJo0U65+sJgZlZcq0/2GQinypui8LDYNZySxLJqGB9e2Fk9TMvO6P701B/D9cioc1/qonxqTRdlq0uCIoB6p3Go1RmLZdQtesSuAzBv8H971NK8a6D1pg9Oht9FZucGgLapA2J4SUB3ScbFGnt4X1R/DAcX0hx8ZGECMZC1f0hal835be/bul/kK/MybdEumsNSUY9NVoPssM7wtfLSDZpUrovvuaK1WXA4woVDDpr3BfXEbWk9G1la+bh6n1RsJ15zDP314HVihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMM6RnKeP9dwko9pP4440Xhy39FCuGEWL4X4if0SsO4=;
 b=fqcL19AZ4c05lwyMEy3cHvs1I0QTqEQdp2FvLDc2KFBRjaw+0sgeC0w3cQwDFq5ZYqcEQT9PMCwdg8XGD319JmlEXfVwdL7AWntldILa4kCuKLGELA7Ti5tsE+YBx8o1eBRSJBtBMUxEf9KobrbgbOPuskmXHy+5jEUY5B89QGpNJAf0K9bXAkkILui06jCB/JyxCy9TTLv5qEcuILfPJKvvrxI5MKDSGyDE62qOdAZdTfFPxFSMnMwYS5459Yf/zzr+JXWACTG2RYavtZ+cQp7LH8U3LNXbVXCJWJLgvMxBUgfTFWrY+id3fTYj6gCMKlLn6Zd1ONkhM7nQPFQi8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:04 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:23 -0500
Subject: [PATCH v2 03/11] dmaengine: dw-edma: Add xfer_sz field to struct
 dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-3-5c0b27b2c664@nxp.com>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
In-Reply-To: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=1785;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4IOZc5bn/cXuVYiNt9uCCiSLEc7b5zqzANKyR82eX7A=;
 b=lpnFXM/MxaBT7VXaMdQ885KN+0qKZeVl2KdbJE1bfglHCM+tzWbxbN31IBuXhcI6U8DXzrAov
 Blw4aDCXMA8DZDw3FT0CQ+X2p5HsO1drd0cCn6/3y26gEWvrAbVK0l8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f781a95-44bb-4064-7cba-08de4f93d218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWNBZ3lYL0tLRExRNkV6QUgwdUF3RCtiNmNmdG1MU1VpVjNUeU83QXBKNDlL?=
 =?utf-8?B?eXVMNFBTdVVnWlRVTTRoczJQZ3I3K3FyQnA5QzNTNU5EN1l2Ui9IbkppdkR5?=
 =?utf-8?B?bFRaV0lhRmZsNDJtTFRIWk5mNDVHd1ZKMXREK1hjdit3bFBTTityY0dlVkhr?=
 =?utf-8?B?VCtGRk1ua0xIWjhYOUNGME5FV1FZLzBqRHZBbVYzWkZGTmtMY3pMVEFLNWdR?=
 =?utf-8?B?R2RSaEROR3M1RTN2QkxRa0lGZUY3MjJINW1jSGVoVWFYUE1lUCtOZC9sVk1w?=
 =?utf-8?B?UjB5MUg4QnhIM0M1a09CVVp2WkRPdTVlRjUvbzMrbC9SQ1RiZWhHRkZRVnJY?=
 =?utf-8?B?RGR3YlVHa3lwRlVWckg1RTBReTVIMVJjRnNaR1JFK1hUVlJCcW90TW5QUGg3?=
 =?utf-8?B?eU1RbVV2bjV2cUJoT08xMDlTelRVNEZHTEhHZ3RBSnV2WnJoQUlRY1ZBMzJn?=
 =?utf-8?B?Y2U3WGRNT1dmanprS1JoZ3F0ZG1yTkdsQ1VCVmVkVUFjeFg1T2FsaENlTFVa?=
 =?utf-8?B?NEpQOWdCNm5tcW8vVVNzZFgxV3VDSDFjdWM5aS83VUVNSjF0NHhUTVpQZ0lm?=
 =?utf-8?B?VjZZMXJMMTMxZjI0eGJxQ2JvOVBtUG9wYjRINHZWWFU3aWRaRkdGdWJPS0Rj?=
 =?utf-8?B?QjdtQ2RoNVJKQXNkczhSUU1vZmZkVlR4K0lBMGMxUUtYZ2kvTExVenJJbTNQ?=
 =?utf-8?B?WHdKQnVUL2szbmZobitBZFFpZklZd2gzT1lVdHhPcXhoL1RkeHMyS3V1SEQ0?=
 =?utf-8?B?WEtMc3RQdHUzazMvUExBTE5sZWtFNE1waUZrcVM1aW5USnpOR2lkS2lCVTY4?=
 =?utf-8?B?SHlIK29KYnNWV1cveTBLKzNiem5IVldEYTJlY1I3anptRXB6ejNUcjhjQlUx?=
 =?utf-8?B?azlUNEFINHQzSzRpVlBxZ2lYN3prS2QrNURld1RoK0txdTluaEVVeVc1ak9a?=
 =?utf-8?B?azZEQmdTZEdHZkRub1Q2blVVcTVQQ3RHRHZpRlVaU0I0KzUrVFhWbUhsWUov?=
 =?utf-8?B?eUVnZUtyMDZxRUxxWFBvQzZSQ0dyUEJOVytOUW96eThNajR5b08wcjVta3pv?=
 =?utf-8?B?UlhUcjV5V3NqRERJV0xDamJJbTI5eGFFZzR6eFpaQVBYS0hGZ3lqUGI1Y3d0?=
 =?utf-8?B?WU1RNFM5em14SW1JalR0a2ZIZDhCYlRIcnVqUlBqTEozL1Y3WVBvaEpGc2VY?=
 =?utf-8?B?dGFCVXBGQkx4MlhWYnVyQ0lEbTdWeXlSa1lnSHVMUHJnbVBpWGJla0Q0NDFB?=
 =?utf-8?B?L1BkVjd2blhMYzZDOEZUVFpaaUMwZU00VHNkYmR3U3YxT1lzOHcwZmlWMnMv?=
 =?utf-8?B?TWhNRjhORlkxaUh1RUdxNEJxb0daWkxEeFA0bzdVV0NoeUFjbFVQbzhLeUlo?=
 =?utf-8?B?ZEFjR2x5UkxPYVZYd3VVMk13UW04K0U5dnZiTUxkS2x0VmpvRTR0ZlBuSHdp?=
 =?utf-8?B?SDdCbmJLdHM1OE5XQXF2OTg1QWNZSzBZUmFldU9PclNCb3hLbzNrdFMrL2Jl?=
 =?utf-8?B?cjFLNE1TRE9vZWJVQVBMSlJhMEtBdytJaTdiRmw3UXNkUjZFb24wTHc1V1hT?=
 =?utf-8?B?Yk5scGo3Z0lRQ25YTVU0RnNuTGpBZ0FtNjJyVVFjVStJR21GOGdGaXVjZ0NV?=
 =?utf-8?B?YlY3ak1aK245eXFId2tpaWtaWURzTWc0aVVaaFU0VlNKdExRd1k2Rnl1QXla?=
 =?utf-8?B?ZXJNeGxvWmdlQU8zcDlBbWFBTlZDRGJlc1hNQ1RMTnFZdmRkQ2VQRHdzU3pT?=
 =?utf-8?B?Z1Y0UktQVjdRUldIbmhVWkgxS3FrUlVFNDRwQzdieStSbVRRR2lVcGo2UEUz?=
 =?utf-8?B?WXlPR016dng0c0JMeUFzQ3k3TmMra0cwVThmd1NybE9LMC9hRG1VNEt5b3Fa?=
 =?utf-8?B?eDhJbkllNWNTR2RFazVyc2liU3RvYnQ3M0tSbUtvRGU2T3l2WHhRbDZCdWd6?=
 =?utf-8?B?M0N2MUxuTmpKaHJnUU0xVVhoU2UvMWY0elg3UGdQbEU3K1VXRDhnb1h2OHdG?=
 =?utf-8?B?UHl6VU5JTzREQjg2T011bkkyT3ZDbmRyUVNZakJGbTNNYnNOR1lRQWFFRTB1?=
 =?utf-8?B?ck1mbTR6dzA5N1FZcjBpLzZmNVNpRmpIMkZvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVpraHBZNEJKRmJWU2tob216aWkvbnZnVDdRV0NWR2NSdXd1MlhwU0ZsMGJT?=
 =?utf-8?B?MGw4UksvYUQwendpMlJQVXBoS1BvdTlVOHorY3ZVOFBETlVXWllLRDdRWlov?=
 =?utf-8?B?OTZUK1VWQldiS3NHTVdHLytTQkZaVlA1Vk1pdU90ZHlHZHJWaHRkcGdYV09t?=
 =?utf-8?B?dE95OGZFa2NDaVhsV1ZkMDZxTkY5MncxZ1VpUFJvWWdMNGF2MWlOWTVPSXJy?=
 =?utf-8?B?RHBHekZYblZ2M3RnbDJSQ0l5ZGVCMHMxVmR1SUZKOUNhQy9NdFJESENBSTRB?=
 =?utf-8?B?bk15K1doZUQvak15TjJDbURJMFJkMnh5RUNvTkdSR2FXNS9qeWJtQndvblZx?=
 =?utf-8?B?TXIxWWYxZVd4UUE0aTdlSkVsR1o0dExMbkJFYzB2bGpWb3BGN2NjU25NTmhG?=
 =?utf-8?B?bitmTE93TFNuNlE4NTI4ZE9TUjEyaHdQZ01oZXJOZGxzSGViWUpMZzQreWQy?=
 =?utf-8?B?S2N3cG1nM3RuZTBlbjlWSEVhZkxVd2JGUmNDdldlcWJoSUpET0VoZ2YrekZk?=
 =?utf-8?B?VHp0cFI5UjJpL3F0eU5QSEYzREV2ZzR2dGFuYnZyUGNPcU9ZZzBxMHMrZnFt?=
 =?utf-8?B?UHE5SW13S1pzNUVhU2sxSnV1eGhFRWpVRDNsNGhmZDhUVm9yOERDUW4yRldF?=
 =?utf-8?B?ZDh5WVNjdm5FVW1aTnVtNmhmSHpiZHI1d3F2NWhOcVc2Y3JxNHA3Nis3TmVp?=
 =?utf-8?B?NXpBTHVMUTRKS3FVNDJEcUNzN25wRVhvMTgzeDJOTXhWWGdsSkQ3OXpKRWNj?=
 =?utf-8?B?cWNLSnVrTkN0SlkxNjF2V05WdXA5Wk1qV3lTclowRStkVHlOdFlicFI1S1NP?=
 =?utf-8?B?cklkc0RJdUZIRGRRVlBmNTg1ZG4weHJkMTBqYWpxdU5CYVFLcE1weWo1R2I5?=
 =?utf-8?B?emxrQitmS29NWE5OQjMvWHA2L0xDZjYvbTl3VEN6WVg1aVdlaVRWVHdFZU9E?=
 =?utf-8?B?eHU1V3lGRC9waFN1SG9DR0EzN0U1UXMwLzVuVUJCczQreEdLYjhla3Y5WHhw?=
 =?utf-8?B?YTF1ODIxYm1oTTFidWx2c3BCeGpPNDF1d0plM0pOLytaVDhMY0VKdFFXS3hh?=
 =?utf-8?B?bkxkcGhxMjE2YzZWcFU0MnppS2owenJaSWwwZ1NFcmFZcW9HV095czVpU1hq?=
 =?utf-8?B?Qkh1NUJ1TTdwbkI1enp5bitJOXg0d2E5dWhMVjRCME5NN2hIS0xITUYwcTZ1?=
 =?utf-8?B?bGNodWpFTnN3My9lancyRHp6MEdMWk84bFFwRm9MaUdoUDBldHAzQUtnSW9I?=
 =?utf-8?B?ay9JQnZPYXNaajdVcFBOM09rMjF3d3QvQnAwSGY2V3BEQTJoQlZ0MXg4eHRJ?=
 =?utf-8?B?NVFiYWFvZDBpd0xac3BHNVE1Q1RVMzZ1bTBDaDVVaWtqcjBLeTc2NUtJbmV3?=
 =?utf-8?B?bkE3eE1EeEsvandMM0tVMHRmZkE0TnFtMDYvWnBRUk1QN0ZTS2V1QXNuWjIx?=
 =?utf-8?B?RDE5VnkycEJPYVlWL0tlUllGd3NxUCtnWFhzVXRzb0t2eGxwQlhzQTNaamJN?=
 =?utf-8?B?bThINS92TTNpNTYwMjRVTWxRaFNMTTVCRWhmTi80SFhLdkdlbGFKU2dOQS93?=
 =?utf-8?B?dVpwa0c3MHZvSTdHbk82UmU2eDVubXFya0RhMDB5VGpQTnh6WE9WVmwxakFy?=
 =?utf-8?B?R3BJR1N5V1htckp6LzEyQlhwSStwTUVhUjdFalBpRkNUbnFMaEwrNFQ2cm5N?=
 =?utf-8?B?cTNZM1gwRTRuM1RGWnpIaXM1SmVTdFdxWUQ3WnU5b1AvckJETkEzVDc2QmJW?=
 =?utf-8?B?Qi9hQyt3QVh0L1hJY3NWaHFuU2l4aEZsa2lHRiswemtKZ0hkOG1HU2lOc1Js?=
 =?utf-8?B?SWM1QWV1ZThicDlCTUovcFF4TktRcTBrQk1sUGxWWWhTUFkwSG04WjRzWTJq?=
 =?utf-8?B?d3dHa21FbWRISGNidm80VFpjRU5mbUw5TG5GOXdUditrcHJOdFE2K3dsOWZo?=
 =?utf-8?B?akJpMml1M0ZwcmhTaTJobVo3Y3I4Z0RTcGtKUUhCWUtPNjVHZmZrVGZOSTlu?=
 =?utf-8?B?UXdVY2lEN2pnNG9mQlh2emNFL05WL3JFK0VKTExFTUJDU25nNk04djFycno1?=
 =?utf-8?B?eUcxdit2NTR3UGkrTE9aQzVYZEcrSVlkL3FleHV3d0FpMFRIRStKcTArUyt6?=
 =?utf-8?B?YXZvZ0xkMW5iaDFpb3o1NUJ1ZFRDVGtQT0NSQXFRVFZ5aGJrYTJ1bzgvelFV?=
 =?utf-8?B?MkNOa1IyUVB0b2lUdHJpMll1cTNTOHlmbmx0M242RUtNMFN4NnIwUTYyTWxH?=
 =?utf-8?B?eVdUeW9aM0ptUEdUSVJMNXNPNHp0Qk1md0tjSUtQRlo0djZyRlFaRFRmQnlU?=
 =?utf-8?B?UXFTZ1UwRlcvMllmRXZDbnFlY1c1bXRxa2dISEdlSXhoV2N0SlpXUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f781a95-44bb-4064-7cba-08de4f93d218
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:03.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTnOBY5W6G2CguwVZk7X2ss52b8RkBHA3em6JPxdKUydylCus03ddQlqwzWkQEHTCxHYRV5576KjAa3qEDNZrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

Reusing ll_region.sz as the transfer size is misleading because
ll_region.sz represents the memory size of the EDMA link list, not the
amount of data to be transferred.

Add a new xfer_sz field to explicitly indicate the total transfer size
of a chunk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
 drivers/dma/dw-edma/dw-edma-core.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 744c60ec964102287bd32b9e55d0f3024d1d39d9..c6b014949afe82f10362711fc8a956fe60a72835 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		return 0;
 
 	dw_edma_core_start(dw, child, !desc->xfer_sz);
-	desc->xfer_sz += child->ll_region.sz;
+	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
@@ -477,7 +477,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->ll_region.sz += burst->sz;
+		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b1539c636171738963e80a0a5ef43a4..722f3e0011208f503f426b65645ef26fbae3804b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -57,6 +57,7 @@ struct dw_edma_chunk {
 	u32				bursts_alloc;
 
 	u8				cb;
+	u32				xfer_sz;
 	struct dw_edma_region		ll_region;	/* Linked list */
 };
 

-- 
2.34.1


