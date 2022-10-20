Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C26059E2
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiJTIdt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 04:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiJTIdh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 04:33:37 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520DC18C958;
        Thu, 20 Oct 2022 01:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aua1kQDagCPG/tx1b2TA7yl+WHrb3g2Kn/Ekjiznnt4XB8XzwLC1p8q4dBHFc7Q72sSQpIZmz8NOoo89B9R1F7wAjr0Oh00Vhdi62taWnDOIiCChjmWMs9WBQZVPx1nIRpT5g94fWzCAWQXKudtU4O4969RqQgpBGSZEKh+VGJW3BQ/dWJVh5opWQ/MAGXaS3bKgOfqbxJjnLdcQfaBRBXhmq8GJHdE1fPLaO8cJ2mibZJwIXHNwLpFgOB0WiOwm8JnfviIQSMfjgk+Gv1+AL9P2swEu91pTPO+l7mwKgQM5ICkomLjW8H2DB8QRzR71dJ9QOn4VFSOJQ0AxfLH1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEylTZ+nZvtt7CtuSmVaGt1Bz1AlbWl2lhzMYhaJFCY=;
 b=kiTy4FjHEvpjxEbjGkF/FYQzW2yyVsbqjt5HJxOMnKlg33gtqVywhcN7T9ve+iPXDbD9YvqFvrKa8OXo4Qhq1jId1jUkSI+R8V3ruE+LPosB6Qo7VaQsbtPpez++HYUTWjaAjqx6khNGrhBNDHa/DIR8/6sY4EcfP3p6B/iskuzC6ZvKKNeWPpdGOugJGYRqg/ccqBZAZYsZ9+0ZXE92OyVfQXsfVvd9y9bPdn6S69HbLIRG+dg8aCPMCGSV+6pDwmHcugwvks7oL9Qrv9ppn/7zLgSwyZwi1qH16lcRbeFXZBo9mxZJ22VsLNJhWaAeuqd7aIM5YqCYvpkbnONRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEylTZ+nZvtt7CtuSmVaGt1Bz1AlbWl2lhzMYhaJFCY=;
 b=PEkKFL8FckK7G5pg6QmrgKlG0HPoZg2hkdpW27LInidP8FqRPAol/zo4wAFnINVMMgehoPptU+LCc9VMn+3cYqGx+/AnWTaGj/dIXiBfFen+OqghJsTmCRzFQCoVVcx/KDcryUnJ8B0WjdVsVqBNcFCT0KpQQ6WbOfqZTsZPPMXMSoFXYzLHD6RU6EVu3z+uvh3Ph4m7RgohJkGZxL3HMiz7zlFkKi3yRFsH5XD5r9CAUbHz3vg6BPnExZvNnsO57DAiPycvO/hfzO+bk6FEGDrOURGMXrlXhc4Y5xJHwpFiX+rLabaVLx5YyGDh60SlI6HM/lg2We23uf7Xhot/ig==
Received: from DM6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:5:1b3::30)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 08:33:34 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::cf) by DM6PR17CA0017.outlook.office365.com
 (2603:10b6:5:1b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 20 Oct 2022 08:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 08:33:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 20 Oct
 2022 01:33:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 20 Oct
 2022 01:33:31 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 20 Oct 2022 01:33:27 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH RESEND v2 0/3] Tegra GCPDMA: Add dma-channel-mask support
Date:   Thu, 20 Oct 2022 14:03:19 +0530
Message-ID: <20221020083322.36431-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a38786f-e673-4ec5-356c-08dab275c6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4ON2ajHWOCThhcutX99WmnyBr+x73/kCes4UdTZsC+u25Da3UG0BrQmcLsxis9vF30NpfzG8gZ02Hh/ILlY7e6DPqYQET0lmmErZ2HTfQfzFEaOzjmvzfbKqRxlsUGPwMHfXkOZkVyWi5iCnn5qOrtcQtV0OkNm9p3iez9zXh+ppGuqSjpj5/AsY2FiLMkui3IX7rOW2ZIJt2K2ik8HNVUnNglQMtnjmp32D8e96KFD36FZNGWtZ8y5qwuL+B70zWgrSRq4wxoGz0DMcV0Qs74PKZJCe0JAiUCHnVbLHIEOt5K9dzok+Ud3ta54VAS9Fln25sbX87OZlb/OdzAF4jg+RQbRUw9wxMvvnAvHehUa9355ljadEfhqjewo3Yt7Ir4uHngnnxNJWW6sxpEhYwD/ALKKcHUE2f+XUovTIKJWsLf4Ubhqz56TMikC92gXxtCaYtHwC2UyHyV6WgKibhyfp0Ki1PeV2paPGAZ7BDhEqv+S1K00cA/XWiElPK+biXQp/pXO5K3GHnUy0dwV10ae+p8Eo6/z9iaulKCRIov0JDm6Ae421p8ndtD3ar7WzHsMbiH4ZKAW05sAUVWfhCN+ydWLZOprzeLT42TOnBcxbJVEishQzgl/0Nz6mxR7/gqnS4l7x4F4BqQy8d1VxMhxCxDMUouK0USdKtreYNsh7yhQ8NniTOFiEQOk+X+c8oFcMtiFWK5oRfr5QYdvkhJBF2yEu50XQcTeTfIcysKqP5mF80XtnXxE8GvepDqOVVKma5IuLPist483ot5TCSOfDztfdSOmpQs8anU14Cs=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(110136005)(316002)(7636003)(356005)(921005)(36756003)(70586007)(70206006)(4326008)(36860700001)(82740400003)(40480700001)(86362001)(83380400001)(5660300002)(7696005)(6666004)(2616005)(478600001)(82310400005)(40460700003)(26005)(186003)(4744005)(107886003)(8676002)(2906002)(47076005)(7416002)(8936002)(41300700001)(426003)(1076003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 08:33:34.0136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a38786f-e673-4ec5-356c-08dab275c6c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Read dma-channel-mask from device tree and register only the
specified channels. This is useful to reserve some channels for the
firmware.

Also update the channel number and interrupts to include all 32
channels. The current driver was using only 31 channels as one
channel was reserved for firmware. Now with this change, the driver
can align more to the actual hardware.

v1->v2:
  * Reversed the operands and used BIT macro in 'if' condition.
  * Fixed warning reported-by: kernel test robot <lkp@intel.com>

Akhil R (3):
  dt-bindings: dmaengine: Add dma-channel-mask to Tegra GPCDMA
  arm64: tegra: Add dma-channel-mask in GPCDMA node
  dmaengine: tegra: Add support for dma-channel-mask

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  7 +++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  4 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  4 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  4 +-
 drivers/dma/tegra186-gpc-dma.c                | 37 +++++++++++++++----
 5 files changed, 45 insertions(+), 11 deletions(-)

-- 
2.17.1

