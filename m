Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0E4AC325
	for <lists+dmaengine@lfdr.de>; Mon,  7 Feb 2022 16:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244385AbiBGPYq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 10:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378779AbiBGPBs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 10:01:48 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA6C0401C1;
        Mon,  7 Feb 2022 07:01:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfVhpzSqGS1g7OEQyUqMDSMaLtxNxd3jI44JtT+hn4JkGgoUzxFTpztU0IvY10pHwUVCppYZvF3XgAu51T/99Bnu0lZxzxCXKSBZ+tnEeKSDd8rfdNYkvm9WYvZAzcLGdr8Bi9hsMd9v/3F3SmnptBLbeEq1Kv9Wni5lHnruER+K0Ua0Px3uvvg+gJ4GYMcn/Fq6eCCKTOSw5pIm4qKq/yeInPeiF7lJIxdMFFDgAA17KSnybesSv9SepWIerfpTdtqBLi6iSlfRow2Hxnf4KU5r6b2PJfqh/sk5CWnCqkn9UPwCu/+nkQv/IZq3BEY2STpjqcBpgeNbz8ZHLZgcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJyOR17HuXBeUrHCgIzhrYYWiIh3xdxAoEoLLdySed4=;
 b=LM2d9y4xi1yxWfImvlwpAOIhD+do3ANQ/f0NiS666LYZrRyqLiOQL3CgY41JNrDKerjY3dQh88N2JY0Qj05YSa0ofakJd1R5YawzC7EKsbpXjmwW8/7cTk1SlwDG4e2rvo//2/HmWuqNWG4OxNNP8QpMCSS2yjIi2QK7jHJocatOiZ71qqZAqud3qXvJx8RAJGvC05OoQHEy//C5B71dWmMCwztYlPJG7gANy2uSx6XKwlSIza0QuqHXn4dH9SdkYxRYwuypPJoZVd4sGRKVUY6mtOgFxSbkPmb1unlWJrS4rKwf3atCyZ29lJcOzcrl7L1KRpghEmRgkRPaKNkxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJyOR17HuXBeUrHCgIzhrYYWiIh3xdxAoEoLLdySed4=;
 b=Kn6eZOswTp/WoHamaJSZ7feM43JtTZAot8uF+6GRdszuznVDGr4/BgeO5Ahc6IbcONPCmJvW6bFNBHmRLuX09J911tlARphUqGbRbypVGWJkwb+SVw7Nm2MgKAKnYLqH45/V4gsqkgQje1+GVAWc+h/IPuyogdtpHBw+ShTFlDtFtlmxLhnjKGJyKsETdMVQ2dW6RXcHrZnSuGH2CF+2ejilx8cY5hIPmBsyGg5fbJRSN5YyG1/b1wDU5UA2ZrRlzKUDCmM84pczbJyMQUF4do7mT9k1lbM1TU7TXsO7/Ts7W1AZDWvTGndNIUhOZEMXEPANAh4ZrT6HDklLXEU/vQ==
Received: from BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31)
 by BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:01:44 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::83) by BN0PR03CA0056.outlook.office365.com
 (2603:10b6:408:e7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 15:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 15:01:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 15:01:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Feb 2022
 07:01:42 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Feb 2022 07:01:38 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v19 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Mon, 7 Feb 2022 20:31:30 +0530
Message-ID: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a65117f-bb44-4ea5-4362-08d9ea4ac186
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3108AA6EE8171A14B5527557C02C9@BN8PR12MB3108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjqMk6ezAM6oaBS6DvnQ8fze9x5x6wDzg15EUbNxBZk677olHZUiJcVbyDcuLdhaBrtaiaiUPRHkyg2UJx2bLiDjYwDo1gLkWo2ipyoRcouMw70HWh5BgRmt7MPhAv9Uafrtyov9JFR4AanUEw/bIdFgg43KcA0IQ6u46fPz85z/jgM/FqrdVNZ9uHS/gllA7XYonb+zHkzKPLfzV9R2iV75N6+ZCJ/ery4e8nIofUU6spS/tuihf/MBX07P42N0MS1KVxl+0COOXyngn1xoOZGjrJbkn9fp4tfpEDokIrv1CYyoVuxHW7F2HUfWwbqO1Rj7/L9A58IQaPQj14kiXiR880sPOQjmM5FLe3bzyKwYAQabwAdDyaLZTDSIW6cd1+R7I0xon/ecqeUEb1STWqGVoTAYVj8JuEbhny39FBrzq/GyVv2csfp603tu0qkzW+qexgV4uXCjuVdxgL3o6E1Xz92Z6FUe/iQx++xBFCAjg+5P7cKJ1TAIlgwf+64c0mN+5nocz7KWSKqFblXVf0ssSBVBS1pLo8XX3/MVKfyeyGktYV/mONP2IGrBDhxJ0L1mOOSwld1m2uPt475gE/rlRPqB21MtW3odKnwdxw0SzNP5cO8BvKkUu/hDbjD6CXYgTU/Y+I9NTJmZIgRCzP9RwvO3feAds00QpuYzRQPhQ3Lj1txrYiv7dO1r56cY4EXbK5X++NmkFH5TSuTn/Kh3KxQ+dWE3k9ULEvzXoDSsfpwPSRkU7q8AgkppUE4wte/8RXqhaHQcPJcZ2rwOOXFrwEK3/w7YPr8rgzmu1ovg+R1Kwmc8gYriwCUqozCvEtXYto8RFMYmyJKJls8gJVKUeEzsjQJqufTkCuGTvKE=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(26005)(47076005)(6666004)(186003)(316002)(336012)(81166007)(2906002)(2616005)(7696005)(921005)(356005)(110136005)(426003)(107886003)(4744005)(40460700003)(86362001)(82310400004)(5660300002)(508600001)(4326008)(36860700001)(966005)(8936002)(8676002)(70206006)(70586007)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 15:01:44.3042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a65117f-bb44-4ea5-4362-08d9ea4ac186
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3108
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

v18 -> v19:
  * Use function pointer to call pause/stop_client() in terminate_all()
  * Remove unused arg in program_sid()

v18 - https://lkml.org/lkml/2022/2/4/379

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
 drivers/dma/tegra186-gpc-dma.c                     | 1505 ++++++++++++++++++++
 7 files changed, 1713 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

