Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917FD5BCAAC
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiISL0i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 07:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiISL0Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 07:26:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633AC1DA7C;
        Mon, 19 Sep 2022 04:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJftq9CHrcKKDkqKptHwtUR0HDb2C0qqcYmmiS654ZTcQkMwdsikRRcva7ZL6Limd8rUuTwe4x2jMEOFa8znvOYs8+1oh/h/q/8B3jQI5o4RQYCo0kYthThxxp80TsfYt5HkG0j36HbZMwbFlagcm9+J/fwji32BpI+x9ExU2TAQkPziqnhDid3s05oFG5lZRdFsKEvXLjKfFa9wf112TZIybhym04mmqjUGH/uTGpk90xrm4Vjd6O6OSbmrfkVf5OhQki7OnUFtW9Bp0KG6gJ8WUw6aBP2V7UzjkyyDsFnuMEJO13+QiJ/x4jCC9IarTpZ2zJnXRwWljgMUGKzjDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEylTZ+nZvtt7CtuSmVaGt1Bz1AlbWl2lhzMYhaJFCY=;
 b=eIHqTR4h1+GFDJWPTyUX7MIpapmOp43APo6B0pxoYu3QUiapOezlmAkKaYdLOnDpUCLX85tNpgG/ws7UZi9Ztsu07VXkygYo8COq8RkLpgmP36NRvpaethTQLUZOUsEtP1BqzRHhCeMcDROJAHfBR35MRBrYB+VDuLS9RtjUIkMw3BmTSU1N/IdCaE0JM3Z9VulTWA3zSBNa4QdE7I7VevGkvitxtmX8MnZxFC51t9bJnwWISGoZYgL1wkBWLqvGMn8nfgO3rtRSRIGX8poYI3YjsKWNZNZqLzcum0SzOPXf0vXBQN6TWETvA4q2Fsq7N/sin+Z9XO1NkRO/pASdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEylTZ+nZvtt7CtuSmVaGt1Bz1AlbWl2lhzMYhaJFCY=;
 b=WNtpWTEX3AWlUrVfFs7LIpQ9nmgNnNZbfbAAExsC9YERvqqEdevVcMFyOdTEVUJKzRgfwDu6jdK0dhYPtVf90UdAe9afQvL32vZGoCIsBZkhjbVZQ6Xbu5jCGUUVuORfxD1DQbFwAPV3M22a4J8S8AUtiQdPvsxGDgZCc/LSp94HxgCjGj04qVW2jCPsh9u1EGUhoSEkcuTRNTBBTdTBHTlzXmCelwku1Z5hjnpRP0Gwsi/4jL81qacuj9weKcG5yclRQlopCwpnwUxMOby2cbnZNw4j6EUUPBcEfxZCcVsH+QEe4+AzFyhmshb9+KVPZBPliG0g9Y8CzWx6gWUKXQ==
Received: from DM6PR06CA0044.namprd06.prod.outlook.com (2603:10b6:5:54::21) by
 DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 11:26:22 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::83) by DM6PR06CA0044.outlook.office365.com
 (2603:10b6:5:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 11:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 11:26:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 04:26:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 04:26:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 04:26:09 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 04:26:07 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 0/3] Tegra GCPDMA: Add dma-channel-mask support
Date:   Mon, 19 Sep 2022 16:55:56 +0530
Message-ID: <20220919112559.58195-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|DM8PR12MB5477:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f1d637-0d79-4dba-6c2c-08da9a31c76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYV/cQSsU2Zc/UrTqBJB5/nLV+m8nuDoDoa+sTnMkFRa1wz7wNpgTC8nJyApbUwonqUCf25CXb7/KMf4SWNMToQtlc/hTw28Q2clNsSa8nGsvktZrW703Z+epIUmGnL0b+CpptV7CfITZGkHj4n/HhdPdeNe0XOSbcmsXvlMcKoHKIsaoDgOz1Y0ZQz3y72/bouLHu1gZAE5fS7Qy1iFwA4SFg751xWczn6tdiMnrzRCiXs+OAded65ks7QX7aQSxXiXgYHNy57Nc+g4nIoxyPeP1XyCYtnd3X0/xLzvW9lUw2wrP7uTF3AsdgEXIgNRE606IbM7GeRDb1aPFry2eV4Rvcmi92GYWE6d+Jzjd3llQ6X7/+H7AfPKOR6ftcxoaOt8v1LNdaKxcC2GMSHzZnWbC+s3vQFbtvoqzdSycmDJ2pk1LGqBosRatAWAdKQngTDj5vDXDAbuqg4MIJzw3uQHarHgwytUNpYKQSk3pUhqbWLK+Wf24S6KUoTXFkaD/iS1jnaEsch/WCnZx4Pd9+IeeILLj5yb7pG+YaLr6jt5/bL3vDKy64ucdqCJ4rYXpuVfwFA8ErREoH+rIOHwULYFYtcXrBswXqkL3LsDW/6S9cOSLHC6vjJ+TLw8NjcgX8UfsKsf2SVWB/aKEt+JdfMZeGyyGnGvSDBnJAmYHycdTxaz0oeAUew5CkhKCkNis9YwXzs1Pa84a/MerD/daIvwSvUujTolqf97Hhtlz1nNlq5+yKNT/kP1UDNtxc+Wmt7idycx+svaN11iNQq1Mw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(2616005)(4744005)(7696005)(82310400005)(41300700001)(356005)(36860700001)(107886003)(6666004)(40480700001)(4326008)(8676002)(70206006)(70586007)(83380400001)(426003)(110136005)(316002)(336012)(40460700003)(1076003)(5660300002)(36756003)(47076005)(186003)(8936002)(86362001)(478600001)(26005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 11:26:21.4671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f1d637-0d79-4dba-6c2c-08da9a31c76f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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

