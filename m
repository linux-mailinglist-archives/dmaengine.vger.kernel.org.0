Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45721569FDB
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 12:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiGGK2b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiGGK23 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 06:28:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CA3289;
        Thu,  7 Jul 2022 03:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCqF9Tb34NnXDOqPjF/Zo4CxhqA24db67A9DMnj9JN2vG+CI8+JRGwP2aECZUcc1WeJxsn5LeKWEWianaSqCHYnsGDGNc3kAEbZuLpqzQfR6m7eYEbvp+A1xbEy5Ujrw0WdCzV+RN4cIlDt1KzR5O+I9pmLYg4ZNu9HpYn1NS+T7DCwAMziWdo+NwZyUQmkrN3/mn7J6CmfOfJ3X+LP8lxkIzqaRGdNgXy4pPSSLXg7GGnZzpRvIowY97fdX6jcU8wh8a6nGKnCM3wPTW+fLWiYybuZMHXBI/EKKMSRM+XazukjEudI7nmQcR7IwuCsFp/V8fd3iUHZeIzgVgZdv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksKAQuV2Ap3SOQbtAa7geciJy15Si/B42n/BPU0MkOM=;
 b=IMWYw3IJjU9Yb8VDbrBX9XVuklHbSBVTWPnfodONdiUz7khz6kc6yckRKhxSkf4yxTA2nPkWwMSxzZirBIPSbtAEI/V0K6B78ubWcS1O5BVD68ss8Mul0SVd3WvK0xLMklH1muR+fmW3HRl/9EnLDtFrF59hPGiRnNtyFWxhycMTrErICLjPnilD9cmzepKOBMWEjKqBuhiUN6GB3oKhQhmZwfjpr6VCEnpZmxx3zED93n4JILZwnIwqN+FpT4Ap2VtecIoGj4T94ZO709OD6L/RCcb91mJc8w95zufTPcHWlOijUndYqhSkAyx8or5uHpnEBFXnT8tNhBts1ILC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksKAQuV2Ap3SOQbtAa7geciJy15Si/B42n/BPU0MkOM=;
 b=NfM8siuPZCx5c4cN3SPHysY7U97VvS2zu+yVxEZYJOmq805uAOCHzyYxgapWNJGW3pxOUy6bXj2z6AS3NPx1i/+y8C1p2IoBsAAP071vExKOjx3FJHtt754B8d8GC67bM+m0PlGA+I5jkUH/NEMDVTNBWOusSGi47yjjJHqVgCgcJ3gXlCqe3PJGz1bnLvQkBxRARmwrhWoNXMoONQRSxzskhnrjOb41sRxjf+Z1wISNBPYEMyH45E7Ebr7qIOwhplXatpGMoiFjqcL7LGVxMNG21msAmBmAuldh1x3Yzi0UZ6PVquAvCe8zLQvK6h9thNaWIEikgtkf2CD47XPVvA==
Received: from CO2PR04CA0190.namprd04.prod.outlook.com (2603:10b6:104:5::20)
 by DM6PR12MB2793.namprd12.prod.outlook.com (2603:10b6:5:4f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 10:28:23 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::79) by CO2PR04CA0190.outlook.office365.com
 (2603:10b6:104:5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17 via Frontend
 Transport; Thu, 7 Jul 2022 10:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 10:28:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 10:28:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 03:28:21 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 03:28:18 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 2/2] dt-bindings: dmaengine: Add compatible for Tegra234
Date:   Thu, 7 Jul 2022 15:57:25 +0530
Message-ID: <20220707102725.41383-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707102725.41383-1-akhilrajeev@nvidia.com>
References: <20220707102725.41383-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a1d3c31-8603-455d-96c4-08da60036b28
X-MS-TrafficTypeDiagnostic: DM6PR12MB2793:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUNyYTK5kAb/3GorHAQusz8/1SCDOA1Me3S3Axqi0dgSIAzADxKUAAYUkBAdHsHCAmJd8fgHQt5+jr8IBhQIbvQUKl6YNCzS4N1f9hcbAEm/o5YQgEVUfR4UeHKG178mx10kQyMNk19VpQl4Z4r4YaxJQnmcIBmHhPCgqYqCEaoqqJyDjpWcRCwPkfkl1tSeRasH7+IPhlWO4ihmAmVcKBtOrxNikK7lFE/oHFqR+NYZC+S1P6GDKx5Jbj9SAAE/MASyrWBbDGy2LobwoIVRI9Rd1AtZOmqWqP4YsdJOR4YXHOM0evee1Isx7m6NwlZjOeFt0CngGt8r1vuRgUlWB97KYp1zYfwniuCvi7y/Wyp24TkghQnMX6I3noJSCn4eZFTWLw8QCpDL0P93qhjHiBwwOZ/Px0s3y59h9wc4/YukCOc4ikrovX3amrgubTJidT57aaWwTwVzTdklCtk0Oc5jxgVNIcNiXTKf/cPIV5aGFdRskRnwFDT6FMbrda5Ovt4eWRoZi8SEk/JE44CZgvA79wkAoV55qxqzKqyUlmpIQhvA0wBBa0e59sgcHePnVI0jZKBlRIDa9JfcEycG/nCBaEz/lfd29y1XuIwEfHCqUg1YDr3tZ9Q6XJk2Zc5h1DhIY6qqdYY1xIPSnFikOH3zxYnfBSjWWLiIE1d+GB/6foP/KzfDZolbRasQkgPmVzaUptgz3oMXQz2UCDBxgMv0nQ3jvWTt7iZCDNH+HIKLBsnmEmMH1WIQurKY16Q8eOby+m/9E0lwCSOiP0WuIHtV4XB2hqTqi0IAQaPk9fxLphvze2DO31TCJ7l2UWlxOzbdRbMhzPmtyjCbi5mgRq+tdmgJCwZfNCFegYEgB/3lx78uZW81lMfkrUn6oWPvAYB5rUgGKsb+D0eqDawNcIsVMfUGeJWrD+cfXQpt0CY=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(4744005)(40460700003)(40480700001)(82310400005)(2906002)(36860700001)(82740400003)(86362001)(81166007)(36756003)(110136005)(478600001)(70206006)(70586007)(4326008)(8676002)(316002)(107886003)(1076003)(186003)(2616005)(47076005)(336012)(6666004)(41300700001)(7696005)(26005)(426003)(921005)(356005)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 10:28:22.4243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1d3c31-8603-455d-96c4-08da60036b28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2793
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the compatible string used by GPCDMA controller for Tegra234.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 9dd1476d1849..81f3badbc8ec 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -23,6 +23,7 @@ properties:
     oneOf:
       - const: nvidia,tegra186-gpcdma
       - items:
+          - const: nvidia,tegra234-gpcdma
           - const: nvidia,tegra194-gpcdma
           - const: nvidia,tegra186-gpcdma
 
-- 
2.17.1

