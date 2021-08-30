Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D4A3FB32F
	for <lists+dmaengine@lfdr.de>; Mon, 30 Aug 2021 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhH3JiV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Aug 2021 05:38:21 -0400
Received: from mail-bn8nam08on2081.outbound.protection.outlook.com ([40.107.100.81]:50881
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235787AbhH3JiU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Aug 2021 05:38:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azr6HFkbYLUV6cknZNOt+TkdD/qrZxnsgK3CBgjyH2YTRENRbM1uoG/XnP6m5t0dv3yYqMzGreqR8OgP7Q1g6MH1odVcAPHW5kI0qYRLh5aKn7UcUhyu6tF8SL1f778CSSehtg7ZLdg2ebfG28wqgwqdfs0ihOb9HpSJSKtBsa6bNPmRw59Pl5DEegbBbv6Q2T3JJDVCLe+J8S5+Aj4CRpcWDJMJl+S+1OgEv55OQ4WumTARL8f0EsYRJ1NuCaDl25S949H4BqKabQZ5ajqHlTB+VvVjfoMdu7XoFVEi7OUvDvPAqXP3oyRtROICBf3jbSrHFy8WrasPPDUNCSF3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrJWDe3XgY63qao6AujTjDS7YjQrF4de2NAWEp9lUYU=;
 b=CgBBUX0YktFDcUePYtKh63BpeGdGZZ8s/Wr6qRV/t90CGhnuDWeHYQnqyNdiHPX0TiphjGiFIGaRxz79f3g0cJpqSQqdt1xWAg5sN3zU6kDffjXn+prZlmMztZJhfzX9O4a8w4QtqHGwc+vLbiss4d8PtAPw7wQSpSBHphZwjz+U3zBPGcV4iaM2X4ZObPl0K0iFf4jl272FUftcEBjyBfu8O7soA9aaYRRXmdKKtsfFdOmJ3gqC9bpmfn9hzn4KYv2drid16FDTZIxdx7uY861lWns3XCOCPNEPcSAag/DF9R2eslDhwifEWzuVK6LWe24lcYPYAleN0lYQTqjq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrJWDe3XgY63qao6AujTjDS7YjQrF4de2NAWEp9lUYU=;
 b=h0hwW2YI7nkruq+qGRu01cXxLgR0DUUHX4J25z7CS16FgdRbbhV48ycTzrWJ/RyDsfRRtcIjP7kLgnr+JDLZoe9lgQeDU1exa50Ey/CDZ5fW29NNitR1m61jraMargKvEhSke4Nc72kCLoLFEci9EjBQLr6oux281qxQBCBnP+lVD1FEHdHtYaevfxQWFtCNIBH42GWjuKHOa6Hlm4bLdonTlhzo9fKhuwe1Bfz3Gr5NKcsPe8354gPPUM/d6C7GtX3PkyH6i8qKOzpMGj2fCsa1RpuXbWYr3j53yRTUiKkgjUf0eIpsP7lZPor1QFwJqdcAZGcOSjnWhjpPo1oIkg==
Received: from BN6PR12CA0035.namprd12.prod.outlook.com (2603:10b6:405:70::21)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 09:37:25 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::5c) by BN6PR12CA0035.outlook.office365.com
 (2603:10b6:405:70::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23 via Frontend
 Transport; Mon, 30 Aug 2021 09:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 09:37:24 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Aug
 2021 09:37:23 +0000
Received: from audio.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Aug 2021 09:37:21 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/3] dmaengine: tegra210-adma: Re-order 'has_outstanding_reqs' member
Date:   Mon, 30 Aug 2021 15:06:59 +0530
Message-ID: <1630316221-9728-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630316221-9728-1-git-send-email-spujar@nvidia.com>
References: <1630316221-9728-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d6621db-6535-4cd6-916c-08d96b99c5ca
X-MS-TrafficTypeDiagnostic: BY5PR12MB4084:
X-Microsoft-Antispam-PRVS: <BY5PR12MB40845F008948B65A45034FCEA7CB9@BY5PR12MB4084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OT089bpbXQXTd1gW5EzVqDWuVLlQd05HraQR/KZX9WNSz2Nfc6Ikt9GiV7JS19FGAgMQUfeYAtWALMmowFciwwY+ly316MivKNmKDU7Gkc/1gzdaX3xSity9lg80EIECVwQxaGPIe1+Fieu8abxYKbNbrPjpv9LgQKxJDe1H5pMZ1DDYGQqStYX+w3JKsvkUlKEz+VfbIY0+ZZ9mA0v+rRMbiWnD1Czlqbx6lcj1WO2Wm6PN/yx5vTUpEFgDc7IXyFTYZQOQ1i5k2eSoU+dlEUJXKMBX6ws0T4DlnWBEy/FXxA+gM14ZiZXiXPUef4kaRjnGdiE78G/Mngm15yc8ejQbsApNt4GB4hmasHfvv3HdPP7b/681F66kvqwf8PgJnGZ2wyR8BxGPYYrbs5/2qVS5COQgGyDYSNl1c2rmwwhbV80k6mkZVZqaBJD+HND43muaCYEJFCYbDPmLev4veSgmCnDuh8m9ILg1oyuCKfSzFliv7fgAv4PmbKbpsHpVL6oJx62dCJmz9YiHta3sqzESIW61iLFpEMErVSFhIrHcOS+k+DsFOZOGsEQGIg89JGY7sd0ZSdH7kspy16+YTwUJCPzs1yUohw/UvO9Vu16VpyHcjR4cxx83q2XFmyKs29TFwK+RywL6ABDBYrLw7lCbWcDQ+09xTXcMn47pBzAGcQffahsESZtefuRHVG2DjErj6ibdD3xb7fcB5s3JtV+59GEi5KznMjymGZR0fzg=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(36756003)(186003)(82310400003)(2616005)(26005)(2906002)(5660300002)(47076005)(82740400003)(8936002)(478600001)(426003)(6666004)(8676002)(336012)(356005)(316002)(4326008)(36906005)(7636003)(110136005)(36860700001)(83380400001)(54906003)(107886003)(70586007)(70206006)(7696005)(86362001)(169823001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 09:37:24.0582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6621db-6535-4cd6-916c-08d96b99c5ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The 'has_outstanding_reqs' member description order in structure
'tegra_adma_chip_data' does not match with the corresponding member
declaration. The same is true for member assignment in chip data
structures declared for Tegra210 and Tegra186.

This is a trivial fix to re-order the mentioned member for a better
readability.

Fixes: 9ec691f48b5e ("dmaengine: tegra210-adma: fix transfer failure")
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index b1115a6..caf200e 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -78,12 +78,12 @@ struct tegra_adma;
  * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
  * @ch_req_rx_shift: Register offset for AHUB receive channel select.
  * @ch_base_offset: Register offset of DMA channel registers.
- * @has_outstanding_reqs: If DMA channel can have outstanding requests.
  * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
  * @ch_req_mask: Mask for Tx or Rx channel select.
  * @ch_req_max: Maximum number of Tx or Rx channels available.
  * @ch_reg_size: Size of DMA channel register space.
  * @nr_channels: Number of DMA channels available.
+ * @has_outstanding_reqs: If DMA channel can have outstanding requests.
  */
 struct tegra_adma_chip_data {
 	unsigned int (*adma_get_burst_config)(unsigned int burst_size);
@@ -782,12 +782,12 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.ch_req_tx_shift	= 28,
 	.ch_req_rx_shift	= 24,
 	.ch_base_offset		= 0,
-	.has_outstanding_reqs	= false,
 	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0xf,
 	.ch_req_max		= 10,
 	.ch_reg_size		= 0x80,
 	.nr_channels		= 22,
+	.has_outstanding_reqs	= false,
 };
 
 static const struct tegra_adma_chip_data tegra186_chip_data = {
@@ -797,12 +797,12 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.ch_req_tx_shift	= 27,
 	.ch_req_rx_shift	= 22,
 	.ch_base_offset		= 0x10000,
-	.has_outstanding_reqs	= true,
 	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0x1f,
 	.ch_req_max		= 20,
 	.ch_reg_size		= 0x100,
 	.nr_channels		= 32,
+	.has_outstanding_reqs	= true,
 };
 
 static const struct of_device_id tegra_adma_of_match[] = {
-- 
2.7.4

