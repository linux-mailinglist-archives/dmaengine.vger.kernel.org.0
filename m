Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1E7CBED4
	for <lists+dmaengine@lfdr.de>; Tue, 17 Oct 2023 11:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjJQJSt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Oct 2023 05:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjJQJSr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Oct 2023 05:18:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89FDFB;
        Tue, 17 Oct 2023 02:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ppa3bX3HIF5/6Cp5w6h5tIVzaWAzLCsETMd4sfw86cI+D8oFVoMchgnVnaPa/M8HEC90gqr9ee24+NrYNQ11c2TPcHwmsY/HZNpoRfMUyDD8lYM4VtBOpcXED2RLTZg2Y8/TafVS/nPc2EDz+qGJE3h0LHlD7ea0mCecMba0cJpX0kWw9H029a2sH7HbyvXYJngUjGHxNv+cjw8c+kTTeOV2tPVVpG7m3E9s0as1lYlAsMbCnP8vykxrsKcmO7+8b3oPIty0XYt2VpwBR0rAxcKIKNlSk1ccydg2yMnf/NwHkkXGvdzIkk5GyvtphYBMGDN3nmM2QV6WJn1tJARi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3KQXlpi54W4lYTL0TH4pmkDKa6qxHZ9Uc6hxiVOVRU=;
 b=kV28as7r7mv/hWcJr/6IFwVx1sVvb68KwQukLa1odHhM/WkPWJoTUElw6Y83CnaVQRElgYhD1FxYp6rnWY98RBDZYy3/XZ50JkhWGw1rdSW3rpq5GXJAFDxldlDQ5noaKk3JHP6mwTON1/bDV3sAtzSk3ujSm9Qn6+GVhgKIrNQTGelIe+RFua7qzWxIM7qHlDgtZ39JCCu+bGVRu9Q5LCoJxw3V7skHLh9xRf3bmyX+LRbCRhLnvCp/F9BV7B2q0j6pWYOSHWEmIU+CzlfAx5SdM5WpiIOVhoe0lljUZtfEBMmDh8i/xUCsh4fcNssDbII0wK1qoVJ/dF2fGhc1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3KQXlpi54W4lYTL0TH4pmkDKa6qxHZ9Uc6hxiVOVRU=;
 b=IjLDhAyZv9VRGnd2cCYA/0YdpoPybTyO5oycHvpC1IkzqL/4XXfyyYooMQbDBxxvdlorGSagWmvYafT2npjZJfIj6op4pXOtgxeAPWuy0EO0K5ww2lZ426d6ZQH8fZsFXTw1Wye9VU4lCE+bQanu9WMOyrMpwqlDT4IMTH/Wmxq0sHZnpN6WSTAteVMRmtyeBAYVVtHnQu4Wdhl8L1yiq43SucjDRTuo3jYIABzGdvfRzPMiM1swLKF25VqJWyc1EZsN4YenbrirkOIscwIalVx+nhJClX/oGiRVRhqxN1LpHzeeIoEBjTVBCniMSy+GZZD2qeNlLoJgRBFHrekUcg==
Received: from BL0PR1501CA0014.namprd15.prod.outlook.com
 (2603:10b6:207:17::27) by PH8PR12MB6673.namprd12.prod.outlook.com
 (2603:10b6:510:1c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 09:18:43 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::a1) by BL0PR1501CA0014.outlook.office365.com
 (2603:10b6:207:17::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 09:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 09:18:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 02:18:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 02:18:34 -0700
Received: from mkumard.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 17 Oct 2023 02:18:32 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH V2 0/2] Support dma channel mask
Date:   Tue, 17 Oct 2023 14:48:14 +0530
Message-ID: <20231017091816.2490-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1fc924-8ff1-428c-ba3f-08dbcef20f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SW+ND7eoo6a5oGtqwPaOX81OOV5QTkFKzhLGzcRLLooArPa+KrzOBdJ5PrgG7vhFE7M5aV6QMIEz3Bwki0dfxdk8TJb/dJJAHNZNU38XXZ3egBYi7tgY01sCExa3YiI5hZdbEJTpLtNYGY1CrsCc9HDtcv/hqlzMJE667bBBWOT4HARGaOmdIvc0DlbpQgN+LdWUiCayObQOmU0ORO8Nq5Tvc6jhYPB8Qta9yC7nijGGLR6hS2zUh1dVrGCwr0lNnZHVmg0OZUJErfSPP6dOXcg3Qk8eoU39dA461CFrhCFd9dwE/7OsDdC+fD/H1Hn1hYEcax8XFzJhjqTTynSOR0owlwjBTfsyo+5VPKEDftwVkgPRBfny+hjENajivRIJhHdcuJRG6SWVT2BlPSXLB04u3txdkMsseoUrqiJXoHCeoY3SL9zGw2aoURBx38iN6RLl4ORyzySqaJ2Jq791qX/KX+i+O711nmFWlQM3QsEbRmmVFDQEv32RpY0fgLir/zoWMejtRAMaMn8dsxSfqD+FcccpqRds5MPQvMn5eZ8ChEzwU8SqPXWBkVD91fl2Jt8mRT14w9Y94bUNHmKgIqKPVqiBJwsVSIKwG6bGyUv/a+IEpSOiO108JXL2vwX0VyMrLicX+lLGmHaB+ZPWzrii0uOMaW+mNufL7SAB8J2NuCj1gMTUuQk+UplUngUN1w4hO86++r9jQ4fweXaxAkr6QcnOjZCVlduvKgkyv1Zxl0cTwA/t8A8uiXAdJphN
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(47076005)(7696005)(478600001)(36860700001)(83380400001)(2616005)(26005)(7636003)(40460700003)(426003)(40480700001)(336012)(2906002)(6666004)(70206006)(4744005)(8676002)(41300700001)(4326008)(5660300002)(86362001)(316002)(70586007)(110136005)(36756003)(54906003)(107886003)(1076003)(82740400003)(8936002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 09:18:43.0819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1fc924-8ff1-428c-ba3f-08dbcef20f08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To reserve the dma channel using dma-channel-mask property for Tegra 
platforms.

Mohan Kumar (2):
  dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
  dmaengine: tegra210-adma: Support dma-channel-mask property

 .../bindings/dma/nvidia,tegra210-adma.yaml    |  3 ++
 drivers/dma/tegra210-adma.c                   | 35 +++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.17.1

