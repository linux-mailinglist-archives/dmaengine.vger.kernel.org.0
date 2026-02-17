Return-Path: <dmaengine+bounces-8925-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JwPDc6nlGkRGQIAu9opvQ
	(envelope-from <dmaengine+bounces-8925-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:39:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D3F14EAF4
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E8223063610
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C4D37105B;
	Tue, 17 Feb 2026 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lq17AAYy"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD43334C31;
	Tue, 17 Feb 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349826; cv=fail; b=DqBep4cHIPR6kD2f6fQynWDDCtSVdAfSuo/EpUzegTcOLZFS4z3NRj9l+a/r9tbE2aQdQb+6MIz4B8eJfmV10NvWlM3dBOEBhrD5xzZPBpvwjxnQzZlE34JPeCIfcZXakJsX3ACRXbuWpkoW9hk+FT9vicHsY6l0dF+fj/0MSso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349826; c=relaxed/simple;
	bh=kcR9AycOO4tJTvFi1ZLLXINB1Y8R5P0hUmmjyRKE7y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptM64ZLjtCRWY7IOX10FWZ2L0CmDRnMOFOzgmLe0g/UxWKeZyU4V4cwQRoAV5JEq7k7vKvlCL1HVnO9ZM24pnVhuukeWSbl4EAAGdvGPEKgSB5PxQmVGzRGefIevvfDCVKs9smBT7BgBU1L6rJ79ZB2YQospVvJBhdojZBnPkdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lq17AAYy; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnXSV7dk6Qt5bsF6p3j8R5nI5pp6il08htgXGajjlYC4pta6ccCIHdfHntzyFMLGJRajx8qxpzjjT0uqOHUolp3Bq4dm0E9dQ4l+vvRiIEZ84hYDKZ1KDIOHmk97dwmc7AYmDtVCEH82PA24hm6MBQtNV90gYI6jyvZ9PCzlrsD4b74IemsPQsMNdLnR661m+8sX2jGvgOdHRMz7iV0AE1q3KOw0Fslv7ZBN8Q9chmsy41x8/aue1N0om5g3p7x2i7ja+ncWHjpI12+NUr8xlMHfPVLIjnGwRn1Bl0VGiEdFDZwSfGXpSegIvpRfohJ9zudXHEWygvZekdFckLecnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur9TOd4T2tMKSG+j+RDQn8awnSOB9Fc4GKrozVR+qsc=;
 b=CVRpkYJkYaWVz057DDIO2WGI89uN5abC4G3b8NsxA7auE+kwZWdhBEK6tQCTrFaI4QPt1Gplfk/7XpW8NR+cnhgB6WLgZ9VInCzmtfsCuGVxgqlXoR9Fm4AuV1wt0iWP1rMMlk8HE83vJjlIGqdNN8dbPW2+llrCmNekoMyq3q+qozCA+heQ2aqfX/mZXLuPCdgZxnMX7ZZvlwIZHcjXoudgUbV5wcGyilbdhKnoHHoNLS5JrhrnatU9BrfdXGW8HsnMuZh2UVGiJdlUh6TeaQ7d6bHZu/4PZW7c82Ii6irBSNzlgp1jVG3rAwvTQAAtd0p2Gc46j2XMOCToW7Y1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur9TOd4T2tMKSG+j+RDQn8awnSOB9Fc4GKrozVR+qsc=;
 b=Lq17AAYyJkqb3EKlWbkSmrHqcNaEQNxGjoOrCx63rKs3sZ3swZkLqVpW15iera3PYKfVANHi+Ymc/1bmhu+taU2EwR5a9DGFsZTzCtdKu60+vp5tQxN3AmLePx8Tv+w6Wjv5XBjMzhOJd/xa5GJuR5+wwfatkaTKnjWcn2WA6AoH/AMYQNMlt7hUIR8dcxlF9+9JEbIK4omVRy81DriVkuEepXMfKi4ZJUdrvXTzp88OobIWhSEys4lCWfS8i/JC+TvTQkAhI7lGyxn+mtbTov/T1WZ/nwhAqS7uhDPXKW1Q/iK0iw8ll9WmDZq0Z+dvZxDRXbE5WbUp3kr9UKU6Vw==
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:36:57 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::27) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 17:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 17:36:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 09:36:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Feb 2026 09:36:38 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 09:36:35 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <p.zabel@pengutronix.de>, Akhil R
	<akhilrajeev@nvidia.com>
Subject: [PATCH 6/8] dmaengine: tegra: Use iommu-map for stream ID
Date: Tue, 17 Feb 2026 23:04:55 +0530
Message-ID: <20260217173457.18628-7-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: fc90049f-e5b3-4872-0595-08de6e4b2626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xPbzGxLeI5NfQp4pN5KVrGcSQe6lDKhqxktbAy4SsVHxW+ysSix4YGhgKNXB?=
 =?us-ascii?Q?YT9fqhxgMqUvM35Wzf0x5KULKRKRzf+QugbXbtLbRrtY0CPORdCLyOluNAtV?=
 =?us-ascii?Q?H2oTTP8Lpu23EY86u1HObQasp2P5SBo9GnZh2NcwnUCKcodvdhcrKZznlxTJ?=
 =?us-ascii?Q?68HyrkeIi2AAxzIjyK3JpzHnXPZJ9P3Lr0Uh9ov2QRJfuRDZs9tnzJUwcVxq?=
 =?us-ascii?Q?8tH3vxIg43UQtRP8Sazvk/r7YEtSpiWophXkk97IPxdOVQtJnxUwhRFDF3Qv?=
 =?us-ascii?Q?Qma80j8ORduN3aXJGqhUCeEuOHouQhQO/FDTx1+h0jGW3C9QptW4ZxEdsF+p?=
 =?us-ascii?Q?KiDRqZ9+kIn7Q3jEhcMj3kjTTzNm+TIluRdqnU3X5NSUPg+jSrh9EXb3mno0?=
 =?us-ascii?Q?y0yF1VwPRhwtsOf5Xzjruda3bFNkm6V/SLZjFLBc3uegERccR2EQ74fckF6h?=
 =?us-ascii?Q?axeE09V070Mhh5ShDTfYm0G4FkHPM9Hnwswur5PWQ3HogDtbRB/k1bkYTlGe?=
 =?us-ascii?Q?nSliuxQVtmH909pHVPS8KOdyB6D3ZzD8m04vVLXbxlBih8YnvzAjK8mytO9E?=
 =?us-ascii?Q?l3RPKrbw9T0J3y8quenhUqli/trpBNX1FdKym+7e1f1dDOTRc6mMUBWDUx/V?=
 =?us-ascii?Q?FiHCs2/ThzygrhsPLVEnQwQ1uSlrUpb6r+Uh7ubcumg6fvOVY3wOCQJy9RV2?=
 =?us-ascii?Q?Ypv5EH0nuW2/5LlrVPoqe0rAfSeVGi2Vgqbk2wdtf9f64SCnQBz7zhfpM/ro?=
 =?us-ascii?Q?1W4fCiBJH7ZT6f3H6E2qQBptNgzGEgn0EjGawTIpxMr2WdBfuq0/2lfbep+j?=
 =?us-ascii?Q?dvu4S5CnUMBA3fM3MoB+LIzYwAlaP8F7sSoD8BeB4of2ddUeolgRj1H0KqU1?=
 =?us-ascii?Q?CzivtzJshrTKgBkboAPO7fXxRBrh5qaTUyBCspVXqo9R3Uqo9EVq2MIf9GQt?=
 =?us-ascii?Q?FkpZr9xWUmxbBIQb4lkuYxmy4PQuNPxyWbJGZFmEXYfHO6WV5XOPTMLob0WG?=
 =?us-ascii?Q?w4jbZG2GQh07+800mJKDcAU6HvJyRZMfZS5mo5EJU52crHIjBzCiIrpOYYlJ?=
 =?us-ascii?Q?PvjuFO3jQDaijeDp8HCXpZJdjry1yDjSJDbrhgHew9NrXMLaGVJRsVuMIiII?=
 =?us-ascii?Q?wZkSDyGWcL/BihXy4bVG5b8GcqbfuXQByK7weHW4ZNXiz2Q94Dnl1w1YdMdI?=
 =?us-ascii?Q?6YCDiFfHKA3MKG6vqzEveu7W0fIx7vZYWot6RsDP9h3s3MnqDBt4OWc9S5w/?=
 =?us-ascii?Q?tFOnT2Cn+mZ/wNlkbX8W3G2pJmhrYOYj+2AAklgxm7vX7ZQyOxO4bNt41pFt?=
 =?us-ascii?Q?/fHcxUtJorbDaHn/0DIgEPIoEgyFEecoBwSBkjuN9m6fwrowWjhRE4cTZYiv?=
 =?us-ascii?Q?fI/bbFUQNTPiFRorJs5oTckDBytiYuuKUFu3gBUARyYwK2ePmsGGs+kPeKCr?=
 =?us-ascii?Q?oZZIWJreQJVH7fyOvX1/Uwz5ZO2MF0HQwqJ3OCG/d1nHyBPQciNnCiJbvtpz?=
 =?us-ascii?Q?zZxBErWyluD0yOWQubRl8dpvP6kGOCEDXMOWMp7Ng2cBwiIix75wsY24ZD1/?=
 =?us-ascii?Q?iFbNk1SSS9RxyMYG3mp+695nym7Kp6pf/L3U6aF91X2zak2feiAZQdGBgWMM?=
 =?us-ascii?Q?cWEEdc0hKs/mW6OK5g+onEUEdURC+7uTLrm6GN4Vx9ptQvIwPMlt5LvPmXN8?=
 =?us-ascii?Q?sIebcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KbLZhO28FX1Ffb3PM3ej2VJlHl0/TbXKZIdskq4VhedwY1F0iy49mhdcMaBUK/chCroneN0iKTa75Caa1iM3GiAH4TnsJ7bcpMjsUvCE3QSaiQfhspfM/C4QC7TMh4g5h/9zdrKvkw2EARyr6id9/zcXx3RjF5BANgLXOLpEV1heMgOHyGgLaDaF6ZFTx/0/2fhbrA/UoU2yzV1z0+Y566drq6PN5EEWVgiGzKi2r8EFIlcxPHacRezipvMGTc4M6+sySyplWR08dJBjxJDwbafvvqHWpvxGSUc1DWpn92l53jg9G0BNcQGoUrOVdAaP1uhT54jaNiXiaHkfYN8PepDk/QNKgd4zENaTJvPZ9dsScLrZQuAMsLXUWF9ekeycAEGz+G1EJO2272z3i0APY2GNUdQSo81+q56OzZZWoPR71FABVttAm/IH9t+DrxAj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:36:57.2989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc90049f-e5b3-4872-0595-08de6e4b2626
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
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
	TAGGED_FROM(0.00)[bounces-8925-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 88D3F14EAF4
X-Rspamd-Action: no action

Use iommu-map, when provided, to get the stream ID to be programmed
for each channel. Register each channel separately for allowing it
to use a separate IOMMU domain for the transfer.

Channels will continue to use the same global stream ID if iommu-map
property is not present in the device tree.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 62 +++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index ce3b1dd52bb3..b8ca269fa3ba 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -1403,9 +1404,12 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
 static int tegra_dma_probe(struct platform_device *pdev)
 {
 	const struct tegra_dma_chip_data *cdata = NULL;
+	struct tegra_dma_channel *tdc;
+	struct tegra_dma *tdma;
+	struct dma_chan *chan;
+	bool use_iommu_map = false;
 	unsigned int i;
 	u32 stream_id;
-	struct tegra_dma *tdma;
 	int ret;
 
 	cdata = of_device_get_match_data(&pdev->dev);
@@ -1433,9 +1437,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	tdma->dma_dev.dev = &pdev->dev;
 
-	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
-		dev_err(&pdev->dev, "Missing iommu stream-id\n");
-		return -EINVAL;
+	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
+	if (!use_iommu_map) {
+		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
+			dev_err(&pdev->dev, "Missing iommu stream-id\n");
+			return -EINVAL;
+		}
 	}
 
 	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
@@ -1449,7 +1456,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
-		struct tegra_dma_channel *tdc = &tdma->channels[i];
+		tdc = &tdma->channels[i];
 
 		/* Check for channel mask */
 		if (!(tdma->chan_mask & BIT(i)))
@@ -1469,10 +1476,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 		vchan_init(&tdc->vc, &tdma->dma_dev);
 		tdc->vc.desc_free = tegra_dma_desc_free;
-
-		/* program stream-id for this channel */
-		tegra_dma_program_sid(tdc, stream_id);
-		tdc->stream_id = stream_id;
 	}
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
@@ -1517,20 +1520,53 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
+		struct device *chdev = &chan->dev->device;
+
+		tdc = to_tegra_dma_chan(chan);
+		if (use_iommu_map) {
+			chdev->coherent_dma_mask = pdev->dev.coherent_dma_mask;
+			chdev->dma_mask = &chdev->coherent_dma_mask;
+			chdev->bus = pdev->dev.bus;
+
+			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
+						  true, &tdc->id);
+			if (ret) {
+				dev_err(chdev, "Failed to configure IOMMU for channel %d: %d\n",
+					tdc->id, ret);
+				goto err_unregister;
+			}
+
+			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
+				dev_err(chdev, "Failed to get stream ID for channel %d\n",
+					tdc->id);
+				goto err_unregister;
+			}
+
+			chan->dev->chan_dma_dev = true;
+		}
+
+		/* program stream-id for this channel */
+		tegra_dma_program_sid(tdc, stream_id);
+		tdc->stream_id = stream_id;
+	}
+
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 tegra_dma_of_xlate, tdma);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret,
 			      "GPC DMA OF registration failed\n");
-
-		dma_async_device_unregister(&tdma->dma_dev);
-		return ret;
+		goto err_unregister;
 	}
 
-	dev_info(&pdev->dev, "GPC DMA driver register %lu channels\n",
+	dev_info(&pdev->dev, "GPC DMA driver registered %lu channels\n",
 		 hweight_long(tdma->chan_mask));
 
 	return 0;
+
+err_unregister:
+	dma_async_device_unregister(&tdma->dma_dev);
+	return ret;
 }
 
 static void tegra_dma_remove(struct platform_device *pdev)
-- 
2.50.1


