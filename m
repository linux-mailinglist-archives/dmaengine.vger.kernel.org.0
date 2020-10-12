Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE52D28B39F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbgJLLUH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 07:20:07 -0400
Received: from mail-dm6nam08on2046.outbound.protection.outlook.com ([40.107.102.46]:24993
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387597AbgJLLUH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Oct 2020 07:20:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACpqRtIIfPoIjEeNw8LH7+o3SpL8IAj8L380dphD77Tnzdt9dxhP484dkG0eoD/yZ5VxCSmx6VdHnnw9cC2uONK8gEpKSLot5RRNKV1k9MfxiNDGXYHkCksOINV/yFfFeVR0/llTaWGpK5n59ClY2rHzRIUjHzi8GbUzyZcYhOAB7l4NdW25Lo3SUg4nubgcWpnldX8ZR/m2Elua9rX8AasIlYcMprQZHmvUJLsD9p9mDmYpKKVv0uwjGlQbCmqtRMhD/ZOkum8INLX+SQWomxr0tIlIz4q7kqnJVsuy9jxLuWkysFXGhDI0/rFSTquPtnWE5ysGNsWrk8Wd9uOqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRlfhH3iOHxdXD8HCHt5GFPUXLJVeqngPb/3q4S6Gd4=;
 b=PCSTxd4ZZ2QSYs28GWbnFJKZqZUteiuJQ7KjKneBOGy+p+o8bbyCO/M3OZtx+bFh3R9uj2jt0OdxsC35IPLCmLeRyh3RCiZgkTKcdSz+ONcNzlEqXZ5LvbpmfkmIizGqr9hFxVNSmAvvR4PTXxxz0Hj803MxhS6EqhpCu+Gqs0MIi7MWJImaT/vJFDTppq5C07ov3xKIDCx2pwoZ834M9Pe6CGanHGCalV3bWXFVwLxsK2etoCRbP6PO/sm6JREbyUqqQeD82FVyiw1nSUOt19zzbRQkAEUph9rD9g+jq+NIZ7EdUfz1+GEOy3dIPNfTbbBzF9NvFkJ8a3yjJ3XK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRlfhH3iOHxdXD8HCHt5GFPUXLJVeqngPb/3q4S6Gd4=;
 b=TRRE+rWe9fA2e5lKEl57R0hExxwp5+wYMiSWi9qszbSVQAT7ZlJ4ck2QzslSEg+ZUfj4v+FhnifJMjWAq7GQcOx3verskOcxiewZzuzG9Fi8HrbldD4/4klvh2xy1ugHKCxZ0cS830xzevgvBO/oVJZ4bolZmUAIC6Lht7Qgkn8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Mon, 12 Oct
 2020 11:19:59 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 11:19:59 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v6 0/3] Add support for AMD PTDMA controller driver
Date:   Mon, 12 Oct 2020 06:19:16 -0500
Message-Id: <1602501559-67927-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::33) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MAXPR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 11:19:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3a12bbd-15ab-48f2-61eb-08d86ea0c13d
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2979A5C38F7BEA5F8A85E3B7E5070@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2Pl2yR6gbFpo4XlR8UKOFFxOjvxQaLEM6nYGP9QtqBaDzrpW12neeiHThrmOvij6ilmcp0eZZyU84EC+Bd6Tfxg3iQzxl//dur3lBAdaZi+Yc6f5LO+q1GgPSEnWOed+SkEOa2VbVBeEQbKJmKHYo4RaDPHBYWtE20J+hLOgX52GaBrUQhv5ciIE+YPYtdC07KI/ob7ccusMKi91DJGicDVEcsqmbTD7qHxNw6LbBNZaZXeTTLKwisNHSrC5jra0MAuQ2TaXhHuYbAyUKdaa8G+Opj7+xWQj7xiVEbBPhU0FFK1t+XMzd/aR+Ahw5KM//c5NrHBI/hZTY21QEsqzdA+EPVZOgLabl8qd7Dq4Plz1dW+GWYCgF+qoO0d5rZDn8nde+Enbiic05uWfsMKAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(16526019)(52116002)(186003)(7696005)(26005)(2616005)(316002)(956004)(478600001)(36756003)(966005)(4326008)(6486002)(2906002)(83080400001)(5660300002)(86362001)(6916009)(66476007)(66946007)(66556008)(8936002)(83380400001)(6666004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EOaBoAG6CQq4L4oWfpP4SRiV1HUHMBD0hTOjWEn8WV4362T39uAr9soi9mlz96SEhbOeCdMA8JZGXMZoEPTENBg+luJ9L4qJUDsKMPeLihVp8zePNffh9uksX6vNbge9MLzcD/6mphDEVZVCyK/vvcEZrZCCEdi0I2I53CaJ3oZvK9Yso6nF16RFgnmr3xunQ6Fv6gQcRHb76LFPc0LjQEVbyaqfySo0Di4zCpIb8zL3aAbBRR2Dkj9ZXHkD3LBTzIxh9IHET8Pgc+2K+yU45tK5MSvPizAJlVK1Gtxum2ly8A1fhoZT60bdTjDB4voRSOddyUzL253t2dVthLKZoiuuARQtgGLd0QlnqWCYbylkAshRXU0Wgrbfj2xUJxNr0QDoQVHvN9qqdQ28mL63FQR8GarNBPsklXYiRiFcIaeG6aWMVApuTkEd8IsWTzesqftrvwz0Xinjhttu3omlxzHa9grtDl+gLEwqIH8LC/mfV/ndjbsAkmOB5GpYoAogkoQJ46aqBfDe8GB5UQA26KOxeEuOpDTf9gaPD4m8o5VsySD4TLYI25KaEQeKE9cFDGBq0phFa/dEXHccIt+2UDeRd8zqVms+urzRZIDrPhyr9o2C7TUDZAcaGdZjA480euTnptN1JJWl0u5xvvooow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a12bbd-15ab-48f2-61eb-08d86ea0c13d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 11:19:59.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCjxIXAxncssJhi2sEzbhtJ0ONjlBWpu9TeUUqSrxG0LqpXuOIL1uyVeD/rRDxOuojegM56bTW7m5c+9ygvx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
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
 drivers/dma/ptdma/ptdma-debugfs.c   | 116 ++++++++
 drivers/dma/ptdma/ptdma-dev.c       | 339 ++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 562 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 251 ++++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 358 +++++++++++++++++++++++
 10 files changed, 1658 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

