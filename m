Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2329343813
	for <lists+dmaengine@lfdr.de>; Mon, 22 Mar 2021 06:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCVFAe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 01:00:34 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:49718
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229728AbhCVE76 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 00:59:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWyYGbD9guoJ16gYL1KZYXnSjanlYLIwTsQsUN7JiOH3rGVQt5hE4Fku+saW1awTRjTBZ+QIEP0Ae58Yyca9E4c1HbCP1th0wo+xiUQCqRtn69nGmrTbuMHuK9CJ4Fb57LLbrzwsCDO4fHxNGUZTPZFx+dUxQXJ2YA7hf+lmihBiDj20HudvwEXeUxH4VgjMkg1mS28RPyLt51h6FDWQ3mqFa/5oevWtIphFMQIhCt70J4+sFVIl//psWN3wPbW6FgEjukFpXGn8aamsOvanrunDUCvVwxegqWlXzLSlxx+ZtmlmFSxJrUi/7FIMnVcyNOFwREMlTvMZ+HLZEtg3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3AJAy0iDCAguQUZWnkPePoQ9170CgtjgTJL/SU5l2o=;
 b=VHfoWrJMNxd+S4GBzX74D2likezttjozpL1panLhtI0gKOlQXfJ/pUDG9tg3jsV1G1IjCgILo+vhB47tytezyoVimZvAQTf+vuzwV9UxNqEIz90KLMj5TbIAZSMiRYxeN+dhkD4TiCh2J223ZyrdwyLTtyRADhbKE41FEKI8zOi8I+NzoIZfe5tCoirEapaLNjozd1o9nVoJCqiMtqhrO+HjgH5XPSX/kGPDCUqqY5VaaG2cz9c88qjbvEurP1ib3YBfa2E6mdwmY24fPvYRXAPDIRjr196WYM09e3I16pid/FTga8IDftucCI7e0UeoptAEpscFRHJE5Sz89Uv+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3AJAy0iDCAguQUZWnkPePoQ9170CgtjgTJL/SU5l2o=;
 b=suKUVOM182Q8K5tXDvW2+T+s+rtIan4OsCwTI2BZyCcgbkhDE/aMLv3reshatGzhUzrN+LWZCIswkHwujUa1Ojc0Ok73tdUZ+MW6RGMWvO0WewvUXsPqPFfXa33uGkOJt2DD5CLl1jeUag9mTuYWBh0kxHz/44RUoM3/lHbxI8I=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com (10.172.121.10) by
 CY4PR1201MB0040.namprd12.prod.outlook.com (10.172.77.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Mon, 22 Mar 2021 04:59:54 +0000
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6]) by CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e974:eaaf:2994:ccb6%4]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 04:59:54 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v8 0/3] Add support for AMD PTDMA controller driver
Date:   Sun, 21 Mar 2021 23:59:29 -0500
Message-Id: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 04:59:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44ed7ddf-1a6a-428a-56f0-08d8ecef54d8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00400DAFA817A68B9EC52EBEE5659@CY4PR1201MB0040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VmbUjHi5Xa84kfGCHmJEZWd+mXh7g50E3UhgRUpc7hNbKvgpTJMG6SaKmhjYoBfV4oUXwgDTWKTMZldcDjW61QGBSJsjdSQryKh5DbL5FlAV0fIeVCCGQiUpakA1LuPaTUBEPtFRyPvg9GEhzgmc5H1KbofXy/n9hBwdbZpxoutrr/Erz8cBZh5Rp9Wued4hn9xnBzYZMu29nfqntRTEPcYn1IHHzD9gjALb4Ox6ml+0HhHd+NRTqAMAzA3qfXuEbb3J6EtLYYkygQealWRcnX31lQewWOtmfgjUfT3podwRn9PMqRIK9IKHEhhidL9nyXr/R84J9BE6KKSXdY6G6JAk58XhNxZwPZuHFLsJ80kma2qqjd/khtLQf/pIBoigfgAd0s2FnzPYgzZs6rSLPtUC8jaybTatcsqskJ0vY8P8nKr0hvpAJIl5yZt5BQsfeXRUZ6LkaYRtUNfZYoj5qV2WhpuQgYWMUwNoCysQTuwp5ma6Vsfhf5wgcTHqzSYOhOrHQdABC+4oQUCV01t7ExYyY95nTgUfqUVoAF9bJg3nuMBQstmUUx611U+/oIrhpvajD2Ac9DWnCQy7Rn7ZyTduV2voiPuz7gNxEGhCHeETbuwDITR8/auBkJVQuUvGVm8/iUWCaNS9o/ejrCfmL2y316CKfRRt81biBDVG9Y70xx1BlRKDGJ8GTT+xMKztdbn58S9woctZyINVXMI82ryXENVvFIPJWbgm3HJhrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(316002)(966005)(186003)(7696005)(26005)(6666004)(4326008)(2616005)(956004)(2906002)(52116002)(86362001)(6916009)(478600001)(36756003)(6486002)(38100700001)(66946007)(16526019)(5660300002)(8676002)(66556008)(8936002)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ilXmdEvr597QyCcmE+85zYxL+B/0611O01Dr2p0ekvJWsBVldv2ilRFW9cOy?=
 =?us-ascii?Q?q7ZkOS5dhuj7XbIDVvFHAhiP4CH1wa1zlzz1/s/oge+eGHveS0JWC6ygIhk2?=
 =?us-ascii?Q?XXaia8uMiqGGSmgD4cRBh4lxTOA0egwb23Yp7hXilajo/QRbb08CQ4lCvlQg?=
 =?us-ascii?Q?XwuHY2KI9gPEcCLnqNJ/md30XlPn20gLa7EedOVTZZol/syLONEUCvcsVqKN?=
 =?us-ascii?Q?u5uNkeyuF4xd+DOZ0nZwL7MtUr0tIdU+wUolPplK4KbORPBI9OZT1Tfjb1De?=
 =?us-ascii?Q?7AyufGjB16RI/yQwNZnY4G+vHDu0nOVP7lW7ng/WHZOuYYgo1rXjcLmxPfny?=
 =?us-ascii?Q?qI4ayCQZYBY30EM8RyQaU7GMJu0eGhhYS9ZOLXCzNJodVAXaD8cAgWaH+aIm?=
 =?us-ascii?Q?3BN0rZSy7skZtzBu3ewzHBre2YBwicoRirwvBvXrzeyI4SXFp9QMQqn5jBlL?=
 =?us-ascii?Q?AcbR69U0f8DWsG4dgm2YEwOrn14Ujg0X6tit0PUnh9psz8MNG1+sa3WotuFB?=
 =?us-ascii?Q?IafxesBS1xhyNDoM5l1cK+1M9x9syYTj/ZjXHMDoXLxXyoOnPmUL+lkQWHF8?=
 =?us-ascii?Q?vOJ+EywROpLuEOCoDjy8P0ZYBR3jybWgw3kRxnd9MU1ZWuQ3rXPqlRuSgCVB?=
 =?us-ascii?Q?PAdD+hF41nBJ3NOEu/uxtRr+CyGaYPbW/k2e8HH6zJLhfox1nVBsPN3ULAi/?=
 =?us-ascii?Q?tQtlrfhzagNAo+gl1udbPWaboPwqXjEfpg8yWx54EefOtQupnrFvJN5PbqrA?=
 =?us-ascii?Q?rjprKGeilvciRPVhKmQdgtSfFRhkD3DFclBja5PMutr26qSi9po9auQzPd0O?=
 =?us-ascii?Q?7zgH7J1X//g5Z2wPuq9+7xyHjpXSlWXaXsjJI24E6O6TCoiM/h/xeC3wwZ7Q?=
 =?us-ascii?Q?MEeUsF4Gcy4coICTLwq2a3nBILPIb2R7/7nd7g+qM+LpkpTH8Iyr2a2OWED2?=
 =?us-ascii?Q?zlZpHlLACRYBtQ7+xeMFNxzEmpXiMHeWAw+E4bE7qKu5PRrXeDgTsG0udvbR?=
 =?us-ascii?Q?F836ym2pZF6XBXchm2+uat+MXdwjC5gdioXvv755jS0edG9lvc8TZaigPQNx?=
 =?us-ascii?Q?Egd31uOUHZC4aST1YTsrwNOBr7eg6qmWWN0DXrc5cH7HaMQ5vNsjCvuBYpz0?=
 =?us-ascii?Q?M2H1eAtex291jED0tQGQYi5a93lFwDkw4J+2LG0c4BiVwbTPE73u9kLsUOPt?=
 =?us-ascii?Q?Cb/jtmVHyV4vixKum+CECDC2i2sY7vh8xT1unzdbsnF8W09+O1RwnfvUFupK?=
 =?us-ascii?Q?Di3yWr97Tvm2hmUmeZH+8J1hjFAsAecUSwbtyJmT1riMoFEfBm2WXXFVrnU9?=
 =?us-ascii?Q?9IXGf0aFpK6G8/FazL5o/xVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ed7ddf-1a6a-428a-56f0-08d8ecef54d8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 04:59:54.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QDBGF6j3orTxk8T5FSjmA82toU4VM9yFE0R2GUrddyDJj6I2zRJrQpJhkKkodLl5unuTOTDVQGNetQaT4mEyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0040
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
 drivers/dma/ptdma/ptdma-dev.c       | 327 ++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-dmaengine.c | 480 ++++++++++++++++++++++++++++++++++++
 drivers/dma/ptdma/ptdma-pci.c       | 251 +++++++++++++++++++
 drivers/dma/ptdma/ptdma.h           | 342 +++++++++++++++++++++++++
 10 files changed, 1547 insertions(+)
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h

-- 
2.7.4

