Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F68E16BA36
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2020 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgBYHFR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Feb 2020 02:05:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33174 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYHFR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Feb 2020 02:05:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so12856304lji.0;
        Mon, 24 Feb 2020 23:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D6g4FFN+2/oVw+clsWyRcWM8iKy7VGLHSR27Eox3yHM=;
        b=g8vnnMgDO/kKH9FnhFtWoxZa4r+k8oIrtEVXMSPL/rAA3SNVTo3zhywXPgyZaHdvkz
         yyuIlnbgLXQ3cXGldW9tr3T9bj4NhUTDaWCwn4nF8NCL4C7cOJTymqJbmg1wX9yOAOHT
         Y2FThsgRQAxmkQeIwh4oEUIMAQHS9v9YGO9X9XGCtC7jkkNsEaI0PTFEvLJCQbny1yRs
         KoFXK1vjuJvD6wPBlAlsTjMrAwRO/7UDy8ld/koZ0PQbU5RL8swznH7Cq70MTJ5JpbCN
         PWM8aIN0yupzeriDf46m86JxZvearD7ef6QkSrThcu80Bmaf1wEql/YlABav0mCMWYs7
         wvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6g4FFN+2/oVw+clsWyRcWM8iKy7VGLHSR27Eox3yHM=;
        b=NrTKYV06D2m6LFxp7atVpb9p/jbFJGJlJYyDPo131M9iMwO1Zz+b1tKFLP7z9KCtw8
         UwwYMz0233E6JRNIWHptZGZe8rZyz4Xzbrtjgyn7qLm0fWr0TrTv3d/mPSYDtrq8W2Du
         G1ThdvcbhL9QTiwL3nrNmC6PZWK+KyPGoSclxOtoraxfTjex7DAIE9gNuS2naUTeuaoe
         dgS22UkxSZgjStrY4wIke4LjH+cB6SrmzIMipDXdKp5I167AUUAx6sTzenO/HG32xucU
         yQwV2WzWnuLl49L4FbA9PQtIGj2Bpb1WGx29VFlWRZ0CC8ahjg+JvsKtnUuMitFvDGj2
         Ho0Q==
X-Gm-Message-State: APjAAAWC/6rFLPJb6Mi3PpkDWnhOJvOb58WStAa5/DLZlsP795ZpQ31n
        9Mk0zv34cxaGkTvDOnh3FSWPXPRQ
X-Google-Smtp-Source: APXvYqxqb3bIiRuvkdOQq4qHLS9yorrChDkfPCKN/aAxnhXVtgL2Fb/IO7BcwvR4aRVVc8zExU7BaQ==
X-Received: by 2002:a05:651c:1bb:: with SMTP id c27mr33756662ljn.277.1582614314466;
        Mon, 24 Feb 2020 23:05:14 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id b30sm6788895lfc.39.2020.02.24.23.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 23:05:13 -0800 (PST)
Subject: Re: [PATCH v8 00/19] NVIDIA Tegra APB DMA driver fixes and
 improvements
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200209163356.6439-1-digetx@gmail.com>
 <20200225063200.GL2618@vkoul-mobl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <84308985-5417-eead-7edc-4984193009b0@gmail.com>
Date:   Tue, 25 Feb 2020 10:05:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200225063200.GL2618@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

25.02.2020 09:32, Vinod Koul пишет:
> On 09-02-20, 19:33, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series fixes some problems that I spotted recently, secondly the
>> driver's code gets a cleanup. Please review and apply, thanks in advance!
> 
> Applied, thanks
> 
> One note I would like to add thanking you and Jon for the series :)
> 
> This version was pleasure to read. A patch should do *one* thing and
> this series really illustrates this principal and as a result I enjoyed
> reading the series and was able to do a quick review of the series,
> notwithstanding the fact that it had 19 patches. So thanks to you and
> Jon (i know he pushed for split etc) for the wonderful read.
> 

Thank you very much!
