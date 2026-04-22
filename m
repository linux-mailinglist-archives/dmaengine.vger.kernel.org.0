Return-Path: <dmaengine+bounces-10079-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBVxIGNv6GmbKQIAu9opvQ
	(envelope-from <dmaengine+bounces-10079-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 08:49:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8F0442978
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 08:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A166A30AE9E6
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C6732A3FD;
	Wed, 22 Apr 2026 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YQi7OiZd"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79637327BF8;
	Wed, 22 Apr 2026 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840124; cv=fail; b=gHXxGRjEYyHys1Cq2+MM91y3ThhLzAF9jOXFd8ycs0gozjDBW2wckxjiagJw8tEc5s1Hw3XTxI98jaMt+wdgS9Igg/4DSz+V/yQa4he2/4h8N9dJqvll+TEyu45AUQsA3iFMO05ye5FKGyhb712g/6OqY8guceyBOO7GYnG95e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840124; c=relaxed/simple;
	bh=CCh138lmsq8e8YBK8iSo9BAajG2eFxx7FRjLQiNGbgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tBFHifskXAkaKOzYMahwGJFVEcOVoiMtXejuilPNBA8nFq5bhnS69hVYdBJ5OBfxMJSGBr2dwBuFtIk+TQqnOyWRzzPNBbDeEHCiEhOey9A68Kl6CpTI3q4jFE5gnvrYm0/t+Z0d2qz51ahKW2KLXkBo60Up/bRMWLM0YN3vPsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YQi7OiZd; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAv3otf1YnmnV3rzC6URTm4qbwowLf3VqX16WIoUW8yccHPnyO/oOQfOKY2ICQ3RPUbxAWHAycjO4hKawrOZc38Mb+xzNnu3Dv1LUcPASBautx9NwVykFVhC8wDcnD0LzaMU5oM+5iTIVwCfLzdHgq3/qiIOpnNFyCrh76+7RJndW+yqEbA7Dmk/Yf2W2TlqWh5lnwppkt2V1XaYq+fDtjDtQH316J5FzTa0Mu93Pb/nQM5EAEZ/iIuWROQixZxHKFD5+Hns/BxqIyZyrc6AWnSyQuFRW1yC5xs2bdHZSQJA4Dy6Mt/p8zBsVYhsk4im7TDzknoD5PG5nBiiD0cWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hToOVopm+lRkVUB34y+lkJND2SYCsjff9a3fISnii1c=;
 b=D4P9q1509FLZp7qhZk+Ch68wBAE5O96FzhrqnxE9vgkPa2dTp/VNI5uMRLAD33B5Fq6bxmKOryWjb7TKug8Dsq63G2L9igFZdMBseUv4NQCiY6OxtqHTtzooNTYPKjOrpF9wS2m4aHN8bAx8b70wCSVgmLraZiOnh9LWuc7m72Ureo+dkSEcS48E7z9uLp4RNa1zF96a+2c1ntVduGXDDUKOz6vkiiuf4OB9P0SSHmqwlNw5x7mVggn7p5PmKRl/RtW8T6MFoHBF/pLh9uAhpvk17YDZmdgJZAYG713frNSjXnAIgYFHXEUMPI7N9kNRMsqillYG5SSsymHHmMlatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hToOVopm+lRkVUB34y+lkJND2SYCsjff9a3fISnii1c=;
 b=YQi7OiZdiws+Og3kxUC+ZzcEP7tSWciILqVOFdym53wuB7W3AjCAEq05k6x26UdSrss9+5uIkvjGuRgkGc/Bwj4G20xKhQaXYKb9Uzc2J5HxD97NRi521TjaI25bmOq1kQnsyAcSSkwG0dJjQEFCXpnfNvTlHF4VqiQN2oMITARIieBl9KMcfVmVBBcCe/V8z5xilYxh+ILoFmgc1AHaJyOfF3cJY/pInxs3JAbr56B4xAqUPSXKyleKj2ACyxao9DFCG7sgW+Xhf3ShgzJUigTJfyCVwNTIrd23FMMeMxrnrmFbJe6szabjyFd4etYpMfksDRtv/0VGP5pTjlL3Vw==
Received: from CYXPR03CA0050.namprd03.prod.outlook.com (2603:10b6:930:d1::15)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 06:41:58 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::bc) by CYXPR03CA0050.outlook.office365.com
 (2603:10b6:930:d1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 06:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 06:41:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 23:41:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 23:41:42 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 23:41:37 -0700
From: Kartik Rajput <kkartik@nvidia.com>
To: <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <akhilrajeev@nvidia.com>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <thierry.reding@kernel.org>,
	<digetx@gmail.com>, <pkunapuli@nvidia.com>, <dmaengine@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kartik Rajput <kkartik@nvidia.com>, <stable@vger.kernel.org>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH RESEND] dmaengine: tegra: Fix burst size calculation
Date: Wed, 22 Apr 2026 12:11:34 +0530
Message-ID: <20260422064134.1323610-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5b5fae-cb1f-4f3f-64cd-08dea03a408b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jShiw859t9Cnqm0lMXcyvpWmV2E0I1FYyRA1aIn+NEy2jKHctraGl4dhmc7+/OO4S/OvmotAjnL49xDyNmolzZHamn6OOM8CWToEdHSUrOEAIQjy2Uqonzr1TOJXGdmPIV5eTrl1KXN5wXM8gGyTU+HKUd9NXnk5Fw6bBrXhG5clA1/runVp9156Wz8xo4VLxZnoQm5DHOsnJLjI2o+R/YBXkVZ62TA9fSdYH8ZfqaQdKboeCRXwoWjtOZIXVPkcXiTfMfkZowKu8RSnwBDcG2J3+bOIvZGvYGWsAx8MtThiJGoLE8MQ2IfDilelnHGaTwqnVepe5gDFtN6da7a2n5eGFbllJniMdeW7/oyRTA6BS25iz4oIpDoJ6xUpE45iwAVrd+4Fycb7pd2JFjVJMMYssDPiEoMfm91psqzK4PDH3Z08K2TeLxQWaI5RI4oPjIrwrJ4IcJ5Iuxc7RYn8jMduTgTRojj7eQk+gH6o+wu96fT1m4Ljn3ItJfe39MjsowPciO4uj/SuZk5/ytRnHeEBOOBBTOVt7q2PepS04d9PHO7dfMlGsJFvIeXTDNqQk8bqb1LhXetv4npvBMOxvBorjbx2B7bcRiphyQ4Vmn1aiT4TyYDMuvL+DwgU1B9YkCTgLT26G1bkUVPufsPvD7AJs4Lhfa1tAKIYG1IJNVw9iOi9rsgDkH41F/DN9ke/osfY7EJolKWUZPZuGkbH5A3zCCIH/4GgL5cxLYGQKHfnE8Bm87ELQsiPlGbobpJ59IAly68s+Sam3oGL2G559m7AL3JxGUDEblL19gOnmA14m8LKQjO/JtdYkItXT7Nx
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o/wORi2VebzSThtKQyls7NAn7xeV9kxEOkJ3bg0zGnHnlsrdW9cqLkoZ4E7dSC/hLG50nOHDoOeVX8GVtG0tcCcPggfv3SqMk7XE2PyeJO89xyKdxogrQlPQEL0JX2VaE119eSJljQGw9TTnOnK3O2+h/URvVZaRfLu3L0kLu4SPKb0udeAIfua5/uwpUNaF/cyFXeagVRNS18bH7TtvLNnXKx+pIYngIkmDI45Xzr+q8qmmA5e6O/7kTNPJQgwG5o92RjZs2zSQVMWEq6nWKcnNFW1PMhgU3mrJsQwuO9JtUX2+iSPdQqOaj0dpmIJL57FBV37Epp62F2pP2Bs2hKR+/co7JVj36FBuFev7RxPej1oWRTSiKfOQ0YS4GTT1+E3DPDM8CAzUae/uFGFU3JapeFMRZKetnpblMJD30Mpba7OH8mWukMgSUO5bi73z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:41:58.3407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5b5fae-cb1f-4f3f-64cd-08dea03a408b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10079-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kkartik@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DD8F0442978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the Tegra GPC DMA hardware requires the transfer length to
be a multiple of the max burst size configured for the channel. When a
client requests a transfer where the length is not evenly divisible by
the configured max burst size, the DMA hangs with partial burst at
the end.

Fix this by reducing the burst size to the largest power-of-2 value
that evenly divides the transfer length. For example, a 40-byte
transfer with a 16-byte max burst will now use an 8-byte burst
(40 / 8 = 5 complete bursts) instead of causing a hang.

This issue was observed with the PL011 UART driver where TX DMA
transfers of arbitrary lengths were stuck.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/tegra186-gpc-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 5948fbf32c21..0aa3a02b2277 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -825,6 +825,13 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
 	 * len to calculate the optimum burst size
 	 */
 	burst_byte = burst_size ? burst_size * slave_bw : len;
+
+	/*
+	 * Find the largest burst size that evenly divides the transfer length.
+	 * The hardware requires the transfer length to be a multiple of the
+	 * burst size - partial bursts are not supported.
+	 */
+	burst_byte = min(burst_byte, 1U << __ffs(len));
 	burst_mmio_width = burst_byte / 4;
 
 	if (burst_mmio_width < TEGRA_GPCDMA_MMIOSEQ_BURST_MIN)
-- 
2.43.0


