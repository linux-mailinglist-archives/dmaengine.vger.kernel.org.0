Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E935FF06C
	for <lists+dmaengine@lfdr.de>; Fri, 14 Oct 2022 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJNOfx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Oct 2022 10:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJNOfv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Oct 2022 10:35:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDB26AF8;
        Fri, 14 Oct 2022 07:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSJXO1GrMUO3sdwJVvHAWBLGvSl4jbMvgJvpSzLmqJSk7Pca4f8I5sUSnhrUKggfVEkADwn/S5P1PJIqrx8aRRQsKv2fMWxA+lxayWQPtWE4aj7r9gUcPXFxza0MF/+r0FrigmXyP2EFr69RWMwbQVa0abMhL7lfwSGgW7GfMs0yDzhXlGRQlezzCDH74P2cdg2XEweSZIqrC7CFWZQsVXgdX3Oxg5DwDNirmCCb0erAIa0mWBkn3WV+meyCJiCQYSMOHYUGbX2J/vhxjTVFnF7uE1Ox5dut8AsuZtAUCH2hDqnICJyqwsMjmtfjuo143EAa8f3AuNUTmGLNnVt/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Wd95xeMXQwNcQg8hCFy2VhY/bUAZiAb3UjvTcy8Zt0=;
 b=AR3p59EkbU0ZakHwJ/jwLkN+u0vvEOcYHSDdDb2bGcffHxUSijs3d8Y4nqPJDKonmQQeGll4z5jdX5QHDM6Sl+yQtAczidEFLqoydi5bo2inedh6s4lBuf1jl4vRvshiQWnLavZ564gJmLh968P4Ye0KcEwjElIcJ9QuUg99QBzryTksWJ5ZTYQDdyKncBkJjv6v/YkNPkq9NPdhUFaL9KfHgrq5kpRFsJIdC8CtZijGnDoMdhICdwf4ld6/wPhqqjH+EnpqPrYIffvgaw8oxnIGK62ig3F//wywiuDpfamgxeDk7IvaCUFad4pz2pJ5Vv7alF8hhrZNFIHS6HwgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sasfermat.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wd95xeMXQwNcQg8hCFy2VhY/bUAZiAb3UjvTcy8Zt0=;
 b=y3pXqduXqcQuZnDzLEg+KOTNDLdPcCJ0WwFe0kxJ653DxqFp+Y5XMkHl4zj5zQzJSV0TdxWuia3I7huXskN0SuwFfDBz4+Ao4g10OBbz0WPVDBeCNSyJS0FzZdeNwMNAR2tCWVeY8o2NyivkEvVEinOA0g6LWt7jFAjQ6+AbQ84=
Received: from BN8PR15CA0061.namprd15.prod.outlook.com (2603:10b6:408:80::38)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 14:35:44 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::c6) by BN8PR15CA0061.outlook.office365.com
 (2603:10b6:408:80::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Fri, 14 Oct 2022 14:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 14:35:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 09:35:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 09:35:43 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 14 Oct 2022 09:35:42 -0500
Message-ID: <e72fbc6c-460f-715d-5b1d-8621b2a56978@amd.com>
Date:   Fri, 14 Oct 2022 07:35:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V7 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx xdma
 driver
Content-Language: en-US
To:     Julien BERAUD <jberaud@sasfermat.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>
CC:     <tumic@gpxsee.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <larry.liu@amd.com>, <brian.xu@amd.com>
References: <1665502262-4246-1-git-send-email-lizhi.hou@amd.com>
 <1665502262-4246-2-git-send-email-lizhi.hou@amd.com>
 <19ac6907-63cd-873e-1545-04ca7a785d29@sasfermat.com>
 <e0a47daf-fcc4-3bc0-2c0b-4b38b2d14b26@amd.com>
 <63fa0d9a-b543-4b2d-f059-3070b8398aa0@sasfermat.com>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <63fa0d9a-b543-4b2d-f059-3070b8398aa0@sasfermat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: f950f166-7d20-4212-73d9-08daadf1603a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YUdeKXuFCIZqtDNrtIqrk/ENMzCQl6leXraOMl+xWlSo5mu8TcTAtYy9cKY1D5X9XZXMN0FKoNUYFsAr2hEGXcoH5qrDZKsy2jGWipLgWLbP6Zd6q0VjBnuRfpiH3HKcZGDfRErPhAeOJqjizn9XlDHeikz+6QaXtz/RSFCP/7f3mSvx7VzOo6v3g3Gwaa0qIY+Ku1FToEOplPFEeE2Rn5nDbCRkkn28sAPRSuPi3jAFuKpMQH7qDm7KUtpcWK9Sz4nJRpQEJFkhiwSHtgQkz0ihc61UKOkriGQ+cqtGuQgYj8XlwOyBF2upmQF6v46xji55NFzD77MafWEb8FJ+fTdQk2ZiygiAZ7k8ovYsr8zIQod/4lu9ykb+REQJtqX6ilCuf3X3+LgTtahG761d34CLtnkWZFLLZLsV+3YAeRjJYrtV3v5TlhEVItUTF7hFiBBaMYd6KiUNa/Dn+mwde/SlxjPd/FGE75p6D0tXD+DHMRSuE8A5o85soLmuDLklwA4uM0p6srcnlhLWyPuEeDAO/K2s8DAVt3oA2QFojiOWC/Nk/eDhsYgTkIJvH0G8LAAp6zIoLiChPHtRDMkbXBnPtVSZhWK3P/3r/vNZn6MgKpGkg8SqD8rz21YHFMTCR7U8qtnTGLnkr/kTjKoBjHKjKSwmCTkN3w24VM4iqa8cR2FaVSii2PotzrjbAUO7+TWJ4u1LT3iK232WWbW5yk9+WSXSlfRrKBhPnZbvG0Ia7zzSN+uLCRCm20TG7DL+g2MMHA1aJlHUBoORDAQcS1D3qi1yx30VRoN92aAqmZJLk7/MLYqPOEhPDQnpAeAowi971t+J6kuMIXjaV2ebEI7KACzEGbqlOSb7GeUMWWJ/mQ4zeDfzphfVFZC7VK0pQNVEyzv2bQI0WXsUP6cwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(81166007)(70206006)(316002)(110136005)(478600001)(16576012)(54906003)(966005)(31686004)(70586007)(8676002)(4326008)(8936002)(26005)(41300700001)(356005)(186003)(5660300002)(336012)(30864003)(2616005)(44832011)(2906002)(82310400005)(47076005)(83380400001)(36756003)(40460700003)(86362001)(82740400003)(36860700001)(53546011)(426003)(31696002)(40480700001)(36900700001)(43740500002)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 14:35:43.9044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f950f166-7d20-4212-73d9-08daadf1603a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/14/22 00:27, Julien BERAUD wrote:
> On 13/10/2022 23:05, Lizhi Hou wrote:
>> On 10/12/22 00:12, Julien BERAUD wrote:
>>> On 11/10/2022 17:31, Lizhi Hou wrote:
>>>> Add driver to enable PCIe board which uses XDMA (the DMA/Bridge Subsystem
>>>> for PCI Express). For example, Xilinx Alveo PCIe devices.
>>>>       https://www.xilinx.com/products/boards-and-kits/alveo.html
>>>>
>>>> The XDMA engine support up to 4 Host to Card (H2C) and 4 Card to Host (C2H)
>>>> channels. Memory transfers are specified on a per-channel basis in
>>>> descriptor linked lists, which the DMA fetches from host memory and
>>>> processes. Events such as descriptor completion and errors are signaled
>>>> using interrupts. The hardware detail is provided by
>>>>       https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Introduction
>>>>
>>>> This driver implements dmaengine APIs.
>>>>       - probe the available DMA channels
>>>>       - use dma_slave_map for channel lookup
>>>>       - use virtual channel to manage dmaengine tx descriptors
>>>>       - implement device_prep_slave_sg callback to handle host scatter gather
>>>>         list
>>>>       - implement device_config to config device address for DMA transfer
>>>>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>>>> ---
>>>>    MAINTAINERS                            |  10 +
>>>>    drivers/dma/Kconfig                    |  13 +
>>>>    drivers/dma/xilinx/Makefile            |   1 +
>>>>    drivers/dma/xilinx/xdma-regs.h         | 171 +++++
>>>>    drivers/dma/xilinx/xdma.c              | 947 +++++++++++++++++++++++++
>>>>    include/linux/platform_data/amd_xdma.h |  34 +
>>>>    6 files changed, 1176 insertions(+)
>>>>    create mode 100644 drivers/dma/xilinx/xdma-regs.h
>>>>    create mode 100644 drivers/dma/xilinx/xdma.c
>>>>    create mode 100644 include/linux/platform_data/amd_xdma.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index e8c52d0192a6..c1be0b2e378a 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -21683,6 +21683,16 @@ F:    Documentation/devicetree/bindings/media/xilinx/
>>>>    F:    drivers/media/platform/xilinx/
>>>>    F:    include/uapi/linux/xilinx-v4l2-controls.h
>>>>    +XILINX XDMA DRIVER
>>>> +M:    Lizhi Hou <lizhi.hou@amd.com>
>>>> +M:    Brian Xu <brian.xu@amd.com>
>>>> +M:    Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>
>>>> +L:    dmaengine@vger.kernel.org
>>>> +S:    Supported
>>>> +F:    drivers/dma/xilinx/xdma-regs.h
>>>> +F:    drivers/dma/xilinx/xdma.c
>>>> +F:    include/linux/platform_data/amd_xdma.h
>>>> +
>>>>    XILINX ZYNQMP DPDMA DRIVER
>>>>    M:    Hyun Kwon <hyun.kwon@xilinx.com>
>>>>    M:    Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>>>> index d5de3f77d3aa..4d90f2f51655 100644
>>>> --- a/drivers/dma/Kconfig
>>>> +++ b/drivers/dma/Kconfig
>>>> @@ -733,6 +733,19 @@ config XILINX_ZYNQMP_DPDMA
>>>>          driver provides the dmaengine required by the DisplayPort subsystem
>>>>          display driver.
>>>>    +config XILINX_XDMA
>>>> +    tristate "Xilinx DMA/Bridge Subsystem DMA Engine"
>>>> +    select DMA_ENGINE
>>>> +    select DMA_VIRTUAL_CHANNELS
>>>> +    select REGMAP_MMIO
>>>> +    help
>>>> +      Enable support for Xilinx DMA/Bridge Subsystem DMA engine. The DMA
>>>> +      provides high performance block data movement between Host memory
>>>> +      and the DMA subsystem. These direct memory transfers can be both in
>>>> +      the Host to Card (H2C) and Card to Host (C2H) transfers.
>>>> +      The core also provides up to 16 user interrupt wires that generate
>>>> +      interrupts to the host.
>>>> +
>>>>    # driver files
>>>>    source "drivers/dma/bestcomm/Kconfig"
>>>>    diff --git a/drivers/dma/xilinx/Makefile b/drivers/dma/xilinx/Makefile
>>>> index 767bb45f641f..c7a538a56643 100644
>>>> --- a/drivers/dma/xilinx/Makefile
>>>> +++ b/drivers/dma/xilinx/Makefile
>>>> @@ -2,3 +2,4 @@
>>>>    obj-$(CONFIG_XILINX_DMA) += xilinx_dma.o
>>>>    obj-$(CONFIG_XILINX_ZYNQMP_DMA) += zynqmp_dma.o
>>>>    obj-$(CONFIG_XILINX_ZYNQMP_DPDMA) += xilinx_dpdma.o
>>>> +obj-$(CONFIG_XILINX_XDMA) += xdma.o
>>>> diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
>>>> new file mode 100644
>>>> index 000000000000..4a6d2d76cb15
>>>> --- /dev/null
>>>> +++ b/drivers/dma/xilinx/xdma-regs.h
>>>> @@ -0,0 +1,171 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +/*
>>>> + * Copyright (C) 2017-2020 Xilinx, Inc. All rights reserved.
>>>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>>>> + */
>>>> +
>>>> +#ifndef __DMA_XDMA_REGS_H
>>>> +#define __DMA_XDMA_REGS_H
>>>> +
>>>> +/* The length of register space exposed to host */
>>>> +#define XDMA_REG_SPACE_LEN    65536
>>>> +
>>>> +/*
>>>> + * maximum number of DMA channels for each direction:
>>>> + * Host to Card (H2C) or Card to Host (C2H)
>>>> + */
>>>> +#define XDMA_MAX_CHANNELS    4
>>>> +
>>>> +/* macros to get higher and lower 32-bit address */
>>>> +#define XDMA_HI_ADDR_MASK    GENMASK_ULL(63, 32)
>>>> +#define XDMA_LO_ADDR_MASK    GENMASK_ULL(31, 0)
>>>> +
>>>> +/*
>>>> + * macros to define the number of descriptor blocks can be used in one
>>>> + * DMA transfer request.
>>>> + * the DMA engine uses a linked list of descriptor blocks that specify the
>>>> + * source, destination, and length of the DMA transfers.
>>>> + */
>>>> +#define XDMA_DESC_BLOCK_NUM        BIT(7)
>>>> +#define XDMA_DESC_BLOCK_MASK        (XDMA_DESC_BLOCK_NUM - 1)
>>>> +
>>>> +/* descriptor definitions */
>>>> +#define XDMA_DESC_ADJACENT        BIT(5)
>>> May I ask the reason for this BIT(5) value ? The number of adjacent descriptors is coded on 6 bits so it doesn't seem natural to me.
>>>   From the documentation (https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Descriptors), the first bytes are:
>>> 0x0     Magic[15:0]     Rsv[1:0]     Nxt_adj[5:0]     Control[7:0]
>>>
>>> Does it have to do with the following sentence from the same chapter :
>>> "Note: Because MRRS in most host systems is 512 bytes or 1024 bytes, having more than 32 adjacent descriptors is not allowed on a single request. However, the design will allow a maximum 64 descriptors in a single block of adjacent descriptors if needed."
>>>
>>> Or is it something else ?
>> Hi Julien,
>>
>> We used 32 adjacent in our Alveo driver for several years. We have tried to test 64 adjacent and did not see obvious performance boost. And it seems using 32 adjacent is stable and compatible with all our setup.
>>
>> Thanks,
>>
>> Lizhi
>
> Thanks for your response. The use of BIT() made it a bit difficult to understand.
>
> Which Alveo driver are you referring to if I may ?
>
>  From here https://github.com/Xilinx/XRT/blob/9f82c9ce900b4b1d7d0bffbd8e2afe0b0253f80a/src/runtime_src/core/pcie/driver/linux/xocl/lib/libxdma.c#L647 I see 63 max adjacent descriptors meaning 64 block, and from https://github.com/Xilinx/dma_ip_drivers/blob/6a3b003f9d7cc3b19a1ba6685eedb36620557785/XDMA/linux-kernel/xdma/libxdma.h#L87 same.

There is a global variable to tune it. Please see a few lines more.

https://github.com/Xilinx/XRT/blob/9f82c9ce900b4b1d7d0bffbd8e2afe0b0253f80a/src/runtime_src/core/pcie/driver/linux/xocl/lib/libxdma.c#L654


Thanks,

Lizhi

>
> Thanks,
>
> Julien
>
>>>> +#define XDMA_DESC_ADJACENT_MASK        (XDMA_DESC_ADJACENT - 1)
>>>> +#define XDMA_DESC_MAGIC            0xad4bUL
>>>> +#define XDMA_DESC_MAGIC_SHIFT        16
>>>> +#define XDMA_DESC_ADJACENT_SHIFT    8
>>>> +#define XDMA_DESC_STOPPED        BIT(0)
>>>> +#define XDMA_DESC_COMPLETED        BIT(1)
>>>> +#define XDMA_DESC_BLEN_BITS        28
>>>> +#define XDMA_DESC_BLEN_MAX        (BIT(XDMA_DESC_BLEN_BITS) - PAGE_SIZE)
>>>> +
>>>> +/* macros to construct the descriptor control word */
>>>> +#define XDMA_DESC_CONTROL(adjacent, flag)                \
>>>> +    ((XDMA_DESC_MAGIC << XDMA_DESC_MAGIC_SHIFT) |            \
>>>> +     (((adjacent) - 1) << XDMA_DESC_ADJACENT_SHIFT) | (flag))
>>>> +#define XDMA_DESC_CONTROL_LAST                        \
>>>> +    XDMA_DESC_CONTROL(1, XDMA_DESC_STOPPED | XDMA_DESC_COMPLETED)
>>>> +
>>>> +/*
>>>> + * Descriptor for a single contiguous memory block transfer.
>>>> + *
>>>> + * Multiple descriptors are linked by means of the next pointer. An additional
>>>> + * extra adjacent number gives the amount of extra contiguous descriptors.
>>>> + *
>>>> + * The descriptors are in root complex memory, and the bytes in the 32-bit
>>>> + * words must be in little-endian byte ordering.
>>>> + */
>>>> +struct xdma_hw_desc {
>>>> +    __le32        control;
>>>> +    __le32        bytes;
>>>> +    __le64        src_addr;
>>>> +    __le64        dst_addr;
>>>> +    __le64        next_desc;
>>>> +};
>>>> +
>>>> +#define XDMA_DESC_SIZE        sizeof(struct xdma_hw_desc)
>>>> +#define XDMA_DESC_BLOCK_SIZE    (XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
>>>> +#define XDMA_DESC_BLOCK_ALIGN    4096
>>>> +
>>>> +/*
>>>> + * Channel registers
>>>> + */
>>>> +#define XDMA_CHAN_IDENTIFIER        0x0
>>>> +#define XDMA_CHAN_CONTROL        0x4
>>>> +#define XDMA_CHAN_CONTROL_W1S        0x8
>>>> +#define XDMA_CHAN_CONTROL_W1C        0xc
>>>> +#define XDMA_CHAN_STATUS        0x40
>>>> +#define XDMA_CHAN_COMPLETED_DESC    0x48
>>>> +#define XDMA_CHAN_ALIGNMENTS        0x4c
>>>> +#define XDMA_CHAN_INTR_ENABLE        0x90
>>>> +#define XDMA_CHAN_INTR_ENABLE_W1S    0x94
>>>> +#define XDMA_CHAN_INTR_ENABLE_W1C    0x9c
>>>> +
>>>> +#define XDMA_CHAN_STRIDE    0x100
>>>> +#define XDMA_CHAN_H2C_OFFSET    0x0
>>>> +#define XDMA_CHAN_C2H_OFFSET    0x1000
>>>> +#define XDMA_CHAN_H2C_TARGET    0x0
>>>> +#define XDMA_CHAN_C2H_TARGET    0x1
>>>> +
>>>> +/* macro to check if channel is available */
>>>> +#define XDMA_CHAN_MAGIC        0x1fc0
>>>> +#define XDMA_CHAN_CHECK_TARGET(id, target)        \
>>>> +    (((u32)(id) >> 16) == XDMA_CHAN_MAGIC + (target))
>>>> +
>>>> +/* bits of the channel control register */
>>>> +#define CHAN_CTRL_RUN_STOP            BIT(0)
>>>> +#define CHAN_CTRL_IE_DESC_STOPPED        BIT(1)
>>>> +#define CHAN_CTRL_IE_DESC_COMPLETED        BIT(2)
>>>> +#define CHAN_CTRL_IE_DESC_ALIGN_MISMATCH    BIT(3)
>>>> +#define CHAN_CTRL_IE_MAGIC_STOPPED        BIT(4)
>>>> +#define CHAN_CTRL_IE_IDLE_STOPPED        BIT(6)
>>>> +#define CHAN_CTRL_IE_READ_ERROR            GENMASK(13, 9)
>>>> +#define CHAN_CTRL_IE_DESC_ERROR            GENMASK(23, 19)
>>>> +#define CHAN_CTRL_NON_INCR_ADDR            BIT(25)
>>>> +#define CHAN_CTRL_POLL_MODE_WB            BIT(26)
>>>> +
>>>> +#define CHAN_CTRL_START    (CHAN_CTRL_RUN_STOP |                \
>>>> +             CHAN_CTRL_IE_DESC_STOPPED |            \
>>>> +             CHAN_CTRL_IE_DESC_COMPLETED |            \
>>>> +             CHAN_CTRL_IE_DESC_ALIGN_MISMATCH |        \
>>>> +             CHAN_CTRL_IE_MAGIC_STOPPED |            \
>>>> +             CHAN_CTRL_IE_READ_ERROR |            \
>>>> +             CHAN_CTRL_IE_DESC_ERROR)
>>>> +
>>>> +/* bits of the channel interrupt enable mask */
>>>> +#define CHAN_IM_DESC_ERROR            BIT(19)
>>>> +#define CHAN_IM_READ_ERROR            BIT(9)
>>>> +#define CHAN_IM_IDLE_STOPPED            BIT(6)
>>>> +#define CHAN_IM_MAGIC_STOPPED            BIT(4)
>>>> +#define CHAN_IM_DESC_COMPLETED            BIT(2)
>>>> +#define CHAN_IM_DESC_STOPPED            BIT(1)
>>>> +
>>>> +#define CHAN_IM_ALL    (CHAN_IM_DESC_ERROR | CHAN_IM_READ_ERROR |    \
>>>> +             CHAN_IM_IDLE_STOPPED | CHAN_IM_MAGIC_STOPPED | \
>>>> +             CHAN_IM_DESC_COMPLETED | CHAN_IM_DESC_STOPPED)
>>>> +
>>>> +/*
>>>> + * Channel SGDMA registers
>>>> + */
>>>> +#define XDMA_SGDMA_IDENTIFIER    0x0
>>>> +#define XDMA_SGDMA_DESC_LO    0x80
>>>> +#define XDMA_SGDMA_DESC_HI    0x84
>>>> +#define XDMA_SGDMA_DESC_ADJ    0x88
>>>> +#define XDMA_SGDMA_DESC_CREDIT    0x8c
>>>> +
>>>> +#define XDMA_SGDMA_BASE(chan_base)    ((chan_base) + 0x4000)
>>>> +
>>>> +/* bits of the SG DMA control register */
>>>> +#define XDMA_CTRL_RUN_STOP            BIT(0)
>>>> +#define XDMA_CTRL_IE_DESC_STOPPED        BIT(1)
>>>> +#define XDMA_CTRL_IE_DESC_COMPLETED        BIT(2)
>>>> +#define XDMA_CTRL_IE_DESC_ALIGN_MISMATCH    BIT(3)
>>>> +#define XDMA_CTRL_IE_MAGIC_STOPPED        BIT(4)
>>>> +#define XDMA_CTRL_IE_IDLE_STOPPED        BIT(6)
>>>> +#define XDMA_CTRL_IE_READ_ERROR            GENMASK(13, 9)
>>>> +#define XDMA_CTRL_IE_DESC_ERROR            GENMASK(23, 19)
>>>> +#define XDMA_CTRL_NON_INCR_ADDR            BIT(25)
>>>> +#define XDMA_CTRL_POLL_MODE_WB            BIT(26)
>>>> +
>>>> +/*
>>>> + * interrupt registers
>>>> + */
>>>> +#define XDMA_IRQ_IDENTIFIER        0x0
>>>> +#define XDMA_IRQ_USER_INT_EN        0x04
>>>> +#define XDMA_IRQ_USER_INT_EN_W1S    0x08
>>>> +#define XDMA_IRQ_USER_INT_EN_W1C    0x0c
>>>> +#define XDMA_IRQ_CHAN_INT_EN        0x10
>>>> +#define XDMA_IRQ_CHAN_INT_EN_W1S    0x14
>>>> +#define XDMA_IRQ_CHAN_INT_EN_W1C    0x18
>>>> +#define XDMA_IRQ_USER_INT_REQ        0x40
>>>> +#define XDMA_IRQ_CHAN_INT_REQ        0x44
>>>> +#define XDMA_IRQ_USER_INT_PEND        0x48
>>>> +#define XDMA_IRQ_CHAN_INT_PEND        0x4c
>>>> +#define XDMA_IRQ_USER_VEC_NUM        0x80
>>>> +#define XDMA_IRQ_CHAN_VEC_NUM        0xa0
>>>> +
>>>> +#define XDMA_IRQ_BASE            0x2000
>>>> +#define XDMA_IRQ_VEC_SHIFT        8
>>>> +
>>>> +#endif /* __DMA_XDMA_REGS_H */
>>>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>>>> new file mode 100644
>>>> index 000000000000..c78871f821d3
>>>> --- /dev/null
>>>> +++ b/drivers/dma/xilinx/xdma.c
>>>> @@ -0,0 +1,947 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * DMA driver for Xilinx DMA/Bridge Subsystem
>>>> + *
>>>> + * Copyright (C) 2017-2020 Xilinx, Inc. All rights reserved.
>>>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>>>> + */
>>>> +
>>>> +/*
>>>> + * The DMA/Bridge Subsystem for PCI Express allows for the movement of data
>>>> + * between Host memory and the DMA subsystem. It does this by operating on
>>>> + * 'descriptors' that contain information about the source, destination and
>>>> + * amount of data to transfer. These direct memory transfers can be both in
>>>> + * the Host to Card (H2C) and Card to Host (C2H) transfers. The DMA can be
>>>> + * configured to have a single AXI4 Master interface shared by all channels
>>>> + * or one AXI4-Stream interface for each channel enabled. Memory transfers are
>>>> + * specified on a per-channel basis in descriptor linked lists, which the DMA
>>>> + * fetches from host memory and processes. Events such as descriptor completion
>>>> + * and errors are signaled using interrupts. The core also provides up to 16
>>>> + * user interrupt wires that generate interrupts to the host.
>>>> + */
>>>> +
>>>> +#include <linux/mod_devicetable.h>
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/dmapool.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/dmaengine.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/platform_data/amd_xdma.h>
>>>> +#include <linux/dma-mapping.h>
>>>> +#include "../virt-dma.h"
>>>> +#include "xdma-regs.h"
>>>> +
>>>> +/* mmio regmap config for all XDMA registers */
>>>> +static const struct regmap_config xdma_regmap_config = {
>>>> +    .reg_bits = 32,
>>>> +    .val_bits = 32,
>>>> +    .reg_stride = 4,
>>>> +    .max_register = XDMA_REG_SPACE_LEN,
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct xdma_desc_block - Descriptor block
>>>> + * @virt_addr: Virtual address of block start
>>>> + * @dma_addr: DMA address of block start
>>>> + */
>>>> +struct xdma_desc_block {
>>>> +    void        *virt_addr;
>>>> +    dma_addr_t    dma_addr;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct xdma_chan - Driver specific DMA channel structure
>>>> + * @vchan: Virtual channel
>>>> + * @xdev_hdl: Pointer to DMA device structure
>>>> + * @base: Offset of channel registers
>>>> + * @desc_pool: Descriptor pool
>>>> + * @busy: Busy flag of the channel
>>>> + * @dir: Transferring direction of the channel
>>>> + * @cfg: Transferring config of the channel
>>>> + * @irq: IRQ assigned to the channel
>>>> + */
>>>> +struct xdma_chan {
>>>> +    struct virt_dma_chan        vchan;
>>>> +    void                *xdev_hdl;
>>>> +    u32                base;
>>>> +    struct dma_pool            *desc_pool;
>>>> +    bool                busy;
>>>> +    enum dma_transfer_direction    dir;
>>>> +    struct dma_slave_config        cfg;
>>>> +    u32                irq;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct xdma_desc - DMA desc structure
>>>> + * @vdesc: Virtual DMA descriptor
>>>> + * @chan: DMA channel pointer
>>>> + * @dir: Transferring direction of the request
>>>> + * @dev_addr: Physical address on DMA device side
>>>> + * @desc_blocks: Hardware descriptor blocks
>>>> + * @dblk_num: Number of hardware descriptor blocks
>>>> + * @desc_num: Number of hardware descriptors
>>>> + * @completed_desc_num: Completed hardware descriptors
>>>> + */
>>>> +struct xdma_desc {
>>>> +    struct virt_dma_desc        vdesc;
>>>> +    struct xdma_chan        *chan;
>>>> +    enum dma_transfer_direction    dir;
>>>> +    u64                dev_addr;
>>>> +    struct xdma_desc_block        *desc_blocks;
>>>> +    u32                dblk_num;
>>>> +    u32                desc_num;
>>>> +    u32                completed_desc_num;
>>>> +};
>>>> +
>>>> +#define XDMA_DEV_STATUS_REG_DMA        BIT(0)
>>>> +#define XDMA_DEV_STATUS_INIT_MSIX    BIT(1)
>>>> +
>>>> +/**
>>>> + * struct xdma_device - DMA device structure
>>>> + * @pdev: Platform device pointer
>>>> + * @dma_dev: DMA device structure
>>>> + * @regmap: MMIO regmap for DMA registers
>>>> + * @h2c_chans: Host to Card channels
>>>> + * @c2h_chans: Card to Host channels
>>>> + * @h2c_chan_num: Number of H2C channels
>>>> + * @c2h_chan_num: Number of C2H channels
>>>> + * @irq_start: Start IRQ assigned to device
>>>> + * @irq_num: Number of IRQ assigned to device
>>>> + * @status: Initialization status
>>>> + */
>>>> +struct xdma_device {
>>>> +    struct platform_device    *pdev;
>>>> +    struct dma_device    dma_dev;
>>>> +    struct regmap        *regmap;
>>>> +    struct xdma_chan    *h2c_chans;
>>>> +    struct xdma_chan    *c2h_chans;
>>>> +    u32            h2c_chan_num;
>>>> +    u32            c2h_chan_num;
>>>> +    u32            irq_start;
>>>> +    u32            irq_num;
>>>> +    u32            status;
>>>> +};
>>>> +
>>>> +#define xdma_err(xdev, fmt, args...)                    \
>>>> +    dev_err(&(xdev)->pdev->dev, fmt, ##args)
>>>> +#define XDMA_CHAN_NUM(_xd) ({                        \
>>>> +    typeof(_xd) (xd) = (_xd);                    \
>>>> +    ((xd)->h2c_chan_num + (xd)->c2h_chan_num); })
>>>> +
>>>> +/* Read and Write DMA registers */
>>>> +static inline int xdma_read_reg(struct xdma_device *xdev, u32 base, u32 reg,
>>>> +                u32 *val)
>>>> +{
>>>> +    return regmap_read(xdev->regmap, base + reg, val);
>>>> +}
>>>> +
>>>> +static inline int xdma_write_reg(struct xdma_device *xdev, u32 base, u32 reg,
>>>> +                 u32 val)
>>>> +{
>>>> +    return regmap_write(xdev->regmap, base + reg, val);
>>>> +}
>>>> +
>>>> +/* Get the last desc in a desc block */
>>>> +static inline void *xdma_blk_last_desc(struct xdma_desc_block *block)
>>>> +{
>>>> +    return block->virt_addr + (XDMA_DESC_ADJACENT - 1) * XDMA_DESC_SIZE;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_link_desc_blocks - Link descriptor blocks for DMA transfer
>>>> + * @sw_desc: Tx descriptor pointer
>>>> + */
>>>> +static void xdma_link_desc_blocks(struct xdma_desc *sw_desc)
>>>> +{
>>>> +    struct xdma_desc_block *block;
>>>> +    u32 last_blk_desc_num, desc_control;
>>>> +    struct xdma_hw_desc *desc;
>>>> +    int i;
>>>> +
>>>> +    desc_control = XDMA_DESC_CONTROL(XDMA_DESC_ADJACENT, 0);
>>>> +    for (i = 1; i < sw_desc->dblk_num; i++) {
>>>> +        block = &sw_desc->desc_blocks[i - 1];
>>>> +        desc = xdma_blk_last_desc(block);
>>>> +
>>>> +        if (!(i & XDMA_DESC_BLOCK_MASK)) {
>>>> +            desc->control = cpu_to_le32(XDMA_DESC_CONTROL_LAST);
>>>> +            continue;
>>>> +        }
>>>> +        desc->control = cpu_to_le32(desc_control);
>>>> +        desc->next_desc = cpu_to_le64(block[1].dma_addr);
>>>> +    }
>>>> +
>>>> +    /* update the last block */
>>>> +    last_blk_desc_num =
>>>> +        ((sw_desc->desc_num - 1) & XDMA_DESC_ADJACENT_MASK) + 1;
>>>> +    if (((sw_desc->dblk_num - 1) & XDMA_DESC_BLOCK_MASK) > 0) {
>>>> +        block = &sw_desc->desc_blocks[sw_desc->dblk_num - 2];
>>>> +        desc = xdma_blk_last_desc(block);
>>>> +        desc_control = XDMA_DESC_CONTROL(last_blk_desc_num, 0);
>>>> +        desc->control = cpu_to_le32(desc_control);
>>>> +    }
>>>> +
>>>> +    block = &sw_desc->desc_blocks[sw_desc->dblk_num - 1];
>>>> +    desc = block->virt_addr + (last_blk_desc_num - 1) * XDMA_DESC_SIZE;
>>>> +    desc->control = cpu_to_le32(XDMA_DESC_CONTROL_LAST);
>>>> +}
>>>> +
>>>> +static inline struct xdma_chan *to_xdma_chan(struct dma_chan *chan)
>>>> +{
>>>> +    return container_of(chan, struct xdma_chan, vchan.chan);
>>>> +}
>>>> +
>>>> +static inline struct xdma_desc *to_xdma_desc(struct virt_dma_desc *vdesc)
>>>> +{
>>>> +    return container_of(vdesc, struct xdma_desc, vdesc);
>>>> +}
>>>> +
>>>> +static int xdma_enable_intr(struct xdma_device *xdev)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_CHAN_INT_EN_W1S, ~0);
>>>> +    if (ret)
>>>> +        xdma_err(xdev, "enable channel intr failed: %d", ret);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int xdma_disable_intr(struct xdma_device *xdev)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_CHAN_INT_EN_W1C, ~0);
>>>> +    if (ret)
>>>> +        xdma_err(xdev, "disable channel intr failed: %d", ret);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_channel_init - Initialize DMA channel registers
>>>> + * @chan: DMA channel pointer
>>>> + */
>>>> +static int xdma_channel_init(struct xdma_chan *chan)
>>>> +{
>>>> +    struct xdma_device *xdev = chan->xdev_hdl;
>>>> +    int ret;
>>>> +
>>>> +    ret = xdma_write_reg(xdev, chan->base, XDMA_CHAN_CONTROL_W1C,
>>>> +                 CHAN_CTRL_NON_INCR_ADDR);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "clear non incr addr failed: %d", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    ret = xdma_write_reg(xdev, chan->base, XDMA_CHAN_INTR_ENABLE,
>>>> +                 CHAN_IM_ALL);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "failed to set interrupt mask: %d", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_free_desc - Free descriptor
>>>> + * @vdesc: Virtual DMA descriptor
>>>> + */
>>>> +static void xdma_free_desc(struct virt_dma_desc *vdesc)
>>>> +{
>>>> +    struct xdma_desc *sw_desc;
>>>> +    int i;
>>>> +
>>>> +    sw_desc = to_xdma_desc(vdesc);
>>>> +    for (i = 0; i < sw_desc->dblk_num; i++) {
>>>> +        if (!sw_desc->desc_blocks[i].virt_addr)
>>>> +            break;
>>>> +        dma_pool_free(sw_desc->chan->desc_pool,
>>>> +                  sw_desc->desc_blocks[i].virt_addr,
>>>> +                  sw_desc->desc_blocks[i].dma_addr);
>>>> +    }
>>>> +    kfree(sw_desc->desc_blocks);
>>>> +    kfree(sw_desc);
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_alloc_desc - Allocate descriptor
>>>> + * @chan: DMA channel pointer
>>>> + * @desc_num: Number of hardware descriptors
>>>> + */
>>>> +static struct xdma_desc *
>>>> +xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
>>>> +{
>>>> +    struct xdma_desc *sw_desc;
>>>> +    struct xdma_hw_desc *desc;
>>>> +    dma_addr_t dma_addr;
>>>> +    u32 dblk_num;
>>>> +    void *addr;
>>>> +    int i, j;
>>>> +
>>>> +    sw_desc = kzalloc(sizeof(*sw_desc), GFP_NOWAIT);
>>>> +    if (!sw_desc)
>>>> +        return NULL;
>>>> +
>>>> +    sw_desc->chan = chan;
>>>> +    sw_desc->desc_num = desc_num;
>>>> +    dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
>>>> +    sw_desc->desc_blocks = kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks),
>>>> +                       GFP_NOWAIT);
>>>> +    if (!sw_desc->desc_blocks)
>>>> +        goto failed;
>>>> +
>>>> +    sw_desc->dblk_num = dblk_num;
>>>> +    for (i = 0; i < sw_desc->dblk_num; i++) {
>>>> +        addr = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT, &dma_addr);
>>>> +        if (!addr)
>>>> +            goto failed;
>>>> +
>>>> +        sw_desc->desc_blocks[i].virt_addr = addr;
>>>> +        sw_desc->desc_blocks[i].dma_addr = dma_addr;
>>>> +        for (j = 0, desc = addr; j < XDMA_DESC_ADJACENT; j++)
>>>> +            desc[j].control = cpu_to_le32(XDMA_DESC_CONTROL(1, 0));
>>>> +    }
>>>> +
>>>> +    xdma_link_desc_blocks(sw_desc);
>>>> +
>>>> +    return sw_desc;
>>>> +
>>>> +failed:
>>>> +    xdma_free_desc(&sw_desc->vdesc);
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_xfer_start - Start DMA transfer
>>>> + * @xdma_chan: DMA channel pointer
>>>> + */
>>>> +static int xdma_xfer_start(struct xdma_chan *xdma_chan)
>>>> +{
>>>> +    struct virt_dma_desc *vd = vchan_next_desc(&xdma_chan->vchan);
>>>> +    struct xdma_device *xdev = xdma_chan->xdev_hdl;
>>>> +    struct xdma_desc_block *block;
>>>> +    u32 val, completed_blocks;
>>>> +    struct xdma_desc *desc;
>>>> +    int ret;
>>>> +
>>>> +    /*
>>>> +     * check if there is not any submitted descriptor or channel is busy.
>>>> +     * vchan lock should be held where this function is called.
>>>> +     */
>>>> +    if (!vd || xdma_chan->busy)
>>>> +        return -EINVAL;
>>>> +
>>>> +    /* clear run stop bit to get ready for transfer */
>>>> +    ret = xdma_write_reg(xdev, xdma_chan->base, XDMA_CHAN_CONTROL_W1C,
>>>> +                 CHAN_CTRL_RUN_STOP);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "write control failed: %d", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    desc = to_xdma_desc(vd);
>>>> +    if (desc->dir != xdma_chan->dir) {
>>>> +        xdma_err(xdev, "incorrect request direction");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    /* set DMA engine to the first descriptor block */
>>>> +    completed_blocks = desc->completed_desc_num / XDMA_DESC_ADJACENT;
>>>> +    block = &desc->desc_blocks[completed_blocks];
>>>> +    val = FIELD_GET(XDMA_LO_ADDR_MASK, block->dma_addr);
>>>> +    ret = xdma_write_reg(xdev, XDMA_SGDMA_BASE(xdma_chan->base),
>>>> +                 XDMA_SGDMA_DESC_LO, val);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "write hi addr failed: %d", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    val = FIELD_GET(XDMA_HI_ADDR_MASK, (u64)block->dma_addr);
>>>> +    ret = xdma_write_reg(xdev, XDMA_SGDMA_BASE(xdma_chan->base),
>>>> +                 XDMA_SGDMA_DESC_HI, val);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "write lo addr failed: %d", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    if (completed_blocks + 1 == desc->dblk_num)
>>>> +        val = (desc->desc_num - 1) & XDMA_DESC_ADJACENT_MASK;
>>>> +    else
>>>> +        val = XDMA_DESC_ADJACENT - 1;
>>>> +    ret = xdma_write_reg(xdev, XDMA_SGDMA_BASE(xdma_chan->base),
>>>> +                 XDMA_SGDMA_DESC_ADJ, val);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "write adjacent failed: %d", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    /* kick off DMA transfer */
>>>> +    ret = xdma_write_reg(xdev, xdma_chan->base, XDMA_CHAN_CONTROL,
>>>> +                 CHAN_CTRL_START);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "write control failed: %d", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    xdma_chan->busy = true;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_config_channels - Detect and config DMA channels
>>>> + * @xdev: DMA device pointer
>>>> + * @dir: Channel direction
>>>> + */
>>>> +static int xdma_config_channels(struct xdma_device *xdev,
>>>> +                enum dma_transfer_direction dir)
>>>> +{
>>>> +    struct xdma_platdata *pdata = dev_get_platdata(&xdev->pdev->dev);
>>>> +    u32 base, identifier, target;
>>>> +    struct xdma_chan **chans;
>>>> +    u32 *chan_num;
>>>> +    int i, j, ret;
>>>> +
>>>> +    if (dir == DMA_MEM_TO_DEV) {
>>>> +        base = XDMA_CHAN_H2C_OFFSET;
>>>> +        target = XDMA_CHAN_H2C_TARGET;
>>>> +        chans = &xdev->h2c_chans;
>>>> +        chan_num = &xdev->h2c_chan_num;
>>>> +    } else if (dir == DMA_DEV_TO_MEM) {
>>>> +        base = XDMA_CHAN_C2H_OFFSET;
>>>> +        target = XDMA_CHAN_C2H_TARGET;
>>>> +        chans = &xdev->c2h_chans;
>>>> +        chan_num = &xdev->c2h_chan_num;
>>>> +    } else {
>>>> +        xdma_err(xdev, "invalid direction specified");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    /* detect number of available DMA channels */
>>>> +    for (i = 0, *chan_num = 0; i < pdata->max_dma_channels; i++) {
>>>> +        ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
>>>> +                    XDMA_CHAN_IDENTIFIER, &identifier);
>>>> +        if (ret) {
>>>> +            xdma_err(xdev, "failed to read channel id: %d", ret);
>>>> +            return ret;
>>>> +        }
>>>> +
>>>> +        /* check if it is available DMA channel */
>>>> +        if (XDMA_CHAN_CHECK_TARGET(identifier, target))
>>>> +            (*chan_num)++;
>>>> +    }
>>>> +
>>>> +    if (!*chan_num) {
>>>> +        xdma_err(xdev, "does not probe any channel");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    *chans = devm_kzalloc(&xdev->pdev->dev, sizeof(**chans) * (*chan_num),
>>>> +                  GFP_KERNEL);
>>>> +    if (!*chans)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    for (i = 0, j = 0; i < pdata->max_dma_channels; i++) {
>>>> +        ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
>>>> +                    XDMA_CHAN_IDENTIFIER, &identifier);
>>>> +        if (ret) {
>>>> +            xdma_err(xdev, "failed to read channel id: %d", ret);
>>>> +            return ret;
>>>> +        }
>>>> +
>>>> +        if (!XDMA_CHAN_CHECK_TARGET(identifier, target))
>>>> +            continue;
>>>> +
>>>> +        if (j == *chan_num) {
>>>> +            xdma_err(xdev, "invalid channel number");
>>>> +            return -EIO;
>>>> +        }
>>>> +
>>>> +        /* init channel structure and hardware */
>>>> +        (*chans)[j].xdev_hdl = xdev;
>>>> +        (*chans)[j].base = base + i * XDMA_CHAN_STRIDE;
>>>> +        (*chans)[j].dir = dir;
>>>> +
>>>> +        ret = xdma_channel_init(&(*chans)[j]);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +        (*chans)[j].vchan.desc_free = xdma_free_desc;
>>>> +        vchan_init(&(*chans)[j].vchan, &xdev->dma_dev);
>>>> +
>>>> +        j++;
>>>> +    }
>>>> +
>>>> +    dev_info(&xdev->pdev->dev, "configured %d %s channels", j,
>>>> +         (dir == DMA_MEM_TO_DEV) ? "H2C" : "C2H");
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_issue_pending - Issue pending transactions
>>>> + * @chan: DMA channel pointer
>>>> + */
>>>> +static void xdma_issue_pending(struct dma_chan *chan)
>>>> +{
>>>> +    struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>>>> +    unsigned long flags;
>>>> +
>>>> +    spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
>>>> +    if (vchan_issue_pending(&xdma_chan->vchan))
>>>> +        xdma_xfer_start(xdma_chan);
>>>> +    spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_prep_device_sg - prepare a descriptor for a
>>>> + *    DMA transaction
>>>> + * @chan: DMA channel pointer
>>>> + * @sgl: Transfer scatter gather list
>>>> + * @sg_len: Length of scatter gather list
>>>> + * @dir: Transfer direction
>>>> + * @flags: transfer ack flags
>>>> + * @context: APP words of the descriptor
>>>> + */
>>>> +static struct dma_async_tx_descriptor *
>>>> +xdma_prep_device_sg(struct dma_chan *chan, struct scatterlist *sgl,
>>>> +            unsigned int sg_len, enum dma_transfer_direction dir,
>>>> +            unsigned long flags, void *context)
>>>> +{
>>>> +    struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>>>> +    struct dma_async_tx_descriptor *tx_desc;
>>>> +    u32 desc_num = 0, i, len, rest;
>>>> +    struct xdma_desc_block *dblk;
>>>> +    struct xdma_hw_desc *desc;
>>>> +    struct xdma_desc *sw_desc;
>>>> +    u64 dev_addr, *src, *dst;
>>>> +    struct scatterlist *sg;
>>>> +    u64 addr;
>>>> +
>>>> +    for_each_sg(sgl, sg, sg_len, i)
>>>> +        desc_num += DIV_ROUND_UP(sg_dma_len(sg), XDMA_DESC_BLEN_MAX);
>>>> +
>>>> +    sw_desc = xdma_alloc_desc(xdma_chan, desc_num);
>>>> +    if (!sw_desc)
>>>> +        return NULL;
>>>> +    sw_desc->dir = dir;
>>>> +
>>>> +    if (dir == DMA_MEM_TO_DEV) {
>>>> +        dev_addr = xdma_chan->cfg.dst_addr;
>>>> +        src = &addr;
>>>> +        dst = &dev_addr;
>>>> +    } else {
>>>> +        dev_addr = xdma_chan->cfg.src_addr;
>>>> +        src = &dev_addr;
>>>> +        dst = &addr;
>>>> +    }
>>>> +
>>>> +    dblk = sw_desc->desc_blocks;
>>>> +    desc = dblk->virt_addr;
>>>> +    desc_num = 1;
>>>> +    for_each_sg(sgl, sg, sg_len, i) {
>>>> +        addr = sg_dma_address(sg);
>>>> +        rest = sg_dma_len(sg);
>>>> +
>>>> +        do {
>>>> +            len = min_t(u32, rest, XDMA_DESC_BLEN_MAX);
>>>> +            /* set hardware descriptor */
>>>> +            desc->bytes = cpu_to_le32(len);
>>>> +            desc->src_addr = cpu_to_le64(*src);
>>>> +            desc->dst_addr = cpu_to_le64(*dst);
>>>> +
>>>> +            if (!(desc_num & XDMA_DESC_ADJACENT_MASK)) {
>>>> +                dblk++;
>>>> +                desc = dblk->virt_addr;
>>>> +            } else {
>>>> +                desc++;
>>>> +            }
>>>> +
>>>> +            desc_num++;
>>>> +            dev_addr += len;
>>>> +            addr += len;
>>>> +            rest -= len;
>>>> +        } while (rest);
>>>> +    }
>>>> +
>>>> +    tx_desc = vchan_tx_prep(&xdma_chan->vchan, &sw_desc->vdesc, flags);
>>>> +    if (!tx_desc)
>>>> +        goto failed;
>>>> +
>>>> +    return tx_desc;
>>>> +
>>>> +failed:
>>>> +    xdma_free_desc(&sw_desc->vdesc);
>>>> +
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_device_config - Configure the DMA channel
>>>> + * @chan: DMA channel
>>>> + * @cfg: channel configuration
>>>> + */
>>>> +static int xdma_device_config(struct dma_chan *chan,
>>>> +                  struct dma_slave_config *cfg)
>>>> +{
>>>> +    struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>>>> +
>>>> +    memcpy(&xdma_chan->cfg, cfg, sizeof(*cfg));
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_free_chan_resources - Free channel resources
>>>> + * @chan: DMA channel
>>>> + */
>>>> +static void xdma_free_chan_resources(struct dma_chan *chan)
>>>> +{
>>>> +    struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>>>> +
>>>> +    vchan_free_chan_resources(&xdma_chan->vchan);
>>>> +    dma_pool_destroy(xdma_chan->desc_pool);
>>>> +    xdma_chan->desc_pool = NULL;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_alloc_chan_resources - Allocate channel resources
>>>> + * @chan: DMA channel
>>>> + */
>>>> +static int xdma_alloc_chan_resources(struct dma_chan *chan)
>>>> +{
>>>> +    struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>>>> +    struct xdma_device *xdev = xdma_chan->xdev_hdl;
>>>> +
>>>> +    xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
>>>> +                           xdev->dma_dev.dev,
>>>> +                           XDMA_DESC_BLOCK_SIZE,
>>>> +                           XDMA_DESC_BLOCK_ALIGN,
>>>> +                           0);
>>>> +    if (!xdma_chan->desc_pool) {
>>>> +        xdma_err(xdev, "unable to allocate descriptor pool");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_channel_isr - XDMA channel interrupt handler
>>>> + * @irq: IRQ number
>>>> + * @dev_id: Pointer to the DMA channel structure
>>>> + */
>>>> +static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>>>> +{
>>>> +    struct xdma_chan *xdma_chan = dev_id;
>>>> +    u32 complete_desc_num = 0;
>>>> +    struct virt_dma_desc *vd;
>>>> +    struct xdma_desc *desc;
>>>> +    int ret;
>>>> +
>>>> +    spin_lock(&xdma_chan->vchan.lock);
>>>> +
>>>> +    /* get submitted request */
>>>> +    vd = vchan_next_desc(&xdma_chan->vchan);
>>>> +    if (!vd)
>>>> +        goto out;
>>>> +
>>>> +    xdma_chan->busy = false;
>>>> +    desc = to_xdma_desc(vd);
>>>> +
>>>> +    ret = xdma_read_reg(xdma_chan->xdev_hdl, xdma_chan->base,
>>>> +                XDMA_CHAN_COMPLETED_DESC, &complete_desc_num);
>>>> +    if (ret)
>>>> +        goto out;
>>>> +
>>>> +    desc->completed_desc_num += complete_desc_num;
>>>> +    /*
>>>> +     * if all data blocks are transferred, remove and complete the request
>>>> +     */
>>>> +    if (desc->completed_desc_num == desc->desc_num) {
>>>> +        list_del(&vd->node);
>>>> +        vchan_cookie_complete(vd);
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    if (desc->completed_desc_num > desc->desc_num ||
>>>> +        complete_desc_num != XDMA_DESC_BLOCK_NUM * XDMA_DESC_ADJACENT)
>>>> +        goto out;
>>>> +
>>>> +    /* transfer the rest of data */
>>>> +    xdma_xfer_start(xdma_chan);
>>>> +
>>>> +out:
>>>> +    spin_unlock(&xdma_chan->vchan.lock);
>>>> +    return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_irq_fini - Uninitialize IRQ
>>>> + * @xdev: DMA device pointer
>>>> + */
>>>> +static void xdma_irq_fini(struct xdma_device *xdev)
>>>> +{
>>>> +    int ret, i;
>>>> +
>>>> +    /* disable interrupt */
>>>> +    ret = xdma_disable_intr(xdev);
>>>> +    if (ret)
>>>> +        xdma_err(xdev, "failed to disable interrupts: %d", ret);
>>>> +
>>>> +    /* free irq handler */
>>>> +    for (i = 0; i < xdev->h2c_chan_num; i++)
>>>> +        free_irq(xdev->h2c_chans[i].irq, &xdev->h2c_chans[i]);
>>>> +
>>>> +    for (i = 0; i < xdev->c2h_chan_num; i++)
>>>> +        free_irq(xdev->c2h_chans[i].irq, &xdev->c2h_chans[i]);
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_set_vector_reg - configure hardware IRQ registers
>>>> + * @xdev: DMA device pointer
>>>> + * @vec_tbl_start: Start of IRQ registers
>>>> + * @irq_start: Start of IRQ
>>>> + * @irq_num: Number of IRQ
>>>> + */
>>>> +static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
>>>> +                   u32 irq_start, u32 irq_num)
>>>> +{
>>>> +    u32 shift, i, val = 0;
>>>> +    int ret;
>>>> +
>>>> +    /* Each IRQ register is 32 bit and contains 4 IRQs */
>>>> +    while (irq_num > 0) {
>>>> +        for (i = 0; i < 4; i++) {
>>>> +            shift = XDMA_IRQ_VEC_SHIFT * i;
>>>> +            val |= irq_start << shift;
>>>> +            irq_start++;
>>>> +            irq_num--;
>>>> +        }
>>>> +
>>>> +        /* write IRQ register */
>>>> +        ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, vec_tbl_start, val);
>>>> +        if (ret) {
>>>> +            xdma_err(xdev, "failed to set vector: %d", ret);
>>>> +            return ret;
>>>> +        }
>>>> +        vec_tbl_start += sizeof(u32);
>>>> +        val = 0;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_irq_init - initialize IRQs
>>>> + * @xdev: DMA device pointer
>>>> + */
>>>> +static int xdma_irq_init(struct xdma_device *xdev)
>>>> +{
>>>> +    u32 irq = xdev->irq_start;
>>>> +    int i, j, ret;
>>>> +
>>>> +    /* return failure if there are not enough IRQs */
>>>> +    if (xdev->irq_num < XDMA_CHAN_NUM(xdev)) {
>>>> +        xdma_err(xdev, "not enough irq");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    /* setup H2C interrupt handler */
>>>> +    for (i = 0; i < xdev->h2c_chan_num; i++) {
>>>> +        ret = request_irq(irq, xdma_channel_isr, 0,
>>>> +                  "xdma-h2c-channel", &xdev->h2c_chans[i]);
>>>> +        if (ret) {
>>>> +            xdma_err(xdev, "H2C channel%d request irq%d failed: %d",
>>>> +                 i, irq, ret);
>>>> +            goto failed_init_h2c;
>>>> +        }
>>>> +        xdev->h2c_chans[i].irq = irq;
>>>> +        irq++;
>>>> +    }
>>>> +
>>>> +    /* setup C2H interrupt handler */
>>>> +    for (j = 0; j < xdev->c2h_chan_num; j++) {
>>>> +        ret = request_irq(irq, xdma_channel_isr, 0,
>>>> +                  "xdma-c2h-channel", &xdev->c2h_chans[j]);
>>>> +        if (ret) {
>>>> +            xdma_err(xdev, "H2C channel%d request irq%d failed: %d",
>>>> +                 j, irq, ret);
>>>> +            goto failed_init_c2h;
>>>> +        }
>>>> +        xdev->c2h_chans[j].irq = irq;
>>>> +        irq++;
>>>> +    }
>>>> +
>>>> +    /* config hardware IRQ registers */
>>>> +    ret = xdma_set_vector_reg(xdev, XDMA_IRQ_CHAN_VEC_NUM, 0,
>>>> +                  XDMA_CHAN_NUM(xdev));
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "failed to set channel vectors: %d", ret);
>>>> +        goto failed_init_c2h;
>>>> +    }
>>>> +
>>>> +    /* enable interrupt */
>>>> +    ret = xdma_enable_intr(xdev);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "failed to enable interrupts: %d", ret);
>>>> +        goto failed_init_c2h;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +
>>>> +failed_init_c2h:
>>>> +    while (j--)
>>>> +        free_irq(xdev->c2h_chans[j].irq, &xdev->c2h_chans[j]);
>>>> +failed_init_h2c:
>>>> +    while (i--)
>>>> +        free_irq(xdev->h2c_chans[i].irq, &xdev->h2c_chans[i]);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static bool xdma_filter_fn(struct dma_chan *chan, void *param)
>>>> +{
>>>> +    struct xdma_chan *xdma_chan = to_xdma_chan(chan);
>>>> +    struct xdma_chan_info *chan_info = param;
>>>> +
>>>> +    return chan_info->dir == xdma_chan->dir;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_remove - Driver remove function
>>>> + * @pdev: Pointer to the platform_device structure
>>>> + */
>>>> +static int xdma_remove(struct platform_device *pdev)
>>>> +{
>>>> +    struct xdma_device *xdev = platform_get_drvdata(pdev);
>>>> +
>>>> +    if (xdev->status & XDMA_DEV_STATUS_INIT_MSIX)
>>>> +        xdma_irq_fini(xdev);
>>>> +
>>>> +    if (xdev->status & XDMA_DEV_STATUS_REG_DMA)
>>>> +        dma_async_device_unregister(&xdev->dma_dev);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_probe - Driver probe function
>>>> + * @pdev: Pointer to the platform_device structure
>>>> + */
>>>> +static int xdma_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct xdma_platdata *pdata = dev_get_platdata(&pdev->dev);
>>>> +    struct xdma_device *xdev;
>>>> +    void __iomem *reg_base;
>>>> +    struct resource *res;
>>>> +    int ret = -ENODEV;
>>>> +
>>>> +    if (pdata->max_dma_channels > XDMA_MAX_CHANNELS) {
>>>> +        dev_err(&pdev->dev, "invalid max dma channels %d",
>>>> +            pdata->max_dma_channels);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
>>>> +    if (!xdev)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    platform_set_drvdata(pdev, xdev);
>>>> +    xdev->pdev = pdev;
>>>> +
>>>> +    res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>>> +    if (!res) {
>>>> +        xdma_err(xdev, "failed to get irq resource");
>>>> +        goto failed;
>>>> +    }
>>>> +    xdev->irq_start = res->start;
>>>> +    xdev->irq_num = res->end - res->start + 1;
>>>> +
>>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +    if (!res) {
>>>> +        xdma_err(xdev, "failed to get io resource");
>>>> +        goto failed;
>>>> +    }
>>>> +
>>>> +    reg_base = devm_ioremap_resource(&pdev->dev, res);
>>>> +    if (!reg_base) {
>>>> +        xdma_err(xdev, "ioremap failed");
>>>> +        goto failed;
>>>> +    }
>>>> +
>>>> +    xdev->regmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
>>>> +                         &xdma_regmap_config);
>>>> +    if (!xdev->regmap) {
>>>> +        xdma_err(xdev, "config regmap failed: %d", ret);
>>>> +        goto failed;
>>>> +    }
>>>> +    INIT_LIST_HEAD(&xdev->dma_dev.channels);
>>>> +
>>>> +    ret = xdma_config_channels(xdev, DMA_MEM_TO_DEV);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "config H2C channels failed: %d", ret);
>>>> +        goto failed;
>>>> +    }
>>>> +
>>>> +    ret = xdma_config_channels(xdev, DMA_DEV_TO_MEM);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "config C2H channels failed: %d", ret);
>>>> +        goto failed;
>>>> +    }
>>>> +
>>>> +    dma_cap_set(DMA_SLAVE, xdev->dma_dev.cap_mask);
>>>> +    dma_cap_set(DMA_PRIVATE, xdev->dma_dev.cap_mask);
>>>> +
>>>> +    xdev->dma_dev.dev = &pdev->dev;
>>>> +    xdev->dma_dev.device_free_chan_resources = xdma_free_chan_resources;
>>>> +    xdev->dma_dev.device_alloc_chan_resources = xdma_alloc_chan_resources;
>>>> +    xdev->dma_dev.device_tx_status = dma_cookie_status;
>>>> +    xdev->dma_dev.device_prep_slave_sg = xdma_prep_device_sg;
>>>> +    xdev->dma_dev.device_config = xdma_device_config;
>>>> +    xdev->dma_dev.device_issue_pending = xdma_issue_pending;
>>>> +    xdev->dma_dev.filter.map = pdata->device_map;
>>>> +    xdev->dma_dev.filter.mapcnt = pdata->device_map_cnt;
>>>> +    xdev->dma_dev.filter.fn = xdma_filter_fn;
>>>> +
>>>> +    ret = dma_async_device_register(&xdev->dma_dev);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "failed to register Xilinx XDMA: %d", ret);
>>>> +        goto failed;
>>>> +    }
>>>> +    xdev->status |= XDMA_DEV_STATUS_REG_DMA;
>>>> +
>>>> +    ret = xdma_irq_init(xdev);
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "failed to init msix: %d", ret);
>>>> +        goto failed;
>>>> +    }
>>>> +    xdev->status |= XDMA_DEV_STATUS_INIT_MSIX;
>>>> +
>>>> +    return 0;
>>>> +
>>>> +failed:
>>>> +    xdma_remove(pdev);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static const struct platform_device_id xdma_id_table[] = {
>>>> +    { "xdma", 0},
>>>> +    { },
>>>> +};
>>>> +
>>>> +static struct platform_driver xdma_driver = {
>>>> +    .driver        = {
>>>> +        .name = "xdma",
>>>> +    },
>>>> +    .id_table    = xdma_id_table,
>>>> +    .probe        = xdma_probe,
>>>> +    .remove        = xdma_remove,
>>>> +};
>>>> +
>>>> +module_platform_driver(xdma_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("AMD XDMA driver");
>>>> +MODULE_AUTHOR("XRT Team <runtimeca39d@amd.com>");
>>>> +MODULE_LICENSE("GPL");
>>>> diff --git a/include/linux/platform_data/amd_xdma.h b/include/linux/platform_data/amd_xdma.h
>>>> new file mode 100644
>>>> index 000000000000..b5e23e14bac8
>>>> --- /dev/null
>>>> +++ b/include/linux/platform_data/amd_xdma.h
>>>> @@ -0,0 +1,34 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +/*
>>>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>>>> + */
>>>> +
>>>> +#ifndef _PLATDATA_AMD_XDMA_H
>>>> +#define _PLATDATA_AMD_XDMA_H
>>>> +
>>>> +#include <linux/dmaengine.h>
>>>> +
>>>> +/**
>>>> + * struct xdma_chan_info - DMA channel information
>>>> + *    This information is used to match channel when request dma channel
>>>> + * @dir: Channel transfer direction
>>>> + */
>>>> +struct xdma_chan_info {
>>>> +    enum dma_transfer_direction dir;
>>>> +};
>>>> +
>>>> +#define XDMA_FILTER_PARAM(chan_info)    ((void *)(chan_info))
>>>> +
>>>> +struct dma_slave_map;
>>>> +
>>>> +/**
>>>> + * struct xdma_platdata - platform specific data for XDMA engine
>>>> + * @max_dma_channels: Maximum dma channels in each direction
>>>> + */
>>>> +struct xdma_platdata {
>>>> +    u32 max_dma_channels;
>>>> +    u32 device_map_cnt;
>>>> +    struct dma_slave_map *device_map;
>>>> +};
>>>> +
>>>> +#endif /* _PLATDATA_AMD_XDMA_H */
