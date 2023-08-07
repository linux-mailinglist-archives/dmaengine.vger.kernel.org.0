Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1F77199C
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHGFw3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjHGFw2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:52:28 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA21708;
        Sun,  6 Aug 2023 22:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfaUW6+0Q7M4aGsBt1sjCbaDvmowAtyQZNevL3ysh3/5E68FVdSdyJSSDYUhtetZJzz2rPNSDAbY863UbyVeHCPyBMfwFxNMS9IHx5gGbVg9dB+5evORRAYO3Q0iUzN2U8kEaa5brWBAZYzBcRRo0xNkgBMwLKT9tKI3RwzoVnmfucEZW7CFaM8QTryy7n3yM6DO3KMS8VF+VdSVCO33KASVr8mauhoWHx379jPKWPZk74tPXRRUvEXxF8ieZ9YhGrAio3/XHCVMibo8t/NxlX5KKvelPZARDKQO12CrDy2+c9eDnbjyNvnKP7YyrbYMm08aB0HMb6MHVDMv9fJRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0B4MvpdrdKeTkVRPn2zNuBFROl2iMhLHaWi6Fx9x80=;
 b=FEcNsWhphxwmfU486nH2CSeta76S8Z84kbA+1+scgNrrVzSOa+J9DtQ6Qo0G0ucuFNzwni1mYUfZmypZ9SnZBTbM2asbDR/SefERgaLmGHBMpIzHjFlHD5IQDF5c8zGN7IgxARBKqBbhwBzWRXgRPBJfDIvOXSZlDuyWEVaPW+8GBYS9zNLhQjbDQ6dYLjF/123I2hiwD3LoskCm32MpA4U0ZfQA6tmuOShQOSpGhN9rzYwvbfOpAMcqUppXcpFHOaQAv9csk8s/XBm3cAFYOWVJAS7IUnyQciE6dCBMv32vDKA9uXQfnDf/1ibYNQC8eyAIfVZuoUvkR/OY5Uqsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0B4MvpdrdKeTkVRPn2zNuBFROl2iMhLHaWi6Fx9x80=;
 b=noQ0+36zfnI35MPbKZL+J6LMjgREvZBQ8kz0TwbDxZbekeVv9cPAx2mdDHvK6jYAmIG3lJHaiE5j+fn2fiN6N0gzTpKN3srmZAK8nsjpm0HE91rGUigx00s1ks250i7PMnfEnoJS1QfanZwkFkHED6BUMyilyCU5XWr5cgJ/wwE=
Received: from BYAPR07CA0035.namprd07.prod.outlook.com (2603:10b6:a02:bc::48)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 05:52:22 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::b1) by BYAPR07CA0035.outlook.office365.com
 (2603:10b6:a02:bc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Mon, 7 Aug 2023 05:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:52:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:52:18 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:52:14 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v5 02/10] dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
Date:   Mon, 7 Aug 2023 11:21:41 +0530
Message-ID: <1691387509-2113129-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 39316a0c-3a24-4e4b-1cc6-08db970a7928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dRl2YB/E+Z7m8owhDvMwkwEU1UzBA2489e8gRj4/9VeMfwghRkAUrO5+hUV1f1/g3XyQLHVAGc6iY3/iEpLagDxA+WZ9RkqQOmnOTQk7T0+lqm+0uq53LXLL3iiQuyNT9RYnZM3Ee52bHdUUrzI+AY0ugavXy2BtinQSFsrkgdGt1JvU16PFsWsczgRIiojjioG8lJzFSs/U6v+HYihCQO9M0S6qOkFoeZYYdS6srKmy5H8yI4oWSTBO8nHhjEKIVXgQu5bLruDT8DUleG8FQYYj8BhBXWRh5MGmeWtTWHHWhFydoSAX7/F5+S7qmsEmOXAxvInpEVvkKYzCkeEUIm3KuU4erZtn+NMjvnuFCV9PYnjYtAIIJZEt26DDChpZZfhvtQJl21P3i/gonle1lydfEVf4yyZd5b8WKv62Ew4Cm4erzsL8cr8kf/0TVPYPyHx4uIs01rw3hw5RzegyckE55nMVOSzf4ovUriQtGlX1W8BA+pp9XAabYWO4vS9rl9BfzwDKXLqk2Z/bWUjZHCvWZ1q2Sw13w4GmV/6cLrOnLf6wiNXxbvCak+x1vT21VHRuk0lOrCJHC5icZnWCV8tuxoGNm87i8YBzG5+Zil1QYTwxPlrbdxk6lJpR42GsNfxvsGqcGkE/Fb+0sZeAhP+mxnT7mqmGjJ82uY4ZeLfanPWPk4o2U0IT379Jp3h0pAUvzoDw5DMeAOG5aFV0Uac0l1cC5c4/grZEyg96eyhhzFTCfzvysdyupNFFGlU3ZUsFzTeGNpVzYLXP8PbmB7cxeDwDO7sk4aOvlGZ4NoHA2Lb8IvT3vqc2een6p/F
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(82310400008)(451199021)(1800799003)(186006)(46966006)(36840700001)(40470700004)(36860700001)(36756003)(86362001)(83380400001)(81166007)(921005)(356005)(82740400003)(40460700003)(40480700001)(6666004)(966005)(26005)(336012)(41300700001)(316002)(70206006)(4326008)(478600001)(110136005)(54906003)(2906002)(5660300002)(426003)(2616005)(47076005)(7416002)(8936002)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:52:23.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39316a0c-3a24-4e4b-1cc6-08db970a7928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add an optional AXI DMA property 'xlnx,irq-delay'. It specifies interrupt
timeout value and causes the DMA engine to generate an interrupt after the
delay time period has expired. Timer begins counting at the end of a packet
and resets with receipt of a new packet or a timeout event occurs.

This property is useful when AXI DMA is connected to the streaming IP i.e
axiethernet where inter packet latency is critical while still taking the
benefit of interrupt coalescing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v5:
- New patch in this series. Just a note that dmaengine series
  was earlier sent as separate series[1] and now it's merged
  with axiethernet series[2].
  [1]: https://lore.kernel.org/all/20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com
  [2]: https://lore.kernel.org/all/20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com
- Switch to amd.com email address.
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index fea5b09a439d..590d1948f202 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -52,7 +52,9 @@ Optional properties for AXI DMA and MCDMA:
 
 Optional properties for AXI DMA:
 - xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
-
+- xlnx,irq-delay: Tells the interrupt delay timeout value. Valid range is from
+	0-255. Setting this value to zero disables the delay timer interrupt.
+	1 timeout interval = 125 * clock period of SG clock.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
2.34.1

