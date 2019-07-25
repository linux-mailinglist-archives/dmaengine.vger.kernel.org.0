Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6879274FE5
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2019 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390185AbfGYNoM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 09:44:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35916 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389989AbfGYNoL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Jul 2019 09:44:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so48079657ljj.3;
        Thu, 25 Jul 2019 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zzq0V46zGQJFFxV1hhNVXna2f5OC8OivFBS02+sNjMg=;
        b=hSfaFMHLP3bpAZsdajQOfeEOf7tn9zZJSdN4l+ZCJ54jTkum1N8UB14d18rCvmuYMZ
         JxuWirUK64kwTMKQZxpw2NYnEi6V/DW6ytMNFgw+WuGM57/2XW8gSP9Ufai7cpX/yjjV
         IJatlpnlumVglK5tqgUl9IqN/y+KuP+4AjiRvGeVeb6zG4PZcofItZ/f9DxTPCXL5Uts
         2dvGBuAI/+6hI5WtUPehu6e5LqmQuDqwH7vOMpXsxFLfK1vmVt97YuEPcGbMbXYHGdN9
         so62rqOWM/nnu7uKzTEUCEAgh/MVkp1l9mhR61YIQgh7uTPfmGJ9TM//52IgxnccGWi5
         J6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zzq0V46zGQJFFxV1hhNVXna2f5OC8OivFBS02+sNjMg=;
        b=oir4mWSp8Mhabup7tSw0sFLsey1W75cxr2QgEytQIofB7y+q2oFsf2qAcJzHeMketR
         Ihtchyg8fCThmz3X2caQYC0SyhuadNfq2zug3Lrcxt+kclXomuSuK3g2rh95tNm3DdQT
         OjmFyyf56KvZh7foX+EIWsrYZe/655DMrl4Mb4J+xSUU5qXUpspCI2QaXhFCkWJo69I+
         P57XVC0rfFpYDrSF1v5iv6XLj78FitaBwmgHczI1RyCPol3Xfvc0Fu9YXH24Fu77DoPK
         7cMPyTT0WCsIAahkKq6Ej81rDs6L/NlZSru+RJh2fTpXb5qwySNBxZkLgC453IYoaDn6
         bStA==
X-Gm-Message-State: APjAAAWc3pxiuPu0VKREuLNKT06bOsAN7fWhOKF6JkMv2hLueSGpxTFA
        ASRbif73/BGvOvcAO5EJd83wjW1h
X-Google-Smtp-Source: APXvYqwJ+a86s+heHkK1HhGkllZIWeVy1ebTHF8Rvfu8Mx8SskthUAKh5juapodrki0bdDPCSESguw==
X-Received: by 2002:a2e:a311:: with SMTP id l17mr44793518lje.214.1564062249353;
        Thu, 25 Jul 2019 06:44:09 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id r5sm7554901lfn.89.2019.07.25.06.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 06:44:08 -0700 (PDT)
Subject: Re: [PATCH v5] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190705150519.18171-1-digetx@gmail.com>
 <20190725102613.GT12733@vkoul-mobl.Dlink>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e8dc55b5-586c-02a5-ec30-67bf39c87dda@gmail.com>
Date:   Thu, 25 Jul 2019 16:44:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725102613.GT12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

25.07.2019 13:26, Vinod Koul пишет:
> On 05-07-19, 18:05, Dmitry Osipenko wrote:
>> Tegra's APB DMA engine updates words counter after each transferred burst
>> of data, hence it can report transfer's residual with more fidelity which
>> may be required in cases like audio playback. In particular this fixes
>> audio stuttering during playback in a chromium web browser. The patch is
>> based on the original work that was made by Ben Dooks and a patch from
>> downstream kernel. It was tested on Tegra20 and Tegra30 devices.
> 
> Applied, thanks
> 

Thanks!
