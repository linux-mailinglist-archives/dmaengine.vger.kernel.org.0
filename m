Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6B6F456F
	for <lists+dmaengine@lfdr.de>; Tue,  2 May 2023 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjEBNqs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 May 2023 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjEBNqq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 May 2023 09:46:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EAF65B3;
        Tue,  2 May 2023 06:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsWEH4Iq4xEuGYQzeJP37mUjyJnoON0EvA10FunjoYn3Xe/klQVPGxmFHWcNFfhexEfNuIoKQ5daxmIjuOMDpF9FTQXSIg+Y5K9eFtnRzXRCRoHJRUDs97bqyn0W2hxVhrwCUXuJ9uPEzv1MaLPdf22tlDN3cZWBll+X13o/6RUka7rEOL0RrrIvN0AzOdawLcMcRPJSr3npDVzr7+hswSbaYK19pcXr4c3Gdb0JbStkv+32W9xNkXIQ/jPxc7Vo9lC6cnBI6e0vyoMwiVM3R4HhL4ugaz9OtATcLf288ykINTmSUz7MSWLpamHT3TRQtoxr0RtvE1PLrqp1fKStHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zwj/LxNDO33xH+S9oeBP4uil2GS4+/S4489KR8o5fnY=;
 b=f2jN+1SRJsrxQ0/xMtDfEYnc0vnJJHGbpq3mim8cNXGF5rYu95xOxxvxr2vP6eJncsJjKuicb2tyP8pTUdS4g73bW7Nz6ig8M+t3u5JvbnIRcoiXMOBJH+t9NKX4dPFcZexT460BKFxDcQ9nLMS6l/i+Bhdil9x93Hc43iSC8EiU2qlGLv/Dc9tX+3XioCoGVT/KK2W4t2C36P3029oyD8YYsebzWM68TRv2YqzDGB3fxu6ZLuR6SAGme6tSekWrG4Ws8decvOW+xRHRDBgWP9uN76f1zmNEL0NKsLNjLwIsajpmkoLgEXtYXyz9+JcIlgl/ZDDCFNUtmulpqRzb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zwj/LxNDO33xH+S9oeBP4uil2GS4+/S4489KR8o5fnY=;
 b=YKs6ig39gC77Cy90sYOmhn5RuFHT4V3GVtbYr+D3cyjcEsyrgYUlwjphYbzj3mrtzj4u0+7py5zQn7cupZEn9xhLaPqzyfx6zRRP4wml36qKABqtaRdNVmGgNLkG8tsk+sTi8CDlhcbC4l/WrM3GOHDuDocrP75fj+imw9HpLac=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:46:39 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::91) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30 via Frontend
 Transport; Tue, 2 May 2023 13:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:46:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:46:38 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dt-bindings: dma: xilinx: Add power-domains
Date:   Tue, 2 May 2023 15:46:35 +0200
Message-ID: <a593bbb71df9818cebb4295a1d9ce61e76d48d15.1683035191.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee00f1c-2500-427c-a09e-08db4b13a7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKMd1B7ET52F5inIRwuR1TiOdavWGSL7UYQuznTQ4HG3iPIao6Uo+lHwVT+sL3OhZQ6otMWI6Bs8kaXh7Y2vOaMyTnlB6VbUipJFFAQM2/jeeFVYhbQ3tL+Gx4K/C98tLLG8BMowaz9QjRkmzuVsCphDWSR/KkX9pDE+iRXsSzazXGlnl4SjNRinLq7ZlLOo6IC8XUAe7Kt/USMn/VRpvcdSu9D+JwutjEcyPRPSiqi52dxiESIVsuWAbbtBz0DQBdRR24iaMztS6WC2w45inxJvlIxO1/XGA8djm8LfaS9JQHtr7ljwdYjiAnHPyV0YOsbtSHihAV9155C5ijj48zNj1x83gSHxxpv6jBHMYW26sOk932CAXHYESuhSYdIvogMdFMDUFf9WRgvGT9kZrwZcTdBYTvZskyInbjZrOVx8SmpzN6mPZcHszHXw9ZGxCf3/pxIgeoplc7feVWwfY9U0UVTP7cNt5ynF+HNcrrUYu8OwHtwySPp488hGXf65V9h/f6e1e0NJq4OqY9HVOvJxaP1q9v4GDfQKjWMrmt3fJcDlXb/oU392GYkF/GnzeVGx0UstY2qkuPec5nkirG4u9GY2oYzuL3IUv+43TO+zHVNsaZ++mvnp4Dkax5pbQupX6d6nC/C2AVaZX1U8AKkJQIPRaB60uPTbgGEaeesG/Xz9YmfFv4n4fEum1IO5W9K+ihZo/Wa3MlxgHJgaSiXlIIA2mhZVVOPTAJPmSG6Oh93scCWsW+Kx/98ztrIx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(6666004)(83380400001)(40480700001)(47076005)(2616005)(426003)(336012)(186003)(26005)(16526019)(36860700001)(40460700003)(82310400005)(44832011)(8936002)(7416002)(8676002)(54906003)(478600001)(110136005)(82740400003)(70206006)(86362001)(70586007)(316002)(4326008)(41300700001)(5660300002)(2906002)(4744005)(356005)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:46:39.5778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee00f1c-2500-427c-a09e-08db4b13a7e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Describe optional power-domain property to fix dts_check warnings. The
similar change was done by commit 0aec3958c88f ("dt-bindings: gpio: zynq:
Add power-domains").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
index 825294e3f0e8..f066f6983899 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
@@ -41,6 +41,9 @@ properties:
   clock-names:
     const: axi_clk
 
+  power-domains:
+    maxItems: 1
+
 required:
   - "#dma-cells"
   - compatible
-- 
2.36.1

