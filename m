Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76233EEDD7
	for <lists+dmaengine@lfdr.de>; Tue, 17 Aug 2021 15:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhHQN5V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Aug 2021 09:57:21 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:36961
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235588AbhHQN5U (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Aug 2021 09:57:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFWOwO30J56AsG5W0LaUWRfGF8uMDBUanXUdwYjZWkjt/jvAMqKkhvcqhe18yJlsYcFY1oM/RW+JjP0cZiyS7sxTnfLqXlKigWPmCcmE5OKqcsPBF738jy/3LfJ5DOKzOHc0p9LfN2gEJhTAfTkiPsmhJazq8gu/fP+7kORtY8ylOxsWHoLDmitm6ULNuWg80qQxaUN/DcDoZSCVev4iQOCmda7OGQ0vZwmoseQfACL+O2mWUBqAFdWX6emdzb3+qx0t7zIdaFzSSkkh8fAw9Yio8RlhNXmSMoG31VHH6Injhy/Nmh1qzxSwLo05b5Wj+lTIAp41H8sTA5ftemjMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfQUXbWFXDqfoCbnzMaVzRRabY3oFMjTtW3DCJ5YBWc=;
 b=NadjvfKpsO6Q8dOdayOLQB53MuP/jUGQgKlduMxL7MeMF+SK12ZoXRWopXwd+eogpE8teVBlFl6lBVbQhM913yhbacP4ICQPAYby54KCmJfPsnArPOa6A5ahbQNQfQdk28LqTRfIHGR65g9tOnRQ4vGP6kLp1lgMseCHDGZhV/xFlIr0wlEXFzm4xnCnRp/36Bohuj2TT+XPSQkOzlpUKapMMsgxHtbjbvXHtpQoYic76YwenpkQTabQlx1RJrLggFmuu30w8s5btpVOEHiWjQyAvgEN2iY4X45tQNghJhEPSdGxxxiHxC4wommlwMmF3z8U9tn1gQVUWhOIkzT5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfQUXbWFXDqfoCbnzMaVzRRabY3oFMjTtW3DCJ5YBWc=;
 b=g8Z6TLE12hQscNNWvLpt6m5MGhBzx1DCGXG0XUVf6Ot08xLS59GUsOS//2T867CMmckc1hxiI4xlJ/5zLuRWVBfhCAIFRSHDRZQM5uwl3qPyiOfjbF3N9HW2YTz6Ak9/+5dRRk/HNX337fhI9IUMaYp9cEEoHfCjGUW1fjjzeMM=
Received: from MWHPR21CA0062.namprd21.prod.outlook.com (2603:10b6:300:db::24)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 13:56:45 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::16) by MWHPR21CA0062.outlook.office365.com
 (2603:10b6:300:db::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.1 via Frontend
 Transport; Tue, 17 Aug 2021 13:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 13:56:44 +0000
Received: from sanjuamdntb2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 08:56:40 -0500
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     <vkoul@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dan.j.williams@intel.com>,
        <Thomas.Lendacky@amd.com>, <robh@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v12 0/3] Add support for AMD PTDMA controller driver
Date:   Tue, 17 Aug 2021 08:55:56 -0500
Message-ID: <1629208559-51964-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab30a4c6-82a2-41fb-a384-08d96186d95e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2790B4DAD9436B9D919662AEE5FE9@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +M0+decnuvupmVWZph/+5DRUl/ZsV2w5OSlvQAcn87nTetFNZgbX//FOwP8LaAlJnVGND/ldNnVdb5iHDBQcODmTrI58xUBfpxi9ZeQ9Yu16Xt1fDeor4Ed0RpAJ2UWiPiRdr5IOFlewSlRLd62+R7gGc/ViqRe2hNVme+IaE80/2je8Jp1BTFNtmYqYXMhLH0RM5benmgK5ZdABwb0LgEd7R+UMn1iIqVlRtU885vJTbFKa5RwdLEPPuYmGoM2hideXbpUY7MleQFssnBa9FBfdl8Hmt+BNl5zmYtnisS2O/rPKXr0+YTs7FphUrBcz7+eHpCUQ+5phD7ACQOet+Lc+YyJNHw80gnaugkxOPsgYp9lXhZNLNfEk/m8ziSD7iwvnAgICiccsEgoIiLQFsX/O9qcmusg+Rzf68xEjyHGqs8f5Mr2sdUEVsOjiPD94VUfkMSOnIpdtPfPFfreZ7mR6kv4i25uOr9ohirvAGtFvTesFNkJF8V8mFIoVWb/A9YvOy9dIs3tzOIgBNL0t5O4G8KrILk44wn718XkJ17DP0eHyAUtepH1YG41CNTzu8caz9MF+R3B+Xf2Eklz7OmVPy+1CSqC7SuHE5Xj2jzNxm1AuDCYu9PLK/HMU2dbXmyu0g/sG3X9eaYfe4RqwDL4Ty5XQjpntSnDyyJLQIQHmV9NFKCX+cbV4WOWeRs5Lsx36ZwKr+tYzhAC0LV1b9eo3eWOQP27YcUK9hHazEGo9cZnS77LU8hvbiJtulkv5/qVZ8RWmYGNMGVjmHMe/WS6/l3R3yKZtIXhmKVqj6GngdO07mielhzboj6LOjATlc/Tv7Hmz5QA32GsEoTZdJDktNXVJd/9kKZx2+w+3KoKkhx7wOJCOS/OwEcD2TD0o
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(16526019)(2906002)(316002)(82310400003)(47076005)(26005)(5660300002)(83380400001)(6666004)(81166007)(34020700004)(8676002)(508600001)(36756003)(70206006)(336012)(6916009)(86362001)(426003)(966005)(2616005)(36860700001)(356005)(54906003)(4326008)(8936002)(7696005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 13:56:44.8476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab30a4c6-82a2-41fb-a384-08d96186d95e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
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

v12:
	- fixed issue reported by kernel test robot
	- removed use of name variable and use needed string directly
	  as suggested by Greg KH.

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

Links of the review comments for v11:
1. https://lkml.org/lkml/2021/8/5/431
2. https://lkml.org/lkml/2021/8/2/860

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
 drivers/dma/ptdma/ptdma-debugfs.c   | 106 ++++++++++
 drivers/dma/ptdma/ptdma-dev.c       | 305 ++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 389 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 243 ++++++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 325 ++++++++++++++++++++++++++++++
 10 files changed, 1400 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

