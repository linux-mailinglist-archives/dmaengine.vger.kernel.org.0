Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0204730324E
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 03:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbhAYNfZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Jan 2021 08:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbhAYNe1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Jan 2021 08:34:27 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F3DC06178C
        for <dmaengine@vger.kernel.org>; Mon, 25 Jan 2021 05:33:24 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a12so2466079qkh.10
        for <dmaengine@vger.kernel.org>; Mon, 25 Jan 2021 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nkYjifaadDKUN2A03i+6Bz+1YtH0jSHjyjWsjSahiSM=;
        b=mP4LUf21MwAjH4kN4dXyT4fkqKESBIoz/aDvWsKEPt5U34es68aocF+FgswhN73A+a
         nKf78vrq8s762U/3o/qIFx4Lcse4dn675hz9IpXQ5V1J8W3AwooILanGLuG25qHgVT+V
         AnghkYYxljpaQh8xTe2EdCTAOTEcG61MJnGBGZpvrekICwUoucgpb13G/GdumPNt4HIe
         3oldteJ9W0Q+hRsOlUEr86W6o8NsDg4WsJ7m9mMs9OxkW1IH46nRjNiVmLJwVJlRzwo8
         E57fA5FtRieTA7AnuN63ukVL/XsN7Gdvs8eiWib2OYFR16b5aV6ZCfHO4VHwtYeG7KQn
         kuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nkYjifaadDKUN2A03i+6Bz+1YtH0jSHjyjWsjSahiSM=;
        b=fSuPI0fGOqRffvV6eQqiqS6vicg0CawUoGxfHmcJMqh991x3/ELPHAKUBPDu3rZRBE
         /L/T8o7TePfpP3UNHIxZiT5/sabq8Tk21U8VpnphUEZfvS2WmdIMsFTpw8aolMU3CUXq
         x9Rw6hVyURjttj9K1RYO97gKu7CCbG7IIFJ1ir5Utzc/WV2aoSbfVu6JwKr3F+BSqMxL
         gEvDqMnbmE8WkZzircATYXkwSbcF6EshMFWhpCsJHi1IRs03YxcQW7PGkaBaIrs6n/r5
         4FAc1l8vj62Ho0mFhpeMnhmXb65DthkoHQoW69qBtEqGzUX8Pa8FkmSvwk8s/bDwACpx
         B/oA==
X-Gm-Message-State: AOAM532Do7tvIkiWrFJ6uruq1CJ6fUu/uJpZh6BzyvzLsdTLKdFDLWWD
        Riakssad/G/QlZMcKX3XQCdVhg==
X-Google-Smtp-Source: ABdhPJztUgDmuOPoaK2+3lrjRYGxsWqSwWTwr1jVgLFFmhxaxk9GQArfwe6Z72+5T+v9iFuPjT8v1Q==
X-Received: by 2002:a05:620a:4c:: with SMTP id t12mr720564qkt.74.1611581603501;
        Mon, 25 Jan 2021 05:33:23 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id u1sm11537939qth.19.2021.01.25.05.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 05:33:22 -0800 (PST)
Subject: Re: [PATCH] drivers: dma: qcom: bam_dma: Manage clocks when
 controlled_remotely is set
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, vkoul@kernel.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210122025251.3501362-1-thara.gopinath@linaro.org>
 <20210122051013.GE2479@dragon>
 <d1f1724c-39f1-7b6e-8cd4-638a44608d9c@linaro.org>
 <20210123071924.GF2479@dragon>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <16da38a6-36a2-2126-c8d5-6618fd9e4814@linaro.org>
Date:   Mon, 25 Jan 2021 08:33:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210123071924.GF2479@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shawn,

On 1/23/21 2:19 AM, Shawn Guo wrote:
> On Fri, Jan 22, 2021 at 10:44:09AM -0500, Thara Gopinath wrote:
>> Hi Shawn,
>>
>> Thanks for the review
>>
>> On 1/22/21 12:10 AM, Shawn Guo wrote:
>>> On Thu, Jan 21, 2021 at 09:52:51PM -0500, Thara Gopinath wrote:
>>>> When bam dma is "controlled remotely", thus far clocks were not controlled
>>>> from the Linux. In this scenario, Linux was disabling runtime pm in bam dma
>>>> driver and not doing any clock management in suspend/resume hooks.
>>>>
>>>> With introduction of crypto engine bam dma, the clock is a rpmh resource
>>>> that can be controlled from both Linux and TZ/remote side.  Now bam dma
>>>> clock is getting enabled during probe even though the bam dma can be
>>>> "controlled remotely". But due to clocks not being handled properly,
>>>> bam_suspend generates a unbalanced clk_unprepare warning during system
>>>> suspend.
>>>>
>>>> To fix the above issue and to enable proper clock-management, this patch
>>>> enables runtim-pm and handles bam dma clocks in suspend/resume hooks if
>>>> the clock node is present irrespective of controlled_remotely property.
>>>
>>> Shouldn't the following probe code need some update?  Now we have both
>>> controlled_remotely and clocks handle for cryptobam node.  For example,
>>> if devm_clk_get() returns -EPROBE_DEFER, we do not want to continue with
>>> bamclk forcing to be NULL, right?
>>
>> We still will have to set bdev->bamclk to NULL in certain scenarios. For eg
>> slimbus bam dma is controlled-remotely and the clocks are handled by the
>> remote s/w. Linux does not handle the clocks at all and  there is no clock
>> specified in the dt node.This is the norm for the devices that are also
>> controlled by remote s/w. Crypto bam dma is a special case where the clock
>> is actually a rpmh resource and hence can be independently handled from both
>> remote side and Linux by voting. In this case, the dma is controlled
>> remotely but clock can be turned off and on in Linux. Hence the need for
>> this patch.
> 
> So is it correct to say that clock is mandatory for !controlled-remotely
> BAM, while it's optional for controlled-remotely one.  If yes, maybe we
> can do something like below to make the code a bit easier to read?

Yes. Sure. I will change it to below.

> 
> 	if (controlled-remotely)
> 		bdev->bamclk = devm_clk_get_optional();
> 	else
> 		bdev->bamclk = devm_clk_get();
> 		
>> Yes, the probe code needs updating to handle -EPROBE_DEFER (esp if the clock
>> driver is built in as a module) I am not sure if the clock framework handles
>> -EPROBE_DEFER properly either. So that
>> might need updating too. This is a separate activity and not part of this
>> patch >
> 
> As the patch breaks the assumption that for controlled-remotely BAM
> there is no clock to be managed, the probe code becomes buggy right
> away.

mmm... not really. Either ways we don't handle -EPROBE_DEFER from clock 
code. That behavior is not worse because of this patch. I can send a 
separate patch to fix the -EPROBE_DEFER issue.

> 
> Shawn
> 

-- 
Warm Regards
Thara
