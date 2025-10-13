Return-Path: <dmaengine+bounces-6802-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1ECBD10DD
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 03:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DC03B6259
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 01:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C71DED42;
	Mon, 13 Oct 2025 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="sLG3RGoO"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25412B94;
	Mon, 13 Oct 2025 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317629; cv=fail; b=W6RuA3fTQOuBvTKDVoIochx7d6DF+rMCMfFqRDWbDp99GaWVuhdua/RarFB3UQJLINP92X1fpyj206MroPTOC7SruUzYjpJyChw2ebZAKr8vTi6mYM8TOUFVqt/4lYxq37fFsGQ9TG818RbGDpaogPjGeUKFDJ47aAgzJU+pzCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317629; c=relaxed/simple;
	bh=GbyV3pSmqouU2ITblLiD87ocAWZyo6fCP0TXKhhCr4c=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gjq2cCmoSEl17dUCsrYESOE15chmGlO7EOOfpT7lIxmBVD4s4nYyL8enfSKCARmxA9vlf33moDZ4QYu+reAjU36iBOxqafbAek67v3yNqRUforfksuNc0fUZ8shQQ7teSfbvaYX2Bk6mVP0D6BxtGH5FK209o+CtWstFkhCT2G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=sLG3RGoO; arc=fail smtp.client-ip=52.101.193.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkHpApEZEpcMUFsdE77H6QWr6OlDKcWzLOrlxKwyhDRX0g+Rxk0vHiBvZJsAFSzi9gwUBAWOjDHxJXw0KlTjzEQBrhMCFsW+ERajtVjAQ2XTBarmR2+V+76ENeZKNB45M2Td/szSweHtJ0tbIZrk1uOVrfwPNgUGq00s88rgAkUr+QAWRXGX267wOGJKru3z95qu3aGtyjwMu5wqAXZ8+BdIQellHsQ13WZ6gNjM5DbGJyCp/9uFakIm4F6juaMx+9Kgkw9X3aBtKQwXAqsMIfiMGGkRLUBJxDuG+kEHzmtqbu4L7x1QhcqX9GxZzUPqhcu0E8s9mK+J8KcSH+Xjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvjprVinY2+3T7xmnxVCYE+0v3JpB5bq65KjnlKqqa8=;
 b=zJhn3oWH1qiff5BHP0WUzsScf9/4nBQfk6RLcpCjvVFY74rfAehKtcE6Wn6r98Cim++efKCpVZ9EdAw+n/JxsDCfsJ+NtQXLPIIdwp7Yf9fcc9gRwZS0rjLR/IIx7W9TYx9aWf9woCUwAYIiLIJPVfou3jCgE0GoF8mdqIA8W5snu8qDtfDArEuFA+UMlB9s3MeNM4cgqCMjb8I3tQCVFbE+XeHU2lSIohLKGYUoNp/Y4p8g6z5D4KvUCVTg8E/ZU7ZAddQf2aEBxEVFAbxxvVx/gsnE59OGxtX9LnpWrZSvzroJGfJ0hJEGEyfPoABjfdNn1Xg1QROEZfYQJ4gEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvjprVinY2+3T7xmnxVCYE+0v3JpB5bq65KjnlKqqa8=;
 b=sLG3RGoOmXIUSIvh5Ti7tqZ7h6IPXnT1iQ88Rg9v9MLo+FaRUyfpU2eGg+8Q8pYIRjeTa4K8tMDTaxaxE03MnvwkZ3UGVHyGfQo59o41xWF0cAfIoWgypL90Ou9snG+1DLQ0aasb4SezRx5iwwzrvVkB26xBg8feqkMJ3s1arU3hBgNTVngSk/nYPZPFc+qefDu8ENFL+nS6JRXmZd4WIal6nDkYx1F2C3gjdI0f4vnHW/+fYVMAsuLmqEc/c3UWBrEVtgfK3ivJDF3hN6uQC0xEsGmU0UckN6rPAh4uWJLm0p6/VMhMHjK6HRbg6fVUFNkSuWE9Yp2PjYdbmzYuiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA2PR03MB5946.namprd03.prod.outlook.com (2603:10b6:806:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 01:07:04 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 01:07:04 +0000
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
Subject: [PATCH 0/3] Add iommu supports
Date: Mon, 13 Oct 2025 09:06:52 +0800
Message-Id: <cover.1760316996.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA2PR03MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: a56cf568-fe0c-493f-71eb-08de09f4d246
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zEWZdEX24XmQSxM6FlQzSdIKrbaY3QQJVHz1PS2eI2gZDzAJ26gEzeCksCX1?=
 =?us-ascii?Q?fuZIqShqBXtn8xqEWnEL0bKeZ4lbucL7z4LetEPCR7zG1CbLTSO/D6KPTkKA?=
 =?us-ascii?Q?BTZQPMltII15t7qrUQXhfFUXBOsJuoRMv2fImKg0CLBXkbs4Wc2jFxxWyCUe?=
 =?us-ascii?Q?2IHt//aj94FUqdlAbVUjeHdFC+Sht4Y3IsMxwerKVbVDeZhsinhNi5wAy+lN?=
 =?us-ascii?Q?1+9mperibeWQRF5c0yf+qaTrgWjotAWxK4ilgy38SakYDYqmvMHbsv11dJRi?=
 =?us-ascii?Q?Pp5fV0rVXBuiDuO04HXuVymsUHv5UWBwrzR6nkGv1S1GFB59uCTlCdmai3tO?=
 =?us-ascii?Q?ZSyqz9ASSL2K9UWqADCGI5h2i4WkKg7fF+M+KAsfz+Iznknj9E6Llfr9mUeE?=
 =?us-ascii?Q?7sXtEoMhoqbwDxkTakiuR2C+2m9iFqkaozV6PgOl5HyiRWzfBwinS+ecg9Bs?=
 =?us-ascii?Q?SHwHj0gO7XdX1NPI33R3qdOsAkewfHBg7ubVvtXiR++YBa/HGc7BrViZA2jd?=
 =?us-ascii?Q?EmnV7U1Oyg/PVzKX94LfwitpWNMX3KqaTMmMszMQUltEUyEldSApK7opSBnz?=
 =?us-ascii?Q?ENNazowoaJ+mhsIS1fSziRVX9LVD1pDKd2rUuIlEUCU4HHcOZ58x0zoViuIa?=
 =?us-ascii?Q?TBFpK/UPqtMdPNzXH9D0rP6/9eebKwam4FhI1UFNT9zVlQ/2zdKZZHpcBmC8?=
 =?us-ascii?Q?EJ5sU7fG9rMy7k2lurS/7xCBG/lpU8g2ey14zonvfpY2gWO3p/UJrDzfHOx4?=
 =?us-ascii?Q?1rqjK9cnonq2V7xmcVS1hJ1kzcMMiS8Hc0UElxeGfdkpmn91Und6217vv9Yg?=
 =?us-ascii?Q?XWriVeRTrRs43qd+WUSHMhDjvcRD8rJfbM+Ut3v0RzfeTOLq7p4If3qFEhX4?=
 =?us-ascii?Q?gWH/Qit6yyCmMa07xl4ZoZqKfn8/XnvDD5lEd2Vq3DwI3+4X9GWifMMtXeqf?=
 =?us-ascii?Q?x16+Tz7/jV+3mLAFCJPe+oZ2J9N6a/5RBMm2Rbq2ilyQLxrZ34Jz860acizU?=
 =?us-ascii?Q?qJ++jiEfTGpubCDe/QmjNTJz1MRnzHB/NITG+w/1r0rQmMPQvRzwQl1t5N2I?=
 =?us-ascii?Q?VQ/yBkg9dSX9iEd265idKVb70fhVtptU47dinaWHSnMi5kxURE62wSRMXyBF?=
 =?us-ascii?Q?KP0jcK6WOOPeIbiJRfxq2TMf7nE8Y13UR4Uu+cT8lys2gwMLp313fFGCek8Q?=
 =?us-ascii?Q?rG2stsqQVX8pC17llGjBzuNUbXKZZFQfUiPFQJpeV08RbF8OhJeIgA5f7+1U?=
 =?us-ascii?Q?vwvOyvOJModGTXYXd1WzdbIp2U5uKKwTlqq3udfe056rCioKzjvtRnkjSfO2?=
 =?us-ascii?Q?hPgXN+4Glt3TFJuUQXtSO10rbbJ5A9XUPgk+z3B9FkuInw38bAlahrZvZ6PT?=
 =?us-ascii?Q?j29x3lrrd5LBlf37zSTWWoDTOGs7qS94hAfx0MQq5P0Um4rR7/3jSZX5ftK6?=
 =?us-ascii?Q?BGaAKVyqkMEFlxZ19IVCiBR5Qc+hwqyDyUPMvQ4mNcHXqNHvNCobRRwbzjf9?=
 =?us-ascii?Q?pbNXGNd/AO3kv7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9glcpoUd+YobehUf3MbfNeSw2bzuwslP7HF5XGwXJgAfFpx2E9oe/Vj7si6E?=
 =?us-ascii?Q?bnHJr+bBat/vBrBoopZ1bcvxSo0TmpCwyRFUT6nIwlp0+IhoNR1kO1mpdK/j?=
 =?us-ascii?Q?KknDxTr+Vl9tVPxTMUunoPUBCtGx3ucMDAt++kZlJUWL5d+r/jk+8oX3sIQO?=
 =?us-ascii?Q?4Y6Q9BVdA6X4x3cH9S8Tss+5B0IeKmHnj0bbI/odEDX2GMGdWsMq81WCbzg7?=
 =?us-ascii?Q?u5uj2H32opzkS8GBYSJt9Gp7sTUDVutDwDYdtWtdJ/wjY0iZYHt+ghhVUCzP?=
 =?us-ascii?Q?+4b/pi5gOxKLhhplyfYiojSZOkk5aJAAsVUrxIemByen3roKLGQM1tQ74v1e?=
 =?us-ascii?Q?zu8EbRnRYeXGaD/0xZX0WHI/xDliHJktqhVwMSP/g0D6HO+QGBXXJFkU4XTC?=
 =?us-ascii?Q?1hIAURb84eRj3Gsvh6JkTujLtkumgaR59E8ss2lFhr7OWmqzGV8DDMBCnw9k?=
 =?us-ascii?Q?mTWok/a8sZiyZycIJMg/nPTxxwOI6ycyaJ5DYv09GDV5ya+5ugadFUu8H8tQ?=
 =?us-ascii?Q?NJLc7wG0+DRc4uIHY1BmpfNmF7QN8i4qPw7eOYeLJ1ySNy865o8/UqoJ+KaJ?=
 =?us-ascii?Q?WX9XOBVxVbXmIvG3iuXMKDrSAXWYWEP0k0Iimz72M4F6F0V2eHT71woYR3qZ?=
 =?us-ascii?Q?C+SAsPCi/DZQx9WXUuEra7e5n1Qg1sDJgUbK/6bVASjeMe7hOhp6B567coIs?=
 =?us-ascii?Q?YfPQBUnfzF5+SqBN/yxYRi7pnsTJPpAY5y7nKfJa/xjhqN2RuxBvqKCK99Kw?=
 =?us-ascii?Q?RRYgewlrUXf0XYn4F8IxooAiNbBJxwyBxxqwUHXoV7kIZDzu8emmBn00An90?=
 =?us-ascii?Q?NVtZh/peKk6F3sQscblLEHfZKCG9O6oxzWqOMshZrATGLx9Sc6/U8m9qNMdh?=
 =?us-ascii?Q?7PYgZwC+amWRfmnhwEYVPihPSpv0gUqsR884k4y3LUTsPQiEZon/sZCVV2cj?=
 =?us-ascii?Q?gqGqNFWfFUwWdxaIaIlmZR49TpX99vifDx2X1eDI9OvisHmePxlmqYF68hNx?=
 =?us-ascii?Q?4XivunedUdqPa5KIsWdZ0HGTd6hekyNcI2qdjz8Juucw4CxU0spw2xgOAbjv?=
 =?us-ascii?Q?QUJyRooYt17vfMT90OO6qVbUdSeQ6//LeskY4MuISOovFAoJiNu/UJEanNAu?=
 =?us-ascii?Q?66TwXSCSRdGFbVM5n3Kt1q2mR4SwiOSAw85QYGhMlkoiBQ5hlHAeR0cFfbpJ?=
 =?us-ascii?Q?/IhIIceeXI6I0HOUgeKVXhPDG3z22yFRRnbR98JRlNesBWvrOuFx8WngWhUj?=
 =?us-ascii?Q?Zq8oeJAFS+x6Aaj2qrwFTOdTK/7jg+6uhwJJ26tVakXe/zM+gus6oqIPG5gE?=
 =?us-ascii?Q?nvp9Xhcvb8wplPhMUBLPCllj0+YkmycZj0Siy5mdt36vhOY4tbg1bpzoSyvI?=
 =?us-ascii?Q?D+BJTVvE/1rLWKZPW/+gNWCRnZ1LO3Qw0HBoDrddhGqHhGVBTiIV2V0iCOYm?=
 =?us-ascii?Q?wKJMKQHIQSvHqYOP7Y9LKoc+dbTspCgOruZMZgoSM141PjOgI1chU0odbAhI?=
 =?us-ascii?Q?0tBvTveuocvJswnSxl823t0uxAqIr2DbQ61MCABH37NCH/vSMUZlCkfi5bV0?=
 =?us-ascii?Q?rTjmUiG4dF5cfNSjmxMb84Uw4PA8YFXbAzXofxtwf1NSibQXtX4Jj2ZVbguO?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56cf568-fe0c-493f-71eb-08de09f4d246
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 01:07:04.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jct9iEfXE2hZDKl2tXRz/RPX2dBO+/oN9DCmq0rvl6mGDTPamzAmo0yjozw/61V3VpSorEC8T/VN7x4vXrLnFbsnFENuXUdiGP8rZ9wN2js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5946

Add iommu property bindings to cadence hp-nfc and synopsis dw-axi-dmac. 

Add smmu node in Agilex5 dts with the iommu bindings added.

Khairul Anuar Romli (3):
  dt-bindings: mtd: cdns,hp-nfc: Add iommu property
  dt-bindings: dma: snps,dw-axi-dmac: Add iommu property
  arm64: dts: socfpga: agilex5: Add SMMU nodes

 .../bindings/dma/snps,dw-axi-dmac.yaml           |  3 +++
 .../devicetree/bindings/mtd/cdns,hp-nfc.yaml     |  3 +++
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi   | 16 ++++++++++++++++
 3 files changed, 22 insertions(+)

-- 
2.35.3


