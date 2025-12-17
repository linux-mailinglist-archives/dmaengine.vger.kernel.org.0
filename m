Return-Path: <dmaengine+bounces-7779-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B67CCC87E5
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0E1C30BA712
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F1366DBC;
	Wed, 17 Dec 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VIQUZDbH"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010020.outbound.protection.outlook.com [52.101.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005834575E;
	Wed, 17 Dec 2025 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984674; cv=fail; b=a1+fsQ6UwGisfNMpHUVEkm/ml7YC8s2kQRVNQFghLdAVIvexpKxQOp9aZoJnLzHCFWXQYh0mFg01FM+3kvD24LMNMs0ruj43lYB9YrBAFQpHbrb72K2Qc0siV3sA0Nae05HPB0itucJt36jTxX5m9bTBvNA7kIzdSW7Cwv8mCPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984674; c=relaxed/simple;
	bh=7y01TviDYCFP/OTuFTh5SMbzmrAUj1Yo4q84GVIFXEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJr7KsF6VPemPuniBd2H1Bd8ply+TJx+MBx/j0oe0i0boIz23ZfmPUvY3UUmeNLsq9GntPRJHTxcjMJP7fE/YjOOYkqXFIQFT+GBHZ+XHN0XL6js9M1YXfdYNFqnIEHMmAkaEoKwDrHXhPqzzozIfE+SRVyVK6b2l8tguHFLVIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VIQUZDbH; arc=fail smtp.client-ip=52.101.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs8RiZARyMTG+kRi+doNO2eRwL1gaDFteLwhrVwWvfPg5RdoJJdRP/hZH30KGY1jlcNbhtEPvNXMoThxxgXyt9t61cPKTx8Zh9qvUBBJD4c9BcNZ7ru4zyim893d0wzlbMGsLPozSbCSE7hjmhW9Hu8J8OpLMVKDH+lYwmQYzspYjgbZ9ZLs5UDWXn3vaxdRteHS8sylePNVfELSiQ7d9jqm0g9wHoimuP1nWEAoKkLZIP8E/br17lH3fm52LaZbcItlyArXh8lQD8LLVvd1VxAaUz0aoSREVwoKNmx1w2XL5Ir/Es6N31EiRoAE6yWr7ATrGLgY0Vg0o7R+XcAGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SZni+m8Up+trZkWVtYU2nXw/H2fvWLTQUnEPIEJoK4=;
 b=erM5b0AKHU98L9avorpzFFwDXJ0j8ByEtbscMHEyBJl1oo8qPXE1D8v5G2yoS27oDwcu+Q0MLTzZoNgjkXW1HX0LpzaR4G8jzH7mHpQ9djx2KLoR2IgF0O0Y543SJT6JLcOqK9Q5ug9XJtStW2P0G7eU+A5+ZKXuUbjg2eFdkdtfSx+MpHkOhwsdSWdquOJw4lrJvYus7iw+tS04bswMdRnd0hRkXltkyqr39bZjSjqSkGE2cNmXDAmBcxzqN3U7/fSfF3nNxb7qT5TQ30nb9biqMp6PqAY+RgyRuMHyVfmoEvh2y+/cgyqUr65TP0fUtPcEk96A1zZmX0hOiOtaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SZni+m8Up+trZkWVtYU2nXw/H2fvWLTQUnEPIEJoK4=;
 b=VIQUZDbHrJCtjUcHYM/Woz5pcwdaqib0z2MK9jSp1Iw/7RXAg8PfHlPhwdgHgaBbF9TmpyqRjZxr58BqLFfsj5unfHDm4c0eZXBisvD939KY/3dhB0eWPkgqAOsFj8o+xKhhsL61//oeu/CxGBdOE+nYMsb6nqR6G+rJ7qIW79Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:17:11 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:17:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 31/35] iommu: ipmmu-vmsa: Add support for reserved regions
Date: Thu, 18 Dec 2025 00:16:05 +0900
Message-ID: <20251217151609.3162665-32-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 284a47a9-9b9d-47cf-de99-08de3d7f4848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nac9WznWwmiJc7E7WItosXEzlJ6VpHy/93wnDsl/eaAGY5k4YNKYD1J7HTVg?=
 =?us-ascii?Q?mqnT8Kej/JOHj0bJOCYSyH8A4FFXyTud0BCh6hk8lo7AScZnpMsmlX4zO576?=
 =?us-ascii?Q?UQwQ6VJ+BSdLMb1dH5qtZpNFrutD6LzdekR+ETP8xItQeQMetImaKPJq6c+W?=
 =?us-ascii?Q?EoK7zkoy4mqx2esEQoFr//QkutA675Rx7U89QaXQQ+MCW9DQ1bMvH6Jh/1zb?=
 =?us-ascii?Q?aNnFr1G/2MfvMkRI/0+Q9S3i/SkImX+2O2F4fkyTmQxxOS8EcgyWfiZ+rCbi?=
 =?us-ascii?Q?xH9hU+EB/0IMq3HUvElTriP0DcGBkcFMDw4aK1KfGXpEMAewTx6cv66KsMSA?=
 =?us-ascii?Q?WQ/1Q45KT1CKlve9QYJTWxjopjvNQdzTj5gZbu6NHUB3buDX8XAMU/XIthOg?=
 =?us-ascii?Q?1cOJAmlruOGn0lexATjxEzsXVQCqEoVke4lLiarnFUcVBRUkcx0G/bECuXyT?=
 =?us-ascii?Q?YMqa7IcRrg3UEDlHnm3kPL9SBoghUUHMFvmGVbxnOTZfvelB6+Y0DKNzidFh?=
 =?us-ascii?Q?c6ReqSrdRIp7ECJTaIiDblhe9I9DZROP8vF5rdT7R94l0jdEEdfhkveRMEfw?=
 =?us-ascii?Q?yHHVeIozj0LNSCjHk2HaoGuZCct9dnF4PohcU1FSjV54ptsoXSzN6Ww5ajxm?=
 =?us-ascii?Q?B3ZziqjkAHES66pdkPjAzjwXyclHRE+I+GRnWqVJ4/knIPaF2Z+OsWKYRrYn?=
 =?us-ascii?Q?U/gltZPVqaG5S8/pq1EK44CWrt2g53dUVBlGvx5WvsA0u6C8aA7tNXUN20P5?=
 =?us-ascii?Q?7yBINTb/QjMnb07EhNYIi87GYcaOrxR3JnIuuhe0ctQSJq5j//W3l2v6Y5M6?=
 =?us-ascii?Q?ZM17KiPX1zTDMP7keTDKmGvmoH3hfDUV08xoOE2hRaH+AM0n9Ggn3ue1bl8v?=
 =?us-ascii?Q?NGAT1uJMAksZ/PsiXZ5wx+dm82TFiWI7HnmQ9nRme2SfMSloAi8QcTWreVcg?=
 =?us-ascii?Q?uJYJeFi8RHsTtqIQC42QyGllPb2WPYJ+mcaygas/C9mJHcwiIOqx6YvWb72Y?=
 =?us-ascii?Q?IT46XVyGisjdIDC81CtyRPx4kk11qW8ywTZN7tHScqSYtP1nv6cML7klyoMG?=
 =?us-ascii?Q?KvF5tNjgZG34xIKhHJxgq8vTxq73yAf8H5FfapC1VrR0t3N9g6HuS7PKkOTx?=
 =?us-ascii?Q?xXxGmNOVSyo9WbPZUJ/IFxD/gaMTxKd1urMb8njkME3AQv089kmpZ3Bbkr79?=
 =?us-ascii?Q?M/TGT/hXp+kUh6wOPJNHnx+XU9JgTbSw2llapWzQCORSihDO/znbHea1GdPL?=
 =?us-ascii?Q?jPNRzVGprjPvZfMNFYNG5xNhvByy8+FV8xQIz9Hu8K3b+/z6FqAU7Q4VOKmV?=
 =?us-ascii?Q?KceOy3JPE+qL1b0XbnCkDcD1UuP9nZyl/lPdFbdnEd5v1makzOy7g4UYFjlg?=
 =?us-ascii?Q?4RTrF1mFUN4F1wVtzPuXYLURRHhIu57EKnVY6VM4JXHQrLOPyorHd4tfKr13?=
 =?us-ascii?Q?jzXoQWElcDAch1wWiYqlu31Qd/1vMd+G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5mvRqMhtd0P/nVaZA5hdO0pncT+YtmFxxwt6BeHl75NM6qnGU2V2uNNMTI6Y?=
 =?us-ascii?Q?qqtm4SEtsSgbQCQQauuPELXmrxAz1Zc273ktlIx9S9+nVh6kHTPZJp4Etk30?=
 =?us-ascii?Q?Ey6XdN9T5HW/Ckw+QGKi7/4cZWsIeMf7icMEl1Y22bvlF8zYnf1bzvi9FE6h?=
 =?us-ascii?Q?+/jT8ewf/C5m9Bn+ZItCx5uBgTbN8r7TSHGxED42gbkg9bWebzlJ0joqLbJK?=
 =?us-ascii?Q?4NrT1gMsW7tpHbsXHn+icxQ/sM1vrcJ1OcRj79J3NDaLTkKSGTR7mKXpdzKs?=
 =?us-ascii?Q?/eBfgVv1NNiHh7RhjXCETBdLpJ+lE3DZLije4bPYBK0MXJyrfwYhw13vdXhd?=
 =?us-ascii?Q?IBegkftoHgSmjt2jCQ+99F+WjtRkA0PiVZ6F4Wh4QTL/et2e4+bZx7N/REwX?=
 =?us-ascii?Q?gd44NpXVTtzQXX5f6yGo1FgrgtSnciQYq12uNgM0neWSGTgNJiYbcWMuaCri?=
 =?us-ascii?Q?eMXeRkxnaAQp/6EHxgWrrmdCNcu8H8BLfV6SZqCj3GBVNANi2U5ZNI9SOcmG?=
 =?us-ascii?Q?k/Xfljb/JGaiPvAqQDtGNkQoJ/LFNOBzGqi9Jt6FwE5aG3Pm9IQIf7PV82yD?=
 =?us-ascii?Q?7cRU0hn1TYiofskpbU2BtrXo49Lpb7cji5Z+tnUrT7bYPVK+m+q+m14pET+e?=
 =?us-ascii?Q?ZsA0Nofgx7VtPPzGH7Y4ahXy+Oc+Hpfx9eDrY+uwBL14HgcuSBrbbF8AYrNQ?=
 =?us-ascii?Q?4KXzS02tvMMLumcnVB8HuTvhjncy3SNhU70Lg14h4PtcdiddTQG5FD0yvJJZ?=
 =?us-ascii?Q?h/WoLRGebnkGHgdFfQFgtAYA6rdtudSKFWtzMEWzzyp2seQPKQA8B7I0nIwd?=
 =?us-ascii?Q?5OBBt/Mqlgox0eNCednsJfmrVc6bEqygUmAMQ/Wb8NpqzyAJl3MrVwhmYOPm?=
 =?us-ascii?Q?Y4bhf6FzSKDxJvIGKC2rhICcXN7GpekryF1RpfrHnvJOY9fHT05KumDSPAU6?=
 =?us-ascii?Q?NUxMiOVNpPDSQoNEYMI7onYlaq26I86qVJgekTLo/lCLEWhhrKKdzxccRSKn?=
 =?us-ascii?Q?mzrMF8Ph8UQt9vXD37fHAxeqqSZnCETS3tclLcqM+A6AZrqPmTznc3rM8USl?=
 =?us-ascii?Q?7XOB7RleKOvTQuqRz44Ec3J1J2B1XyG4TYZ2E5oBSnpVXQKrhw1x4oh90nDh?=
 =?us-ascii?Q?qdps2mLyohalgx3ZakdbSpJmsSKzui90GVEFvEphSTyx8To/71FBf8j6+i9O?=
 =?us-ascii?Q?JlT/sBbe8RBvUVmcdwbYHXy8IFPJWom5B2peuLVSMIcWgNuA02JdtCyudd5+?=
 =?us-ascii?Q?oQr1bbrqeOGIFe50WwbHq6lUxkcxAt+FuwU3DsmeOauXls7s9T5RzHk+fE6H?=
 =?us-ascii?Q?CDVifsyTX38stxVQJuYW110BYiyyOegT3rYJ607tInjixlu2OZUIcmUIWwU/?=
 =?us-ascii?Q?NI+dKF/tDy+5qa+qleTqLM7M0f/707yrfiUv35syhzuya0f7rK9oWSzG4i2j?=
 =?us-ascii?Q?fKyjCOqkmKrGmyHKjedCc+Tu+gAwlYkI59LDl2w2cAenVGlvlG9/FNkVZ7uJ?=
 =?us-ascii?Q?UCcZbN+soY35LsMUnOVB8HDFWQ/530jVmAPJorj81oXzvf/VsfI3yh1cDhy0?=
 =?us-ascii?Q?A/ejjqT2Y3/ySwjHgODrK+3LLUxpnzGN3ktkpBH85hcKFFgXfunPkDm3OFGW?=
 =?us-ascii?Q?iJMTsFmNQOOsnzGyzgjElSE=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 284a47a9-9b9d-47cf-de99-08de3d7f4848
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:41.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyTtRFxlBaAqzHBxJdtk0b+yOKiayoyNVQzzQAcq+SNQBn6rndnOdQCf+Q5alYgGr/VdhB9OmT7Kb++X4igpJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Add support for reserved regions using iommu_dma_get_resv_regions().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 724d67ad5ef2..4a89d95db0f8 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
+#include "dma-iommu.h"
+
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 #include <asm/dma-iommu.h>
 #else
@@ -888,6 +890,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
 			? generic_device_group : generic_single_device_group,
 	.of_xlate = ipmmu_of_xlate,
+	.get_resv_regions = iommu_dma_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
 		.map_pages	= ipmmu_map,
-- 
2.51.0


