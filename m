Return-Path: <dmaengine+bounces-6856-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4AEBDBE55
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 02:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C073C3B5A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 00:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04A149C6F;
	Wed, 15 Oct 2025 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dWbiGZ5Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD84A48;
	Wed, 15 Oct 2025 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487245; cv=fail; b=fewGepNFdzXcX+soxw6UnETFuFTchIpZwsUgIdvpMXfMmEXZxFmo8mSzxJ5u/lqZyb4RN/nUKQm/ychqXQ7pQub/iOU++6W5XthxPVXnCD4M8gz4BTMdYgcEap7MGEfzyeppv7ckUSlmd0HGU7c3LMsySS7qTrr5r90NG1Gmbfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487245; c=relaxed/simple;
	bh=4JI9n/hne/woU1x9oShZydIpC2V5+ClOOs/9sdPm2cw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXIG2/FX9ZTB4OxBGY+VFwfUcgFT4cPJE1mnKLyz3bjrTIMyjZGTvhF6kDcSBhzZwASwBW7LOEjsGOP4TZDIA1kqU8KPWsJUFDHgSePBNPwxrCQnOid4jVEXjlCrLRG0s+Jls2ovRyAis314UFZDX4NJXWfy2H8bpg/N3MAYUjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dWbiGZ5Y; arc=fail smtp.client-ip=40.107.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1VeIY9PXcBgMerxTQGOseKS9AVJjqtpOSdGTGNNlUuA1DwSuarhm7j2a0ye2mpU18ecZg7MXZVlirhPeuidQ7lmb2gkq3GWQGl9twIKJ/wosUGXGu9xCgZJP5Pr9PCUfA30Aj9jsroyjWDniEseng3M6pN8PZWf54dHCmCFhI9IvY4Xy2SKOpQGtx10PMn1UIz2w4B3Pcr02oVLLyyyr3jrGrMTL3wBf9SaFRB4gI28QPnaULwvtxKCc6Nkm2ALAB0TtUfF15+SAuoqiZprMuK5/6cLGLwZS7DWJU6D6hHSPbCHWXoZDl+OwOrvP+L9e1CS6t/GiGbRUlynY9oIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8l5DzyvKyU9XmEaD1+9BCVlSOrnfoJA33pn8XfZO/o=;
 b=vrJPcITRyNwQiD0VCB3NsuVVUZGSn7SGAxvdmgm8nqmvLTwqVonkKMM9ExfND7ZEzBV/piqSCFWhSg72Pk0dEycYed29JTZHg70ty+/YVXuuUuHRfC9fruedPUYY1IF8vsgFgkevfZfvPfp4ogcT1pUGtHH+8g5Zdv6bxUzq+O0LgMsVC7EKzvG4oQY6mvn4psc/e9p3RMViSbnGHrzLbgv6nFjW7+Ot1hjZ4FAAMMCufncEbh8rpOuWFP4S0OpLNLGwQqY2mNbTqOeyPNIAPlsW+tpM9OSezVJfRVBkcEWrElUkTN/dtiB19PqAHi2z7UFiFr3mPeyZA8pOVEPrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8l5DzyvKyU9XmEaD1+9BCVlSOrnfoJA33pn8XfZO/o=;
 b=dWbiGZ5Y+v30Sq5yJ8rzTWFrtnTQvxEFLA3Lte9UkzLbFJRJv6BhmNkxb6sGDiWDufwAo9aijlBVIWi9SOphIqoCDbhRied9RKKsmI5Y8dpCmZscIa9Uf3Vs/eQRwErbrEBeyu6EgpBC/AKIbL/HfH/gV9idw1x5SMnMqOVHexnHh+5CtKpWZUAEOd/MA5moYCBLdbvaq9CVvotjngoXybC1xNDdQhE0EajSj4gP/U4dewqyMyOEUQ/Uo1Ar/AcBoDI/WY7GDx5D2cxadMSvxTMd0CXhIR5rl4/T75A4vkT43mXhCL0eVszWbbiTcpEQ7DZlxBNYECysfSYVNLHeug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BN9PR03MB6041.namprd03.prod.outlook.com (2603:10b6:408:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Wed, 15 Oct
 2025 00:14:00 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 00:14:00 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux-mtd@lists.infradead.org (open list:CADENCE NAND DRIVER),
	Dinh Nguyen <dinguyen@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Subject: [PATCH 2/3] dt-bindings: dma: snps,dw-axi-dmac: Add iommu property
Date: Wed, 15 Oct 2025 08:13:38 +0800
Message-Id: <b9bcc7542afae659d01553c5559e28e4f01966b1.1760486497.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1760486497.git.khairul.anuar.romli@altera.com>
References: <cover.1760486497.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|BN9PR03MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 31069536-4d35-4f60-6205-08de0b7fbcb6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E6HdLWZif4oc2HBH6uzNgndOaIrJq+OCndCo8fBDE/jnK/YVL8FLfY0TB55z?=
 =?us-ascii?Q?BNv5NclV1eNA8vORPnZoH/6l1MCO7hOpY8mPpl9xnNB8WCxPT6lF5q1G3krt?=
 =?us-ascii?Q?uC0UYcuGMzpZLX36Abt2vhDvX3eOh0BEksNjSnJ4OFKZ85ner3CPC/xnH27q?=
 =?us-ascii?Q?pxo3e+ae4vsKLpnvIXzPO1ihoRAZVYvDsY6lsldkTjfDqQyyns0hXidRq+KW?=
 =?us-ascii?Q?ozfGoI5Zrec73XziMuD45qQTG+tjyeSXBSK1zyfLyOHL2hKPj5YV/eHo7Wcn?=
 =?us-ascii?Q?uk8B3nTXRxlHLHLmiBcH1WgTPzKmclRO7oDa0ddoo5/A10bYItOqt915DmNH?=
 =?us-ascii?Q?mqafN4z2HVeCUmgdMlMrP2QuzNrRYGzHQGgb5bCI9fLhaa1pe9y0EyECBJHa?=
 =?us-ascii?Q?6wH7CS1L7XRE9NWl4qOmcTtpiajge1zNn8zJ+suRkL2i2zReyM/CSx2rAXY0?=
 =?us-ascii?Q?Kc+sB0FSiNBSgwLjjMfTtPW3RjW0SReI1UZ6uThGKtNXndzymaTC/zkPHqCO?=
 =?us-ascii?Q?IGeusFejLU1BJdbuHDq0G7GS461LnwknRsPolfJw5TH4Y/gZ5bUikL6/B/Pq?=
 =?us-ascii?Q?lIUc5KH4ljbOcZHtwVAcw7LOvPhHGitcoF8B/sydwTqYJsvjGoOgZW7hgcLl?=
 =?us-ascii?Q?+adNj3BSaHEPAm15m24T9F43Dosm+29XGJNiMwC0p+KHGOrLnUBhbNgEehHJ?=
 =?us-ascii?Q?G8HjPCP3XgU0s4USgQr6HTkW6O6Or5Bthw5HO98qjITRIU0zMX0dPckAw1qU?=
 =?us-ascii?Q?WjiPwhbjd9WLApv4iXyYdqouYYfdoe2E2ZTnkz0JKmPR5mcCf5wA8YFqZKAs?=
 =?us-ascii?Q?Q/+wnnKNd85ltE5JIEtgxh4/OxiVRb1CcD38xQS/nGvNylgEzFT2LYTRazJF?=
 =?us-ascii?Q?uG3CghIdhSr4Fgf9M86Mr6AyEHOzRTW20f1kBIxL46oKR/IQGHecTOItAQu1?=
 =?us-ascii?Q?BHwZMhiNTy9CZKzebQu66DBHcw5MMHpzB2Rlz2Ag6SsOoO21agbysJs7G9/N?=
 =?us-ascii?Q?XG1xJkJN+0tgdaN2Hf/USmKyiAg6AisNQJyJyDhjxQIdwfh7CIGaiqD5Wi4N?=
 =?us-ascii?Q?bglJGRz8uoYKksH1U/ShW1shj6RLzrXOjjErSjJq2byu7OCehISpLfVQGzMn?=
 =?us-ascii?Q?V06GsMDHVmyjqvgKNopVt/ZpvuN1zAFno3hRO6cCafctg0dAsWbzeMFLqTFE?=
 =?us-ascii?Q?asLmFfcE85LjdjPBbaosfwzL3cOLSFiH8d5Ojqh83EDSmyG9m4Vtyt+cIJSo?=
 =?us-ascii?Q?hvcLEET57elzNKRys06bmNZ1pAdZW7vsscsIWHAE49hOXlrBCsgI5UUxxM3T?=
 =?us-ascii?Q?tqfslCL5aCdMzCA1CRCwDuO4GSp0/geewiBNj6DYYvuBglnCyIRvqWeby2md?=
 =?us-ascii?Q?Sonw4QHwxbdUIITrOrtFOsxL8D3QTdErmpviwCHDiFj6ctK8JrkpS7ghXv4u?=
 =?us-ascii?Q?3fT9/fMi+dbkDP2gD+xNkNct+ir6iE3befzKpMdhhGLITdvbkCOZjm1PQVWA?=
 =?us-ascii?Q?bB7lPAC7b00ZLgo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PX1nz2ERrqbRHL8LglmYM52TkZwS+ZRpOpcP7zNqHcsKHJ/P9TM0Wfjkb9hZ?=
 =?us-ascii?Q?x1Crdkjv69zEwxst0f8P7XiTGD5LFvJqsqSGG2fngRjo6lkjTwZ0wge8ZpD7?=
 =?us-ascii?Q?nA9BcWiAoJL14egXKVSWVhzC6qmqrQNaRRxUKb0PBM5aq6uRtNmG57o31IAA?=
 =?us-ascii?Q?0U26R/gtPg8b5KbpmtmxiJrhHrYYIhaXetFOyEe93JlVCU0jtY4ARptNKlim?=
 =?us-ascii?Q?Hgw+eU1nEAP4Gm0FNnAgL2xljjIn/VGv8q+RTThzX+jR0xU6EVuQi3uwfd28?=
 =?us-ascii?Q?9VJDCOgtRb2/0EizOdu7aMsW290YUFfIP8Y9p09UU2ZhZJYguKLEdA8X+8e4?=
 =?us-ascii?Q?sFFchmC1NQjiofgWqi76ddR4YctxukYs94+txxp4dr3t8CcPi0uBQjAftoQm?=
 =?us-ascii?Q?MIRROMVXa21H53isOlt3pMg8NUpjKuYgoG272fb+f6GVRTmBlFU/HzNAtN7p?=
 =?us-ascii?Q?taXb8Ls94UKSLdNiCLjBWXezr5CTIJFqMmxY1YNSIUE41hmEKPmdcQlHPddY?=
 =?us-ascii?Q?C6c/ptv+DoOgJcQoe6ki2n/fNZmgcWALEJE7rt8Uhp1gjeCPTZFsSCh/6nB7?=
 =?us-ascii?Q?C+cTDXbjxqzI56R8ZPAfcD2Aaz2OncKPpg9eJAZg53Nrb54rpZ4YKuEZNw5/?=
 =?us-ascii?Q?HtTXUAsla1qxQeZRC9fvdDawcb9zgFb8E9ovqxzhfZQ/+zL7ObDwby/Wmjh6?=
 =?us-ascii?Q?aIDnwxUnd457mxgmJPMNoD0rp5XRLC6HdLeOeYhl/hS/JDDVNx/eBdJHXSGG?=
 =?us-ascii?Q?1vJKX7g/UPmgir/umjzHjHGJy9xpV4zSYZLGGw1R3036z24VklvmRX104GIw?=
 =?us-ascii?Q?95Wjh208KBqsyvwDrLIQ/v20SIeLk4L7sbscdUnsV5s1qMuDJ8I8cnx090bg?=
 =?us-ascii?Q?35PRgrYuQbs38FASu+fBvHt2OSvOBoSDpKYyDpA5ugMmj4ptxCHE0Y2bXWMZ?=
 =?us-ascii?Q?4OYnLZs0rs1MQMX0k6nsS3maJtABwd9ZvtmEvn+TOVgDnGC8RApr9kP5UJuY?=
 =?us-ascii?Q?+nBlAKoY21oFPtco3tPrjwMjtafRIXReEjJh5ZR83Y1lm880US2ertv+2TNG?=
 =?us-ascii?Q?HGWqWXRaUL9XrqUmxhowMwYkzazMq8RLev2ZVp5Hk0xHKx321HkS9r2KCPEL?=
 =?us-ascii?Q?bPWQjXExnu7TVVT90EQi3/Fb6Mr7AdKooi+qFCu1lokLHt4K0PO8N9Cn+KFq?=
 =?us-ascii?Q?54A4Lqx9wu4yN7H4t0jFYEZpO1oBrCDJSh3/dxAvtOE4MBkoer3Km+gVaqiI?=
 =?us-ascii?Q?exb9yNQ+ohajCpKkxJHf/W2dALRoiUkSNuunkhHYCh82CekwjtECh+bpe/Sj?=
 =?us-ascii?Q?0A0SJ9R7GJtMtk530QAxDA7Z3h/wzLeAYr5Dvs/7POJDhihILixmd5B+ppho?=
 =?us-ascii?Q?7FyEEgC2AxzmrdaCm3OsZPEGEYVBsfIdo0p52DqXF2Bhkt0HG/FyLGUhQ+IU?=
 =?us-ascii?Q?60bmrmH7N9RAcEwHgcOamK8j0yB5QJ5n0nouZKwk3BDrjUAjgmAaGtm0soe6?=
 =?us-ascii?Q?L1tMCqJY6AXrsdxHcOmlw/WhoEa+qkgCwUIwi1LgKKYvAjJO+xlxtUAML+2K?=
 =?us-ascii?Q?njse+vmCWkaRkABhH0z0QCTBjemqflSjCF7NAuC/O+FkI/WGx0E3TEkxw4qx?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31069536-4d35-4f60-6205-08de0b7fbcb6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:14:00.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR7Jf2gTRfQwi6NqdwPmUe5MgOL6LGgmtyk713dmaHUGv7S7VW1YSl9I60iOhfIub4rIJ1CIe7jBBvU9jclVntrq5j+cSIVa3ZTkTy4ez/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6041

Agilex5 integrates an ARM SMMU v3 (System Memory Management Unit) with
dedicated Translation Buffer Units (TBUs) assigned to various peripherals,
including the Synopsys DesignWare AXI DMA controller.

Each TBU handles address translation for its associated device by mapping
stream IDs to memory access permissions and virtual-to-physical address
mappings via the SMMU core.

The DesignWare AXI DMAC instances on Agilex5 are connected to their
respective TBUs. These TBUs forward DMA transactions from the controller
through the SMMU, enabling IOMMU-based features such as:
- Address translation for DMA operations
- Isolation and protection of memory regions accessed by the DMA controller
- Support for secure and virtualized environments through enforced access
  control

To support this configuration, the `iommus` property must be added to the
binding schema for `snps,dw-axi-dmac`. This allows the device tree to
associate each DMA controller with the correct SMMU stream ID, enabling
the Linux IOMMU framework to configure translation contexts at runtime.

This change documents the IOMMU support for the DMA controller on Agilex5
and allows proper integration with the SMMUv3 hardware.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v3:
	- Refined commit messages with detailed hardware descriptions.
	- Remove redundant commit message and add hardware use for iommu.
Changes in v2:
        - Updated the commit message to clarify the need for the changes
	  and the hardware used of this changes.
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 935735a59afd..a393a33c8908 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -42,6 +42,9 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommus:
+    maxItems: 1
+
   clocks:
     items:
       - description: Bus Clock
-- 
2.35.3


