Return-Path: <dmaengine+bounces-5490-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D47ADB42C
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 16:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555C6172B95
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A189A20A5F5;
	Mon, 16 Jun 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="BNJZ1JWv"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B6205E02;
	Mon, 16 Jun 2025 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084903; cv=fail; b=lqBTulke1gH6Z54eEHFlX+pRNWDnOMa9/rDR+hUxDc9wfo4/vTBcOAZ3VvdZ/L/A9ZRI7zbmBuY7vGNQyU7Iy2P1CMzRLp28ZXbI1Lq9KTvw83VQwyzp8GlN0KmEHFGVChNXbsDLYKOzlEcpPbtidOrsVYnLOmNJiZ2wS4VPOVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084903; c=relaxed/simple;
	bh=P5QxfpH2SQ+ePckOIQlHN7L7hlG8TNV61wy2gFvvv9U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bwQr89Fht25xQCutrUA3szMIBHQjojnkPvUE/zBjbCDBc0I4LgWTakF0zkbNpHAjeh75iyTp8wDRbt805JSlCV07DLAljwWcSKsSD3jKTkZ2C99dUWCtHLq0KfnzJWEVW8hPvsFOaZyfc79QuF8lFdwxM7IyIn+tggxySRVybeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=BNJZ1JWv; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd7yYJgJOae+huGHGR9SIpTqd916wRY3s8YQXVx86A+jJXkdTUMMBslo95OwnX/2l7sg6kkzaX+KMgD+ghQsyBu4bPaOfnMdZy9gNzM9kCKgK3dOz4DvZbQghtnRL8VotNtd+eDF8npb+VmY1vWXhkCImHM61LmJNOL7MPD5FAKt6PgpPOcHKtA5WQ+yrN58fx1dERWVrTh8noEQyvZYK4e2I5SodsybdxqjlVA0LFm+N+r3Hr+L1cTBj/+h4sYwXBB0SLVU/s2w52rW0BXqlOWLSRIrwr8+Zmc26pL3XXyJzQsp5JZO9EjCB8k31P1QXNrdH7mvRiFnqRpzeNnxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhzFchYlmskrjVTiNBecvi/jdO6brkxTwOA+MCsj5+Y=;
 b=J6F8B0FtyTzt+Q92jdxNHOE5TivA/7ntNUA4TSIzm1a8M9VdUR7hEKnxShEUBi+gAi+KX9cqkFMdcRBbgRVKUm+liAGhJkpUbMU2g6y1u7etWAb9/khGzmzRq0NaTBV795rgxyKSL6Jv46UVIveYz3t0Ys5zAWhF9UEPIblMEkrBhAvbQuRIVHIxN0e/U40i1imi1TbjSLZPOAHvXzgqQ4p8LfHmTQoiRqZ5Yya7cUJsRb8dvDf2/VOoNFOVlHY+OBOlyDplhLNh33afq+kF/uXMa46nNbDD5graO27BR3y2wBupUrzSun8uQOergQ+H0LCfqvjK+LYc1KwNlwd7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhzFchYlmskrjVTiNBecvi/jdO6brkxTwOA+MCsj5+Y=;
 b=BNJZ1JWvfOIKfIe+YoiiWyylDsqxPWz6YMFzIfyhqxLB9rKUrrWPQ5Y6aGzn2YHSKdWfgX4GuMegqiLvrTdHYM36H4WsBfpw2LU8aDuYzUx1haFGflQhiMSiWIkwgEbjtKdqX/07f3WWjQGUKLdGmlY+pcOZOeSeH57reHAwoIb9nZuYwS9mTcnMPfnAm+2JBLlbrwfHFc+5d0dP05O2sTF0CfrQxI4L3VhUQhI4T1Zedun6Ciq6GomOK3Hz6HPlQmpN2gbB3Q9djqNHHq5VvN6GqNH5saAEI57LDENFl5/dDzoiYlPlA5jhClZggDUzs1u2XAUWxr+6Tucri3yJkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 14:41:39 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 14:41:38 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH v3 0/4] agilex5: Update agilex5 device tree and device tree bindings
Date: Mon, 16 Jun 2025 22:40:44 +0800
Message-ID: <cover.1750084527.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: a30ebbd4-8229-4f19-f62d-08ddace3e6ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NXsH2kuuMeW+Ndpw79pCnFpHX/IQlbL7ZJYLi+WBHVSZrNFvQ6T00s3UQ6K5?=
 =?us-ascii?Q?AuEUE3VEEx3yWwmdYCdxtrnQwKVlzh2USD1nsj9oKC+8/vs8nxUL6TS3sCOl?=
 =?us-ascii?Q?6UZtLs7sXLxGTD1vdCEA3GVKJ3CC34SGMmz2QmLXk1rzQDfDFfAnlbfbox44?=
 =?us-ascii?Q?o66DUR5JdfAHcLdcIDB0DXf/MHXbBAr3NJS2IR9RHuZPhjhGM3cczQHqGxii?=
 =?us-ascii?Q?KWAkspJytpNLQ71f9jMKvqAnYgGdXHD6ja00vrqygkHLDBiMtXg+MNAu9Dwr?=
 =?us-ascii?Q?6daCXxOBAUiQU0suJFfOh4KNz9LwGZVBLBffqWgntDJxCZSaSreJo9oVPl8K?=
 =?us-ascii?Q?8pRjv7JUHOdWPkl896X8Qx9i6T3tqS4Je+95d+NUBlQWz7+3sAa5KYjXCrm9?=
 =?us-ascii?Q?KJ6TiieEPHGvYyzyKsvHJwKDffeGu8ag5iHudNgXgXzMwPqt/w7AXNh3PJA/?=
 =?us-ascii?Q?sv+nyiVVOcYhN1AHIVz5QZOFFy4mISyQ5+CXrNMWRP2HwRpnm8gxsB6MkBEC?=
 =?us-ascii?Q?8XQxBZm4jswo0/YUBWe4DSggKccQp21ByKkou8981R5e4iaoOQEQrkw5l+QY?=
 =?us-ascii?Q?pDtlaryg12CvfOEYA6akar54cKhJ+37PrQPtJFOnPBI++clKjf25es2yq1r/?=
 =?us-ascii?Q?2KcnrZYYT8IpsLBHArsy/g2kuTJzOcAXScgzNeierrYoXoilh2rZywOWbZSF?=
 =?us-ascii?Q?454GiFxwhFZF6vzG0VSUqLTWvEa0CnO9Nn9rmV4Ily1u+5Ig6vROyysfF98+?=
 =?us-ascii?Q?is1DdjzhMfgZGwKF9hrbZDH0SIedPgZtHIM6/9OxFnGRKqenuz+fQoccVDS6?=
 =?us-ascii?Q?pym0KrQzXfuDbhjbjhbHgKMwOdWttnJrmNQYyUxSiqQS3pg7DTOWzTsXhp+I?=
 =?us-ascii?Q?HiXTCALPaZuYKm/Jg9c5uLIL+g4c1hn7NEhbR7nemhXfYQY6K4crjP1YgAm7?=
 =?us-ascii?Q?nlLj8VnzNTiDAGqsUIedpUMdtmo2oNP8ks5uPlrO+KTxsOmCrgqUs4t1X9t4?=
 =?us-ascii?Q?U7HiTDCG7NrVD46WQpuH0+0aTqjo1dGbDZEz/dbbpQl86dSPOi21caUqtCxp?=
 =?us-ascii?Q?WMvbR2yi6IhxVqzASRggGGpljL/LjRTuID37upW2hWu9C4Ebgdoqi4raZqQH?=
 =?us-ascii?Q?+mPPhq2ckf3dMI31Li14sVqrg8reQq8EHRuMrxkYQZzYGke0RbZ7zKffGwBR?=
 =?us-ascii?Q?qmh55KWfqOQWBgG5o+ACifPHii+UCdSMg1ERCYTTzOwriWGrv1RlrkdtVYu/?=
 =?us-ascii?Q?BoH9Enq2pM91+7stkS+hC4hXv/IuGMWO3qi6gln3NL4bsfIuG8EwTZ3gJ9Ag?=
 =?us-ascii?Q?2iU8eGvoE+FlvNd/ZZ1ZwSvg2cRlpfkJcYR52b7t2n6Su/lRUt5ku6uamKox?=
 =?us-ascii?Q?rUBXSnquICaHVAJ970liT+P85W45LZlynjsOiFuIU9gxYdSECEKT30sBdakp?=
 =?us-ascii?Q?3A/ocdaR4Es=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PlnaAandGKIoWdJUi9vsSBSv3PhHRBYNB02IOFQBHRk/CS2ucufUyI/BeMwP?=
 =?us-ascii?Q?JTFZuLWAH3KTtkgbalVPUuEzlLmg67RsYJKH74odsOtlVk6iwwV/Ksdz6IC1?=
 =?us-ascii?Q?mmpTMGeXhj/WDprxEu/m5G46OoecLTuwOoJenhhwo+WpnmZh7Ux4h5FHLNpk?=
 =?us-ascii?Q?hEhvVBK36U2eOer11l+X7/9V1pyQ91iy8ZmUBrc2bWNL8ZwFDJpbAtU7fXxs?=
 =?us-ascii?Q?LpNuoATfh17ak4ZPT+R+4t2qa9F2as036E76naTBOsnIhxLamwLY7thCmrOj?=
 =?us-ascii?Q?/FzGLz9hbTHtG7qaYMYHLxLcSJ9gRnqok5sn9zKbuZiSCppnkWR9pyc6ZEfk?=
 =?us-ascii?Q?D328T+CUzYgZySODFrkBhQmUTC4hro/FKVRGJZtMn3F/iT1UZFOZLco9X4r1?=
 =?us-ascii?Q?q9oEaloiBi8mi9dqC1yK7eNOcm1pMC51Y7in1777OL769MFkk0bpuuSvV7ZI?=
 =?us-ascii?Q?QHuCcCkoa9B7Uv47+JwV/eS9apxRYd2xUweBhnHQy5GKpDdJzDOrCir97i7y?=
 =?us-ascii?Q?bZX7kvmrBfJKQzXrnCqi6tMoIXb5TuHHWE5Gw1LiGVW+bq2dCKNifKhVIJOJ?=
 =?us-ascii?Q?ZGkVU3nzcEqf98SpSm4rx/hNf/UNU970kFiYIng1F+Qmx8rOwkq42zedIWeS?=
 =?us-ascii?Q?vjRxGZ9UD8GbYDdUOE2mAoPFze5poHC/Cql7rgE59RjofwjcuC7gZ1Bjy8Pi?=
 =?us-ascii?Q?fM4YxkEgCKhw+l1SOsYq24zQMsZSCgjZ3ZSKMIfIrUWVzI7VZtu5p2LBu0Sq?=
 =?us-ascii?Q?J8AwUSedrKdXdLfDZywDEXXx6EXbcmIZHCUzKBM+9vIfLzbTCS6OeAPPOZ7T?=
 =?us-ascii?Q?xlSjthgQgXMGAXgW/QkDztMRom4+QN+eTfl2RED3sGUvC4ELAjrydejt63bk?=
 =?us-ascii?Q?JTe8OWo/P2EPhCEe87cmmZg7H/WRc25AsXgrRq7Pkw1PVdHinsJmeB98lGP3?=
 =?us-ascii?Q?avfhwW/rvZgT88jyGcW1dQDHHvG4qQh1WaUBgbfJdnCFby723f47FvePtDwD?=
 =?us-ascii?Q?RdWLsbyJxL6YJZui9H78QbPdHZuOqDGWWVDkw/0pD9LNAswLMuWy5MVrtXaE?=
 =?us-ascii?Q?YUNSkmvlS1JGwzh6ubqTGcHOWA2YnkaHW6u+a7tiQSn/Afo3kbCLhWgRtXD7?=
 =?us-ascii?Q?qKmmSYz+BBZ0hQyTWHe0sYww1gvIT+fXs4HNIZXdWdN/r24jpZg4nn38b9Of?=
 =?us-ascii?Q?2i5I/vVoRIV6ltq0HomfwA45+gmZ508dZ9ckiDVElcYIyAV2nj6ABFXdgli7?=
 =?us-ascii?Q?MJo/U9NJqgUi5nmP1rdnB1rNMfRJlicpfzdvqtZ4rOXPOKA3/uiqtob3g/Qt?=
 =?us-ascii?Q?+reI1sRrS0jPv1egAxaNcDjYrQZPhtTuNQnwPjeOX60JnXNEU9LJgSTTY/Zc?=
 =?us-ascii?Q?V10hW2FyW9r9t78iLULik4lNHawpGuRT0JKRpmMWR41bbZkKzleJPjfzgOWW?=
 =?us-ascii?Q?VWtzYhQN1MUOx3PmYlLsPq3nQAYOS+7iC6L+4/sDgRFI4H04mcqXV4P3X6PO?=
 =?us-ascii?Q?bwjTxNtM2307LAXod0uyaDrR0FsErLA38MsrLEoLyYqDihQV/RIMRxUwBGlU?=
 =?us-ascii?Q?1fej93g6BRup9W0z1KCrFwU1uns3iIrFyk6iLirC1mnvFpCnjXe16KclTS1G?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30ebbd4-8229-4f19-f62d-08ddace3e6ca
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:41:38.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwzBoLToHod2HdgW4QmStoxOYB6yN2bbO5islElR8tk+YSZ2gVMvjcQeRfTE0SNEr4Wj0241sTS4voW2DGjjG5ShdUDQ7iXNooANLoRNUwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

This patch set is to update Agilex5 device tree and the related device
tree bindings.
Altera Agilex5 address bus only supports up to 40 bits. This patch set
adds support for a new property that is used to configure the
dma-bit-mask if its present in the device tree

This patch set includes the following changes:
-Add property for dw-axi-dmac that configures the dma-bit-mask to the
required bits.
-Update cdns nand dt binding with iommus and dma-coherent as an optional
property.
-Update Agilex5 dtsi and dts.
-Add implementation to set dma bit-mask to value configured in dma
bit-mask quirk if present.

v3:
-update commit description.
-update property naming to match property description.
-removed text description for default value and add as default property.
-update property name in dtsi.
-update dw-axi-dmac-platform to read updated property name.

v2:
-Fixed build errors and warnings in dw-axi-dmac.

Adrian Ng Ho Yin (4):
  dt-bindings: dma: snps,dw-axi-dmac: Add iommus dma-coherent and
    dma-addressable-bits property
  dt-bindings: mtd: cadence: Add iommus and dma-coherent properties
  arm64: dts: socfpga: agilex5: Update Agilex5 DTSI and DTS
  dma: dw-axi-dmac: Add support for dma-bit-mask property

 .../bindings/dma/snps,dw-axi-dmac.yaml        | 12 ++++++++++
 .../devicetree/bindings/mtd/cdns,hp-nfc.yaml  |  5 +++++
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 22 +++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  4 ++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 14 ++++++++++--
 5 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.49.GIT


