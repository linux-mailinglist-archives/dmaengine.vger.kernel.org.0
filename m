Return-Path: <dmaengine+bounces-6855-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12266BDBE49
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 02:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A30A353A84
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 00:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E347199FD0;
	Wed, 15 Oct 2025 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="u/nMws21"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807C18FDBD;
	Wed, 15 Oct 2025 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487237; cv=fail; b=Mpd7FkXyRulwVcgxAsfL0vf2atxsk5jE1eJU1fdCsC8Uu4bod92tbnpWopKwmrdwGC/P0K0cGUeLwYxaqd+6c9vQaHz38S+y19DS7g09k5jbjX04KZJO/grRIcfR5ZF2lcJAu5NE38qPMq1yOURN0nWI1cwpWj5JZUcusg8bMRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487237; c=relaxed/simple;
	bh=C53g4MZ2+d+Cjl+hws5qwE+djYVBBg8p3++8Uw7VBTI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jo5R1p4+AFbgzVBWQxiKQlxwMG6BThGnAOpVw9iH9NT0PSYR6HD5MJowmGpijg/qZaYRA0TrSdtipElCVjb+HwtZ2J0FJH3idUepbpxJQty0ojMIVMwj8xe9XKAViuPAS2wmR8SI987P9/FHuh9gazbwf1AM3K/FDNb/j5PgWX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=u/nMws21; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbuHJCp3HJewzYD2l8VRB5FfJ8A7bBob22VlhqDBypEFT28KDz98xKGnkIfyPgHfuYJhM7PaH2xcJJfyPHeRrvwNKC1K+OPlCt1Nx2KIIHBsCe8h031QB3eOXcOyFs7HcCuafIO8XV/lhq9xGnSKcUewCBFkjhudEulK/pA6AGc6GY2FUpiMOM0HdlMlQmG9NYVXR9/eQgmXI9GVoHio2CK6jl1Kl29xKp83BCJYGWuzT1s9lSryarZ7nsqYcSO4cjUG97biuHlc/BXuzIXtuOKp9JIR8JWtb4MdyXbUbElxgTYbdUIuWvxW2K2YMyME7pzuSjMLMvZXucI3NwHRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EKIUEqqsFN5N86cWYiBeGmUtu3xJ1x8ISp0qh0jpGA=;
 b=lIaPkaNE+lOBAgANZfYEyzdsOLeg9GSlIYHQmJ3ThcXkD8CkaDOqFZ9p/VY8axfSYgxkDUhcygX2t7NTyU9PvabMIEjGXB5YYpauI0wvANM91nCIh7WpoTbHReCFov+TxdObzB+/AFYExxJHv2EUY8RCl3AQJnpYUGfxazYV+YvTUKJlzgEVU7rzutsyXZowJN2Dy30uD3ZMl5c8/iWda+VLPTktnp2o8VokNFV24gJLruJ4cxkZTuxKXPOIAmQFgRNBZCG8X/2KD3ttfqZ4ikf6QCUSxtAEY8er15daCdXXA/gZddae5dnNLO/2fBqLUuugCGvJEsRCMBGHvaZ98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EKIUEqqsFN5N86cWYiBeGmUtu3xJ1x8ISp0qh0jpGA=;
 b=u/nMws2126v/n4r2gykIR3pcw6MMOuoopw3YD0caQhUXEWmCaTSQ01W0ODUD35c7LpJfdAgsWyc9k3WXqCnPfGfFj1TMaub9gaGshNtdoVLAl2NAc3ANOuZ5ktc58fSuPIJKOhaFYif3bqPHZH+mS1CUFbp2ZxSjpEBVk6+YA3NPgWCor+TG4r1ihvVyVJX3Twj2xOHIKDHjyPifxFRDOhq5BOr5IY2eXV3yTe5fkQXs5kMe2VgZ/5lvmugzxo9K9VUN/nbsK5UJje1aDK/Q14zPkpJeRt1YhpSLYV+ObIyce47B5wrnjKQjv6uxYiQz9Kst2yGhehT5daJeB6LYKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BN9PR03MB6041.namprd03.prod.outlook.com (2603:10b6:408:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Wed, 15 Oct
 2025 00:13:53 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 00:13:53 +0000
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
Subject: [PATCH v3 1/3] dt-bindings: mtd: cdns,hp-nfc: Add iommu property
Date: Wed, 15 Oct 2025 08:13:37 +0800
Message-Id: <8f3ebbe7084c8330e9ea05e55b16af1544fa3dd8.1760486497.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7f63fe5-5992-4397-bc83-08de0b7fb965
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aChgBfoGlb/vudtS/r99dMSHpDhHryaX6RlpNiWD6/iET9ZviQUJeYH5HJXb?=
 =?us-ascii?Q?UwJ8HQtdV53R6wM5zPi+a6SRlnjhVWxdNhI9a/Fp0+sl9O/m5HvGAqLxBMFa?=
 =?us-ascii?Q?X+xgJYO/PWQdL9r7LOVLzXOUiDkud6UZ/aqiw5tosKqRqj3W0ino4NGExGdv?=
 =?us-ascii?Q?FGa/vpMSV9A7LXnmF+C38KzzxzWrx2e8GWchdm3nAh9f134Pz+iVOngYjQyy?=
 =?us-ascii?Q?crHjvQSWclH1bRsILdnuFB7dTqFSEsAKnoXS/7eO4s2Lmb0XvmyjsHoZjuhc?=
 =?us-ascii?Q?OQ5ltizD2AtMkUv1ksCuYG5OFZBJsA8/5GhtTaSi33OoWc+glxrVtaf4/afr?=
 =?us-ascii?Q?XrAxkE6S6q9XnIVWZinUIwZv1n0JMPasd0DZ4rzrAbiCpSeDTygt8sc9KuYP?=
 =?us-ascii?Q?wRrL2EdPvEXv7+zNvypqaZjf0f4nRBneZdVlw0MpKfhQlmCwAKNiXbkGBdj+?=
 =?us-ascii?Q?e4GqhWTIpASfxNmu8ENOdIgwLxR0+0Lr0PwT8deo761wSbxI1bUYOa7vjBnL?=
 =?us-ascii?Q?HSDaDQ4szmgDJw9dFbrw0FgG86PA8bjh+a/FBnTzu082bnOcTCgqiCJQUI5q?=
 =?us-ascii?Q?qjiL9Vh5VwkgIN/BxjeK1ezJucTMTJh2DQWuXCaGnTwNjXceQOGxVq7wAOpG?=
 =?us-ascii?Q?qWJzwjJsXbIwRdBcD9QjZ9q5pukkr/B4e2gTWAX0YDDK1rMh4tbv61h0CtMY?=
 =?us-ascii?Q?PzzNz0fspru0oWD9iLULx9ssdLtQ3qho1vbMGpVZc96LVPlpbGtCklFlqix/?=
 =?us-ascii?Q?149mZqd8vqwmOyk08op4fXUFLIywwNP9WsWOoS/X9sn7QHAm8oN8v3YVRDev?=
 =?us-ascii?Q?sqj7EloHEg2xSjsW3RNBsViV0/uJl70tY2DgAdS+mn+wt5//LvMrmxc0tl3X?=
 =?us-ascii?Q?0V+iLny/VlbmUSFPClk9KP0WSlh9gaMbezGzixH3KX1rHWuMFTm9nudsJmF9?=
 =?us-ascii?Q?wIifjJZfaUchiXwbJJ/oFH8WJxA3YLO+Di9U1m3xqImXOsYuSY3uWeZwaeU2?=
 =?us-ascii?Q?WwMZievSOJUl9N+4SNBBS9dca6rcLIlIt0A+WqWRa1HPEvUMcBPbAnmxZ6av?=
 =?us-ascii?Q?9euG7rtAif0N9bu7rj04uWxugZmGiZ/yDr+x3dhg+runY9TFn0ueYMNo15Cg?=
 =?us-ascii?Q?WgL20fIYv09L1Zk8zgDRorHoBKEWccoElmRsCBTUsuxyrpnPdMaPICKtWi08?=
 =?us-ascii?Q?vkwzcRYMaHheBNHhDEp2soZ1ArtLIfnOOjm0mZOEZEE+J9yqpwBj5QDY8kPa?=
 =?us-ascii?Q?Is5IWFNvnCukxoP3yqTLcFFiG+peDRwZURdTns1Ko2X9XahYTac55vSm3Xov?=
 =?us-ascii?Q?1psMUPT8F2Weli53Bwq17aLviiVqG9f6xtY/CPp8Frkr5ld+m3/vYl79nUc3?=
 =?us-ascii?Q?kzPl+fATMBKoue0d9JSPiDHNZohKdPh8iF+NKVwtKROE9kMs6q9S/VuNIH60?=
 =?us-ascii?Q?FEF2w9knJqKECEE6GeHTZQbSO7mmC7FlBlXMsLDdvO3aUQECdVRRaw8/1KZE?=
 =?us-ascii?Q?Phn8X6dXUSN95OM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5cWdtek8yyD31PYyBHIpH/v6zrbCNqxcoW353jIeCUb2/81v5xUu94JYosCC?=
 =?us-ascii?Q?Z1WR5MkvdhmNfuHmL4hF9NNeYyD7KXpVMQGxtQppmMSoJaaiOTbbJQZRyjnY?=
 =?us-ascii?Q?FdAO53gAB421ub8FunvVEwUSjv2thk1x79JgsMFXTlZn0FxGZ70lzHFKJH6f?=
 =?us-ascii?Q?Y9QRFYmtsavzS0Pu0tXd4/TdLKOGoTNf6CVNkSH/oRsLFM8E06MERR878T8r?=
 =?us-ascii?Q?OoalWfqlTXFSnr68A2i/bLUSnPnKZQ8GXlZ4dFx7wBOUAweWwTR4dDFHbv+q?=
 =?us-ascii?Q?FiMypWL3uUQ43922nqCZLbjFvuhJHt+ap2SGjzaiVi/9Qwtph14jXBM7rAoR?=
 =?us-ascii?Q?mEJVydWSGpxgp1ZoZfqRtrO0a4a5UdnUh+/Ec/Uah2PIDYoS5X7BZ+r/4pif?=
 =?us-ascii?Q?+Z3QiRjy7F+T9VQulCT2T2edVX/nPFS5S1lr/QMLGDHk51EQSunIQxDMcbgb?=
 =?us-ascii?Q?6eWGB9HwGAFe0C4pAbl4ALB6swA01fjwnATjHUbZtm0GUXbnOPXbaXQbPT6t?=
 =?us-ascii?Q?tFyKs+BOGzFZ4IX4Bhj457Ktbt/hJMYmwYbz/QhfadXEb0sB+g2yV9117nBA?=
 =?us-ascii?Q?kEjoiI48KctzZPh2wFcM7GoQL7h86YuP3CeIAeOfiokx7lA2HtcAWUhpnd23?=
 =?us-ascii?Q?KkBY8g1SfMLgKON58oc97wwMpifw662Hv5T/NQjwmKJ8QdHMJliFbaPIdZaX?=
 =?us-ascii?Q?J+RE6WN2Ey9MvxzMV91HM2pd27K+26F4zM5XF67EfsR2cEBuucUbPjg3fTyX?=
 =?us-ascii?Q?3w8BFa6jkC0FXSZSPJOXpPbTdmcKdsav3GzQ6Xs8Ov2OBHDEZPoQwGHADJxY?=
 =?us-ascii?Q?+E5MgQsrUArJ2C4ZArtX1VuQjFt6IWvmxaCbMhZoW2t/qv2yfb6EXfRoEsFw?=
 =?us-ascii?Q?OH5ANJ24Dir8RsMqtYiO75fcFKuB50vXxaP4JqXIxWCyhwi7Scw2ay516gJg?=
 =?us-ascii?Q?0EqW1w06NHBWBSENAoyRbODGU3kviqADeY5rQo5owGIjtybCJZ7mEr/PqOhd?=
 =?us-ascii?Q?VWHlOaT5CJnI/oCQdbJhyLXv1ECgqbK7RkV5QAXNi0UAdX8UDY9NLDdn7Foo?=
 =?us-ascii?Q?mtD5Cnl25tBh/+Hrwhj0wO9WxWqJPCeFiOlTMwRinal/UKy0/2iaz8kBhAiu?=
 =?us-ascii?Q?pp3YkpzmZdDBYNP3/wpU9jEjUz9WDLKO7F1VuVGUgmHNvpEY/QUvZ7nbX//m?=
 =?us-ascii?Q?/eKyKPJKAVOBaQUBDED8KZ3acgJx/9MC7Y0a5QFGffk4ZD6lH9Mhbxc7EeJ0?=
 =?us-ascii?Q?Sq1h+Va6gZJ44kRNvJRToGU9J8PpubpA+3WYME/nM7XMLg5o5MAYhxh0Aqeo?=
 =?us-ascii?Q?nHec7KfAKgsI8eu8IUvRraYnoT20WKaLy0aNcw7ZnbDasLQKZOpc++teOV0Y?=
 =?us-ascii?Q?mvXIEuiZkA7JPWYYbKkSPnuz7FY9B5xmEUAc9M75bwvg1qP5wu25W7UbiFyG?=
 =?us-ascii?Q?aRalFIWz8yHpahMUonOepGvSLcZhCpunxjH7lddjtJ0wPG1Vnfp3PQtpkreL?=
 =?us-ascii?Q?xo32Q0SwUUEzT5mIz1Tb/dNk7zVX00oByu9j198THJIjFtq7+1etSAuPbgfs?=
 =?us-ascii?Q?rtrzCR6332V6OgghsV30WlFsoC4JROvLyPHD9O8o/4RgiTebo4NcSS1rpTNJ?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f63fe5-5992-4397-bc83-08de0b7fb965
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:13:53.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0cyvqnkDgu7c1UBGLX4K4YQVOGF3/jn5ArSkXHENR5Vlq0y4iCTlBvJEdg1AmDuCPdOsXwpea+zc+9j/BeeLvuvPVs8Y7nrefSIzMrZVZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6041

Agilex5 integrates an ARM SMMU (System Memory Management Unit) with
Translation Buffer Units (TBUs) assigned to various peripherals,
including the NAND controller.

The Cadence HP NAND controller ("cdns,hp-nfc") on Agilex5 is behind a
TBU connected to the system's SMMUv3. To support this, the controller
requires an `iommus` property in the device tree to properly configure
address translation through the IOMMU framework.

Adding the `iommus` property to the binding schema allows the OS
to associate the NAND controller with its corresponding SMMU stream ID.
This enables:
- DMA address translation between the controller and system memory
- Memory protection for NAND operations
- Proper functioning of the IOMMU framework in secure or virtualized
  environments

This change documents the IOMMU integration for the NAND controller
on platforms like Agilex5 where such hardware is present.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v3:
	- Refined commit messages with detailed hardware descriptions.
	- Remove redundant commit message and add the hardware used for
	  iommu.
Changes in v2:
	- Updated the commit message to clarify the need for the changes
	  and the hardware used of this changes.
---
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
index e1f4d7c35a88..73dc69cee4d8 100644
--- a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -40,6 +40,9 @@ properties:
   dmas:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
   cdns,board-delay-ps:
     description: |
       Estimated Board delay. The value includes the total round trip
-- 
2.35.3


