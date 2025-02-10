Return-Path: <dmaengine+bounces-4387-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01274A2EEEE
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F94116463E
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB3E231A3E;
	Mon, 10 Feb 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cDMoMEU3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18418231A33;
	Mon, 10 Feb 2025 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195683; cv=fail; b=CHbS0UzhPkbo3aOGs1TVCmoJ0e2sc7wqh/SW5hVtxERPMT7/U8sEjFI1nWAyvxrnj59IY7FkqCuodp6NjlUUDZTCyB/HCk1PP6kQQ9R10tR0MuQo96Q8s8iwFWgrtRWAI8jYDMD0ox9CFq/HOGqfX1ajhZmR0NY9tLar5Ji6nPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195683; c=relaxed/simple;
	bh=mTZlIDl5QLOJMDxUNc064lRgwWcsH/y6kKXHt8iigVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoAHTgKLoqAkQHV4k9JUfIAGkC1MO/9NRI+C2Ur4rVkN2zkaLFoVbHNYKagQcUOHp7p5X1xp7aHpl7lU9rTcqGFJfyOLYDdHALmvkfn1SeK2ZqD2VsjtCyD4wftZX1UN6VJOV8NjREE4GqgLQzhmsi2c8o3YlU3+Rq/xt+mOg1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cDMoMEU3; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8n7KfGL6Kw8gVHcEibbDTnrDZkOTp6bpDrdLi9AdOAZSNuVIRD5CDVvqZ5KPAi6poYdJGIkkcbxpBCvk25ti40SqK8CGSgHEudkAredF5KXMDqcutcpeq8ozFfPEc71WkPGJ+fgDomlHHPsxAwIWx+RM53qtXVMKyhjo3vwMX/7ZZVzqK+ykG74WDXiVChkYAZMVDC/QEDBwZx0AZV67Akh251TV3U6bxwrxTvp534SHSa3B4g263NGUx4uKTdiTdHvMtpFqSzEminW9PZLtHIFfk4BfYwD7s/Lmq8xvwpw0XMgkjZubcHKkDs1mpDbrzw0aYF9+veFZaYK32+L5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAqld6ACD9cKd6Gw08149R6YFUi92EZgC/qWPxiJrjI=;
 b=hiwLwwv3Ck52nMLgS9dOw8ApL1TlSEHfnrC1ykJzt+T2VAw6FbS2Lf+KVJF+WiUOVIxIKduretxs/BxxDcz70tx+JClwVUsMp/VeW1ieC1Ma02uohsFBOEE4xF6pwKLei/iaMFketDmwX/q62ObCcd/xhQmO4dZpCC27xgoqHeaHAZEduB/vTMiE2EONJRfPtSGypjzSKk2HtT0hrIbnZSfCU34O71QNKqeNTZS94KN9iap7JPrl00rAgar8yRtReMEeFRbCZdkRhtAlULfXepIMGr5ULFnjp9PE9jBin4qYA5YeRTniVh3XHQmIS+WyJYrK3darom02n71W2mHxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAqld6ACD9cKd6Gw08149R6YFUi92EZgC/qWPxiJrjI=;
 b=cDMoMEU3vertz1L50IM+jHbJFIv4J8gkLLjbxkW2+KRfUB/9Eu4vpHODOMQQs5CIwNPPU0LJuQQRyN7ifw0UXwncZFrvii++mTATzXNxH2B2cYYFTkbrNOy4zut5mmb9U+9W2VnmrhxarMQhaeF+ed5atZjs0EcbkSgGv/72+OVw2deCqGA1JOeQdwAqp/0q5NUOBPJ4VdI3h+xs54AZy8FzjcwzpLb/OM2arqbRBWXcNckeYh3Rt+yu/MKtIbNN7/qQg2Ascj6FkH2yUSFGgjpNt7xR9CqRe56YsYAToPy87hsrcGcCFKsAAmSCRulf28kZBVCW5daP6KxrdpYK+w==
Received: from SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) by SN7PR12MB6960.namprd12.prod.outlook.com
 (2603:10b6:806:260::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 13:54:35 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::a8) by SN6PR2101CA0029.outlook.office365.com
 (2603:10b6:805:106::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.2 via Frontend Transport; Mon,
 10 Feb 2025 13:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 13:54:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 05:54:26 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 05:54:26 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Feb 2025 05:54:23 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v5 2/2] dmaengine: tegra210-adma: check for adma max page
Date: Mon, 10 Feb 2025 19:24:13 +0530
Message-ID: <20250210135413.2504272-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210135413.2504272-1-mkumard@nvidia.com>
References: <20250210135413.2504272-1-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: c27da0e4-0b83-4ed3-ddc1-08dd49da7418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i+LwoC0WHLtwdDvuIvo++fLjvE6D09jLpdjUjsrxfLS4D+TWlFWCVoRP4J24?=
 =?us-ascii?Q?bmFALpX1udFcq1ndTq4B9C867+Yw1Ix+zoRb+zxlIUvEKY1sUKwKjuqLwSAJ?=
 =?us-ascii?Q?W37yU/dIOKO7+VDuqUl016jEx2h+OfT8fb62QXXHF93s/XSrwfwke6ld3ge1?=
 =?us-ascii?Q?9++oSSfl5bxV4UtBPost6EE8i29oEVD+plX4ROHanRitNO0hX8duFDKB5zA8?=
 =?us-ascii?Q?+IBpgRDiMhitzp1w+IT2H1EbL4jU2+eCyApvxlTjYoc8EPlSulAnYPo6F4eJ?=
 =?us-ascii?Q?icuaOg4kHdMzbbNmL42HJLjwNU9MrL6f/hGEU4w5yOj/t3PCJMb6vjKQkNBz?=
 =?us-ascii?Q?JZL9FTbqtGrhd40UCNzF1Er86X+h3ZXtgGc1N5XrnHfl9apyRe7+IbFc1YdO?=
 =?us-ascii?Q?o9jkiuU4VKed0Xqcc9BUrK/lbcpCilNsBsou5hgKwxt0S6KCik4wdbuPltv1?=
 =?us-ascii?Q?MdN2luxuy8q8zFy3Cqgr5CyGZy89ngrmAqW0h0/Nn7roptKjtFLJlwNt+Pev?=
 =?us-ascii?Q?2Ciqv6UTa8AvJ7tpJaDVZBYfF6oUz6c+VIaoUpGpl1r9zfH0+JcADvnwGGR+?=
 =?us-ascii?Q?S0MxIE4HAV1wRhJI8aLBeRRNo6jGKT3xnNvkvYfb+rId7q08iUtU0MQaix1Y?=
 =?us-ascii?Q?wWNEjwPGUFRDbX6yxfT6hJ1PFN8fI30IlbxjldLezEdNU5IwK3LXi+rTZg9H?=
 =?us-ascii?Q?J8xZ51Qwx5bc+Z06GYYWm/3171YqkerRzdo1WTWHLZCaLtLrjp/lsrbvaQDw?=
 =?us-ascii?Q?bbqTiujuHLnZBDXQVsRY1IIqZ1z8Ca0WhvCl9HLy1jjCWnRU+OmHiuSR30Us?=
 =?us-ascii?Q?9zAkAl+maY64+NPiuH7puaLN65lEt4F0rqKMYClUKc87B3t8YUNI9fDjhH3J?=
 =?us-ascii?Q?NfSntbvSo/FXiWcwuWybeNdj7UOv8nQ8/pKfxD0uh+Oz3mstB9MNG9Yfp9is?=
 =?us-ascii?Q?F0i8nR3bkOP1XT3o87sYZL38N/igCtyitz99tr8L2OHlmBa5xttz6gF9neZn?=
 =?us-ascii?Q?IyOkKU11wKzkZOEP6OlaPwzI38UXrsXQge99U3QQrsf4aCVIEPfgPNnZY6pS?=
 =?us-ascii?Q?q4YL/Gh37iOUAzT1GYmkhiy6V9d55bwlBf6fIHJzC9J1TMIMHVjbzuaexBGi?=
 =?us-ascii?Q?JH24E/YaiSiWoyS2YgzSMFF3XHFfpuw34wqmVybB1WAQFB6MiAD+t3Dg19oB?=
 =?us-ascii?Q?qTgI5ChKPNuIBwzvIf6xWz4oK5yWIUzDN7aU/xRuMCgvPafjmqC3NC4B8oML?=
 =?us-ascii?Q?FHF8+lVeC7urTQc4L9Pj1X3qR7AoXHtOc8DA0Th5YIksyqzsLKz4z5rRXFha?=
 =?us-ascii?Q?0qigDXW6TsglWCg6uPRvEE8xe5ImwOsR5lqM1u8LdAYi5TCjp/GP2/8bImI7?=
 =?us-ascii?Q?mjEnQQ3m13qiYfHm56+czG6bJ6lc60q2DQvpFWfI0uvIUqSH+hiublVeScIp?=
 =?us-ascii?Q?gpYDqSE6p58ptBmBP85T/dgvANdfVmxQOwvGCe56ECIvWfPH0ikxieNvg8fe?=
 =?us-ascii?Q?ClCzlewxHdGTzDc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 13:54:35.4713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c27da0e4-0b83-4ed3-ddc1-08dd49da7418
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960

Have additional check for max channel page during the probe
to cover if any offset overshoot happens due to wrong DT
configuration.

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
Cc: stable@vger.kernel.org
Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index a0bd4822ed80..801740ad8e0d 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -83,7 +83,9 @@ struct tegra_adma;
  * @nr_channels: Number of DMA channels available.
  * @ch_fifo_size_mask: Mask for FIFO size field.
  * @sreq_index_offset: Slave channel index offset.
+ * @max_page: Maximum ADMA Channel Page.
  * @has_outstanding_reqs: If DMA channel can have outstanding requests.
+ * @set_global_pg_config: Global page programming.
  */
 struct tegra_adma_chip_data {
 	unsigned int (*adma_get_burst_config)(unsigned int burst_size);
@@ -99,6 +101,7 @@ struct tegra_adma_chip_data {
 	unsigned int nr_channels;
 	unsigned int ch_fifo_size_mask;
 	unsigned int sreq_index_offset;
+	unsigned int max_page;
 	bool has_outstanding_reqs;
 	void (*set_global_pg_config)(struct tegra_adma *tdma);
 };
@@ -854,6 +857,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.nr_channels		= 22,
 	.ch_fifo_size_mask	= 0xf,
 	.sreq_index_offset	= 2,
+	.max_page		= 0,
 	.has_outstanding_reqs	= false,
 	.set_global_pg_config	= NULL,
 };
@@ -871,6 +875,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.nr_channels		= 32,
 	.ch_fifo_size_mask	= 0x1f,
 	.sreq_index_offset	= 4,
+	.max_page		= 4,
 	.has_outstanding_reqs	= true,
 	.set_global_pg_config	= tegra186_adma_global_page_config,
 };
@@ -921,7 +926,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			page_offset = res_page->start - res_base->start;
 			page_no = div_u64(page_offset, cdata->ch_base_offset);
 
-			if (WARN_ON(page_no == 0))
+			if (WARN_ON(page_no == 0 || page_no > cdata->max_page))
 				return -EINVAL;
 
 			tdma->ch_page_no = lower_32_bits(page_no) - 1;
-- 
2.25.1


