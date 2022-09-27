Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D966A5EC980
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 18:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiI0Q36 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI0Q3d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 12:29:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F301D6D1B;
        Tue, 27 Sep 2022 09:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq+hro/skRkHTQbUMpzEnNjWGdrpgXP+iujpzhOb1s4AUN/bhKRFuFLRafhnou54VcDnw2hnV6Y1SnN1bBv3wuwAsVOjrs5yZv2LpEGGaBSSr21DXN9GIcxp31BvI8MIj51w6nJQ0bmxb3hE3gKw6W2HfWIeVKYG8FLujopTyN/h8ZbLAPwGiCQ2dmrNHrncetwJw8nod9/uE7V1MtxTm484TzaQfyQ8w51cu5hdlcjUPj79nfEZYGNBI9HpRsRjxzhJoT4aK1BrHJt3YoaRjv1tzj/qxRins0ay2Y/Wk39/B6WmKpSQQfn0nuTAmP8X2a4/BZXQZUBHW259ouXmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDAn9LZGuOSje8pWxfAJweS3MRFC1oMQc+X6qo8eVNE=;
 b=O3JNPXpJ5V5gDVCV0czHcqmw5d9lpSlJB2XPjiHacgzoTVdlf9e93KQBjEK1LUCLRNQGaI/s8258M6+nqcT0GHQUAELdVAE/Ef2dxz22LpjeuRClCepfGtLsre70ADM8bTHHi0lvP74Lt/reIxg30j6Cxsnt1Qz2MoJFX6reRnIkqGV+0E4qcmC7zWcUhx39nK+bTEb+A2vtdv6CpdhM0B+8DgI1B6CvPT8adR2Re14uMP6Cf6xKyrCsYqv/Jbh8RmQ2yQZXDlboEgEGjqcFxm5CVQbVqXdwwh2K5xhkuiCtdnyUU5zYC/D2E7ARBC+xSxKDqmkF8BHIJDbmg/dF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDAn9LZGuOSje8pWxfAJweS3MRFC1oMQc+X6qo8eVNE=;
 b=VllKOquU86tYPBsu0AVJTx9jaxftENwWRibeFJmSuTrWNWaNhP2tbrULCG5+d5mmwEfs9KtbX5++zZBPFOzQUoLrsyP8yzJPQOS4hOYbK4m5E3Q9OZSPpnqGVcJXAyQ+iyilmDQqojQbc7kqJt+MRxBC0P6jENRfX1KmteYVe3w=
Received: from MW4PR03CA0228.namprd03.prod.outlook.com (2603:10b6:303:b9::23)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 16:28:42 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::b0) by MW4PR03CA0228.outlook.office365.com
 (2603:10b6:303:b9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 16:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 16:28:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 11:28:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 11:28:40 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 27 Sep 2022 11:28:39 -0500
Message-ID: <64388266-1707-ee20-c3ab-edb67ada68dc@amd.com>
Date:   Tue, 27 Sep 2022 09:28:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic
 interrupt support
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
References: <1663871905-60498-1-git-send-email-lizhi.hou@amd.com>
 <1663871905-60498-3-git-send-email-lizhi.hou@amd.com>
 <a2b5c35d-ced2-ff83-c550-4bbf29973b80@gpxsee.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <a2b5c35d-ced2-ff83-c550-4bbf29973b80@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 56115458-ce1a-4d5c-b791-08daa0a556f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3BhxbugApQKX6jYZjWaXrG0eNDiR84vkk9PiqWLraPwUrIq87D1NcCcxCoUO2jwJESFJU/cQDIcShjp1OKOp5qhcqZEn0WwSTYV/8/icZOJvO4R0nELErk3pB8QKUISa8L6K7rL1WOa72EXwBX7j5yECoJZSv27Wl2DEfRGoX0psH881eetsoXEC2uRgb6DNn9SfcKJrRhfrz/AJQaTAdDOfObhG+qaM91Rpn83vJH/qI6CkIBttsQ95FAaf/vorVlC3gUJd+jpxsZQXnI7jJ4qL6LwTWS2J6GqHUVhtoABPrkTxC0ZBVe+ivwv5+JnGGoAO0hGVTL8zfHRwwT3y2+yipkunEiVSByIrOx1Hz2kv0oSkTMXtXcJeWyILi/9xRUX1+vkMYS9PeB+9uiQ+zcteyQeTHqWQSZdWfuwNYO8lT9lyxpVhHfQZyqjNfm4AwEz1tCaHRNo/zDG2IcDkoQBZDSHkydhpcFJ/tO8NkRitmcLSvuUeLawHO9h12D6aSZ91pQJoaNo+jMhKomLVzvQqzsHGi6HLMbdbmX3nepATnlHUu8Cb0CagSLU4yQJb32vzE+Cb0Hwnbl/KFHXl9rp2jowmdwyR774W0cyDXp6PamFiIsM26JWFExqM1muszs2SCq+t7LrrF0ZVTWU5iKi+mkEfbQ0jtN4cSY8YRMIhm/mVNQkS0aRpMh9/1BwYOkM0GkBnO2IGn4fxKjsXQ1nD6a6ktc3Rx7HO+ihYqjH5BAEFEhOyY/BK61y1BsrBjitd7uFUdobxMlqTGXuNjzRsPBytupZhIQAse99aQIo3GwPcoaJArCmhkiU7ykKXxeySZcaPDqA/oR8KwBJ3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(336012)(356005)(82740400003)(186003)(426003)(2616005)(66574015)(31696002)(81166007)(40480700001)(86362001)(83380400001)(47076005)(36860700001)(5660300002)(70206006)(70586007)(44832011)(41300700001)(4326008)(8676002)(82310400005)(2906002)(26005)(16576012)(40460700003)(53546011)(8936002)(316002)(110136005)(54906003)(478600001)(36756003)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 16:28:41.3397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56115458-ce1a-4d5c-b791-08daa0a556f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/27/22 08:31, Martin Tůma wrote:
> On 22. 09. 22 20:38, Lizhi Hou wrote:
>> The Xilinx DMA/Bridge Subsystem for PCIe (XDMA) provides up to 16 user
>> interrupt wires to user logic that generate interrupts to the host.
>> This patch adds APIs to register/unregister interrupt handler for a 
>> given
>> interrupt wire index.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>> ---
>>   MAINTAINERS                  |  1 +
>>   drivers/dma/xilinx/xdma.c    | 80 ++++++++++++++++++++++++++++++++++++
>>   include/linux/dma/amd_xdma.h | 17 ++++++++
>>   3 files changed, 98 insertions(+)
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
>> index 58a57e03bef5..884942cd2a37 100644
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
>> @@ -816,6 +830,72 @@ static bool xdma_filter_fn(struct dma_chan 
>> *chan, void *param)
>>       return true;
>>   }
>>   +/**
>> + * xdma_free_user_irq - Free user interrupt
>> + * @pdev: Pointer to the platform_device structure
>> + * @user_irq_index: User IRQ index
>> + * @arg: User interrupt cookie
>> + */
>> +void xdma_free_user_irq(struct platform_device *pdev, u32 
>> user_irq_index,
>> +            void *arg)
>> +{
>> +    struct xdma_device *xdev = platform_get_drvdata(pdev);
>> +    u32 user_irq;
>> +
>> +    user_irq = xdev->h2c_chan_num + xdev->c2h_chan_num + 
>> user_irq_index;
>> +    if (user_irq >= xdev->irq_num) {
>> +        xdma_err(xdev, "invalid user irq index");
>> +        return;
>> +    }
>> +    user_irq += xdev->irq_start;
>> +
>> +    xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
>> +               (1 << user_irq_index));
>> +
>> +    free_irq(user_irq, arg);
>> +}
>> +EXPORT_SYMBOL(xdma_free_user_irq);
>> +
>> +/**
>> + * xdma_request_user_irq - Register user interrupt
>> + * @pdev: Pointer to the platform_device structure
>> + * @user_irq_index: User IRQ index
>> + * @flags: Handling flags
>> + * @handler: User interrupt handler
>> + * @arg: User interrupt cookie
>> + */
>> +int xdma_request_user_irq(struct platform_device *pdev, u32 
>> user_irq_index,
>> +              irq_handler_t handler, void *arg, ulong flags)
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
>> +    user_irq += xdev->irq_start;
>> +
>> +    ret = request_irq(user_irq, handler, flags, "xdma-user", arg);
>> +    if (ret) {
>> +        xdma_err(xdev, "request irq failed, %d", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1S,
>> +                 (1 << user_irq_index));
>> +    if (ret) {
>> +        xdma_err(xdev, "set user irq mask failed, %d", ret);
>> +        free_irq(user_irq, arg);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(xdma_request_user_irq);
>> +
>>   /**
>>    * xdma_remove - Driver remove function
>>    * @pdev: Pointer to the platform_device structure
>> diff --git a/include/linux/dma/amd_xdma.h b/include/linux/dma/amd_xdma.h
>> new file mode 100644
>> index 000000000000..b70486121ca6
>> --- /dev/null
>> +++ b/include/linux/dma/amd_xdma.h
>> @@ -0,0 +1,17 @@
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
>> +int xdma_request_user_irq(struct platform_device *pdev, u32 
>> user_irq_index,
>> +              irq_handler_t handler, void *arg, ulong flags);
>> +void xdma_free_user_irq(struct platform_device *pdev, u32 
>> user_irq_index,
>> +            void *arg);
>> +
>> +#endif /* _DMAENGINE_AMD_XDMA_H */
>
> Hi,
> The user IRQ logic is unusable, if you have other IP cores with linux 
> drivers (eg. spi or i2c) connected to that IRQs like we (and many 
> other users as well) have on our PCIe card. You can't use the already 
> existing
> xiic or xilinx-spi drivers with your xdma driver!
>
> You must split the "IRQ enable" and "IRQ request" operations for your 
> driver to be usable with the other platform drivers in linux. Instead of
> "xdma_request_user_irq" there must be something like 
> "xdma_enable_user_irq" that only enables the IRQ in the IP block, but 
> does not "eat" the IRQ so you can pass it to the initialization of
> the platform driver of xiic or xilinx-spi.
>
> M.

Okay, I got the point. How about changing request/remove APIs to 
enable/disable APIs as below

      xdma_enable_user_irq(struct platform_device *pdev, u32 
user_irq_index, u32 *irq)

             user_irq_index: user logic interrupt wire index. (XDMA 
driver determines how system IRQs are mapped to DMA channels and user 
logic wires)

             irq: IRQ number returned for registering interrupt handler 
(request_irq()) or passing to existing platform driver.

     xdma_disable_user_irq(struct platform_device *pdev, u32 user_irq_index)

Does this make sense to you?


Thanks,

Lizhi

