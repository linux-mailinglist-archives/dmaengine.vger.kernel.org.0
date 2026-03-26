Return-Path: <dmaengine+bounces-9666-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIt/GPwUxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9666-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:14:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77A33433A
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7421F307ECF7
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301938C2B5;
	Thu, 26 Mar 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oQf5XJJG"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21338B13E;
	Thu, 26 Mar 2026 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523472; cv=fail; b=JjT5B9erhfs91KkBWkR0gnBu7NNkZK/EdbZlJWUdwE9STaZnA3+NKLCwMPrhd5PmSXMy6tbo9UaLYhY8sylUK64zr+duR94LodglUGd1aXs4RU1XURwXe25MD61PcJIUKH5UycMIE5H0/llrQXIQ/hGs9xe/Lg2YwigLBQWIeU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523472; c=relaxed/simple;
	bh=DQkNHhFDyC19k9csVDwhNnWWmByd32w8BQDSDsEd71E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgZoHxGpRCzCTaoQZdJkbJsZJ2B3bktdVUgvnW+5mIly/2TO/P/F5f4jhh/edfuelM0u4xt3wcBXyYCa2fmxstekEgwiSOklrinAdLT/7xe4I8TytGWJ8uJO06P3X5aszhPATvJa7qQySqXmPEYsNu13SX0zdLUkU3DFei2IZ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oQf5XJJG; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf71vhzCRv56qFtOzXb0L3kLvpJo5PJw5VEyLzHF7jwuicCuN+lG5/lUXDVHUBOSvpqgj/OYd8nzpSP2d1fWirQZZifwHmhZ8qrcJsGmVHq8KINc/4tV3Se+DxdcxGL5gW+tF0+00XQpOEGRlqRdvEViHP35bVdCpHNaawUWgQt6kusTQpg6ZicAKh7HgZ1CTgRknvyMoj3lH0efk8Gz3zPTeN7RbU0vZBw4abhFnrj/YMN/psY5GlB+uIWYBoSyJOYWcb7Nkr6aVVEqzvfK30VMtFtaL8AOQ89w8mWIsbsXdlR4Ss+7CIYZufAL4NtukaPDl9YPe491fL6nhG9ONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E/TSJ4/CVWvqg/sIkoN1Bc+TDBYdsoBTkTcWD4FXls=;
 b=J6Azv5FNaVrgpXwwAZXYatO0I0gLhaygpw11tCCmct1HvtKL0UZ64TYvtOxsd4/u4BEomlTETVsy0VZrjqxP5q9hHv2LgRT2WHNj7qdX8G2dUJLM3JH5x1He25mV9g6eUCD5jmcWKe9f7ZK3uxLrlw8VRUezlvsnJ2mrxs5KD6EfmA2fg3aTo22hgyDQf+/GXwJgX2voY5T80RVtygCssBrK2h7czxrA+eFijt2DfBrGgOKBKkE0gZuGQZovw5ju8QbAuaRrCVOnXanOVcjJ9L9lKMjS9glExEI5ZAMbA/KwVzNlag0GIVeutxktAgSFIhsaYC1Wg+5SAanHYX6A0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E/TSJ4/CVWvqg/sIkoN1Bc+TDBYdsoBTkTcWD4FXls=;
 b=oQf5XJJGFbQc0J2AtlgoDltKOt3tcnOMZvdoq6qbfxtn/n+5SL9FhGYZgUjzVck9ojjeJFoATvrWAPuaEhdLMCx/6XCKgeh5eU9B0TWcX6IiUj8QGV0rIzZQ4ya6hXYnJE9a0sxtYkA1Y0ssEECb2+EKCd07S6+/lr8EyR01MiolQhDrwG9LWwS4XyFWNE2hWAS7M7spEoGP5ZagYUCyq0AnD4VEqGOAz9AZjQryNc+2OTxsNXDMf2hh5jW1SD5sHAjpL8r6TMsnp23/rCadngx29TsOX9MYfiBHhmjlGrtG+GEALcraY0n1juB5Y5rxgUmpA7+ccZXxwEK24vgFDg==
Received: from PH8P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::6)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:11:03 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::25) by PH8P223CA0009.outlook.office365.com
 (2603:10b6:510:2db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 11:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:11:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:10:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:10:51 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:10:47 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 04/10] dmaengine: tegra: Make reset control optional
Date: Thu, 26 Mar 2026 16:39:41 +0530
Message-ID: <20260326110948.68908-5-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326110948.68908-1-akhilrajeev@nvidia.com>
References: <20260326110948.68908-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 721ba7b3-8329-4461-3323-08de8b285e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KUBJc71OxIP6fSRqrFffGWxQCN/QVVdH6dLqGdcvzDiMXBXTzQV9Xv1WHuNt7p2YlOHNrHBe1eMxyWi3+Qmmd6gwjTJdTgsCgJzsm8pzKHMDSNG7TC4verUhzBHG4714Gz5KIpnF8KY76XiV5uF/b512JyOHRIXX8kwvJF6Z8Q/qnGE325F2RhsdR70Lfq3FAGIAz2RmiV4ELSXxhky8+tWm7zfIZqs4IcjG5VfX1bjknkonwgI8e7Ov1ByVmSdwOQBW8jyoWo+imbA7jIn/5sFnyUZqITRfbYez9q7isEwJRgaUDzd/xfADklpMJvl3HKto0qWnw0/eKbjowi60HekC0D3a1qZscbZfq2HFn0IGGbbt4F4fdyhRVV9wLvfGnh4ZHms5IIy8RPivwnYu2S0KTKHUwnT3O7LHlVgImVWbdJy/aDs2EbxyMz+505M9ma5JrDlLbUadeHAE23gy7YHro972wMiB839qcEhghPDyi3raqznUQvrZyXp4FaSv926f/wrX5VvcpfzoyRKs4EXWsOckNilQVZ2DXzF6zpwRiuhW/5QHMk27J1l561NX1VTIyb96Yt9Cr2USFKr6NbbnLiDoN8+BEjOTBjJ1qGYrpyn9jfHe65sU/P4G43lDLH6QmvbRa42OTkF+330QvC8OqjlgsVVFHmqtBeE6g6LNFcFpC24rNavdP4qipIoOLYt0A/heXa0E7ZqaMf2pD+oQyXgZyJ1SitD1V3InbIBZX5i09GKX+azOmP5qhwV/IxnhO0+uYFsc+MEc15UH9lt8r/JdPqVEtlwLiyM/XEBVJW4owKjIqySeJwzhU4q3
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	izi/2MYoKGw67dG+Q8/YLqwVveMk6rA+amG8TanDYwYMY82blM7dPK4Ho7f3LygVXVkyrHXvUZCrDSqwFayzS3LFmAF8z+wN+JMpTvTHrWuyiUBqD52mrJx/YVIQVVets5GvB8XcgvqgRMadPwnBETMAPZYlGbNLmdSgQfnLOPJ3Nx8K79Z5coyW7pf2ZFWKYGhD4Br/smbhzf3JixVE1/HRytCXuM+lPwp72n8967VAiJm0KeyBurNr6C33r4B7ofNSmc8mAl5jvyIu3KlBrMNwZtYo3iZqEC324lgsCE9ppX6lBUfwYYeTUVphySoCqMzaioGeoVH146HQlOx1LnCjwtCnVPKVupvmFQVdLrG1hAJubS1rAf6OHv1d5Qlt4amLCyhtTzfsrxWi2ehegKeWVZZVklWITBNHw1F8iKLEFkmtXQf+JkflhiE9GneX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:11:02.4725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721ba7b3-8329-4461-3323-08de8b285e12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9666-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0E77A33433A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, reset is not available for the driver to control as
this is handled by the boot firmware. Hence make the reset control
optional and update the error message to reflect the correct error.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 5948fbf32c21..a0522a992ebc 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1381,10 +1381,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
-	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
+	tdma->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "gpcdma");
 	if (IS_ERR(tdma->rst)) {
 		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
-			      "Missing controller reset\n");
+			      "Failed to get controller reset\n");
 	}
 	reset_control_reset(tdma->rst);
 
-- 
2.50.1


