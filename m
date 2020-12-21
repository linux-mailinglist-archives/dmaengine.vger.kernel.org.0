Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD82DFF61
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 19:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLUSKf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 13:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgLUSKe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Dec 2020 13:10:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D913DC0613D3
        for <dmaengine@vger.kernel.org>; Mon, 21 Dec 2020 10:09:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id hk16so6895494pjb.4
        for <dmaengine@vger.kernel.org>; Mon, 21 Dec 2020 10:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oKzr3FPkUPe+aYLEEdAws7uUObKGbIl98KSfBYhptN8=;
        b=soNsn/OEkcxcg3tdMLUK8S9ZfkM2t2yqDVZhgO18mjV+PiB93rs9nVs4/WOxCehg/l
         Zg1AKon2Kp22DOxk79DHwR6nf3NMY2EigMyBBHYEATgEmmoIAESPB5ryNAeJdcC/ABow
         gu2QCIJsK3kY5FV0rUzPAZKM+Vu5PA9N1h2mZkoKFe5opMbOQqNy5Nv+ZylxufnFJNgp
         M9n+UFZYYDVCrgxz1RYf1f7reW9o1Uj/tCIUJeJghbf4yqPqoHRS6HDcSsdLMgXS3j5C
         il7Nm9zO2lJUTh3QxS6ymYW9gn3wf4DgrEL+jOFyt3bn8Bjnh1bYfSBVesfBWDPaEQ27
         tqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oKzr3FPkUPe+aYLEEdAws7uUObKGbIl98KSfBYhptN8=;
        b=PpFBZKOhEcQQ741i36Uu7+kArsNTz2jrc5DGyeGTy31sOy0Gu630F/BhcDULgw9s0+
         TmxywbaJBbnl5t4udTzMi5zGNMCw/Dizy/0wT3ID0SjfRb0En0eQJAgdhwVavoqOVfxV
         AGuMoQSGEdVUPwrLwUuDYrEg4hF3FYnmoHo6ftj4CeZh0oJ9M0oBMBywa85xymv5eFW5
         oA9naZpCagl8Y/zGDVNYEgyo1H6cCykxlbvKuFjLP5ssDiDAKIncKIEbbHEf0WZsLtpP
         fMry0m6VhWALXoeZ4sYEWr3e5UZ6sKthHHfoyEIQcUuDAc2sBZtqQn+eSfJxU+02A2XG
         eiWA==
X-Gm-Message-State: AOAM530IOcIZju8DbCwIUMvV91rGRaOdTKn1w3SIaTZoefS3YnbGLalP
        tnDW7WxcCckXjeGsjEByBt3MVA==
X-Google-Smtp-Source: ABdhPJztnTinUeHX3LcXJVPOkssICjBjG1WnlYcFyNRW4VUcZrVDlmsc2+SKAtrnjnsK75mEEiyg7Q==
X-Received: by 2002:a17:902:5581:b029:da:a817:1753 with SMTP id g1-20020a1709025581b02900daa8171753mr17030542pli.76.1608574193380;
        Mon, 21 Dec 2020 10:09:53 -0800 (PST)
Received: from [192.168.1.70] (ip72-195-250-206.ph.ph.cox.net. [72.195.250.206])
        by smtp.gmail.com with ESMTPSA id w63sm17017843pfc.20.2020.12.21.10.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:09:52 -0800 (PST)
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
To:     mdalam@codeaurora.org
Cc:     vkoul@kernel.org, corbet@lwn.net, agross@kernel.org,
        bjorn.andersson@linaro.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sricharan@codeaurora.org
References: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
 <6c85436d-e064-367e-736b-951af82256c8@linaro.org>
 <9769c54acf54617a17346fea60ee38b6@codeaurora.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <8c86f4db-9956-10d1-b380-a207137b50ef@linaro.org>
Date:   Mon, 21 Dec 2020 13:09:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9769c54acf54617a17346fea60ee38b6@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/21/20 2:35 AM, mdalam@codeaurora.org wrote:
> On 2020-12-19 09:05, Thara Gopinath wrote:
>> On 12/17/20 9:37 AM, Md Sadre Alam wrote:
>>> This change will add support for LOCK & UNLOCK flag bit support
>>> on CMD descriptor.
>>>
>>> If DMA_PREP_LOCK flag passed in prep_slave_sg then requester of this
>>> transaction wanted to lock the DMA controller for this transaction so
>>> BAM driver should set LOCK bit for the HW descriptor.
>>>
>>> If DMA_PREP_UNLOCK flag passed in prep_slave_sg then requester of this
>>> transaction wanted to unlock the DMA controller.so BAM driver should set
>>> UNLOCK bit for the HW descriptor.
>> Hi,
>>
>> This is a generic question. What is the point of LOCK/UNLOCK with
>> allocating LOCK groups to the individual dma channels? By default
>> doesn't all channels fall in the same group. This would mean that
>> a lock does not prevent the dma controller from not executing a
>> transaction on the other channels.
>>
> 
> The Pipe Locking/Unlocking will be only on command-descriptor.
> Upon encountering a command descriptor with LOCK bit set, the BAM
> will lock all other pipes not related to the current pipe group, and keep
> handling the current pipe only until it sees the UNLOCK set then it will
> release all locked pipes.

So unless you assign pipe groups, this will not work as intended right? 
So this patch is only half of the solution. There should also be a patch 
allowing pipe groups to be assigned. Without that extra bit this patch 
does nothing , right ?


-- 
Warm Regards
Thara
