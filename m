Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCEA5BDC9F
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 07:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiITFwr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 01:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiITFwZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 01:52:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95CC5C366;
        Mon, 19 Sep 2022 22:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXf3o5eFY51hyed8GAinbTKbSfLLe2Q8MNoHNXACLVPSp81tO77QtTGpI7xJqwNx7CEoF3MySrzzn+rod4WDcjF9bWOL+hsflDOCFFyAm18C12VN+ewvIkH35OCJ68XdgRAcE5f4yZqHWfzFBecbrELIZ3qiD3oh0IIU8bORaDrMX9ljKMFP33YfoaHnwqirgmqetD7kOW3/asqmiNXUQ1SuAoNpkxaGTrP7QfuJ2vGUWEPwqAsb/XsG1FToDTw0gLzA/BKRATkhXBCl8JjZWRmY9gOJGrvwh/ThGA6hEs9aDhPXPq35gjOcxgHgcglAdbCHeOWmplACT+TlQsbfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by1agEk8lfjHamMfPOHjuYzSqx0rNXcSt8vz4Buuj5k=;
 b=n/j4CjwsE9htoF7IB6Rf5Kjs02OYYIahB77apEzJyqScQEym7D11dJf2A/8gQvsVehOKR8+AVI+Sh+zp7bfzEwWNVpqeCBJrpMaR5xMlRjoxyFF0J8KPffCsq91EGLjmouid3jXO3uSIxGjRxZR2wW9KmcXbcc64odTNo7sG1ymkDm203dTNZrOnqtp+8d4qcx6/ldV/h1VrW2qHwNEwKa0lxJRSXHDIoUmSgZT9Dyj8xvKE1aIjro1ow6Zmpw0hwaQDCWdqHQYQ27i2km7G3A//rBm6SwRf74ZTKYLELUS4T2YN9M2koiPL2x8sputcacnnass3/j2pIbKsEhB6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by1agEk8lfjHamMfPOHjuYzSqx0rNXcSt8vz4Buuj5k=;
 b=uuo+CePM9e51+OCR9BuY3UdPp43icgn2G+Wpq+zDzvdaIf+/ET1o03P3Gslrsw3sIjN4HGp6Es/YUpNZXbASDkTQQLWqztdDxptuXPNts0xaWuGnEcW1uxnJxS+KUOEWuWkaOCp2J9J3w/s40NI1SzMCUyq7gdLk0Sfd8zzBmx4=
Received: from DS7PR03CA0160.namprd03.prod.outlook.com (2603:10b6:5:3b2::15)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 05:52:07 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::7a) by DS7PR03CA0160.outlook.office365.com
 (2603:10b6:5:3b2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 05:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:52:07 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:52:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 22:51:55 -0700
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:51:50 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@xilinx.com>, <git@amd.com>
Subject: [RFC V3 PATCH 2/8] dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
Date:   Tue, 20 Sep 2022 11:21:13 +0530
Message-ID: <20220920055119.12634-3-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 615c0844-c905-437b-97c6-08da9acc40a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+W7MgBjzMeAgdfkXrbKa9rHSZwXA8HpuNDC8IgQ0lx4uyQcq6y62svTH4Te096mAP00YyGziJDa6uR4QUgWkRDeH2GgFqCtrqO74KCtj7gM9BHFDRaxccriI92Wgdqd8drWpbVaj63EzXIJe+MoJumnjU4IVosmjPLDAkiJ0SfUEkDL0sO/b0+/TzPRoDOIqPZVwoi24xfvslGYk5sJfFlCgzSYWu/yNqWaxOdpKKGRvtN/lrLSxlaAO5Qx4Wgn57474b5sXsG0ED3NJWsf5Kle+wlU70kMz+Tu9UhQvcWPRRzRerJHAZCDRu7YE4JxKc3Agml6DBzYWE3k6eQGRB83kMSSDchCtwoALHPCCycBqZj8fEarP1MYj1otrWFx8Y8clws5Ewp5Fru855u/KNySRoXZZyulrL80OsWOktNSIh9+DXpAWbQrCeMrMnE1xIf4oZNc9/lCWe+Glai8NExwoVEVmIRQFUNvjAxcEYQUwFtld24ZMpUPvd+HODAjNoVUWg4tapK8Ieo6GewXJYuJzucPTN5UnELzuHBolalSvZeBDGYDyBvYHpXChngEsHobY+J8EuX46GykhFdI30FtnkIWdddK35ow6okrz/mEDTxfYQKdnKw40JM3LECVKq6K8PgU4IwTzzfANolWem2+BgIBKhzj/GeF/Hea4FA5yiA1JUSQLNZ41V9S0wDm7WXFdBFw2UjkOMts4IsvA60lYr5dz4yNb0n+aJ5BvacKA1xqhcqI3qDXzv8Xht9rJv/NMYd3fB0/RV+AqGvFToAoc9v0LOZc64Xeo+uJiR3X7tVfBiVDJsTD9JaI56ls
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(26005)(2616005)(82740400003)(81166007)(478600001)(2906002)(5660300002)(82310400005)(36860700001)(86362001)(36756003)(356005)(103116003)(40460700003)(336012)(1076003)(186003)(40480700001)(6666004)(47076005)(426003)(83380400001)(41300700001)(4326008)(316002)(54906003)(8676002)(110136005)(8936002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:52:07.3681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615c0844-c905-437b-97c6-08da9acc40a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Add an optional AXI DMA property 'xlnx,irq-delay'. It specifies interrupt
timeout value and causes the DMA engine to generate an interrupt after the
delay time period has expired. Timer begins counting at the end of a packet
and resets with receipt of a new packet or a timeout event occurs.

This property is useful when AXI DMA is connected to the streaming IP i.e
axiethernet where inter packet latency is critical while still taking the
benefit of interrupt coalescing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
Changes in V3:
- Add rob acked-by.

Changes in V2:
- New patch. Introduce xlnx,irq-delay property for low latency usecases.
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 18445aa092ab..9793523633a4 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -50,7 +50,9 @@ Optional properties for AXI DMA and MCDMA:
 	is missing or invalid then the default value 23 is used. This is the
 	maximum value that is supported by all IP versions.
 - xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
-
+- xlnx,irq-delay: Tells the interrupt delay timeout value. Valid range is from
+	0-255. Setting this value to zero disables the delay timer interrupt.
+	1 timeout interval = 125 * clock period of SG clock.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
2.25.1

