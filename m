Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02528FF40
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 09:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404665AbgJPHju (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 03:39:50 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:65121
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404637AbgJPHju (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Oct 2020 03:39:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFgCtkPmnzwCX90r5+uP+iFZMYTPZrqkHnGW7W0oUa39gNq7XT+ifbun209FxeFFLTmpPDovav8F17ch26x+/l45VvARLGTTbRzLw3cUXCjTwn/R19K5NisLE5xd/wcWVl9qGTtanXSBR7NiLMyA6fV5yUth3MrLq5y+DlvjP4D1+q5/mSySjOYCLHPQKm6n2GWe8GZqHK+8E/uD23hRFaiHQC/wvGdhc5tA36z6o3DfIhvvPPDwbhyBU/++OuIoK0bIXRQN/NMcorbvaXSreAQNP5QzorvVc9SBhSNgL3I4akVz2FDlQwHoWfgMNIJZNcP1DdjUzOE5kPtOO23Mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4zjsqoCEhaexNRbx/HOsG8biKAIrdjhkBm4syo1YjI=;
 b=kOJFJe0gCvjKZFsJx1ZJ7q2AmkhGRBN5HvdtdHRwQ+ZPlFt6OX8V/xHvYy42Hfhdew/3t9lPcPxF7JGl1zApIquCUUNi5Uz6Y4vQfcpcbDA3ehAdS5ojniE7GFIvJ8DGG8Q8xf/QM9uL1ob9ZAdJZbtAHWqfT4UOPXv4UDFfjEbHBVz7WrAZv+oz+q8vbzWirPeViOJecj64j0f/yNJvCpbDsT/01LKDXxyX9nxeCkfeMLgECvtpgHTOklJLOzLV3fvXHDgN5dySOJqraiot5ndA/wjtzhzfB6RJdRhvTtsw/CaMH7PWjxiDCLoA69xDm911urlPVfq6l3OmQBIoRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4zjsqoCEhaexNRbx/HOsG8biKAIrdjhkBm4syo1YjI=;
 b=wSLPwUNnqvW016csEdq8NClU22uPlhsjkO3uyEVUI3QqR8JQwtA8ZdqgGm5r9lBwp4PchqFFfyiCEykyEiFZztbWUvoYNQO8Pi/ZOWHmddU1crYxfvvYhvrLUDhy4HLT0wha8FyKxgILlkWg1iihGkFgsRBCPgx5flbJLNpfIdI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 07:39:46 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7%7]) with mapi id 15.20.3477.024; Fri, 16 Oct 2020
 07:39:46 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v7 0/3] Add support for AMD PTDMA controller driver
Date:   Fri, 16 Oct 2020 02:39:04 -0500
Message-Id: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 07:39:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ffaf3c3-ac54-4749-14e0-08d871a6a746
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02121ACEFE2632D66AE294C7E5030@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +u3nJjkKqPAD3kWT16oTkS+gvpoJHxoiR3wJYRk8t6QSQGhDoYKDNk/q+6GHjbFgGSez1p1CfQ/bRHXSWDp6enFwTEikYncVt0dLAtV9DAphyFEUo09YFzJ84coyH7LRllsXBopG/UKOAOl1SSZmT+d867YDv1U1etV3t0FphIKFJi6Zfg2PsaUdo/ncWcal7qHzq615/AJAB7/d4eeyaXqmZqmtlhfpRGh2n+t2fEieFI3XtRg21LqwDW+ds5ZNXYH5LSfNDPhrvYt4ukSIZbdyMOjxu9wPplUpupgAebFWhhWSSUC73SLlVMY4d2l+fosLplfpCHJV8707H48J4PoshVjT7n4r4bD3FGOaOHArsOWzMJv0juaE1gCSWdYI2DdaNb87wvcDSEwWIKCJ5jfrfTEC9qu41x6QnY/2GlXPuQ3fFMd4/3b0sd+RAkBZM0KTARySK4VBQy9Aa/Oc+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(478600001)(4326008)(6916009)(5660300002)(2616005)(956004)(34490700002)(6486002)(86362001)(316002)(7696005)(6666004)(16526019)(186003)(52116002)(26005)(8936002)(8676002)(966005)(66946007)(66556008)(36756003)(2906002)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8nxfA8UwMopAAwCFrhYQJzAgZsv0yku1fZNBFngWrLXE5AHPVpny9zIIxrCI8RdjyvD6jQ1oG/wpHdT12oY82wfjwNv47atSLOToJKlfycxWpIUbQ5w+3UKlm8ygBy7/gSDM5CuPfjnwCnhcAVXf+PkPonYS1XQtOu5NEu7KjxMXP1TeKanASK+HZznoE8IPQgec+bdRkxML9mgbkYD2hK4kuWyTz8bvgyH1V2CycAl8CSalX1iOdxOHW5ohLOLEyeHl2ot0V9f2d/Q86yNJEzbTLdNa0n7RArujr9CY22MKeSQbEtYTIDGEJ4RwI1GFZJYaox5SUvB1/+Qmjbc7HJgMwzc5oKRw3X5sNqfH3PiG+jNznpDwOCa4af0SxDgg4G7v7jTRaUOs7DjfHcnyFmwtAXsJf7j7X2cbinOwTJdOfyFOiq8F051vbTPF7+JAJ9ArNnRwn0qep2s+cCoAFKT+SdGQTpj8OxkorycBFQGIgvxgyuM+cdj3DVuZFmDWyXqs/ALGnd4gVf0bL+fTbmHyUwQO0UH2t2ktYT3XfgwTJ4crbl79dM26KySiENkhWpRxN2P+BffE8B5q5zeMeCTg9eSQ5TSsax9q0FCzAmCI1iWRmkx4Pe+MCUziGtOt5WPIT6QwpLnBkbkJBKiOfw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffaf3c3-ac54-4749-14e0-08d871a6a746
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 07:39:46.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96sAjkjz5ZpzXoFN9WwqtLBTw+cXbVsaVHtdEZubQXpiY/OwZXTSL3j8yLBfxlImBqDCCwqUx22lETCm8QL/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This patch series adds support for AMD PTDMA controller which
performs high bandwidth memory-to-memory and IO copy operation,
performs DMA transfer through queue based descriptor management.

AMD Processor has multiple ptdma device instances with each controller
having single queue. The driver also adds support for for multiple PTDMA
instances, each device will get an unique identifier and uniquely
named resources.

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
  dmaengine: ptdma: Add debugfs entries for PTDMA information

 MAINTAINERS                         |   6 +
 drivers/dma/Kconfig                 |   2 +
 drivers/dma/Makefile                |   1 +
 drivers/dma/ptdma/Kconfig           |  13 +
 drivers/dma/ptdma/Makefile          |  10 +
 drivers/dma/ptdma/ptdma-debugfs.c   | 115 ++++++++
 drivers/dma/ptdma/ptdma-dev.c       | 333 ++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 554 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 252 ++++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 352 +++++++++++++++++++++++
 10 files changed, 1638 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

