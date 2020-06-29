Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4720D88A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2020 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgF2TkB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 15:40:01 -0400
Received: from foss.arm.com ([217.140.110.172]:41798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732999AbgF2Tj4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jun 2020 15:39:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1254E13FD;
        Mon, 29 Jun 2020 04:20:36 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B30A83F73C;
        Mon, 29 Jun 2020 04:20:34 -0700 (PDT)
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA
 engine
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Amit Singh Tomar <amittomer25@gmail.com>, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com>
 <20200624061529.GF2324254@vkoul-mobl>
 <75d154d0-2962-99e6-a7c7-bf0928ec8b2a@arm.com>
 <20200629095446.GH2599@vkoul-mobl>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <36274785-f400-4d69-deed-b7d545718d40@arm.com>
Date:   Mon, 29 Jun 2020 12:19:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629095446.GH2599@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29/06/2020 10:54, Vinod Koul wrote:

Hi Vinod,

> On 24-06-20, 10:35, Andrï¿½ Przywara wrote:
>> On 24/06/2020 07:15, Vinod Koul wrote:
>>> On 09-06-20, 15:47, Amit Singh Tomar wrote:
>>>
>>>> @@ -372,6 +383,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>>>>  				  struct dma_slave_config *sconfig,
>>>>  				  bool is_cyclic)
>>>>  {
>>>> +	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
>>>>  	u32 mode, ctrlb;
>>>>  
>>>>  	mode = OWL_DMA_MODE_PW(0);
>>>> @@ -427,14 +439,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>>>>  	lli->hw[OWL_DMADESC_DADDR] = dst;
>>>>  	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
>>>>  	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
>>>> -	/*
>>>> -	 * Word starts from offset 0xC is shared between frame length
>>>> -	 * (max frame length is 1MB) and frame count, where first 20
>>>> -	 * bits are for frame length and rest of 12 bits are for frame
>>>> -	 * count.
>>>> -	 */
>>>> -	lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
>>>> -	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
>>>> +
>>>> +	if (od->devid == S700_DMA) {
>>>> +		/* Max frame length is 1MB */
>>>> +		lli->hw[OWL_DMADESC_FLEN] = len;
>>>> +		/*
>>>> +		 * On S700, word starts from offset 0x1C is shared between
>>>> +		 * frame count and ctrlb, where first 12 bits are for frame
>>>> +		 * count and rest of 20 bits are for ctrlb.
>>>> +		 */
>>>> +		lli->hw[OWL_DMADESC_CTRLB] = FCNT_VAL | ctrlb;
>>>> +	} else {
>>>> +		/*
>>>> +		 * On S900, word starts from offset 0xC is shared between
>>>> +		 * frame length (max frame length is 1MB) and frame count,
>>>> +		 * where first 20 bits are for frame length and rest of
>>>> +		 * 12 bits are for frame count.
>>>> +		 */
>>>> +		lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
>>>> +		lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
>>>
>>> Unfortunately this wont scale, we will keep adding new conditions for
>>> newer SoC's! So rather than this why not encode max frame length in
>>> driver_data rather than S900_DMA/S700_DMA.. In future one can add values
>>> for newer SoC and not code above logic again.
>>
>> What newer SoCs? I don't think we should try to guess the future here.
> 
> In a patch for adding new SoC, quite ironical I would say!

S700 is not a new SoC, it's just this driver didn't support it yet. What
I meant is that I don't even know about the existence of upcoming SoCs
(Google seems clueless), not to speak of documentation to assess which
DMA controller they use.

>> We can always introduce further abstractions later, once we actually
>> *know* what we are looking at.
> 
> Rather if we know we are adding abstractions, why not add in a way that
> makes it scale better rather than rework again

I appreciate the effort, but this really tapping around in the dark,
since we don't know which direction any new DMA controller is taking. I
might not even be similar.

>> Besides, I don't understand what you are after. The max frame length is
>> 1MB in both cases, it's just a matter of where to put FCNT_VAL, either
>> in FLEN or in CTRLB. And having an extra flag for that in driver data
>> sounds a bit over the top at the moment.
> 
> Maybe, maybe not. I would rather make it support N SoC when adding
> support for second one rather than keep adding everytime a new SoC is
> added...

Well, what do you suggest, specifically? At the moment we have two
*slightly* different DMA controllers, so we differentiate between the
two based on the model. Do you want to introduce an extra flag like
FRAME_CNT_IN_CTRLB? That seems to be a bit over the top here, since we
don't know if a future DMA controller is still compatible, or introduces
completely new differences.

Cheers,
Andre
