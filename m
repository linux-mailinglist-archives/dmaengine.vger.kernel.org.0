Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A97A2AFF0D
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 06:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKLFnT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 00:43:19 -0500
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:45152
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728055AbgKLFm3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Nov 2020 00:42:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9MongGIS4vM+vhd/r1FAdRvVPLAMV5jmHB6ovgyW2f/XZvqaAEPpKFeOgT/jBN2ZbB5Nji9Lsd54TbxgsX4yvZe90O7S/pjCjPpa8+gph5idc1A6wJGigKN1fmbG3ImTF6DsblzVpCkZ+58RsuOzil5E/qGzirXxaU60FdkCBbvBYnJHq5dkChG/VYWkgJII59Pfc3ixr2brwI+z0LtFSO0wLtpU96MTgdyYgt8KLTHExb7Rd7IZrisKjTR6cAgZ2ap598hPNlvSXDkfCspGD3vqqyuScrvzzgoVF1WnHOBj7GNHO1CtXbWSNHThGJuEy4kA5I/OFJ3UoZbWwSzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r+SO8I1eBJWgkJ4QEr2IXtyl49BFbel1GY1IGpAAxY=;
 b=arZ9M8+zxBhBVI9o5NPBiArxT15gogD4UtZf73YzUSSMZV10DfVK579piaK2X9XNMAqaN3hBJl9SIaIm0Y695BGVBe3RT71DrJaDKSnrTpPKfEx+uMX5ymLNTRrjTYtqujjgjvISXXs7xNYtBYf1P/ezS6f7/l8mc1z0JsTBJHobut/kVTvxzTnVGJKC/wGJa7LHFSeVuuYF+1jypQenBUxUieUyCzGt34RUq8eITGz+ih8dsh06Pbu75Bdawp7A/eK/0eAAza2Xj3baGo1njidkwAPcjsFGaIuG7qyB7K6OlqjA3+w0lHpaVx7kJ/9BHtWqlFQbhmXgnjuzF7vVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r+SO8I1eBJWgkJ4QEr2IXtyl49BFbel1GY1IGpAAxY=;
 b=1RHuzg5TBpRU5nkHy6apPDVLy26eY45xw8P2HthvhsxvgKI2voaUF99s025ok7PnHUHrw5sX8S4uY6JuA0kGdfBcY7zKn7kpJ25UdAOAWd1d0boRPBcgI6n+JkRHX2p5ubLGRif4jJ/HXeE0P9t6EP5+7NUFw/ZgnBetM/LpKLI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
 by BYAPR12MB2757.namprd12.prod.outlook.com (2603:10b6:a03:69::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Thu, 12 Nov
 2020 05:42:24 +0000
Received: from BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::9c0d:9f7b:9600:9c31]) by BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::9c0d:9f7b:9600:9c31%5]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 05:42:24 +0000
Subject: Re: [PATCH v7 0/3] Add support for AMD PTDMA controller driver
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>, vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <d89783d2-6b60-a603-aaa7-3d06cf5ac770@amd.com>
Date:   Thu, 12 Nov 2020 11:12:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
In-Reply-To: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:7400:70:98ca::1]
X-ClientProxiedBy: BM1PR01CA0112.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::28)
 To BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:7400:70:98ca::1] (2406:7400:70:98ca::1) by BM1PR01CA0112.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 05:42:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aac07a22-68d6-44a4-8662-08d886cdbae5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2757:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2757FD4521A5EBEA2566C5B0E5E70@BYAPR12MB2757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rv8eyJPAtFVgZbdLlwEelUoq/3ZkajftFSPY7ST8UATI70eQ2+FRe/iOWn4ovkLC0FmotwAcKiwlZOnme0ingfo59nDPEztJSYEjSpf9s0sJsG6WO27/uoZyrLYvECuxxHty0787rkWR6PDzHpRfTXv0F9dAEikECw95HrVxJTukGin6AW70EQZrLatXQ89bH1OopwbQGdBisT9YUnCDsxv5yvKAvwTPLFEH1SwDinoUwPOKCAWnoO7EiHxVg7ZPv6zr0qYlbjEKUpHlx3eIBTRNQV+pE0gNWCH/EVUlLfptlIwXI2XyiGynp7zaMRt/B6tWVMvAbSCGCq1temRoEDW4Vt8dXmiDj4V522vW/QdhQz+tnk1EkaqKOXKsOsGlsinW7MyTDAOt/ZGNgklkSMz/wNfp2uzpNVjGDrQ+b78iwGsg5pgcop/Yg/QtpDwbgg4f5REYVVz0HkIpk+KQDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3956.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(52116002)(966005)(8936002)(66946007)(478600001)(36756003)(2906002)(53546011)(8676002)(31686004)(2616005)(4326008)(6486002)(5660300002)(31696002)(83380400001)(6666004)(66556008)(66476007)(186003)(16526019)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kvE4JoKKL8aVKVtZru9usUWnUpk0E6POjRgSkDlzhtvTxD+Qef7zqbqsRjvlAD9xYQPvUA2+u+dI9UzR68coQpEkNbz8gNQI066Pvjq0QZ1ho6HRqY23ip/4bJxklXKRq0yKCIBQp/jimaICuGdapKdWk8iqAdbrP+b188+D1K1nskCc8W+3uim9DmQZ4NqcET99pJfaPIZTvcPn5F+U1qLcH2AFKxD4jwruwg0UkEiWtQnLfSKv2W+G0H38yl2A1pjwg7LtzrOZt+fupZ4lQW+yW0vvNKHdM0BMaDsqtdVp5RUj/CJ120s/dK7C9NjSRRCtBrJ4YhJ5QejTOAzba94ztbj5pzlsMGY66VE4GEhIk+lfDN9FvFLl1V5s4qh6ugxl4w4APmkifoqyzLQayiB5+uJUgCNp5RmnAHhW8pPS9/H3M/olwH0c3fDwIFYOFzzaSaRSddhro246dcGdembJ6jtZUBRC3IzITeT6fbQAJ2KAtvnHkmAOIdBP8YqUChayFgM+is9WmPXY0pHGFoAhUX6OxogGrxYBcZ08aJ8mxc8YF0baISyZrGiwOkWLnGa5XrZ/mF+cNXTsShTGGKNwI1p1HJAFgp+LGkOHzpqou4lpfvvhTJ4zDXMmwELPjRCtLf4vUc26dZo9O+tBUhjMO5m9j2dMQEDbNVtVYeoRvkHvzwwIxiHAIwt5z/aSBpJj55OPTo8uRyxhoZtjz3qKWYGKctjQXAPyLwiSlkJrYpMUFNtecPQGRoJ6NsG9tOn/gLkhR+0gqGgA8T32yhy589m0z9r2hmu+lE0GPFz6PAf3R6q5HgrWUJsC+xhgkQJH75JMKqKIt5rI0xcxvoNLWL3nws1qJZAodNDmc7W868vtVdUtsHSQsmRBjG4kFJBSISZxleL3MFIxXYUNA4wF9n4B8l7mF8VUIMIN3kY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac07a22-68d6-44a4-8662-08d886cdbae5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3956.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 05:42:23.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddPKW8ZQM8n0nmvwmbnxdZgnSIsKzawrzxygYaL1RT8LpPguIdSXeraS0Jjr4szGT3ZuuPCCVEKF/Fvwd8CGCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2757
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/16/2020 1:09 PM, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This patch series adds support for AMD PTDMA controller which
> performs high bandwidth memory-to-memory and IO copy operation,
> performs DMA transfer through queue based descriptor management.
> 
> AMD Processor has multiple ptdma device instances with each controller
> having single queue. The driver also adds support for for multiple PTDMA
> instances, each device will get an unique identifier and uniquely
> named resources.
> 
> v7:
> 	- Fixed module warnings reported ( by kernel test robot <lkp@intel.com> ).
> 
> v6:
> 	- Removed debug artifacts and made the suggested cosmetic changes.
> 	- implemented and used to_pt_chan and to_pt_desc inline functions.
> 	- Removed src and dst address check as framework does this.
> 	- Removed devm_kcalloc() usage and used devm_kzalloc() api.
> 	- Using framework debugfs directory to store dma info.
> 
> v5:
> 	- modified code to submit next tranction in ISR itself and removed the tasklet.
> 	- implemented .device_synchronize API.
> 	- converted debugfs code by using DEFINE_SHOW_ATTRIBUTE()
> 	- using dbg_dev_root for debugfs root directory.
> 	- removed dma_status from pt_dma_chan
> 	- removed module parameter cmd_queue_lenght.
> 	- removed global device list for multiple devics.
> 	- removed code related to dynamic adding/deleting to device list
> 	- removed pt_add_device and pt_del_device functions
> 
> v4:
> 	- modified DMA channel and descriptor management using virt-dma layer
> 	  instead of list based management.
> 	- return only status of the cookie from pt_tx_status
> 	- copyright year changed from 2019 to 2020
> 	- removed dummy code for suspend & resume
> 	- used bitmask and genmask
> 
> v3:
>         - Fixed the sparse warnings.
> 
> v2:
>         - Added controller description in cover letter
>         - Removed "default m" from Kconfig
>         - Replaced low_address() and high_address() functions with kernel
>           API's lower_32_bits & upper_32_bits().
>         - Removed the BH handler function pt_core_irq_bh() and instead
>           handling transaction in irq handler itself.
>         - Moved presetting of command queue registers into new function
>           "init_cmdq_regs()"
>         - Removed the kernel thread dependency to submit transaction.
>         - Increased the hardware command queue size to 32 and adding it
>           as a module parameter.
>         - Removed backlog command queue handling mechanism.
>         - Removed software command queue handling and instead submitting
>           transaction command directly to
>           hardware command queue.
>         - Added tasklet structure variable in "struct pt_device".
>           This is used to invoke pt_do_cmd_complete() upon receiving interrupt
>           for command completion.
>         - pt_core_perform_passthru() function parameters are modified and it is
>           now used to submit command directly to hardware from dmaengine framew
>         - Removed below structures, enums, macros and functions, as these value
>           constants. Making command submission simple,
>            - Removed "union pt_function"  and several macros like PT_VERSION,
>              PT_BYTESWAP, PT_CMD_* etc..
>            - enum pt_passthru_bitwise, enum pt_passthru_byteswap, enum pt_memty
>              struct pt_dma_info, struct pt_data, struct pt_mem, struct pt_passt
>              struct pt_op,
> 
> Links of the review comments for v5:
> 1. https://lkml.org/lkml/2020/7/3/154
> 2. https://lkml.org/lkml/2020/8/25/431
> 3. https://lkml.org/lkml/2020/7/3/177
> 4. https://lkml.org/lkml/2020/7/3/186
> 
> Links of the review comments for v5:
> 1. https://lkml.org/lkml/2020/5/4/42
> 2. https://lkml.org/lkml/2020/5/4/45
> 3. https://lkml.org/lkml/2020/5/4/38
> 4. https://lkml.org/lkml/2020/5/26/70
> 
> Links of the review comments for v4:
> 1. https://lkml.org/lkml/2020/1/24/12
> 2. https://lkml.org/lkml/2020/1/24/17
> 
> Links of the review comments for v2:
> 1https://lkml.org/lkml/2019/12/27/630
> 2. https://lkml.org/lkml/2020/1/3/23
> 3. https://lkml.org/lkml/2020/1/3/314
> 4. https://lkml.org/lkml/2020/1/10/100
> 
> Links of the review comments for v1:
> 1. https://lkml.org/lkml/2019/9/24/490
> 2. https://lkml.org/lkml/2019/9/24/399
> 3. https://lkml.org/lkml/2019/9/24/862
> 4. https://lkml.org/lkml/2019/9/24/122
> 
> Sanjay R Mehta (3):
>   dmaengine: ptdma: Initial driver for the AMD PTDMA
>   dmaengine: ptdma: register PTDMA controller as a DMA resource
>   dmaengine: ptdma: Add debugfs entries for PTDMA information
> 
>  MAINTAINERS                         |   6 +
>  drivers/dma/Kconfig                 |   2 +
>  drivers/dma/Makefile                |   1 +
>  drivers/dma/ptdma/Kconfig           |  13 +
>  drivers/dma/ptdma/Makefile          |  10 +
>  drivers/dma/ptdma/ptdma-debugfs.c   | 115 ++++++++
>  drivers/dma/ptdma/ptdma-dev.c       | 333 ++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-dmaengine.c | 554 ++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-pci.c       | 252 ++++++++++++++++
>  drivers/dma/ptdma/ptdma.h           | 352 +++++++++++++++++++++++
>  10 files changed, 1638 insertions(+)
>  create mode 100644 drivers/dma/ptdma/Kconfig
>  create mode 100644 drivers/dma/ptdma/Makefile
>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>  create mode 100644 drivers/dma/ptdma/ptdma.h

Hey Vinod,

Hope you are doing good.

I had submitted this patch series 3 weeks ago with the suggested changes.
Did you got chance to review?

Thanks,
Sanjay

> 
