Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4688561098F
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 07:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJ1FJ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 01:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ1FJz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 01:09:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9A1AF20;
        Thu, 27 Oct 2022 22:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAdWWzgSeu8dkv4lj4gH4Tenn7rdhbzoecOC61APElfd7H7XdtQgFM7jyhdO0c9ybZWrHjr5JUX4L7DoRpiDmnntV8zSD39KcwsdtEI157M99Nu5tONHX5FstQQdiWp4a+XBqF4U434Gp83ePsacU6uFoDv1M/Rcsw5eA6yE3NXd9DCLW0uWyw6mXTdBJXEYb8+rOUtvRCzCEkowGqjZ01Y8T4C6FTkrderPguw8COh3CPUWGEIeJA0j4fkFeqtzfCFRlv5mGQmbjy8UVljjTkj4b7x3om3v7I+kyKHidHR+9wXd6KKkkW6322rgRiE7sQNsEDbmwlUh+/geWzx+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJzvglSfJEJAzwsAZPJu2B/6BV+s/PR8ZBrGTcCnbjo=;
 b=Q9bk14hgm0WI+tKRr1ZTjUf9Vj/QKYLtE+j4l9NgULSaBI9/zBSABMd9LCPhjtR6QeOdy2rDh3ZzeDn6rNoMq5gftQrka7VPYzq2FZjCB/A7fueFD4j9S5qxOJD8NqLx3H3TJxAtjENEWbFvoGI3QHAr8f/Z2CqWOZ1EDE7naG+SzYC8vO8lKg1ewXlITETHVuFe1hjgiJzvU7CUOkje2HXpGwOIEG4rpnuDxewDimCT5ZFwilW+6cW9lofdNyvNXrAxzedpfJr4/pwiSpnA/62pLFmer1WjmACSSPCXgFcJvpy0AnTfCOlGu6EiaPkIKctuKip77suqY6LZ9fDjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJzvglSfJEJAzwsAZPJu2B/6BV+s/PR8ZBrGTcCnbjo=;
 b=pfOg75RTzHPD+oISXCjMtpIjihNTvtQyilg4ddXwEZW95VQp2kgyj//zgcvPlOArrHJakcbQMXm97uaAqQ+y7Ec+TAF/UNXnpM67s44fsLZcLHCsi7D8UlVkT9bGyhH+QKYRgsQUQGfHfq2Ve00C5rf+shOeXLHbDucRgrc57ro=
Received: from MN2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:208:23b::7)
 by BL0PR12MB4945.namprd12.prod.outlook.com (2603:10b6:208:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 05:09:50 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::ef) by MN2PR11CA0002.outlook.office365.com
 (2603:10b6:208:23b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 05:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 28 Oct 2022 05:09:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 00:09:49 -0500
Received: from xhdpranavis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 28 Oct 2022 00:09:45 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@amd.com>
Subject: [PATCH 1/5] dt-bindings: dmaengine: xilinx_dma: Add xlnx,axistream-connected property
Date:   Thu, 27 Oct 2022 23:09:36 -0600
Message-ID: <20221028050940.27888-2-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221028050940.27888-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|BL0PR12MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: e64f3747-8d9e-4b0d-66c4-08dab8a2a424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ILiC85Fejt13Lsx24e47+4yNldAqhZbh2sBHpU8xnBnUe9CFVTC0ECPLQTj0brU/hRBV4Cx3D4qYHEMtUhnbzTBthSoAQ3X9l3g99Uz7IQo1jmbzW1hk0vCtJeEe92pa3N7wFGoRqDlCJjuVNzK07rnE1fnMUpEW0pM6t/pDy2FZHRAv1N9LeYmfIaPNaAwr2vrUX2VRIAki7E+j3KO/sas9qGYT9C4LNABAAMp3bVu4LHHQy1a/0+qt+wBYwT2TBcfu6aODWWGOwKvH6rDHKx1X7SRbZRhYDBl/DiTbyBjVXCUeD4eOPbYKnlXJe5BiRpDPaMURHQgPBz7BoNTELTZ+cMxh9+thm8Fid6WcVvt5aAHZD+kUFvt12kZ6/Q2nmPw18J3ckIN/JyUo/2UfGs4Xb0/Yrud5IsGc95y9OIVntlGwu+R+vYjjFlFoL4L5gIytYDaFDgdce3G9XgHA9Vm3D86NJAWLJVAjhLDXS5p0I4smXor3gpr7bGdGhmX7dDt1Mc8N471p2DP/OWQ8MmSkheIzq9tmE5I5XdR2RKkhJAFFeHkPiXFexjdv3/QVuhhKJ9eoMvaWpz/gdq7WTtsDRLZbt8sv8JVEPj3VblGrJbfCkhyz/bCV1c8chtCEa18nSiRsWh1hIRBeOhkeDj+pMHDNSwZjiuPVoIr/YHwYYoyfVmxRreR2o8G1aRQ0nj7vee0nFxojyP286tdUP49adDpuUh8QQidkIxKxGQdUbXrOL3lfCOwc+WXQETjRsfzzoyv6qobQtw9Qpe1JCtMCIsCG0tUCvAXVMIQJbsns/aVBgdwVXWPWEPH8wUa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(82740400003)(36860700001)(2906002)(5660300002)(356005)(40460700003)(47076005)(426003)(103116003)(86362001)(81166007)(336012)(2616005)(186003)(26005)(1076003)(6666004)(478600001)(316002)(54906003)(110136005)(41300700001)(8936002)(70206006)(4326008)(8676002)(70586007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 05:09:50.3314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64f3747-8d9e-4b0d-66c4-08dab8a2a424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4945
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

Add an optional DMA property 'xlnx,axistream-connected'. This can be
specified to indicate that DMA is connected to a streaming IP in the
hardware design and dma driver needs to do some additional handling
i.e pass metadata and perform streaming IP specific configuration.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index d1700a5c36bf..18445aa092ab 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -49,6 +49,8 @@ Optional properties for AXI DMA and MCDMA:
 	register as configured in h/w. Takes values {8...26}. If the property
 	is missing or invalid then the default value 23 is used. This is the
 	maximum value that is supported by all IP versions.
+- xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
+
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
2.25.1

