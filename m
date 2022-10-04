Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4495E5F4782
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJDQZ3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJDQZU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 12:25:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E3E039;
        Tue,  4 Oct 2022 09:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8IqLpMn8fyCBpAHJ3f5WOx2D5guNddM1WPBSPVed2KOjLXWsd+Wpc1zmlmmpsnJ0sGmZQ0fDMJtFz1HiopKMIO+UEoNd3m9QvLEMg1QfAv/gGr0zLyhz3lHtSNF9DspEpku2nBcH3LOFxRVBYNSnaZpx9L+1osiuQZUDSDx9e0qI8RMYVh3KSWh6ZSPhtMthzcdqQ4ZpAK+hWcs1f5tygO+qAunYN6nYMxBVo5+q0AQ0mPvTlOR/Vk5jhU6/dtx91pYLX4Tr34TT1q4C1nnZ59aWov4ErvDtuTlUoLpxElOaAkSP6pyVSlNanf0zM/8NHsZzADr4jRGXQAFJrqFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjEbiCN8nHPwUUyX/OyK0iU6coXSRk62+Y+6KLVuRP0=;
 b=lZho9Ueo4TlmUmhAV0PuyxtICt+LzEEPTFPArRRsj5IavZSk8z2xqW63+eWr5A9vRGWhS6IaLRupz4prb73PYC8XMhLWlIYgsJseYp3K3B9RoNhFD1A6mFG9a5P14KpFk2fXJ9RG3hN5X3W72A5CtRlcwYYSGTeZ1rz60qIQQWffcPW+kCuL+4FzQ5uzsWnPgrikvNDU/i9rMn61GNtYZ5NCWdAaYmtUhV59oYwBPuVCEWCSGsHq+RmNyTfFPSr5Or/NjTuusTQmC+dpId2oBOuXq0OU3o/Fko2fAyT6/gKTBdRk1JjWOeYT3t3GjLY7pxDr84IOfyHW3rPQANaWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjEbiCN8nHPwUUyX/OyK0iU6coXSRk62+Y+6KLVuRP0=;
 b=Rkd8YvmspDWsj4WEcbSYrZFirwRR07Ufs0PZv3/x+Zz94n23M42P6M/EvcdF6uPjQhxKRzs/wLfJDQ6Mn87gxflGeVlBAUsEDUpx3hU25kXMM7T/IkNUk5JYI26H8Lp/T+/SOcKEHydFS5uiDFqkOdzRFd8WMjeE8W02/2uaB90=
Received: from DM5PR07CA0054.namprd07.prod.outlook.com (2603:10b6:4:ad::19) by
 SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 16:25:12 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::f8) by DM5PR07CA0054.outlook.office365.com
 (2603:10b6:4:ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Tue, 4 Oct 2022 16:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 4 Oct 2022 16:25:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 11:25:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 4 Oct
 2022 11:25:10 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 4 Oct 2022 11:25:09 -0500
Message-ID: <2cb4da1b-bea8-245a-d9b2-ba08ae36ffcf@amd.com>
Date:   Tue, 4 Oct 2022 09:25:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic
 interrupt support
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
References: <1664409507-64079-1-git-send-email-lizhi.hou@amd.com>
 <1664409507-64079-3-git-send-email-lizhi.hou@amd.com>
 <33583d7f-8f8c-64a1-7b93-4e6aebb266a3@gpxsee.org>
 <1836ce13-101f-a863-41ea-bd49c21d4f60@amd.com>
 <daccee4a-ac3c-bfc1-4876-24e6ecf5bcf1@gpxsee.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <daccee4a-ac3c-bfc1-4876-24e6ecf5bcf1@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca536b2-a736-4075-484a-08daa6250322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roRqj8hhrHH6egYqdYlDHbhfl4ttnqX786p+ikTzN+XQFMDUwHdM/15H7ukE1MB1p+OHtIuStVmBoeukc9caLDTy63yk6NdYiQyJZft3iKMalLu8mnWC8z1gQys2dWR3+pQCuhF4kckKjM07G+ZGr+2G4zk5ud61kd4UI6P4VJU6wvA/PA2osVCTXosEyMGS93EHq67MquOQpPYsCTeO5zQJ9kbXgRDtj0pFZIKJd/Or5R7CmI2mWBq+4kIndfljnkofXEp+3uOTz1a+xmaOkNG4pd2RVPQQZKQpIFXPHRPtt0ftoKNDy8FXEy5A+QhxXk7HSFLW91mcDVsF3prdqTH6CpyfZ6eknnHVYVdDYVzv0JagkK65FU8C8DnEYZdz8OlcMQnxeL118WAxJ8gRYca/l3FxdxYO4GyAvCCrECHwzETqSW0XiHPBB88V6oo2NmARX4RVGs+d49aEjM37IIfGIxJx8Q1t7KefWw1dFgVGUmFQBwm8iVMQ6YSKOlVURc4CjFAbp2z69RlzE746dhB7X4sSYfckoSH+qxjj4WEDehC7ZhBQM4WEt5VrmwoY1LpB0YQl5AXUTsXCKuACdoARL0w2ZaJPPHWOKbmQEDK07tNVCAaPt45tS+9LzZwhYblPHMYnGMo4XJeGZaNPWIZH+DMmmMWScpAeBMitAItgKdXjvPyjCCDsWvKwZ8IGf/jWORgXilYJKjUB2JIkmqDZuJVkE4y/Oxc49xRxnU2nETjCjCslH7Q8Ve80rv2K71JPAjH3v6JnOkgbfLx0ffymyzU0/WXfUU8UfNLigv98eeCv0en+yni0ovhGMAQ3oBtHy5DiJ1f8rzkon1YxMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(110136005)(54906003)(8676002)(478600001)(4326008)(70206006)(40460700003)(16576012)(316002)(36756003)(70586007)(426003)(82740400003)(47076005)(66574015)(36860700001)(83380400001)(44832011)(53546011)(31696002)(86362001)(40480700001)(26005)(8936002)(5660300002)(336012)(81166007)(82310400005)(356005)(2906002)(2616005)(186003)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 16:25:12.1831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca536b2-a736-4075-484a-08daa6250322
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/4/22 03:26, Martin Tůma wrote:
>
> On 03. 10. 22 17:52, Lizhi Hou wrote:
>>
>> On 10/3/22 06:59, Martin Tůma wrote:
>>> On 29. 09. 22 1:58, Lizhi Hou wrote:
>>>> The Xilinx DMA/Bridge Subsystem for PCIe (XDMA) provides up to 16 user
>>>> interrupt wires to user logic that generate interrupts to the host.
>>>> This patch adds APIs to enable/disable user logic interrupt for a 
>>>> given
>>>> interrupt wire index.
>>>>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>>>> ---
>>>>   MAINTAINERS                  |  1 +
>>>>   drivers/dma/xilinx/xdma.c    | 65 
>>>> ++++++++++++++++++++++++++++++++++++
>>>>   include/linux/dma/amd_xdma.h | 16 +++++++++
>>>>   3 files changed, 82 insertions(+)
>>>>   create mode 100644 include/linux/dma/amd_xdma.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index c1be0b2e378a..019d84b2b086 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -21691,6 +21691,7 @@ L:    dmaengine@vger.kernel.org
>>>>   S:    Supported
>>>>   F:    drivers/dma/xilinx/xdma-regs.h
>>>>   F:    drivers/dma/xilinx/xdma.c
>>>> +F:    include/linux/dma/amd_xdma.h
>>>>   F:    include/linux/platform_data/amd_xdma.h
>>>>     XILINX ZYNQMP DPDMA DRIVER
>>>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>>>> index 58a57e03bef5..13f627445c4a 100644
>>>> --- a/drivers/dma/xilinx/xdma.c
>>>> +++ b/drivers/dma/xilinx/xdma.c
>>>> @@ -25,6 +25,7 @@
>>>>   #include <linux/dmapool.h>
>>>>   #include <linux/regmap.h>
>>>>   #include <linux/dmaengine.h>
>>>> +#include <linux/dma/amd_xdma.h>
>>>>   #include <linux/platform_device.h>
>>>>   #include <linux/platform_data/amd_xdma.h>
>>>>   #include <linux/dma-mapping.h>
>>>> @@ -736,6 +737,7 @@ static int xdma_set_vector_reg(struct 
>>>> xdma_device *xdev, u32 vec_tbl_start,
>>>>   static int xdma_irq_init(struct xdma_device *xdev)
>>>>   {
>>>>       u32 irq = xdev->irq_start;
>>>> +    u32 user_irq_start;
>>>>       int i, j, ret;
>>>>         /* return failure if there are not enough IRQs */
>>>> @@ -786,6 +788,18 @@ static int xdma_irq_init(struct xdma_device 
>>>> *xdev)
>>>>           goto failed;
>>>>       }
>>>>   +    /* config user IRQ registers if needed */
>>>> +    user_irq_start = xdev->h2c_chan_num + xdev->c2h_chan_num;
>>>> +    if (xdev->irq_num > user_irq_start) {
>>>> +        ret = xdma_set_vector_reg(xdev, XDMA_IRQ_USER_VEC_NUM,
>>>> +                      user_irq_start,
>>>> +                      xdev->irq_num - user_irq_start);
>>>> +        if (ret) {
>>>> +            xdma_err(xdev, "failed to set user vectors: %d", ret);
>>>> +            goto failed;
>>>> +        }
>>>> +    }
>>>> +
>>>>       /* enable interrupt */
>>>>       ret = xdma_enable_intr(xdev);
>>>>       if (ret) {
>>>> @@ -816,6 +830,57 @@ static bool xdma_filter_fn(struct dma_chan 
>>>> *chan, void *param)
>>>>       return true;
>>>>   }
>>>>   +/**
>>>> + * xdma_disable_user_irq - Disable user interrupt
>>>> + * @pdev: Pointer to the platform_device structure
>>>> + * @user_irq_index: User IRQ index
>>>> + */
>>>> +void xdma_disable_user_irq(struct platform_device *pdev, u32 
>>>> user_irq_index)
>>>> +{
>>>> +    struct xdma_device *xdev = platform_get_drvdata(pdev);
>>>> +
>>>> +    if (xdev->h2c_chan_num + xdev->c2h_chan_num + user_irq_index >=
>>>> +        xdev->irq_num) {
>>>> +        xdma_err(xdev, "invalid user irq index");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
>>>> +               (1 << user_irq_index));
>>>> +}
>>>> +EXPORT_SYMBOL(xdma_disable_user_irq);
>>>> +
>>>> +/**
>>>> + * xdma_enable_user_irq - Enable user logic interrupt
>>>> + * @pdev: Pointer to the platform_device structure
>>>> + * @user_irq_index: User logic IRQ wire index
>>>> + * @irq: Pointer to returning system IRQ number
>>>> + */
>>>> +int xdma_enable_user_irq(struct platform_device *pdev, u32 
>>>> user_irq_index,
>>>> +             u32 *irq)
>>>> +{
>>>> +    struct xdma_device *xdev = platform_get_drvdata(pdev);
>>>> +    u32 user_irq;
>>>> +    int ret;
>>>> +
>>>> +    user_irq = xdev->h2c_chan_num + xdev->c2h_chan_num + 
>>>> user_irq_index;
>>>> +    if (user_irq >= xdev->irq_num) {
>>>> +        xdma_err(xdev, "invalid user irq index");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, 
>>>> XDMA_IRQ_USER_INT_EN_W1S,
>>>> +                 (1 << user_irq_index));
>>>> +    if (ret) {
>>>> +        xdma_err(xdev, "set user irq mask failed, %d", ret);
>>>> +        return ret;
>>>> +    }
>>>> +    *irq = user_irq + xdev->irq_start;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +EXPORT_SYMBOL(xdma_enable_user_irq);
>>>> +
>>>>   /**
>>>>    * xdma_remove - Driver remove function
>>>>    * @pdev: Pointer to the platform_device structure
>>>> diff --git a/include/linux/dma/amd_xdma.h 
>>>> b/include/linux/dma/amd_xdma.h
>>>> new file mode 100644
>>>> index 000000000000..91fb02ff93a7
>>>> --- /dev/null
>>>> +++ b/include/linux/dma/amd_xdma.h
>>>> @@ -0,0 +1,16 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +/*
>>>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>>>> + */
>>>> +
>>>> +#ifndef _DMAENGINE_AMD_XDMA_H
>>>> +#define _DMAENGINE_AMD_XDMA_H
>>>> +
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +int xdma_enable_user_irq(struct platform_device *pdev, u32 
>>>> user_irq_index,
>>>> +             u32 *irq);
>>>> +void xdma_disable_user_irq(struct platform_device *pdev, u32 
>>>> user_irq_index);
>>>> +
>>>> +#endif /* _DMAENGINE_AMD_XDMA_H */
>>>
>>> Hi,
>>> While rewriting our V4L2 driver to use your XDMA driver, I realized, 
>>> that the API for the user interrupts is still not fully usable. If
>>> the expected outcome is that the "parent" driver using the xdma 
>>> driver knows nothing about the IRQ allocation in XDMA, then the 
>>> xdma_enable_user_irq() function must be split into two separate 
>>> functions:
>>>
>>> int xdma_enable_user_irq(struct platform_device *pdev, u32 
>>> user_irq_index)
>>>
>>> and
>>>
>>> int xdma_get_system_irq(u32 user_irq_index)
>>>
>>> that returns the system IRQ number for the given user_irq_index.
>>> Because without it you can not get the system IRQ number without 
>>> enabling the irq at the same time which is usually not what you want.
>>
>> Is this because the user logic you are using does not have 
>> disable/enable interrupt by itself?  I thought that the user logic IP 
>> would have its own register to enable/disable interrupt.
>>
> Yes. Our HW has no "own" registers to disable the IRQs. As such 
> registers are already there in XDMA, there was no need for them.
>
>
>> And xdma_enable_user_irq() will only be called once for creating the 
>> user logic platform device. Then, user logic IP driver would use its 
>> own register to control interrupts. The existing platform driver does 
>> not call any xdma_* to control interrupt.
>>
> As you can see, there is HW that was designed to use the XDMA 
> registers during normal operation and separate enable/disable and irq 
> mapping functions are required. Maybe it is not the best HW design, 
> but it can evidently happen and then the driver author is screwed with 
> the merged API.

Ok. To support this case, I will separate the API as you mentioned.


Thanks,

Lizhi

>
> M.
>
>>
>> Thanks,
>>
>> Lizhi
>>
>>>
>>> As a workaround, you can compute the system IRQ yourself with the 
>>> knowledge of the XDMA internals (this is what I have to do at the 
>>> moment in our driver), but then the "u32 *irq" parameter becomes 
>>> useless and can be removed anyway.
>>>
>>> M.
