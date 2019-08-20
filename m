Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63DF95DCD
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 13:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfHTLts (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 07:49:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728283AbfHTLts (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 07:49:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D0C39179BBA873435022;
        Tue, 20 Aug 2019 19:49:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 20 Aug 2019
 19:49:40 +0800
Subject: Re: [PATCH v2 linux-next 0/2] change mux_configure32() to static
To:     Vinod Koul <vkoul@kernel.org>
References: <20190814072105.144107-1-maowenan@huawei.com>
 <20190820114105.GW12733@vkoul-mobl.Dlink>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <bdd606cb-535f-c153-d51f-4571db2d23dc@huawei.com>
Date:   Tue, 20 Aug 2019 19:48:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190820114105.GW12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019/8/20 19:41, Vinod Koul wrote:
> On 14-08-19, 15:21, Mao Wenan wrote:
>> First patch is to make mux_configure32() static to avoid sparse warning,
>> the second patch is to chage alignment of two functions.
> 
> The subsystem name is "dmaengine" please use that in future, I have
> fixed that and applied

Okay, thanks.

> 
>> v2: change subject from "drivers: dma: Fix sparse warning for mux_configure32"
>> to "drivers: dma: make mux_configure32 static", and cleanup the log. And add 
>> one patch to change alignment of two functions. 
>>
>> Mao Wenan (2):
>>   drivers: dma: make mux_configure32 static
>>   drivers: dma: change alignment of mux_configure32 and
>>     fsl_edma_chan_mux
>>
>>  drivers/dma/fsl-edma-common.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> -- 
>> 2.20.1
> 

