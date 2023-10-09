Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BEF7BD388
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbjJIGfu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345249AbjJIGfr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:35:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459BDA3;
        Sun,  8 Oct 2023 23:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iThqn1Ryue9H2nW3SN1W2WgUf3qrOeFPoKEh2/3nnYmswfxgYmtEuxSPsC/sppyLbV0yGCtjvNu91wIeWQnHfl3zdwliXBWL7RL3pu6RJg/JNewY3RLOdfV4lCEwRh2KakNI2dUvz3BeEKs17c1v2Cih8pM0AAFnH8RT6b+edDPwUlm1eCdeCWFVVGsdRTmanunO0n/Y7B9MTjqdtHHd39DCx2IWl8Gh+T00ibmoqK5NygzNwyYbgCxa0gGH/UWlsHRjAneC6wC1ijdm/EdM8fLcEkOwY7ny2wXxFZx2A05xmhzTlhHMfN78kCOR0IrCdbzfChc1HlIytZgTgGKtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm51URY6puPYW485whAn7GbuN4AXyt1U1JWUBAOqCoo=;
 b=b8kTT/K9FPSQiypR2UC/GwyUVqg3W475PJ6m7hD0eP8j6GReTOlDpyheDLOsF8pI3Hae2fsblUlmvbvRv/QHux+eD9FGoSyHvfjobu1nXDxfkVfJ4TE1Y5Gg/UJXN5fiNB+Fd6peTjGwnbbZd0XtZICKXh2+bDJ40qUSvDk6rB3QGpQqD/CfC8iFc0b74p4X8vS9ifoJWgNy8erHRHtie5yLrRGw1VF7rugaG34NdKQuw99JA2QKReVu52NECBz6d+aijPsTAitmJiS+VhCpun6wPD8T4QEKec7WL//MjT3bSNN0Ek31lidwmp+A4p/QjMprEF/AngY2g6FysaPq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm51URY6puPYW485whAn7GbuN4AXyt1U1JWUBAOqCoo=;
 b=N/IQv85De6LBQuzVAlpZmJ9qJyVUJxPeT0HKeZ23qHmfyBWz/Df8lwQl3sm11GHkuYPW75C3iCeVO1c+9Ygdd9hgoo5OwqhBJhSP8vs8O+zpdYJxJZIUVhVYumVZbYvBTsfTsMCY+fbLKa2CV0Z9OYSrhNur3xGntkDK1wSJXL6hOsPtPpGdTiRPA6h9VRHpKej9cHO+L2nhwe6kuCIMBvqrR6eIdsricAM/TPIFR+YSs+2MT973/siWi/oZapCKWUINy+iEhr8V/gvsDnPiS6HIpdCskWjvW9D/E7I18z+gcVWS05wXRnn4/aTjdz/4+Kbv0Uk7+yiTClLxAwH4sw==
Received: from BL1PR13CA0194.namprd13.prod.outlook.com (2603:10b6:208:2be::19)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 06:35:43 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::f6) by BL1PR13CA0194.outlook.office365.com
 (2603:10b6:208:2be::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 06:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21 via Frontend Transport; Mon, 9 Oct 2023 06:35:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 8 Oct 2023
 23:35:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 8 Oct 2023 23:35:30 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 8 Oct 2023 23:35:27 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH V1 1/2] dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
Date:   Mon, 9 Oct 2023 12:05:08 +0530
Message-ID: <20231009063509.2269-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231009063509.2269-1-mkumard@nvidia.com>
References: <20231009063509.2269-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|BN9PR12MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: ab800c0d-4aa4-467f-f576-08dbc891f68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmJg28EzfZeKG7isIKlpI35qOFyIYAfJZxT/G0rb6HQ7F6b8N85WV9kcBESbY3lYqETPx1K3RUsv77oyjgrsuVrz3IVnNma1+qZMjdiLuL6/9gS2M6R+1vn4lfZSCw0gQznOVyH/nZgi1CXr0gDFzqYbUvTnlwks0ayyj0NKaxMDNrRGPGpy1bo5DZZhbQn1acfebPkQMx0JD8XYZ+LuZwFnrEJwXXGioG//Y1nyeZ3Hzc6z7aFaNL27KadQZLchMplIBMI7Y+X4okugcaDLqWlF6dBm8RjVMiOkKdEXBigk5RUIQ0h8GKOQ/fL2nhlyR3MfRn85uDpTqSL3B/gRKdhEAEQ2c96SIw0BNLFwdfBXgE10F3/fgRiylMIa7UhwLjpGmIMj939psmYK6yosfC9wp0m9Oi+fAYQ1tuxYCr2tvsPF16cuF0bCa8bbqtRt0s5mtCmMLdZKdkMG78ZXe12pXxhqq3JVhpDcA98m2OwPbZb0Rb+PhFLaz0s/SAxaqLfrIL/dvidmx2mx+DmoRF3kJU371ofwDopsj5o3WsazX1AxTJnxGpNR0xx4i/j0bLqt/K5bH/SYUy1zTf+8V8Lxk04fuBaS/H3QvJ9Dq1Ui7zqfYAwMlOZt767vbcFJg8liftINaxLJpn6lb/xFGOnOWex3giqgdmQyM3560bqOgSEzL2qyywaJyR23AJADDPghmjDSGHcrpd6a3Pknb/ISMg9ck76MUar3PrIh7/6s8joOe1nbpgF8oVYE9Nrf
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(107886003)(1076003)(2616005)(336012)(426003)(26005)(47076005)(36860700001)(110136005)(70206006)(70586007)(316002)(54906003)(8936002)(8676002)(4326008)(5660300002)(41300700001)(7696005)(6666004)(2906002)(4744005)(82740400003)(478600001)(36756003)(356005)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:35:43.3140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab800c0d-4aa4-467f-f576-08dbc891f68a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

- Add dma-channel-mask binding doc support to nvidia,tegra210-adma
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

