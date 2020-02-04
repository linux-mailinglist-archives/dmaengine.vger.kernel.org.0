Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58A15189D
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 11:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgBDKN3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 05:13:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42143 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgBDKN3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 05:13:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id e8so4469462plt.9
        for <dmaengine@vger.kernel.org>; Tue, 04 Feb 2020 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OkODZfD0TOCWkrVmZb373OBkkt2OOLqS8H6uAuvHUNU=;
        b=vKiI1beaLHxdeZBw93M+sozI1n1CArYvM88KZSVL5rsbXIvVVdInpw2Ag9xOQIqHq7
         9poyiqKKRgV7RlXsmQOopQa9fty/jXVweNRFP67UYvu2KL7RGxUQAWq5ruMf6yYzO0ai
         J75liKsCodOc3x7hkNAqgqLKe27zR5UvPgZoe8nWiKGJkWnZxVY/wnLul69ojJdyJ+qE
         OlqM1kzB84uPeMpT6+MQvpeC9s83lfXOOfQJjV23AuN9oQinq5W/j5d2w3aUtU+CRhMW
         +t6V35S3Y0bhfoy65fNClrCh77UdFPEtf0ejl+xdErx8QQKUDgpHqZ5+611fIs7qqmpC
         jFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OkODZfD0TOCWkrVmZb373OBkkt2OOLqS8H6uAuvHUNU=;
        b=kOK9X+Z15oikGXznGiB5l1DokJGcrNJ3CYIWBRiUgnffEXaW/1t71LOGPreUCyIlXB
         aLKET/5AjAxQJ6S207rZg6fHmq9lSOBF94B3X1UUm0zSTGh9MS684i2mnh7zR+mhybnT
         vdOXc+mHpXTALO92oUB3T3mjDBVesfcgMge44yPZApPqbgdNBG+kzZFmSGlHyTYUzqhV
         z0Qv/GJw2YYY3zmsQ+Ze0+u84XLRJDfr4ny9OQ+33rJh8JGKPdmTdxpuDB/werjZSHhu
         XCfq7qLH4Tmb+XsGi7kaNkeAyvBjfnz4NWktZo4zEf8mTpXbEpemv4+GKVHtFKSlKm9Z
         mSBg==
X-Gm-Message-State: APjAAAUDjMLzNphLlmttg/YgKFuimEqvfR8pwFMYypHMEgX7mZWDEkzk
        tGlonLP+tm8KrtgdP02WRNfwfg==
X-Google-Smtp-Source: APXvYqzISGwROQ4q5fq5nttC+PzUoGznWW9Yc7dOP9VfbUZXZM5My/IDO1+S4yceR0m1fPSy9As0Pw==
X-Received: by 2002:a17:902:6a8c:: with SMTP id n12mr24181422plk.191.1580811208877;
        Tue, 04 Feb 2020 02:13:28 -0800 (PST)
Received: from [192.168.11.4] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.googlemail.com with ESMTPSA id y2sm23887773pff.139.2020.02.04.02.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 02:13:27 -0800 (PST)
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
 <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
 <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
 <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
 <b09ad222-f5b8-af5a-6c2b-2dd6b30f1c73@ti.com>
 <CAMuHMdUYcSPoK8NOSdMzU_Jtg84aPMNKeGnacnF7=aidV4eqvw@mail.gmail.com>
 <64cffbfe-a639-c09d-8aa2-fdda8fad2cf7@landley.net>
 <CAMuHMdVeCaRu=D9stdEuWKpnVm1YBibwuVrxogVx+2RBvOb1tA@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <3601f6ef-1666-2fd5-263c-388c0c48db16@landley.net>
Date:   Tue, 4 Feb 2020 04:18:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVeCaRu=D9stdEuWKpnVm1YBibwuVrxogVx+2RBvOb1tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2/4/20 3:27 AM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Tue, Feb 4, 2020 at 10:12 AM Rob Landley <rob@landley.net> wrote:
>> On 2/4/20 2:01 AM, Geert Uytterhoeven wrote:
>>> On Tue, Feb 4, 2020 at 7:52 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>>> On 03/02/2020 22.34, Geert Uytterhoeven wrote:
>>>>> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
>>>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>>>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
>>>>>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>>>>>>
>>>>>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
>>>>>> for classical SuperH hardware. It was never merged, unfortunately :(.

The problem with converting everything else to j-core has always been regression
testing. I have 2 pieces of classing sh4 hardware, and one classing sh2 board,
and none of them are currently on the same continent I am. :)

(I've got 3 different j-core boards, though. And am currently in the same room
as 2 others. :)

>>>>> True.
>>>>>
>>>>>>> Anyone who cares for DMA on SuperH?
>>>>>>
>>>>>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
>>>>>> essential hardware features?
>>>>>
>>>>> It may make a few things slower.
>>
>> The j-core stuff has DMA but we haven't hooked it up to dmaengine yet. (It's on
>> the todo list but pretty far down.)
> 
> And would use DT.  Hence the issue is not applicable to j-core.

Indeed.

The last classic sh4 board I used did not have DMA hooked up in Linux, and
trying to make current kernels work hit the fact that the device tree people
kept breaking various pre-device tree APIs, and my patches to fix them were met
with "you should convert everything to device tree rather than fix this obvious
regression we caused" and thus never went upstream. (Johnson Controls shipped
them locally and I handed the patches over to the lawyers to do the license
compliance tarball before I left. And of course I posted the fixes to this list...)

It's nice that at least this time somebody is _asking_ before breaking
non-device-tree support for stuff that used to work...

>> The turtle boards need it USB, ethernet, and sdcard, but Rich Felker hasn't
>> finished the j32 port yet (we just got him the updated docs last month) and the
>> existing implementation is nommu so the things that are using it are reaching
>> around behind the OS's back...
> 
> Is j32 the (rebranded) j4?

Yes.

Rob
