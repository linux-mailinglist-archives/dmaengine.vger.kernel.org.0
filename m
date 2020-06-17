Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE61FC337
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 03:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFQBLv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 21:11:51 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:48865
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgFQBLv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 21:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ+H12tI/fXqGpwA/y3svkrlhfuiO2nWFNTYTlogP5rSqndgartsmF9SCiqfn+owgz3iCGEKz2DZeNY+ZqEVOWaddzYDPh2kQ0wIcUMSzS03+5cCFSgo6Z1WZE4O+wRcBmtE3jDotxL5rqjbtq+oi4B/PH4KJDbcSPvsXrRlowudLMtsMrPD6vcAnmE9TQLvA/OMNvEfBwChpEwTxJTExJZCe7Cj8CKlEL6IZiKUH5r8JqogFmi3LRj28PdpslDPiZGy/SOqRwuugwTTLDeRsp/oevV9IqlXbybiKjsfZ1NL+CnGLb2hkTu0ds1ReLhefO0v4RrbLtKC5iW6ioADmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLfmOfwlSnv135Yb5xwq7oHdYGqafoaXtHiVT1Z2u2A=;
 b=nlI6KuZlaTqQRHxfn5JcNAenu8N89xXw2DLhrNDP72LKMmdnKCIoBG9FJbDCAHCUF2LTZzYUiVeqi4FDKbFmDwkFd0B3tFPWOa+4ICs3chif5KGfJNSRI9CHq391pBJqLqlO7Ftv5SzEQbEQCIA4kLH/I34A9+sBfhyxOXfP/BC7Q6+ZzI7I6xuvrW1kJHZbqNEy3p4yOqATJMS9J7uB+dSA/fFP+ihlIefteR7YEmOJC2RaYdrhxeHA3B5FrI9trUvgtKAzCUCbKcnw0MiTXhH0Akkh6xtlI0x4b/Ef9LjA3coFWf8sW+4xufNlynH/RiTkK49UQPXGpoE7Db6tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLfmOfwlSnv135Yb5xwq7oHdYGqafoaXtHiVT1Z2u2A=;
 b=OU6bKvE2VuK3e5SOqiDkkkhXCfMVkT+rHT8Scsdg8b67XtRVbcQUhFlW8IKzHU0Fc+jts4maspq7sZfN9Mz6pIloKY6vowIAdp3D2ohXD2wkVPxEHrh8+OpXylYD3MC7hougCR1my58xjrSqbYsmh8Ls0AyoJnK3QsTZiuvylEU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3421.namprd12.prod.outlook.com (2603:10b6:208:cd::24)
 by MN2PR12MB3502.namprd12.prod.outlook.com (2603:10b6:208:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Wed, 17 Jun
 2020 01:11:46 +0000
Received: from MN2PR12MB3421.namprd12.prod.outlook.com
 ([fe80::956f:e98c:37b4:25aa]) by MN2PR12MB3421.namprd12.prod.outlook.com
 ([fe80::956f:e98c:37b4:25aa%7]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 01:11:46 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v5 0/3] Add support for AMD PTDMA controller driver
Date:   Tue, 16 Jun 2020 20:11:25 -0500
Message-Id: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::13) To MN2PR12MB3421.namprd12.prod.outlook.com
 (2603:10b6:208:cd::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 01:11:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cefecd1b-13f1-4127-9897-08d8125b67b3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB350291340C8D312A3B006D20E59A0@MN2PR12MB3502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21SJHYEvJ0RPOOK8CXAewLN5QOAYQ3xwjqsNYsT/R/RFlUzXSUc22hzhkjWZtgdpZ5ig1mQzVlnxode7MjJqvqq4UYby28dhdfvFykJTKH6LrZ/Fit1L41tuNa01qX/ZtN6hUcNKy9lvpG5I66G83g/hyUmvBZS+RKD7ugWLqQ97ofuhIWqgzsQrGFogY0h4mQiQN8b2cXNjz4J7sxeUo+xCI8AqaDsCvp2xG1XB9esAxLWarl90QZppW7doPHyFMCkeecLQGAKBv1pyLa1JSWOJcA5cDoBkW4As02M+UweSSgYAYVzElgEy3fseKiB8zRa8X2GOc07A73Rz+Ko1joxOF8+U8Qq3IohXKj4g2rhAND+U71N1UmU7LJ/v79rk/8FcxI7kfaIb9xD7kPOOwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3421.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(4326008)(36756003)(66476007)(956004)(86362001)(7696005)(52116002)(2906002)(6916009)(2616005)(66556008)(66946007)(6666004)(83380400001)(16526019)(316002)(6486002)(478600001)(8676002)(8936002)(26005)(966005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: D0CvkpSy+6331wfKA0rmmnB8CS2NcYd4EiMfz0jsBCphy1WS60eP18nae7rlG5M7+gcJEuxjgA47qZi5JUelnf60dAtvvVGoMQ6KDBQkMbW6t87GiBwUOc1Q/nkyCQRUL4LdxyIFg36VWwqAF4zeIVmQYODzyLBn7lBuj0hzUurrNvlyO/BvG5XseKWgnx2slS0YdGGM5e9N5M70MPm1/Db8PgfRwQgWQxsm/3Zn7E7dA/56jTgCrf6DMGZmF01mV7HB6nlzLgc8TPc/WWhnsF1ogsSrI3I26ZmPrRFJknpq+hMSHXPyQQtOeYdTzRhWxRiHugBSJ7JrGlW2OxpKD+9az4zK6cbkgJTAe36skofGykuvdvauCNZ2HJMQC9ew5VRoNDX+IIbkmxa579LU5VaNxr7ou1H3rAZ8/qKgLwrz9IeXxiAPSeOTfR6ZkVW0J03VgFgSUF7atUaNPL89OE7aBCaWR06ti4+OhJa8nuD7nRRn4pmoQ14Z+mzm8T1W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefecd1b-13f1-4127-9897-08d8125b67b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 01:11:46.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W18env13rJkhwXelINXLgs/LK400xE+g8vZDUDs8f1GIdFPUArgfh/NuGLzxCAXFTBWy6u/8ZMcrowVezBRyiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3502
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This patch series adds support for AMD PTDMA controller which
performs high bandwidth memory-to-memory and IO copy operation and
performs DMA transfer through queue based descriptor management.

AMD Processor has multiple ptdma device instances and each controller
has single queue. The driver also adds support for for multiple PTDMA
instances, each device will get an unique identifier and uniquely
named resources.

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
1. https://lkml.org/lkml/2020/5/4/42
2. https://lkml.org/lkml/2020/5/4/45
3. https://lkml.org/lkml/2020/5/4/38
4. https://lkml.org/lkml/2020/5/26/70

Links of the review comments for v4:
1. https://lkml.org/lkml/2020/1/24/12
2. https://lkml.org/lkml/2020/1/24/17

Links of the review comments for v2:
1. https://lkml.org/lkml/2019/12/27/630
2. https://lkml.org/lkml/2020/1/3/23
3. https://lkml.org/lkml/2020/1/3/314
4. https://lkml.org/lkml/2020/1/10/100

Links of the review comments for v1:
1. https://lkml.org/lkml/2019/9/24/490
2. https://lkml.org/lkml/2019/9/24/399
3. https://lkml.org/lkml/2019/9/24/862
4. https://lkml.org/lkml/2019/9/24/122

Sanjay R Mehta (3):
  dmaengine: ptdma: Initial driver for the AMD PTDMA controller
  dmaengine: ptdma: register PTDMA controller as a DMA resource
  dmaengine: ptdma: Add debugfs entries for PTDMA information

 MAINTAINERS                         |   6 +
 drivers/dma/Kconfig                 |   2 +
 drivers/dma/Makefile                |   1 +
 drivers/dma/ptdma/Kconfig           |  13 +
 drivers/dma/ptdma/Makefile          |  12 +
 drivers/dma/ptdma/ptdma-debugfs.c   | 130 ++++++++
 drivers/dma/ptdma/ptdma-dev.c       | 347 +++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 600 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 253 +++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 364 ++++++++++++++++++++++
 10 files changed, 1728 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

