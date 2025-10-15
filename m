Return-Path: <dmaengine+bounces-6857-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51E3BDBE58
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 02:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D3D3C3CEF
	for <lists+dmaengine@lfdr.de>; Wed, 15 Oct 2025 00:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9855A1BD035;
	Wed, 15 Oct 2025 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GBU2bMK8"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC78156230;
	Wed, 15 Oct 2025 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487250; cv=fail; b=V+NliXMnbk8VBsGyfM6P6Zc/qCCofUHGzbigrG5JkRlvqnIY2ZFcDOpEMMXCjrWSSvED9ALCzdwatRr3KmUqjrdw3qJPWujqNqz/L93/IaugLhCrAhieVLzKGYi5A/zPkwI+Ks7dd0Tj86ZIWNS7RxloeWLH+Nwl3e8s6y8adQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487250; c=relaxed/simple;
	bh=5oNDDhVikm+Z8v47ipIQ20u8AYxoppyPWYIaZ4gCVBc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WE+FebPVAXYYGMXc5tSO1aeg9QTxM/t4IG6e7C66WQkxIH5Im7WWzHUBCtQtMW0oXuZjbP3Wv20UUjC+1on//vdMtIGRF0g2LH8nFqcq5RSDcL8xOPxwwacCAWdlm22d97JfNzuk3FncNnLL2O31EBmpxx64o3oYSj6m6URisMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GBU2bMK8; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFcU8DFwg8JNJrU3TR0lJQTN8uccKc5YRhP54eanAJL8xZ5YwhYS2CdzZvL37VBcZYpDdWmippkCvLyBFXRT1UnuME4Oo3AY6gTjL7GzUz2FSYsMkHMKif5KXfHja+OX6DwYaiNNrGDfYzJK0gfFTbqG6Rl+lBbip8xZi9GyjVh4OvThGX9sd85eZb7vZfokMHGRFqIc4kqGLTesA5p0PAqtjCLDkVXTwhwQeS9UyT2m4D93hNf2R2Joo39QFrqbr+C8kMLukI/ReWEXB3ya3wMvY5ZX306LiH0sLKgkutE6UxnQTGrR0L1xdYGzXCOP47n9veJ3xQiuRvsePLFxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlWYANzYDcEGg3U6IJro/d7DCnxZl6CBDhTkE5itUaA=;
 b=EZTHEMr4oHxbCxPXutjm+aF3cpnFVzh2Z8aVIHdKQjAdRTtTo6B1QqBYZPsFrMb/crybfAurIfH0RRanSJbW/TgczG/gIkqkqJ9h3oI46lRv15ncZjqqM93DvlSKbo1PNtm1JUkb3g0vEAtyEeSyFglE5bIT6Wh3m385GOjteOP3MKHCE/MGrhZP1wW9NXY+VQNWt8SrHmNZHz2sU4BPb4vhhivBf1wlFjQ758rqOukXmOfNjcRM/uoidzNLl0sHVuTdIR21721BTBW0Mv9lD2TGlwSwYPKCy2q3xS2iyYPxpgpAfaXRBj1RqRhKZ7SxUqdx1KIe5EYDjj+CGkCvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlWYANzYDcEGg3U6IJro/d7DCnxZl6CBDhTkE5itUaA=;
 b=GBU2bMK81o+KG7+eTV/M3Q2i229EYzyVPv1/jwvmwgToAwbVL/9fTaRxqTjOfAreo7ylch0s3Xp78BEueRfFDwMr43LyHBgjaPok+dUDBAn5ijQmE5CjJx4rgzjHlNm0bm8izxe2RWHBaTpmMWE/bHi3qBXumq3CugsLqFwfv9OF20wR8KNm5ilB3d3G0tXrUTDnvKJ6C8cKNMWXe6jDKgyBsKzee8dsTxrkKjz6NbZ/dRv1PosmluB3CEuGFgjSCZMaqePfL0JbRY3rtHHzhmIuk/DuxxAnJ1iPwCnwfHezeZVmRI1mG1s8iH0GJlixFGmxD+m+GhW3B0yKS2MB0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BN9PR03MB6041.namprd03.prod.outlook.com (2603:10b6:408:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Wed, 15 Oct
 2025 00:14:06 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 00:14:06 +0000
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
Subject: [PATCH 3/3] arm64: dts: socfpga: agilex5: Add SMMU nodes
Date: Wed, 15 Oct 2025 08:13:39 +0800
Message-Id: <166b08f5eede0a1124df938ecd7a031b67d829c3.1760486497.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f79140f-df41-4d40-3abd-08de0b7fc0b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBH3YtKPDd0mWm6zOnDKw4xsFqDs5L83UJnm5q8u1iQEqrA4v/9FX5KPAf7a?=
 =?us-ascii?Q?TG3Wt6p4lOuIJqcQK8A2ZEURBKaGvZ3aFKGAWvT7P2O7T5DSc5lLP1BPGsFw?=
 =?us-ascii?Q?KKHIniGLb9qIFvjpAjt9R+7kUaknXyjKMeiXZjB6tGwuX/QkOe3D0WCFLStt?=
 =?us-ascii?Q?OEDQSU3B1X9iW4u610vUzMZjVfBraDImY5TI9K9X8khUxq7lU0QMbCEcUi5U?=
 =?us-ascii?Q?E7XXI1hMHW2G2rpVjzxjvEnfLL2p7vkRtPMJD3Us1qv+/q9Ce5MDBMkXqvOh?=
 =?us-ascii?Q?En3t3b9p3IH0gfV3x/ZWkcPqrZJCP/p6+INb96HC8BxHotPxFmQXtAt8y5Ez?=
 =?us-ascii?Q?e54ODpo8CAEmq3WaDUWtZ6d7HWl4bqfY6RNw2RToJAcd10rXOgEsla9kua90?=
 =?us-ascii?Q?BVYYPsY8Ft/z3nxkvFUw0EHhIi9oqNX9L9/4/D9J8GbczMCZmLHKIUIwUt/a?=
 =?us-ascii?Q?QeVrlmfMSOuIEK4Mn15DbttQc0QHB6jEdktj1B3L83DndYKe7YH57Z1JSBwm?=
 =?us-ascii?Q?gl8Pv2tU8lAZUpkevgQR4yc6kHAgpwEXVOMCTxfSP8cAQPtzDhBDL+XOiAmy?=
 =?us-ascii?Q?9TG7Rk5aTDdpmxrg+RlswUGPsG2iQOt6r/FE3MBOl8kmXku0g2BTbXBGoMNI?=
 =?us-ascii?Q?pflmAUJloWmKok8CyRlGFVYa8jWGDVC0Uq4BqL2Ey5nTZF3Ogew9iD9SRaqz?=
 =?us-ascii?Q?F4F3f+pDJGHkG+MXEXCt2VhrgomQV/ygc7kzpg1YNprw5xDcZWrJK7fL4BnV?=
 =?us-ascii?Q?wXOd+CHh3dSMb0/pp9rDLQj5Qiqp7OrAtriercMbmyRcUmXS6KPDEzOIw/X6?=
 =?us-ascii?Q?UnohFi1ODEGJ7AFZ8UQ1xcDqC9VLDjwTQvKdSQPiGduzbQfMlEz0VBm9obkO?=
 =?us-ascii?Q?ALSuD2LBtkMDJJz5UUF/TzuBkWn9FUYJ/9wgweJtuqf2Tal1Hk2M5ZzM+DMM?=
 =?us-ascii?Q?fykFPQv59y3CZUF6IBatQGZN28+MbT7Z0bHbhcqg5wnnJa77LwiqP8jxO0Xv?=
 =?us-ascii?Q?i19xH4K55fKo1b/AUp96RcA8FOprtbg/f+jSprHWYtpAgSJIusHKteW6QeQR?=
 =?us-ascii?Q?rKArEYZe3edL60PmOzVSIsjHUfheO/vslEqQCBB5eZufLPvqMEEyVcVdfASA?=
 =?us-ascii?Q?47cuvY8Kgum2qrPlWoLCY3Vl4EWnf8eg30kE3w8Qr06RlnKl4oum3T0nYyt1?=
 =?us-ascii?Q?TR3g0bj05NURxwoJISmJm/qlzXRiPNrPqJBWwmvov40MyxINfqDT288PTRV5?=
 =?us-ascii?Q?wGjU6DynaVLhGKSeIvmMCNSTH+VOsovSNypQgmE1VuCW2ZXxFHomUtKGdKTh?=
 =?us-ascii?Q?FKohcl3lGJYZLJ4b4PA1OJ1JxxjlIJF6xrid3KeD5TEXYTiYEEugBVw1FaMr?=
 =?us-ascii?Q?2cIUBwYC0HDFpQwrtZSyEBKeeH2shbPUIYBUmreMRhYSFc2FH5gw0snFgxQf?=
 =?us-ascii?Q?FlKSqulViZ5/7KtYTk/QWsLmagIK1vzigRNKSCtbUG9ry1Pl4zl85WLsLVW5?=
 =?us-ascii?Q?AOzemmkHWuuG6kI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ThbF0A4IJgSpTxAoNs147jEGOQJEDhYCPtb+hIRlJvV/A+9X59ZptGHIf6cT?=
 =?us-ascii?Q?bf9+lND9S8rFzpFF8WpvCDrBejcYJA3H+Y9KCugXAF8OdPvjntZR6sgESDeO?=
 =?us-ascii?Q?mmgPycb17m5g5W2RANHaXYn3oEcqJno4Bn7rtdV3Cz64Mx8nSnrxtYfJOAwC?=
 =?us-ascii?Q?N77t0N3DOMjlYgoDCL9GzTjX7Zgdkxc0veA8XIGjyen3iLAZvn0dssDqvYB6?=
 =?us-ascii?Q?2C2O0CMz2ofZnrG6jdHUjeru228ODzss3+iUtFxiU32iUtqOTjWuoI/0e5+3?=
 =?us-ascii?Q?EhiMl6uP/bm1prDN0n2bvqbYBnLoX++K7wISiIs+dOzsDs6IW3fTOl9Tvn8G?=
 =?us-ascii?Q?+uyM/u7JMstlIYxgHZ2gegToxAgQtcpbU/c4I1xtQMGJTj+xGtq+DhJCxErL?=
 =?us-ascii?Q?LX5AsfKFShcI2QCmDLdb2RWIhTMkdU1/g5FBvH9ESpZh3ujodGnajGcP6H6H?=
 =?us-ascii?Q?lZCLSuODdTMhWjX9pTlLT4nQ3iPy8Bb6JFuEZARX8qpdyuqe9qiEB5bW9bfA?=
 =?us-ascii?Q?XEDyUQ+odtqYwtkfmwPh1pSmUsMsPWwk+gGBSNdm/Xnc7Cxtg+tIi9wNwUNs?=
 =?us-ascii?Q?gjy2MZhSw21PXAI2SQD2MnBHC5iCrMkYk++22rX3IGMybQ9skX0GlBaRCHC5?=
 =?us-ascii?Q?j4LG1j7x1V5SHlQtCy/O5WOWvdGkgMnk1A6ynyAmMQwQ1ekR1E126A8ESOnZ?=
 =?us-ascii?Q?mXQg5d1zORTstS0WoLo8Vqp0X7tzD2R6Pl/vw7V1O5BWYs21fW7fKbFtu1j5?=
 =?us-ascii?Q?zxpiFciDTXhLiuRNAEslDghREf5xvK5wIMwpxnJJ8ixLzRQIPPoiW4YGa+U7?=
 =?us-ascii?Q?NswFWrxKf+ViS+izom/R/j2i9BnN8aEMdueFmFfcybzgS9mpSrdqv0lTL1ra?=
 =?us-ascii?Q?RJlePWb1tyBYbkBu0E7Hnj+go3ucofg66TGA653Z7nB/Kv+PWQvuMAhd0f9P?=
 =?us-ascii?Q?adgdIoWW6KOF/hyT9EDKn33FWQ6JfIR2BDM7vGAKffvhehjtNxh5DmOJ8Ann?=
 =?us-ascii?Q?JqM3rybuEmEl22KGb3YanPQnK242qznK16Q75jhBiQUNNfXFhIWhM/uP0DvG?=
 =?us-ascii?Q?KOxa710nbKvo6iqUZA7QQPwEzzY2+2vPYh2VAIl8sEC6GsNoLwMwBz8bwmQF?=
 =?us-ascii?Q?yt8F1gzvjEU/Dxhyt9RArA/fLqJ98dJ6p4jiavz+PtqHwehSuRAjeE5E0GTF?=
 =?us-ascii?Q?TdWw5bthRkKPmo9/HWklF6MfKFh6l1Xzvb+ek3a1xYZiUEEfpN/yJtR/kpLI?=
 =?us-ascii?Q?8zcG8IuHT0cg83eEfbLO9SKH2kXUJDQ96bjQnUW1k+XQUbCD/0jHs2oJy1NN?=
 =?us-ascii?Q?UZsxgaz+fEflgmrd5duG3Jp8a0U3MFFXYFQeR5dFKulpvoQlMwdIb65cL/+s?=
 =?us-ascii?Q?0KRJhaGxsdTff+g0A6QuG1EWO2PoZpjxORAdpgrYDexXgyhnvoJuSe5zmuVq?=
 =?us-ascii?Q?mV1N++R42U7SxCQ8bha69AuPGrv9TjdrJRpiOC/+8zjxO/4Mm3NpuFL6VtmF?=
 =?us-ascii?Q?scdNZPCTEG/9Vur+KCCL/EZUj1ErhU3jd9XP9YhvYIvqG8Fycbis0DeOk8Le?=
 =?us-ascii?Q?qQ51qKXkR16YrYNrVw/daOb0pvhWK0YOxHJX2Q0V0C0JWwAjgerEjttVbl4n?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f79140f-df41-4d40-3abd-08de0b7fc0b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:14:06.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XG3d8rfu6uaQx7Jmd0cH5IRlH6Z++1GZSTVqKfvVYphOMU08F4BiYC9Yx+Rf3fJAwHbE6vh7tsl4Ue8Bi7AxHNZ7q07gvKqsaFd8uy6YFks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6041

Agilex5 includes an ARM SMMU v3 (System Memory Management Unit) to provide
address translation and memory protection for DMA-capable devices such as
PCIe, USB, and other peripherals.

This commit adds the SMMU node to the Agilex5 device tree with compatible
string "arm,smmu-v3", along with its register space and interrupts.

The SMMU is required to:
- Enable DMA address translation for devices that cannot directly access
  the full physical memory space.
- Provide isolation and memory protection by restricting device access
  to specific regions of memory, improving system security.
- Support virtualization use cases by enabling safe and isolated device
  passthrough to guest VMs.
- Align with ARM platform architecture requirements for IOMMU support.

By describing the SMMU in the device tree, the Linux IOMMU framework
can probe and initialize it during boot. Devices in the system can then
bind to the SMMU via the `iommus` property, enabling memory translation
and protection features as expected.

The following devices are updated to reference the SMMU:
- NAND controller
- DMA controller
- SPI controller

This change is a necessary step toward full enablement high-speed
peripherals on Agilex5.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v3:
	- Rewrite commit messages with detailed hardware descriptions.
Changes in v2:
	- Follow revision of the patch series from v1->v2.
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 04e99cd7e74b..a22cf6a211e2 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -272,6 +272,7 @@ nand: nand-controller@10b80000 {
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkmgr AGILEX5_NAND_NF_CLK>;
 			cdns,board-delay-ps = <4830>;
+			iommus = <&smmu 4>;
 			status = "disabled";
 		};
 
@@ -298,6 +299,7 @@ dmac0: dma-controller@10db0000 {
 			snps,block-size = <32767 32767 32767 32767>;
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
+			iommus = <&smmu 8>;
 		};
 
 		dmac1: dma-controller@10dc0000 {
@@ -315,6 +317,7 @@ dmac1: dma-controller@10dc0000 {
 			snps,block-size = <32767 32767 32767 32767>;
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
+			iommus = <&smmu 9>;
 		};
 
 		rst: rstmgr@10d11000 {
@@ -323,6 +326,18 @@ rst: rstmgr@10d11000 {
 			#reset-cells = <1>;
 		};
 
+		smmu: iommu@16000000 {
+			compatible = "arm,smmu-v3";
+			reg = <0x16000000 0x30000>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 132 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "eventq", "gerror", "priq";
+			dma-coherent;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
 		spi0: spi@10da4000 {
 			compatible = "snps,dw-apb-ssi";
 			reg = <0x10da4000 0x1000>;
@@ -423,6 +438,7 @@ usb0: usb@10b00000 {
 			phy-names = "usb2-phy";
 			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
+			iommus = <&smmu 6>;
 			clocks = <&clkmgr AGILEX5_USB2OTG_HCLK>;
 			clock-names = "otg";
 			status = "disabled";
-- 
2.35.3


