Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBDB57B4A3
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jul 2022 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiGTKlQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jul 2022 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiGTKlQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Jul 2022 06:41:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272CA643F6;
        Wed, 20 Jul 2022 03:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eySUFCshv13mmQjSAxpP8XjuGRUQfLsbk2olzep7qIZ4lB/aYKFA/yB3heKkQzTx/NyPzEJNYY3SO/b/kK+3KFPRHc7RidE8PLytiIMjr2NzsNR0b04l9o3nZneF4HCb6wO6oZOtdW1BcsFhKBAujY1XRJ3nxq04kkE/2AE3UcgIlL4C726F5p/0CrFTFG75Jmk55hO2QFNpCm75MQVD63GpN0xTcOgTwwIKtcP2KmTjDsu/52jDdcyI1e5/rfh8nmGuSo+nhkZqRITd4u8aI3LiqXshgpKUUYGR2oeII7baebZAIuFr3E7kppjNQLtzBAZ6gBCiMr1lSDam4W1XYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VhrwE4hdFCjjzO4lFl+zAZuICGuCKoKTAycraj9D/k=;
 b=jVM0FE52UtwA8fDskRRUCVVvws9DDmCtMEelCi1Aa+jO3gLpxHCRBDKfuvJg/aaBIqetVPwIA99BxcdHDni47hOlXWF72XGwmuMSXdI1ArVGa9e2cQTzKfnqWekUoj3a7dzGxoOOdnr/lSMegRV6qKWsgiTPcA/UX0RaUqbwCFjef8Th6sN7d9UTgUcHjwSC3KCBZwoPv3GMUjeA436GFY/8AYD96D55anFMNuYoykBFUmmBEfVIyQb/0vstKCFMITqAoiimMdtdfqSUsVxnTTozwEZSxdS6Xgc9OFCseFCWP8Jn6wlDNZFzCZj8OlI7yfiS4ShjT5kF9pBOwRMkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VhrwE4hdFCjjzO4lFl+zAZuICGuCKoKTAycraj9D/k=;
 b=eJDiBpkdGlyNLDwwa0Kn0h2+n+oZsHqK8svLXTQ3lnwk4wR0h98fuRhu0pquv2Cv6TJQ1c0Cy7V8CgNO3L71mTszVkc6nP2+4RodqoZj/x1o0dr9nFDLQy0z7shhk4PB3H7/9sZb/s2KE4v3We3IIc9D59LghLxtJ+jBP2Gc7nunWJhu/6XsbH9XcIHsoM8tIxguVFZlsyqfNNIzR4PxqB7JVw8KK5TUn6fAjwWzZErKccrgC9P1+QZMTFtM2m9MoifDvi88IXyAEi+Wzj94+xGEkpHlc/VI4C09dzEmI1uO28pNd4w8Zsn1UECU0oaw6QFTugEx2PWu/Cf7WwLZdw==
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 10:41:13 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::2c) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Wed, 20 Jul 2022 10:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 10:41:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Jul
 2022 10:41:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 20 Jul
 2022 03:41:11 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 20 Jul 2022 03:41:09 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v4 1/3] dt-bindings: dmaengine: Add compatible for Tegra234
Date:   Wed, 20 Jul 2022 16:10:43 +0530
Message-ID: <20220720104045.16099-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220720104045.16099-1-akhilrajeev@nvidia.com>
References: <20220720104045.16099-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3ef6a27-97f1-45ea-fd44-08da6a3c5dfb
X-MS-TrafficTypeDiagnostic: DM4PR12MB6136:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqe4iKiYV562VbwNj3Mjpw/hXHhlKOS5ZZul14SxFkh+mKseYxIl6UpBW2UPq97uvlTk+PcSy31zLWyT+tdrgfIfeOtx9Rq9RWjRjSTsiag75xbe7ThIifTBuhtPltJgd9g59fsqsTgtor0oA7qz9LWo+Wrhsi1vGAhaK1i93by7pOBn2/HQ8kWXZJjLCSUM/EDP5jiA8RXyCNJTF2MGI95TZQDwK114J5MV69yhDkxeJda1esIFL5Jn3/gHSOhe7kIDeUOfXuKi+mwIe3MJtcZYAvnoyjxwaQolWZ9iZ6qJZN+CAkRzBpu1PgSijJxtd5FU33H91xhMbSXmV23woEQazBtEYFttSCr0ZUzv8n3o3rABVyjsvzBYCoW2Jtic5RyDLkHpeFaT8+ug7QbWyBC69XF36VMtgGJ9+jeMX6fyhk6rPtuxuST/kYklTuGFGsH/zl2LHt/qS63xR3BeZ+lA5DNXWIYYIAoP95vnEKbEy4AXW9KUFfKEZpWXejWn5To/73ZnmvMNMmyHUBNtjOhZg47dV48vigDqEaRwjJjhH3QXazvuq+KeCdjnlx+iZ/KKP1ST6MTUi/BQ+BIvL/99j7VSdpRtIjkY/f9hFxcbCMfXrQrle3oRkv0BTdlEh+c71VfllafuiSw3RViRrBn4RIKjVshMwSs7XCTA4iFzJmbImJ00zvAwSnTkhKslGUyKNz8O5ylBN4XDhIdPbtWJ18uc39KYT4s5Y8NqPp1kpMHY218L23bXnthpy53N3L1mzZgxUxxuiRhRR9PZpOPerYepE1qajE+CpNBCWnhVduIGlN7gJpwyG7lNiHuTkaIlgu0zanYIPUdtRSDz5Maj4L9QFLodTokJFwEbXRzH/e80c6ZS9hUnQ8bQ1A9t2wy7UtG8FS5wWHqxR5nodg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(40470700004)(46966006)(36840700001)(5660300002)(8936002)(36860700001)(4744005)(86362001)(83380400001)(8676002)(110136005)(70206006)(70586007)(2906002)(40480700001)(40460700003)(82310400005)(36756003)(4326008)(316002)(41300700001)(356005)(107886003)(6666004)(186003)(1076003)(2616005)(7696005)(478600001)(81166007)(82740400003)(426003)(336012)(47076005)(26005)(921005)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 10:41:13.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ef6a27-97f1-45ea-fd44-08da6a3c5dfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the compatible string used by GPCDMA controller for Tegra234.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 9dd1476d1849..7e575296df0c 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -23,7 +23,9 @@ properties:
     oneOf:
       - const: nvidia,tegra186-gpcdma
       - items:
-          - const: nvidia,tegra194-gpcdma
+          - enum:
+              - nvidia,tegra234-gpcdma
+              - nvidia,tegra194-gpcdma
           - const: nvidia,tegra186-gpcdma
 
   "#dma-cells":
-- 
2.17.1

