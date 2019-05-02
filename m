Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C088F117A4
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEBKxY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 06:53:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3659 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBKxY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 May 2019 06:53:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccacc040000>; Thu, 02 May 2019 03:52:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 03:53:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 May 2019 03:53:23 -0700
Received: from [10.24.44.78] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 10:53:17 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
Date:   Thu, 2 May 2019 16:23:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502060446.GI3845@vkoul-mobl.Dlink>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556794372; bh=4YZqSSiPO2nd8RHIayr3bXD4xD40OAMtmWBa4LBfST0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=OlnH7WSfUQ35KXH+Of+aBPIgwndVpUefXZxGs/nmgzDIpN4c3/JZ7l2VF974WuPXZ
         L5Tca3KGIQjQ4CdimHhgjnc5kbBMp1n7lUTUfhxvakyj4NHUM8YYVxWNcS2+YcuFgU
         jQVcirFFI/6WIv8QYLha2uVsKr1BcXo2O464IPCbkXEQTepaVO4Jur8MvE/xPJjzVZ
         /cmRulpSMeKQCWje4odEQ597mBwjp0LzBX94daXRcvRURF6za/EeTHjL20CG6t1yMT
         eOAEy71utFFTkMrFFL70VUBkr/hW9ZQP5Geu1Mdr8xySDXwkLPjenM5BTKg50g3rZj
         rpiEau6YPrJKg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/2/2019 11:34 AM, Vinod Koul wrote:
> On 30-04-19, 17:00, Sameer Pujar wrote:
>> During the DMA transfers from memory to I/O, it was observed that transfers
>> were inconsistent and resulted in glitches for audio playback. It happened
>> because fifo size on DMA did not match with slave channel configuration.
>>
>> currently 'dma_slave_config' structure does not have a field for fifo size.
>> Hence the platform pcm driver cannot pass the fifo size as a slave_config.
>> Note that 'snd_dmaengine_dai_dma_data' structure has fifo_size field which
>> cannot be used to pass the size info. This patch introduces fifo_size field
>> and the same can be populated on slave side. Users can set required size
>> for slave peripheral (multiple channels can be independently running with
>> different fifo sizes) and the corresponding sizes are programmed through
>> dma_slave_config on DMA side.
> FIFO size is a hardware property not sure why you would want an
> interface to program that?
>
> On mismatch, I guess you need to take care of src/dst_maxburst..
Yes, FIFO size is a HW property. But it is SW configurable(atleast in my 
case) on
slave side and can be set to different sizes. The src/dst_maxburst is 
programmed
for specific values, I think this depends on few factors related to 
bandwidth
needs of client, DMA needs of the system etc.,
In such cases how does DMA know the actual FIFO depth of slave peripheral?
>> Request for feedback/suggestions.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   include/linux/dmaengine.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index d49ec5c..9ec198b 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -351,6 +351,8 @@ enum dma_slave_buswidth {
>>    * @slave_id: Slave requester id. Only valid for slave channels. The dma
>>    * slave peripheral will have unique id as dma requester which need to be
>>    * pass as slave config.
>> + * @fifo_size: Fifo size value. The dma slave peripheral can configure required
>> + * fifo size and the same needs to be passed as slave config.
>>    *
>>    * This struct is passed in as configuration data to a DMA engine
>>    * in order to set up a certain channel for DMA transport at runtime.
>> @@ -376,6 +378,7 @@ struct dma_slave_config {
>>   	u32 dst_port_window_size;
>>   	bool device_fc;
>>   	unsigned int slave_id;
>> +	u32 fifo_size;
>>   };
>>   
>>   /**
>> -- 
>> 2.7.4
