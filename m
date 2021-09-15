Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839F040C9C1
	for <lists+dmaengine@lfdr.de>; Wed, 15 Sep 2021 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhIOQIl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Sep 2021 12:08:41 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:20576
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236263AbhIOQIk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Sep 2021 12:08:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKCNBYpXqwI/bqsODSkP2CTjPVENUegIMA3n1TU3SPCJL/ctdG+RqTj8hC9ziaTNJ+azWAHk3F1/8Rrpo/YSTHr0tmrWoECzUuARxqxYryO7swK07FozL1ihmdD1ZoBIExa6dvVeHRNbIq/feZSu/vo7veg0vM4stXOAGOEjkMCejf7XYW+Yzb3YTYkz3jZa96twc9f1pQPO3qQzlo/T2rhpczzVeLN/FtAn7oPL1E0ihHCf9Cu/mbukMEu5AH6Hb0MYa+tKJcB9nPNPG7R5BVActVw9s+ZB/5cPyXmTRHiHi64zvBfTwszhvEAXejsVQZ8ufy528impf4/VsRagjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=grzgjKM00vgz83vYDKMdbVU+EN9O8y0EHhQGjbrKRUo=;
 b=IZVJtIDuVLossa86YgWsRia3JzndCsTn7tYsV7T8SEpjZZkQyXc53+yOYMlqUb5nEuR90BfOws072K56njyxVf4AeHm5Ud/98lIQ68+nhFhsVOtzkQ5NEwuTdW9xZDXY2KtWqOl0vOgMzg87zAq04GXdZekDDS+8JYmRx+3N4ZkvdRVpUOzECFgzUaJi1cyCjcgIZPFAB8zpQjdZqL0ZzW4oeDxN+V9VKUtdATr8y+xz7PGuh7p7cw6EjGmlGSl36MzSN+K595/fU8Y3P5PE3zXBMBKgvWqlFMw10hV7SBZRmeSUqseqN9tSjL3K57EPT+SFykELQFBk36QWF5OC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grzgjKM00vgz83vYDKMdbVU+EN9O8y0EHhQGjbrKRUo=;
 b=fUKChu5NwdD933w/BXIxvsrQ0LeQSNjL8dtqaDf5QZVP0eslHH4/lGaXe9EKVaigaj21ln7fyp71DMq3HudaSRsTtihDDwrTlQTsmHUgQTR0xtBcucLrTuuXCXZzQMgUY9kGFeiX+KJKAoph3VCp5ZeTkIHia/+YTZ4j3LHYqtHdXl+gBhktnK49dQCRjZiB9SMTYoqaNfnd3lEJYPiHMsnm23Nj91jzEEaF5el/w88e/cHR0b6dk/qLF0FJXVewru/rqr8+7nG5QL0+f2BxUZbuvKTKdv5LvhvSHeK+tKMKXgfpaQF4kMRAflLo4F3QatruURu2o7EDdhsAVmJFqw==
Received: from MW4PR03CA0204.namprd03.prod.outlook.com (2603:10b6:303:b8::29)
 by DM5PR12MB2389.namprd12.prod.outlook.com (2603:10b6:4:b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 15 Sep
 2021 16:07:19 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::66) by MW4PR03CA0204.outlook.office365.com
 (2603:10b6:303:b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 15 Sep 2021 16:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 16:07:19 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 09:07:18 -0700
Received: from audio.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Sep 2021 09:07:16 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RESEND PATCH 2/3] dmaengine: tegra210-adma: Add description for 'adma_get_burst_config'
Date:   Wed, 15 Sep 2021 21:37:04 +0530
Message-ID: <1631722025-19873-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f2dc83-15ad-4d62-0cda-08d97862e53e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2389:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2389D15BF43B4CFDA4B434E8A7DB9@DM5PR12MB2389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcjY5QtGlgO28ILL0ZHHxwKzKTOUu+fFq+MXq3j5RMmxxsSjHd2A2v9poDjbVOtNT3FWMEXR+6LPvfhlIitCqWm0bOca2mYbU4r4n/zQObhOI8YmQGCrq0vTo2UpwTtfdDxoNNdFIOkbsOvnOog7FXGIr+9woMUBaYcJ2MxM6eT/JkRYCYWcOKXCj5F3Qi4/9ic/jeVoh7IGgmJTqq4ndZqaDx5+9h8KyR+fM1uefJFwqwms5bXhvVlWkFF+9GlputxNW8sDffWQgPQvxGMOyPIMsD58AkOJ03lZ6jX7+MW63QbbnhNOVJUmY4qmsFH6KNfTqNDxTp/MM3+cjwgZp0/0L4sOIbqOcZORtbafGMXCctaecdFDvlNA+kLwxz3256aMIUMygsezkrym3WymkhnCkaVOYIX17J7p3q3KvwzL9EzPqs/MIwiHVqi8jACgQ/PeNRjcklaEh3A6RalsIu4dowXjj1YH+n1LeosL1CV4rpkCOfvuhGnPZrWAQT41pICOYRQ7SLacdX/QQN8sp1omBjzuHOA1X4S/Vset3pu2gQJjDpPxvvom6yacILskRJXuVVPKPQP7TCkB2wh3cvr4TUM47rz3x81B+qm7tGBbhK4i1M88ZNsNE90lbsjYCBDxEEXmkzA8ZX8EyevdDZu0WCkWP1KQqIlqhSz2EqJnJB5DHPWyAdfQk+XOqFz+jiKYKebRCsc+mB1ROf4FDg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(8676002)(110136005)(6666004)(478600001)(7696005)(82740400003)(70206006)(2906002)(70586007)(4744005)(8936002)(54906003)(107886003)(356005)(36756003)(316002)(86362001)(47076005)(426003)(36860700001)(26005)(186003)(5660300002)(336012)(2616005)(82310400003)(4326008)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 16:07:19.6713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f2dc83-15ad-4d62-0cda-08d97862e53e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2389
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Trivial change to add description for 'adma_get_burst_config' in chip
data structure.

Fixes: 433de642a76c ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index caf200e..03f9776 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -73,6 +73,7 @@ struct tegra_adma;
 
 /*
  * struct tegra_adma_chip_data - Tegra chip specific data
+ * @adma_get_burst_config: Function callback used to set DMA burst size.
  * @global_reg_offset: Register offset of DMA global register.
  * @global_int_clear: Register offset of DMA global interrupt clear.
  * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
-- 
2.7.4

