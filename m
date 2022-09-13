Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6AB5B7744
	for <lists+dmaengine@lfdr.de>; Tue, 13 Sep 2022 19:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiIMRER (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Sep 2022 13:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiIMRDp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Sep 2022 13:03:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D691C4816;
        Tue, 13 Sep 2022 08:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsAqGVHrapKRU2esH7d3ZizFZxLRrWH92Lbr1N1VstlEAfp/1KwvUaKKCWNhU+3jUUq0efWv5A0h5l1zvhxTSEBRYiB3SwtmKIAr+dpm1zb2uRFbgjSl20DGpotdabXduSq+iKno3GFU0zlrusb9f/Zj0Ic7bmL5LZ32k0TZhgs42V98rFS58mQ0ZIJ14Kc3brYVm+du8IJ60uUqRgQxPCQWU7lj7cP/DGE+Dui/k4LCcET8SM+JGm+YN8y+oh7waBmNAgFnrPzraLV6L+3ycMvDjiuiMxT+PZ/yFFrQIhlRX/DVZ9lbv83GHY5xYznFgWOypSzU2aFo/ecQ35F8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOvIDM9ZIxvgS+voBSHklQ0HJWbpefTYM4kRcohY3H0=;
 b=UJQ6/yMY6pQdy9ETU1d0XBU4PdVsmNkCirD89N+3rOqGaH99jjWj9JCFM2hPgNsf5kczxL9HULNTB9scJi87Nt2WChW/81lf4k+vN9kAowa+/VivqEFFM7jEheKQEtHy/PurBPqcQOcIzWcX2oEknd1zqIu20fHNg3Cow2+AMkyyuyLO7Qm722d05cYCMCz92ysOMlUdN9UFaQKTTx//DDZUCUrYn8hHReRsOGOF2cCsqNb2ag2IcpF6h3OAk34ZigKSfaN/qOKG52ZM3VWGR+QpAZKp8+OP0A1NCqB8DwXjBLjO2fhbxkz8JgJitjtVUSoDWaUJhsbmOTERE89y1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOvIDM9ZIxvgS+voBSHklQ0HJWbpefTYM4kRcohY3H0=;
 b=FtdFgrFIYhLHwAPjx0hpG4kz5CdcTwy4DrGnMrFtDnSqsoG+mwJ0EN8KWyGYP+bMaEVPaw0iRpUrUze0Uxy56I8XUMVxc/qegCDuXpsDD7SgQ8MQcUyMyL14PtAOCnW3BbknGc+N2fYJLTaUo7tb67s9Rh97sqtr3t5sKvAZrIcCLaIK7qd5mieX3RtnwLCb6uqTe0sKQlm9mUKktNBUrKW3zz2pWt5HHnOx8R76SkQQWNwMXRuXKoJUfUWBO51eLgzvQlO5RJ3MWew2NWjdLkL/6G+r1zHK7PY+DNToXrsD6Uu3pmIh/kD3uIRN/2eUA8x9mya1lH6SK2dGSBTepw==
Received: from DM6PR06CA0090.namprd06.prod.outlook.com (2603:10b6:5:336::23)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 15:53:08 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::2e) by DM6PR06CA0090.outlook.office365.com
 (2603:10b6:5:336::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 15:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 13 Sep 2022 15:53:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 13 Sep
 2022 15:53:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 08:53:07 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 08:53:04 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 0/3] Tegra GCPDMA: Add dma-channel-mask support 
Date:   Tue, 13 Sep 2022 21:22:48 +0530
Message-ID: <20220913155251.59375-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d02973-ef19-44d2-4611-08da95a00dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1YGfwxOkEid2E9HQbCYrPpkYQ3VBy8WWX7TTRvupuHUmsMHV3REtXgCvqQ3/aNCQ9kulKtM1AzFJkr/wSsqAjcgtc0Uf9e+gRKzyW4aFbx5Rp4xUydwMQmCe1kYjfz9Qhx354QsaubxX0wnt9zLHp7x3mgqgd6b21ul6oPOSRn9lJ0daZWLlrXkwpe9BLE18UHNV/vBfYoSbR0w+/RJwyL6CYBlmPtUMSezwwQIRpS5UqI+UYsXzW/2Mwst71wo4Q2YyO5YpTwOXvOA3A7+7cQ6640W2xMioZIY/4MGEEc8eRs3lKi2EZzzKtCqX4eJ8D+kHf/Rqv1iVa20EgfoHGyRKpZozD7FEe5uX6T4MuYFCdjtKSJTWXZjP8YJYKMby5UD5QM6IdDJY8r5bvabiuk6wvqBvktgrRvUWtz+DL7CXZeVwVkz16nFTzB89IIHsZ6iTxLgdW3GiUkQ0Cj2pEBzMQzxHfx3czXwI4xkCr+CSINU+I9V68UBrkCZY0XUn3AH24AMA+hPsKuStT8tr5bpgv8hUpadR/E7brYyCREnlF2fddR5Wqko0rVrxPyrW0+wuef5xciVXR249UzoCyydt0ejZTC+iFNlcb0Vl+o6GJJZtSu+6xCMzURezgz1BBYRCu0Ro4UtrIc4Xzy7ioIF7HgGBmEksnVJvcqjK4ZY54xesNYJDBpQ+t8u5Q+9xbM8LMjlRjSKwILGBziXMOiK9CehgwBDd3wTN4IrXopDe5bLC7f8KFwk9DbHE23J6LL6qtwiI9s3smmBNUak3y8Nu68xOYLaa5adF3Jz8T+NHd4QEhiaaRHTcBWTRPk0
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(186003)(356005)(478600001)(1076003)(336012)(107886003)(110136005)(36756003)(41300700001)(4743002)(5660300002)(2616005)(26005)(2906002)(4744005)(40460700003)(4326008)(36860700001)(6666004)(82310400005)(40480700001)(8936002)(86362001)(81166007)(316002)(70206006)(83380400001)(82740400003)(8676002)(70586007)(7696005)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 15:53:08.3697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d02973-ef19-44d2-4611-08da95a00dc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Akhil R (3):
  dt-bindings: dmaengine: Add dma-channel-mask to Tegra GPCDMA
  arm64: tegra: Add dma-channel-mask in GPCDMA node
  dmaengine: tegra: Add support for dma-channel-mask

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  7 +++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  4 ++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  4 ++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  4 ++-
 drivers/dma/tegra186-gpc-dma.c                | 35 +++++++++++++++----
 5 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.17.1

