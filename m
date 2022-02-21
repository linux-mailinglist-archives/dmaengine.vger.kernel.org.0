Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719D94BDBA8
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 18:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352701AbiBUPmj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 10:42:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiBUPmj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 10:42:39 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A3B220E9;
        Mon, 21 Feb 2022 07:42:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEFUaAps5SKnvaFX1/giwmTkdl9Mru6kYYdl4dscRuqAFg2ycvYHpIBjO7lJ7HPu9nQsAoily9mnjXBNgEcrs5tY6osLwS53vxqUigCCuFoC+XBc+PwUTw8WAYmElXPbINt3RJiOYic+/HymbH6SkCtsmU+4WWgW/aTmm1+aIE5eKxa7wIL0NYQzbVuQv0sT1Qr0xcXWhzmImbQWcDpy8xd3aADoATUSrBzSs+jbUdZ0Cl04R/eGpZTc0Jd4jdDP7LaCpBnPR0CLkMt4fGnqkD9LnOZ6JuwKyisie64AZA/bD9pjFdayRb7wIFLqzTcP0mwUkybFKzNmw8kjq6bcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAHOXZBwNM74+8Uuax+AE0tyWfNmn3fVHYsI/yW1kfo=;
 b=QSTzwKL0siC0WaUblEiP2W7QIAI8HRmM/SiWpA/OepeLUJ9J6ge072J3ybyWToNFtCUYwzK3AB/J3p/Bxa5FUG6Hs3j6lOywRSrtegO5gbcU+6cXu5KzMCo3YUeGhqfcprwLuojGORJpthMXlv22uVDVidODKIkqC53EEek9vs1kluaBut5dz4AFSKSff+To6v8ayN92wtqKTguwtD+lvlyf9ReD9nsEYy3fW/2WbwfVB54SIhxtiFq7HK4Yh4YykOLt8TDiPdoYm9YqJsEGdfZR0ir/s1txYQjaqLmhTdMUSGSuqeMFJypNO9Cdhp4Nkc+Y0af5z4N8uMy6B9t8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAHOXZBwNM74+8Uuax+AE0tyWfNmn3fVHYsI/yW1kfo=;
 b=ZRXaZ5KUA1yQtodfKKXdMbi69XL0hzntgkdcxNYFnJ7BciDEvX6VmTN99t/24/mIgawiVRiM//hmgAXnPrhnadHCTBKrk5F/z9TXtT5BTtS2bzhZdFFrL+bqFmuZMUQdbOS13aOiNRTRYYf7Wv2WRIhTk6iDguPF/YodgrreMcjoYi2ykQXl9E1jl+sZInGZu6pbGxnDorNzUh66NT+xMAU54vh13oFZVf3vmKhMrFVihLShbkhSsYo0FkYp/Y5LDJ7iRi+TRMxNEPU56+8Ix64YH1xkHdJdzNQom6ToEXT1QQ3A2JfYre3E6PGFuhDwu9CN2nyc1zEgHn65dtKAxQ==
Received: from BN9PR03CA0609.namprd03.prod.outlook.com (2603:10b6:408:106::14)
 by BN8PR12MB3618.namprd12.prod.outlook.com (2603:10b6:408:4a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 15:42:13 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::62) by BN9PR03CA0609.outlook.office365.com
 (2603:10b6:408:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Mon, 21 Feb 2022 15:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 15:42:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 21 Feb
 2022 15:42:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 21 Feb 2022
 07:42:10 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 21 Feb 2022 07:42:06 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v20 0/2] Add NVIDIA Tegra GPC-DMA driver
Date:   Mon, 21 Feb 2022 21:09:32 +0530
Message-ID: <20220221153934.5226-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9829f858-e79b-4916-84a4-08d9f550baf7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3618:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3618AE219D59548D663B29FEC03A9@BN8PR12MB3618.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtAtGV20CiCh1OifVE8h3ImgCV4Fa+7+MftWxZwviYMO97ssjbeb4YTM20XCBV3ZuIN0iIM9DV1s6vo6nDK/iYWOGMOXnrYMWM74ryM1zQiPk20nA2kXoURxkW5q3TDlHqQaI5HyhHZgWmjq1/YLN5ll3x3R/Pt5kTVWYN15sut/Ly/wPdYP8FrJ4l33gGDcGrZVdOdvwyhsw61nrzqzjweu6QNDxAx+D+Mg+sdnm2i50ToIloAyK9hASKDURfdfXbfBdmJ6f1j2UIQ0oXeqg1pJGy0O2ScMo0UflGaVuF3dUMYAxyJb1WfyioMuOMkj2bgjYR/fAcwWcMRC/sP49oJeGe6jrb+8QnnwUzApwh11I+RCYhMnQ8+3Ga9V2rjjhspQCeZNSrxdw1T+VPgx3oZfTlqGao+NgB8bU4F7Rk8L5LVeDHIEb9dekCC235mivivUfZTf7li1rkaZ7GLCchmRiaf44sSKJuZ3Kp/1btbHLsMK51rB8a1eTSxi5wvTEF4rOUsl0e+HiDpNZGTslLbQu3SpFbp/8fHVQ9JOAUta+QcpOTMsncmRzrIlY2/oEMxg6S1azAkgqyKqVm8KXwo7gCj7iyewhZMBWtUr5BRMsGmUKD3Z2Hl6PNH+jGE3A3Boml21jln8QQxv67L4KQjl3aI1OmPC3cwdWE5Kkp5YLmRYPT/8xASnQ20RMtq3548Vuqvqpp9fLeJah9FO2icaf31EMEVFzuUO38Tq9u3XGQErkv5VseFIx1BATHrPS7J9z1hsu2y7F/TgZqttdg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(336012)(70586007)(36860700001)(70206006)(36756003)(356005)(26005)(426003)(921005)(4744005)(81166007)(2906002)(186003)(107886003)(2616005)(508600001)(82310400004)(86362001)(1076003)(8936002)(5660300002)(4326008)(7696005)(8676002)(6666004)(110136005)(316002)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 15:42:13.0889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9829f858-e79b-4916-84a4-08d9f550baf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3618
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

v19->v20:
  * Change in sg_idx updation to solve issue when sg_idx=0 in cyclic
    transfers
  * Styling and spacing changes

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

