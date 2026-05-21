Return-Path: <dmaengine+bounces-10687-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAeaLFAqD2q3HQYAu9opvQ
	(envelope-from <dmaengine+bounces-10687-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:52:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAB45A8AF8
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C54A319EAAF
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC2368D7D;
	Thu, 21 May 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ifgmwrd3"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AC3806DB;
	Thu, 21 May 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377630; cv=fail; b=iO08ynVMM7huy2UFkPM4kDrDsNuA4WQ0rTfH2t5QXY/rg/umUsFYrz90/OFUrcWtTL+vLlNJIS8A+XFyEwFc6bJGFX+MVv9fQolljLuiY8UVAxqzGTER7xw2u6j0En5G2/xVm0Ed+gkLh/mToQfd8vXXN/ngwlcz17RH9NupqJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377630; c=relaxed/simple;
	bh=Xxxb3WvNGrZnopGky0RMx4nHthEr92Nj/Z1vHabT314=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F2vQjMvRn1v+riKpWJUwdmu8mest0Cn+db+WFvUuXEWnWVwO5KZdVfp91fjcUVLwt3bb2j9hO2Nw9PcIb9sd/4PAl1vQeLXSo57d8PxYt4ca41bGMah9pOij26czc/UY920riXhlqw3lz/fmlNFqZZRuCz9dExFHkPbF6pR4+Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ifgmwrd3; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVe+Om98naWVp5Y12fvKnVhZrVyUqaVRt+KfbjvgXwvSHS314SaSX9tBHha3YZ36X0RTCFmTivJ+mDGKkGgOrO5asc/LisVT0Y83UnCAQIJjRwxzJutnkzkMH5SDiutFeGnVRZf8k5h2kqj7ZQ7DSSp+MEpj/mo3aA+5S1IRS0NY8A8z+7Zw2mCd1YdZUOUNVNuAA+kg1a2sKqyPe5/LslyWL9mwqxBHPKZGi2tQoHEykqHa8eFtr3HlBUDD5ZbI/ED7SDwu8gyHRopSoRxZar1HxtN5LJqtpn7nL7uhFfr7w8BMcB51DuGYGf9CaNoPPibphk+DcJyaa1NkdLoMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/ReP1rgqWrU4/sMzuwdfH3iluXexvaN58iUOEqpsAA=;
 b=nRxV6FDo5Tf71vdghvmN3fvS6D9Ec5ECra/6YNhJKuUQBfJKaVk4TtxuxchO8Aqgkr5g3AOhiEBJewh3OQXMhg9Ah/Hne1T617tyISFUmCCalS/PVpkM9CYnJoRLVJjWNM1zeTSvMzjsA4Ltf038RVYeLRVvsMPuOWrUTFUXmh8PJBH1Cgy91mGF1OQ9b177RmJj/56QcKG+y/3kTGHKD7hN+Sw4pjJ7NqJDVgiixS5GnJMsqRbqMfj7MfBkQNJcJRHMdU4RVYgNBhrni5BsGQJA6L9x2es60WrmO99lwYnqYODOs02b2de997kRSwU2d4v/VHv8jRamlvRC+dI2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/ReP1rgqWrU4/sMzuwdfH3iluXexvaN58iUOEqpsAA=;
 b=ifgmwrd3NzlV/Y9b1w3xEBRZqr2FAPqp5kUxJtlks6KDCSu4AW3t4iByDpGBR2xSFGEeRvdAeavvk6C4oTy9Jcp/oniYxrSL6g+QKgkQNaz0ePEU6ocJ2DKpRh+q4CnP2I49/XIh89AO/BLJOaktnZ7/9cQGzGj1v9MxtNwtqtgI+5h1GvcY0anNDpvi/K0Hm91gJCUrbjBuad6AoHybad/9iHGYkoXBmntD1sCfgnAXNUNLVyW/0SgmNGUdlpGLMQpUJ9/f17hgDjTMif2PCi9ecUw5t2Wybhqk492WSHKftSw17ltPuAMBPAJl0M8eiMbniRKJulUf+capuJZ+3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AMDPR04MB11581.eurprd04.prod.outlook.com (2603:10a6:20b:71d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 15:33:45 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:33:45 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 21 May 2026 11:32:55 -0400
Subject: [PATCH v7 9/9] crypto: atmel: Use dmaengine_prep_config_sg() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dma_prep_config-v7-9-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
In-Reply-To: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=1773;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=erGKLaAZMNXPQALsbiq4uU1FrELcrAtTPXSGZhnyQ3o=;
 b=QKHbZQEkp18U2ITWjZrhkJW46/m4B+DMU571m2yZa9yPRvBA7Xpft6riw3YWQHf519CY3JuIX
 w+7v6kkHY+YBqLDcZ1yAf95BCXLfCAeCDKXwwRVaoWhQnXhUs32Sk2k
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::14) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AMDPR04MB11581:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9c4b1d-7dff-45fb-b05a-08deb74e58ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|11063799006|6133799003|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	s862SAwdPXq3ZM6se5Au7e+/kEnxXj/A2PXnixdhPWF/KiumghN4v5mBXBzWcLfDqeNcOkVecz2LSYIFHs+74x06rRRmahoJYjEtFuu4J7fB1qxJ0qmliiZdN6vYJIXxW70YrPi2+26teX3AO2aDBEqSOWFstuWVFEd1ljsEVbzAITpsenm/a0Ukp6K+x/hjk6QI0WhpmIVDaZZE60Lk5tTohpDViVSz+kggVNkkHy18xSodhIdhwF9qRMAxQmNfAxapdx48q4QQBv4EHpchABc8fP2/fplQRIHp4RmPLP6hSPvOokHItSfhdEygjaQu5RraGjJ9+JqN5oQlNXhwF1k2qdrOPaBiCIf7h8jPZL43ZcRdzoiLWoKf3hXOpmh3RxqZmRO/9rC0znqVhYD5uln618Gttx/PDn2NM4xlQ35ssTdeS0q8cL7y38hxS4r6KQQKmHAPK1/+J5/qTFeAJqqMA9zbNb3da5Dbu++vfdItlNmPoXTheUXUeKEDFEyq7m7jvBcjX+s6oVao2Ml2MBIxT2vJ4SEecVIduiTopL3+nDltKzWca4m41VTfcDjEmVcrdoUbwJOZe4L8N2mReU6eKhh3bH2dOVNs0weHRsWVHcROznFS9vq/He10j+xLi7k/750e1GaML5o6K6f5yPUUizpbh8hj5Kr6RzOUF1D+v1n3TBO3IYlAIsKzQWoOc2pD1DJRxDpSir/zpnRru59AHgJCFWGdxKS86aUhO1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(11063799006)(6133799003)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVpGUVJVM0hMUllueE9FNHRuTnRwQnk4Sjl3K0o1SHU2V0YvUHZoNVc1RlZZ?=
 =?utf-8?B?VDF3UWx1UG1IOVBPNzJ3VTIvS3NpNjMwNTcyS1JlYVJIVzE5WWh2YlE3ZGNi?=
 =?utf-8?B?U0tvWlZCNVVzbzdKa1hYNGhlWGN4TzlWZGlqM28wbk53a0dzMnYxTVIzQnNU?=
 =?utf-8?B?TUlqM1ZkVTV0Q2g1a1RoNzMvMjJoRVdoMlVYWFRDcFdjS3dpd0pPT3VUM0I2?=
 =?utf-8?B?aWFCbzE4QzlmQUdOZ1VqaVQzQ1ltY2hzWkxWeHhseUlEVER0U2NESWJkbmhy?=
 =?utf-8?B?Wk9DdTVWWlpKNEtQS21Ga3B0Ti9wR25Kcy93ZHovM2FiN0xsL2pUUGowL21K?=
 =?utf-8?B?N1VJZjJwci84YXg1REpDUVIzbmQxREdwWlh0YjFTQjU0VVZQQlZKb2VLYi9R?=
 =?utf-8?B?YXA1L2xid1pYRnBGaUZYNGN1aFViUm9EbFA0ckUwSFFjMFkzWkx2ZG8vMW9j?=
 =?utf-8?B?cnExZmNpS2RQNHNGTCs4R05ubm1DWFdnQUZycFZhdXo4YVgzeFp2OEd1b1l1?=
 =?utf-8?B?VFZQR2dsNFpYUFd6dFRTQ1BPTitRemFyVkkrMUNxaW9xaG1UdkI4ZWFsZ2dI?=
 =?utf-8?B?V0N4a0pMdWU2dEpJT0pxVzg3ek9MeDhFb0s4Z3BpeGV1TVNLeXM3NWczZVE1?=
 =?utf-8?B?ODJwYnFGbTNqMDczU3YwdWRieXBFN3VLbHhZalNNQ05TQ25pbHgvKzBtbndN?=
 =?utf-8?B?cVAxbmFCeTNLMjV4S1NXdDBPRm1JRUlWN0ZLUzRoMFo0NDJ4T2FzcDdaN0I0?=
 =?utf-8?B?cXdtSGdaZ0xBNnFBMlk3bnFveTR6d2ZEOVd5RHowV2NvcjRvMlcyMVJIOVp0?=
 =?utf-8?B?Mlc3cUMzVk5XeG1EQmZMUjdCVVEvcVE0dHhaSmgyWU43OTVVZlZQaUtzMTk4?=
 =?utf-8?B?YWtqc2hLUWczcGpGdXF1ZUV4ZXVHMWN6UFJJUUY2WmJITjB3R3ZUZkVoOUlr?=
 =?utf-8?B?bGhudE1wcCtNSXhVb0gzQW0rb3BBK1VsK1BKL0YzYW9MNjE4RTVaQ1htWU15?=
 =?utf-8?B?RGJXTGdZTGRYbFBJZm1LWE5Lc2Jwc0tYK3FhYW9QM1B5eWZTT3BabExVUStF?=
 =?utf-8?B?Z2YzanFzTy9aL2xNZm5yRlBSWHVPS2Z3bmthQWtlQjVtTnlScnBtUm01Qjcw?=
 =?utf-8?B?ZFNpcy9Ndm1YY2JDdUNTVWZZZExHN3lxK284a2dmTVp5Yll5WHpEOUVxK0lv?=
 =?utf-8?B?YlV6UzJEM3NvZzFydnZvTUVEbFp3OHpnM3gwNjdkS3NSU0llZlMwQ09qL3A0?=
 =?utf-8?B?U2xIcDc2MGUvWnlaOVk2SmhwdkhPQmVqQ3hQTTdUTmpNWTVvNVJQalcyVFIx?=
 =?utf-8?B?QXovWlFWakh0YXh5cXlWcjEzQzBNNnBEa1FiZGpWbDI1anFHTmFFNSt2THVH?=
 =?utf-8?B?OGJLTEFiOWwwb3FqYk04eldxRTVhZEkzNGhiY1A4ejFrZXA2YXVwN2FYK0JV?=
 =?utf-8?B?TGRVSE00bjZKdndsTkNYekR2TzJmNnV3SnE0RTcrYjNwNzdtMmZYeEYrYVJH?=
 =?utf-8?B?QXJKY0NNakVLZS92aE9sMEdQZ3ZpNWI4THcxbU4rT1djNTBpV2V6T1FOdkJS?=
 =?utf-8?B?b2RyTmQxT1RXdGYvN3dBeCtHckZQZ044UXIyYy82MmdEV09LbHplQmNhQ3hh?=
 =?utf-8?B?QU1XeFI3bDVPNlpFMmNXbUlpUXhEM3MraU96RnhxVnIxSENYOTdURHhZYlhT?=
 =?utf-8?B?SStudmFpd0tMOG1pWW1QWEt0b0FvN0xOSGp4cC93MlRmNjFuQVBUd3hUdytG?=
 =?utf-8?B?TTJLY1g0aThkRmZ1YXRIOStHWkVOZm1EeGlDUW9BRWkxdEdCbDdPbnRVUHVY?=
 =?utf-8?B?TUhQQjZRZGdCTWsrR1diUDhpQVFGLzA1QTZKMlc4eXVqeE9heHJCZ3ZIbThT?=
 =?utf-8?B?T3Z1aHRkL2lzYkhvK09KaGdyV1dmWWE5WWJvTGNhdVd6REZkUVZHMnZsQXll?=
 =?utf-8?B?RTN3RHJ3U0pQclpDZmZTdkFIUGdkT1ErZnV0QmFyN1JvRSs1UWJ4bWRNYThK?=
 =?utf-8?B?VjYyK1VpR1J4R2oyWTF5NnlWY0tIMlNFT3B3YStMMjlGK1FIQTlBdTNaWGwy?=
 =?utf-8?B?ZmFDcFVZbnBFZGN4cld2dzd1QXA0SHc1QVJWd0prb1lHekozM25sazNQeHha?=
 =?utf-8?B?a0tvNXlha3dReXU4d1lNeGxBeXJNbk1RS3RpVC9lMEFzYUI0STByWk4rRkls?=
 =?utf-8?B?MjZNZ2IxVC9oQ2RINXkwSUxyTUpYSWhDOW1qQ3ZFcHZFMjkwUENOdVBuTWNr?=
 =?utf-8?B?clR0RDNWL01OVitXbnRPTk5QSGhhNEJiQUpLck1qWHVSTUVJNXBhRkRhcUw2?=
 =?utf-8?B?RWIxeDNEUEtsTVVwWXVDUHU0UndpTHpMK0pIK2JValJ2MzJVUFY1TDRSMXBa?=
 =?utf-8?Q?sbmQX8QGQIbN/BJ7Z/Uc0AHVsSrbbaMmDFtaC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9c4b1d-7dff-45fb-b05a-08deb74e58ae
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:33:45.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX7jpJwtZzeD+hsUATEhTrhY0HzVGcARJcr1fyT2nrHCddtfQgSpxwMbvDoB0UPFwEgt6uLYvKRVFur9a/BUf7MSPY6fJYoF90AVd7mvKdJdZn401Aab2xidmLrLlset
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11581
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10687-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 6BAB45A8AF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Using new API dmaengine_prep_config_sg() to simple code.

dmaengine_prep_config_sg() does not distinguish between configuration
failures and descriptor preparation failures, as both are reported through
a NULL return value. Converting both cases to -ENOMEM is therefore
acceptable and consistent with the helper's abstraction.

In practice, most users only care whether the operation succeeds or fails,
and do not depend on the exact errno value returned from this path.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- add commit message about error propagation (sashaki AI)
---
 drivers/crypto/atmel-aes.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index b393689400b4c..d890b5a277b9c 100644
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


