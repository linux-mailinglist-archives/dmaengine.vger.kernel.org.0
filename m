Return-Path: <dmaengine+bounces-10373-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOnqDXZZA2o35QEAu9opvQ
	(envelope-from <dmaengine+bounces-10373-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:46:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4234524FF2
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 18:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CC68305B262
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417723D5C0C;
	Tue, 12 May 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q92zoi5x"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E03D45FA;
	Tue, 12 May 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604166; cv=fail; b=GzsIdi1tF35ReUBdy1q7yAsPmFnA8rwRyb0im3Lz0mytoc7KqTg2fVTGPrHDifREyaCEHU3GhNUTDYOjEsVM8uM4RCwyp2Y9jUxKlBp4gRz5Zq67UCLAFWLuPtK2h4lBUFOEPTfHOlzOwNL7NrWJvUzHq/dOmcqwPxlQqONdmZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604166; c=relaxed/simple;
	bh=5Ht3OpV64qQBJF72UE+o9BDFv/FIRBIdPMczb03BKkU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eNjKJ+066kuWtP0iKtwTaGQuntZ5XKH56gimwKriVESwA72Sflkrks3zl5SVQnkBfPeDjTD6zbG8AU1FhcGJ+UMcLcCjvNol2qW9srH5I+Vp5tKIQasJJpASrcM7YLnm+5iW1g3SeP0XIlsiwU7dgL0H/kYbZAETX58iNiDw9xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q92zoi5x; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvTfVI9arwI1EDhgi6pIviWw/hJeMUpqFiv6UarY6vCvvNNeJ1AMhefdkOwG8ED2FYth4j7bszfLQMwRoN55mx/9dnC2kBA6vm7kimEMS7q/y7JqNEmvXyA0DrdOGbBiiEe03jECv4Mh/s+2MHfYlv9zRakhyGD7nynI/xi4jLdxPU5zzKOEhug2yEFUYJagvZs2RjdCwh21fho9mxiWdKfKhdQmhi7e8A33SbdVVB9qH0Utr1EnTnQ10F+NamjNFyKRY4z8dtXcIS858ka+YIF1fHjZSSEx6NV3fpkZfUVT0HC+KTdDE7npnX03PGCoit/rz9fuN3u9mDRgVgw2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=;
 b=vRrgI+DGCHnzKXT65F+rndNuEZwEHDuDGHtoIGwwwhACPXR0tkB3cNfh8fGAd1wVraZfzXm33ryJW/PRTrlTwqJ8uKoux83Vsh0OJJqEvSnIE0fDKFdfBgVNCJO5aKTPuf/vk8OJZ+69jiU9pVQs3VsctEUVEoZMzHzcgJIWdkU3U4Q6qb2ScCmEsssTXPuse4avhhoncBH25zg2o+3VmLQ0wjwvzZi9XJX96YqkQ7PYCuCd/WUByirZ79Rw2mCBWxabsrwlOCbWEZhL0KbryKg+Bv13q4XoJhfzMP02G3vvXscw46plPwzpoilNKcV+aGfLbAMM5eIcjYcSwPoZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=;
 b=Q92zoi5xKjPo+GfHWQppO1sA/WWzLBF0sNPS5gMmOHAHGm2zm8zMU2IgmcXQY8yF7HKenRSJ49kDaLj5uJkONHjjKe6/IzyW3kJhUDlsCsiebb/OAYAp/EDz9MgR0nQoycG7JGu3ne7ofQuC5paXrEd6YPy9nrEBMJNTJ5OhgDaE5rWvXWztlqOSeamLYueYxG98A5Dhd7TFcbjoM32abPk4yzzDpVm7b+rU9qkxrmZW5aSUin6YvNxdvgYZPbabC1chVBgM3fM3wJY5b+BDHsKZco5MBkkImqk0cZaFEuCb/ciM99lTuseT2H+5L2uPUqHlLiYDT2b62NavDE8glQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:42:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:42:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:01 -0400
Subject: [PATCH v5 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-3-26865bf7d935@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=1293;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5Ht3OpV64qQBJF72UE+o9BDFv/FIRBIdPMczb03BKkU=;
 b=pe6cig6xcQzt01HDBZpbt8ocLepQ9e+SUWFEAUke2+yg5utMfwhYnuWSI6zLPb7ot5ipQyr9T
 d0zNL6+Ced3A97y+QmBGUtf0aazVQwhwOFDI2Z/MMpfTaUItNOESDkc
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
X-MS-Office365-Filtering-Correlation-Id: 8ffc2656-ba54-4058-6b9c-08deb0457b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|11063799003|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	I0otguAMgN0ca+rrbSkfEbDcde1dZ4AGNUZNVx0/pAT8sjBb36pB0cxwNOKEVpmTsjrdcnPWeQoNly9UuOMPE+wIO+iwgvPv3/O1RHhwZbSiYvtzb0dm1IEqUcgaaO1mvNcStOziVnJIYLbAWVHj/pfZ3zBTx2O3Gm48Yw883MSYTGI4BFcFJSIUPYXDWGAPPG9IjHQqMWb0LtqIjoYfftWyNXjv8web7OX8bAhM3YGyZvVkI/pVvz1FKt9rdzFO7ByjWW6b5B7WzOEyX3eMjN51yI7gSt1oZwi4UBZX/KlvyZljLP3vnww/qWcvcO9KFWAboSiRx7tOPixwYqfqjCTaXpC+EQePfxzn7fDFXLbiKti4kChU037aRkaxm1sZV/IVF02NfmCw+JW4ZycnE53UpZTtaSCNdQ/a6fEce4J+Yb/5318IIWt9kEUCCmcoYGhtFKkSTuBQI+knkdJlx/Un17BtxSd+uXih86hLy8DoULD6wbI8cdQaQyD6pygLHB0oqNJ/SO1c2AvHXpantFA2hJBJhAO6mNNq3u7lBTb/Q4TXUAX0dr+BS+ul6R8ncsRjmScT+LMgeIVHF6DumIvqyHy3pv2p/voCtm14u1z6GibjnNMhFlMTKIKkMwnxlujWobymUfcCAn2ZCt8NR1avF+43IgkJKjD80enT6G7ntSPhVQpv7upvuvAgFd5eY5rJRq2dxchhkHry6GS5BOxSqTET3eONkQkKgy4+zwmAnEtru9COOEfJSylByN/Tu1xsnCF5irHI070XtDi2Dw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1pVMzdiQTBoV0QwTG9DZkR4M3FpY0VOUXJTbW1OM2xrYVNxWEJsZWplUmVH?=
 =?utf-8?B?SVY5NGZ5cjNhb25uSlA0alFwQ1NRaXljNjQxOGp6aG9rc3RWVEgrTzdCYmZz?=
 =?utf-8?B?QkRpdFdVUnNvYnJORDViZ1VDK1dva0QxamxUOVJpOXpGSyszM1MxanpmTnRw?=
 =?utf-8?B?SXBCcU53bGJnR3VhR3ZwajZRMy9LSXNYSlgyTFNWYUV4Qk5sd3hxR0ZrMjF6?=
 =?utf-8?B?elRzaWNaR3VUa282QzlNdXRwR1NQVkhwemoxK3U1bmlVWTFycGRhTGo2YnBv?=
 =?utf-8?B?aTExRlZWamxNdW5jNGJUUkkrcyt1Tks0UDJIc255UUdrL2xNeWpEd3pBNFVZ?=
 =?utf-8?B?ODB1L01rbHdtUHNvU09PNHMxaHlRaTEvcHNMZjRtZjBHbyt2SDdZODA4Smt1?=
 =?utf-8?B?YzdCTVR0VTdrSlBvcVgrZEk5YjhvbWhSdFhkL0p1bHJHaytnREptMXF3Z3lV?=
 =?utf-8?B?dytFdGhKVWhOSzk5dDdZNHl4YXYvZWFZYmJSM3JGcXQ0VHM0dGg1ZzVkUWJz?=
 =?utf-8?B?OUpmeUdHSEtqdmlCeWY0WnlzaDFGMXVOMmJQallZQytBS3dWMmxhd3lLd2FF?=
 =?utf-8?B?c2NMb0tZZGlJNnh1QVUwTHpXNlY4VnFGeUFBTVdEdGJnTldWWUJYbUtOOEdz?=
 =?utf-8?B?MzFjOFlITmhYN0JKT1VaTjBPdGREVEVVcjE1dmRBSkVqRVNuUlA5WVQ1SlRy?=
 =?utf-8?B?QjQvWWh1S0pub3o0YVByR1FHTUNnazZGTHl1c2tBa1IrcWNjeVFZTGVqdUdN?=
 =?utf-8?B?SlNFdGQvZUZxNUphNnBEWVZhMVlLM2lqUU8ycmR0WlFhUW9jRUJ1NENjQVFN?=
 =?utf-8?B?RzUzY0YrSHhSZmRvQUZJSGk1MWZTSnYvYVFVWUNhQ2ZKWUhzRDRSbzFRN2xp?=
 =?utf-8?B?MWVEcm1sMjVvREloeXZ5ZjZjU01uRVBidjh2a2pybGdmYmFIVldidzRTSmdY?=
 =?utf-8?B?aTBkQm9rU0xJQmF0bGE3OGRSdGZBUDc0Q1V2bVk5cDQybG53cnFvMEp1U0tn?=
 =?utf-8?B?a1JYWFBCdzBlMGptaWh1YWlMUG1VTHYrZTVKc1RNdnM2STNkVWNDMkI1U05N?=
 =?utf-8?B?akxYRzFTZzY3SzA2NWFYeUp4ZER4b3hHSDEyaUl0ZWlnempncTZOVEIxMHQv?=
 =?utf-8?B?WDhCUklRcXlQQmNiTktQRlVHSE56R1p6SDAzTVhTRWpSd3hYSGxZQTh2ZzVm?=
 =?utf-8?B?elN2QVYzdEhLMmFYeXVmWnRhUVlBSjZLMi82RG9CU2tWV2YzQ0VmcStUaTBo?=
 =?utf-8?B?a0ZxUytseWJMb0EyZklqeUhWekJJUlltK0JkbldhaGw1MkdWRG5ja1JSTTVB?=
 =?utf-8?B?YUNsU3BUbytZOXNyd0lDUVd3QXprS3B0NHVYOG1PQzVlQVJzRE13VmlsNnFQ?=
 =?utf-8?B?NmhhZWtYWnpiR0crMnNVOWtPeTE1cW1hZlMzOXl6Umlwc2J2MlBrMnhSUDMw?=
 =?utf-8?B?VGk2eU43RWJJd2EvQ0o0SEZPazJTWEEvelBJU0dRdUZaclJSS3ByQnFWVmpz?=
 =?utf-8?B?ZWF0MEsvTXI5MS93bW8rdFhjUHhJZVh2VTFzbldLcWtRQksvZHowQTJ4OHVt?=
 =?utf-8?B?Z3o1RDNGMmFVdG9taFVkZVpBQU1uNndmUW1Ba0d1bWlmVnh5dUtnZkdjaFFE?=
 =?utf-8?B?NHkxOXlBTk85LzV3aFhQa21hVWZ3am9tNjltY1FwZWZsNlJ0c2pWR2ZZS0Fq?=
 =?utf-8?B?ZFRRdit4Ri9hZ0tzelI1a0FIekZjUERrZmlCUWlmbmJFcGw2NzFDNHNRcE1m?=
 =?utf-8?B?RjZUME80NlA2KzVRNkpCUnk4Tm9id3Jic0ZidlR1UStOSmYwUnN3UmpzUlBq?=
 =?utf-8?B?VWhGQTdmelZKOEVnRjdKL280TG5HRkVicFFVakdlY0lMeUpoaURaZFliUHpE?=
 =?utf-8?B?UzBUYkNLTHdMSlJKakZKR2ZUNUdmK0dwUDUzUnYwb20rU01vZTRCQm1BSENQ?=
 =?utf-8?B?Tk5MbWpVQVlOQUVTeVpRRk5xQ2VVVmY1VzlZY0FvUVErKytKTjE1Y3lrZXdu?=
 =?utf-8?B?ZDJPNC82SVBOQk0zYlNrNFRrNktDN2pwb3hNeEtRSllKbkoxZ2tZQi90c2o1?=
 =?utf-8?B?Riszd09BSjIwRk9Yc3BKU1lZL0FDeUlIOVNBVlllcWRBSUw0UWRBS091am8w?=
 =?utf-8?B?YUNqK01RMDVuY05TdlFObVBCdmZYVDB4OUlOUW80dXhNTWhkSFJ1K09SSEVY?=
 =?utf-8?B?RXc1OXgxQkZFZ2c2SXkvZGYyQjFIaTVLbmN4QzFmN01GTzY3N2JYcytxZFla?=
 =?utf-8?B?L1RiRCs0T2hPa3B0MURWWk9DZlI0bThwb1hYbkFVK1hQRENaV3Fsc2ptUExn?=
 =?utf-8?B?SmJEZU9raHdLL1NYNnBDVVFuR2xCRE10R280a3pwMzh6dU8wazRBUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffc2656-ba54-4058-6b9c-08deb0457b87
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:42:40.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNi97MvDAJCHS6aRyl3NMVyxcbUjOSFLLABbV6F+L2JOEqA1uwH2TI2Z+MB9co07sv5+pvKWbH2nXaJf7Gl3PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834
X-Rspamd-Queue-Id: D4234524FF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10373-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
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

Use dmaenigne_prep_config_single() to simplify code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add Damien Le Moal review tag
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 591d301fa89d89addf5df16e775e80460b689589..0f5cf2d7951088af3801ea1cc240b2ea8627eed5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -182,12 +182,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		else
 			sconf.src_addr = dma_remote;
 
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
-			return -EIO;
-		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
+		tx = dmaengine_prep_config_single(chan, dma_local, len,
+						  dir, flags, &sconf);
 	} else {
 		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
 					       flags);

-- 
2.43.0


