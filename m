Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8EA14CC98
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 15:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgA2OiZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 09:38:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44957 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgA2OiY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 09:38:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so18665360ljj.11;
        Wed, 29 Jan 2020 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x9cas/+X1zyUKvZrT+ywQG9cQsvEI2jODuyH9GxwbZ4=;
        b=lZVdw08CSa/FCqccdPfm83wSXIKemZJusaCVbpfc0SzvXEu6kp8tSYtr2QpidS5Nu0
         EKdgNOlgqnoiTsPb4oiFwa2juxxAZR0s3fqYfOPNmtxTsZV2glwBcaEtUokTUI8YwFQ9
         Xf25oFPCWI4vJ+lFzPdKw5SFcUBsspczaMyZTqPGn/WXbO2bqutA80e3eY2ofdE9UcEg
         TzxeSehx91bDZMPwiWHrjzOoxPwqZDsOZHUk2ARfeTz8xh9rPBGuMYQecrj5a5EfF/31
         WcGbXT492A4+WFkmUsUg2hvwUQooMDgMo4x/GL1NhJeU3lVjuM+ImSeZO31BDIm/vsya
         ObGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x9cas/+X1zyUKvZrT+ywQG9cQsvEI2jODuyH9GxwbZ4=;
        b=EWQy3O6h5GgdBiAx0YOvOhVHNU+r/MqlGkuwOMvfvfX9V/wR6Y1lDYPGs92YHUrRuP
         Lk+COrhvZklEnQbUJEy41f++qrnAssw9eC658pJhPYzr7ioKKQmnXQnIRA5plYq2ABKf
         4NH1ImRa56XsjPOQmDTS+kVtGstymF8OrUfP67f55SiLIGeExpeFN0FnUCC8koZk06mp
         nTG31/4TFNczoyu3HF+rmxUS7XUtbIdrs304a6BZ/lFRU8uDM0h8/ajqXO/myVdxk1FX
         tmZ/yGW/BAVMAq+7mEA1GQTuMTZbGDpiYxrvGLHdvwgxaGTnTGgPzcP8MTYHQtCYfLdG
         id6A==
X-Gm-Message-State: APjAAAUSZfvBkWXFaHOj3xGUKnX3IeMRN5GpYSsDVhc9oZhMDxhra3UH
        bVOX1oRfvmSrCwT70Z8ERQejN8Xi
X-Google-Smtp-Source: APXvYqz9jEDhSAUeU3Qrzbt8F84n3Y5kQKwkmX9toAPTv/ttf0K+IPzfxPVGwKu96wXuX6Z3tlV3Yw==
X-Received: by 2002:a2e:88d6:: with SMTP id a22mr15515824ljk.163.1580308701573;
        Wed, 29 Jan 2020 06:38:21 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id n11sm1072323ljg.15.2020.01.29.06.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 06:38:20 -0800 (PST)
Subject: Re: [PATCH v5 01/14] dmaengine: tegra-apb: Fix use-after-free
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200123230325.3037-1-digetx@gmail.com>
 <20200123230325.3037-2-digetx@gmail.com>
 <858021de-62fd-2d21-7152-42af4e3a04b2@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <362d18b9-e928-bcdd-9183-88e2d487ba22@gmail.com>
Date:   Wed, 29 Jan 2020 17:38:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <858021de-62fd-2d21-7152-42af4e3a04b2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

29.01.2020 13:56, Jon Hunter пишет:
> On 23/01/2020 23:03, Dmitry Osipenko wrote:
[snip]

>> Cc: <stable@vger.kernel.org>

^^^

>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
[snip]

> Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!

> I think that we should mark this one for stable.

This one is marked already ;)
