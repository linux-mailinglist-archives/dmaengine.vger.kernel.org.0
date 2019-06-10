Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D053C017
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2019 01:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390656AbfFJXkz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 19:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390524AbfFJXkz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jun 2019 19:40:55 -0400
Received: from [192.168.1.32] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2B99206C3;
        Mon, 10 Jun 2019 23:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560210054;
        bh=mohPqaA8xgJOKhd1BCUCmxIzOCK/TYeC1MF6iHiSzxI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zuXphXcAgY/HWNpIsAFzmqLpCu62zF5beO+Je5IGz0a22zRZ8b29uozbR4DezKxWP
         ll7swaszkCOrBVpWhJ2KvdFMnCITcl9omdycyvXHF2+siCHtQq7Y+KOMBR3s0EHXaL
         9vxOXqgdwh/JjI9Jhh4i5YerLRYpun3n+yhaGeO8=
Subject: Re: [PATCH 2/2] dmagengine: pl330: add code to get reset property
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20190524002847.30961-1-dinguyen@kernel.org>
 <20190524002847.30961-2-dinguyen@kernel.org>
 <20190604121424.GW15118@vkoul-mobl>
 <1dd97825-f6a2-7a1b-33ef-e28e00cc8506@kernel.org>
 <CAMuHMdV+_DzS+LD720BeAn05RzYGO9rS51-ucicP=8D0wz9Psg@mail.gmail.com>
 <00841780-ad68-ba8d-bdf0-d3f78fa42c98@kernel.org>
 <55cc6016-f297-539d-df08-777903b79005@kernel.org>
 <CAMuHMdWktznAYLTp5t6PJy2+qcbs-5SHy4zCLUXYjRS3DqUZnw@mail.gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cf47b2d3-129c-fd1a-2d0a-0b662d86cc1d@kernel.org>
Date:   Mon, 10 Jun 2019 18:40:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWktznAYLTp5t6PJy2+qcbs-5SHy4zCLUXYjRS3DqUZnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 6/7/19 2:37 AM, Geert Uytterhoeven wrote:
> Hi Dinh,
> 
> On Wed, Jun 5, 2019 at 5:31 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
>> On 6/5/19 9:41 AM, Dinh Nguyen wrote:
>>> On 6/4/19 11:31 AM, Geert Uytterhoeven wrote:
>>>> On Tue, Jun 4, 2019 at 4:21 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
>>>>> On 6/4/19 7:14 AM, Vinod Koul wrote:
>>>>>> On 23-05-19, 19:28, Dinh Nguyen wrote:
>>>>>>> The DMA controller on some SoCs can be held in reset, and thus requires
>>>>>>> the reset signal(s) to deasserted. Most SoCs will have just one reset
>>>>>>> signal, but there are others, i.e. Arria10/Stratix10 will have an
>>>>>>> additional reset signal, referred to as the OCP.
>>>>>>>
>>>>>>> Add code to get the reset property from the device tree for deassert and
>>>>>>> assert.
>>>>>>>
>>>>>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> 
>>>>>>> --- a/drivers/dma/pl330.c
>>>>>>> +++ b/drivers/dma/pl330.c
> 
>>>>>>> @@ -3028,6 +3032,30 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>>>>>>>
>>>>>>>      amba_set_drvdata(adev, pl330);
>>>>>>>
>>>>>>> +    pl330->rstc = devm_reset_control_get_optional(&adev->dev, "dma");
>>>>>>> +    if (IS_ERR(pl330->rstc)) {
>>>>>>> +            dev_err(&adev->dev, "No reset controller specified.\n");
> 
> "No reset controller specified.\n"
> 
>>>>>>
>>>>>> Wasnt this optional??
>>>>>
>>>>> Yes, this is optional. The call devm_reset_control_get_optional() will
>>>>> just return NULL if the reset property is not there, but an error
>>>>> pointer if something really went wrong. Thus, I'm using IS_ERR() for the
>>>>> error checking.
>>>>
>>>> So the error message is incorrect, as this is a real error condition?
>>>
>>> Yes, you're right! Will correct in V2.
>>
>> Looking at this again, I think the error message is correct. The
>> optional call will return NULL if the resets property is not specified,
>> and will return an error pointer if the reset propert is specified, but
>> the pointer to the reset controller is not found.
>>
>> So I think the error message is correct.
> 
> Please reread the error message, and what you wrote above.
> 
> Error message: "No reset controller specified".
> Rationale: NULL (i.e. no error) if "the resets property is not specified".
> 
> If an error pointer is returned, this may be due to probe deferral (to be
> propagated, but further ignored), or due to a real failure.
> 
> So IMHO the code should read:
> 
>         if (IS_ERR(pl330->rstc)) {
>                 if (PTR_ERR(pl330->rstc) != -EPROBE_DEFER)
>                         dev_err(&adev->dev, "Failed to get reset.\n");
>                 return PTR_ERR(pl330->rstc);
>         } else { ... }
> 

You're right! Will update in v2.

Thanks!

Dinh
