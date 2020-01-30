Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6686D14E3A2
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3UGS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 15:06:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38771 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3UGS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 15:06:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so4752212ljh.5;
        Thu, 30 Jan 2020 12:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5MtfyjIK8iIjsf2DswNSJhJWXPmE9JSASerKTR8hIHk=;
        b=Dfjjt1oJBm8Zv7HcUVqflmVkswBSaeNY1oyGduYay3CkUQkstffONIaynu+1fv8eTL
         qArLmejHHLOWYCjM0k54OTmjEtQqrvRSzJDmN+VBXZCsXuUd0r8tzS5wfxWylcOTIWpp
         Fd3T036r7GTGzbIs1WcoywQwBcIVqflDA5o4wzt3BeC9n31ck1XSu0DS0t+kybmvYEde
         YfRYCu9adTRSrobveMAIae0JVppeN9QqoZ9K8W6ar20RXASNUZmtsXUKwwd5O7qeafOp
         +/CAbeAgpWAgBaU1NIslo5ijNfwja1MIfFokWgl83gHD8aEO3UZaNh2r3nyw72nO2rCi
         Wd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5MtfyjIK8iIjsf2DswNSJhJWXPmE9JSASerKTR8hIHk=;
        b=an7OnvN7qXQA5ssVshsIzjkYS7mgOgNMi7AhoZwohkENWCFS3GXNviSAePwHdr8Zlj
         yxAPcH0MJGmqGAMEgnh9i353Xrf0UhKfoZm4a9um1KX0n2gvyYivd7EJnu8x5ZEBJk0T
         /looD7DPyUbmW5FOlOyHekFJZSdwAp7QX2Gs7ohcZtpDo4iMQ2fpmENt/+nzySkhE3CH
         yNxX5O7E4TttNuPrua0/lGElCUBUmSlbpAIjccJFnDww5wRUVQDzqM3W87id08X5Em05
         GZemZuzAaiNT/OFOqsKPLAfDnPcEiwO/JgSYEnU8DgQd77SgbvIT+01T5zFwFO+5peDy
         T/tw==
X-Gm-Message-State: APjAAAXoi4pxWT9mofHNagnNz8OwZLZI40RBaZVKoDzCR39YvAkBAISq
        86qKukNYyxdoekhPqds9I+hfiecY
X-Google-Smtp-Source: APXvYqyXwLnGLwg102wBTYCAiUt/EXf5IEfxXfCBcbMe98trvybQO7hUWy+nEDwU/LSwjKRV65eGiA==
X-Received: by 2002:a2e:9090:: with SMTP id l16mr3909709ljg.281.1580414775879;
        Thu, 30 Jan 2020 12:06:15 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u16sm3535567ljl.34.2020.01.30.12.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 12:06:15 -0800 (PST)
Subject: Re: [PATCH v6 12/16] dmaengine: tegra-apb: Clean up suspend-resume
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-13-digetx@gmail.com>
 <3507dcb9-4a92-8145-1953-e40960604661@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fb32d2e2-4cd3-c493-7792-3da62276cc07@gmail.com>
Date:   Thu, 30 Jan 2020 23:06:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <3507dcb9-4a92-8145-1953-e40960604661@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2020 22:00, Jon Hunter пишет:
> 
> On 30/01/2020 04:38, Dmitry Osipenko wrote:
>> It is enough to check whether hardware is busy on suspend and to reset
>> it across of suspend-resume because channel's configuration is fully
>> re-programmed on each DMA transaction anyways and because save-restore
>> of an active channel won't end up well without pausing transfer prior to
>> saving of the state (note that all channels shall be idling at the time of
>> suspend, so save-restore is not needed at all).
> 
> Maybe just update the commit message to state that the pause callback is
> not implemented and channel pause is not supported prior to T114. And
> then ...
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks, I'll update the message.
