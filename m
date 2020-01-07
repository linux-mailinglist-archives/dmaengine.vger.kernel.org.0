Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D614E132CBA
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jan 2020 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgAGRMu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jan 2020 12:12:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45482 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgAGRMu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jan 2020 12:12:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so242380lfa.12;
        Tue, 07 Jan 2020 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b6uJhncOje5k5j8JgdUT1915LVoXHzLCLy0HXT+ESDM=;
        b=eQMxTCNDkkImyT+meRspXjEYMXtYGwHD7PHKqBo5qAwqFLLVzwJUONW9pfx3FCT4Sa
         WaXhx149BGna7obIB2c2YwTzRvDksikbr4O+G2Ejom7S9a7Fl1DCA/HRL/ZhJmdFZHb3
         nD05sPWfvpx+voYWKVlj0olYdVhSJARwZPr26OC7QphjWTDyAT2YLdp6q2fBwlA8K9vu
         E9Ap1tyCrTxBSK+oQOzHUxQ52jsVT2sZppUcK38j1x1f0pMULVnoEtRdSZhUz3sFhJCh
         w3t35zT5KWh2w0qQL5CmP83ncs4/hUrEdmjmjJgSCn1Uv+Q6j5Sh6JS7rpNcjfrLN70g
         ruKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b6uJhncOje5k5j8JgdUT1915LVoXHzLCLy0HXT+ESDM=;
        b=U9rX/VVoDIShLuGSEJqL6sfQLlF6eHRZx3Dt7I9+cHBhMwXYEr9QCUjnbz9WyfK2wQ
         lsp9CpdFCgScLn333WqGTolE7xlj8C6eeeSLKZ6ohnkkJ0B3bpzfpyeQiFho9ccHy3m4
         3FN6hwKw+2zJ/Ls/D3sMgTFZv/cuGKJdvsLpHhcZoqRFcd78FUCXgFDkBsyS/eA1hnmX
         u7SiGjRjWywIDIH5ww67dOxqqg1pEtobaJw+/58LZLWE3RXqisNo7eVS5fTsnuzD5kTo
         Fek/qvc3Wsh+6z0sJc5vC90mjfPi2JnxA1tNBiw+tsxQLMhszTL3QzsDbsLAnkXJe4Ce
         aXLg==
X-Gm-Message-State: APjAAAVuIEUTtbWDSKuGZeC7Ax8MBQjwqDr105cSAt1hY4BSs0esainQ
        rAQc8/yBbb0bA2FtBmIpJHQF4vQu
X-Google-Smtp-Source: APXvYqzdR/1BR2kEg1yM42XI/RhYE+PLQISkZSqmtH+r8XiHq2qd76cVOX8mwyovljS/xvEG57CvBg==
X-Received: by 2002:ac2:5468:: with SMTP id e8mr273096lfn.113.1578417167078;
        Tue, 07 Jan 2020 09:12:47 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i4sm134431lji.0.2020.01.07.09.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 09:12:45 -0800 (PST)
Subject: Re: [PATCH v3 09/13] dmaengine: tegra-apb: Remove runtime PM usage
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200106011708.7463-1-digetx@gmail.com>
 <20200106011708.7463-10-digetx@gmail.com>
 <f63a68cf-bb9d-0e79-23f3-233fc97ca6f9@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fd6215ac-a646-4e13-ee22-e815a69cd099@gmail.com>
Date:   Tue, 7 Jan 2020 20:12:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f63a68cf-bb9d-0e79-23f3-233fc97ca6f9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Jon,

07.01.2020 18:13, Jon Hunter пишет:
> 
> On 06/01/2020 01:17, Dmitry Osipenko wrote:
>> There is no benefit from runtime PM usage for the APB DMA driver because
>> it enables clock at the time of channel's allocation and thus clock stays
>> enabled all the time in practice, secondly there is benefit from manually
>> disabled clock because hardware auto-gates it during idle by itself.
> 
> This assumes that the channel is allocated during a driver
> initialisation. That may not always be the case. I believe audio is one
> case where channels are requested at the start of audio playback.

At least serial, I2C, SPI and T20 FUSE are permanently keeping channels
allocated, thus audio is an exception here. I don't think that it's
practical to assume that there is a real-world use-case where audio
driver is the only active DMA client.

The benefits of gating the DMA clock are also dim, do you have any
power-consumption numbers that show that it's really worth to care about
the clock-gating?
