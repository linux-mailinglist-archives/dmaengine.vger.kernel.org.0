Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185923DD3B6
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 12:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhHBKdb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 06:33:31 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:5888
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233081AbhHBKda (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 06:33:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp9rm41Umt/QKW7FEbiPtK6dNIZ1ntY4HP8vcP6+ft5LNeRTe8kyFyhj1r5I09jMdpCHze2bnt3jdxx1sjBU0VFqwSGhHmRdeOWcPQL6qFMvbw2rLnRrXgnSBgjkFeJubHDAnduFOsH2a99jhYaUNDZMBn5LpQpfsgRfiZre1dXRazC5IR7OEU28f22+AEMU/1DGNAECY4xKN0qds1EZopiEPeWwSYll2JX7nNo0h5ZHByX1sXTQBXAcYEQ78bfBlHuXSHgv5gaqizsob6H4q3veCFuIPiFn21lDR08814KsoM3Ohm0OIZZi3m3G07tLymG0aVPVg3mMUQuMFqaG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwYg6gJtszI+wmSf6Se9+V9g2r6hzo/SOmjqIlasPOQ=;
 b=EbB9PXKRMJyTxWli7+X/b3f7UibeNljbC20eR5cRC1ODDzwrELDgTuMphEhuLlLvmgX0bXJCU5u7Cugy+GLRGVAfS//4w6Eu9aYvNPlzoRpdcGFLe+fR40zvZNtStfEFBokQ0Aq/vQ8zFDQvoUbP7eWp4XvtftljW1TH9yCBVDdyCJxoE7QR1JdV20s2ZwVyBu+j216/XpTarV7n497237mAMfrNFYTwbnpGa8ewCfo5aZ0A0q7G1qh1tyLv8Kl0d2rpsK0GCDTBcST05qzwZYQ1/XqzygY3ZszuIg12Wq2SVH8Q3sT6cVOS2C1LSXmiKovsateuJlf2uWKWayFDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwYg6gJtszI+wmSf6Se9+V9g2r6hzo/SOmjqIlasPOQ=;
 b=1zXthYKYJi4C7Kx7PglGuDIIbnfsds+hspmKYhX6QRkCSietfJK9ovZATtl33tpImoHKpewM3fPQFu4f8mN5t7BslzOIEKC+3AKYcNGRpciAqQOqR1n5V66/JTB4scN/XMYF4tHBwafK0VTm5yfIHrCwa+R0AsTBF6xSWvhpr08=
Received: from BN9PR03CA0842.namprd03.prod.outlook.com (2603:10b6:408:13d::7)
 by DM5PR12MB1676.namprd12.prod.outlook.com (2603:10b6:4:8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.26; Mon, 2 Aug 2021 10:33:18 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::63) by BN9PR03CA0842.outlook.office365.com
 (2603:10b6:408:13d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Mon, 2 Aug 2021 10:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 10:33:18 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 05:33:14 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <Nehal-bakulchandra.Shah@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v11 0/3] Add support for AMD PTDMA controller driver
Date:   Mon, 2 Aug 2021 05:32:52 -0500
Message-ID: <1627900375-80812-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0678ea9e-4dd8-426a-1b40-08d955a0f195
X-MS-TrafficTypeDiagnostic: DM5PR12MB1676:
X-Microsoft-Antispam-PRVS: <DM5PR12MB16766741C43F55DE5420B800E5EF9@DM5PR12MB1676.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSNQIWQGmKdXOVOLhqvZxhETteDdMc5+rOfnwUdfMPC91lgo3WVpuXGBkjZRG3B+X++hv9l/eE2SbUjaX1beuntAz5uCdw2llLcvOmcB5xgD8dGp2W0f9LU/E1p7asWIi0HWctD5CeMzBu7Dy9jw90Tdkm7x6W47erCg4hY0GgpSf5g7FrjHmoKCbF+96ye1KBzwrFXOV+LCLJZYQQvuHqFNKc6c8fny7mH/74AiD8kYigZGqmAcNwCu6qAmEEZQ9DZEXmaCPuFnn0rmM6kOjfFJi5sziAu7yHglFV5rr441ppfnbD9gdNtqrUlX2lLQSGl/A8X7KGd4SLdboYslE3qRnp9r3/LUVH/8xs8xPyXRcjfzLkUfxmtSKtq4b2RF0XvquvfFQdht4YEevWeSq0b4onKb7Qlb5n7HjSdmWacDOF+pACqwwq8WGRjlTl2fTpKstFlyuYdpZ/W1N74WDHCnWUHfSDF/yMw2MCLB+Fqebejmub7kLPyBxzpICXTSmbcNZbazdCrg6tZxvRXWPAN5I9wi2WOomt+BXWneGB414TWLoqdRuLjc0MA0vAkW/7XbwTP7TQeY4moFiuH0Nfke51Z3JUs61sZNDnS4QEQWd5B69PjN/LEOPU4NJxCV/ChrQSPTngCo1lreeOLm8FeOf9qaxhsz/D5od5oLk5CMD9ULLqSMeduMWXGxFolCKnsHR1r7QmQpxz+YjqOjR9q2N9g9/sXARDFcJ54mbf+NQqyz6HEHsnXbopzEkb58BSwRKwpuNYVMkT7xnvU0ZYfghGsquf0A+tpKux1N2F/A5oh46gJP+H/T0xxkrM/uqW7HRV1VXP95wIkzF4SHsFROTKdA3DrZuv/x0+uK2m8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(6916009)(966005)(2616005)(4326008)(316002)(70586007)(36860700001)(7696005)(81166007)(70206006)(54906003)(426003)(83380400001)(5660300002)(2906002)(356005)(86362001)(8676002)(36756003)(336012)(47076005)(82310400003)(6666004)(26005)(8936002)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 10:33:18.5395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0678ea9e-4dd8-426a-1b40-08d955a0f195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1676
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

v11:
	- removed IRQ_NONE from irq handler as suggested by Vinod.
	- removed pt->name parameter and instead used "dev_name" in the
	  code.
	- used register offsets instead of having pointer for each
	  registers as suggested by Vinod.
	- removed few unused variables.

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
 drivers/dma/ptdma/ptdma-dev.c       | 308 ++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 389 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 243 ++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 325 ++++++++++++++++++++++++++++++
 10 files changed, 1407 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

