Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADFF1BCE48
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 23:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgD1VOR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 17:14:17 -0400
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:6721
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbgD1VOQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Apr 2020 17:14:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTtBXRGtw6wB44IkzZwlHse3MDOh6xOW7kZQoN87GKLxZG2aCUdktfErIt8OAe3prZJZSvka5cfbINcU6UPfHthzuC9me4pQvB7lWsQ0p/KzuTWkmQFuAxH4tHyqghELuPg7M+PlX8L+SXhbhIUR1WjqPN+2Jvqlh4OTYqH6fBBMZ27MajA7gWIkSRio+M4apiWwnjVMQ0U1Rx2XtJ1qLfWxTmE5O+EbxZMXDFmWcn2cASIeJ1N+f/7+/cTYs/v3zN05LjqVJNL2uSouaopDqps4fmIaBT7pLdCEnhuR6ygVIw8CS32mUQaq5xSJcOT2Bw6Liyn7Xcem9x9EaPtavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8JRHBLnCrTe0yoD3p7g3tQHmQu6ep73fVpa8sdCEqk=;
 b=kcTynlgw/Tvm5SgzxAegCdH3MYxjrtujCSFEULg3BaP/TJKot+G0ZnOtv+zdCj/qMFFYuwcZ/tcWv8MJA5uPFs3zrPv5moH7hsfRYJbJN0MZkFt+Zj8Vpi0xAO36mXEzwbNTdxclYZozytpvbIAxZ/fkG3ag/UytyTY8hmGpRdOPU6WCFliIYCAgm+/GibdZb8t3+0v2xn4RieIXyP9kW/OSW0l1Wj0jNu71F+bRI1TTFdPaH7zna1PNdVGH+utvROEhwEcszrOIEb8YJNUCzDOPJ7xy/D5GjW3lGkMmCrD9WMZsdG6++NjXvZFkpLBrMctWKXPRWMKa37OFpnK3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8JRHBLnCrTe0yoD3p7g3tQHmQu6ep73fVpa8sdCEqk=;
 b=Hr1YK70duSazGvEgZoeAx2pORj6esAX0Jq+EtoO7cHjGm6ASUoRT/d96gMs3x3u4GJt3CsvWFD0lMwApKakF0u/u3SPBcI6zHlpeARxt09Z8lekV8gHUzBOAXSNVXKT+oeb+mPzbgsUxuvPuI/hjwMmXsNSE+kwW3iTYOvNHCCM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Tue, 28 Apr 2020 21:14:13 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2958.019; Tue, 28 Apr 2020
 21:14:13 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v4 0/3] Add support for AMD PTDMA controller driver
Date:   Tue, 28 Apr 2020 16:13:33 -0500
Message-Id: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::20) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0034.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 21:14:09 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74a30a49-9e76-4d74-ace0-08d7ebb919e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4532:|DM6PR12MB4532:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4532CB05A3FB6CFF1C56A2E7E5AC0@DM6PR12MB4532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(186003)(4326008)(16526019)(6916009)(36756003)(26005)(52116002)(7696005)(2906002)(8936002)(6666004)(5660300002)(66946007)(956004)(66476007)(2616005)(6486002)(966005)(66556008)(478600001)(86362001)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7b5GX7r2EQMyAumVzny1TDTc3wGTjEpvg5N/MTvx48SP5XjuyBG1uE/BkaM7ypul7zDmdRCoJidhC4PppEY6tgoTetQLkYDeJB4CSRUThydrF16Jj0TRXXaLwI+wUwE/CMUeTcc/XjmKvKthAJPyXWKJkm35/c0HBQ2psLyE1ZQIBbScf252o3H/rhLnkB6AVMkUsbRxNGwa/ZW2eru2QrY/czlRRnpYKBGEO9VnOKkDD48DWrhzPVWN9pbXp2dz8uCsSzAsRjP2rbWZ0OiPIWQBxVXsTC4vU+MJewpyYfFLf0ZGCQzaHOEw8TqG4UChV8NcMWveH3TZH+CSax/rbqdl4pPDNBYYx+pVexChKhudo44Mm4yfdx0+89C/Y1TZ1Rd1UWNkKKc98eZjbkBIwztF76jFw2fJP6Aep3gyviVR1DMfKCw/VAa62xv3w05H6BvQ+TgDTVWrTHN+VonCAW/Bc/PyE/gxZ8ZK+JCOpbfa6oRQPl5GZTuybsNtRqioE8cV21w3BHiHTUCfZPrYoA==
X-MS-Exchange-AntiSpam-MessageData: QYCnPxLPpAmOubDIrJXZ2XC7mjc33/9sdNa33ty0KHnCj7O+9cT1D+gQ76GOU3w9J/GnprMWh2s3nKET/AsEfuNIUYTHcH2jPvfxfnTL8nI9dpulFpJg9BR9VGMU04Krjh6wDU6EUPf8ZdG+XjfeuxCQNWbEa/yD8T60OPk/gE6sJ8cNp339L+M0bMWQUE3rtOk4l2h5IxFEChohgzgQy+KUJhp+s3qT4Ob63F6p1L0DDGgcjNo1xSxqF98baVapk5wZML4yAijV6jKEhCrCWZDYhTjWahtuwMJC8ZM8LtZPN67Z4l6v41Gc0/XPTOoFgBf+HvXONuqhyR57vnpOCx9Yrf1kRz/b1W7qAcx2RyWszuQtd5mqfY5FNOg7qvMGjw39MG1hltnZTUy7k6JCBW7Puate2KMEFgiTMOvoIlUIhc+UpJf1pHhKpF/V06jqhPx2nNS7ig7MpqB/1lwFL80rgC+pztfIA/T9g6CuieKdpEVJufmR74ZWs1Ftglo3DMtm47xOtwUZZg1TL19q1bgCx/VIVEokCZLmciw6PmXg13QiPKzv2uL10K3A9mFebFaFTF7/3RLDGxLHivrlGr+dF4gx1XL+w/sxMnfwpUpHrqZj3N7fk7q8cfopW2IGvrCiyoEE/CDHOawpE8sW6U7O/5lZGnwngmMN056xonkIHcPt9xbHxP8lXia14DmNEUAx7PnsLWuRJ3PMrjXvVRxeXI0nWhDxBXMKTBsbI70sji0/Q30TSvBl4vvKEz1nYJ7iXTiZ/vV5j6Z1WSAmeD3pmnbbckSI8dvmuIuktnsSfexmwa72zf4yW7s9eEQ4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a30a49-9e76-4d74-ace0-08d7ebb919e7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 21:14:13.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvKKeVJqqDK0Phj2qa8YmK3g+T9ogHKiCAZakoP702/7wHvLrYzNZHs0assNhkeGPzeD2xcZDPG78uGOGTLvcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
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
 drivers/dma/ptdma/ptdma-debugfs.c   | 237 ++++++++++++++
 drivers/dma/ptdma/ptdma-dev.c       | 460 +++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 597 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 253 +++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 375 ++++++++++++++++++++++
 10 files changed, 1956 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

