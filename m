Return-Path: <dmaengine+bounces-10248-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBuOG2ao+2mYewMAu9opvQ
	(envelope-from <dmaengine+bounces-10248-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:45:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2108D4E04DB
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A3A430241B3
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB53B0AE6;
	Wed,  6 May 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LiV4ZCpz"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDED3B19A0;
	Wed,  6 May 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100290; cv=fail; b=D7l2p0ioT6EgKM07Z1lBrDcccH1dr5fqpfkVfU/90F0vMSp8AersT2kQ5dz5jeodlX5RmLkOZSPA1540dQjKW/QFF59EiDNPE1J2Ksy3wsXsRpyq7oOkJGMf1cSNjm6+HJvCQe6bFNKtig0RKr74+ut43q+hxNG7YNwi7/fFdDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100290; c=relaxed/simple;
	bh=PVqkwlDevLa8q//bvILaa09LG3I8Y4Nq429mLidRViQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b6eMgcK3N8OGP5xDMrFaAiDaFFpQNsbGVIpSPbdFqT0EPRbfNJGmSV4Vu3wKjWkBTFLsuoJFko24VbGcyDO2vLQRR+2JZt2JHXb+glJaj8Pi4YaL8N+VJKNuX4D7uBy5PTnchDAIFfv+Wv06aYM/wqDPVKDPDR8/YoibLu1DyAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LiV4ZCpz; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+Tt7ek35buqCnNptQIut9Zaj0BR5pBrgfIG4Bb+KfeeddrciobWaTN6jrmKVccrCSqSIMh2FmRekWt0z8N0/TcIWE1NF+RGzPatrSm8+VJtnTpUvYcuMB5D8ReaW8VMzPsQt2TMa/1fuhiuMjRvNQk60V7QeyBo0E28eue34utQTUnNfPDRzxIldrpzaSPPuwo/5DTpYWS8Nr4I4rIig1WoHMKvagDZhPRcipo83QenZnc9QAWltDkktrRyfFxqVHHilc/hSfIcnfIt9rtMOChGYyUI5Qzn4ldftEEdmZNsD5jJqxSsqM9kFkbYK+pH7DucHmv4nzSR1e4kKKmUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSEGfcohbjolMDhqk6iLshH7TkWZ6YeHmm3C5JkIaAk=;
 b=qza59MTlgdOht3qtMgz6WTMeQBb6phzX9xOP8Jy0vMK3/BXn8XZ1c0fF2h1fHOnifLJohRBrvu7XCnxozWFWs7Re3PkJD4PrIIr45YNFmQeBaS7AnsPws7xAHAju+yO/qOzIcJYTWmmBCaG3Pr8y6ppp55ZnO2dt6TDEjZJtk7qNzBSgiNM3papGnHtofqnzVNiltYh+iZmhwzXsfpbnX5rzqjnYx5zTre+q2yESJ8Fh7sRhJbSVYNNDaXXC5t6PpjjLm/RQ8RTGkol1sYx+2mQ7bKgfafzn2o3dyHquy1TjWHXesZ2QLBxnAdQoe5tr9j2xjus6QQWCFJl9AUrZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSEGfcohbjolMDhqk6iLshH7TkWZ6YeHmm3C5JkIaAk=;
 b=LiV4ZCpze5dQRC0TquGlow1GxrHoNPJsSOm2EIh12/FlBKuTFCe3T+DyMzGDuwlrl7nxQ95ATbxdkkbceSxkPTtgysk4PTzxXc3d3JYdINds8FaLKLbgZRbIk4rrqVw0vNGq7tMNOJRo6vI0L2XG5jWVwopAlvtdvMua9pWTWQhVc/FgQW7hsXP8GyNTQrFtx3tTjrzGgI9ciHfNDZYxfhkx/aRRyqAtOtdhGYMWnkyQDjW9r3tZhMD7+cQMO0WSpuvtl9OcFTd+i/QyajnOucwhKC1OnSW/ylPR3bOJWwPvWahkZWs5h6UXEAm3FzAeEUeQGlxN+3hZo/YVbyjD2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:46 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:16 -0400
Subject: [PATCH v4 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-4-85b3d22babff@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=2185;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PVqkwlDevLa8q//bvILaa09LG3I8Y4Nq429mLidRViQ=;
 b=dTs/PwqVfZ4qRXABfF8i8TpPglFRnpedoCUViUBEDAAtieGEEeoTOF6JqKzayGBXyGV9phbh8
 kfvFsbjzjhRBPK1++TwDsMzc5VFP4Ikuw8xQjHeSsPt4nzYd88hylH5
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
X-MS-Office365-Filtering-Correlation-Id: 3bc3a17f-3616-45c0-a40f-08deabb04eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|22082099003|11062099010|921020|7136999003|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	lnevWndhUnLYIydQquFYCZvwxafvgfUsCJyvro595HKUHuzmg/k/trWGT4fm3FzI+sa8Y3H52TujhmmSE4sTXbD+Lk3QRP03mBb2MbA3Md5RkeD7XddtNOaez2YylqUM3Ger1RB3oRa1q3yXkxXxs1uQYuH40dbyowRarv5OJ/mHhhS2xNa70Jy9sIvvYbTgqvbksF2Appph/bss7+DqSQpgzEz8r30fiRvPLb4Kubbp2Dwg1y26on94trQ4l3QFTnuyIBGIwbaypHt4zON5qkpnn6mME9lokCpZKH6IvkZqqyxLvl93vYUlhFbE4gWdzdn5hAHnVgtmzesZcL3HsCCN0tHIOJ10RdX1+1q0oFMbwbrKZXzKpFAR/MFGOU01a5D5uGL4Rbh7zxy5DKBYV8I8bkFJhs/+LC+wM2al/kyB2w7NDGFEZzYFXVlGtstP42BMIbASVj3MbdA0p9B2MDjtsIY/9teDKqkM5lb++Gc/jqQItEFR0NCpX8eyMt3NzxzbvQwDtivwV1X2Wcrhb/UH6YWufq5nYF3O5v3CwIk2I6SuW3izAF+8WOTUCy0FjLaVTxeZ0gXz6o6xo2jIJcXJzERSVDpy0qRgu96X/Swy32cIEhSYxl5f8jctfSvdEmRLVq6MV2nqI2jVa7X4O3Vlj6UZoQgr4M/JjzYAQPzfhzTRcOh3rwEKlS1D0rMu0HloSWqlvur+06uI1MELjcIrHkBPXdozGxj2hBmI5KullOup61nkPy3KD4j0o0/OkRWKCuxu8nVlehp9mU+IVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(22082099003)(11062099010)(921020)(7136999003)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnVLQ2luZW9TZDhXemozSkg0Smhvb3hMTGc5WGswaGV3MG1KbTRrTitvbWU5?=
 =?utf-8?B?b1d1K0NZSXpQdEJub3FYaSsrMzRSM21EODUzbmY2Y3QwMlZSOUdPYnZteDk4?=
 =?utf-8?B?ZHNzUU1lckgyajN2K016Slcwdm5RbWZtWEJNOXVXVE5mQW1LRjNQbmh6elFR?=
 =?utf-8?B?RUFuSDBNOCsvTjZ2UzNCTDVZM21tdnEwZjRDa2tOZEh4QjAzT0VKTm4zSHQy?=
 =?utf-8?B?eEd5RE9OOWdSUUl3czJJUm1aeEY4YUhnQVkzOFZQdTRXWFUzRHdPMjEvSEo3?=
 =?utf-8?B?eVpqQUlvemMyTEJNU2VGNEludVhnOW1IZ0N5UkNYS0hKVi9vRGdnVjVBL1cv?=
 =?utf-8?B?eE05L0VjN081TjZVc3RqRk1zQ3FHM0x1bFdnMTB1NW93TjU2ZEQxTGVMN1Fi?=
 =?utf-8?B?OHVCZWNUUDhRMDNaTlFOTjdNb0xTVGlSbkkxTEgxUnlnekI3aW5oeTNBV3ZH?=
 =?utf-8?B?VXpFaHM0S1hnUmZGbnNLVTFEWnBwVGtZbmJxQW1OVThpUHcramJvMTlYTnRS?=
 =?utf-8?B?UHVQNldSYStMdW13Tk1zczZoYWhhaVNVbm1leDRsdVd3eTVmN1k4cU9xSjlW?=
 =?utf-8?B?aERXYlJrMTBHdHVDOGZvYXhLQVRHYjRvdE5hZlMyQ0lac1BOeDF1T3NuMHBO?=
 =?utf-8?B?dTd5K1dZcnp2SUdVRWZDVldzdVk2QThPcVJ2QVNyRi9lNG5NdUY4OWZKbERN?=
 =?utf-8?B?Mmc3K1NoOW14aG9PVzh6WjZIeW8rdEhMMytHeEtmelM0VFpOcEpYOFk3R1hi?=
 =?utf-8?B?NU1nSzNnZ053dnVrN2dxMUEvV05JS0cxWnZIdWcxM25PdDJ3ZmVXK1UvZ3VT?=
 =?utf-8?B?SUFmQklJWDEwQVBIL2cxMDRZMmR3bEtqN0tIZmR5c3ZlaVlhUWl5L1JqckpE?=
 =?utf-8?B?Vk1jN1RVN3RVL255bXlnN0ZxY3RSS0JVZUg2WGoxZjdaa1JPaDlGeHF3VmN2?=
 =?utf-8?B?Z0RsbStHc3dYbmZzazgyQWFEVERic0xkQm01NXc5Nm41ZlFPZ0s4SnVWMVZk?=
 =?utf-8?B?cHFqZ3pIU2d1Z09RNjBaK0dnRXZQNkVRaG43cGVvUTF3Nk5CLzlnaDFVd3hM?=
 =?utf-8?B?Mkh2YmRUUkp6VE5LeGhDNC9Va0dINUVWK3dqbjNtZHFERzVSVXU0a2Z2YTc3?=
 =?utf-8?B?ayt1emdYMmZpQkcvQkJ5bldkckVaZDRYQXdkQ0JGY3hRQllIQ1BnUEpHK2JM?=
 =?utf-8?B?YzRJZk12cll3bXk5SXR4Z0s4bHpRVUdVUmFHWTVmVTBoYWtNVE9IcHpvbzho?=
 =?utf-8?B?elJkbDFyUkMvWE54U3RsS2laR0tiN0wxWi9sU2JNVGpVNGFTaW8rcUdkc3Az?=
 =?utf-8?B?Y2YwZ0dBRkpQcS9tQzUyV3FXV3pVUXlvYlk0L2FEc1RVam94VGN5azl4MlBE?=
 =?utf-8?B?WGdRWnVSU3FYS09ibkxLT0taTTZhTzNnWm5LZGhxeUcyWGJDcG1YMTdtd21Z?=
 =?utf-8?B?M2R5NTlQVXJ3NTZTUWdUR1VweVE4U1lsRWtIMWxIc2RNL0tIaUZud0VLOXNC?=
 =?utf-8?B?cTNWSTNrUHRJemluTEpQTlZrTmZaVDNIR29PZ01SRzkzWUxKL0U0a0NNUHNN?=
 =?utf-8?B?VXg4Y0g0M3Y4ckpRS2Eva2ZZNGZ1bTRVZ2IvRWQyaDRnM3BPUTYxL1Z1bndN?=
 =?utf-8?B?WHZjbzJTSTdZZUNQTS9hcTl1NW8wODJ6VStYM3ZKaHFCcGozNWphNExUMUZP?=
 =?utf-8?B?UDlndEVkNDBBYmpwQlQxYXRPQUtYc01LNld0Tk5veEJsTE0vbVNsYno3UFRC?=
 =?utf-8?B?a3hMOHhtN3k4anhnZ05QOUU4VXMzdlpqUFZLemVqbThxMnMrSFlGVVlwZEE3?=
 =?utf-8?B?RzdxSlJSdERROWE5MHgyTk5hUnRIc1F6bkxzZTJBVkpBTjZlY3pkU0pFbjZ6?=
 =?utf-8?B?bUVtMlpLMVUrT3lub3k5UGFsT3lnalcwaG41dlN6QUVHT09tdEY5NnQyZW1q?=
 =?utf-8?B?VW1EYXRzNG9jUmllK2xIV1ZVOUN3d1pUeXZMYUNhTysvZEZLSXhhV2xndXJH?=
 =?utf-8?B?NUg4bWFEVkM3YWljblIzRGIzYU1XQXhvRTBWSzkyczVJZXhxQk9RMU15K1l0?=
 =?utf-8?B?TUcyQmx6SnNtdHFrU2o2em8reStDYjFwamN5LzhFejk1RjVqdGQzelgyNnlQ?=
 =?utf-8?B?VFpMcHc5QUg5NVpGdTFrQ04vMnZqT1ZlNEo2U2lOdytha2J4bjV2MG1DTk95?=
 =?utf-8?B?SC9Pb2g0RGJSZEZLMGFoMFZyWFZ6VkIxK21SZ2orTzVtQVFxSkkzVVJLL3dX?=
 =?utf-8?B?UHVmbmo3dWZoTkZLS0RrZ0pDZjFPekhtc1l6cnVsQit2Wm5jd1NkbXlTOFY2?=
 =?utf-8?B?cmFaanhHZlc3UDlKcXhTRlRkM29YZ0twdHpNelR5MERyTHlCOFB6QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc3a17f-3616-45c0-a40f-08deabb04eab
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:45.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH1ZCldSufmHevsa56wWarke2gOTcVbx0Jy+NRASuFRGqbsvNxdQPHV18Uj+lV8tfQ0gI4Fl3HT4U/iffmg7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-Rspamd-Queue-Id: 2108D4E04DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10248-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

Use the new .device_prep_config_sg() callback to combine configuration and
descriptor preparation.

No functional changes.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- drop context in callback.
change in v3
- add Damien Le Moal review tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79fa94b016913443305b9fae9deef12..f7f58b0010e26b529ffb7382d5b166a703587c71 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -577,10 +577,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
-			     unsigned int len,
-			     enum dma_transfer_direction direction,
-			     unsigned long flags, void *context)
+dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			      unsigned int len,
+			      enum dma_transfer_direction direction,
+			      unsigned long flags,
+			      struct dma_slave_config *config)
 {
 	struct dw_edma_transfer xfer;
 
@@ -591,6 +592,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_SCATTER_GATHER;
 
+	if (config)
+		dw_edma_device_config(dchan, config);
+
 	return dw_edma_device_transfer(&xfer);
 }
 
@@ -970,7 +974,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_terminate_all = dw_edma_device_terminate_all;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
-	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
+	dma->device_prep_config_sg = dw_edma_device_prep_config_sg;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
 	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
 

-- 
2.43.0


