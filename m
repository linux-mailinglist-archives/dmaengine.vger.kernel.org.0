Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084E6D8221
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 23:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfJOVYD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 17:24:03 -0400
Received: from www381.your-server.de ([78.46.137.84]:41314 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfJOVYD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Oct 2019 17:24:03 -0400
X-Greylist: delayed 1022 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Oct 2019 17:24:01 EDT
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1iKU1s-00079J-3q; Tue, 15 Oct 2019 23:06:52 +0200
Received: from [93.104.114.34] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1iKU1r-0001zM-Ky; Tue, 15 Oct 2019 23:06:51 +0200
Subject: Re: [PATCH] dmaengine: axi-dmac: simple device_config operation
 implemented
To:     Vinod Koul <vkoul@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "alencar.fmce@imbel.gov.br" <alencar.fmce@imbel.gov.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190913145404.28715-1-alexandru.ardelean@analog.com>
 <20191014070142.GB2654@vkoul-mobl>
 <4384347cc94a54e3fa22790aaa91375afda54e1b.camel@analog.com>
 <20191015104342.GW2654@vkoul-mobl>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4428e1fa-1a2a-5a5f-ada8-806078c8da94@metafoo.de>
Date:   Tue, 15 Oct 2019 23:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015104342.GW2654@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25603/Tue Oct 15 10:57:00 2019)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10/15/19 12:43 PM, Vinod Koul wrote:
> On 15-10-19, 07:05, Ardelean, Alexandru wrote:
>> On Mon, 2019-10-14 at 12:31 +0530, Vinod Koul wrote:
>>> [External]
>>>
>>
>> Hey,
>>
>>> On 13-09-19, 17:54, Alexandru Ardelean wrote:
>>>> From: Rodrigo Alencar <alencar.fmce@imbel.gov.br>
>>>>
>>>> dmaengine_slave_config is called by dmaengine_pcm_hw_params when using
>>>> axi-i2s with axi-dmac. If device_config is NULL, -ENOSYS  is returned,
>>>> which breaks the snd_pcm_hw_params function.
>>>> This is a fix for the error:
>>>
>>> and what is that?
>>>
>>>> $ aplay -D plughw:ADAU1761 /usr/share/sounds/alsa/Front_Center.wav
>>>> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
>>>> Little Endian, Rate 48000 Hz, Mono
>>>> axi-i2s 43c20000.axi-i2s: ASoC: 43c20000.axi-i2s hw params failed: -38
>>
>> Error is above this line [code -38].
> 
> Right and it would help explaining a bit more on the error!
> 
>>
>>>> aplay: set_params:1403: Unable to install hw params:
>>>> ACCESS:  RW_INTERLEAVED
>>>> FORMAT:  S16_LE
>>>> SUBFORMAT:  STD
>>>> SAMPLE_BITS: 16
>>>> FRAME_BITS: 16
>>>> CHANNELS: 1
>>>> RATE: 48000
>>>> PERIOD_TIME: 125000
>>>> PERIOD_SIZE: 6000
>>>> PERIOD_BYTES: 12000
>>>> PERIODS: 4
>>>> BUFFER_TIME: 500000
>>>> BUFFER_SIZE: 24000
>>>> BUFFER_BYTES: 48000
>>>> TICK_TIME: 0
>>>>
>>>> Signed-off-by: Rodrigo Alencar <alencar.fmce@imbel.gov.br>
>>>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>>>> ---
>>>>
>>>> Note: Fixes tag not added intentionally.
>>>>
>>>>  drivers/dma/dma-axi-dmac.c | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
>>>> index a0ee404b736e..ab2677343202 100644
>>>> --- a/drivers/dma/dma-axi-dmac.c
>>>> +++ b/drivers/dma/dma-axi-dmac.c
>>>> @@ -564,6 +564,21 @@ static struct dma_async_tx_descriptor
>>>> *axi_dmac_prep_slave_sg(
>>>>  	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
>>>>  }
>>>>  
>>>> +static int axi_dmac_device_config(struct dma_chan *c,
>>>> +			struct dma_slave_config *slave_config)
>>>> +{
>>>> +	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
>>>> +	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
>>>> +
>>>> +	/* no configuration required, a sanity check is done instead */
>>>> +	if (slave_config->direction != chan->direction) {
>>>
>>>  slave_config->direction is a deprecated field, pls dont use that
>>
>> ack
>> any alternative recommendations of what to do in this case?

iirc direction is checked when the channel is requested, there should be
no need to check it again.

>> i can take a look, but if you have something on-the-top-of-your-head, i'm
>> open to suggestions
>> we can also just drop this completely and let userspace fail
> 
> Yeah it is tricky, this should be ideally implemented properly.
> 
>>>> +		dev_err(dmac->dma_dev.dev, "Direction not supported by this
>>>> DMA Channel");
>>>> +		return -EINVAL;
>>>
>>> So you intent to support slave dma but do not use dma_slave_config.. how
>>> are you getting the slave address and other details?
>>
>> This DMA controller is a bit special.
>> It gets synthesized in FPGA, so the configuration is fixed and cannot be
>> changed at runtime. Maybe later we would allow/implement this
>> functionality, but this is a question for my HDL colleagues.
>>
>> Two things are done (in this order):
>> 1. For some paramters, axi_dmac_parse_chan_dt() is used to determine things
>> from device-tree; as it's an FPGA core, things are synthesized once and
>> cannot change (yet)
>> 2. For other parameters, the axi_dmac_detect_caps() is used to guess some
>> of them at probe time, by doing some reg reads/writes
> 
> So the question for you hw folks is how would a controller work with
> multiple slave devices, do they need to synthesize it everytime?
> 
> Rather than that why cant they make the peripheral addresses
> programmable so that you dont need updating fpga everytime!

The DMA has a direct connection to the peripheral and the peripheral
data port is not connected to the general purpose memory interconnect.
So you can't write to it by an MMIO address and	 there is no address
that needs to be configured. For an FPGA based design this is quite a
good solution in terms of resource usage, performance and simplicity. A
direct connection requires less resources than connection it to the
central memory interconnect, while at the same time having lower latency
and not eating up any additional bandwidth on the central memory connect.

So slave config in this case is a noop and all it can do is verify that
the requested configuration matches the available configuration.

