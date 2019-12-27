Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472C512B546
	for <lists+dmaengine@lfdr.de>; Fri, 27 Dec 2019 15:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfL0OrZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 09:47:25 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:6123
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfL0OrZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 09:47:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmC2HiYuz0XWmwxAckOO1MRcNi2keiOpbv2IFD6hJ/kUDVmgZnKp2LGRL4zDLqSDyCkdgK86wTkFm3FI2A8QORhbHsvXMuDoYz5axsqL1rPJSITpRmi+JhzG2w7SUDvDMgtyQDR7mu58jgf8lDml8nZvBLSnsNCbpQFOMUQoWU1IrlI7iVFYnXuHz707WmUTqp1GVH+mV++tz2nmWfHcR3i/lbSFO4+iHAy+ayyGzQuyT/6k4HMfrPnFWSkfobP9hOtrSlX1OH//PFC7YAYcwuitbfC6tbuLqbq01tQdMkEnWAuIORGUcNIH5jHbW9A/g4FFcJKsB6DWgkbqXiFCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evw++GroxqttPVbkuGwlgOybAP6HYAn/3rm5RZZRcvE=;
 b=X9vr9ztrcN7YaRM7Vb/uG1W3ZnmAsA7/DCek85tMhJ/slNWvL5JRpkLuB6ZuKiVVyyLDIqfThxMef8ETFFDtfkdO7lL2KlPSc6aMEYrLbR2O+CKFwEPyx9kj0MIFBvH8BaQnMNoxdYtToaCCoTqj4X3bwncZZCjsaUrfRcdWL0tjVw3THBbCTjjaq4EQamAwJiDLDeQVM8w/sKJ0nVkfIqwfVKM0e0FjS5D3megUcpvPfc6/+Dv/vWFQV1E18eyp1+mqHDRQyxRrLd3d/fBfB3afUW1KsGHNfYvsG+NFAgYpQyodB51zaVW1QCgDWuGYGz3x2506DriJVeSAj5uFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evw++GroxqttPVbkuGwlgOybAP6HYAn/3rm5RZZRcvE=;
 b=c/LeulnSvWysouhgdt+JUlBEIYvHJeFg+FdHiHq/BKEWu3Ue2hAO4wimDHxLgdWNTm9ZDkx462Jv2m3HyX3eLHttdftXce6Wzg+ERG06sZZaYj/b5H88ngwAzd7tn89jGu1YMU+0M5PWFCb5iSZCQL8wUXpVXsl4cXsR1kmUF9E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2SPR01MB0024.namprd12.prod.outlook.com (10.255.232.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Fri, 27 Dec 2019 14:47:18 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 14:47:17 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, Gary.Hook@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 0/3] Add AMD PassThru DMA Engine driver
Date:   Fri, 27 Dec 2019 08:46:28 -0600
Message-Id: <1577457988-109613-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2581.11 via Frontend Transport; Fri, 27 Dec 2019 14:47:14 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d53b184-4920-4e82-1608-08d78adbab7d
X-MS-TrafficTypeDiagnostic: MN2SPR01MB0024:|MN2SPR01MB0024:|MN2SPR01MB0024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2SPR01MB0024B5BCAD3467E35D2811B8E52A0@MN2SPR01MB0024.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0264FEA5C3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(7696005)(52116002)(2616005)(8936002)(6666004)(316002)(186003)(966005)(4326008)(16526019)(81166006)(81156014)(8676002)(956004)(6486002)(26005)(478600001)(6636002)(2906002)(5660300002)(36756003)(66946007)(66556008)(66476007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2SPR01MB0024;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3nti9nOSRHXGhJHMPCkSbxxbSThMPjccu85RlueTR2w0k2bAb8UnddQSZQ3MdDUHaXtzsqpTzluPaIGYjC4a7pnsSNcgH4izOdoROJBGxscuuASdfSCN1oWfx33NlJBC6yok3/6uHP7xRDthvgQ3gjNYMxjmN0ACpwC078Ex+/AmRBysdaQzG0igQbUmE1VtQgCFXYzIX4s3YwLAxrPUIUHY6zsMn0hHoWcUqBVyptzGU51r6Dxr1PztMpta2zMrOFM18VwFXcq/v+CoLYzkHqFoOGeIIM6XcIVH7dALrg7IdovlH4Yg9e9YRDCNXYP7l7q4wyoJoUxgfxS2cmnJSTiDyBXnuJvFE8aMW511MwCSd5glE+OEY3e4YjxVMr/NWVoZlIII8ehGJHrUzzyH2B0axmg829aSEA9tsN1DxRIjuG5wFKsfDsUNvbzicbgpSqk3KqQNkaC6xTjAtu6aaTJQAy/lUSSunc9rgEyJ5A=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d53b184-4920-4e82-1608-08d78adbab7d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2019 14:47:17.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pq0/M/DsJxslF2mF7A4RY7gM+9I/lk5Buzphcx6Jn/OnBU7XsannhDKz9oW2qFr3ICgI88aMzY6PF23POvQokw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2SPR01MB0024
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

This patch series adds support for AMD PassThru DMA Engine which
performs high bandwidth memory-to-memory and IO copy operation and
performs DMA transfer through queue based descriptor management.

AMD Processor has multiple ptdma device instances and each engine has
single queue. The driver also adds support for for multiple PTDMA
instances, each device will get an unique identifier and uniquely
named resources.

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
	  now used to submit command directly to hardware from dmaengine framework.
	- Removed below structures, enums, macros and functions, as these values are
	  constants. Making command submission simple,
	   - Removed "union pt_function"  and several macros like PT_VERSION,
	     PT_BYTESWAP, PT_CMD_* etc..
	   - enum pt_passthru_bitwise, enum pt_passthru_byteswap, enum pt_memtype
	     struct pt_dma_info, struct pt_data, struct pt_mem, struct pt_passthru_op,
	     struct pt_op,
	   - Removed functions -> pt_cmd_queue_thread() pt_run_passthru_cmd(),
	     pt_run_cmd(), pt_dev_init(), pt_dequeue_cmd(), pt_do_cmd_backlog(),
	     pt_enqueue_cmd(),
        - Below functions, stuctures and variables moved from ptdma-ops.c
	   - Moved function pt_alloc_struct() to ptdma-pci.c as its used only there.
	   - Moved "struct pt_tasklet_data" structure to ptdma.h
	   - Moved functions pt_do_cmd_complete(), pt_present(), pt_get_device(),
	     pt_add_device(), pt_del_device(), pt_log_error() and its dependent
	     static variables pt_unit_lock, pt_units, pt_rr_lock, pt_rr, pt_error_codes,
	     pt_ordinal  to ptdma-dev.c as they are used only in that file.


Links of the review comments for v1:

1. https://lkml.org/lkml/2019/9/24/490
2. https://lkml.org/lkml/2019/9/24/399
3. https://lkml.org/lkml/2019/9/24/862
4. https://lkml.org/lkml/2019/9/24/122

Sanjay R Mehta (3):
  dmaengine: ptdma: Initial driver for the AMD PassThru DMA engine
  dmaengine: ptdma: Register pass-through engine as a DMA resource
  dmaengine: ptdma: Add debugfs entries for PTDMA information

 MAINTAINERS                         |   6 +
 drivers/dma/Kconfig                 |   2 +
 drivers/dma/Makefile                |   1 +
 drivers/dma/ptdma/Kconfig           |   7 +
 drivers/dma/ptdma/Makefile          |  12 +
 drivers/dma/ptdma/ptdma-debugfs.c   | 237 ++++++++++++
 drivers/dma/ptdma/ptdma-dev.c       | 448 +++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 704 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 269 ++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 378 +++++++++++++++++++
 10 files changed, 2064 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

