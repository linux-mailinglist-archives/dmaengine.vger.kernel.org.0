Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC85F32EB
	for <lists+dmaengine@lfdr.de>; Mon,  3 Oct 2022 17:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJCPxA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Oct 2022 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJCPw7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Oct 2022 11:52:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888C255AB;
        Mon,  3 Oct 2022 08:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZdoGZNvMtBwHbiE8Q5eVHGgfS7wP+Y/XrlGG73cXEHPNI303rUVghBp6PX34qo78MDK/b3GJNqwMOwmyHJ2lKelyKkIBlG3mvmbHdCGXKMR2FWSBhszUxcNTyVEOdOacYt1cglE7bN/CWucCZFyKFHKAp+VNc4ziRsCZENoMGFq3ffeUedkQXudGdSqPl6FwwtkGWdyDkP6/vPdqgnLJhFKzOi4L0sHg2MIFeeXCokyast2I6mQB/tr2Jt1OGCnm3kLDslPN5JFIQbGRnUboEDW81FaGun4uiAmRSbFkHw6leTnNedP1VP50AxFZzr3MAtdoTXfnWCLiRNm5eUZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOR8Xyiy854ypU6Nk00hSX+jXzP4B/znLsGk+XdYNQM=;
 b=j9SjrpkoTTtvgE8LJuEdys6e4TIdYR721n0VXmF0lTng4tvCYBxVEPKjCtwYqZ+NWLbZM0WOoMNfiDWsFkSlpeukJWaoeinjDApLYxatNtFDQ/o0c7TxKENVFONObb3egwmRPSxK99AOKVnPpRrH9gQyczvnfBm32cA7BPEWwn5Z0brIi9cxerXKwFIPoOd6NJT/As9gixTK3bo1rhKia7u5lxL87AWZDoG3FWpOLs0hghyPSUpfvRSXF0HYMaaDiL0RXGlHTv8HuBJURMKUkiAlOOPa5rQui17QJ7UgBwKxsA2AhQ1QKClGoWoORQ2BToAMXMXU4nPy2d/y+mEAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOR8Xyiy854ypU6Nk00hSX+jXzP4B/znLsGk+XdYNQM=;
 b=sGMauQYkUkm3d8jo9fAEQ/PXlbIPpdFyeRRSur3HsfmzH36z7WuEAoGkTNFdIfTLLIhnOqgMbC9nVjmHPkMt4kTNEokczcL94CFne0MJdWXHCvAw4LG6+GPxBHLAZWLiZtXOW0qGDuodKKp9/PZAm7QZI5ickbeKd/qwCNx/o+c=
Received: from BN0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:408:141::28)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 3 Oct
 2022 15:52:55 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::62) by BN0PR07CA0025.outlook.office365.com
 (2603:10b6:408:141::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Mon, 3 Oct 2022 15:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Mon, 3 Oct 2022 15:52:54 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 3 Oct
 2022 10:52:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 3 Oct
 2022 08:52:46 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 3 Oct 2022 10:52:45 -0500
Message-ID: <1836ce13-101f-a863-41ea-bd49c21d4f60@amd.com>
Date:   Mon, 3 Oct 2022 08:52:45 -0700
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
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <33583d7f-8f8c-64a1-7b93-4e6aebb266a3@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9389f6-eb31-4e50-bfb6-08daa557561a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+RlFPNzgWqF8XjMteQmmpfVIkOl8Xclb3MhiTDrTOqD6J4Vi6ni+DKq+5A+cyn/xlBnrz9Qp6H1Sqd5Ua/hwu1ra80vHwSnc4m6kD+ZaQX1sSrXwH91U/oNLElDE8cXWRlYjij8bjdFGV5udSKlEjTfupa1cyIg43WpLmo3JadeMH24GNgIHMJ+sI8d2R2f1MzoYKoivrpQth9SPR3YsDvBAqsx4d51CRDJYTKnZGSdErR8eqpDAVYxKKvqRoyu7LORBpkNVP272kP7GZQ+T2LwvE5pBtwipp62F5nr5FqqfmKEL+SQlwZdLdcT3mc2IGFkWFMq39DOUyftruuVs6swwzIVo22I1NDeSYdoXW/Es4mqbtggo/AyDnOy589/lgHtm+r4qyKtgbhC7zNiPGWCoZ9pTpJf1k0fveRr8f6Dcn7W1XYWb21HT5zp62+Y04wLhp6oJhMGUUSr38fd/xL0g6wxQkLNddjm3RxupLygmnQEW/WI1CU7g4Bmlm0a0y5q0vQdD2O2+pgGr/6l+xD2xm8cs+Waj4EVKLH4YpEWmO7qV1Q5+c9bvq7VSJaGqtZMjt14+6HAcyLbUw7u0nkAx2ZyOfRR32A35DU/FVdLhJ12f4ZhW8//ZxBiP0LudzyAIpFxG5aVHnrIlPmRGor9ewMA5v6oi3bhF+ocUM6RwMqXQW8A+LZ9S5h/0LFdgSytqZV/DfJgghfWywjydZZZeyEI/7h/q6w1s+WY6LlrJ6wvGo/RvKWznZ7aY+wSpgRmwFGnwRFd1IlBajwbqIOPrpBx3zoarXK8lJKtEfFsHftM0Go+TDm7G2KLPMtEHHXInM9TBTiYn87BHTU77A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(26005)(2616005)(53546011)(31686004)(31696002)(110136005)(40460700003)(54906003)(8676002)(36756003)(4326008)(16576012)(316002)(82740400003)(40480700001)(86362001)(81166007)(36860700001)(82310400005)(186003)(478600001)(336012)(83380400001)(356005)(5660300002)(66574015)(2906002)(44832011)(426003)(70586007)(41300700001)(70206006)(47076005)(8936002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 15:52:54.9021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9389f6-eb31-4e50-bfb6-08daa557561a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/3/22 06:59, Martin Tůma wrote:
> On 29. 09. 22 1:58, Lizhi Hou wrote:
>> The Xilinx DMA/Bridge Subsystem for PCIe (XDMA) provides up to 16 user
>> interrupt wires to user logic that generate interrupts to the host.
>> This patch adds APIs to enable/disable user logic interrupt for a given
>> interrupt wire index.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>> ---
>>   MAINTAINERS                  |  1 +
>>   drivers/dma/xilinx/xdma.c    | 65 ++++++++++++++++++++++++++++++++++++
>>   include/linux/dma/amd_xdma.h | 16 +++++++++
>>   3 files changed, 82 insertions(+)
>>   create mode 100644 include/linux/dma/amd_xdma.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c1be0b2e378a..019d84b2b086 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21691,6 +21691,7 @@ L:    dmaengine@vger.kernel.org
>>   S:    Supported
>>   F:    drivers/dma/xilinx/xdma-regs.h
>>   F:    drivers/dma/xilinx/xdma.c
>> +F:    include/linux/dma/amd_xdma.h
>>   F:    include/linux/platform_data/amd_xdma.h
>>     XILINX ZYNQMP DPDMA DRIVER
>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>> index 58a57e03bef5..13f627445c4a 100644
>> --- a/drivers/dma/xilinx/xdma.c
>> +++ b/drivers/dma/xilinx/xdma.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/dmapool.h>
>>   #include <linux/regmap.h>
>>   #include <linux/dmaengine.h>
>> +#include <linux/dma/amd_xdma.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/platform_data/amd_xdma.h>
>>   #include <linux/dma-mapping.h>
>> @@ -736,6 +737,7 @@ static int xdma_set_vector_reg(struct xdma_device 
>> *xdev, u32 vec_tbl_start,
>>   static int xdma_irq_init(struct xdma_device *xdev)
>>   {
>>       u32 irq = xdev->irq_start;
>> +    u32 user_irq_start;
>>       int i, j, ret;
>>         /* return failure if there are not enough IRQs */
>> @@ -786,6 +788,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
>>           goto failed;
>>       }
>>   +    /* config user IRQ registers if needed */
>> +    user_irq_start = xdev->h2c_chan_num + xdev->c2h_chan_num;
>> +    if (xdev->irq_num > user_irq_start) {
>> +        ret = xdma_set_vector_reg(xdev, XDMA_IRQ_USER_VEC_NUM,
>> +                      user_irq_start,
>> +                      xdev->irq_num - user_irq_start);
>> +        if (ret) {
>> +            xdma_err(xdev, "failed to set user vectors: %d", ret);
>> +            goto failed;
>> +        }
>> +    }
>> +
>>       /* enable interrupt */
>>       ret = xdma_enable_intr(xdev);
>>       if (ret) {
>> @@ -816,6 +830,57 @@ static bool xdma_filter_fn(struct dma_chan 
>> *chan, void *param)
>>       return true;
>>   }
>>   +/**
>> + * xdma_disable_user_irq - Disable user interrupt
>> + * @pdev: Pointer to the platform_device structure
>> + * @user_irq_index: User IRQ index
>> + */
>> +void xdma_disable_user_irq(struct platform_device *pdev, u32 
>> user_irq_index)
>> +{
>> +    struct xdma_device *xdev = platform_get_drvdata(pdev);
>> +
>> +    if (xdev->h2c_chan_num + xdev->c2h_chan_num + user_irq_index >=
>> +        xdev->irq_num) {
>> +        xdma_err(xdev, "invalid user irq index");
>> +        return;
>> +    }
>> +
>> +    xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
>> +               (1 << user_irq_index));
>> +}
>> +EXPORT_SYMBOL(xdma_disable_user_irq);
>> +
>> +/**
>> + * xdma_enable_user_irq - Enable user logic interrupt
>> + * @pdev: Pointer to the platform_device structure
>> + * @user_irq_index: User logic IRQ wire index
>> + * @irq: Pointer to returning system IRQ number
>> + */
>> +int xdma_enable_user_irq(struct platform_device *pdev, u32 
>> user_irq_index,
>> +             u32 *irq)
>> +{
>> +    struct xdma_device *xdev = platform_get_drvdata(pdev);
>> +    u32 user_irq;
>> +    int ret;
>> +
>> +    user_irq = xdev->h2c_chan_num + xdev->c2h_chan_num + 
>> user_irq_index;
>> +    if (user_irq >= xdev->irq_num) {
>> +        xdma_err(xdev, "invalid user irq index");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1S,
>> +                 (1 << user_irq_index));
>> +    if (ret) {
>> +        xdma_err(xdev, "set user irq mask failed, %d", ret);
>> +        return ret;
>> +    }
>> +    *irq = user_irq + xdev->irq_start;
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(xdma_enable_user_irq);
>> +
>>   /**
>>    * xdma_remove - Driver remove function
>>    * @pdev: Pointer to the platform_device structure
>> diff --git a/include/linux/dma/amd_xdma.h b/include/linux/dma/amd_xdma.h
>> new file mode 100644
>> index 000000000000..91fb02ff93a7
>> --- /dev/null
>> +++ b/include/linux/dma/amd_xdma.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#ifndef _DMAENGINE_AMD_XDMA_H
>> +#define _DMAENGINE_AMD_XDMA_H
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +
>> +int xdma_enable_user_irq(struct platform_device *pdev, u32 
>> user_irq_index,
>> +             u32 *irq);
>> +void xdma_disable_user_irq(struct platform_device *pdev, u32 
>> user_irq_index);
>> +
>> +#endif /* _DMAENGINE_AMD_XDMA_H */
>
> Hi,
> While rewriting our V4L2 driver to use your XDMA driver, I realized, 
> that the API for the user interrupts is still not fully usable. If
> the expected outcome is that the "parent" driver using the xdma driver 
> knows nothing about the IRQ allocation in XDMA, then the 
> xdma_enable_user_irq() function must be split into two separate 
> functions:
>
> int xdma_enable_user_irq(struct platform_device *pdev, u32 
> user_irq_index)
>
> and
>
> int xdma_get_system_irq(u32 user_irq_index)
>
> that returns the system IRQ number for the given user_irq_index.
> Because without it you can not get the system IRQ number without 
> enabling the irq at the same time which is usually not what you want.

Is this because the user logic you are using does not have 
disable/enable interrupt by itself?  I thought that the user logic IP 
would have its own register to enable/disable interrupt.

And xdma_enable_user_irq() will only be called once for creating the 
user logic platform device. Then, user logic IP driver would use its own 
register to control interrupts. The existing platform driver does not 
call any xdma_* to control interrupt.


Thanks,

Lizhi

>
> As a workaround, you can compute the system IRQ yourself with the 
> knowledge of the XDMA internals (this is what I have to do at the 
> moment in our driver), but then the "u32 *irq" parameter becomes 
> useless and can be removed anyway.
>
> M.
