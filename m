Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6A4C2BF1
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 13:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiBXMkE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 07:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiBXMkE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 07:40:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC52804DB;
        Thu, 24 Feb 2022 04:39:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0xDY3WkvLcywyAY1kNybiMzut8YN6fe65J5kxMOGyhAKrz+d17D53ih+8piz1rCG98AvmvZSZrS30eeLs6Gtm2s6390DyZGu1B0M3CNKix/0esJ19iNx7MCwsniHLMaX8kDonIQQ2Vtk5CEJayvrGqevU7TnkdpNrE8exsdJJmhMaYeO1ixMi9bxJEAoXQ+pLyJyTkvr1jUt4VykC3ZzJhj4QlH91goYP2QbrX4EtJRqlyveUeGw5NLn85ROlVLsWlsdTUjkpVrlVt9zCFp70HI4jTvjP7OJ8D7UnA5RlK/9IpY1RcEitkir6BQyxxPMeJgFPd5LHXBE8b5GUsWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU5C0H3J4RNRqSeLu4nAovAj90Oyu97kVPOOBP2D3ME=;
 b=RgT/EpC/Si0drGKjA/Vn6UZolUs/cbF45HWv8RHd+JE1pp2F5J2uCeg/B/b324pZgOgkLpLVZE+tk4lVy0UVVkuDpi4eTdV5EFxgJKiKjm/LJt65yIT7lpQC0K9gKeDM9gL9Zs5RmPBlS9GO8z9dyjIujJuyXDD2k9wMjdqo+3OyRm1ZDHJSK9lQME9/W7L+TxXL6VnWnjYKt3NUcIttGO9m6lbRTx6eabIiH4tSm7K5b/c/u1GTJFmOu583mDvmCgToG005VsA2M3+t2AER9mujP64sDFDeoEoJc37U3kNZ20hJ7N+27MdUyUgldpgh4DehysTOQ74gfSaBjckB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU5C0H3J4RNRqSeLu4nAovAj90Oyu97kVPOOBP2D3ME=;
 b=EKlYpgy2tiicMmVH9dJqUBbyrUKpngXDthsEVVVXWmWS9wnOCcqelhHvPbksx2C896MfxPQ9+cEsMJMTYUCKWsZBBb86B5FrzyqEm43GU+B/cAb4hsb9v4tsQNtQqFsHbUVyrgx6WdVjoX6agNFYEEl99AdUVco3HtM8YurqBz7c3w+GqrDftpKb2AyNhkgBmMWftMQkhg6QQP6dp0XaUZzEn/if3YIIRF3tLcCQU/K7fWfIoAfZLipyT4+dEmuPCHEK14/EUbTFOZtyz/yU2bnjUmdu7AvCX1tY4inP+S0hZiRtZm/hPdgFaOIpPRVVJEdy7jf8Vke2BmLSj51UiQ==
Received: from BN1PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:e1::27)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 12:39:32 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::1f) by BN1PR12CA0022.outlook.office365.com
 (2603:10b6:408:e1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 12:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 12:39:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 24 Feb
 2022 12:39:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 24 Feb 2022
 04:39:28 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 24 Feb 2022 04:39:24 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <nathan@kernel.org>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v21 0/2] Add NVIDIA Tegra GPC-DMA driver
Date:   Thu, 24 Feb 2022 18:09:01 +0530
Message-ID: <20220224123903.5020-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bf55dec-5d9c-4b98-0691-08d9f792b4cf
X-MS-TrafficTypeDiagnostic: BY5PR12MB4308:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4308D9793FAC886A75AE96F5C03D9@BY5PR12MB4308.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luHY2yJD0ZvkWCm+pA0xkILvHphmt7NTuMd+ku2Wc4v4sofJiTVq84EdMcdN2k2sDJMRTDJ6g39AwOZDLju0d9E6Zjk1lbxXPPqikQkx7Vb5MJ5fVmps6DTyRFwCwJ92B/pf+e3lJirBHxJqhyVeNofKVPtqeEOBg0kc12Znx2a9tq2WxBJToY4uaqQC2wuE7C78TyE7NLFSpiWY9zySv2DslOpgF6fU4nDw0bTWmmkagHmUUakyOeYspPvhBLXhuX/w5+GBfQG2PBmP5IC/JEP3so3JPZKoSVtOc9NdI4eAPN+Qbn8FeCLREA/X2LJu6orYazJMPC8eOqXZ+Wtg6zWQw3Qx3G6XVkosdO/R/tSfX9yMMIY+/5QDJX7RstOrMVMzIwbVTuN3ssdOwy4OKdGWiRncO4B+obRgcRJwLh0OOX0xsE5rTu/e38DSKI+vQHari3iHVDy7trUwGFvOAneXb5Sbexu5FfE8ARw8YnwKu9HzVavM1BFdYkJS9hbt4fOpCkDblcPkaUcL4kPT4C2Dcuf97K38XnnLog2Pe2gBumnO1b6BkxmoTfaKwSwhEZ28lei36D3a7ltFeMQF6vMcWjNw3ZMSzw6ztlJ2ArQvkL88JzciUJ4HiOKmAohzSTYN7aTevUgYTljspjhVoO7OF8NEstxPG/lI44X4LLAGoJ7cwQsFtbYNW2O+eLxkw9ysQP6Y5i5n5YJZpc8mNs4t0P0SK1/4hrSep/d7iiBZ53uASX8FN5JYmwxO2JuckZ4BlUK9CjW1txvR/JM/tw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(36860700001)(82310400004)(508600001)(6666004)(110136005)(186003)(316002)(2616005)(26005)(4744005)(336012)(426003)(70206006)(70586007)(4326008)(8676002)(1076003)(356005)(921005)(107886003)(5660300002)(8936002)(40460700003)(86362001)(47076005)(7696005)(36756003)(2906002)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 12:39:31.8513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf55dec-5d9c-4b98-0691-08d9f792b4cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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

v20->v21:
  * Remove __maybe_unused for struct dev_pm_ops
  * Add 'depends on ARM64'

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

