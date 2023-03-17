Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916006BE7D3
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 12:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCQLSO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 07:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCQLSN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 07:18:13 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DEAA6421D
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:18:09 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id AED6E276BE;
        Fri, 17 Mar 2023 12:18:07 +0100 (CET)
Message-ID: <51071604-c97b-2f98-d382-d70e7916a7c6@gpxsee.org>
Date:   Fri, 17 Mar 2023 12:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: XDMA crashes on zero-length sg entries
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, dmaengine@vger.kernel.org
References: <529849b0-2ba9-85bf-c57f-0abe93cfdc42@gpxsee.org>
 <f6a0051f-acec-f661-55cb-8b2504bef79e@amd.com>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <f6a0051f-acec-f661-55cb-8b2504bef79e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi

On 16. 03. 23 19:25, Lizhi Hou wrote:
> Hi Martin,
> 
> Based on the dmaengine document
> 
> https://kernel.org/doc/html/v6.3-rc2/driver-api/dmaengine/client.html
> 
> The sg_len used for dmaengine_prep_slave_sg should be returned by 
> dma_map_sg.
> 
> This implies there should not be zero segment for the first sg_len 
> segments.
> 

I do get the mapping from vb2_dma_sg_plane_desc() which internally
uses dma_map_sg_attrs() and yet in some special cases sg_dma_len()
returns zero. So this is a "real-life" scenario. I'm still investigating
what the root cause is for getting such empty mappings from v4l2, but
the DMA driver should IMHO not crash the kernel in such case anyway.
I have looked into some randomly chosen kernel code that uses
sg_dma_len() and all usages that I have seen are prepared for the case
the length is zero. All but one driver simply stop the iteration while
the remaining one reported this case as an error.

M.

> I think that is why we need to provide 'sg_len' for 
> dmaengine_prep_slave_sg().
> 
> With 'sg_len', we do not need to worry about zero length sg in the 
> driver callback.
> 
> 
> Thanks,
> 
> Lizhi
> 
> On 3/16/23 10:03, Martin Tůma wrote:
>> Hi,
>> The Xilinx XDMA driver crashes when the scatterlist provided to
>> xdma_prep_device_sg() contains an empty entry, i.e. sg_dma_len()
>> returns zero. As I do get such sgl from v4l2 I suppose that this
>> is a valid scenario and not a bug in our parent mgb4 driver. Also
>> the documentation for sg_dma_len() suggests that there may be
>> zero-length entries.
>>
>> The following trivial patch fixes the crash:
>>
>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>> index 462109c61653..cd5fcd911c50 100644
>> --- a/drivers/dma/xilinx/xdma.c
>> +++ b/drivers/dma/xilinx/xdma.c
>> @@ -487,6 +487,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct 
>> scatterlist *sgl,
>>         for_each_sg(sgl, sg, sg_len, i) {
>>                 addr = sg_dma_address(sg);
>>                 rest = sg_dma_len(sg);
>> +               if (!rest)
>> +                       break;
>>
>>                 do {
>>                         len = min_t(u32, rest, XDMA_DESC_BLEN_MAX);
>>
>> M.

