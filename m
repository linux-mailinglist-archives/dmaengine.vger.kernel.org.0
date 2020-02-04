Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3AD151779
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgBDJMX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 04:12:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42200 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgBDJMW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 04:12:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id w21so3579895pgl.9
        for <dmaengine@vger.kernel.org>; Tue, 04 Feb 2020 01:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OEno8L+dLk53KEqvLYXsrFVru+rwMQDT1MCsCBWWmic=;
        b=PGeL2yv80M/Xyz3TqQfy30bcMf6fkJSWDpFtX5zg7SPUH32tZaavlnLQLUeJvm61jL
         7jc1TvZBXJLdQqek38XGa/IQ7IISMsQ6Z+WP22qtzWArm4IfXAQjwdE2Ga+ecWTR7ANa
         YERU2WTGz9nVMujVG57yYbPj32BYQtRfE68nkB3pq2NXz1q3L+5qIKStEyr+Dhc9FAaX
         xi6xSd1RLMPZ0pXPtcy8nYd5D924/AO2HMEt0/LdLK7SnHAYIkl+EEjc7yT/DPAWgn6p
         gkp4llgs/xk3IzTuqHUQ5FfkQ923tWRHTjwVPNc0B2adGWZK2sgorrP3b4qNJ5nL8m+0
         MJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OEno8L+dLk53KEqvLYXsrFVru+rwMQDT1MCsCBWWmic=;
        b=X6yNtNzbwn8AfFKGHySomt1kSolDrwejfe/Ee+JTVnNOR7Zp61aaSebBBmZ1akPW6f
         n/l3p9/SNtSi7Vj70hD9MTdO9TMvRuz1GJ9LY7vsI8t5n2+nR9tEI8gfjY8i4+EEgnub
         VlfLVOteNQmvyqwB9JvFyVt4R7wZ7hGgBxRhvidBAOeYyCYS+huD31r0FcWwJSmYRz+C
         QC+9gKlL1BLT6qBQN+rFGXXudgMh9mwmoFpfgCPfRcm2hLca06VtlKZ8V1NK/mHmCq9+
         ACezb3SdZOfQmZ3iStp2pBi6WP7YjyPwlC6F+e4Db/qA/44J9PKVqjVFPIlVhzx2w5yj
         +J0w==
X-Gm-Message-State: APjAAAU3A03pYGBMbWWU0dMAweUiJpqI+Ma8MGrYETpYMWsBOKEQSnSU
        l6sfDvxGUKUIv/10xpi1OvNuVQ==
X-Google-Smtp-Source: APXvYqxShwB5mksr4VLPF6EQdoB3Thrj1dJI1OjTYyqPg21c1H8oXz+rhju/pYJoSihlvb9nLNYwrA==
X-Received: by 2002:a62:e414:: with SMTP id r20mr29513047pfh.154.1580807542320;
        Tue, 04 Feb 2020 01:12:22 -0800 (PST)
Received: from [192.168.11.4] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.googlemail.com with ESMTPSA id b130sm23059315pga.4.2020.02.04.01.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 01:12:21 -0800 (PST)
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
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
From:   Rob Landley <rob@landley.net>
Message-ID: <64cffbfe-a639-c09d-8aa2-fdda8fad2cf7@landley.net>
Date:   Tue, 4 Feb 2020 03:16:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUYcSPoK8NOSdMzU_Jtg84aPMNKeGnacnF7=aidV4eqvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2/4/20 2:01 AM, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Tue, Feb 4, 2020 at 7:52 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> On 03/02/2020 22.34, Geert Uytterhoeven wrote:
>>> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
>>>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>>>>
>>>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
>>>> for classical SuperH hardware. It was never merged, unfortunately :(.
>>>
>>> True.
>>>
>>>>> Anyone who cares for DMA on SuperH?
>>>>
>>>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
>>>> essential hardware features?
>>>
>>> It may make a few things slower.

The j-core stuff has DMA but we haven't hooked it up to dmaengine yet. (It's on
the todo list but pretty far down.)

I fought with dmaengine in a 7760 board in 2018, and got it to run its tests but
the ship deadline arrived before I got the ethernet working with it.

I found the documentation fairly impenetrable, is there a good primer on what's
_current_ for new implementations? (I had similar questions for gpio. It's easy
to google for "here's how you did it in 2010"...)

>> I would not drop DMA support but I would suggest to add dma_slave_map
>> for non DT boot so the _compat() can be dropped.
> 
> Which is similar in spirit to gpiod_lookup and clk_register_clkdev(),
> right?
> 
>> Imho on lower spec SoC (and I believe SuperH is) the DMA makes big
>> difference offloading data movement from the CPU.
> 
> Assumed it is actually used...

The turtle boards need it USB, ethernet, and sdcard, but Rich Felker hasn't
finished the j32 port yet (we just got him the updated docs last month) and the
existing implementation is nommu so the things that are using it are reaching
around behind the OS's back...

Rob
