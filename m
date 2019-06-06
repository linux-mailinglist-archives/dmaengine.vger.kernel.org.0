Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB8379F2
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfFFQor (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 12:44:47 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:37243 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfFFQoq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 12:44:46 -0400
Received: by mail-io1-f49.google.com with SMTP id e5so732769iok.4;
        Thu, 06 Jun 2019 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NBsMfRuKTrjUWRbWIua1fvZvKysXDdRrLhHLJlMCHME=;
        b=rBk2vwzme22eGy5imGJ247qFBWoJ2gbU50Z7FWsuQ0q4oaeHHYONAUgT6DnLDG1wm0
         oYPOfSTQv42gC65LEmlkkBCbpaX/M28gMmBmywM8CtrRa0xNbnV5NEd8n+8RhFg5gDxk
         Nz0ik41bbd8/bLyoH5BiyqHziN2cmIGz1o/oejb9i73pFK9JvOWRZMOxcZPB8Z3UHQSJ
         A47IF4D9+KY/k5tXGgm6qyvDj4CP31xSYc0le7S31MEEsUqEZe8NbxbGIDHSn0/4jIH2
         WiTs5ErFEpCzFvsMTZEcPgPukKfm9UUcU7m5P2RaX6Iz4gaUa6KRzJtBl0wun2OvqTGg
         +HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NBsMfRuKTrjUWRbWIua1fvZvKysXDdRrLhHLJlMCHME=;
        b=VN2s55ujDiwhuvsG6fhW8ieBnE5sF9Dms2MCL90udmB5M7cFhcTCvVmc+P6a3UNsS9
         37A4WagMrBnsW+af3FXaUpuYuJGu7kg+/DZarroRIAuL3IepGBNP41KIZpWMczAQ3uVE
         5H+dvv9kFFKc7TJ22kDDJtbHOC61pTIPbv/SE25+LK8vT4VlfT+qfhC4PCh7kMxGAVZ8
         FzVcvgNAkCs6dJe4U/g+zPZYmGyGC3jf4xTmLO+Ydda6rrmackaiyTn5jknkA0YMoks2
         BnqWhpYfJCGSLt63C26t6DcDDPJXl84zrhGAFT+cmc4ZaPqocz5qnFrYI4GoSAOTVyFF
         XdGw==
X-Gm-Message-State: APjAAAXVkUS1V9vg+fnG4McJwswLDILqMaqraXcMijRUa5y2Vyyr04VH
        R/oBCt/Tw78jgcheNaULQmTSkh8J
X-Google-Smtp-Source: APXvYqx5n0J7ZI5aH/LEu5//p8quuu+03srrJFZqrx+sJYVBD+cGktH3UYlzbj3zMeuBqUfr6Og2kQ==
X-Received: by 2002:a5e:8704:: with SMTP id y4mr28492011ioj.135.1559839485574;
        Thu, 06 Jun 2019 09:44:45 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id 143sm1156389itw.9.2019.06.06.09.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 09:44:45 -0700 (PDT)
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Jon Hunter <jonathanh@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, tiwai@suse.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e6741e07-be0c-d16b-36d7-77a3288f0500@gmail.com>
Date:   Thu, 6 Jun 2019 19:44:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4b098fb6-1a5b-1100-ae16-978a887c9535@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

06.06.2019 19:32, Jon Hunter пишет:
> 
> On 06/06/2019 16:18, Dmitry Osipenko wrote:
> 
> ...
> 
>>>> If I understood everything correctly, the FIFO buffer is shared among
>>>> all of the ADMA clients and hence it should be up to the ADMA driver to
>>>> manage the quotas of the clients. So if there is only one client that
>>>> uses ADMA at a time, then this client will get a whole FIFO buffer, but
>>>> once another client starts to use ADMA, then the ADMA driver will have
>>>> to reconfigure hardware to split the quotas.
>>>
>>> The FIFO quotas are managed by the ADMAIF driver (does not exist in
>>> mainline currently but we are working to upstream this) because it is
>>> this device that owns and needs to configure the FIFOs. So it is really
>>> a means to pass the information from the ADMAIF to the ADMA.
>>
>> So you'd want to reserve a larger FIFO for an audio channel that has a
>> higher audio rate since it will perform reads more often. You could also
>> prioritize one channel over the others, like in a case of audio call for
>> example.
>>
>> Is the shared buffer smaller than may be needed by clients in a worst
>> case scenario? If you could split the quotas statically such that each
>> client won't ever starve, then seems there is no much need in the
>> dynamic configuration.
> 
> Actually, this is still very much relevant for the static case. Even if
> we defined a static configuration of the FIFO mapping in the ADMAIF
> driver we still need to pass this information to the ADMA. I don't
> really like the idea of having it statically defined in two different
> drivers.

Ah, so you need to apply the same configuration in two places. Correct?

Are ADMAIF and ADMA really two different hardware blocks? Or you
artificially decoupled the ADMA driver?
