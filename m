Return-Path: <dmaengine+bounces-8923-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPxPF5WnlGkRGQIAu9opvQ
	(envelope-from <dmaengine+bounces-8923-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:38:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5CE14EAB6
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E973020022
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3C371040;
	Tue, 17 Feb 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GsoMnu7y"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5330036EA9E;
	Tue, 17 Feb 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349802; cv=fail; b=YCcLL+jZPf8nu8ID+h5EZlOgKwp4QREPKF3UXpLtrb8yN0xE97Oe/Yz3M/TeDEk7xl8NULXYDCZksL/De93LdjjDQoumdivP1LgAMa01PyJAemjkjqv0TAdem8kI9jOF8qRGHSg7liZkUwyJNkG2sw51d5qYPKZgSVk4mrUjvoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349802; c=relaxed/simple;
	bh=JhzGtl8jwoYGquOyl+/GitjrT4NreVmoAZp8s9/7GJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hlr9W/27FERO25Ei/4ldUhYRAECdY9vhtsKqTklmmgT8jOpxitQpxsqhcqCvKABLQ4+748svLBBOb8MdbkY28XsZDRfpFer41hqheN13MyC+2sXn+nWiTIRY9ACuVaIeEgsXI/mDH830xKmqotVR9MC027Wzt6HHTHvYZRpoXVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GsoMnu7y; arc=fail smtp.client-ip=40.93.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKUBZSxYFL8k67zar+Fp26RiFaP2Zy6Xucw9j+QJ9OWmAoaK/fbYp6lpgKl3B85xhsCoGKbSKkOC7gxEV9EFox84+GZEHHWn8rIOAqC2Zr6M5K91T+VS5Al+1gSdWINfEOQ9J3J2wsXV7ciXIh4n1Rlc75QTLzVwDhQh5iBqYfNJxgB8aCPq4CCxH0+6psW98+vuj3ks0DFTmDT8Qy6bn7wuOxJIj29z3fq+T1PTWXLJdZKI6Y6xsgxryc0kfhd7yfXCMN9tFE8EekaFJQGBkGWx86nrurFRZ00Qyv6tZw6Vvbzm5x0dPW8XRRWhIfVLQXQX0TQ05TQPzYnfGjaymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mfgGmbywXr5P++ughYan1cbFFjyUS6TLwcxnpbgg4s=;
 b=rPbmWU2aE3ZslH2qoh9yf+DTa4O87WsB/gPxD6t0iDI+lkzuGJQ/RzIPhNvbKuBJKAR/Y0sEvQps915+sCFTCa4pe5Q0AImu2W8Cj2Bk0UTdh4+tyxhntj+tqObMNO8E184zjgxRLAyPlTGDJ5m0IpcFore3uzVhYRAQXSqOOs+FOwcZvXOa/lj2zu7dWc1CqBaw6kRW7o55w52Wm7iq3oP15M7o7ouUfP3I5uWcGMuzNiauSXNLq/zIzv7dKDODhk3M2wxfYTQ0pCJseM3d7nfUkLo8INX/sOZcN9WFxbViG8JMRbUJaNWl/hFf4iwSySkS2M0LpNLn9gcwZu3Exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mfgGmbywXr5P++ughYan1cbFFjyUS6TLwcxnpbgg4s=;
 b=GsoMnu7yRmnU8OkxLwtvH6VymXoNwIETKbXCqvUQ8kdX541rEs7Sh9mrwjJOJNtUVc2A2649zfdMm2l0IPEKSiWh+raxc1Hl+SiGJ/S/qUiGr9zsxce6m/FcqNKSd3jGnvKh8MmyD8BI/MPbCM0QgYe8JquO9J9DPbTy4XlZBpQXMy1NyDcWbWS3U61WLOrH+/bugOxx1k/gKCdF0pRREcHVSVBbE8GJnO/isdSJLL0mdvXC1O1Yy71J31tf3ilweG4pNgLlMoakM29vHzT6DBv/87XsrkrOvzITL7AQImhWpTi2iMiRtmpWNg7YnXBXcjxTp2+940AMre4i/DyE+g==
Received: from SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 17:36:26 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6f) by SJ0PR13CA0030.outlook.office365.com
 (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 17:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 17:36:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 09:36:14 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Feb 2026 09:36:13 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 09:36:10 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <p.zabel@pengutronix.de>, Akhil R
	<akhilrajeev@nvidia.com>
Subject: [PATCH 4/8] dmaengine: tegra: Use struct for register offsets
Date: Tue, 17 Feb 2026 23:04:53 +0530
Message-ID: <20260217173457.18628-5-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: a91b4b8a-9f10-4ef3-a6a7-08de6e4b13a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gTK75lEPA0VAxhEiUzznQwlXSAMIaFGst63/NNwTFbc3PFfD1NOPk+vPykM5?=
 =?us-ascii?Q?G1e8zM2kd0uy254vqjbQRnEvfQvFr19FpImqRwCaQlY9DRzsP6QuFsqr8jId?=
 =?us-ascii?Q?dUSCzH8JPiOM/c6lT6L2FO2bZBuqRYFJVVW/xlNUHYarWCPQtYYwklj9J6dV?=
 =?us-ascii?Q?8SJ94TqICAbPpEpPfeePdHPZ2+8DcsuEabWj5+bCr8WZjxJW9JPJ5ofiRnWX?=
 =?us-ascii?Q?liQBtiA3fT1S84bMYljKB0NVvVuk4hHKizX/ybzl9pILYE6XqIquwx/stO3k?=
 =?us-ascii?Q?4Z/wQX606CDslwGs6Pd/Rc/AWonipAzT3wM0+JkNcbwvTl7E6Pi1EcX8GT6P?=
 =?us-ascii?Q?l0doEQTfijwZid5aPhIsI4cOTePsj8aLJCT1fSG7c/k+2XEKwDvUTOgsqW0K?=
 =?us-ascii?Q?/J+IJQ7r++FdL3OXFacpNPtreOIEe+GkzYBM/+bUIurG4rs4Ncyx7pjLJw3+?=
 =?us-ascii?Q?/aD+Nvixv6Xf3nAa5NOfhDlNc+aCoXYv0+7mr3X6rnAB/hGU5y+9Rqny7j8g?=
 =?us-ascii?Q?ws6dOidax9zZZ21rQJQ8P+PDssKwPhBRCf40k0U0+qh721/m9aSBRnYE8u+x?=
 =?us-ascii?Q?akRifvSF6BaRRRLPcXTpZiuHBOX/8KYI1ZUxNDwOY99QyXpUsqHC93FTParh?=
 =?us-ascii?Q?RoWBvDr5oQyUGHhni+FZYPtW+CcA4ePf/FsPLk1l2KA9lY015SXpmtz5iHX7?=
 =?us-ascii?Q?WrodcxDf5T/3+/NOwUNX2z1mZ2d/KtxL03dr6JpklXv83lVcquZ5FRxorvWJ?=
 =?us-ascii?Q?NNjttzinoJlc1xNFGW0cG0JUERFE7sm6OwomQtxhpQsgXfs4IUPP7phzhKlE?=
 =?us-ascii?Q?8YyEOMT4VoyJu0+tip0janKgs7gHQySNANseqTEEaTMWoD6esHPbSFWAinjk?=
 =?us-ascii?Q?ylaGWL4F6GADR35vsB9t0TJ8GxFT2JgSfQoTJsGD+LTBZ5Qu5+EcUuIUQYxN?=
 =?us-ascii?Q?n/00YXOzlDTfqQaD1TABume8Vfnk+SC4qGhFbriQ1Q+4ByAcnJERyQLvZ+uo?=
 =?us-ascii?Q?II03WTxHf+X8UGMcmMvPtZ7mvyNTPyLQrlJ7zA1Zdd25Pt+WB9fzZ6/5FOwd?=
 =?us-ascii?Q?BV+6XKsrT9ACG+sFObqgRzo2/tH5YSliGrKxU2jWLzKOtJ6IsxbfradF8WMX?=
 =?us-ascii?Q?iqmHioJvFNtaTm+upcNk9UGBEf3qKYRq1idg/Z9SBnjs4V3REikcOB6Jwh77?=
 =?us-ascii?Q?MzTeJGbi10dUIa8ugx1nMNJRfDjerpRjQS5VIuLS/DP+h+FZjUt69ohIwR8A?=
 =?us-ascii?Q?eSboXlzdLKT0OEpLJ9J4ovSm/6E6LaHiGjdMTy2KQ8+z9Y4tHhdOe260lRrz?=
 =?us-ascii?Q?WJKyl/+opiCoeToursZbjC+WCkRJiJg8MvRXZoj6doJMpjfCRtQz56+PAyWW?=
 =?us-ascii?Q?1pLZFSl7LM5abjDH3ZcibccgZNi2DKWh+PGG44UkGtkuvxf0rX29z+FmDB+u?=
 =?us-ascii?Q?Oub6L1g2ixSaYQr37zU4lqryS84sWUZFREs09oJOPedkDJBphKaj6g8yjs5m?=
 =?us-ascii?Q?VZ5GdTG++UPlDLDjckIOmPjDonEsVycNLValV4GibKHtgmvzHgtwJ+6ARaAV?=
 =?us-ascii?Q?byrd7siG0K/WK8j0z2jMsMXrUEUfT3AQ81zW8nfe+3rE9HN/0+rhCT2azRWS?=
 =?us-ascii?Q?73YaBzJdDlPIKskjMK0je4qvbOPb0c19jxFaTmg6Jf6cRf6jCNCcaKJkfmzG?=
 =?us-ascii?Q?Jyajdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O+UjE1iEz9ZuRr0CdFMGRJGj+/RIX3jMdxmxAyvH62slEahB3is9zLPxgfdUVfDk2JJ0oryWKDPeOx5fC0wFrc6BfFS6E0yfDubavzPjj125uTV6C39oOFAo9U0o6K6PjTmtvHLNE8z59akpvIdPb8GQVVSgkKBUP99/UR0p8lW3Ytp5OP/QvIXWubBKuYYA6JD+GJw79qssNte0LeAx2a14iOS0VobrAqw9TOhsHd50Sj5Ywhq6goLAE0iVUNDncA6boyf7+LFokQN/TuQnQpkwZ5BZiji8ATB92DF4aKTU3nUqFY7QNFoj499O2Ylgec1IM3/MrEeC7/B/G7VnttFo4YgVxW6Gj7uSVJ5c2hst9MfLDCR7SPslrdPfnjRS9Nl05iTA+mjO6PrtGwAn12kOrnpw0x9OTudqzXOECv2BAJ+dBJpyEW06kNLY5OF+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:36:26.4233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a91b4b8a-9f10-4ef3-a6a7-08de6e4b13a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8923-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: ED5CE14EAB6
X-Rspamd-Action: no action

Repurpose tegra_dma_channel_regs struct to define offsets for all the
channel registers. Previously, the struct only held the register values
for each transfer and was wrapped within tegra_dma_sg_req. Now, let
struct tegra_dma_sg_req hold the values directly and use channel_regs
for storing the register offsets. Update all register read/write to use
channel_regs struct. This is to accommodate the register offset change
in Tegra264.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 280 +++++++++++++++++----------------
 1 file changed, 147 insertions(+), 133 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 236a298c26a1..72701b543ceb 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -22,7 +22,6 @@
 #include "virt-dma.h"
 
 /* CSR register */
-#define TEGRA_GPCDMA_CHAN_CSR			0x00
 #define TEGRA_GPCDMA_CSR_ENB			BIT(31)
 #define TEGRA_GPCDMA_CSR_IE_EOC			BIT(30)
 #define TEGRA_GPCDMA_CSR_ONCE			BIT(27)
@@ -58,7 +57,6 @@
 #define TEGRA_GPCDMA_CSR_WEIGHT			GENMASK(13, 10)
 
 /* STATUS register */
-#define TEGRA_GPCDMA_CHAN_STATUS		0x004
 #define TEGRA_GPCDMA_STATUS_BUSY		BIT(31)
 #define TEGRA_GPCDMA_STATUS_ISE_EOC		BIT(30)
 #define TEGRA_GPCDMA_STATUS_PING_PONG		BIT(28)
@@ -70,22 +68,13 @@
 #define TEGRA_GPCDMA_STATUS_IRQ_STA		BIT(21)
 #define TEGRA_GPCDMA_STATUS_IRQ_TRIG_STA	BIT(20)
 
-#define TEGRA_GPCDMA_CHAN_CSRE			0x008
 #define TEGRA_GPCDMA_CHAN_CSRE_PAUSE		BIT(31)
 
-/* Source address */
-#define TEGRA_GPCDMA_CHAN_SRC_PTR		0x00C
-
-/* Destination address */
-#define TEGRA_GPCDMA_CHAN_DST_PTR		0x010
-
 /* High address pointer */
-#define TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR		0x014
 #define TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR		GENMASK(7, 0)
 #define TEGRA_GPCDMA_HIGH_ADDR_DST_PTR		GENMASK(23, 16)
 
 /* MC sequence register */
-#define TEGRA_GPCDMA_CHAN_MCSEQ			0x18
 #define TEGRA_GPCDMA_MCSEQ_DATA_SWAP		BIT(31)
 #define TEGRA_GPCDMA_MCSEQ_REQ_COUNT		GENMASK(30, 25)
 #define TEGRA_GPCDMA_MCSEQ_BURST		GENMASK(24, 23)
@@ -101,7 +90,6 @@
 #define TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK	GENMASK(6, 0)
 
 /* MMIO sequence register */
-#define TEGRA_GPCDMA_CHAN_MMIOSEQ			0x01c
 #define TEGRA_GPCDMA_MMIOSEQ_DBL_BUF		BIT(31)
 #define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH		GENMASK(30, 28)
 #define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8	\
@@ -120,17 +108,7 @@
 #define TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD		GENMASK(18, 16)
 #define TEGRA_GPCDMA_MMIOSEQ_MMIO_PROT		GENMASK(8, 7)
 
-/* Channel WCOUNT */
-#define TEGRA_GPCDMA_CHAN_WCOUNT		0x20
-
-/* Transfer count */
-#define TEGRA_GPCDMA_CHAN_XFER_COUNT		0x24
-
-/* DMA byte count status */
-#define TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS	0x28
-
 /* Error Status Register */
-#define TEGRA_GPCDMA_CHAN_ERR_STATUS		0x30
 #define TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT	8
 #define TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK	0xF
 #define TEGRA_GPCDMA_CHAN_ERR_TYPE(err)	(			\
@@ -143,14 +121,9 @@
 #define TEGRA_DMA_MC_SLAVE_ERR			0xB
 #define TEGRA_DMA_MMIO_SLAVE_ERR		0xA
 
-/* Fixed Pattern */
-#define TEGRA_GPCDMA_CHAN_FIXED_PATTERN		0x34
-
-#define TEGRA_GPCDMA_CHAN_TZ			0x38
 #define TEGRA_GPCDMA_CHAN_TZ_MMIO_PROT_1	BIT(0)
 #define TEGRA_GPCDMA_CHAN_TZ_MC_PROT_1		BIT(1)
 
-#define TEGRA_GPCDMA_CHAN_SPARE			0x3c
 #define TEGRA_GPCDMA_CHAN_SPARE_EN_LEGACY_FC	BIT(16)
 
 /*
@@ -181,19 +154,27 @@ struct tegra_dma_chip_data {
 	unsigned int nr_channels;
 	unsigned int channel_reg_size;
 	unsigned int max_dma_count;
+	const struct tegra_dma_channel_regs *channel_regs;
 	int (*terminate)(struct tegra_dma_channel *tdc);
 };
 
 /* DMA channel registers */
 struct tegra_dma_channel_regs {
 	u32 csr;
-	u32 src_ptr;
-	u32 dst_ptr;
-	u32 high_addr_ptr;
+	u32 status;
+	u32 csre;
+	u32 src;
+	u32 dst;
+	u32 high_addr;
 	u32 mc_seq;
 	u32 mmio_seq;
 	u32 wcount;
+	u32 wxfer;
+	u32 wstatus;
+	u32 err_status;
 	u32 fixed_pattern;
+	u32 tz;
+	u32 spare;
 };
 
 /*
@@ -205,7 +186,14 @@ struct tegra_dma_channel_regs {
  */
 struct tegra_dma_sg_req {
 	unsigned int len;
-	struct tegra_dma_channel_regs ch_regs;
+	u32 csr;
+	u32 src;
+	u32 dst;
+	u32 high_addr;
+	u32 mc_seq;
+	u32 mmio_seq;
+	u32 wcount;
+	u32 fixed_pattern;
 };
 
 /*
@@ -228,19 +216,20 @@ struct tegra_dma_desc {
  * tegra_dma_channel: Channel specific information
  */
 struct tegra_dma_channel {
-	bool config_init;
-	char name[30];
-	enum dma_transfer_direction sid_dir;
-	enum dma_status status;
-	int id;
-	int irq;
-	int slave_id;
+	const struct tegra_dma_channel_regs *regs;
 	struct tegra_dma *tdma;
 	struct virt_dma_chan vc;
 	struct tegra_dma_desc *dma_desc;
 	struct dma_slave_config dma_sconfig;
+	enum dma_transfer_direction sid_dir;
+	enum dma_status status;
 	unsigned int stream_id;
 	unsigned long chan_base_offset;
+	bool config_init;
+	char name[30];
+	int id;
+	int irq;
+	int slave_id;
 };
 
 /*
@@ -288,22 +277,25 @@ static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
 {
 	dev_dbg(tdc2dev(tdc), "DMA Channel %d name %s register dump:\n",
 		tdc->id, tdc->name);
-	dev_dbg(tdc2dev(tdc), "CSR %x STA %x CSRE %x SRC %x DST %x\n",
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DST_PTR)
+	dev_dbg(tdc2dev(tdc), "CSR %x STA %x CSRE %x\n",
+		tdc_read(tdc, tdc->regs->csr),
+		tdc_read(tdc, tdc->regs->status),
+		tdc_read(tdc, tdc->regs->csre)
 	);
-	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x BSTA %x\n",
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_WCOUNT),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT),
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS)
+	dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
+		tdc_read(tdc, tdc->regs->src),
+		tdc_read(tdc, tdc->regs->dst),
+		tdc_read(tdc, tdc->regs->high_addr)
+	);
+	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x WSTA %x\n",
+		tdc_read(tdc, tdc->regs->mc_seq),
+		tdc_read(tdc, tdc->regs->mmio_seq),
+		tdc_read(tdc, tdc->regs->wcount),
+		tdc_read(tdc, tdc->regs->wxfer),
+		tdc_read(tdc, tdc->regs->wstatus)
 	);
 	dev_dbg(tdc2dev(tdc), "DMA ERR_STA %x\n",
-		tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS));
+		tdc_read(tdc, tdc->regs->err_status));
 }
 
 static int tegra_dma_sid_reserve(struct tegra_dma_channel *tdc,
@@ -377,13 +369,13 @@ static int tegra_dma_pause(struct tegra_dma_channel *tdc)
 	int ret;
 	u32 val;
 
-	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
+	val = tdc_read(tdc, tdc->regs->csre);
 	val |= TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
+	tdc_write(tdc, tdc->regs->csre, val);
 
 	/* Wait until busy bit is de-asserted */
 	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
-			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
+			tdc->chan_base_offset + tdc->regs->status,
 			val,
 			!(val & TEGRA_GPCDMA_STATUS_BUSY),
 			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
@@ -419,9 +411,9 @@ static void tegra_dma_resume(struct tegra_dma_channel *tdc)
 {
 	u32 val;
 
-	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
+	val = tdc_read(tdc, tdc->regs->csre);
 	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
+	tdc_write(tdc, tdc->regs->csre, val);
 
 	tdc->status = DMA_IN_PROGRESS;
 }
@@ -456,27 +448,27 @@ static void tegra_dma_disable(struct tegra_dma_channel *tdc)
 {
 	u32 csr, status;
 
-	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+	csr = tdc_read(tdc, tdc->regs->csr);
 
 	/* Disable interrupts */
 	csr &= ~TEGRA_GPCDMA_CSR_IE_EOC;
 
 	/* Disable DMA */
 	csr &= ~TEGRA_GPCDMA_CSR_ENB;
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
+	tdc_write(tdc, tdc->regs->csr, csr);
 
 	/* Clear interrupt status if it is there */
-	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	status = tdc_read(tdc, tdc->regs->status);
 	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
 		dev_dbg(tdc2dev(tdc), "%s():clearing interrupt\n", __func__);
-		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS, status);
+		tdc_write(tdc, tdc->regs->status, status);
 	}
 }
 
 static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
 {
 	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
-	struct tegra_dma_channel_regs *ch_regs;
+	struct tegra_dma_sg_req *sg_req;
 	int ret;
 	u32 val;
 
@@ -488,29 +480,29 @@ static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
 
 	/* Configure next transfer immediately after DMA is busy */
 	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
-			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
+			tdc->chan_base_offset + tdc->regs->status,
 			val,
 			(val & TEGRA_GPCDMA_STATUS_BUSY), 0,
 			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
 	if (ret)
 		return;
 
-	ch_regs = &dma_desc->sg_req[dma_desc->sg_idx].ch_regs;
+	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
 
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
+	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
+	tdc_write(tdc, tdc->regs->src, sg_req->src);
+	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
+	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
 
 	/* Start DMA */
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
-		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
+	tdc_write(tdc, tdc->regs->csr,
+		  sg_req->csr | TEGRA_GPCDMA_CSR_ENB);
 }
 
 static void tegra_dma_start(struct tegra_dma_channel *tdc)
 {
 	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
-	struct tegra_dma_channel_regs *ch_regs;
+	struct tegra_dma_sg_req *sg_req;
 	struct virt_dma_desc *vdesc;
 
 	if (!dma_desc) {
@@ -526,21 +518,21 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc)
 		tegra_dma_resume(tdc);
 	}
 
-	ch_regs = &dma_desc->sg_req[dma_desc->sg_idx].ch_regs;
+	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
 
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, 0);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_FIXED_PATTERN, ch_regs->fixed_pattern);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ, ch_regs->mmio_seq);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, ch_regs->mc_seq);
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, ch_regs->csr);
+	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
+	tdc_write(tdc, tdc->regs->csr, 0);
+	tdc_write(tdc, tdc->regs->src, sg_req->src);
+	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
+	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
+	tdc_write(tdc, tdc->regs->fixed_pattern, sg_req->fixed_pattern);
+	tdc_write(tdc, tdc->regs->mmio_seq, sg_req->mmio_seq);
+	tdc_write(tdc, tdc->regs->mc_seq, sg_req->mc_seq);
+	tdc_write(tdc, tdc->regs->csr, sg_req->csr);
 
 	/* Start DMA */
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
-		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
+	tdc_write(tdc, tdc->regs->csr,
+		  sg_req->csr | TEGRA_GPCDMA_CSR_ENB);
 }
 
 static void tegra_dma_xfer_complete(struct tegra_dma_channel *tdc)
@@ -601,19 +593,19 @@ static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
 	u32 status;
 
 	/* Check channel error status register */
-	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
+	status = tdc_read(tdc, tdc->regs->err_status);
 	if (status) {
 		tegra_dma_chan_decode_error(tdc, status);
 		tegra_dma_dump_chan_regs(tdc);
-		tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
+		tdc_write(tdc, tdc->regs->err_status, 0xFFFFFFFF);
 	}
 
 	spin_lock(&tdc->vc.lock);
-	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	status = tdc_read(tdc, tdc->regs->status);
 	if (!(status & TEGRA_GPCDMA_STATUS_ISE_EOC))
 		goto irq_done;
 
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
+	tdc_write(tdc, tdc->regs->status,
 		  TEGRA_GPCDMA_STATUS_ISE_EOC);
 
 	if (!dma_desc)
@@ -673,10 +665,10 @@ static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
 	 * to stop DMA engine from starting any more bursts for
 	 * the given client and wait for in flight bursts to complete
 	 */
-	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+	csr = tdc_read(tdc, tdc->regs->csr);
 	csr &= ~(TEGRA_GPCDMA_CSR_REQ_SEL_MASK);
 	csr |= TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED;
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
+	tdc_write(tdc, tdc->regs->csr, csr);
 
 	/* Wait for in flight data transfer to finish */
 	udelay(TEGRA_GPCDMA_BURST_COMPLETE_TIME);
@@ -687,7 +679,7 @@ static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
 
 	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
 				tdc->chan_base_offset +
-				TEGRA_GPCDMA_CHAN_STATUS,
+				tdc->regs->status,
 				status,
 				!(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
 				TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
@@ -739,14 +731,14 @@ static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
 	unsigned int bytes_xfer, residual;
 	u32 wcount = 0, status;
 
-	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
+	wcount = tdc_read(tdc, tdc->regs->wxfer);
 
 	/*
 	 * Set wcount = 0 if EOC bit is set. The transfer would have
 	 * already completed and the CHAN_XFER_COUNT could have updated
 	 * for the next transfer, specifically in case of cyclic transfers.
 	 */
-	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	status = tdc_read(tdc, tdc->regs->status);
 	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC)
 		wcount = 0;
 
@@ -893,7 +885,7 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
 	/* Configure default priority weight for the channel */
 	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
 
@@ -916,16 +908,16 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
 	dma_desc->sg_count = 1;
 	sg_req = dma_desc->sg_req;
 
-	sg_req[0].ch_regs.src_ptr = 0;
-	sg_req[0].ch_regs.dst_ptr = dest;
-	sg_req[0].ch_regs.high_addr_ptr =
+	sg_req[0].src = 0;
+	sg_req[0].dst = dest;
+	sg_req[0].high_addr =
 			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
-	sg_req[0].ch_regs.fixed_pattern = value;
+	sg_req[0].fixed_pattern = value;
 	/* Word count reg takes value as (N +1) words */
-	sg_req[0].ch_regs.wcount = ((len - 4) >> 2);
-	sg_req[0].ch_regs.csr = csr;
-	sg_req[0].ch_regs.mmio_seq = 0;
-	sg_req[0].ch_regs.mc_seq = mc_seq;
+	sg_req[0].wcount = ((len - 4) >> 2);
+	sg_req[0].csr = csr;
+	sg_req[0].mmio_seq = 0;
+	sg_req[0].mc_seq = mc_seq;
 	sg_req[0].len = len;
 
 	dma_desc->cyclic = false;
@@ -961,7 +953,7 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
 	/* Configure default priority weight for the channel */
 	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= (TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK) |
 		  (TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
@@ -985,17 +977,17 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
 	dma_desc->sg_count = 1;
 	sg_req = dma_desc->sg_req;
 
-	sg_req[0].ch_regs.src_ptr = src;
-	sg_req[0].ch_regs.dst_ptr = dest;
-	sg_req[0].ch_regs.high_addr_ptr =
+	sg_req[0].src = src;
+	sg_req[0].dst = dest;
+	sg_req[0].high_addr =
 		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
-	sg_req[0].ch_regs.high_addr_ptr |=
+	sg_req[0].high_addr |=
 		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
 	/* Word count reg takes value as (N +1) words */
-	sg_req[0].ch_regs.wcount = ((len - 4) >> 2);
-	sg_req[0].ch_regs.csr = csr;
-	sg_req[0].ch_regs.mmio_seq = 0;
-	sg_req[0].ch_regs.mc_seq = mc_seq;
+	sg_req[0].wcount = ((len - 4) >> 2);
+	sg_req[0].csr = csr;
+	sg_req[0].mmio_seq = 0;
+	sg_req[0].mc_seq = mc_seq;
 	sg_req[0].len = len;
 
 	dma_desc->cyclic = false;
@@ -1049,7 +1041,7 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 	if (flags & DMA_PREP_INTERRUPT)
 		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
 
@@ -1096,14 +1088,14 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 		dma_desc->bytes_req += len;
 
 		if (direction == DMA_MEM_TO_DEV) {
-			sg_req[i].ch_regs.src_ptr = mem;
-			sg_req[i].ch_regs.dst_ptr = apb_ptr;
-			sg_req[i].ch_regs.high_addr_ptr =
+			sg_req[i].src = mem;
+			sg_req[i].dst = apb_ptr;
+			sg_req[i].high_addr =
 				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
 		} else if (direction == DMA_DEV_TO_MEM) {
-			sg_req[i].ch_regs.src_ptr = apb_ptr;
-			sg_req[i].ch_regs.dst_ptr = mem;
-			sg_req[i].ch_regs.high_addr_ptr =
+			sg_req[i].src = apb_ptr;
+			sg_req[i].dst = mem;
+			sg_req[i].high_addr =
 				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
 		}
 
@@ -1111,10 +1103,10 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
 		 * Word count register takes input in words. Writing a value
 		 * of N into word count register means a req of (N+1) words.
 		 */
-		sg_req[i].ch_regs.wcount = ((len - 4) >> 2);
-		sg_req[i].ch_regs.csr = csr;
-		sg_req[i].ch_regs.mmio_seq = mmio_seq;
-		sg_req[i].ch_regs.mc_seq = mc_seq;
+		sg_req[i].wcount = ((len - 4) >> 2);
+		sg_req[i].csr = csr;
+		sg_req[i].mmio_seq = mmio_seq;
+		sg_req[i].mc_seq = mc_seq;
 		sg_req[i].len = len;
 	}
 
@@ -1186,7 +1178,7 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 
 	mmio_seq |= FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD, 1);
 
-	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	mc_seq =  tdc_read(tdc, tdc->regs->mc_seq);
 	/* retain stream-id and clean rest */
 	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
 
@@ -1218,24 +1210,24 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
 	for (i = 0; i < period_count; i++) {
 		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
 		if (direction == DMA_MEM_TO_DEV) {
-			sg_req[i].ch_regs.src_ptr = mem;
-			sg_req[i].ch_regs.dst_ptr = apb_ptr;
-			sg_req[i].ch_regs.high_addr_ptr =
+			sg_req[i].src = mem;
+			sg_req[i].dst = apb_ptr;
+			sg_req[i].high_addr =
 				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
 		} else if (direction == DMA_DEV_TO_MEM) {
-			sg_req[i].ch_regs.src_ptr = apb_ptr;
-			sg_req[i].ch_regs.dst_ptr = mem;
-			sg_req[i].ch_regs.high_addr_ptr =
+			sg_req[i].src = apb_ptr;
+			sg_req[i].dst = mem;
+			sg_req[i].high_addr =
 				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
 		}
 		/*
 		 * Word count register takes input in words. Writing a value
 		 * of N into word count register means a req of (N+1) words.
 		 */
-		sg_req[i].ch_regs.wcount = ((len - 4) >> 2);
-		sg_req[i].ch_regs.csr = csr;
-		sg_req[i].ch_regs.mmio_seq = mmio_seq;
-		sg_req[i].ch_regs.mc_seq = mc_seq;
+		sg_req[i].wcount = ((len - 4) >> 2);
+		sg_req[i].csr = csr;
+		sg_req[i].mmio_seq = mmio_seq;
+		sg_req[i].mc_seq = mc_seq;
 		sg_req[i].len = len;
 
 		mem += len;
@@ -1305,11 +1297,30 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
+static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
+	.csr = 0x0,
+	.status = 0x4,
+	.csre = 0x8,
+	.src = 0xc,
+	.dst = 0x10,
+	.high_addr = 0x14,
+	.mc_seq = 0x18,
+	.mmio_seq = 0x1c,
+	.wcount = 0x20,
+	.wxfer = 0x24,
+	.wstatus = 0x28,
+	.err_status = 0x30,
+	.fixed_pattern = 0x34,
+	.tz = 0x38,
+	.spare = 0x40,
+};
+
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 	.nr_channels = 32,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = false,
+	.channel_regs = &tegra186_reg_offsets,
 	.terminate = tegra_dma_stop_client,
 };
 
@@ -1318,6 +1329,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
+	.channel_regs = &tegra186_reg_offsets,
 	.terminate = tegra_dma_pause,
 };
 
@@ -1326,6 +1338,7 @@ static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
+	.channel_regs = &tegra186_reg_offsets,
 	.terminate = tegra_dma_pause_noerr,
 };
 
@@ -1346,7 +1359,7 @@ MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
 
 static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
 {
-	unsigned int reg_val =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	unsigned int reg_val =  tdc_read(tdc, tdc->regs->mc_seq);
 
 	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK);
 	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
@@ -1354,7 +1367,7 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
 	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK, stream_id);
 	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK, stream_id);
 
-	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, reg_val);
+	tdc_write(tdc, tdc->regs->mc_seq, reg_val);
 	return 0;
 }
 
@@ -1420,6 +1433,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
 					i * cdata->channel_reg_size;
 		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
+		tdc->regs = cdata->channel_regs;
 		tdc->tdma = tdma;
 		tdc->id = i;
 		tdc->slave_id = -1;
-- 
2.50.1


