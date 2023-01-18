Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA367224D
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 17:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjARQBa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 11:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjARP7q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 10:59:46 -0500
X-Greylist: delayed 1370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 07:56:37 PST
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FEE3028E;
        Wed, 18 Jan 2023 07:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=RvRO3J57DG+qNWkdApkxviSN6J7YqPU//nc76wBkQ6c=; b=bM0jdSJ7CSTTIKJr+AoLxDvLVt
        4Rmmy9tKtLbUvrTpqXdeaIBEnWbnXJAvMgobXiWZ+woDVv9yFnGL5JyJxNczL2toCYqQ/aKwr9cep
        GAi81EOASbAzuvHFHbXPzbsz0ytRs22nd80Nrqi4x7rGASw81qwCJx9fUjvGz5wCPc9zNxINAcQ2g
        CD0NoDYzw/KONx9yTYKI/K7pGOzAUCzbJS8O14QwV1453w+WYZuUyw3NYObCqoIsefEEwpc/ewlxX
        35C6P7i28fg0SkS3LRqub5RgL0LZJHElVO2P8BGzjk5+f44EIr8yqCDH6BPmloWGisf6/aEl7EhEy
        evjtzBxg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pIARd-0005Mz-HI; Wed, 18 Jan 2023 16:33:45 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pIARd-000Jx0-3K; Wed, 18 Jan 2023 16:33:45 +0100
Message-ID: <483c7088-1ac1-6924-9cfb-a131e82276ee@metafoo.de>
Date:   Wed, 18 Jan 2023 07:33:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RESEND PATCH V11 XDMA 2/2] dmaengine: xilinx: xdma: Add user
 logic interrupt support
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        Vinod Koul <vkoul@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1673988842-43631-1-git-send-email-lizhi.hou@amd.com>
 <1673988842-43631-3-git-send-email-lizhi.hou@amd.com>
 <Y8eRz2sXrnCtSib+@matsya> <85d1e660-1df4-6e84-a329-751197ef7eec@gpxsee.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <85d1e660-1df4-6e84-a329-751197ef7eec@gpxsee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26785/Wed Jan 18 09:42:40 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 1/18/23 07:28, Martin Tůma wrote:
>>> +++ b/include/linux/dma/amd_xdma.h
>>> @@ -0,0 +1,16 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>>> + */
>>> +
>>> +#ifndef _DMAENGINE_AMD_XDMA_H
>>> +#define _DMAENGINE_AMD_XDMA_H
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +int xdma_enable_user_irq(struct platform_device *pdev, u32 irq_num);
>>> +void xdma_disable_user_irq(struct platform_device *pdev, u32 irq_num);
>>> +int xdma_get_user_irq(struct platform_device *pdev, u32 
>>> user_irq_index);
>>
>> who is the user of these APIs? It is not clear to me how this is to be
>> used...
>>
>
> The APIs are used by the PCIe card devices/drivers that use XDMA. 
> Without them the "user IRQs" provided by the XDMA HW can not be used 
> by the PCIe card drivers. If you look at the XDMA HW overview:
> https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Overview?tocId=O_EMX26J5IsdubL4i3XJ_w 
>
> those APIs control the "IRQ module" block.
>
> For a linux driver using them see the mgb4 v4l2 driver:
> https://patchwork.kernel.org/project/linux-media/patch/20230113172636.2590-2-tumic@gpxsee.org/ 


Rather than custom functions this should probably be integrated with the 
generic IRQ framework registering a IRQ chip that provides IRQs that can 
be requested by the consumer.

