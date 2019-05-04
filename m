Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0481213B14
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2019 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfEDQHC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 May 2019 12:07:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44633 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEDQHC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 4 May 2019 12:07:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id n134so4570654lfn.11;
        Sat, 04 May 2019 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/g4/FAy8CFEuRGloQTqP3cAjsdXbs5MvbrpZgu3CUjk=;
        b=Zs4sbqa8ANARSKgvwkNbcoqZn+42xxiawSxnMZSY1yc/iu/sH+Ot5XADP947HPOMRR
         hKwm2ZXbPJa98rJ6eA1ev1z1t2Zh7nfXlWI2Z4oZwMis1Ib4n2gHuQMZrBbmR8XeiAk+
         x+fIdUZNwa64ezJLTWSCtwyED9VCGM9XpBnUqFxLMC5/tsvaTrO5UM7LKTjjIKyRFUxi
         PTSYjNZ4g8eyhr87NTx3nTAwW/MbaLp1+Xwa+sCGHAKROjYAi6PbbzjkR+TF+jtPqJhZ
         Vb+B+oOxHKf+5YtuCAJfEh5QS5YJ3xTZlJ5bYR3scbFJSB0c5Dq9TEBVPhzSF1DWOLZi
         o4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/g4/FAy8CFEuRGloQTqP3cAjsdXbs5MvbrpZgu3CUjk=;
        b=r2PZa5aa7WpiTzh/sUZZ8FROebWHkk0aEcQZieYNtWMPVYVCudX83ob7L4d1TlLJvb
         cnSPhlAZfSgDhHzsKFPZX15KYA4R8TpXB8wAdP+kKHuITbks3i0nPsw/G+L3E6V8vRct
         hNDBsOwDSFJ6Z40fhU5gjDixXcFqPt/VG0munPUnidFq1wCi69XjLN+FbBR4qbLO55q6
         oRlLNtOJJVlzKhIQxo+TcKrDpEFGoXoBcvHXIoFN7+Gi5l4e10QwjOGvmTzcgc56vvX+
         kQAT0JdRlNYV+cgXeqj5QW0SdxFOOMjxuBM1smZRhzDEGzt8J5C/rHgIFNtGPjKjQO2e
         b6Jg==
X-Gm-Message-State: APjAAAXkB0MlS9AEXSYgkQLM4qStT3PE3MeR9fDcV17wmkc4PJI39WjS
        NfxfcsAPiiKjx0c+8Ay7+lq0U7fe
X-Google-Smtp-Source: APXvYqxhehPM3PnaxJ90v96qF3eCZ9T+BqQPR/v66khn0KxIS/k1POTK8sIbrNKVQms5LuWHEdI1rQ==
X-Received: by 2002:a19:3f4f:: with SMTP id m76mr8137930lfa.17.1556986018121;
        Sat, 04 May 2019 09:06:58 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id y19sm994817lfb.24.2019.05.04.09.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 09:06:56 -0700 (PDT)
Subject: Re: [PATCH] dma: tegra: add accurate reporting of dma state
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190424162348.23692-1-ben.dooks@codethink.co.uk>
 <dbe7c256-c7ad-a172-9e63-9251bec6f182@gmail.com>
 <b10126c5-227b-af9d-8774-7c9cf8f43908@codethink.co.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6631ad02-0e3c-d768-8c23-fd1f091402df@gmail.com>
Date:   Sat, 4 May 2019 19:06:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b10126c5-227b-af9d-8774-7c9cf8f43908@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

01.05.2019 11:58, Ben Dooks пишет:
> On 24/04/2019 19:17, Dmitry Osipenko wrote:
>> 24.04.2019 19:23, Ben Dooks пишет:
>>> The tx_status callback does not report the state of the transfer
>>> beyond complete segments. This causes problems with users such as
>>> ALSA when applications want to know accurately how much data has
>>> been moved.
>>>
>>> This patch addes a function tegra_dma_update_residual() to query
>>> the hardware and modify the residual information accordinly. It
>>> takes into account any hardware issues when trying to read the
>>> state, such as delays between finishing a buffer and signalling
>>> the interrupt.
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>
>> Hello Ben,
>>
>> Thank you very much for keeping it up. I have couple comments, please
>> see them below.
>>
>>> Cc: Dmitry Osipenko <digetx@gmail.com>
>>> Cc: Laxman Dewangan <ldewangan@nvidia.com> (supporter:TEGRA DMA DRIVERS)
>>> Cc: Jon Hunter <jonathanh@nvidia.com> (supporter:TEGRA DMA DRIVERS)
>>> Cc: Vinod Koul <vkoul@kernel.org> (maintainer:DMA GENERIC OFFLOAD
>>> ENGINE SUBSYSTEM)
>>> Cc: Dan Williams <dan.j.williams@intel.com> (reviewer:ASYNCHRONOUS
>>> TRANSFERS/TRANSFORMS (IOAT) API)
>>> Cc: Thierry Reding <thierry.reding@gmail.com> (supporter:TEGRA
>>> ARCHITECTURE SUPPORT)
>>> Cc: dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
>>> SUBSYSTEM)
>>> Cc: linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
>>> Cc: linux-kernel@vger.kernel.org (open list)
>>> ---
>>>   drivers/dma/tegra20-apb-dma.c | 92 ++++++++++++++++++++++++++++++++---
>>>   1 file changed, 86 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/dma/tegra20-apb-dma.c
>>> b/drivers/dma/tegra20-apb-dma.c
>>> index cf462b1abc0b..544e7273e741 100644
>>> --- a/drivers/dma/tegra20-apb-dma.c
>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>> @@ -808,6 +808,90 @@ static int tegra_dma_terminate_all(struct
>>> dma_chan *dc)
>>>       return 0;
>>>   }
>>>   +static unsigned int tegra_dma_update_residual(struct
>>> tegra_dma_channel *tdc,
>>> +                          struct tegra_dma_sg_req *sg_req,
>>> +                          struct tegra_dma_desc *dma_desc,
>>> +                          unsigned int residual)
>>> +{
>>> +    unsigned long status = 0x0;
>>> +    unsigned long wcount;
>>> +    unsigned long ahbptr;
>>> +    unsigned long tmp = 0x0;
>>> +    unsigned int result;
>>
>> You could pre-assign ahbptr=0xffffffff and result=residual here, then
>> you could remove all the duplicated assigns below.
> 
> ok, ta.
> 
>>> +    int retries = TEGRA_APBDMA_BURST_COMPLETE_TIME * 10;
>>> +    int done;
>>> +
>>> +    /* if we're not the current request, then don't alter the
>>> residual */
>>> +    if (sg_req != list_first_entry(&tdc->pending_sg_req,
>>> +                       struct tegra_dma_sg_req, node)) {
>>> +        result = residual;
>>> +        ahbptr = 0xffffffff;
>>> +        goto done;
>>> +    }
>>> +
>>> +    /* loop until we have a reliable result for residual */
>>> +    do {
>>> +        ahbptr = tdc_read(tdc, TEGRA_APBDMA_CHAN_AHBPTR);
>>> +        status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>> +        tmp =  tdc_read(tdc, 0x08);    /* total count for debug */
>>
>> The "tmp" variable isn't used anywhere in the code, please remove it.
> 
> must have been left over.
> 
>>> +
>>> +        /* check status, if channel isn't busy then skip */
>>> +        if (!(status & TEGRA_APBDMA_STATUS_BUSY)) {
>>> +            result = residual;
>>> +            break;
>>> +        }
>>
>> This doesn't look correct because TRM says "Busy bit gets set as soon
>> as a channel is enabled and gets cleared after transfer completes",
>> hence a cleared BUSY bit means that all transfers are completed and
>> result=residual is incorrect here. Given that there is a check for EOC
>> bit being set below, this hunk should be removed.
> 
> I'll check notes, but see below.
> 
>>> +
>>> +        /* if we've got an interrupt pending on the channel, don't
>>> +         * try and deal with the residue as the hardware has likely
>>> +         * moved on to the next buffer. return all data moved.
>>> +         */
>>> +        if (status & TEGRA_APBDMA_STATUS_ISE_EOC) {
>>> +            result = residual - sg_req->req_len;
>>> +            break;
>>> +        }
>>> +
>>> +        if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>> +            wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>> +        else
>>> +            wcount = status;
>>> +
>>> +        /* If the request is at the full point, then there is a
>>> +         * chance that we have read the status register in the
>>> +         * middle of the hardware reloading the next buffer.
>>> +         *
>>> +         * The sequence seems to be at the end of the buffer, to
>>> +         * load the new word count before raising the EOC flag (or
>>> +         * changing the ping-pong flag which could have also been
>>> +         * used to determine a new buffer). This  means there is a
>>> +         * small window where we cannot determine zero-done for the
>>> +         * current buffer, or moved to next buffer.
>>> +         *
>>> +         * If done shows 0, then retry the load, as it may hit the
>>> +         * above hardware race. We will either get a new value which
>>> +         * is from the first buffer, or we get an EOC (new buffer)
>>> +         * or both a new value and an EOC...
>>> +         */
>>> +        done = get_current_xferred_count(tdc, sg_req, wcount);
>>> +        if (done != 0) {
>>> +            result = residual - done;
>>> +            break;
>>> +        }
>>> +
>>> +        ndelay(100);
>>
>> Please use udelay(1) because there is no ndelay on arm32 and
>> ndelay(100) is getting rounded up to 1usec. AFAIK, arm64 doesn't have
>> reliable ndelay on Tegra either because timer rate changes with the
>> CPU frequency scaling.
> 
> I'll check, but last time it was implemented. This seems a backwards step.
> 
>> Secondly done=0 isn't a error case, technically this could be the case
>> when tegra_dma_update_residual() is invoked just after starting the
>> transfer. Hence I think this do-while loop and timeout checking aren't
>> needed at all since done=0 is a perfectly valid case.
> 
> this is not checking for an error, it's checking for a possible
> inaccurate reading.

If you'll change reading order of the status / words registers like I
suggested, then there won't be a case for the inaccuracy.

The EOC bit should be set atomically once transfer is finished, you
can't get wrapped around words count and EOC bit not being set.

For oneshot transfer that runs with interrupt being disabled, the words
counter will stop at 0 and the unset BUSY bit will indicate that the
transfer is completed.

>>
>> Altogether seems the tegra_dma_update_residual() could be reduced to:
>>
>> static unsigned int tegra_dma_update_residual(struct tegra_dma_channel
>> *tdc,
>>                           struct tegra_dma_sg_req *sg_req,
>>                           struct tegra_dma_desc *dma_desc,
>>                           unsigned int residual) 
>> {
>>     unsigned long status, wcount;
>>
>>     if (list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>         return residual;
>>
>>     if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>         wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>
>>     status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>
>>     if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>         wcount = status;
>>
>>     if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>         return residual - sg_req->req_len;
>>
>>     return residual - get_current_xferred_count(tdc, sg_req, wcount);
>> }
> 
> I'm not sure if that will work all the time. It took days of testing to
> get reliable error data for the cases we're looking for here.

Could you please tell exactly what those cases are. I don't see when the
simplified variant could fail, but maybe I already forgot some extra
details about how APB DMA works.

I tested the variant I'm suggesting (with the fixed typos and added
check for the BUSY bit) and it works absolutely fine, audio stuttering
issue is fixed, everything else works too. Please consider to use it for
the next version of the patch if there are no objections.
