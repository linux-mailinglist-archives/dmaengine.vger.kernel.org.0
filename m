Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC5569FCE
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiGGK2C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 06:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiGGK2C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 06:28:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2471253D15;
        Thu,  7 Jul 2022 03:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHvwOwQ4SRE2jaKEhgOwmSEHRnz11GF97RlUaQGfblByC+ScdE2XUcUnKFnEqb8Ot2x9k/Ygv+JdnZ4RKk3m9d6UJIz5DiomcXR8Q6ZkOgwoZoHPWfZNnYhvarZrM+7ERR7nxuNEp9haADixGkmnHlv5mOrYk4zrQKcFAmRz2CesJPqBszOG8jRopOaodKaiyFBUkWm+sUSayMZkO93dgI8XKAy4QpynpIubqYUHJmS9Z/N8AE//SL4J/MDvWGlg6HKxbG4o1r+J3+psnkPtvxweJdS/n1CXPWgFYgn/Fu5ihcjGkbOqjIy3gKZ2Xsx+Ul6MK0t/stbYI9yTLIGmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM1zSxmI+2H2m75r4qrM/SZXreN6axvHp5gdZKoF5aE=;
 b=BDcJ7DNXqJn6caPnAveIv4npFqouIhcl4sqZqMs+xbk1thMJGXatzpbAtAq3ucQdotazr74n094Bp2cqHzSYyINWB3PwrInAX6esyVRC6O3EgMoz4cXioS93lWSw2lUm7eitm8WLl6vTz5aUjEUHtwtU1lP1ObbR08MRrVDuN1FMjyL7FTT9zZP05b3bS3b6jC3KW8Z4bTXWd376SavPDhLcg5SxY19Wg11TXnpDvejgDJeMcYTP/5GHbZIw8aGSco0Rj+Aaf3q5GrDTgZLURTuaKjl6zSUCdaXqhdSQwK/ckeUU3qRGh8viyP/kN9/LmG547hEDqphH4OiKYCwIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM1zSxmI+2H2m75r4qrM/SZXreN6axvHp5gdZKoF5aE=;
 b=qarWfpLIbJLkybaSHW+y7F8sFnXNIFxv8LQZXtsXVR0iFWC1KndrmQC9wQ+3DFAuTJupCf3qy36bfmf195sPHRlUUCeGl7UFV9Xh6Wxdcuilsb+xrhZPlK7XZXpTXe+HGi/gfHauFabDcgaKUSPcLAl//qrB2aypn5jZfKya5Rlyzvs1FvbroxgeaGqgRYsH4vsOPM9QPUO1MGqPfKa9ZOnkL3xldGN24gvbDNZ+L1b02Eiz0ioqUN/y2OQTjwueRGWrFvLQLnoFl05owo1W70UznPFqPqtexCoaIoOAFoMXCKjcthcZ2ke3nMphl1lTt2O5LdsiHXb7qct5vWH/kg==
Received: from MWHPR07CA0020.namprd07.prod.outlook.com (2603:10b6:300:116::30)
 by BN6PR12MB1332.namprd12.prod.outlook.com (2603:10b6:404:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 10:27:59 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::39) by MWHPR07CA0020.outlook.office365.com
 (2603:10b6:300:116::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 10:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 10:27:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 10:27:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 03:27:57 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 03:27:54 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 0/2] Add compatible for Tegra234 GPCDMA
Date:   Thu, 7 Jul 2022 15:57:23 +0530
Message-ID: <20220707102725.41383-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4741a9c5-42d3-4995-8acf-08da60035d70
X-MS-TrafficTypeDiagnostic: BN6PR12MB1332:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oDVUVl88LQveVMUty/Ynwm/j5/jvKXu9mgUZ/yVqQQ2ToW9hDF81veWomPwJkDT3mq2L9vkv0+cyHGTf4kKg3xFR9/E/BQ1GZfl7XSMbFRIrBMPgPtS1HRtdhA7XzMT3zvC3lMeYubqyaJ543/f0qWVmS6cC1JJ34cax80KjNRukBHmEoHMdeTIrFEXe1aKatDFX/luGMdm6vhfOLED0tldSwcI+ud/gLbjiFfNMritA4LeU0/o1wMcZ+XzDiqFh1ESi9r4AyOyOBGcSjxYyVsIJSken5R5H/+2OqPzHyFphz6N9vGhE7clZtN3F5hYsvrKzQ07THf5UiiqUuBJJUt+D+auYvDwT2GXpEVERw2lxFxShJ8noRSmSvzUKcyCNsWMeW+16isSxF8sR+yX70ze7W3D4ETTQW/sXp4OVdQMuAKSXgl77j9FxNITzljk+263A06xZzPFJt92I9g5ZESnJ0W30VN5i45zAz0k/k2IQUvSSlE36hgr85G58xWYA+qz9vQfyfEv2QGRrd1fZz1c6bzSkhTrxmAwUuDlJGLhXvVCxvnj7np5RI9pTCno7J9SKnfp1HsDlvUscq6mzLn4PH/y310xjkyPJ4j8rqK1noAecTxOeozpJFUdTNqWfS8q+Plvtw0ZMCemMMQkOOUBUIAu7bIW4az/1hfu3NKvA8+ibHxGWMIpWKIj03fQ/6S8YwFAl4wGB//H0aTloW1GkRlj4VlqrLLi0VhjMjKeC5T5nU9FIabpo2kvz4WdMZtd9Zl9XNF0PtxrZn7djU4eVuk3meZQ4V+vg+h8klTV6pBpWYSMWkPqBquwZn164/Zdv2PggHd8fToPgKna5bW+rhfoARaJErqeIKMSVdQ5MOyM/6gVYGwbGSMj59TxdiwLPM3VJe6QxHLCp1154Kjua9XPrktQPqu1cmvlSEI=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(2906002)(8936002)(5660300002)(81166007)(36756003)(82740400003)(70206006)(86362001)(8676002)(356005)(40460700003)(4326008)(40480700001)(478600001)(4744005)(70586007)(186003)(921005)(6666004)(2616005)(316002)(36860700001)(41300700001)(336012)(47076005)(83380400001)(7696005)(110136005)(1076003)(26005)(107886003)(426003)(82310400005)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 10:27:59.4077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4741a9c5-42d3-4995-8acf-08da60035d70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1332
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra234 supports recovery of a channel hung in pause flush mode.
This could happen when the client bus gets corrupted or if the end
device ceases to send/receive data.

Add a separate compatible for Tegra234 so that this scenario can be
handled in the driver.

Akhil R (2):
  dmaengine: tegra: Add terminate() for Tegra234
  dt-bindings: dmaengine: Add compatible for Tegra234

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  5 ++--
 drivers/dma/tegra186-gpc-dma.c                | 26 +++++++++++++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.17.1

