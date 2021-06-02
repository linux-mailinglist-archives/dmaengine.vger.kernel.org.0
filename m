Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1E39918A
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 19:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFBRYg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 13:24:36 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:59777
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229982AbhFBRYb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 2 Jun 2021 13:24:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl6S5SwKzm0dJii5d3u0WQvDFxin31fC4djDLsRfQA9gOjOzbUwtuYNUwGNd6yoOInKyWQZUDeHteclNhqcE83+hTJAiCVC287TFbEJC1ST3piRgRi/Z9wCFgHUQtYw+x2ByofnoXtgVJEkNM6S8fes2osLQOO/V2tITALYcBSVg0UbUHA+wbTZDOR1H2h7g7xNkkL6dQKI/O/hJTRaWPKGIT50boYjzQNlNbdc6Ysef8Kptm4+9ghbBUNoWFKQPvd30MxtcwIyO8lTBfY0+IThdS4WNyP25s904GE2d6pag8KdlfsJljzp7LQQA/cg7CrYT+TVhsK+VfETxUEbIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnKqczGP2hjpyhGidIp1jAkSTxN5qG9HjC715KuvORo=;
 b=ZG6ssGcYbMddk3b5ouRmHTR6bU3IgmGVMVFduD7HElFjr3fHYk1AnNOv1nvIFA6mnAeHVNCe4xjOUONZS41QEQE+1bZypuvFAJoQ1SLJFa1syvGvxwYW/f24t24inlungIH4MRJ4LoWM+/5DyA4UuMWXz1oov7jKDl6W6KcVCYb5OFHmhk/SahDILdJMUmzWnc5BTaevGSask3JbhC/RG3i+SYfRqBHuTLxixSFS/8VMT1msRLl6nh4xr0L6bSmIKmXO/Ot+ME8n3dK1bybcfXBrK9rJkGRNK9JvO/o9InxFvJnb0oXbIS6h3g89L+2N7qwWWE3DITb2EumHdmEH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=amd.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnKqczGP2hjpyhGidIp1jAkSTxN5qG9HjC715KuvORo=;
 b=xAupjHPVBrOSlTwVkK64QdF+c7q1wIKtR/y3Dqs+nnx2ekhQErYbe1OIvgplOGwt6m/G/qqUe3QYGjtwJCAxXS1w5WlAvocghP0+nAnogH8bIM+9Z/3MSXtdfMsD24ZouTGTKPFKJX6z9eC/b5Dcuv1kHtcSg2sdgXbSVUzxNJQ=
Received: from BN6PR1101CA0008.namprd11.prod.outlook.com
 (2603:10b6:405:4a::18) by DM6PR12MB4863.namprd12.prod.outlook.com
 (2603:10b6:5:1b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 17:22:45 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::8c) by BN6PR1101CA0008.outlook.office365.com
 (2603:10b6:405:4a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 17:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 17:22:45 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 2 Jun 2021
 12:22:41 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <Nehal-bakulchandra.Shah@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v9 0/3] Add support for AMD PTDMA controller driver
Date:   Wed, 2 Jun 2021 12:22:28 -0500
Message-ID: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c26b156-a35d-4341-7430-08d925eb096d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4863:
X-Microsoft-Antispam-PRVS: <DM6PR12MB486308B3FFA7E766F0DDCEF7E53D9@DM6PR12MB4863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRMH/Wdr6aJnK2zE8N6XvqK3Yno0UlOLDbAdYlAzGTVoI0l0kdpmcLNewRII65r241ZtG8mZOSsp25GiSby3ZvCvbykcFaq+RzrAGQhfmil3T/jmL02vjpXVN+ar6KeK2FSmS9j1CR+xQlMU7xHrr8x5TAeMPCnibEEBDqyQMtrRC3ly2lwyUUfnNSgDfppF7R1+DfRH2psepBipsj5evb/eJ/GbHRHnWlcRVRLDO/4PGg8l1wEhYeI+4wzH49D61+armazysEBoyvY0n2u/YzvnqrOBV23KNlu0o4rPqucnWZlM0lZpFKcWAVCoKzMrOi56q+t0zl+infYPLtLNEeL9zcgreIl+IXGAC1yCqyt6K/J8Jkf+/BXVscgwcl3fKQKNR6R476jo7kK2GvN6q2ha5KUXOWIg76P1ZiOPaQavK8AIVeZ9E1FxxQha00m9qnhG2kXEIxl6M7IShiByDBwldoE2BVDVN4/V48y83sU5upNOB6ls0mgBNQ5aVRw7KIdDJNuVNBFJQtk7TQr0edTxa0VWObmGQ4bJYj/MZf5dio6bjj3KKA5iJJQTZIeuXVc8DWcxbFBwfaFCQlQAqzxdTE/buWVDLshtAho23oucOPJ5uRZSIQ6qQnN11ftaoSSJMyAd9kRKpKSi5cJ0zVEjcjMN1F+XyGmzn3j9X7Q9LZqGdkTOApOO5KzEElJkVXj6qFqjgXbw8SEV7Ifn0LEACQKLELO5k7BztzFX24Tj50GlupEXjUbk4ye68MBhlmtxy2dafu44d5oG9Vdm5feeavul6Blh1B6eM1zYpDxChTOtYej1jAqQCFvliNhYUM1Rg8Fj6MFI1V0LBP2Pqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(36756003)(2906002)(336012)(316002)(54906003)(5660300002)(83380400001)(70206006)(82310400003)(70586007)(426003)(36860700001)(47076005)(7696005)(16526019)(82740400003)(8676002)(186003)(6916009)(8936002)(966005)(356005)(2616005)(86362001)(478600001)(4326008)(6666004)(26005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 17:22:45.4916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c26b156-a35d-4341-7430-08d925eb096d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This patch series add support for AMD PTDMA controller which
performs high bandwidth memory-to-memory and IO copy operation,
performs DMA transfer through queue based descriptor management.

AMD Processor has multiple ptdma device instances with each controller
having single queue. The driver also adds support for for multiple PTDMA
instances, each device will get an unique identifier and uniquely
named resources.

v9:
	- Modified the help message in Kconfig as per Randy's comment.
	- reverted the split of code for "pt_handle_active_desc" as there
	  was driver hang being observerd after few iterations.

v8:
	- splitted the code into different functions, one to find active desc 
	  and second to	complete and invoke callback.
	- used FIELD_PREP & FIELD_GET instead of union struct bitfields.
	- modified all style fixes as per the comments.

v7:
	- Fixed module warnings reported ( by kernel test robot <lkp@intel.com> ).

v6:
	- Removed debug artifacts and made the suggested cosmetic changes.
	- implemented and used to_pt_chan and to_pt_desc inline functions.
	- Removed src and dst address check as framework does this.
	- Removed devm_kcalloc() usage and used devm_kzalloc() api.
	- Using framework debugfs directory to store dma info.

v5:
	- modified code to submit next tranction in ISR itself and removed the tasklet.
	- implemented .device_synchronize API.
	- converted debugfs code by using DEFINE_SHOW_ATTRIBUTE()
	- using dbg_dev_root for debugfs root directory.
	- removed dma_status from pt_dma_chan
	- removed module parameter cmd_queue_lenght.
	- removed global device list for multiple devics.
	- removed code related to dynamic adding/deleting to device list
	- removed pt_add_device and pt_del_device functions

v4:
	- modified DMA channel and descriptor management using virt-dma layer
	  instead of list based management.
	- return only status of the cookie from pt_tx_status
	- copyright year changed from 2019 to 2020
	- removed dummy code for suspend & resume
	- used bitmask and genmask

v3:
        - Fixed the sparse warnings.

v2:
        - Added controller description in cover letter
        - Removed "default m" from Kconfig
        - Replaced low_address() and high_address() functions with kernel
          API's lower_32_bits & upper_32_bits().
        - Removed the BH handler function pt_core_irq_bh() and instead
          handling transaction in irq handler itself.
        - Moved presetting of command queue registers into new function
          "init_cmdq_regs()"
        - Removed the kernel thread dependency to submit transaction.
        - Increased the hardware command queue size to 32 and adding it
          as a module parameter.
        - Removed backlog command queue handling mechanism.
        - Removed software command queue handling and instead submitting
          transaction command directly to
          hardware command queue.
        - Added tasklet structure variable in "struct pt_device".
          This is used to invoke pt_do_cmd_complete() upon receiving interrupt
          for command completion.
        - pt_core_perform_passthru() function parameters are modified and it is
          now used to submit command directly to hardware from dmaengine framew
        - Removed below structures, enums, macros and functions, as these value
          constants. Making command submission simple,
           - Removed "union pt_function"  and several macros like PT_VERSION,
             PT_BYTESWAP, PT_CMD_* etc..
           - enum pt_passthru_bitwise, enum pt_passthru_byteswap, enum pt_memty
             struct pt_dma_info, struct pt_data, struct pt_mem, struct pt_passt
             struct pt_op,

Links of the review comments for v7:
1. https://lkml.org/lkml/2020/11/18/351
2. https://lkml.org/lkml/2020/11/18/384

Links of the review comments for v5:
1. https://lkml.org/lkml/2020/7/3/154
2. https://lkml.org/lkml/2020/8/25/431
3. https://lkml.org/lkml/2020/7/3/177
4. https://lkml.org/lkml/2020/7/3/186

Links of the review comments for v5:
1. https://lkml.org/lkml/2020/5/4/42
2. https://lkml.org/lkml/2020/5/4/45
3. https://lkml.org/lkml/2020/5/4/38
4. https://lkml.org/lkml/2020/5/26/70

Links of the review comments for v4:
1. https://lkml.org/lkml/2020/1/24/12
2. https://lkml.org/lkml/2020/1/24/17

Links of the review comments for v2:
1https://lkml.org/lkml/2019/12/27/630
2. https://lkml.org/lkml/2020/1/3/23
3. https://lkml.org/lkml/2020/1/3/314
4. https://lkml.org/lkml/2020/1/10/100

Links of the review comments for v1:
1. https://lkml.org/lkml/2019/9/24/490
2. https://lkml.org/lkml/2019/9/24/399
3. https://lkml.org/lkml/2019/9/24/862
4. https://lkml.org/lkml/2019/9/24/122

Sanjay R Mehta (3):
  dmaengine: ptdma: Initial driver for the AMD PTDMA
  dmaengine: ptdma: register PTDMA controller as a DMA resource
  dmaengine: ptdma: Add debugfs entries for PTDMA

 MAINTAINERS                         |   6 +
 drivers/dma/Kconfig                 |   2 +
 drivers/dma/Makefile                |   1 +
 drivers/dma/ptdma/Kconfig           |  13 +
 drivers/dma/ptdma/Makefile          |  10 +
 drivers/dma/ptdma/ptdma-debugfs.c   | 115 +++++++++
 drivers/dma/ptdma/ptdma-dev.c       | 327 +++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 460 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 251 ++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 342 +++++++++++++++++++++++++++
 10 files changed, 1527 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

