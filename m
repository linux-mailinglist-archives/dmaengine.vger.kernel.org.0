Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13866624816
	for <lists+dmaengine@lfdr.de>; Thu, 10 Nov 2022 18:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiKJRS3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Nov 2022 12:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiKJRS1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Nov 2022 12:18:27 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB78043873;
        Thu, 10 Nov 2022 09:18:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNHD4B5rcYPZe0uf2ZLFdKHYLewsJtvR7FCGQeQlyNX7a97UhEbPafBFGpowAPma41YwptveycUPlHOQJ+fSGfKp+udL3UHgHdAoYj7s3MnhgMCubA9HdtzyX6ICSe2J5CsbK6h9+5a0TgLuj/qYQ7o+4JhmQ5IhXuszRgSxl1zM0jkhJpdpHBfqowk/qtkVeAylStHcDRqTRCizxzX+w7LO5Zfyo5rhWIvo9mlGK4T6K5lk68JP3NJqSbyEyxVQT8PGbQALMvH1Jea6nVW0VAEmi+r2NDb89xD3mynKqrmDPH41pLFMI0dq1ux6U5H4UO4nbC7q6wvoR5Fil258xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/78lYH2zH0jSLlgD2H/YFbJvMtKoC1CS89lWS+Ikhcs=;
 b=Ya1ztVd9st5xT1CMKLswUcDft7k8fiU49/1R86f3hkz7QlwBd+6aI4E8QOvwkEl5F52YbezQLYQiBUkDbcmcPRlUjQuKFlpXtujRdI3T2YQmoMe++vCiWZ5bMwWrrwqvu/x5Q6g/w/H0U9m0GkBaLsp5LoI7MBqaDSHB1grY/ybMxQcIoLIFq+U1X9gO+Y92xhxa4i6JJOKszNMlbgJotOdHK331ItAEfX6ZBIn0469QdiLY37uGTQQ5fjK6BShGRe52krgoD8TR8FIe5SWAJgfGD9Xfj2A5UlY++BE0B7rETsN/kIS4Kn8BqIIt1sV9LYRp9f1is4yi3u95J2LdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/78lYH2zH0jSLlgD2H/YFbJvMtKoC1CS89lWS+Ikhcs=;
 b=bqbt5ERdCgKrc3bGds6ih61E7IFIpIzzm9kuIGnwjWmhNKbUjdy9Bx2RdbExAaXLF6MFzP4W0F11EUbGgHDRUz5TjGbxP+OUlPHnsbBQeZrMli4rIWKlx1uEg9hbU3eUNa/NcJGS/tXKfhv9TWsv2OnJdUEoCLxJqVvMhmy5Bf6l44Yz1ALZwN+uVfdAiXB9P7ILLDbjRYHURs027YT0mTZJQV27stru7aRRKbuql2sm+Yec+L/8PQVDiAMxVM50nBkAZzWq702btPplVqtPtVE8s6gSWGHpPeKGsDU1fmJnViMxJpvgrw9bVmuPEUOBSxpOXJH9I/icn8NaWdQ0kQ==
Received: from DM6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:5:190::20)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 17:18:20 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::31) by DM6PR11CA0007.outlook.office365.com
 (2603:10b6:5:190::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 17:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:18:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 10 Nov
 2022 09:18:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 10 Nov 2022 09:18:04 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 10 Nov 2022 09:18:00 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v4 0/3] Tegra GPCDMA: dma-channel-mask support
Date:   Thu, 10 Nov 2022 22:47:45 +0530
Message-ID: <20221110171748.40304-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e9399b-d8ad-43fc-3189-08dac33f9068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExUqrSuE3SsQH6xF2fdSmuKEi70baot1H0OK6rlNttKd43Bif80ZL9Qa4ae3MA2Ljf2rcQMa+9sWcTvU6V/co45+pcQElod7M6phKxItX883B9AVk1jiCQ/EzjBaZhTBc7tS2QEIcyIZ6boSwT+BLR7ETF3OaC6PrcXy6JF3qW7+ec4BYdpNI3hrdsmpRKgegf/Mask50DmPVLAjiey+lxBvKMbsUDSarVdmcZe+HDf9Hx1Mb+queiPHvvRua93ZvoRF6OVc7rA/qGMi1BVhAuLLAwWuz+T82W9wWG7ZOy2LQPR6/QCLtz+y6SHqlfqNHMZ7Cd0AECyqYdHVwjXI9SJ5OMmUsmeGyHoRuk4m8vBJciUSAGiebrzxdxGaXy3Zhw0GUqOAqZ84CipiaIq+THrEBbsq3nHQ4oRnudUgQO7UYH5TtwUvELM8Hj6mcGxrHr+YaZJ4yP5bB4voMa2c25+06zsWW4NrSGwOiMQBBOrhsEKom1FgkHIb6ukMLRDTKkyeg1m3EI91EpDr3e6W2Nb5QHA7R2xee6Vi6BXVeIW5pkY93yBFbXiCbINXQgyJ7Bq2uODHELZ12sirov64G+lCDsnE4TGqWt8g2KTTsIy8UuUTRj3b15jZbQPWrU5Bah9xDEzXMpKWsNib26D1SSaTt7cJ4I3CpHG1ahvzy9dUEqSU6w1hqBJIAf8bfc1NPPt/OYRb+fWUkGy3OimuhNbya6og009TZpfbxY9GZQ81e1ucRBoXD0rQpxax35aEXcfytW6tUlWivbzdb/eKiozvUekcvlrlK8LfjpRpAQ/nXppynId+elstMSC4yYOKq//Bu9AWrLC+YeZTirVbiZs6geVzybHokOjF6U6m9vJtlbvO/NA52YUNytprPSUA
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(8936002)(2906002)(7416002)(5660300002)(36756003)(356005)(83380400001)(36860700001)(40480700001)(107886003)(110136005)(6666004)(316002)(4326008)(478600001)(70206006)(8676002)(70586007)(7636003)(966005)(40460700003)(186003)(336012)(41300700001)(426003)(1076003)(2616005)(47076005)(86362001)(7696005)(82740400003)(921005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:18:19.8043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e9399b-d8ad-43fc-3189-08dac33f9068
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
channels. The current DT bindings has only 31 interrupts which is wrong
and doesn't align with the hardware. This was done to reserve channel0
for the firmware. Now with this change, the driver can align more to the
actual hardware. but this implies that there will be a breakage in the
ABI and device tree must be updated along with the driver change
for it to pickup the right interrupt corresponding to the channel.

This breakage is okay right now because GPC DMA was introduced on
Tegra186 and the DT bindings were added in 5.19. Any products released
with this IP were released with kernels prior to 5.19 and bindings that
were never in-tree. Any of those products that are supported upstream we
know have replaceable DTB images (i.e. by default they are flashed at the
same time as the kernel image).


v3->v4:
  * Reverted back to v2 based on the discussion in the thread
    https://lore.kernel.org/all/Y2EFoG1H9YpfxRjs@orome/
  * Added description of the ABI breakage
v2->v3:
  * Updates in driver and DT to provide only the interrupts
    corresponding to the channels used in kernel. This would fix
    the ABI breakage that could occur with the previous version
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

