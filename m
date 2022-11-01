Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1EF6145A8
	for <lists+dmaengine@lfdr.de>; Tue,  1 Nov 2022 09:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKAI1y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Nov 2022 04:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKAI1w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Nov 2022 04:27:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379813EB2;
        Tue,  1 Nov 2022 01:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em2RhXBdZ5Ev/WT5kEzN8ekrSYWfQYS1T9iA9aCvmaxfuxq5AwMjEt6dDXT58KW0/S8X+Ux0HKX5VtK8AubyVuQG9mDJcarJ+YvwUgPz3Os14TnJXBYZbsfYTNrrurqtEZzXgn/MUsMiZsrcrDuGRie6zpDXvScNmoorSLRYItYOdsJso5VHKx1Z7AZ/dCoqqpeYlpRcyrc8BwoPTcfsbh+lhBhpQnq2tab8GEuxLg9sAvmUZI/jXeZ8geadlrIbgX376okWqFisp6rkd+guYtN6ISELJBRiJB4RbXUEDw1I7z25kXCbXCXautCzQP01w5jHWkQaXs0oiqK4xY6Pkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+MIQUVQVj+Sn7xxiS+tsqEPBn7QYrwDZua7R26SyfY=;
 b=WWEO+yCXvrU24wHkIl/eZFWiOFFvVUTWj1zNWznlc1bxMLAOqBkU4juW10UUEGFzoV7mvS+dYruzydwDfVP2bCaAjvbWL9lEVRBKDsEO+oClih4qQdmBcg3YXFh+F3TaYasKDO9TlMdyReW8x2/d6O7Gj72Byj+tme8nSoFDRo4UyKBZk8KDNqHWc49Ll43AkdpVX09B5d84qZQ9uJ/KHYVcWSsmAOW3J3w3z2mfVW/Sx5SdhGk57JStfvoJpB+1/OxCaa+mZLuurfCySuy0e7QbL1FlP+VRmkR7PwGXN02QPe51EUWaimXaNMrwbnhHjIhoPPp9D4Tm/iCE75SKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+MIQUVQVj+Sn7xxiS+tsqEPBn7QYrwDZua7R26SyfY=;
 b=IZI5HFXLvbMW0b+NaCmUkNwEX2Qty29Bq/PGMZjLSbZit2HZ/6Kcjwj14M02gOBoT9LdEtzb21rZyna5NffSc6oCysVCKNifBFj/jU8Hj8XKpwW4r4B6jRfOjAHZtKTae+4HySKPfWoIA2bykPr65Sl937/+eB1/jnnMMzWXkPmbpi/p214Js46v8olKXoLP5UQmTF1IOIoakYgVxucB0HCtQewUb+ke7WB8s5tptZhVu24tzuHqpm2WwxTW/gitzrViSPn6fQYmE3vOLhEFJqRYjRPxrFuLbtrsso32206jDVSKGy+PZXcJcrZceKlLokvJ1YysENlL7C13AJFGzg==
Received: from BN0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:408:ee::29)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 08:27:48 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::e7) by BN0PR04CA0024.outlook.office365.com
 (2603:10b6:408:ee::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Tue, 1 Nov 2022 08:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 08:27:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 1 Nov 2022
 01:27:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 01:27:31 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 1 Nov 2022 01:27:27 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v3 0/3] Tegra GPCDMA: Add channel-mask support
Date:   Tue, 1 Nov 2022 13:57:09 +0530
Message-ID: <20221101082712.59263-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: c519f360-c4c5-48e2-91d5-08dabbe2f56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pWlSZOMXI327Y9eTBHdyEhSAYWjykre+eIABNuM5hXRWhvkAmx5yOYUwB+mZwlrs6UT4a5gpg6LSQyb6iA8pbC8IJEfX8iIRyvVS+HuS94WD4T6nP+bTJePL/G0CdMvPywQthaOKmgbkF7KKd7z6Oc0bn15TRO3+3f4Sd0Q3IykAdXpyl852OblGslkRPsg7s/1c/5vrTGBC+4GyWdjR+e116n3HDqQaNlQqgQQBBPZOjaJxgJgXZsjvvk9GzDkBGdmF3/i4a4J5LvepP8QFC4r+2RlB1DBjz/fZMZQ3PofN6bk7k1Y3iiphuN3XeEd6OQKycUqPM6UKOInWgXrNGkYJfPAJQJwg1e2ZIl6gtTbcv/FI9+hua+Rts/F6Yhr2pq4b2MG4vduvt8xJR+ALJpvguGEAAP3dOBj6OhJzKFLLckr5GobfTld7MiYt1Fm2lZjg2w8KH7rEEKkod/5Cphvso07CGkqeHiFBgwIL5XbqVvylDhwh05/T8a6mVDDNJX8nRVpGSOHzaPR6ykjedRZMg4di21y5P5eLmDslcVyhrn2Gj9vN8B2bsx6vIHg1RAyNdCjmhk1oB0wl078ZnfIIUcxe7oQtYiwFL4OEch5B2+HBIM1Ajbe/80xm0gwc4aL8tKqksRcbcgFKqcXcKCkIuvN4zIrbIXtfLgDC+GsENfx1iCS999Sq9AenM+Hc6JcPOHU3d5A/Ix9BbzuRcvZ2VP5UXB/Z7Bnd2By5LxJSWtFJahzICpUGP4HsBnkY2N9wmIco3RmDYbWu+UYABcVdkw9hpZmD3Wop5vZkFo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(8936002)(86362001)(5660300002)(36860700001)(478600001)(47076005)(356005)(83380400001)(921005)(2616005)(426003)(7636003)(82310400005)(110136005)(186003)(36756003)(2906002)(7416002)(336012)(6666004)(1076003)(107886003)(70206006)(8676002)(4326008)(70586007)(40480700001)(41300700001)(26005)(7696005)(316002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:27:47.8851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c519f360-c4c5-48e2-91d5-08dabbe2f56c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  7 ++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  1 +
 drivers/dma/tegra186-gpc-dma.c                | 46 +++++++++++++++----
 5 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.17.1

