Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE619D8B0
	for <lists+dmaengine@lfdr.de>; Fri,  3 Apr 2020 16:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgDCOJr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Apr 2020 10:09:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41858 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCOJr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Apr 2020 10:09:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 033E9jJ1061866;
        Fri, 3 Apr 2020 09:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585922985;
        bh=x82XtfYhNThrV4V+N+0uVz7ohtlRFiEl7i3LOb0N3S4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eRA2jbwVJV7Jz3emvo6zcbBp9UdFp3AzMTagHWPZFPwOZlJljmnIPpOgGn3DAstYZ
         qCCCxw/vovfSLWIiXRTMoeQDee+ptfsPldRctIRfj34sPh6uQ/UizgzftDd5K4gND9
         4ZyN2jXMR2qgJaVs+B6ry3eXRZgw7yxAbOD5eF+4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 033E9j04027400;
        Fri, 3 Apr 2020 09:09:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 3 Apr
 2020 09:09:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 3 Apr 2020 09:09:44 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 033E9hEY101749;
        Fri, 3 Apr 2020 09:09:43 -0500
Subject: Re: [GIT PULL]: dmaengine updates for v5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200402112500.GJ72691@vkoul-mobl>
 <CAHk-=wi81+9roQMgf7n0YRxJ0rqK3W0ghB3tS3kngSikC7cOig@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b4edfea1-ef1b-70bf-cae9-da1276ab8bef@ti.com>
Date:   Fri, 3 Apr 2020 17:09:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi81+9roQMgf7n0YRxJ0rqK3W0ghB3tS3kngSikC7cOig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Linus,

On 03/04/2020 2.28, Linus Torvalds wrote:
> On Thu, Apr 2, 2020 at 4:25 AM Vinod Koul <vkoul@kernel.org> wrote:
>>
>> Here are the changes for this cycle. SFR has told me that you might see
>> a merge conflict, but I am sure you would be okay with it :)
> 
> It looked trivial enough. That said, it's in the TI_K3_UDMA driver,
> which I can't build. The driver is marked as COMPILE_TEST, but it also
> has
> 
>         depends on TI_SCI_PROTOCOL
>         depends on TI_SCI_INTA_IRQCHIP

Right.

> which means that it depends on TI_MESSAGE_MANAGER, which in turn has a
> 
>         depends on ARCH_KEYSTONE || ARCH_K3

And the INTA_IRQCHIP needs INTA_MSI_DOMAIN.
and the UDMA driver actually needs the ringacc.
It goes pretty deep it looks like.

> so it may be *marked* for build testing, but it doesn't actually get
> any outside of those builds.

Yep, sadly this is true.

> So I did the resolution that looked trivial, but mistakes happen, and
> I can't even build-test that driver..
> 
> Just a heads-up. It does look like it was _meant_ to be build-tested,
> but that intent didn't work out.

The merge was correct, thank you!

> Adding a COMPILE_TEST option to TI_MESSAGE_MANAGER gets things a bit
> further, but even then it doesn't actually build that driver because
> that TI_SCI_INTA_IRQCHIP dependency needs to be enabled too.
> 
> And that one doesn't even have a question, it's just a plain bool, and
> expects to be selected. Which the arm64 platform does.

Yes, I'll sort this out. I prefer my drivers to be compile tested.

> Anyway, to make a long story short: "the COMPILE_TEST marker is a lie".

I'll remove the lie for now and fix things up so I will have legal
grounds to put it back.

> So somebody should actually test my merge.

Tested, thank you again!

> 
>                   Linus
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
