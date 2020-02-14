Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CD915E796
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405752AbgBNQyo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 11:54:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35362 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406842AbgBNQyn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 11:54:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so11492282ljb.2;
        Fri, 14 Feb 2020 08:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M+xcBhgbl/QZucNqUQYoyGs+ziRhICQEGd1M8X6NrGI=;
        b=qdWAeOGFDeOv5wfAKoUl5Jh5aIfShyW/vDnFB2Tlc2qILXY/JENzB13kx6M6Vkmlx0
         UhHdujnOrzAF40kToU3Hy8YmDfhFaVp2kLx+BdffV6ukghYBSnbpj1IA44vb7Ig8H76R
         hupUzDBpkRUjQ7a1Nv9CvbpN6ACN046Ij9cuT4M2J4pI5hYgNnaDz5Q9xGl9T625Pu0l
         lqNacWBs3GyaLGcqngjNLtJgcaztbJ5kMkqDLKhJE9C5MmauboNn87Mu9Ts/rOwHWhLa
         lNspxcKNd/luThLR2iyhvIUwjNmdQ5zVq5Oixd+N5zHR2JKhvhfkafKhjdMvyx+YGtfV
         LPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M+xcBhgbl/QZucNqUQYoyGs+ziRhICQEGd1M8X6NrGI=;
        b=BWuQh9J5mX/aDKLLB6WFFaz3FAouqlS6w87VkvABEEru6yOIOc4opr1IYh+sVW1vkm
         EFCL7/i0Au/0CWjmuTAwAKpCNngzf32bSe4FyEK8rmBWHF69Cqb924IfBx2qprMwX7bn
         b/G481ryJKs92CJCzkpx2TZT+R6uTk6j0n3GXpDg6P1eEJpbFT+v/cwi1qBNlRQGW3/W
         GmCjZYSCpNiWqk/h22oTblyoJNuNrjYagfIyteMMuLuW+3HBxagxf1SCPyxqFc3adL4H
         gLnSrUCCbbJa3j10NyN1ziUlOCMXCcpsFSSPsDlHPnELmbKIcfG85MNGTCylqJvG6mWJ
         O9kA==
X-Gm-Message-State: APjAAAU01Tg2Cw+vvJnU4/UQtsBdb6At0V4NfNYuk4iEIn6wvB8Cnqda
        W8OvP+HLKCY5+maTihIS5Z9hU6pH
X-Google-Smtp-Source: APXvYqzda8qC12k53RKnJkNfCJ72RN8KGm4vqHZRZS17lW5MdtXW5KQ3q7U329LktiiBDc6QK23MbQ==
X-Received: by 2002:a2e:58c:: with SMTP id 134mr2615105ljf.12.1581699280824;
        Fri, 14 Feb 2020 08:54:40 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f5sm3244423lfh.32.2020.02.14.08.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 08:54:40 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <392ccaf4-3cc9-e8af-130c-fa068cc56527@gmail.com>
Date:   Fri, 14 Feb 2020 19:54:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d9a1bd6a-bd26-36ad-7d94-57801a2aa616@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

14.02.2020 17:16, Jon Hunter пишет:
...
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Thanks!
> Jon
> 

Jon, thank you very much!

In the patchwork I see that you acked all the patches, but my Gmail
missed 2 of 4 emails, maybe the missing emails will arrive a day later :)
