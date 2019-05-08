Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF1317983
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2019 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfEHMhT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 May 2019 08:37:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44097 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfEHMhT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 May 2019 08:37:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so12590422lfn.11;
        Wed, 08 May 2019 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v7au5CCe/tAVeWfzeYAbhgqBsx7YkJZIcyvifTQduLU=;
        b=Ug84rc6uRecC9IhQA2zooKkTs0rIUlxauvTqkH+dlX9dxpCxyx5rBCNGf2CLSmnwk5
         Fyt6rYUqydF1K1DNTu8ltn/T68y/fvkHOx0davtUcDSz9trOYZdNGm9RXPZpJTz/VR/G
         uzZbRUnQzTenqOxXqfHEr5e2Oiz9VONPUYv0hGb+8aZl5nvysk06ARZy0iPbTZe30GjS
         r0RgihlqPzsCdlMUKOxcAhHDwCCU8CabSh7YHlTpxXruWDcqHJq02PVSM0fR59d/d35u
         K4YiNi7/eKrogkhmIQ01nGZ6b8i9/1UmEzeXbbgDVomk9eOgOzrjg5nDn4zr5gGdFUv0
         5Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v7au5CCe/tAVeWfzeYAbhgqBsx7YkJZIcyvifTQduLU=;
        b=t3ZDtQKPbtQaJ2y6NFf1bT4ceJ2U99jn0r/PsOngQBU6AEHO03PfOCIuIVl8UZOt1S
         Ha2Y3U6utHy+oi2WJTlBvGgn1L8Ibtii0L+XZwTrT2XQTFH+1o4CHC1GRIipPEn5aUDo
         NSSlXlTexMi7ekMOMedP/CiEpjjvWe1oZ1x1xnrDDks23V7JuSVvkoBrC0Jp7QE8Oq3g
         1d8TUDuwf8q4xd91tTiWIW0zyUxw8nGIy2Edf/TVJRe4XKeWXwLD2+45AzQInW7qRL07
         EwIOIisDIbCw6E5qB8jaIlhY8gkx2YgPGMtRa5k0g47f1P6mH+lmk0lxSvsJNoc2QLd6
         iWVA==
X-Gm-Message-State: APjAAAXIuCd9LYKvArdpQT5c/M7Xq0w+IdDBlstjxvt2zJ/09TutLmql
        FeqtzWVKYeP3N0ylU5xd6LiIMXOv
X-Google-Smtp-Source: APXvYqzaQoM2ZOXGyH8zy4/azzZrir3MBRJu2rAdTrgWh8SPV96vqARK/cGoOxkCRZPDEuF9X6N9KQ==
X-Received: by 2002:ac2:4148:: with SMTP id c8mr17889881lfi.2.1557319036956;
        Wed, 08 May 2019 05:37:16 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id d23sm3675396ljj.38.2019.05.08.05.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 05:37:15 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Handle DMA_PREP_INTERRUPT flag
 properly
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190505181235.14798-1-digetx@gmail.com>
 <287d7e67-1572-b4f2-d4bb-b1f02f534d47@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cbe8352c-c1c7-12a7-c658-82e7ffee0be8@gmail.com>
Date:   Wed, 8 May 2019 15:37:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <287d7e67-1572-b4f2-d4bb-b1f02f534d47@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

08.05.2019 12:24, Jon Hunter пишет:
> 
> On 05/05/2019 19:12, Dmitry Osipenko wrote:
>> The DMA_PREP_INTERRUPT flag means that descriptor's callback should be
>> invoked upon transfer completion and that's it. For some reason driver
>> completely disables the hardware interrupt handling, leaving channel in
>> unusable state if transfer is issued with the flag being unset. Note
>> that there are no occurrences in the relevant drivers that do not set
>> the flag, hence this patch doesn't fix any actual bug and merely fixes
>> potential problem.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> From having a look at this, I am guessing that we have never really
> tested the case where DMA_PREP_INTERRUPT flag is not set because as you
> mentioned it does not look like this will work at all!
> 
> Is there are use-case you are looking at where you don't set the
> DMA_PREP_INTERRUPT flag?

No. I just noticed it while was checking whether we really need to
handle the BUSY bit state for the Ben's "accurate reporting" patch.

> If not I am wondering if we should even bother supporting this and warn
> if it is not set. AFAICT it does not appear to be mandatory, but maybe
> Vinod can comment more on this.

The warning message will be also okay if it's not mandatory.
