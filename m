Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1DF57076C
	for <lists+dmaengine@lfdr.de>; Mon, 11 Jul 2022 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiGKPqc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Jul 2022 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiGKPqQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Jul 2022 11:46:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789747858D;
        Mon, 11 Jul 2022 08:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtR23iLhXlIZp4plIyfzjtpVURr4AqrEf1eTZbIlLX222TvbyLuUf3eVkYejTdaQBOOyineXDsfKgtBGs8OhQmGbDoEPlK922aMZSVdlwcx+6dyhxTjDbUEMGkVpjugki2HVjBwNXdwZXDZwVdafix85fH8Bhg0ftCX0/8xSQ/aWEkkax6MuZzuV8NEohhJzEcRg/VkoY1RVVlfVurvjawXQB1kb0sWCdV1phI/E818WR5LEU+yBqBY54Aet1AYaJTktKppvMjOLtfsxut6Po7NR1k2S2moAq8WYHj3CSKfI7c8RFYGUmHkXWEZdJhn0xOGDtlJTHtlhP28vAnS3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG7HMcZZDVbEqneZkOj2QM3ZKxcPkRSqRmdfKPWuzyU=;
 b=K7WYn2Ez5oR03v+t6Zz7SrC7NoscwPrt3j46ago6MP9tbfa2dvHx6GouJf59+1VX+aQn7fhvsy38OiCXXsQgGy4dxfZfr+gghCEpx9QKGPex+apqcr3vw0su6rX7zxa6oQeI3miItOaqElxkCn4wOS0k+XHwwrKa6ms9SbtAqN0/TBu9qJ3anCfueWhrF0GsddGPjHIq7NmPQFQx8P9mv/Nzhu5PKCjd6o4BDBKflJhcxzzLdX9S2fx4rqXSEzfOhlUfHm5ALW3BCk3zdo9WPRnLnjSVlxzZN+v7mFEjOYk49dK5e2MszTKKKPqCGYUpm5KnfkED+1gjuF3iJdVfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG7HMcZZDVbEqneZkOj2QM3ZKxcPkRSqRmdfKPWuzyU=;
 b=lL/h1mVfzgyuGy+Th488ooMk+vRrhUT8fayxV46MrknEeDnhNILZMaKVq+eh5lzgzTjPpcOdN8FWCIqhsh/X24dCbHnavpqtSRUDomZjLy1I0anJ/czh6JGYrept5hZWfcQPNhMkf6V049sP2uBRmRA9NUg1U4vMMFVr8DUtPdKiD6nxt4yf52d8ucoN1PhaRNXPLMEmupsthBs5RNCR/lccdo4+f+ChzxnIM24QSxIDWGZqmxfzH2Tnk9dx4YiOxr+X+GKI6DWPijnwOSlJM7Kjw6MxlQeCI+GarxOAoWrkhHEoLVvJGg8oAS7auwuINCaoK/jXHHFocd5QJwSlBw==
Received: from DS7PR03CA0264.namprd03.prod.outlook.com (2603:10b6:5:3b3::29)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.24; Mon, 11 Jul
 2022 15:46:05 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::d9) by DS7PR03CA0264.outlook.office365.com
 (2603:10b6:5:3b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Mon, 11 Jul 2022 15:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 15:46:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Jul
 2022 15:46:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 11 Jul
 2022 08:46:04 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 11 Jul 2022 08:46:01 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v3 0/3] Add compatible for Tegra234 GPCDMA
Date:   Mon, 11 Jul 2022 21:15:33 +0530
Message-ID: <20220711154536.41736-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d637c450-64da-4ecd-4314-08da6354774a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIZur7rc73yX0DnlXcsmEURC6K4LYpY/+Gc5CnQtrUxMzHCaet0gpcAn84xWm01Bt6wMb+Ke0fzuBlPNd0IlkqJGRLXy4oZSl9MRZ8n5yfLFkHWxttPsIfKjJJqq+Gq+PDizNfAdSgIVfVOMCZR4djR4Dn+9rUNvG1aDDj1vCjKAfasdLVT1ZEoj2fElpAC1s0hCHJgOiKeEkHMgnAxHmWM7EWARgXKdY2wP2ou0yYmV0tMtIi0wDl/UG7ryFS6X/nZJlHRCR83ApKX1z9aHVSA1Ube8/do+r+wLVSZ2v5qNctpsyzVigbqX5ktbGqp3OhRYQh9kcGbznDrKxOLCZTWo3/espnytB0IIShJU/vlKEKabyZT1TzkHYLe6YrR5A4LgAYf6J7A/gmuC1d7jjH53A0uLqggxoo8FQogOJw2Y47w7b1loMMEW8DA9ubxfPfAuat9ggLVzNUwfLxTa5t1eoZb+7muplWbsQVYz9wAyJjdC5LkZoENeJmCRIBGB24d1L7FDkjgD/QrqS/n9DZKiUw1T8/So+BwMKn6430bknJ35Edy4pMJj+QFN+l3m5epNH8rCD6Hk7deqZOIHEPeNFoKgWhrKUloY7c73FvDpnCko2z0MJePwHpI+ge30WKYAuBQagpzRW2f0ezLAkxUUhktpx7IDNvNRowlqUWB0CHqvT5DX0a9bMeNGAbJnSRF/2PmNqjTDgOtwEqRnkl5og1BwPd3lQMY7gOKyHLtkvPYNNy77+qGxx+v2exzc4voGKWFWK3V8lKO3ZEKIlyCooOO2L0ENuO7U0ff0lTt6eUevITvbg1dQ6nXW7zPu9dlaPUzX65v4EbXrHSV1eMAThMGLZDKUQfO0E9nbdbxwZ0YpQ3Dv9udJmYq6N3q73k30YaNnQSNmQiYVXMO+Pk1eW0IkYjCpINAjzjZnBvc=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(36756003)(4744005)(8936002)(36860700001)(40480700001)(4326008)(70586007)(8676002)(82310400005)(70206006)(316002)(110136005)(40460700003)(86362001)(82740400003)(1076003)(921005)(2616005)(107886003)(336012)(478600001)(356005)(6666004)(47076005)(41300700001)(7696005)(186003)(426003)(26005)(83380400001)(81166007)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 15:46:05.4854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d637c450-64da-4ecd-4314-08da6354774a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

v2->v3:
    * Updated binding docs and device tree compatible

v1->v2:
    * split device tree change to a different patch.
    * Update commit message

Akhil R (3):
  dt-bindings: dmaengine: Add compatible for Tegra234
  dmaengine: tegra: Add terminate() for Tegra234
  arm64: tegra: Update compatible for Tegra234 GPCDMA

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  4 +++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  4 +--
 drivers/dma/tegra186-gpc-dma.c                | 26 +++++++++++++++++--
 3 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.17.1

