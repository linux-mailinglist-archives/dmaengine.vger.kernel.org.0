Return-Path: <dmaengine+bounces-8924-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C/dHbWnlGkRGQIAu9opvQ
	(envelope-from <dmaengine+bounces-8924-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:39:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFA714EAD5
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 973A5305C8FC
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B936F436;
	Tue, 17 Feb 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2qr8Wbr"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2536F429;
	Tue, 17 Feb 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349817; cv=fail; b=PZxpZAiZyc7FTTkN5HHwgCdEEELl+kEsRZk4TAEGHimkZAAhLo0Fnvo9yadSZ+mXmFIzHsEZESnuhWCajQemQ2WBQ/8defF3k5/+raOFwbwZqMYvYLmQazDLbw3EjgIHZrXx7kobg1eFPTKKulH+rtbRFFpL6kg0xuGlgfyJG0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349817; c=relaxed/simple;
	bh=aqYUbKVAuw0ZI5PxgMTfy26AYPwuRM323tUiwRAeMGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeI5QqRAFoRnmYyZ0AHMcOo3UfVZmegOUzpVWcD/x0C9C6j/guNaQ0VEszeks5vK4rn6v8N1LjEm6/D2o6kISSrGispKA9wAOE6R8ocEV/4ZOgGBIWbqU19mHxaazpQAZwfToFE9JARAPFGi+659r6WrM43/FGmdibHJZDVnowE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a2qr8Wbr; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prSwV4yvqid1pTCoXL2T4D21nsxEenopsYgSK2nA9EQwhs7gbQLByFP66pH/Kqy/JyWm7eE4ZAB7YW8+zf1NKgUH4vssbHZhho5qQ7i9wky+Ro8sBzoEKPFTMzclj2d5HPCnYIeiFS3y4yf2Ohlajd0FkhJnk6IXUh0rUjkcBT31rRL6Y3Zzv+hmEBMHfl2ASRst9lScC+lkFKOM5zjafTpYQvjbjqDfvkZDcRCPSSuyDd24wBLKrRaH7o5TVsfK5PGPToDnHcru0tH4DnKnUcEQAxCXsJRf1BEtieFKVoUPrB7DOhDYR5Jjgk0eB+mahMQMPye2IfW75QkV4jtC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFQd2Ev64x7D09kHnQdfgp78Oh22jqiNa3RblKctvRk=;
 b=grPF7CvunW0z3v2VO9E1aziv5Ixaq4g0H7o8IVzFqYsIeXra0vV/EmFeR/2P/qIfT6GdNWgwMcSPCV8Q8d918pN1c9zglHDfQubAYgPZjkqwt5ds2ZeS7A1ht83roS+OndDQE6wrFvk61GK0azbM4f+CFhDH3NS40woPSDUR29YwY/LdJxEiqaXogY27NA6kl7n94Ovxxf0HKbYznUpsbIE173W4Ask51Q47GoVHXDBZLT5qabYXeLBwXCZkujiLkfkqtPhS+HNvuDT4d6WMZ/16Aroju0IaFBLZa1gcHNXPVs3eDNZEnr5n4vzwgsw4veEqWh1JvYmPlWAVWbYCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFQd2Ev64x7D09kHnQdfgp78Oh22jqiNa3RblKctvRk=;
 b=a2qr8Wbr2jBHdj16Y2TKKc7aPJUnlJQPs47/Bqk1Ed8pMflumuwH/s+/ATwT9vZvCc8jYg5IZ+KIcHrgsSZiCY+OD0MvdnOlXElZe2xyO+EDw3x/pwL7yVL1eGEYWWS4IUCQpYV27+PjCARoiCHzRee1HdiUqNQzIyFw+LaCeJ0dk2a/2WbGOLblUY213Op0Nj+b9iv2tUMQrOIAeu2Jj5Ym2NETzwMz4jqOuV6jmWQOzu3GZ+0scqoxbkrWKgyCdHK5gAHHPq9si7pM0ZcfnwvjXnQaoCVx3R6sKNKXxMVYH/olXGSFS+tLHyGH1by3mi65lwpcFE+/kIp8R8qq1w==
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:36:48 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::10) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 17:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 17:36:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 09:36:28 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Feb 2026 09:36:27 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 09:36:24 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <p.zabel@pengutronix.de>, Akhil R
	<akhilrajeev@nvidia.com>
Subject: [PATCH 5/8] dmaengine: tegra: Support address width > 40 bits
Date: Tue, 17 Feb 2026 23:04:54 +0530
Message-ID: <20260217173457.18628-6-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217173457.18628-1-akhilrajeev@nvidia.com>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: c0008f1f-2f72-480c-88ef-08de6e4b1fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?douy/2z2iT2xqmcgfeLfhixEActiNihk++jaA09pU70T6Yo+3iS2QQfehJPb?=
 =?us-ascii?Q?1l2bxZXI1myK65WJHoMnFIsxEjdsyLTdjB3Xc1+DTN+oZ0+6dCQ++VHAiIyc?=
 =?us-ascii?Q?1Fh5pJFy2gC33oWf/cbV2ZQfPf9NBPFVzNWtMFOaHh0shbJhlncbDwjcqe19?=
 =?us-ascii?Q?NlRpxEbcAj60r+QHGWjo4KmG0bqfnyavwHQ74ICeyuZtYdwGqGEbd3HVVw+T?=
 =?us-ascii?Q?PLJc+BJ47mK3KUzjIloqUts5rOscxz2etZsmEo7nwaKz39vsYG6MfD8cc2Yw?=
 =?us-ascii?Q?ecso/tUv8nNr6D3eRD2OgTs7H8S43Vlo7g2Ak068tj/5QsSi3dRIuUVROHXt?=
 =?us-ascii?Q?Mmj7f7IPbdttevhLG+J/atSXMof3BzsKZnFxInogrjEtHjbpCYWD6fNLc2Um?=
 =?us-ascii?Q?VVW545g16QIIf8GVARO4R3UkHch++iYwqNxkFtvFy0mV/u2tDkSAan5/oK+I?=
 =?us-ascii?Q?ysxnLwnLElx6wEOv98wAt9f/beUdWVgdD1dhBWcFxmbXn9CvpfYsN8fg3W8A?=
 =?us-ascii?Q?w6og5XGv12X3NIeVTRoklJIMU/vil8IlEuNSKXQDeO5JkSwLpxGPwkZ4xUY4?=
 =?us-ascii?Q?+mafQM0YEWUjVZHY5YkhxE0LjNh7NFUw94+ujvlufqgdVx7bfMyaS0Cbl5ka?=
 =?us-ascii?Q?oMLGguwg3VYFOTBDXGQ9ObZT2o7AqdK9j8EveCXt5GIbXosYvvKzbPc9DqwE?=
 =?us-ascii?Q?ZEXqMBWi8z2AwloDcJkGo254+sifeDYidcn3iR8R0f8FIDVHqpr4XnBTxqWr?=
 =?us-ascii?Q?z9C/Lj61hW/8bqlejAI8K9Ic0N6pnQRJVsZjrkj2QKkHxox522BxsK2CaqkR?=
 =?us-ascii?Q?chxcMwHLJkLBD225fONflQ5QBHnnWMQVGaXOTQWNRP7/KOhHPhQMaXJidDcX?=
 =?us-ascii?Q?4ZwPRJyXdzD7KFaDJcRMAGGIxCRocuIETBWjGXnWFBoFXlUBgdlr+vFJQDTd?=
 =?us-ascii?Q?eN4zLxHkl2KXcbiDSzIfh+j9L9TQWYLnuSzaWHc/Sf9XjmB8UOg6u4OxVg/K?=
 =?us-ascii?Q?zDMmakGrF+Wer/qf5MTJhMCPKGqrsJ8aGKfAT/NSWh93Zw+7KMjHp8X15xfw?=
 =?us-ascii?Q?XaquMh8rBXkklS3sh2Ip5XurhlHnxJe/4GXJylGPLfJID1nZgtBNkuYbKFLh?=
 =?us-ascii?Q?1xNuFiP6mbGXfuJIgLlzGzp+Cd2MJacKNWvTQwlm2hjaJPyY9NnoHI8YXVgT?=
 =?us-ascii?Q?S2XziJBM/fBllfePOobBZ8223TxmEeLz52SanrgB5M0uZGV0XeeOd2CiRap8?=
 =?us-ascii?Q?nSVsf1rtneCpvKjLEn8ULwzJeQRogzjB31zqjfBhsfy5U7wDvWQOTWZwdIos?=
 =?us-ascii?Q?k/wGlTfR/oROwIod8opIXjC6VuQEWgSDWU5y+hOx+aro0O9aDmjvYt1LIcRH?=
 =?us-ascii?Q?TIphxpcpBh8IJ9TYiiC0yZAMcLbEte8jj8gcMvDCDdIGD2xPauwzG2gGtgJc?=
 =?us-ascii?Q?cqFX8vpM93TWuFZJReMi6zcwtQsm554rZtqWdfgsB1IURSmo/Ruu3VS9FJZt?=
 =?us-ascii?Q?AxTG3L/QL104IEBn1Mjrc03oU5gl+YHT724tuMKtQB7DALofc2tDB/pN1JyY?=
 =?us-ascii?Q?XuAjGtOweqqglToyc9QI7X2rIvprIwzXSgRtm1JDnPd4mdZ5a/GmG6ynQGRv?=
 =?us-ascii?Q?ft3GwW0vVYPjiglIZZe7kdxhc0smnICDAp/76GJ3JgOvgjQAqXjb7XCdLhNK?=
 =?us-ascii?Q?orgdCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0dVxRW7lbQh2WYNl8JwVWV8snVkXze8o4OVLxYk6OXZDU4YZGJ7Q/WvAeApeOZP5UPD3iebUlNs6E6bwCG6T4ALnsnCZEGuhfUk5R5oGalKVdcnDmY93sNsRZLZrL/Oqu7zRqRe+RI12yxg+rsD3+eH1iUZ2+n5CqcQJ0Vvi8ifPPdSTjLRstbvQ6hkMMJbKcNb+rRppVdsqjY8twQjfFxMxeKAbtWq8kdBm7QKtfsKY9kvaESTkLtrkEoMN+iU4SyhDbWiZucX3RXCEbiB7Qc7LCpUMAnNUuBzdlOgu2ahVhH9ZkXRU02OVVI2HfB0/28/c8ZukEUBixtsuZNB2eGju0FkXYOWeljY8gieoq36QVufBb8ZNI7u0o8o889EvZkggdgKl36GQwT344yiNzQaiworl6RsXb6DKDNiDp6sP1/ztb9jADZbYFYQwVe1n
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:36:46.3644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0008f1f-2f72-480c-88ef-08de6e4b1fa1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8924-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1EFA714EAD5
X-Rspamd-Action: no action

Tegra264 supports address width of 41 bits and has a separate register
to accommodate the high address. Add a device data property to specify
the number of address bits supported on a device and use that to
program the required registers.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 129 +++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 72701b543ceb..ce3b1dd52bb3 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -151,6 +151,7 @@ struct tegra_dma_channel;
  */
 struct tegra_dma_chip_data {
 	bool hw_support_pause;
+	unsigned int addr_bits;
 	unsigned int nr_channels;
 	unsigned int channel_reg_size;
 	unsigned int max_dma_count;
@@ -166,6 +167,8 @@ struct tegra_dma_channel_regs {
 	u32 src;
 	u32 dst;
 	u32 high_addr;
+	u32 src_high;
+	u32 dst_high;
 	u32 mc_seq;
 	u32 mmio_seq;
 	u32 wcount;
@@ -189,7 +192,8 @@ struct tegra_dma_sg_req {
 	u32 csr;
 	u32 src;
 	u32 dst;
-	u32 high_addr;
+	u32 src_high;
+	u32 dst_high;
 	u32 mc_seq;
 	u32 mmio_seq;
 	u32 wcount;
@@ -273,6 +277,41 @@ static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
 	return tdc->vc.chan.device->dev;
 }
 
+static void tegra_dma_program_addr(struct tegra_dma_channel *tdc,
+				   struct tegra_dma_sg_req *sg_req)
+{
+	tdc_write(tdc, tdc->regs->src, sg_req->src);
+	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
+
+	if (tdc->tdma->chip_data->addr_bits > 40) {
+		tdc_write(tdc, tdc->regs->src_high,
+			  sg_req->src_high);
+		tdc_write(tdc, tdc->regs->dst_high,
+			  sg_req->dst_high);
+	} else {
+		tdc_write(tdc, tdc->regs->high_addr,
+			  sg_req->src_high | sg_req->dst_high);
+	}
+}
+
+static void tegra_dma_configure_addr(struct tegra_dma_channel *tdc,
+				     struct tegra_dma_sg_req *sg_req,
+				phys_addr_t src, phys_addr_t dst)
+{
+	sg_req->src = lower_32_bits(src);
+	sg_req->dst = lower_32_bits(dst);
+
+	if (tdc->tdma->chip_data->addr_bits > 40) {
+		sg_req->src_high = upper_32_bits(src);
+		sg_req->dst_high = upper_32_bits(dst);
+	} else {
+		sg_req->src_high = FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR,
+					      upper_32_bits(src));
+		sg_req->dst_high = FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR,
+					      upper_32_bits(dst));
+	}
+}
+
 static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
 {
 	dev_dbg(tdc2dev(tdc), "DMA Channel %d name %s register dump:\n",
@@ -282,11 +321,22 @@ static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
 		tdc_read(tdc, tdc->regs->status),
 		tdc_read(tdc, tdc->regs->csre)
 	);
-	dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
-		tdc_read(tdc, tdc->regs->src),
-		tdc_read(tdc, tdc->regs->dst),
-		tdc_read(tdc, tdc->regs->high_addr)
-	);
+
+	if (tdc->tdma->chip_data->addr_bits > 40) {
+		dev_dbg(tdc2dev(tdc), "SRC %x SRC HI %x DST %x DST HI %x\n",
+			tdc_read(tdc, tdc->regs->src),
+			tdc_read(tdc, tdc->regs->src_high),
+			tdc_read(tdc, tdc->regs->dst),
+			tdc_read(tdc, tdc->regs->dst_high)
+		);
+	} else {
+		dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
+			tdc_read(tdc, tdc->regs->src),
+			tdc_read(tdc, tdc->regs->dst),
+			tdc_read(tdc, tdc->regs->high_addr)
+		);
+	}
+
 	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x WSTA %x\n",
 		tdc_read(tdc, tdc->regs->mc_seq),
 		tdc_read(tdc, tdc->regs->mmio_seq),
@@ -490,9 +540,7 @@ static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
 	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
 
 	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
-	tdc_write(tdc, tdc->regs->src, sg_req->src);
-	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
-	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
+	tegra_dma_program_addr(tdc, sg_req);
 
 	/* Start DMA */
 	tdc_write(tdc, tdc->regs->csr,
@@ -520,11 +568,9 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc)
 
 	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
 
+	tegra_dma_program_addr(tdc, sg_req);
 	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
 	tdc_write(tdc, tdc->regs->csr, 0);
-	tdc_write(tdc, tdc->regs->src, sg_req->src);
-	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
-	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
 	tdc_write(tdc, tdc->regs->fixed_pattern, sg_req->fixed_pattern);
 	tdc_write(tdc, tdc->regs->mmio_seq, sg_req->mmio_seq);
 	tdc_write(tdc, tdc->regs->mc_seq, sg_req->mc_seq);
@@ -829,7 +875,7 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
 
 static int get_transfer_param(struct tegra_dma_channel *tdc,
 			      enum dma_transfer_direction direction,
-			      u32 *apb_addr,
+			      dma_addr_t *apb_addr,
 			      u32 *mmio_seq,
 			      u32 *csr,
 			      unsigned int *burst_size,
@@ -908,10 +954,7 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
 	dma_desc->sg_count = 1;
 	sg_req = dma_desc->sg_req;
 
-	sg_req[0].src = 0;
-	sg_req[0].dst = dest;
-	sg_req[0].high_addr =
-			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
+	tegra_dma_configure_addr(tdc, &sg_req[0], 0, dest);
 	sg_req[0].fixed_pattern = value;
 	/* Word count reg takes value as (N +1) words */
 	sg_req[0].wcount = ((len - 4) >> 2);
@@ -977,12 +1020,7 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
 	dma_desc->sg_count = 1;
 	sg_req = dma_desc->sg_req;
 
-	sg_req[0].src = src;
-	sg_req[0].dst = dest;
-	sg_req[0].high_addr =
-		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
-	sg_req[0].high_addr |=
-		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
+	tegra_dma_configure_addr(tdc, &sg_req[0], src, dest);
 	/* Word count reg takes value as (N +1) words */
 	sg_req[0].wcount = ((len - 4) >> 2);
 	sg_req[0].csr = csr;
@@ -1002,7 +1040,8 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
 	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
-	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
+	u32 csr, mc_seq, mmio_seq = 0;
+	dma_addr_t apb_ptr = 0;
 	struct tegra_dma_sg_req *sg_req;
 	struct tegra_dma_desc *dma_desc;
 	struct scatterlist *sg;
@@ -1087,17 +1126,10 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
 		dma_desc->bytes_req += len;
 
-		if (direction == DMA_MEM_TO_DEV) {
-			sg_req[i].src = mem;
-			sg_req[i].dst = apb_ptr;
-			sg_req[i].high_addr =
-				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
-		} else if (direction == DMA_DEV_TO_MEM) {
-			sg_req[i].src = apb_ptr;
-			sg_req[i].dst = mem;
-			sg_req[i].high_addr =
-				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
-		}
+		if (direction == DMA_MEM_TO_DEV)
+			tegra_dma_configure_addr(tdc, &sg_req[i], mem, apb_ptr);
+		else if (direction == DMA_DEV_TO_MEM)
+			tegra_dma_configure_addr(tdc, &sg_req[i], apb_ptr, mem);
 
 		/*
 		 * Word count register takes input in words. Writing a value
@@ -1120,7 +1152,8 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 			  unsigned long flags)
 {
 	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
-	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
+	u32 csr, mc_seq, mmio_seq = 0, burst_size;
+	dma_addr_t apb_ptr = 0;
 	unsigned int max_dma_count, len, period_count, i;
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	struct tegra_dma_desc *dma_desc;
@@ -1209,17 +1242,10 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 	/* Split transfer equal to period size */
 	for (i = 0; i < period_count; i++) {
 		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
-		if (direction == DMA_MEM_TO_DEV) {
-			sg_req[i].src = mem;
-			sg_req[i].dst = apb_ptr;
-			sg_req[i].high_addr =
-				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
-		} else if (direction == DMA_DEV_TO_MEM) {
-			sg_req[i].src = apb_ptr;
-			sg_req[i].dst = mem;
-			sg_req[i].high_addr =
-				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
-		}
+		if (direction == DMA_MEM_TO_DEV)
+			tegra_dma_configure_addr(tdc, &sg_req[i], mem, apb_ptr);
+		else if (direction == DMA_DEV_TO_MEM)
+			tegra_dma_configure_addr(tdc, &sg_req[i], apb_ptr, mem);
 		/*
 		 * Word count register takes input in words. Writing a value
 		 * of N into word count register means a req of (N+1) words.
@@ -1317,6 +1343,7 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
 
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 	.nr_channels = 32,
+	.addr_bits = 40,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = false,
@@ -1326,6 +1353,7 @@ static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 
 static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 	.nr_channels = 32,
+	.addr_bits = 40,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1335,6 +1363,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 
 static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.nr_channels = 32,
+	.addr_bits = 41,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1446,6 +1475,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc->stream_id = stream_id;
 	}
 
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set DMA mask: %d\n", ret);
+		return ret;
+	}
+
 	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
 	dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
-- 
2.50.1


