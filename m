Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BAE4C45FE
	for <lists+dmaengine@lfdr.de>; Fri, 25 Feb 2022 14:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiBYNWJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Feb 2022 08:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiBYNWI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Feb 2022 08:22:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F084F11154;
        Fri, 25 Feb 2022 05:21:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaSKOyCJo4ELH8xVVK56+f/8FNIkfe0aTUtSE3bXfnGSpPo/kT6PMTvPEFWKnfmzoUhhuYE7apsHPdfB+RtLqnKoDgNMxpx0wwlKCKfPv+OpEGjxkKp+x1TlN+DGRHyuOf+qUbJ1hiYqNsy7kJxTwDa10uytbAVIyRpJ23Y2j17thELbDnVEGpniSuZ3IzLPftuXDdoo6EDTxNIGzltQRQZ3jZIqGDJ5zsECBm4b+HFOW8cgkAuKhXXEgL8aAXW7+ijJHvtqDCARbd21yK/1VerpHsiVImGlsdqrYhJcVXinrkmgjkYMiY6SCO7sbcppZVXqe4dAgWbYT9SpKeuSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrvV+tQce+ow3FBalJg/cf1aAlVGC1YEtqx36/2cPPk=;
 b=QMYM+bp8WlEW7DU4wEW2l5FpHvHTcSa0dzSG9GB3PAHI4jt9Z3jrr0S9tT6y2+PXVImbG6TjZygT5e1O9sfcoTn8HD+FS+05j6O9OnMzqsXKH+NmtJG/g71J140SzZdL+IL8UsHIzqYhWo/cGDJcGLeBuRJUs5PJJTq3Xe6zw76blyhSrO88UoaiAd+WBYmhMNxUfkdwpwOfV+Vw7erOaogBSGcAhLNlDg3gwOjGRSkGpB5RXSOiyPbafMmVyczeQ9OfWFsySHAq8KOaBVtJ4YVqQbewFoahQE79Ii+h1ktKxIvftIVlge+sJe1ujHTTLkUndQPlj3k6JVXkxuaaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrvV+tQce+ow3FBalJg/cf1aAlVGC1YEtqx36/2cPPk=;
 b=p9Q6m/m68nTgt5dNn9vvA6ojPiL7tYGcGyZ/t+8Gw9unQvfrZIPPMXLeG/CyPXyfo5zA/Ggy/3XQDg9040rwhqMTOv2vuoTrgEpUaDtsVHfUi46bV50m0QB4+BHTfvHhGF+F1QFp4W7TEFF2304PDk6MNtTc6wB7uNXt56Hwix4nz0KtKEvU8DTZIBliYmid/ERTU+M0HvnOsqv0FzBLyfeIGxieUSPcRDMJqVl7UJo6ZahMm4h5hYPmae7uDhR1ANcR3o7Ql3pt0ZNSJwaVkzS6H/8lLZmt+FKPlUJBP7yfioErQi42srgUMXiLHMbPyHrImJ16w/OEVcg6cYfymA==
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 13:21:31 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::9e) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 13:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 13:21:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 13:21:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 05:21:28 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 05:21:25 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <nathan@kernel.org>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v22 0/2] Add NVIDIA Tegra GPC-DMA driver
Date:   Fri, 25 Feb 2022 18:50:42 +0530
Message-ID: <20220225132044.14478-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3651920-cb27-47b1-cad8-08d9f861bcc0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3950A4C97748AD9872F997EFC03E9@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0NFdoXSUtO3xUdULnYx+U48aOb2PbUAsBaKCNTUwNPo4xcr/bSW9JiiZdFsN3PU4QBT4moo38+u0m5UmWZFSs35n2WsBa6f46Xn2hHKmVZnUv2glDQv9yLGjwuhs8zh8b5G31ydNUjE5RjLIejGzYsHY1Kcg6gZjuwSiPru3uKcGs4oG1w/gWabt8hHmp0wi6iqPm3Mjc37/aa+k8ZsDAvvKi3ikDdvcr4sTwaXPfDVyzhm+HryNF6P4KlRmr3maGT6Ek7XxmU8PUaD9UVUyEnA89ui7mL86vEr9fIDLKx1aKcMaaapEIK9sHsRQuzsaVYk3Tn+PhhyKqMfXqVagDNcGVWDIkYzQiStzdAkr2HrMmN/xMdW3ozuHl+DP+PRRy1OX3Nyuz8cC/5YgBhwbJcrEWf1cA4pjc2g6efznMlQpMayBYpUp4ySUfW79J4PFcmzbN96ORsM8dBaN/EcUZFVoVioandG5wyIcZOpObj4uLiqkgLRSAiuRO7cffuQRlA18rW8XmQRtcuXJOdkn72+veVS/y7unHwcW+sokBmmDoK2C7uJ+eV19V60DvzKs1n/yXqCLi2umTRWIjsGWH3Pmpt3MEOGFc+RWCh14aMGyvYz2mAvIvxkkBCx7Ool6lvqZNzk3SiSbIQl5qadrA5d66cAmijUXB8F5gjsH0kY2oi07cMB0pIbmC5AaEVgbreZr6Fp9uHGGDfTZG9UQUcC4xTJYXmlmO8ZGRxPnXmWcTMPkb7PNr6zQUkdkNiQ/DiO8AodjAYM4AB+qMBarQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(8936002)(36860700001)(2616005)(107886003)(921005)(356005)(40460700003)(1076003)(36756003)(47076005)(26005)(110136005)(316002)(6666004)(5660300002)(4744005)(336012)(426003)(70206006)(82310400004)(81166007)(7696005)(86362001)(70586007)(8676002)(2906002)(186003)(4326008)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 13:21:31.0028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3651920-cb27-47b1-cad8-08d9f861bcc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
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

v21->v22:
 * Add depends on ARCH_DMA_ADDR_T_64BIT in Kconfig to avoid
   compiling for non 64 bit systems.

Akhil R (2):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  110 ++
 drivers/dma/Kconfig                           |   11 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/tegra186-gpc-dma.c                | 1507 +++++++++++++++++
 4 files changed, 1629 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.17.1

