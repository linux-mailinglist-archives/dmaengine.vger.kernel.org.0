Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDDC6030BD
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 18:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiJRQ2t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJRQ2r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 12:28:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D20BBF31;
        Tue, 18 Oct 2022 09:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmZU/k1TtGo9zDf7avyPKYWgWsqhJwVi4NZgdm3+ASEp2Hw1fA/hvQYuJsCVgDcMl9DKdshkde+x40y1vag2ShqAzkHemplUh95qJJKZaZOcgi/UlAdn0WYDpO6WI3987RF9tpJkLU0JRlaTpD81GTfBrWEbZATo9OsUB13tAbCkqgc11PRHsqQFBqN+/WVOHj914be3cuht71tqEMgrX/6MvwD5o78gT/ptWKWw5vKpKiLjjwu8bz/soMilJE0NOsFsUMt55xqfX7axwQ92vj75xGKuZ3ObpcHsUjbJrz1KRH905OoOCmYCl6UX9JZaI4XTTcrveJeUPEMkYmTxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEylTZ+nZvtt7CtuSmVaGt1Bz1AlbWl2lhzMYhaJFCY=;
 b=Kq2FigDcrqbkDQWUZ7luVVhaXAcnZ77hBiO4UMOPqC/y+WXNIrty36Y074yEx74toTRBDtZJEn8NF29OgFcGP3eL+9cnINqTF4Vk+VFjR5msaG3VT2WiLXF9YpWe6WcWcTCJfdta1TkkhvrsUf3m7MoiGigVLUDlieJtyk//3UvJYLSJ+5w1Rjbb05+pRmUnw7T8i1JR3tjxjMcYsccwJMEt+em9/J7br3y1Gd6IyS+hw4yeNx77EKdTQxbv770m+X+s0PBpcxNZDHKYrQAaGUTn0BX/9vfx6dhwe6OV15RO9o9y48Vz1iEvfaUQZnfgqe7wjk1EbQmW44uB7akRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEylTZ+nZvtt7CtuSmVaGt1Bz1AlbWl2lhzMYhaJFCY=;
 b=ai+7idmzrWY91a8TtczZxyn5HWfunHdbEL+xx73HWYuyY3Gwwy1wXCafnnYsYPEcTMGLCcD1QU0ZQIav5rF5cZ6PCtaXypV86B06J+gDwihD56mbmBDaQKxakEpm79G6av+1xp5IP0C+TNwX75LKrFSvOFAQ25G1Opp6Ip7TiIXw2q4Ax6x+FUYtZ9gYsH14KlmBBUd4YHYguhe3Qpmk7RWi+yqBsatQrNv5F3FaRwpNRGYLDSBztcVAIi2QbxPPrTunSlLxrYkDwttWeC1cEJKsZM/I3NLP0SHa07RllrIQgpkkwu3qaJYfsFDZwbhnwbn7SjN9vCwzD/Ht2Pn/cg==
Received: from BN0PR04CA0103.namprd04.prod.outlook.com (2603:10b6:408:ec::18)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 16:28:44 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::68) by BN0PR04CA0103.outlook.office365.com
 (2603:10b6:408:ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 16:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 16:28:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 09:28:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 09:28:29 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 18 Oct 2022 09:28:26 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH RESEND v2 0/3] Tegra GCPDMA: Add dma-channel-mask support
Date:   Tue, 18 Oct 2022 21:58:09 +0530
Message-ID: <20221018162812.69673-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 059d037b-c086-40eb-3432-08dab125d327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3yVRo0s4IdZFfkWSDlcPuFj+XrQBHm3jncxFZMboFZS5Nu8gIadV6pItIJm9UbZL6rGLcMNEqdOuNjHCruMu99sqdK3oBiwuQLfVlE1D+xR21expyLiPTA9NQ/3toAGa6S3PXEQzNYB/gmms04RotFhi+r3QqPmTmk7jcDPDLd+qW80oRzpPqXNAoGjmE068eD3qe40Nl7PcHBbGIIY8WGkiAELPus3oqCPSQFFW7Yly1Sv0V4XeaGTtyzPCpRhS0N3jHTk2eNmR9GCp9WghRKs3OTtudSj+f7uAxlZLqLINQfydAsjGY7af4yPaAiqJKypc/Re/xgWS6+U+tSeZ744JpfuxdamqSXMsFmRwenOxYM9LhwAA8erTaqSWIRiVdxFgwsOkhr4RY8MtldFYj9PLxT4EEP0s5Ld2Ve6A3n2IUD4trn4iKW/Vn9cO8F1tmU6qwUK7mnPmK0Yfe846tDdSJahWON4ZNBrL6i6y5Uponqigm1LyvSmzxBQYFa4s6NVnifOKfGKX756j+5Y86EbsBjgpQ83Ja2cJUU9pTZjbO1tDQWap+pLCYEfhki7srGDB2Ui4y/SPR4zw6fD7VchTllICpdp997wIGVM0MnDIWqNSyNKOtIe+jVF7RHW75n2Kh8FsdxBpdobCmKBH1VsMpH4c+4Ekb1V0XeJrOWUxj0Gn7uS5Np1vvN+PHL1JgrYbqTRby03c5PE954vIqzTox3gvWpdYkoanCgDpSwQ7Hs2oGjknOoZt4JkEZ6hf8UBuhuhrbhLhsZjuGEXog==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(2616005)(336012)(2906002)(186003)(1076003)(86362001)(36756003)(40480700001)(4326008)(8676002)(7696005)(40460700003)(26005)(41300700001)(7636003)(82740400003)(356005)(82310400005)(36860700001)(316002)(426003)(47076005)(70586007)(8936002)(5660300002)(4744005)(6666004)(70206006)(107886003)(110136005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 16:28:43.8471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059d037b-c086-40eb-3432-08dab125d327
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

