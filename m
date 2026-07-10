Return-Path: <dmaengine+bounces-12322-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EfZEJ7okUWq1/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12322-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:58:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A4473CD0C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:58:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=ObMzyghM;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12322-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12322-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99E2030B56E0
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C279D43D4FA;
	Fri, 10 Jul 2026 16:48:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EE36F8F0;
	Fri, 10 Jul 2026 16:47:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702081; cv=fail; b=YKLHOcpLjiKdnEYFy1MVaSnIRoWDkXZ9FKaPWWnr56vgx9BJ8v3WOEI/YpHRMuN9ajGiuTHy0EJDhw4wS3tcmqV8CVVsWmEYA6PvF5eCQx1h2fw1OrOWYQHgvIWep/lYzKBgWnzrmOi9EL4V0vT1AfM7AXDKGLCH85IBgv+utGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702081; c=relaxed/simple;
	bh=WxqyNp3m0NpK1U/JmKrSQc8W81pxPi7wfpAnMRmEz78=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sdBa6bgnf/MpVRt6CvTrdiFcNpfZ0rpgfgb4KyXH2/HTye8uI+EOAltfWugzNTtI9RVUZC8ICGvCdVDhryZJcgWeNQEd8u486n95shO/owQUVKOkL8OO5EPVMdPwTzE2kB9wFghcULjHgi8CK7ZG01QPqsia3s7HMZ2gRpYWFYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ObMzyghM; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8wItyoAJsfF7hTMAMDRg2am54nW+AOP5cdsIbJT5qPhINpcXidX9kSXZ6nBtFBi++DITehWsqzsC5tlN8GhbWRZ4Vl5NQL9eecba9S/b0an7UHvHDKjyNL68Saa0E9pIh6WyeT2xSCJxOa8iCZ91yPqyJ8Akqgk32Nqlj9rD07ziZMK5fI+zZOBYKFKTrId7D0CHnQfd3pkjewD6ifbsNgB4x21kRSL09xLrEuj7I5IqX6F0qpCERcujwqqpWpdGykNTcifogR7GC0Y9YN9YDPjKumWnKO6jboCBNNGxHltFJMhoURpYEBf13QwDeYXz+E6glJwibpRBnPYsiH23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBhTZQhQit1aE+vEI8r/EdULj2rn7CIvBtPXMDbEFlw=;
 b=Nv1u7konhuCPPMj1KVAQTjPE8l6V4bJmPqLwCY9YFyiusob6R+fNAGZUScTw06I37SqR1CaVfoDwbxFOqVlloIf704U/rZWqFACnsy9Dqg9fb4lDS0Yr/usgP3aTGv2W/HhNU+d0bWoFbaAZhormThaiwCYFn4i3FRRVh1dZQuokPFkdGr1Y96f5d0NYOWW9439zm585I1IBw7EbRNgNNn70ABiz6wYoELFLzaXrDT88nLigUhrfsX6Yt4mCPmedMDqzkE5lwXoO2fxSYp1IE5TN2PoLAm+S3DBBq5j6I3VvzkwKWzgrb9Oiiw2e2La3Z7wBsa/GCEt+8sF46jH59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBhTZQhQit1aE+vEI8r/EdULj2rn7CIvBtPXMDbEFlw=;
 b=ObMzyghM2clGFU/YPhUJ4IyCOQ4kaRmSLxOoNLryj1r1c57LDEfvtSAEErKeH8PadrOEKihvbSVxQLV3n/e1DCeV+UevDWpTRLDheh619HiQTan2OY1wYiCHLRHHzV6CY5nARKLrOQXk4nZKC2RNZX71z9XlI/goGayk4ZGgfzBeEv8UJt0Kt0LTR+E5/ATp51BskEHi0RCqNLilNh/Yq2qH28mu2fW5nkqt8MWk/R3t+NotfF9D6rqbbnKcyyIEfvsOysSb1jmozfjHkW2fjuaPMTwhzynual7KAp918cl1WSrzoiB5BmuwBRzhkb2PBGE9q+YuuhyMwewpJ/SRiA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8578.eurprd04.prod.outlook.com (2603:10a6:20b:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 16:47:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:47:52 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v6 00/10] dmaengine: dw-edma: flatten desc structions and
 simplify code
Date: Fri, 10 Jul 2026 12:47:42 -0400
Message-Id: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC4iUWoC/1XOTWrDMBCG4asEraswM/rvqvcIpchjqREkdrCDS
 Qm+e5VAYnv5CT2vdBdjGkoaxefuLoY0lbH0XR32Yyf4GLvfJEtbtyAgg4QoU3uOP6eThAC6ieB
 DBhT19mVIudyepcN33ccyXvvh7xme8HH6atC7MaEEmdlb1YZsOKqv7nbZc38Wj8JEL2UBISyKq
 jIMDbmG2Fq9VWpRDlZvqaq8czFqq5wG3iq9Vn5RuipmJJ8h5sbiVpm1Wv3QVJUwBDCq1QpgUfM
 8/wNVJb08dAEAAA==
X-Change-ID: 20251211-edma_ll-0904ba089f01
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702066; l=6857;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WxqyNp3m0NpK1U/JmKrSQc8W81pxPi7wfpAnMRmEz78=;
 b=aTtWyiaaGwCa0xmvZkCkOmnXDxCZQtgttoxCletIeqEk9n8oMciPmZX/f87LTyAAYuLkQxppm
 TeuYRV32k3LDEqtneuEO6MzbEOuvTjSGxXNWRgYg2oxVmlNuN/wRxzu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0111.namprd07.prod.outlook.com
 (2603:10b6:510:4::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b16544-6456-4b34-6c56-08dedea2fbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|7416014|376014|366016|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	crngd+oeM1VV8m/G7blCE+W5xVf+2J/tkeyvie6jKDDziBnUJuo8GItK+hTXY1ez2yvIjG/HlKdNrwQHrhErjYr0aWmbzgKTPmHm2HJKJdaakcpdGd7ftVV0vHa6c5qtEpR0767h9/TM932I5riaqTDQTqImiXZVgMBs0spsoWDMYHsjOVcqXTEKlDwzjWzlJ+5MkczmGCB5tDNScj8JcJpvuPYZByRiGznINynYziO9TGDekt+DOWo1NWJvOvwh8j4L/Cm4Y3TC2k7emjfMkWrZ6x82EgztM5XHcDPht3BhPqr924K+Gtf8x6ktpUjTnpDJvkPzZEF2PGXHcmAntyvtU68T6wt2GqiULHPSj2Gtv+gc0LpEWVzyH4GfFHP8ivKkA+I2F1d1vdSLHl56K1Gd7OtdS2cEQdResLkP1To88Qd8uydBb7ba7GO2O6lQlx5HQNz+t7WTUwIHnPe6B6wnjj2wMMbc6ueOynQHNDXEmtaW1HJ/9r9gidam9q4Z7i6zGCsbb8Vg3yP6UEbeYetFDWbqpWFM0FESuMVMQAbfe7mqd1sEHn2/xoKTrfN7a1ePMEwYfzpitDz/A24JKMl6RJ5zs9A6lRwZgR9sx/d75sAQ5rNeXG+3VMx1gqwDVZoh4sk9aY/x445o7lm+M9ljweNpb8NqVPGIkPfzv68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1QzV1dmQ2lNWTl0Y0UxcVUxR1NmYXRwV2xCdHlXZGFnSFoyT00wR3F0c1N2?=
 =?utf-8?B?czJrY0F4eVZycEJndE11OVZVREJyUGd4OWxWMVV5VS9zU0grQWEvdzlRYkV3?=
 =?utf-8?B?QUl0bU5SNkRvNXQvSWlJeThsVjEreWlNbEp0dnpqL3hpY2VScFNqT2MreDUw?=
 =?utf-8?B?aHJPUU9yV20wbUx4dWZrc0pkTExrUHZqQVI5NVlxNTBuVCt6Nlk3T2U0bWdZ?=
 =?utf-8?B?SlJqSFpOSk5NVnM3KzdncVJyUWRQODRxZkY5NmdHS3lHRVBITXo0YjlMbzdS?=
 =?utf-8?B?bHhUYUQ2QVNTMG54WjVsMmh1c1FpMjlTdWhKai8wd0xlRjdsaW9jSi8xVmxV?=
 =?utf-8?B?dUxtMmhRT0s2VVBNenJwa2hlQVFZRUxzWjVrR3BkVUltMWNkYUI3M0lHWlFR?=
 =?utf-8?B?a1dKREE0cW0xSVJxNUNQbmozT0x1RnJJbjEyZVpjQzVGUlNROW90SENMZjNk?=
 =?utf-8?B?Lzh1OEo2U21PdnYybTZIUDI1Q1lPLy9lUGZjRmJQUWFVQk00UVI3SVc4Qzdx?=
 =?utf-8?B?MDF0dE9LZkZVQU50VzJsMU5YeDBLbEZ6VkMrbTYvdXBnaTZIdCtSZ3lYVzBz?=
 =?utf-8?B?d3N1b0gzTU5mMk04OGdLSXMyQmZSWE44UjZyWVB6czVnZG1yRFpzbVFWbVZz?=
 =?utf-8?B?S0YveUx1SUZKKzlIOVNnUlY3SE9WZHVCbk1vUFpGWkdYRW9DWFhkMGdKSGxV?=
 =?utf-8?B?a1N0dThwSjI0NGQ0Mkl1T2wrZGwzSFIyYlFiSEM2MUgySWZRbGdKODBzV2tW?=
 =?utf-8?B?K2I5alFoNXRuWWlZQVBBd3cwMjlSYnJuWnJuRWE5cm4vR0JKaGpxc3YxUG9h?=
 =?utf-8?B?cVI2ZDQ0UU1rZklPd2VJTENVM1A3OTJyaUtQZG9reVoyQ0x6Z0xGZ1JWL1pk?=
 =?utf-8?B?UXhYNUFNV2E3d29meWJ2NFM1UFhjdHQzSjM1eUplYlRHT25yTmpFRmQ3em00?=
 =?utf-8?B?aDZDK2hJK25CWnRvTnRlc0lFZ2I5ZnFvcnJDWTBHOGJhVjVIaEZIUnQvdTZ5?=
 =?utf-8?B?bEoyYys0M0g0MWlIbERGQ3JQMGVsd0svbTFTalZ2VDlxTy9DMUx2dlV3R3Bw?=
 =?utf-8?B?elVLdWhlTzdRY2o1K3pFd2k5U0NnZ0ZZTHFGd3ZWV0c1TlA2U2dhNUM1S1kv?=
 =?utf-8?B?dll6L0Fzd3dMZ3BPaUhZYVRTWlNLbGJ6bnlmYkZ1Z2ZqbDBVeWV0WGpDM2tN?=
 =?utf-8?B?YmlvV0xFSjZhZFE2Q2g2SHgrZVFoOVhZK0dtUEF6eFo5LzQzVk53ckZwQUdS?=
 =?utf-8?B?VEdZRGNlNXRPKzRnMHR4N2JLQ3ptZHRFOGZ2WTR1YXpYTVhxN3I1ZTFaLzRC?=
 =?utf-8?B?VG0rUHd4a3JEOStyRDB4cHZ0ZWVoZHdnUUFxUHpiKzR3bnNqeS9ORzErMy83?=
 =?utf-8?B?ajdUQ1N4Qmw4dEcrVVlsdHVIS3NNMmJWeGNDcmw5T0cyL3VIbGErZVFuNXlR?=
 =?utf-8?B?UTFqUkJDY2R2cm0xNUJQcTg0ZlJIUnY2YldRVU01YTJ3YTBnU2hGcXdqaFVY?=
 =?utf-8?B?NFhpTVBPSitRQ293RkpuS3VQQ1VPTWJZTEpmaTdaYnZXQlBFdThudE9HZlMz?=
 =?utf-8?B?VUwzOUgwaEdZdWZOaXY5dFUzYkVhaU1OOTdBTVByampFWXE4ZDhoVkx5azZK?=
 =?utf-8?B?SXBDTGMzdnEvNUxQeU8zZjJLTlFZcFJWMHF5b00rTndYb0pValdiOEJqL0Yw?=
 =?utf-8?B?elNwb0xOV1NmZmdjQlh0L0txTSsvVFNQT0k0eXFJdEZWTFk0WU04Y1pjenlq?=
 =?utf-8?B?OWZOb3NQb0YzWVNXS3NPellxYnZVNmtnWk5jMm9vLzlNU25yR3o2OUxMTDEx?=
 =?utf-8?B?eFRXWkQwNzB5ZDhNTFlSSGZ5QW1tNVlHbFZGTHJ4Y3pnNFlHblVQdk82VVNS?=
 =?utf-8?B?QXdiR0Q2RGxwZDc4cXFwUzZnU21LdWEzdlJwSTJ1RGd4aDhsdEIwK1hQUVhz?=
 =?utf-8?B?QUpMK2hLalZUaWRENW9iY1MwVzZwN2hWRjVKOUpaVFNiZU5Qbi9jYm1pQVI3?=
 =?utf-8?B?YkovTkk4ajQwRC9xeERNaStRckw5ak1UbHRPTS9Tbk01V2Q0ZnVhVk1mTzRj?=
 =?utf-8?B?WGt0SzNza0hhWkJhLzlVRFBIYThsbUlDVGozVW82bjJOOUx5Kyt6SFZndEM0?=
 =?utf-8?B?bVd6V0FDR3NoQXQ2WUhxWTVybTJiY1BjVUJEVXo2bVUrRFVzWE1XZ25wYXMv?=
 =?utf-8?B?cXZ0bFNWcmxpeWc0QlRuaFVtS29CZmVtSW1CWWNhOFVUZldaUFJaOFBnZDIw?=
 =?utf-8?B?UEMvbjBYaWxBYWp0VVM0ZWovdDJDZy9GSGROdWkyUDdULzg4MW9YZFlNZlZL?=
 =?utf-8?B?b3N2OTBKOGUxZThKa2d3N1ZwM0hiUUtIM0QzUGd5aVppSTBtNEFsQTVzU0I2?=
 =?utf-8?Q?h/hK/D2AgwbKQNsH5q8vSAn0ehBclkG7mibYS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b16544-6456-4b34-6c56-08dedea2fbb4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:47:52.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnsMnZNgcXI7EnRk+HcxMwN6qRHqkmq7DmbFeKM2HZ+NRLPAt2dvXQZif4gIHuIQPy1GZjpdV+z9YS1fskK+Wf6WTh5iDhK7lH+p1GtgCcvtSqRUFICTR15YDiBgxAmV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8578
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12322-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email,oss.nxp.com:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35A4473CD0C

Basic change

struct dw_edma_desc *desc
       └─ chunk list
            └─ burst list

To

struct dw_edma_desc *desc
            └─ burst[n]

Flatten desc structions and simplify code.

I only test eDMA part, not hardware test hdma part.

The finial goal is dymatic add DMA request when DMA running. So needn't
wait for irq for fetch next round DMA request.

This work is neccesary to for dymatic DMA request appending.

The post this part first to review and test firstly during working dymatic
DMA part.

performance is little bit better. Use NVME as EP function

Before

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
  IOPS=261, BW=132MiB/s (138MB/s

After
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
   IOPS=266, BW=135MiB/s (141MB/s)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- use size_t for nburst (sashiko)
- remove unused field (sashikio)
- leave pause and resume as it because there are other problem for it. It
is not fully functional, need fix later.
- Link to v5: https://patch.msgid.link/20260709-edma_ll-v5-0-e199053d4300@nxp.com

Changes in v5:
- Fix cover letter typo
- Fix double subtract found by sashiko AI
- Link to v4: https://patch.msgid.link/20260708-edma_ll-v4-0-cc128f0afb61@nxp.com

Changes in v4:
- collect Koichiro Den test by tags
- use addr in argument when set ll address, found by sashiko
- fix iterate burst problem when exceed max link list, found by sashiko
- Link to v3: https://patch.msgid.link/20260702-edma_ll-v3-0-877aa463740c@nxp.com

Changes in v3:
- remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
- rebase to vnod's dmaengine topic/config_prep_api
- Add non-ll-start() callback to handle non-ll mode transfer
- Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com

Changes in v2:
- use 'eDMA' and 'HDMA' at commit message
- remove debug code.
- keep 'inline' to avoid build warning
- Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com

---
Frank Li (10):
      dmaengine: dw-edma: Move control field update of DMA link to the last step
      dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
      dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
      dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
      dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
      dmaengine: dw-edma: Add callbacks to fill link list entries
      dmaengine: dw-edma: Add non_ll_start() callback
      dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
      dmaengine: dw-edma: Use burst array instead of linked list
      dmaengine: dw-edma: Remove struct dw_edma_chunk

 drivers/dma/dw-edma/dw-edma-core.c    | 220 ++++++++-----------------------
 drivers/dma/dw-edma/dw-edma-core.h    |  67 ++++++----
 drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
 4 files changed, 304 insertions(+), 392 deletions(-)
---
base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
change-id: 20251211-edma_ll-0904ba089f01

Best regards,
--  
Frank Li <Frank.Li@nxp.com>


