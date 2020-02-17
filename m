Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B16161542
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2020 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgBQO4l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Feb 2020 09:56:41 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38831 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgBQO4l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Feb 2020 09:56:41 -0500
Received: by mail-lf1-f50.google.com with SMTP id r14so12082098lfm.5;
        Mon, 17 Feb 2020 06:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=deWPm8yN9kcmmTRRZQ/czJmxbT7YJ6dCNZrwugRjTHM=;
        b=dlCRJscS/I7Zjgd5XJfOSQ/pObZ4jf3//Faf5uosezUK3bOO0DGDi41z3BirhmaeHi
         dPd9KPqWcXbveMKYkIpbcraqHsrY42cuusdCP4TjuKycUna4lFoCPYPHHcD9XSuYRgKv
         aQyNarFffbvKa1rj3clZd7VhnSn57hbBEPjoJ1laXPtxDB1hkXaMxtFAgkFQSmWR9JB3
         /wCsUklaZzTpEmyQSK3Akfk56CK25k/muMynmhUXCZgvfKhvmSjg/ud4M5qa31h5cpy/
         fSNE3mNLNWjw3mQqucj7Djdz1l+aNodC5xPMO4WFEgtpWNKJtHqgS5iY4t304gIXr/3J
         XCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=deWPm8yN9kcmmTRRZQ/czJmxbT7YJ6dCNZrwugRjTHM=;
        b=hHXYxSOz/uhOo8mnM8Chj5EIEEdMiIgV7wG6fGEYcHnEcSpCkpOrjQlFkt2eHUtOMn
         zBqG+NKWi+7I+ybxYPGG6s5YPZHcBRgKkW4j6DL97DHp27Wth5gMMrFydkbcFG2coHym
         q5+z3hzXpryRmo5csFFybSDyItpzQ9bk11PV9FO0Q6qidZRLlDc28BsZ7dYmhoccXSHU
         tIh4VXVXwsaWVcLxhjuBfsLU27otl45/js0weYJMuEyrw68uFBewkQdzfdz7Rydtt4tY
         SVPvv1BPaPmjHUsT3+5sxsrRuW6B1i0oG8b5KeNFqg3k32Dd8/d52HPmwtCrdz/rqNmj
         8Q2Q==
X-Gm-Message-State: APjAAAWeg1r35IpIz+tvG7fCraYbPMoOJdi6vdlcEYhRD087RulosRXq
        vtlUx0us1I/mCoNQeO2tUrkTB2Xa
X-Google-Smtp-Source: APXvYqyXuS84xRTVNL121HCAGGjTInIwaY98cdty84WeBg4/IE+anNryNYLokxK8DyI86f5Dyir10A==
X-Received: by 2002:ac2:5388:: with SMTP id g8mr8123002lfh.43.1581951398567;
        Mon, 17 Feb 2020 06:56:38 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id p15sm470882lfo.88.2020.02.17.06.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 06:56:37 -0800 (PST)
Subject: Re: [PATCH v8 18/19] dmaengine: tegra-apb: Remove unused function
 argument
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200209163356.6439-1-digetx@gmail.com>
 <20200209163356.6439-19-digetx@gmail.com>
 <d9a1bd6a-bd26-36ad-7d94-57801a2aa616@nvidia.com>
 <392ccaf4-3cc9-e8af-130c-fa068cc56527@gmail.com>
 <f9ea6be9-71d6-0119-eade-fe06bbbcbd5b@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1d10367e-4e1c-3d25-2e80-e601b34a01d7@gmail.com>
Date:   Mon, 17 Feb 2020 17:56:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f9ea6be9-71d6-0119-eade-fe06bbbcbd5b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

17.02.2020 14:15, Jon Hunter пишет:
> 
> On 14/02/2020 16:54, Dmitry Osipenko wrote:
>> 14.02.2020 17:16, Jon Hunter пишет:
>> ...
>>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>>>
>>> Thanks!
>>> Jon
>>>
>>
>> Jon, thank you very much!
>>
>> In the patchwork I see that you acked all the patches, but my Gmail
>> missed 2 of 4 emails, maybe the missing emails will arrive a day later :)
> 
> Yes all should be ACK'ed now. I did receive an email from our mail
> server saying that there was an issue and the message was delayed. So
> not sure if you ever got it.

The emails arrived a day later, just like it was predicted :) Thank you
very much for reviewing the patches!
