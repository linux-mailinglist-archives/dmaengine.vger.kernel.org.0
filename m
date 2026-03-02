Return-Path: <dmaengine+bounces-9170-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFFjIRGGpWkeDAYAu9opvQ
	(envelope-from <dmaengine+bounces-9170-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:44:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1D1D8E88
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF3D23096200
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8493136F437;
	Mon,  2 Mar 2026 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KYgyB5Jx"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9536E486;
	Mon,  2 Mar 2026 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454992; cv=fail; b=LuvMuM5AnhW+QV4E3s/zVc6mcDkM/a0zGbanxGXnyycFPz6lcYOWX7LskdQEayBb2CLcVvtol3FjBAUnRY5FF594ADEH/8KcTqC2Mh9zX2z8kJA/vC/FHgEIkOmxbnTkHXVrF8PHobhCdlVle6lqSvvQCD1NA2641QMC9zwxqx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454992; c=relaxed/simple;
	bh=UXQh6RydZgbwzAjRMES1duqcqe+OKx56eK3cjXzhFs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4KOY9MM59q1r8TUTeS/6dh0fiDbtEdeHVyHrrzU9k1YjBHkCeivrOL4hjcQ9CIfLOWp38A4RBQdkSW1V0uZSABvfPq/i4+bIIEyNvRvfjfqHCgtfM3JuTCXc4qX9EK6LHDnfzvsmWmnopfGtyyP8X28YTjyYhGe2zuYs7naHeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KYgyB5Jx; arc=fail smtp.client-ip=52.101.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOnxOfE5kpBG2jgVFbdinXiMnQPxxlH9YsaxyoV/WO1HxrD09XXpQjLETzhptpEKaZSr+GX0ZRpWvq9XOmz3hzaOeTO9Ew9l9OeBYyspQSfkfrC6NOHbwSBaXXsuCE4qfT13sZlfyh3Px0W/Q5DBaNAlB2H8Rqc1LfNd2nwnLYPptwuAKxnPMdVWu4bLBdYWpQi6G+4dm+sV/cwk5zdPxpHJJdKoKA/sWAy8CoeVbFjuGQYhECfvk90aAlfo3RR1dclD1GWlN3kiqdzDAcyA6sk60ybEwZeuTbQusr14xr79jtXFtus4sZcnNwSZqLnL5Es8vUftUiGb0g7FlzjGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92SnuKNNTwW/x/rB3c5O1xusqGb3Iup+xVBqw4UoBxg=;
 b=jUIDW9qu4GdrVgs7L1ng8o47xIN5TFKSygnGQuG1jDVhgJo5CStatP1D75KLdmq0d3X+C6FbMDmngfxEJ6ZLXFAXGRovHP9Z5FP3lFwqX0o9NVGo1agffVGvhLWR8fl05I/QsQTGty5eVFIfy6+C+rHXx2WaVhbLRo3TlNH3nfzcFn2HXYlJg9L9+zBBeNmGOUe5HOlvL3GpnU9Ezs6CKuXxff1+WeU56WOEzRLX9YkowFE+gr8ANqAah6eF7h4oiaaPcjjRXpeSCdo+Yi6Llv9AMJWg3ivuFYmGrPCk+A3xor6wH+pIv4n/EL1cMfUWRra5w2wL5ACnh7qYCxweOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92SnuKNNTwW/x/rB3c5O1xusqGb3Iup+xVBqw4UoBxg=;
 b=KYgyB5JxYTGqcavV6acJrkMlFrNkbfRT21jx9DCX6MYsAyXs2ryBnQi0zZDzFfB26ucaYJnQDiWWffKDZ7KPLTzg4khexe6mEunvlsUri0Cs0VsYjOHwtV5F/oNkVo/KauUDbhFBUHIm3x9TeXVYTeaBeCiWh28VIz+E82ScBVPh7XlYVGRTw4svBKUKznGOb8C7a01EZP+FMMrIzs/EXXd48zmNiK5nPoEfEFYUB20TbdBrOhTU+1Q8FmuQnZhjiwfyZ8FKLWBywAn7pktfmNgmE+4apu97sGVSSjnDGD91Oyt06UVHqfXl4leQOT+sE/6mCRuTtEskkZkavd8tIg==
Received: from CH0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:610:e5::17)
 by LV9PR12MB9832.namprd12.prod.outlook.com (2603:10b6:408:2f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 12:36:27 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::40) by CH0PR03CA0252.outlook.office365.com
 (2603:10b6:610:e5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 12:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:36:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:36:09 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:36:08 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:36:04 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>, Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 8/9] dmaengine: tegra: Add Tegra264 support
Date: Mon, 2 Mar 2026 18:02:38 +0530
Message-ID: <20260302123239.68441-9-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302123239.68441-1-akhilrajeev@nvidia.com>
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|LV9PR12MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fd6a2a-8254-4a66-c818-08de785852a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	nlsak7wO0/emBkDGTNm7tVfSGmC8OmWuKbzI+nBSaWDdsztfvvACpYWq+zOxJjdLFnLkEDVf2fufpVo+R9yc+Xv+8Xj49T2i7tRkBqg0FGxKZBH0LXQ3GvjtG9GwoTu9Bs6Jl2jYMKaaPiOjvEoRFpIF++3nwfYbYizBAryWWdSQM2FYHanR1aiW/cox6kRMkV0xUgk/oUSd/yW2QkE07WV2ou1VD5Rc3P+zzmYjQVx/q5uNVqTgBcOrbK6qJkSeq2t7lmxJESOgVxRHg+rwv7G+vsXHpa4ULPxTc0yRVjo3VPZyER/4dKpTZnl1mjbvrD3cj92Nr4ZiL7Fzer0FR9iXdC82kY+epfX0XeG+Q/GLjWbXEbn7QyyCZQxAf0sBqkFDQWdwGqBWhqRB43wtaiE2dTYq1qn42l8EulmC3gPEyYAqHY5Bf+qqMYFW4QI9HSDA/+YB/RfuBhvlC+0mLcwRTUFaXgP8AHbF/1g1S6KP1k9f+QYNm9B7larsYx9lTvmHiv8fUHUeNfv+Wv+/zHySguv+6LvJkiAIdl89dNA9um9dTC6lFzc9PtL5GWE/tw9ukX4HL/Z4j37vlU6ygg+FdtsG+UIqPthF6y0WE67zX6h40DnBCDmLY6xiVlKfIOmMAXe1cIxtPwiJoh25fR3GaFqW6NJlEt7MP5QTZw7VGEBCg/LvAMFKM0YVvJ9TPkhgAfJqMYW1j82eNkNPiR5+mhMMJvE6Tm4FXlm9QvS7WAg+A+g/2KRzyO2mrCU7XYnxECJXo8OFY3FuBkYsf38bUCxsUTYdjsySGvczT+d3eB815XBnY2d5h8ei/z4FuKoGer4EDjx8fukUpUXT4Kj+wScLiTezozeThjZuc/M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OsyHyAsCEtkF84JlGey6NpDojCYfH8sYH06loSDgdp6VCGPP6YRzf6vpBZu9EuGNY79ItTZWqeaLMftNy6O39H0Hy8Rsxkn1rF87J88vmvPw9MPeki12CLwXE6qcIQqMiKkRnw1d4uQzoBPZcgFXFMBOZQKjbkO43lxjVbTKh549IwBNATJXETl2hZy2VMUGJ+KtBZQsC02a0aaGA8CmYe90nOHz15Ok34Tu2uNndSdV2SefvVm2m1k9VPR7Y6Uu/eit1ysQypyoIjtB9VTvdvKUhWfZTn+p5W5aMijS6aEmL9laX80XryGHFPdUWbLD24yZmM11wKoI3qZ7dIHnzYq0Sugnad2a+ZPkjpX8JGqnQmzy6ibqjMkUUkW6R+QUdx88d4dNCHdUDd5YB2wOub0B8vQVY5GAZtYsB76HERRZomNZ2+lR6YbFTGuE8trZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:36:27.0806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fd6a2a-8254-4a66-c818-08de785852a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9832
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9170-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 21A1D1D8E88
X-Rspamd-Action: no action

Add compatible and chip data to support GPCDMA in Tegra264, which has
differences in register layout and address bits compared to previous
versions.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 9af509ecf495..d6e0dbc19e8a 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1329,6 +1329,25 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
 	.spare = 0x40,
 };
 
+static const struct tegra_dma_channel_regs tegra264_reg_offsets = {
+	.csr = 0x0,
+	.status = 0x4,
+	.csre = 0x8,
+	.src = 0xc,
+	.dst = 0x10,
+	.src_high = 0x14,
+	.dst_high = 0x18,
+	.mc_seq = 0x1c,
+	.mmio_seq = 0x20,
+	.wcount = 0x24,
+	.wxfer = 0x28,
+	.wstatus = 0x2c,
+	.err_status = 0x34,
+	.fixed_pattern = 0x38,
+	.tz = 0x3c,
+	.spare = 0x44,
+};
+
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 	.nr_channels = 32,
 	.addr_bits = 39,
@@ -1359,6 +1378,16 @@ static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
 	.terminate = tegra_dma_pause_noerr,
 };
 
+static const struct tegra_dma_chip_data tegra264_dma_chip_data = {
+	.nr_channels = 32,
+	.addr_bits = 41,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = true,
+	.channel_regs = &tegra264_reg_offsets,
+	.terminate = tegra_dma_pause_noerr,
+};
+
 static const struct of_device_id tegra_dma_of_match[] = {
 	{
 		.compatible = "nvidia,tegra186-gpcdma",
@@ -1369,6 +1398,9 @@ static const struct of_device_id tegra_dma_of_match[] = {
 	}, {
 		.compatible = "nvidia,tegra234-gpcdma",
 		.data = &tegra234_dma_chip_data,
+	}, {
+		.compatible = "nvidia,tegra264-gpcdma",
+		.data = &tegra264_dma_chip_data,
 	}, {
 	},
 };
-- 
2.50.1


