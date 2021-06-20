Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD73ADF65
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jun 2021 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhFTQoM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Jun 2021 12:44:12 -0400
Received: from mail-dm6nam08on2040.outbound.protection.outlook.com ([40.107.102.40]:30789
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229600AbhFTQoM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 20 Jun 2021 12:44:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gm4DvrJCXsx2qZK4+fCvTh7Z8X2t6zESiNUAQA1gByFRrNVn3xYnCkkxkQ+RSMqNghQ6JMopZ0fNTRsfSRuYe31DS3ZKeSQoyIr9ukevLvfBQAAmI1KFOq37mx7ZVNP2KXR7S2z33D9uCcsPZOvlupD/YqU3Y5LVrxvk4992bULJJ5bTEdtIrORfmfl9rH1ViBo5UjwIlH98ix/efp0ATowK9zze8UIsL0anc6voIVC6+5Lb+dWsfWshwDrfLFXfKUvegdPcU17FDExKKKgdWSmbx68H77IWpSshY+whH94okWWdKvdl9imKl2vXGzRnbqdo+IYRZv+JmCEupQS0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfz1CiH0Kj1UP7O3jeJaQQvA+ZUopZuDJliDoihd/6U=;
 b=Ur7RPOq5ONBwCyHfIsUMxvzjq4GIq3evZr9iw4attUtWvdV0A645Daj8x5xkI/ikzOxsk2y1OvYCjctKoJaBu9iQER5DP7lZoR8H7zP42lZeFDnIpx/ildeXkXdi6Dx/B32A/3tPkU64DH4ezB7epw4ZcsV3M50dcfPmdTKtygdg8NoiRXit6/CMzmYDn6fT/BwFHh9/Jrn9Lx2/mzNFzNOox1AsmS9Xt2hgpXwOBILygJVJVHV+RepO5SVu07/Fk4QZhYBEv+HLZLtfMPPqUbUIG39b7BN4zg8v/bFlo/l883fHt1QsGbDk7zI2b/hYnXo82N6dnrFv88kLkjdCJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfz1CiH0Kj1UP7O3jeJaQQvA+ZUopZuDJliDoihd/6U=;
 b=zH6hue9JGHnCnfhCdI9+wQWO1ALhrCawwShVCqylwxiY/yGQsAKNBOxv7IyjBDZISKipYkbb+iSI1KlWILfpNrgH3lb4pyMw2gEGP4w02ekVi8qX2em+nBEc36kcFaTsJtp5FwTSiSZr5wWhzfEPXDk7PwCySX1aW4Tev+56N9M=
Received: from BN9PR03CA0382.namprd03.prod.outlook.com (2603:10b6:408:f7::27)
 by DM5PR12MB1643.namprd12.prod.outlook.com (2603:10b6:4:11::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Sun, 20 Jun 2021 16:41:56 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::97) by BN9PR03CA0382.outlook.office365.com
 (2603:10b6:408:f7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Sun, 20 Jun 2021 16:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Sun, 20 Jun 2021 16:41:56 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 20 Jun
 2021 11:41:52 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <Nehal-bakulchandra.Shah@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v10 0/3] Add support for AMD PTDMA controller driver
Date:   Sun, 20 Jun 2021 11:41:35 -0500
Message-ID: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cae5a61-aee5-486f-4580-08d9340a511a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1643:
X-Microsoft-Antispam-PRVS: <DM5PR12MB164302DBB157F892A798D147E50B9@DM5PR12MB1643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJ2p/4FbhfEk9O5LM7GiIST1Y4aGz/5eCsq7p48THLZiWrvdA4v69BNZ7RpCF+hIvNXjFdF8WW/Q2Yag8xOC08zV2F1x+Tt1O5WZrx+DrU+VYmMKeYCTsFHykDgtmUEEE0JBu8OOXKYrhHQb2Pi3DL8ufKq/uPBqXnRgTs9m0cGVgfToFF8Mx4zxQEvLVpWqzUwjQ+N1cKDEP8rNm5any66H15RFhEfhSDXZMTKeVx8Sz2s+/RIYWbb82hHeXEgNt8W/eMhf+K7GSyyKDdGc/qoGvoHluP+qSYutvvWqlDsBqDV2QAvGAhNKmEl72ZY0s+oK18y3yOcvAKMCxJ/9oQdRFJw0DJtPB0IWQsV2Gs64t/zbMPDAnSKJ20m/BaHok2+elL6vvBc6XDCWoEtDBx1O2kSEiAv2rLpdcQ4pKQRsORoV8i7nAyT8AxT8czigMeMST/GxbNHqTtBz89F73YGqZgQ5vvLmx9l7v0BV9zWrdHTRxi7K94LLinTV6MYhcyUr0Owf3s3NDpcamLbbWNXgfJ7L5vVDwWg0DsYxvOui5bjs8Jbzr0A2eqptjg/A7KAF1qP2S++Pm0tJhzMK7i1gH5Xm54/mLd1cRmUMhS1675jb0slnN8hU3FH8mV/WgK0YnNyaOD60dA5LevcpXfvf527QXyo3ZE/DlcwfZ6HWGCO+U/39y0YpOr9+OrulpN6njJ+MmsDgHaUJJpz0GVWR7J/QmSFDbBR3BCOOQsS4j+5nlpRXtHMVRbOIorOiwodd65o1+fKFXAbXJgDTa7+wugB51i13Ldmm5zqpjJQwrdEaKqQaXHgzLQVVsubxpryVYmr5b1Fws1JCtKYfmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(8676002)(478600001)(4326008)(83380400001)(316002)(966005)(47076005)(16526019)(186003)(36756003)(81166007)(2906002)(6666004)(356005)(26005)(82740400003)(8936002)(7696005)(82310400003)(6916009)(70206006)(70586007)(5660300002)(426003)(2616005)(54906003)(86362001)(36860700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 16:41:56.4089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cae5a61-aee5-486f-4580-08d9340a511a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1643
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

v10:
	- modified ISR to return IR_HANDLED only in non-error condition.
	- removed unnecessary prints, variables and made some cosmetic changes.
	- removed pt_ordinal atomic variable and instead using dev_name()
	  for device name.
	- removed the cmdlist dependency and instead using vc.desc_issued list.
	- freeing the desc and list which was missing in the pt_terminate_all()
	  funtion.
	- Added comment for marking PTDMA as DMA_PRIVATE.
	- removed unused pt_debugfs_lock from debufs code.
	- keeping same file permision for all the debug directoris.

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

Links of the review comments for v10:
1. https://lkml.org/lkml/2021/6/8/976
2. https://lkml.org/lkml/2021/6/16/7
3. https://lkml.org/lkml/2021/6/16/65
4. https://lkml.org/lkml/2021/6/16/192
5. https://lkml.org/lkml/2021/6/16/273
6. https://lkml.org/lkml/2021/6/8/1698
7. https://lkml.org/lkml/2021/6/16/8
8. https://lkml.org/lkml/2021/6/9/808

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
 drivers/dma/ptdma/Kconfig           |  13 ++
 drivers/dma/ptdma/Makefile          |  10 +
 drivers/dma/ptdma/ptdma-debugfs.c   | 110 ++++++++++
 drivers/dma/ptdma/ptdma-dev.c       | 327 ++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 389 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 245 +++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 334 +++++++++++++++++++++++++++++++
 10 files changed, 1437 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

