Return-Path: <dmaengine+bounces-4140-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4381A13F28
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 17:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFA21886B9C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D422CBD3;
	Thu, 16 Jan 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3ku1YjN"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05F1D86F6;
	Thu, 16 Jan 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044472; cv=fail; b=EIc7rAE20nDwhJTonPh6pbtz8Ni4RbrZi3KGdn6z4Ealdp2ZDowGK54h3UZ8bKClykFbHBGZfx+V1avg4xoNiI6JMp52ZXrttL7GsNsanvyaqfNQQB2zPOxiTaxCiDmEIume932jYJCoi9Uu7EkWuIF11hjvXxtEk0v4w6c/Ee0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044472; c=relaxed/simple;
	bh=Uc7QiqmKFE8gUzVZ7XE7ukRkCOJw0gRx32J+DfoWZnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPJEmYwjXBcnp5Cnj2rq89nL02+qlLkw8iKExRUnJ4BIIKdpwhUw62lntzuo3sqVDGMaOI60XPVbvnrdz6aE2RE/myahjilXyeVYYvPt3YhHgrY/IT8jjePuqqKHU4chVJPJn6nZfpDg2tHVBJey8nRdqugLdcrG1o0xuqlLYfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W3ku1YjN; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZlgUCV36FizCFtfOpc6g4JM18n+tJiVHFaYm7je7HcpbKdc8YVY7EHsIVbPNqzNqtUKrFQ2RjHNv1BIIML/eub/6WsLzZds1pgXg2KHzfo8u5KMhxRyovJLENwnqZFxiKUJlTtd1x37TVSojXyeBNt+zpW63QSPlfoG/C+yyZXbr6H1SYhweUGNxH6eMkkBUuhVCzTBDVeCbWvw/1Ti0kPBT2hwkbpctLG7jDKD6csBsNoXI/Pvcbf5W9c1XSaFOU52rtcl9i6njG5mojOTh4jdwf+toLAzjA+NUqACylONeMIzpMTn4JGDug9ne11GVtuhvHFsexjyLjAxOV7EjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amttj7Iqf4JfoK+6cTxNPeuBXo8WwFPxu5NcT+m+8wY=;
 b=PZnWbg92F7ryCkCvASHS59j7U1wsd0gLvxiQRljeRz0dCm00eMbFcilFe9R85kLCCLj+eE4xVUV+A6cQCpaNcx0fWTIo1idEf81Y3bZggRbTz8PJbCdfJWtTHakHRnC68+CNdFno0IhcxsTSALdsMkDL5q6Mpfdh1KsCMgc4k1JPQabStgB7KAxAbaHtp3wzsi2ph3F6ea9nOcxJS0xtoz/TbpFvJGvQ3iIx7ztJFAUicT/BLn1ghNG/0jWfthMvySYOPLbUUvwD/ZkukcTtoK7mn6WGNlseSE0YOaQuSDa4DiKkqqWU4UWxCoPSlzOvquXH6U/y6UtHtVP9UcuWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amttj7Iqf4JfoK+6cTxNPeuBXo8WwFPxu5NcT+m+8wY=;
 b=W3ku1YjNkTQfl2MYgZnybeCo3menvIZty7DdIrWU7msZxgdfqp40xYR2iW0TBeW2dWCaSC3yzQiQQlNNKxZMdhONl/ZO1TBywdMQMK5+APq9w7bb5XRPpFrYGyhnFf/WDJA+1CRjduBfZht3yo97ZbKkR1uAbXtx3BElxQull0dJf9k/2s/dpIIZ+QaoQsiRJrOgwzlAwVCcB7e/4X6Iw0EiKNdXVTgbMW9po/hqcvBDQf+q7umv1FmcR067bl5pCAzYoRpi5QYGYtrPFx0Eqtn1JH4mf+ZMGNlvgFaJbvF34cADcbJFDuOcgIkWRd0sPpawDSqHqdANw9rmlj/nxg==
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 16:21:07 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::8) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 16:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 16:21:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:20:44 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:20:43 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 08:20:41 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH v3 2/2] dmaengine: tegra210-adma: check for adma max page
Date: Thu, 16 Jan 2025 21:50:33 +0530
Message-ID: <20250116162033.3922252-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116162033.3922252-1-mkumard@nvidia.com>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 307e1fad-3191-4f8b-c073-08dd3649c80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J80yIp6KPr7Dj2et/LmloK5+moWGbFxFVUIukc18CaBMYla3Ts7apcIuf0wX?=
 =?us-ascii?Q?bMue4PuavUgUp+y58PdWTZ9cP6Bl+6YuRFKC+I7+6SctGNQLd+Pi6Kg1QB8o?=
 =?us-ascii?Q?I1mpd/UInpiAyR7/8Q7bmbvikd8ibmWK3tUbZIebmhtXl8hFkax8AsKT+ApS?=
 =?us-ascii?Q?0viwdDp3mJLqX80bEgx3RsQqOXeGR/M5tvMh6WweAwtrNH1s4I5AlpFuSmq2?=
 =?us-ascii?Q?DMqsvIepRwx8s7820QiJOeJa3ng5wQF0hNP6DEb3k85rI2y8rp1YL5OOi7TP?=
 =?us-ascii?Q?FGructi47H2TbzfuCoSAKQrduQps0NH6bOABQCK6Uh5B56Mk+63gVcAoU2sK?=
 =?us-ascii?Q?LwSqwHvQ+LZSZbXzwTuXQYS/y06nrFO+XQFku5JIgOh6dn1uKzFfymt3rLMO?=
 =?us-ascii?Q?4XghZ+WVuEZJZ8ZN2/7160IwYii1mNC+mFnb1ZwWVNp50Qa0LcQXDy8C2/DS?=
 =?us-ascii?Q?2QvoTbtwBzyOLgwpMepierqx0hVw+fiwGC8XMU8AUoA8GwAftC6AkAxw9t/1?=
 =?us-ascii?Q?qFY3LXgXvZHUmSIE9sskvImE9enAyi3xkg/rJ3Z29zpxgVkIw4kLCvCzTX/4?=
 =?us-ascii?Q?QVJeOGm4ZBYn4KgCwxiEiVsu9r5MvxcU9tSTX+S4wOA9fg+35dwhN3lr4aLf?=
 =?us-ascii?Q?6XMCj5+FW+BuiVsUZ+d0N5iLMSRQN7fmNOubexDGvanHl0k9lxxX5WogxUM6?=
 =?us-ascii?Q?gtVblU9CobpzK48HopPwU+Xmc/VChTfIXF1jhd2APDsL6hXE+EiXHJcIEeFq?=
 =?us-ascii?Q?93AXnRISbnsNZkbpK971oJiS1x2Jt6Yrt3DvH/LaEiTa7O7nfZWHs5hj+Ckj?=
 =?us-ascii?Q?7IwDno3qoqkRCho0uEsxuyMdE645oZaEaSUqoiSowwW1wJH1V0BPnq0/WEYZ?=
 =?us-ascii?Q?We0FVXmQ99kaI4xn6DgxlAxzE0I4cnvOGcEupui0SaQdCQN0BT88f6Hc8OJL?=
 =?us-ascii?Q?TyB/N19ivR+H7i82r5l312JoMlVlEmkiMJrXmQ5SW/BWTdGGqtufdt5RvlIS?=
 =?us-ascii?Q?CJH3I09iX68IfsnWKntaAFqNMKTeRgX4czoHdEDv5ItaPMgYCN78mZKpFm9G?=
 =?us-ascii?Q?+WkczK04AIL5IbOZiEkQDXlmXGX3nJMk4k5Sihlo4RTWHwCx0DFzBsUhyjn5?=
 =?us-ascii?Q?x/3CPWdP3pW3HULGQUTGfklh1ttyAYBdkZgTNvA3OXMmY5n6Ln1n+gKz22fa?=
 =?us-ascii?Q?qhn6ZSHueyuaE+Ts4ZCfcXOyiVtWiBrrpLH/YxgynVnvrxzj1ey365poTgyo?=
 =?us-ascii?Q?prxkWG+zUc0usYEp0T2BSrfsipCJx/83s9Os7hCEQTBWtUDBvq0TFVZJo6Q6?=
 =?us-ascii?Q?xTjsGZ3vCM2rkCHj+/OXpmrO+tGUOLya0Raei1XSx0lMbwIZPK9OZBn12KOK?=
 =?us-ascii?Q?0+wLr5yGbqS0LsKIquSJvxfqU3wMybvWkqqvUiaaLERbV+zmmVpZ4FQnAxUg?=
 =?us-ascii?Q?SWQKvJohUFsWIVWFW1Ow4zK0+fyn71vi5DEOEa47NG9hWJr5Lei1WdNI5oRt?=
 =?us-ascii?Q?OyKmPGaf8J2hyvY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:21:07.1173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307e1fad-3191-4f8b-c073-08dd3649c80b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923

Have additional check for max channel page during the probe
to cover if any offset overshoot happens due to wrong DT
configuration.

Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
Cc: stable@vger.kernel.org
Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 258220c9cb50..393e8a8a5bc1 100644
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
@@ -922,7 +927,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 			page_offset = lower_32_bits(res_page->start) -
 						lower_32_bits(res_base->start);
 			page_no = page_offset / cdata->ch_base_offset;
-			if (page_no == 0)
+			if (page_no == 0 || page_no > cdata->max_page)
 				return -EINVAL;
 
 			tdma->ch_page_no = page_no - 1;
-- 
2.25.1


