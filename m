Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBF240C9BE
	for <lists+dmaengine@lfdr.de>; Wed, 15 Sep 2021 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhIOQIj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Sep 2021 12:08:39 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:54656
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235511AbhIOQIh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Sep 2021 12:08:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl03+7gVT4jrdMInMbgFwWlvWcsaX9bYfzkFAtMto6zrYUR8T7cK0jFsQNsDDUvdRNmDegATiB//LxMKBlGIfvjN+fyjPo5RJju52CPuRsG2/30UoCYHb85DlDHt1fttURuHQZ/JD3U6dpc1dNimRCPP1kWTuq1MdqS7LVzPw2Onut+nctSkVsTexXWI/bManMm6qKk58H14SMvkv5qb9oDjviJQCZi7mfvwiZeF53c56h6JNA40CQb9xWmzU+c1Djg975RX1vMzMEABTp5d49BC+sdOeD4xJW7h2UId65PKS1qnKgbAk0Wo4WyIMCTqEWPJLO38ODaUV+GYHMovaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MrJWDe3XgY63qao6AujTjDS7YjQrF4de2NAWEp9lUYU=;
 b=PxlcxQH9yrGlU2O+ZKSZoyDe4zN9aT5q2gd6pGpFgwSlcKRACuLzKwHoTLliCEa5LTv1Iu20VaTfOawvDN96yfNKASSJrd/50iZ+dmrUKJAXO4qZx3xQ3a//cm0FyqJ9MHOil86EMZHcgBa9H1GnPNCgNPkDI/0dwpVnNqMgZrUP5CZeGSA347YjRlwamefyi76X1IJZw6TNLcTkn/G+IXaFIdJBLp+DqQ/HhWAWBSL28RVkFrtlk11tEOwNNPxjaVJ9FGIIjJJBGIrbaE2WZjuQiSIykEUxzyplMbgvcnEHmdfEsnMXPR1KVA4RjFpvKp43Ot0dFHsDpNaXh4vZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrJWDe3XgY63qao6AujTjDS7YjQrF4de2NAWEp9lUYU=;
 b=uTVEabdW5QG4yt4tr6XJDtkFJnVRPoVL6HRf7Fjxf4vZNO9Z9yHkgZo3EOSTV6uLDJCxzBL9eQqmChSfQxCAnb1v2QtYjyO80lw6SqzGyl5b/88h+2rAnIhT2R2thu3gQwLv7X15fUUUPb3FZPFSD33a5ODxQ55mkg+SHIAzhOlfZnZDXFBUbqv3q84Q14VAQfJTM9y0oZL3qMy8ALVijHHzRI/ZBToI+rcjiOvTcEELppiz+l+8ORdiLF9DQh/GJvqWp7DA4DqQuHe2KjOXPKx1Vdl7ub09xBpXbq5TpElvj0/P2DkEThRP3Olbf+oE9HNsTpNlSeEnl8lh1UQwqw==
Received: from MWHPR15CA0041.namprd15.prod.outlook.com (2603:10b6:300:ad::27)
 by BN9PR12MB5290.namprd12.prod.outlook.com (2603:10b6:408:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 16:07:17 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::e1) by MWHPR15CA0041.outlook.office365.com
 (2603:10b6:300:ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 15 Sep 2021 16:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 16:07:17 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 16:07:16 +0000
Received: from audio.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Sep 2021 09:07:14 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RESEND PATCH 1/3] dmaengine: tegra210-adma: Re-order 'has_outstanding_reqs' member
Date:   Wed, 15 Sep 2021 21:37:03 +0530
Message-ID: <1631722025-19873-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3c0f41-1345-4262-31c3-08d97862e3b6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5290:
X-Microsoft-Antispam-PRVS: <BN9PR12MB529040C0DE8A1FFA596EF90EA7DB9@BN9PR12MB5290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQbaDOaOT1GbDRIguMvpXBzODbPS7BgLzwuKZ3SV0dCZLVKdQxJK21R6AH/JFVrPak+kMKsjZt8IUAJcdREsUPN+RMf9xd6RCqgtP2aLmo0+SZv4bgd/x3n4j1HIpL1KszAVLilwGaSfsqIqe7frUEkv1A3nvkXT+jntj+TG857xZM4ZIAUA9bCq3GmfZ4Q6DfPrFjICqu3DBVAVYUGEgz7rJUFoRUqUiyEVKFEoY3Dd10kL2OCbM7a7h6iyz60L8DtBMblFLdzgJ4of+TfG9z5lft6oTAJOeBtIvF2m11cQITFG6sTLiEAhpJ4X/5ZtAY4YTmG+94TIKJ4DFWbihl0pIRvBk5KruRn1vZEGhzGLQ/YtFIj4tCDX+mmG9G9FnpWOkF+mUnw2jECnqnASpirQaQ1eTuF5dRIkKPENEBvacC6XBTe1lNzGfjt/9fscQ4mJVLO/KdzXveyfJDOtwZWNmuajB5I5Kpw4ptnGNFCM1CZheVpY/HPXeQDAyxUu1Dl/TcnRNZO4HcUIj8hmQRxRqGUXxbnmlA03/g34Cr7OnwmmF+DfeubuNtGP1QBYRZUfKjC3OvilBZlzsHpoi1uklCNdeoJK1XYsLuG5RU9n/8a2qKGo/JWsAh7papE529VpkPQ9CrNkwcL7c4mzeAAP7LPfXD23RrGGGnzMVzwxqJnYFzopcx85E/AU3yLmzNEI5FIDvQluBE6rjxfcajqVDkzZodmCRBrsvud4MDU=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966006)(36840700001)(336012)(2616005)(107886003)(70206006)(70586007)(426003)(86362001)(83380400001)(82310400003)(36756003)(36860700001)(47076005)(8936002)(2906002)(36906005)(8676002)(7696005)(4326008)(356005)(7636003)(54906003)(5660300002)(26005)(110136005)(186003)(6666004)(316002)(82740400003)(478600001)(169823001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 16:07:17.1022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3c0f41-1345-4262-31c3-08d97862e3b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5290
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

