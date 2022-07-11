Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5F57076E
	for <lists+dmaengine@lfdr.de>; Mon, 11 Jul 2022 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiGKPqe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Jul 2022 11:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGKPq3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Jul 2022 11:46:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB703343C;
        Mon, 11 Jul 2022 08:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI4SlPH95OcFG9hICSlu0xMdIA8jkHgSGAp7MYHmLUn0fPn5ecyMZ0ckWcG6HDOg0+lZFNaf/Je0I6h4dc6SxZJK7Dvfq7NIsiUlk8noI4v3EPSbkuvMEdBgTj2N5+rIFFbWL6CUGrbplkHP2tnadXTsiBYL+R6dtfgaNkWmEn0Uof1qAvQ8PN0AsE0wQYD5dmdzsDtTQXBiWO9hudSSsf/c/l9ssArUj+OI95TGD0Ei643MIok3ht8vlamWKTToBVeSkUFLUnGQmWpPmn5Lduh/ThXPX6XTJBz3LlTiJfpoOR3G4uT5ome/AiNOjGZMZQy5Sxp+BMdQ7/ho2oXaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgeIeTKe7wW0NZFW3xYK2XEq0dmlbhVw7IbjVQQ5Mzs=;
 b=aIpxZHPm11nzQRtxlzwonsZN0qjRgUXA99yb+OPApEcr0ZHFEeOL5Vpd9bMd1rrCNswJlxq96X2+IwtcLXv9TUXKgWA1LGdKTkE0cIAVYd9FRC+npadVSxRWlTQT7dfDEOTOK+9Yt4DTHjLOBny581HuryIUXQ4Es9Ed2ArSrgjJ1Tt72/on1zOwzee+LNtnUA46LwTqJImiSs6cXudZMEAL3dc3Aoh6LLIWPpRXxhaLyJmD4ugIhz7B/oAgjmyCkv0vfYvFMUxBWVEonJDYArM33T8dUPG4pm+WqVpkBmbPutGb+nu3PLBg3YWywVZ2fF/08wX06eo12hQDI6AdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgeIeTKe7wW0NZFW3xYK2XEq0dmlbhVw7IbjVQQ5Mzs=;
 b=fvqDWLUGuX/+PJZhLZw85sIIoS3eAtaKF8M5mKEqv/pa6tZ6B7trq4dAaJ0gcCM3JHmngJ+voG7EIbIb/g4/eXY6mf/Q/sdIhStNW1IgojjHnIueXX/ISTKB/aIiZiWlWQJwKIzh0wPbh6ca5mDaz9C6SQ2EwNQs1wwbHpU7BN95EaFVEqD9gSVKmk4QDCRC2SfF6RsDvti95+JhRTwnqVwf3nFWUuRaTRuQHM6hvvH2XFdUeDJmH25OldMI9BoesMx0vpw8f1ZkB+fFKnS31MGjtALofF0NW3HRagRS3Dgs1df2C9Fj6a4TXZjPdzzWV858PCxjGGX/9hbAblg32Q==
Received: from BN0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:408:141::34)
 by BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 15:46:27 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::26) by BN0PR07CA0012.outlook.office365.com
 (2603:10b6:408:141::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Mon, 11 Jul 2022 15:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 15:46:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Jul
 2022 15:46:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 11 Jul
 2022 08:46:25 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 11 Jul 2022 08:46:22 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v3 1/3] dt-bindings: dmaengine: Add compatible for Tegra234
Date:   Mon, 11 Jul 2022 21:15:34 +0530
Message-ID: <20220711154536.41736-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220711154536.41736-1-akhilrajeev@nvidia.com>
References: <20220711154536.41736-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ad41cf4-c2db-499e-a2b6-08da635483fb
X-MS-TrafficTypeDiagnostic: BL0PR12MB2465:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9XWNVGE09GrLsxZpILjUQu/KMPdY2hvO6KtK+ARBLLesYLMt0e9D03z61/WTdTQuxzdV0osMHmPYjG8MJPGJUeyBNH59TIYYTpZRkhRUx/088RsXg7VTLFMLIasUGYgdCImLw9FovcleETI2UFm4Psj4bc8YbrvfMX+d2kRBXX6IXq9S4D9wqfD9bcy+eoYcNiQUix6CaQuZgfmP8mMwpXqby6uZ9rkDqqrg7gCLlNM6UHeGMbdBtBkH8totLFnSbxFCXicWIc8hPmJ52l24oHqoKKdk4tbMh5cyvOvhK6lLSM9Q5iqRbuqhRWFFLy/DgXZT4yAqrujaQWqJm9pbf6oGXCrRdfWQAfphOtDzO5F2A0XIQUm1TPRzSbMLfKeNyYOETTrLTWIZn85wF0W1JgEVAZUTtK8i+HLEH1KJM43BQFAlJ33kvZRRfj8I/e3ifo0P7eCdQCGvcBFm/hmx+ziyt8FGIv3NwWKA2DFKTGLKB5FlQlqjCqYV4eiJwyPnR/KATva26UZ0nxAk8CjAgUNso0osJLzEj+luh7dCtDm/pi8F/cPgoyEvTgDZHfj1JamMF9VECp70LRCIK5+qvlKEplqsSUL9X5QrE0E2a2XvcLicf8aMT4e8+b5huf9eajlskb3ZQhqpA8ykB8A7nDixndPjDWZvLoTejIpN/Trv5bJ4AY+LBamTX3QWftXhRmZXHiCpdqaFWzkPSOLAN8m0Fk6QpBaOHu/EZ2d6wiCaIYA7SSrnPMBagb3y0qJwEPEPTm4PCDuVBSabNvsdzzElBPX+RoYs82gK/Hti6u9ell9hTnnUR9Rw8Qqm7PTRZu3dsaEwcIfvsoj6U5IHk3skjA20RhmezyHRwD2Ilx1qfEazBOgf0T9IFIRMcvPa13LBm22GJuPRax+GnhEQDIoV2UisWtjShb1nAvXBCg=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(40470700004)(36840700001)(81166007)(47076005)(2906002)(336012)(26005)(82740400003)(2616005)(7696005)(70206006)(70586007)(426003)(107886003)(8676002)(6666004)(186003)(41300700001)(86362001)(921005)(82310400005)(356005)(40460700003)(1076003)(5660300002)(316002)(4326008)(36860700001)(4744005)(8936002)(110136005)(40480700001)(36756003)(478600001)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 15:46:26.7337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad41cf4-c2db-499e-a2b6-08da635483fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2465
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the compatible string used by GPCDMA controller for Tegra234.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 9dd1476d1849..399edcd5cecf 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -26,6 +26,10 @@ properties:
           - const: nvidia,tegra194-gpcdma
           - const: nvidia,tegra186-gpcdma
 
+      - items:
+          - const: nvidia,tegra234-gpcdma
+          - const: nvidia,tegra186-gpcdma
+
   "#dma-cells":
     const: 1
 
-- 
2.17.1

