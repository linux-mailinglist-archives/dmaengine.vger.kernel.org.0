Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B189D7CBED7
	for <lists+dmaengine@lfdr.de>; Tue, 17 Oct 2023 11:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjJQJS4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Oct 2023 05:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjJQJSv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Oct 2023 05:18:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D91F7;
        Tue, 17 Oct 2023 02:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnRaopNyzb+i1erDW9GFCBE3rwVgpRCHmn7vVLpVWZ5kaH6TBeVZRtEMkdHG+hwc+d5PptX2rsaTbCChwAY4VNl+jPW8r/HsUjhIbTPeuYsTXpkHNitr66FjskEBKTHOFR5Qw+gQ01S+L405Hqn/jTpyc+vKJDQ/UDnIJuNsM47Vb9SnKHak2V8+UKRjUMJlPP+EQ1OckOhg8q9ETzsf+muwbgY+iTzw1DqukvCP9JhtB6v4/JYvqEIHEF1VlpJxNmPHoAON4h/YMR9GUM4q0cOjUykUeG1RQIesDKlCk/AHGPPVmevnIizJ7Sc+Bv/qvMHTv/MSB753KbgbNWHGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsCQTL71fZ/IoxTK/AN5plf2R7WmAczs7hKmelKUtEU=;
 b=IBq6E4yEbW5OA0lizzq9nx85EFWtH4u+p7lRJt5jbZOf43H1kXJDnbsGreuKVi/EHTHZwHM+Q03XY2yYC7wqYtQ3/gZIjMfPoRx2+lVvFUTNYRcAPRZaJpfKiVyAWtNnkRmFU/hb6OEOVl9dH4o6hXdLk2RamrMLIIZxbsX4ZoJJV4t+OYA8EGoU3Y5CgoYmVRKY+i9LvqfNHEbG5e1+zg72rieRhND9oRv5lNQnjBTaKiqrSHuDturL0buLGOZ2kihbQT4z2y9IlCP0im0c3yzcPSxVWMpqWfghd33bXXa2vsjqrUHhUESTZZjKAtf5MjbzQB1L6NlhhivB5B14Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsCQTL71fZ/IoxTK/AN5plf2R7WmAczs7hKmelKUtEU=;
 b=q0AQhf4QXKdnQggWmraxRlNmaAjxrojn8SFDy6rEJ1tvb/SBkINvqtB+IZdvebrrwmDPIXT9xQDFWatrNGWWNkVYdfxiqpdOPgsXYYQ+a2Qj7wjKJrWdSr6TNFdyy6t51rpd8dQWCHX25Z/YzeZS00ABGvz4+Za8aHa4L0EXXM1/cs/O9beF6sawgEwjh01PL82OpHSbFm6vGtjAXL7Xp4P7HtFaUyLYwNTNQDOY7I70WJfPYdkGMgSjhYbddeqkk0euRiGQbm4s6I/Sv3fB45j9yuaL4rRtV+baSpjc4WchikF3/EN3ou8XvprHgzJpMiPvSp+harcvPgiV2Ux5pw==
Received: from BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 09:18:46 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::25) by BLAPR03CA0138.outlook.office365.com
 (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 09:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 09:18:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 02:18:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 02:18:41 -0700
Received: from mkumard.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 17 Oct 2023 02:18:38 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH V2 1/2] dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
Date:   Tue, 17 Oct 2023 14:48:15 +0530
Message-ID: <20231017091816.2490-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017091816.2490-1-mkumard@nvidia.com>
References: <20231017091816.2490-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7caef2-bc89-481c-b751-08dbcef210f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZS6XBY8LmFNam4pblMn5qj6XFXcLlDG0w2YfV3uVIWKwJq1nJPVCbc6HIPf3s9z70jAL7JdyptEZJ119QFvKtXU14RC2r31av/pspdKhFMcYLzC79HTvLAwwF1F+JOaj2SpK3/OGYF8zOj49oAeBGXNTHDZHkdqLzkdiVJq1PoSaMmCW723M8A89rfJK6rn+v3PEdn+hVoTHGmSEotnT/CK0yWW1DDVDj9khSUQBxK0PaTdp8ndEkuyUMMw41XlEX3fAQtkN/z2tCRU+n1lRXpKFda0Nj9jCUAasGemBnon16daFuOSS4vpAhsevX+K5y28rNqmGQn7DMDwy3Yx2XT31y+KwKTZlX3CHwcnQPjw47f8rwO/R6OIFBOlRmbMV2vdjxPmzs0U9SK5M53ZoNrnNm0t9/uYAa2aZW4Za0AiE9Umwo0Hd+5w3Znx1akeYXaAmuXbOvZaovdprPQVn1durP0ome4rKDPxVx5XviH9wWqd9xarW3TUyOdF0W6GCmbAITAP91q+TqvPUvaF1R124n27MjP1yVrN7Yely8FWVcPYZyDg9bftFBovlzmOQTo4g8nhoiRwESouW0j366tN+jTQwsjni6ilru9HZsg98i+wYyNkW6zscazhazwVUkL82ZD9o6QMekk5Lt5BtG9cE/lrt8m/nd+2SjEr4no1Sc6EqEpUFI+zATrEEV8bLOlJBuHJ9XAQwzpvKPPiyI5ydvXDMi9uzpiAxjMCh47Ir7d64lxhxNJmkDpi3ID5h
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(426003)(336012)(26005)(7696005)(2616005)(107886003)(1076003)(6666004)(47076005)(40460700003)(36860700001)(478600001)(40480700001)(2906002)(41300700001)(4326008)(36756003)(356005)(7636003)(86362001)(4744005)(82740400003)(8676002)(5660300002)(8936002)(70586007)(70206006)(316002)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 09:18:46.2841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7caef2-bc89-481c-b751-08dbcef210f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channel-mask binding doc support to nvidia,tegra210-adma
to reserve the adma channel usage

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
index 4003dbe94940..877147e95ecc 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -53,6 +53,9 @@ properties:
       ADMA_CHn_CTRL register.
     const: 1
 
+  dma-channel-mask:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.17.1

