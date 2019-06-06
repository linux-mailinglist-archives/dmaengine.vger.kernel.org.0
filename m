Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564BC37BA7
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfFFR42 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 13:56:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35375 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfFFR40 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 13:56:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so2906770ljb.2;
        Thu, 06 Jun 2019 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ypu9yesBsK3nZ3WNQW/z70b8cFn+k8rJ5hY1PK+94RY=;
        b=jK8nfl4iev447eqDDOo0DHFrAEVpNo92GOvACQbKwq2uank7tOHRXLB9ihq8BgNVn+
         XaIs1DgsJ3WQ+JIVcjPggv+p6smZ+ia0L4pe85/szO29YD9g7an9ITehaLLAmUc79ZG+
         krbKRxQlM8KkodCmvgZld8+2kj4OxUJIOfUThNMAX8laR1xhjhmG5b+P2OpV/Va2GOvn
         PGe/Pa58LdX9ypIh9auGNaGG4hEzKcPTKYMPT9p9pAlx31DiIslvQymDXHnqj9RlFcJ9
         NDTVrTBbshQ7M7ltdghdv74tuQdXYyn34xYGQkDGnZEHi3pRb234Ni5gqsqsJSTtax4t
         Cy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ypu9yesBsK3nZ3WNQW/z70b8cFn+k8rJ5hY1PK+94RY=;
        b=q4JYcRJ6LgZkYtg6tdoKKd3yj6Qe0ZbQyp8ASuk+GsJDnptIODqWMFc3Go1DxIxndu
         M+z/fIkzm1MVl5UrgfrLkiJkQLOpryb55yiWcd+giU8GgWyEd3lIcM+Y7V4eu5NImueb
         3b2snY01nfWyoMFDfGQHRb+7r3c2oONgyEGHVYZhDxyVIOSO31kApVcGj6/lrqb+yIaU
         /WW56WaGsghB0NeeFHrmEEaQ8KuSKK4+4dQ9n8RlLy3yRC4zsjB5XW1sIU+YZ7xU5+8g
         Bjxc+e8bjFevg//J4ZNYbkd26hHf2tpQFJpcNFUi9KahW41IQ4l8UAwt7GWfZLOU4LJU
         sJgw==
X-Gm-Message-State: APjAAAWmbdMK238nGUDZUC4RkfljhlJd+1s1dKeO/x+WI+IMtnrjjdlH
        qAI46tYrB2kDUY88GBUqyE+JFtV9
X-Google-Smtp-Source: APXvYqz7M2NP5kCWR+y8c0p6FMz8K7hG2iEUno+KL37IflNEKBBse9Jre3hDHpZI7QH9xMHDTiZzKQ==
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr25343396ljk.176.1559843783549;
        Thu, 06 Jun 2019 10:56:23 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id j7sm513504lji.27.2019.06.06.10.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 10:56:22 -0700 (PDT)
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, tiwai@suse.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
 <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
 <8a5b84db-c00b-fff4-543f-69d90c245660@nvidia.com>
 <3f836a10-eaf3-f59b-7170-6fe937cf2e43@ti.com>
 <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
 <a08bec36-b375-6520-eff4-3d847ddfe07d@ti.com>
 <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
 <deae510a-f6ae-6a51-2875-a7463cac9169@gmail.com>
 <ac9a965d-0166-3d80-5ac4-ae841d7ae726@nvidia.com>
 <50e1f9ed-1ea0-38f6-1a77-febd6a3a0848@gmail.com>
 <4b098fb6-1a5b-1100-ae16-978a887c9535@nvidia.com>
 <e6741e07-be0c-d16b-36d7-77a3288f0500@gmail.com>
 <a652b103-979d-7910-5e3f-ec4bca3a3a3b@nvidia.com>
 <457eb5e1-40cc-8c0f-e21c-3881c3c04de2@gmail.com>
Message-ID: <307ade99-757a-ac75-6358-28f8e5dd9596@gmail.com>
Date:   Thu, 6 Jun 2019 20:56:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <457eb5e1-40cc-8c0f-e21c-3881c3c04de2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

06.06.2019 20:25, Dmitry Osipenko пишет:
> 06.06.2019 19:53, Jon Hunter пишет:
>>
>> On 06/06/2019 17:44, Dmitry Osipenko wrote:
>>> 06.06.2019 19:32, Jon Hunter пишет:
>>>>
>>>> On 06/06/2019 16:18, Dmitry Osipenko wrote:
>>>>
>>>> ...
>>>>
>>>>>>> If I understood everything correctly, the FIFO buffer is shared among
>>>>>>> all of the ADMA clients and hence it should be up to the ADMA driver to
>>>>>>> manage the quotas of the clients. So if there is only one client that
>>>>>>> uses ADMA at a time, then this client will get a whole FIFO buffer, but
>>>>>>> once another client starts to use ADMA, then the ADMA driver will have
>>>>>>> to reconfigure hardware to split the quotas.
>>>>>>
>>>>>> The FIFO quotas are managed by the ADMAIF driver (does not exist in
>>>>>> mainline currently but we are working to upstream this) because it is
>>>>>> this device that owns and needs to configure the FIFOs. So it is really
>>>>>> a means to pass the information from the ADMAIF to the ADMA.
>>>>>
>>>>> So you'd want to reserve a larger FIFO for an audio channel that has a
>>>>> higher audio rate since it will perform reads more often. You could also
>>>>> prioritize one channel over the others, like in a case of audio call for
>>>>> example.
>>>>>
>>>>> Is the shared buffer smaller than may be needed by clients in a worst
>>>>> case scenario? If you could split the quotas statically such that each
>>>>> client won't ever starve, then seems there is no much need in the
>>>>> dynamic configuration.
>>>>
>>>> Actually, this is still very much relevant for the static case. Even if
>>>> we defined a static configuration of the FIFO mapping in the ADMAIF
>>>> driver we still need to pass this information to the ADMA. I don't
>>>> really like the idea of having it statically defined in two different
>>>> drivers.
>>>
>>> Ah, so you need to apply the same configuration in two places. Correct?
>>>
>>> Are ADMAIF and ADMA really two different hardware blocks? Or you
>>> artificially decoupled the ADMA driver?
>>
>> These are two different hardware modules with their own register sets.
>> Yes otherwise, it would be a lot simpler!
> 
> The register sets are indeed separated, but it looks like that ADMAIF is
> really a part of ADMA that is facing to Audio Crossbar. No? What is the
> purpose of ADMAIF? Maybe you could amend the ADMA hardware description
> with the ADMAIF addition until it's too late.
> 

Ugh.. I now regret looking at the TRM. That Audio Processor Engine is a
horrifying beast, it even has FPGA :)
