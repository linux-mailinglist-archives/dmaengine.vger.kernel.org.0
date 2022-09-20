Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1115BDC9C
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 07:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiITFwA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 01:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITFv6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 01:51:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3B5AC68;
        Mon, 19 Sep 2022 22:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7PZ1Oawcxuoou+FmO0EiFwYYOtMAYlgFugw2cFD3ENO9l/USDA41OUHVg9elzxNJ2+1h/DCyGn3LjGy9iTLFaFOvdHjZ6wFnlrdSdt+lUYWdyOy62BqT/u1h62XoXZ5MQ/WFByMLzr+py9waORDsxDHMGkVBi/tVHQV3LKMXYPwuIU8uVH+Hg8nhLx2F6vTHrXFqsJuGrkiAn4Lmdw4Ci/Shu/MKfRwJ0UUdtTBk0odGOSi7uaqRMlND1y++0fjzLFzs5ucdasTdvAvkc0c5EPDVB42NjU3R1YiQ6Fku5nZ9gqBCY9Gg9SE61NQODeHseaeCY/cti/ptrZ8+dhzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80GXYjiKOseHTX6Hxl7idTbFp4NgLAPmI9B5hy+1E5w=;
 b=UEkf/XTe5t4o8jWbxOBh1V1DS4SxH931BwFVq3euh8Bx9f2u5u0T31Vhf4/EkeQHfFj+GdVk3QRLJBAPPX14P4hOXwspT2kFkcAzcWov3uBnxid8hxorMPzQ+U4xNGd4k80uUkpt0KCLalH7WXKri/OkU4KZ/uhgZDcxtxY+qFQvYRF/0nQaO4OPjncrJA6mGptI7FruXxg5Ph71DONihvhftnYAVfvLql2E9W5U+WQHpToqQZP5B0ou2vfE4o7t4qwAmBUYwMS782k92pM1DXM16EhyB1t506WWT7khus2rPQlXD/fMIa4gEEtcSZhU3RTRB3voBeyPvekNGIDptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80GXYjiKOseHTX6Hxl7idTbFp4NgLAPmI9B5hy+1E5w=;
 b=HLCemPUqSBBhPP89e+x+yEy/RdA+GjqS7DDJ/Tbga5lOerrEKMV+B/P1BiCPTEHDqLEttKL0GG4xuum0GYj1RMmNBQrM65x6iBoRfr6W4UiffEzYEsjbWxUWljQmEAf/dVVRRPAhcYRDrBMTucK0T+FQ/PHqJx+DsVHO7zzEa+c=
Received: from MW2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:907:1::19)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 05:51:51 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::ed) by MW2PR16CA0042.outlook.office365.com
 (2603:10b6:907:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 05:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:51:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:51:49 -0500
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:51:44 -0500
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
Subject: [RFC V3 PATCH 1/8] dt-bindings: dmaengine: xilinx_dma: Add xlnx,axistream-connected property
Date:   Tue, 20 Sep 2022 11:21:12 +0530
Message-ID: <20220920055119.12634-2-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: efa68603-1edd-451f-1c12-08da9acc370e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCAA89qshgyT33HETayKdjTUaSgtczHkkkW8Y9TY14D3VZRVdTaMkl1NXTjXIwRj6tIJADqe3Hp6q3GAWrl4ZjRtFV5P++17ZxXHZMvImSUPQBSNtLOiv/mGGQj0WU+3gCvVjH9NlL3ikqPZ97vnXOi0Qs8NEzBmKsjNcROG7OsF/5ySDy9ajZUE6yA+X35d3hpgPfnWKjVvqZQxzdyYLbBA2AQAMWFSVzH6BOleS0bZDj32kdepxxzXZ1cLY8n9cwfFl2/U8GnaWFNPCKNOQtrSpRwPT0ak33UqGkDNv10NcSIoqFJiLAf0nByyZG/dk6xYTHsAlEQsTNMKMYqPRbw39bvQrwMzys2LOuEr4gjL/1Wt1Z6mWiSzdM1Nv/pO1NrKHyW/sC3lJfBaTa9FN7gNQwqmV+2LlcwKrPiv8Pa6uE94fqSQUiKMN3MQGIyF/t68nOYfVovQ7njhI4QbWQcnd1tMU+qvfhuj4nhk69nPubx2yeukX7cRryyCgl541lDjboBHEXb+Tmuku/kPxGQzrgq55pu1Ij6WqyCsMzQmxC0VF/ATHtXmQ6/F8iFf0Rg/gg5ueqCAKxL0G5Q5HRA8as4CC4r7080QAbhhAU5r9XlH2MGPYih/8M2vUzT8fHimxos3pofQAN17cpb9BLcZuXWR88/joFPUjwH5X9mfhMXD+H+7qA8VEgGjd7dqpovJ/QDQMMAINavagvURX9sRIdaVOlBG3U/avFMoTPUOCnLq4k+17QerkWfJiFredec78ViaE/AeVcQyEaEuH9+rB4kwN1HFLkTxo1JP4mwZBhdR5lzKSsDlg4jh0633
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(40480700001)(81166007)(103116003)(86362001)(110136005)(8676002)(40460700003)(82740400003)(41300700001)(4326008)(70206006)(82310400005)(54906003)(70586007)(316002)(2906002)(356005)(8936002)(5660300002)(47076005)(1076003)(2616005)(478600001)(426003)(336012)(186003)(26005)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:51:51.2149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa68603-1edd-451f-1c12-08da9acc370e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
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
Changes in V3:
- Add Rob acked-by.

Changes in V2:
- Rename xlnx,axieth-connected to xlnx,axistream-connected to
  make it generic.
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

