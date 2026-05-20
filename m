Return-Path: <dmaengine+bounces-10584-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP4FAfcvDmoK7wUAu9opvQ
	(envelope-from <dmaengine+bounces-10584-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:04:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D662959BB25
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5175A30327ED
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9B3C0635;
	Wed, 20 May 2026 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Aiw46ZPq"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77853BCD12;
	Wed, 20 May 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314490; cv=fail; b=dtOrC4F+1enUdh+HZcFUmpZzW/TCiPENDPO9Uw8xYL3k2voS4AWqywKk6Qb57LrQ5CAiAC1VWKV63+N+5Vjpcv3iXrR0ktL6PU9j0l8Q00Ryt/xLHBAL64hR3uTRWhdbjxq/72vlwmANsZX/rvqbk7Efll2R4ClAFKDejFzFAK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314490; c=relaxed/simple;
	bh=NBCsd7MOzZIjGUdFJVELfXSD5nP2JwlHcJyr2IWu8Ww=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iiVftaHV75ndbfe6CcOGKqW1UW6Zvty1dzC1ytxPa+W0oTfu0Q4lyP3aLewFIz7BuMqT/xIM6qKUXS7GBffneRFEdWRV7Y3hasbsr7SWC3B29/37PF97zsO1e04n8Mz0es7Kd4Q6SygnuuhlxOQtjsDgowf5Jpl8I82WyC2Xw9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Aiw46ZPq; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE3go2zNs+hbUxyVL2bmL+SKWGQFcQVUCT/DwmCyX1QFHZzXipZ4gJuTudJQ524aQGKGFYbrslA5o3Ojl4H38ZghrPKq5uSfk3Hdml3Xo3+lRDBSYxr0EHbb2qe2G7h6PxD3RE1qNLv1PgxNqNAT/JkxHM+vzo78MMswjUvfsQ3Z0oEIped2+dDY3uo2gyljixjFQn8nw2cnRUzSUYaTrsFIqxnEUnN3/S3SCssphH99KouVxu2v+3j7mxOwbOZikv/RbautfteXyJhUNjxXHZLIp2mdrg+rWDc9QO6AwOZVrYXOCYBP+/T407Y9GSnykx8cKvlknOB6Y+qTgRsVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StX1KYDn0Ke2D5FOaP4H7Cn1V67jnEpYFFCVgoHWH88=;
 b=U6Aj17WKsrBnikq3ru3OCHADj9sAVxwhgCA4DWH3+UhbUnS4/WmyIeEKhQJZSpo2IyvrPGA1Nm0375no/gGwvSRVvhZ9oA4uv4k4sOCpjz7Klb4IUjnbgzKrqzLxjhQdsBCi0dYXArSi1Mys683YIcGDG8m56ZEbK3jpYzRbGQrG4q5U3BRwqWCZLbr4B4FBuDbRWhYqGmDYedw9KMOzLsApV1hAZFj+k567n2+uUY+oN2rVVVodjg+RdCK6Z6NAs8+FB5GqJk5g8P018v9H1k3Aj3BOYZTCNiu9VZNBXzmJDLIMBlhN0049a2YZnRaPC5CUqMeJWh3asJK9SbdP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StX1KYDn0Ke2D5FOaP4H7Cn1V67jnEpYFFCVgoHWH88=;
 b=Aiw46ZPq0Ctwvq/kyMZ4u39/5CaO2FckUJwQtzGLPzfoKdskUzJn8ctLsWx3ChLo7t0mc+/RvOwTNJ9dRwiRrjnzKHsiT2m3X8OslvoT0aTJbe5kvduYNL4PKCvnKXE6sd68GpO8wtFdn/U+/C3vpKWSMKLXZTg+G/D6xU8JPSgCMnCgSFRI44Rn8q6AedDWzE/YWQ2gDLYob9f8oF85hAQf6e819uO76vijrsaGuhHEpY3SAQStZa4wwVZ82p323XeTWddLr4audFIC8X3Vh90EA6tTT3oL/z19XhzcE5Uq+XHSVH6EmgRpgec+SR7Fq9LmrHP/h2QspsmpmyPrqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:01:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:01:21 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:48 -0400
Subject: [PATCH v6 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-7-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
In-Reply-To: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=2393;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0yP01YEXNo+TKZFooYpo3T4x17odVk3sXG11GGJCgSk=;
 b=jLe6fsrEVieBgAMQqAiUJhChEBfqpvwbhjZ7bKHarPX5lwTwKOH63Rr4hntdc9Xzb9J0qX5VS
 aXk8pP72YhdBStb+1NteiWpIvf3IdbGIzLtQh9HbOtnYOOa3R8++cK3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0039.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 711bc4b4-0698-4591-d149-08deb6bb536f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	02mjjIGXVMXLQT2jDW1O7CZVmvzHcCUqRBGsPcJ4/6a5kDeNs/hBqarg2tokgiiWk15RCtVAsc3FBQdUncYTmCqMRY3DAoQryyJ5PZcZOdXbslAnE+9TEMAdGSlEHIT3PGjwwLxn21V+5DRTqFPageWt9pU20PfXObjCfvD+aOYt3nfUu3BilbbW8nilYHyaBpLozYP79YUXiEI+bqtQErRflIxN/OaEQ/8W+QZ9JYUb+920wJT4DaV2v/DamVTE3YBmAXwXwqyqUtzmztbEZkxAwgB3QTNyIrP6CXHMtjkW6cz0NaiLWm9l0gAJFV4osPz618XZBgWBbkMKYnpUbRYaHg1RSJ+QixBUVzChsDkQMfeW7jWSOslQW0hv36F1ux5WReuG4i3qziWL2ioSBTMXO/OVK1SmvPGRevQt1QyU8+HyTMRAIyLpx6IJXZYQ8Ti3iYgwKB92CR46qMdwhxtTFz+KyuPFCGa5OXWeosoGxF/EHXc1tK///IZ2j2gnMkICVH4rT2HSEd3YIuCdwpjTlWgxSTg/FvNOSqJ6upappYRn5ZN6SF9d05XUWAJXZ6BC9A43sLgGXPnIfl8F4tUVw+goRcUqLoSY7qax8giL925Wcj5JFwVxvTL6/AXqV5tE0hvZcLrdXRT+hx2YiMK4YXPKYRmvYYShiCvA4NhyT0PwCA7hYNQMqwBGl7EOgInFvaJDMUp/KyqB7cEWCu3blHTXheFgL9fuIrhl6+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1NvZjBYM3RyMEE1OUkvUWhCUU04OUVLZHFVbStLd29mMnNRRnhHTmluTEF3?=
 =?utf-8?B?WTJ6TGRTbk5QZmZndEV5OGg4RlpNUDdyeFZWdkluSXJIN0pBdk44S1RLZW56?=
 =?utf-8?B?Y0VtUjlYYjZ3cFlUdWhlWFlqR2NTRDVORmliVVFWZWRIOXBmNmJEU0lXclYw?=
 =?utf-8?B?NFhZYjlUTVpTRlEzQzdjellIK1EraEh4clRnWkpxVVZxbFlnYW5IcFNFbm9w?=
 =?utf-8?B?d292QWtUSEppaGRlN29yMUpmQ0hRZjNHY2d3NksvTWFTUFkzcmhNK2xaN091?=
 =?utf-8?B?RmdjWDgzNVhLcEVWTjZGY2VDTHVVUE8rVUMvTVRnendlQ2xPNzk0VmpKREdO?=
 =?utf-8?B?ckJKR1VicjA2dFBYT2pWVHBBY2hqVUlUbnVibEw2WVZJNi9LdTdKdURLdTYr?=
 =?utf-8?B?clh2L1lOL1FKMmRFMXVKSXZYUmtZbkhPaWYxR1MrRDZ6c25vZGQ4YU5GMFFm?=
 =?utf-8?B?ZmpDM3V6Nm9XRmNzZTBKNkxUTjB6K1NlUHNmaGZNWEpkYUhScHFYbGs0b1g2?=
 =?utf-8?B?TmYvSzBza243UnR0NERhQVZYVWUxWllhUXgxL1pwQmE2Nlp5M0UzV1lwcVVN?=
 =?utf-8?B?a1VHenRSZlF5UWcwL1RRWjhoV0JhaXlNN0Y0c0JEYVVLejZDd2w2ZWlHbzdK?=
 =?utf-8?B?MUVlZzhIeHVkS2dLQm5ZV0xMU0h4M0NId1RyTkpEMERMa3dPUmFIVnVuVk9o?=
 =?utf-8?B?OXZpSWR2blA1czlkUTdPcU1tamYxZEh2QlRKaGR4a0JzM3BYK3N5eElxb3d6?=
 =?utf-8?B?emJZQ2hqZWRoTXk0cm0vMUhUM0dTK3VxTUU2ZWtIS2l5QUUrcy91WWdlVWhL?=
 =?utf-8?B?dTJoY2JWc2h6VGpacU9NMmpGeUJHMHQ0Q0ZmNkNpUU1xWUprdnR5RkYwYXN0?=
 =?utf-8?B?K3F3QkcvY3hDMTRQaDRjQlRYVEIxSkpNOHJVdm82MmVLUzJEem1PcEZJdE5Z?=
 =?utf-8?B?SWpKVzBBcG1TcmxmSkFIRVFmTk05QmI2T0Y5U0Z0NFR0b2FtbStUbFB3TlJM?=
 =?utf-8?B?RFI3N0dGWWVMOHhUb0pBQmhKcGFsYVFuS1NCbW9COWY3ZmRDaWRoQmRxVmJM?=
 =?utf-8?B?a3RSUEREYmFGNmFLR0tSbGNDV1VXNjBFalNiUFBTTXBKaHZWb1dEODZldGVw?=
 =?utf-8?B?bkEwQndnZkpYT2tyODI0WFpyUHRzdmkyL1BRaExHS1RpRUs5bmFaTTd4WGox?=
 =?utf-8?B?UVBPeHIvTUNHMjNNdTEvYmRSNE42NTVIY3BuSGhNUDRnYnlFcndhclAvRVVQ?=
 =?utf-8?B?R0ZnTVorNUNnaFVWeUtwKzhzcVhsTExKZmlpTHROdkF2QlN3SllERHdEb1FS?=
 =?utf-8?B?akxRZE5LREd2T1BRU3NVaUduMGFLSjYxWXlzbnRkYmJ0SGR3am5adm9kUGdx?=
 =?utf-8?B?TTRhaC9uNnJXMjN3MEhvOFFqRTA1ZWtmeDFyVnUxWGhENSsvTTVCeVFCYVlE?=
 =?utf-8?B?cTU5UzRuS05zeE45a0FsTk9CcDRwcTdycmR5VTgvNHZsV1puQUlLbyt5N3o0?=
 =?utf-8?B?L2FLb2ZNMkExcHFzczlTZzNkQ2ZsVkFOZVRrR0cvcjl0dnZrOHVjdUNoMlNn?=
 =?utf-8?B?YWxvVHduNlpLOXF3b0pnSzZXVzl5SUxuOVV1ZXlrZnhEMFBRb0JZL3N3N2Ja?=
 =?utf-8?B?d0lPUjMzdTJ4cVFQMDZkMExlWkdML0hGZXlFNXVmNXFheHRuK2xjNFZZMGE4?=
 =?utf-8?B?Wi8wSnRoNkZabU5ocGJyVis1RzQ3dkhuZjNoUTI3cHQybTA1REQ2Y0lwNHYz?=
 =?utf-8?B?Lzg5bmFZRHJER3h0dkk4UGF2TXFFdHR2U1NkTmhsUmErek53bnR0QXlBVnRp?=
 =?utf-8?B?dm1vdTBxQWRsVWhMbDJ6Q1JCL3NBMHZWMnhqQURuaGIvY0dLZFNjbXpWMFhl?=
 =?utf-8?B?ZCtScjIwSVUrMCtkeUY3ckt5M2RrTXNTa09zUzQ2WEh6dTlHVFJ4UmxQYzhQ?=
 =?utf-8?B?WWJSTnh3aVFBV0EwcWNVV1l4V3hQR0xsbG9EWkpZcDZsU2ZQUGl5MWRaYTRi?=
 =?utf-8?B?eVdLWFNBK1ZQbnV6aE02anJ0MStqd204Ky9VcmthaVQzWFRUMExGRWVvbjdH?=
 =?utf-8?B?d1EvNzZSeThiOFVOazdhazFPQlM4V3p0M2dVcnd5MnhzR0VlcENKZERENEJL?=
 =?utf-8?B?TmZROUI1N29LOFhWcXZ3c2syeEpmTkIzdmJCQi84N1ZuNVhkeVlLTkRPRXo3?=
 =?utf-8?B?Vy9kRmE1Z09HTXFsVmpjNXVsdVIzQWdpN0FCZ2syR3R3Ym9LeHV2cDNwT2VQ?=
 =?utf-8?B?dDVwTVpKNG9NYUpHbnZ3ZDlydGFTVjBPK0txUU91RzVyb0ZTeCtyVGFBZG5J?=
 =?utf-8?B?UnZrNHJQa3FZNE1zb3FaL1VtNFQ5QjFnRXc2Wlk3d0IzY3p1QStDQmVpK3ly?=
 =?utf-8?Q?NNKatGU2C055wzqHaCH704NiEaiJU1VO3As/D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711bc4b4-0698-4591-d149-08deb6bb536f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:01:20.9738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AJ5nmtsj8oe8Z8Ic1ga9Bvm/4rlB/oU9DlJZo56oIuI+RrRmty6WInt/XqfQwVXw6K5ZufNQ5Jet4lvHroNHg5sJFa6J1N1R4uc0er34020O9BgCEL7JJERcYGLilZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10584-lists,dmaengine=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: D662959BB25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Use the new dmaengine_prep_config_single_safe() API to combine the
configuration and descriptor preparation into a single call.

Since dmaengine_prep_config_single_safe() performs the configuration and
preparation atomically and the mutex can be removed.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- remove local unused variable lock (sashika AI)
---
 drivers/nvme/target/pci-epf.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2afe8f4d0e461..f917d6ec278b7 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -368,18 +368,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 	struct dma_chan *chan;
 	dma_cookie_t cookie;
 	dma_addr_t dma_addr;
-	struct mutex *lock;
 	int ret;
 
 	switch (dir) {
 	case DMA_FROM_DEVICE:
-		lock = &nvme_epf->dma_rx_lock;
 		chan = nvme_epf->dma_rx_chan;
 		sconf.direction = DMA_DEV_TO_MEM;
 		sconf.src_addr = seg->pci_addr;
 		break;
 	case DMA_TO_DEVICE:
-		lock = &nvme_epf->dma_tx_lock;
 		chan = nvme_epf->dma_tx_chan;
 		sconf.direction = DMA_MEM_TO_DEV;
 		sconf.dst_addr = seg->pci_addr;
@@ -388,22 +385,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 		return -EINVAL;
 	}
 
-	mutex_lock(lock);
-
 	dma_dev = dmaengine_get_dma_device(chan);
 	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
 	ret = dma_mapping_error(dma_dev, dma_addr);
 	if (ret)
-		goto unlock;
-
-	ret = dmaengine_slave_config(chan, &sconf);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto unmap;
-	}
+		return ret;
 
-	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
-					   sconf.direction, DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_single_safe(chan, dma_addr, seg->length,
+						 sconf.direction,
+						 DMA_CTRL_ACK, &sconf);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -426,9 +416,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 
-unlock:
-	mutex_unlock(lock);
-
 	return ret;
 }
 

-- 
2.43.0


