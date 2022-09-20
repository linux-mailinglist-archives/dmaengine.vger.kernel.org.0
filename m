Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5FA5BDC95
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 07:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiITFvv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 01:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITFvt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 01:51:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392953F1C9;
        Mon, 19 Sep 2022 22:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOb7r411Cm/P4cre2yW+GNEbMln1nPOCc3FDqYTNjrJqg26mZFS9xbMusiJeieeRuPABcReTCaleelcN6QlxP5/HyIadc45T2SWaGsQyePSNjVDyyMdpCtKCwwT/AP/X0vlClX9uIKH7xU0ru6YpnjSh4Wlw5dE/oM5XW5q55gFJxHwy96bEjMRD7pYDij0TchcLklL2QROcP/9mupVFWF7JJo58DBjRccw66HArYoEaup1oFbN3D8ubV+0Wdl0C+HbmsHd60J48hWcrdKUr/XgvCU9DOaZLx532/24IXvCJjgslkrLZgbybzgF4KF8UqIC6Ol37iuB34qcDNTI6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+48VxJyTbY9C/h27aLcjhed2YouuHbx81e3g17EOMAM=;
 b=LfH4kAMsbuFhTzRAWAOVuifdLjktU4mj3ChQ2af1aDwRQF/Zt5Q+pTg9bi7/4tWvEtet9wzs0giLPBtuOZR6zGi862Rb+yXk5o+iWeSXwEoT0CdljLi2BHQ7JCD5Ko1pMgVxyCYsrOkBcMzzNqWbTdiee9ehfx4UBkXMAA3dp5uwBt7xUzeeFOS0SnzO0l+9vTQk7iqqd+cUN7Ug0tOJeGukUlvNlJxQVIoKSmYtK8GAQRSXQTD2o8kr4wLNgZdzQl2GYAh9SbvmypunnrKWHxU4SSLd3+C4C5eBf/8DjXnRFxbkrZQGRp2iIMe8NhTFhPnEj00SS3FoCigRHZs1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+48VxJyTbY9C/h27aLcjhed2YouuHbx81e3g17EOMAM=;
 b=t93yQIblyG3MxIn5MPox3dGCOGxUv2lcokm6lcxvqK0tC2Q17sZh6mW/XeKdQo8Hb6zqFhfoZqxUhpXpYCDndj46WMC3IbHYhhe5xYHnPW93ljmx1dI79XMDP/z1LkBboHgfpggLP/6Uh+E6wwlDqOEuTj1X9gKfiX4Tmf8Gd48=
Received: from MW4PR02CA0007.namprd02.prod.outlook.com (2603:10b6:303:16d::33)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 05:51:45 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::b4) by MW4PR02CA0007.outlook.office365.com
 (2603:10b6:303:16d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 05:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:51:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:51:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:51:44 -0500
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:51:21 -0500
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
Subject: [RFC V3 PATCH 0/8] Xilinx DMA enhancements and optimization
Date:   Tue, 20 Sep 2022 11:21:11 +0530
Message-ID: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 495c86b7-0396-4524-9503-08da9acc338b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSkEjjcgPjH0jUZeZG/ouBNB/1p9BmRxCm7I5+6i7MBA2IWcWv+oOewPoQA7hbujflRCdJfzWfXxgwrm9QpifgYQmw+GOSiZxLx2lboMzf2kkex7mUW4oBU5CEq0/JfHhil97Ilb6LBzWA7HgptgjMV+4X/4Xd3wt7IPRtwCmLovuEquqw5qu+gsomoVDX/d11rxYuxmGxcmxJuPFEUEDO3EeZ7XvmX/nJT5BzyVrahBhvQ1SrGZxDJgK0XnB3z2bsvcDsBTQBVXt5bpfOehJqgiHGNa82xlWQLLpD3zs+Y+Z19pdaCIJv4pfLYktgWuvWsUcmSXPDf117tUaiOYbQGYofP53ExZv22HTExQ/kcj0eYl+F9EXjp6JeVUaeQYRpkDjBBvOk1VF3MY/+hToNcxOs7GFVHxTAr0iN0eD8RFvMl+5hJcCKOyxi3SmnxhaafFubhrds2MlFSPi+hgXfuRTYRuUUgH4cA5yeZjibT47YB9dYJkZqgWfd/EsUlnWt/8/fLHEdIxudx0JNuzyWMfT7UQK8FXpAekmN4jE0850c2o525ABOt977ygASBj1dqaXiiU0opat87OXPmkaFWg1pFS8tv69jhRGRRYi3IC/KWJ5zenAHKm/mM3MK9ieGkUzZxbYYyB79Bgs+ZZ/N1B91V/muGiVkWzsY5Sgk8Wn5KOAv0pxlwvQnNKagzJD34X50On+pXVBa/KE0ZjK8gUzQHfpGiMYdEprv3UIe23EH6PceTov6W70f5GMhloZIphIyT/BWR397ukPK9+1D9ZZ5GrIr8W41cbxTX0CAc4N2VQsLYzTRalhMCCSay9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(26005)(82310400005)(103116003)(36756003)(356005)(81166007)(5660300002)(82740400003)(36860700001)(86362001)(186003)(2906002)(426003)(6666004)(47076005)(1076003)(83380400001)(336012)(2616005)(4326008)(40460700003)(41300700001)(478600001)(70586007)(70206006)(110136005)(54906003)(8936002)(8676002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:51:45.3263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495c86b7-0396-4524-9503-08da9acc338b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some background about the patch series: Xilinx Axi Ethernet device driver
(xilinx_axienet_main.c) currently has axi-dma code inside it. The goal is
to refactor axiethernet driver and use existing AXI DMA driver using
DMAEngine API.

This patchset does feature addition and optimization to support axidma
integration with axiethernet network driver. Once axidma version is
accepted mcdma specific changes will be added in followup version.

Changes for V2:
- Use metadata API[1] for passing metadata from dma to netdev client.
- Read irq-delay from DT.
- Remove desc_callback_valid check.
- Addressed RFC v1 comments[2].
- Minor code refactoring.

Changes for V3:
- Add device_config support for passing any dma client data.
- Address RFC v2 comments.
    - remove hardcoding for axidma_tx_segment.
    - Below review comment is in pipeline. We are facing a race issue when
      addressing it. we will fix it in the next version.
      "chan->idle = true; in xilinx_dma_irq_handler() needs to be gated on
       the active_list being empty".

Comments, suggestions are very welcome

Radhey Shyam Pandey (7):
  dt-bindings: dmaengine: xilinx_dma: Add xlnx,axistream-connected
    property
  dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
  dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
  dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
  dmaengine: xilinx_dma: Freeup active list based on descriptor
    completion bit
  dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical
    usecase
  dmaengine: xilinx_dma: Program interrupt delay timeout

Sarath Babu Naidu Gaddam (1):
  dmaengine: xilinx_dma: Add device_config support

 .../bindings/dma/xilinx/xilinx_dma.txt        |   4 +
 drivers/dma/xilinx/xilinx_dma.c               | 107 ++++++++++++++++--
 include/linux/dma/xilinx_dma.h                |  16 +++
 3 files changed, 115 insertions(+), 12 deletions(-)

-- 
2.25.1

