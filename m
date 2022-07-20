Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26E757B49E
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jul 2022 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiGTKlG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jul 2022 06:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiGTKlF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Jul 2022 06:41:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1723959256;
        Wed, 20 Jul 2022 03:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKuxTKtJ7rt4dey+3mv4XJgNYW7sbSUjZF/Aqdurxi2tGQn9Et25pOivQ0vZCLVYpE2RDP7dfI3bmL4KQ+1IZHnSL38qzIMjtWL2hCrLlPvPR3807ZwLbkvdC+XY4aQWQtaHEM2jF+4HD3VMOaWlglkYspkZU8VZQmuyHa+IKW8YtDu7BKwZXuVTlkTn8hkTgfnMt3VFVhgfRlQ59mA5SxHNy5N823E+7iQIZ/FyBEf3w85BOFo/xc+Tz6lQYRb0eKNsx840nZYfrzopBOlQQnUdiw73d6Q3goe2ZdKQyb6KTRVACTzpCYxYrFNs5fN4jXBjBr3aNf1dRX/EYL3Miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoZoG7xRViS+VyoFLJVZnLpq+V9pgt/qYOG01zyNu6E=;
 b=NzCA5x2YcQpSQdzlnqhjcIGzdga7l6TqZGzojTpV7hMW12rGTAjnAyO87/NZiGZKGGBXL8YYHUBJ4pl4PzY22xzsdrvjKqVt8UbI8OcTHCh5JDflnSeigg6z4mQ0MvlVyT+sGA+je5pNuq+wq7ysiRxkT1gXCWx6a1rrILJxaEyqK+rRLbKVpIAi7wl+iiuGn64qzaYCvNlJq9/KBm04BcSmDOI2br4OmuJTGCCoQ4G8+uEpvaaONtzOWcdkQmP6Djv0NrDTW1E922liu+4os7fADhxGtv5WbKDCOArO1nGHbsEhLjrzi9X/FpBiF+ujjJmcWGy1xxOTUI5b6uRAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoZoG7xRViS+VyoFLJVZnLpq+V9pgt/qYOG01zyNu6E=;
 b=TjoEiV35hmu1aJ9at3pvzAItsRCn2MfilBlSaDiJDnj2M6GMqjVbZGlHzaOYbpDfKGcn/zx2PD6rE39gTIWiqaC+ePklA+FfqTrViu4M971+KwxSkxpdLMkV3mMOZ9KPfII6hN90aCRUfl3CTBFYLDPoU3G5HzuyG0xlg1WyxiTJoKx+s7pRRN3n1679NondhXHSs5U1k7QWUocrTGudgVoLU56/YwJHDptt8jhPqupv0Os6GmpmHM+AcokLRF2t0eEwnFJME6xZd2Xq+ILFRpvt53dWekFwuOeSXJ0L3mpSuvRcyj1FRpaQCzJQLzeHjN3j5I5Zajs6oIIiQPYucQ==
Received: from DM6PR06CA0043.namprd06.prod.outlook.com (2603:10b6:5:54::20) by
 DM5PR12MB1193.namprd12.prod.outlook.com (2603:10b6:3:70::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Wed, 20 Jul 2022 10:41:00 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::cc) by DM6PR06CA0043.outlook.office365.com
 (2603:10b6:5:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Wed, 20 Jul 2022 10:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 10:41:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Jul
 2022 10:40:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 20 Jul
 2022 03:40:58 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 20 Jul 2022 03:40:56 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v4 0/3] Add compatible for Tegra234 GPCDMA
Date:   Wed, 20 Jul 2022 16:10:42 +0530
Message-ID: <20220720104045.16099-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8712723e-95e4-448f-e9f5-08da6a3c5636
X-MS-TrafficTypeDiagnostic: DM5PR12MB1193:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Hmg8zIJV3nKEiaIHPtxXZ5MVzmAwa+zFMClkig8vVHLYLH49Xi0pwANpHjlZ5KA7v2sknDz0LoAC8hDo248kKVw1VPRaMbFXKc6Xwyc0rB+Vpd2rD/rute6cu9YHh60Fuv4ynzlH6D+AkcDP+nwwyh5HEvb2lfisx6C6BNiU7f7N2ciR4OYYfR2yTSjISSW+VQYg4VMy5e6G95rVbcD489MmpYOR+NhVxI70i/o3yp+S3yBqmwsztzucKDlcBpSBexffhKbd8DosvJvEsA0xStJkfoRsn/eiT/SzkFIV5Iw+/hT93ovdWti0GtSsY+/wnY9Hq04aPnAczCMKC2U8OTS99e0MdFgOV9M77N3UAJwF+Jn0gqJqyzt+Hn3EX2nw/qv4o2Tn1ryspIZKmRRpyCZgbSFMYAdQEc3LRx0dg6m7UFqk991qxWOzB61kpmGZqJmTnmN/qOO0BgRPAcxDvEMxQO8779asu9jrz9nastJZIRL+o6KYiOMkt6Fn9V0w59vJWZstHPYOn1ASShLnJxpwkRtQgN/bgp1M6MSWYgxVJKT/FRw70ZwKemSRLwTzXQspGmfOpnwevapqegcT9/7Hy9BaLCbM9vhvfa79Oael//+fKPj7N3cR5LeppwveIExeh17vyA2lbThFn4vovQOetuX03oFSxKk5Fu6XwC1R/FdSjvNJ32rLdjjIinL8hPoIMj+x1AIRYdsqa5lVRxGyRsNKZt3dmREXWk9PYNLwuaDn/BIN8Jw8sXagl+KgJUZVA/1D2Z1x0bEygTdmYRc93mmUJquRe0Hygbfmre4T2oal+ml+nPMx2ZgKAA1ZnUlfX7L2EQXic2qV8aCGtBMFYZlWD4Oa+F+Fl48S7oaj1X0+5sb/NruYIRRoHc4hGBJwNOVLALwlqhriyCq7w==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(40470700004)(36840700001)(1076003)(478600001)(107886003)(2616005)(82310400005)(83380400001)(26005)(40480700001)(41300700001)(186003)(336012)(4744005)(47076005)(5660300002)(6666004)(86362001)(2906002)(36860700001)(70206006)(8676002)(426003)(8936002)(4326008)(40460700003)(70586007)(316002)(81166007)(7696005)(82740400003)(921005)(110136005)(36756003)(356005)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 10:41:00.2117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8712723e-95e4-448f-e9f5-08da6a3c5636
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1193
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In cases where the client bus gets corrupted or if the end device
ceases to send/receive data, the DMA could wait for the data forever.
Tegra234 supports recovery of such channels hung in flush mode.

Add a separate compatible for Tegra234 so that this scenario can be
handled in the driver.

v3->v4:
    * Updated binding doc to use enum for compatible instead of const
v2->v3:
    * Updated binding docs and device tree compatible
v1->v2:
    * split device tree change to a different patch.
    * Update commit message


Akhil R (3):
  dt-bindings: dmaengine: Add compatible for Tegra234
  dmaengine: tegra: Add terminate() for Tegra234
  arm64: tegra: Update compatible for Tegra234 GPCDMA

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  4 ++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  4 +--
 drivers/dma/tegra186-gpc-dma.c                | 26 +++++++++++++++++--
 3 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.17.1

