Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2764A5FF5
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 16:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiBAP06 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 10:26:58 -0500
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:37568
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240236AbiBAP04 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 10:26:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyCBodqsB7U00KL8HtbeCjO9Qo/R+crAC0pn0lWT41j7gqnKliuYJErcmxQOHBLE0dbgd6aMOdkfWIoZvsuTQGkervoH6guwXUccb46rfAeImqPee2b8HkM3ENrH8jpTyfJPVclh5cdXKaqQoXxxHA/1u2ZH9H+tPdjE+4zOAkQzXwl1Hybxh/hfBpS3Omh4pABu/LHlGbnk5Qa2ecm8iMSKu6/PiFWVbrfZQY2AzFhl2PRKMlLL+6jsAQlf6SolGvCbN1ebAISDLVcKANlcsUQyoYvtWaVjqZueZojmIHSMo5t+CBam6TwR6v78ZwE+OMFoV0QR3smkff6WkA4iGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w9Ppp9JUJjB25TU8ve8Jnj5r961ZTs/riWkJLEucKs=;
 b=bYrpI2rxkjrhUsBwdv6mb9RxLDNcjFQtWVcgafXcsH+SEesK+FrN8xu6VoeiZNHWJFrc3mgj1BiqSIQ9s3j+5Y15CcE9c7h48X65OFAZGC2YX0+JJRLvO86Pcank8PKYQmfT3UfplYukQZCiwzCrNPhY9FYqKLBtPPsSsO2GFrNbFx0j75iQrAL7WhTfetm5kPqVCwmgVqUyqJr3Jq8Epx69Nl6Esujf6Ku0SJPpldVp/fv6WZQaN871PAoVKv7eEl718Bnmk6wX+18Qv75ICQjlZStISXRk4YfnM0yNKGWJD+0/86Z6OLP3egPFaNrW/cfFaojUiWfM4ywn+DyhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w9Ppp9JUJjB25TU8ve8Jnj5r961ZTs/riWkJLEucKs=;
 b=eC7bkct1k3zS0+jP79g9yDjwygBaRGFV2+KbBcJ/XXR8OJLJJCYb3LLCfv6aEn1IQY5kh95iIu7FAcKnycoQ3wffxf2vtyfguxHl8Rzh+HQz9dy0wS1xG6Qq9B2d8q/XlvOnuszGfA68R6oEVSMBdzWuw/2nJEbrBpW72CBHpQsEDNxwOdl7Ju+BfU1b2vD+/9YX14f6XIju6uP1RFLGrfqvskbEwBmfKhnXWCKlDEp8uB21FS1IXS930qIWu6rzKhFZVLTEToHq9FKmYL9EUnV9gFzrHjbhU2ys2NCrTCfHDJgJdm+vXO7jp8yELtxF/PzyyxWG/354YM3mpqRUPg==
Received: from BN6PR19CA0108.namprd19.prod.outlook.com (2603:10b6:404:a0::22)
 by BN6PR12MB1683.namprd12.prod.outlook.com (2603:10b6:405:3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 15:26:54 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::20) by BN6PR19CA0108.outlook.office365.com
 (2603:10b6:404:a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 15:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 15:26:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 15:26:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 07:26:52 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 07:26:47 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v18 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Tue, 1 Feb 2022 20:56:35 +0530
Message-ID: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1623058-2ebd-4344-2ecc-08d9e59746de
X-MS-TrafficTypeDiagnostic: BN6PR12MB1683:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB168353E82F5E2BF32E92EA11C0269@BN6PR12MB1683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fg5utH4unIfKoCc6v0ZYYCDmgah4HuXl5UZf2WOK+gOl4jrzovBma0qgTwdZLpQyoRMUSzNA6S8dK5UgcOL7fuAPydIGid+V1UvPI3no1ch/b92fNe4LIX1iGwZmyKJpdIozM2XDJsXrZpnnjlopv5z2w5i6BH19fxv28Dv/7d19y1HEaP2WERWfDNp5n7vT4NowB86axBcO9V7jeKb40E8iKR6BvlrKzoHhuQQhmfuU5t2voBK4jllePe4h2N644eYH9oZ06nXfMJwT8VozEaJnhxO8HnH1wagjgiEXtT0j2jrb6JwQB0iUnNBbytYUaSi+WPvpeezSYZuqgyhqSieIaFiRyAW9b7hgqRqWug3PaCmfI84A6zQRBnoUuEoFt/cc/njUrG0Zf6D1AlBBGA/fCNW0WnsEl2kABIm9I1q+7yQSxT953kP5PZiifMGnfy49TT4zepiJDEFQwz691PC3FlHe35N3jlQNhSaf3Sm8lQtlj1GMMmVCgaCTxBF30gzUgaxdwokQb+3lWtchIXtYkeY9g1SpKvxkxDBMXQX0E5abMGUbz87ULJYj605lbtQgEHp6XiFNmtpnYGA+qsJhPxxG5qVZOyY6PzL5fBHJvkB+fqqV8hj/LsMA6JPzAQCImblQoVDzQ8ZUgzkyld6l/oR9n7rcZkmvfVGJa2grj8RvExOgg/242od9AA8gc0tqB/PoXxkcp/060xjbRNXndTqbFwiWGf+WMv6iI07Gd1X6xzio0qAh1EIJUS/K0M/SFE+wtDbIX+RLAva0rg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(107886003)(47076005)(40460700003)(82310400004)(426003)(86362001)(70206006)(36860700001)(81166007)(921005)(356005)(36756003)(70586007)(336012)(4326008)(8936002)(186003)(110136005)(8676002)(316002)(2906002)(5660300002)(4744005)(6666004)(7696005)(26005)(508600001)(83996005)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 15:26:53.9705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1623058-2ebd-4344-2ecc-08d9e59746de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1683
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

v17 -> v18:
  * Add get_residual() to get residual in tx_status()
  * Added label for device tree node so that the phandle
    can be used in client devices using the dma. 

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  110 ++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   42 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   43 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   11 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1502 ++++++++++++++++++++
 7 files changed, 1710 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

