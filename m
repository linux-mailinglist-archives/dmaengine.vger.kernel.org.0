Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8B672144
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjARP3I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 10:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjARP2q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 10:28:46 -0500
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2081346141;
        Wed, 18 Jan 2023 07:28:14 -0800 (PST)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id A15943758A;
        Wed, 18 Jan 2023 16:28:13 +0100 (CET)
Message-ID: <85d1e660-1df4-6e84-a329-751197ef7eec@gpxsee.org>
Date:   Wed, 18 Jan 2023 16:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH V11 XDMA 2/2] dmaengine: xilinx: xdma: Add user
 logic interrupt support
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1673988842-43631-1-git-send-email-lizhi.hou@amd.com>
 <1673988842-43631-3-git-send-email-lizhi.hou@amd.com>
 <Y8eRz2sXrnCtSib+@matsya>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <Y8eRz2sXrnCtSib+@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
>> +int xdma_enable_user_irq(struct platform_device *pdev, u32 irq_num);
>> +void xdma_disable_user_irq(struct platform_device *pdev, u32 irq_num);
>> +int xdma_get_user_irq(struct platform_device *pdev, u32 user_irq_index);
> 
> who is the user of these APIs? It is not clear to me how this is to be
> used...
> 

The APIs are used by the PCIe card devices/drivers that use XDMA. 
Without them the "user IRQs" provided by the XDMA HW can not be used by 
the PCIe card drivers. If you look at the XDMA HW overview:
https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Overview?tocId=O_EMX26J5IsdubL4i3XJ_w
those APIs control the "IRQ module" block.

For a linux driver using them see the mgb4 v4l2 driver:
https://patchwork.kernel.org/project/linux-media/patch/20230113172636.2590-2-tumic@gpxsee.org/

M.
