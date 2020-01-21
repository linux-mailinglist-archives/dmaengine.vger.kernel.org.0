Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E411438FC
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 10:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgAUJFe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 04:05:34 -0500
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:10494
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgAUJFe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 04:05:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WthuX3mO1mPY68rMmm9Is2SuWRHXUdbxmjp2JZ955tNM9QL5LDqULY3ZAD3d2BKBalBGE1jTQGYpMfhAb8Bkx66h5Wl+zcXzNs6OJ0nJf7yEjArZ3w7nZ4jdo9eaVXXrNLJW6IeSoUXrRihYM+X0yK9tsGrom9alK3l6AJwhxAtSIUchTiQpATgF5sdJV734oVH4aZdt6dFpaxjbV6QjcVPHbRwtMe0zYew6PaaCknno9AzKEQLgrzgBnEH9FCDe3AiWSYvm+69EFZALoNYJK3DsAum+SJDjEio/T0pyO1kdghslfgS8wcCLrRKPFiMuwdfx0L9tfVGv/kRmQDXv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deChP9NF5tLKERidR+k0NSvfOmM0q1/HE7fS2MLHRhg=;
 b=Xzr7/iPv50ELpGYdzd2JxOd3DR+g/98vVmG36jjTGu2VLVr9TV4oTB/7j7/3OGuf//RJvVL53F8vgTuQIXmFDcRoWCH7j51kr5TRhvlGUksGD5PLTMU2lzXP/MlHSJPUab5e7zMOostx3C/ZclTjXByMVIbhdBlQ3fTK09aS6aZO/VShXBufWKlYCSeMhzQGRC5fd4DDnCb7gW4pFElOkUhdRw0453z9KG3C1e1E0F3MsJShDWmv6BJ6BCTJdvol16ebhniUJ0Oiqweg0oHF5TDB8n+Ka3OnjyHE9JIv/sWf8m7X3PkmoWs+fAA72TzqEdZ126GYhA8br+MYdXph6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deChP9NF5tLKERidR+k0NSvfOmM0q1/HE7fS2MLHRhg=;
 b=3mEBoGSE6uLN6E7AC5i10X+0kbwQalyw9qNEh6x1g6q6p8pWS9O12NupFotBx0SjqDxAQDrqpAHDrzMIhDDNAgKYyxUSP1IfFBRJdV8sQj+gry23qyE4rt4eApY72eMfUvPWaocGhsKw/O0H3sqx3wtPf2nY8ra6mv1+DCZSFpc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Tue, 21 Jan 2020 09:05:30 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 09:05:30 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com
Cc:     robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 0/3] Add AMD PassThru DMA Engine driver
Date:   Tue, 21 Jan 2020 03:04:51 -0600
Message-Id: <1579597494-60348-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::22) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.18 via Frontend Transport; Tue, 21 Jan 2020 09:05:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 452d6187-dcc3-445e-c8c8-08d79e51108b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:|MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40488BC93D7F551816642529E50D0@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(7696005)(52116002)(6486002)(6666004)(8676002)(81166006)(2906002)(81156014)(8936002)(5660300002)(316002)(186003)(66476007)(66556008)(16526019)(2616005)(26005)(956004)(478600001)(66946007)(36756003)(86362001)(966005)(4326008)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4048;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLNhFE380PrgFdy7McI7I1fJqjf7pmG6YuvX7ddCxaq4UwzBWyWUnMwrmK8khQaizetuiWjccBU9/lqKdiC6T8VKe//idSKeYryLpE6hakgLKF5ccK9PoLow384ivhx31ccFbtZRQ1lcuM6C2KjEeD3D6xWy9k4Qe+KS2seLhGHk/1uI+FDWBrBxUdbYiXK03C5dQ2XfP+pO/G9AqQkjYNCGObaOb59rT2/8YdeXAVe8GYozTMut4kEKzkAOYzCdvpxsWunErN5sKklkg0o1wgkiJdCkyZbZHO7Fbbso+M8+4cNy7VpHcolq+BoOOmhYhNHKDdgqRpv/QV0+7ZlqGpckCzdkKGy4HaOfhnSxOgbmiEO1fJtoczA08XwKzjBpAwuCSZA1FWPQ0mq3Czc7TwEzB+UnUak7jo1XswkM0iVyHjSjAB/epZ54xEj9I/obePiHtwbDw/fM1waEvwQ+EeBjj8nFxhBf6E3Fj057dTcr0PCRcnVWx0JwRd+QxFRr3RDJrFsyjv5OEPSyXLGO1w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452d6187-dcc3-445e-c8c8-08d79e51108b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 09:05:30.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NH/uGkispAgNMjGcdyxzv0EDwKp6q4CyNMzVpsWsSRMD58PEM+yCXJAE5otPp6pDiEdems1QskAkYCTz2Tv2jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

