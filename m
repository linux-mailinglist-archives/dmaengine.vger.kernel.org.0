Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034BDE233D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 21:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbfJWTT4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 15:19:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40095 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387989AbfJWTT4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 15:19:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id u22so4293385lji.7
        for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2019 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bjb6E5o86jRaWkMUAMaUmOeuRzJYRhMdLd2b26gDTww=;
        b=nmiJoJ8l1o9knls8nsIWmUpDi5FlEUu3SbVzMufRfoCa8k71fcAIUu6uRG5rhsOUZq
         nOt5gP4Fwd8kLkbvIBdckJ/Fe2eugM0y9cAipqL8cQJgz97BlKPmarLSou+harWormyS
         o+U2FQSfYk91d0xFzPzs4I8SAU4yG288VCwI/CCrw3yFN93ujzv55Kurj3ghes70kbHB
         ohg2oLxoZSDExctnRbL/WtFRbbYhu1tCwQ8m9Z6Wg8OVg+fIn2an0rTKdpx20ItXaFVv
         QQSPJ3cM+qqGLTm4AEBSVQ7CwcpdsgGQF4V35EQn+n4ttGyp03QCXdO8s6B0z1pDF2dg
         wGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Bjb6E5o86jRaWkMUAMaUmOeuRzJYRhMdLd2b26gDTww=;
        b=eH11i7/KWobv5VqdptcKHKaJZx4TRVAxAGHtplldxHa4izlYtqsZOfVM3y0fqBgHx4
         xC3FLK3X026FzL1JUEazVF9R9WC2BEKYvK25pqP1QEcnN2jWbVVXp7Wn7rLZebrNnnF9
         xQ3UxspIgdtoRND/2CupqyZ1SeF2N49G6npSPLRFjUd09lFyqEtv8TvYUhJw5I7Gs+yN
         q7bCjubZO4+LaFwBmyfLuwvhTBxkCOgXwAYKVlMjiaR9Q9KZvsh8Sauv6cralIUbbx76
         aDHhbgpIQa3NkUrYyeICJ4CUbus4KCjKE716zACjxj9nWRSoU8auZHEomjg2hAf083h3
         IOHQ==
X-Gm-Message-State: APjAAAUgBCnD7POgrpycvXnXiL4SztohQxtU2g6EQfmb5WFGN68U4sEA
        7GghizEFIiF/TPqlbAS+OzhP7A==
X-Google-Smtp-Source: APXvYqyp+ELRQOy9DNzDhRPqQaZJ9rdA1w3HqxPMLTejDtvzPI+0Q0HoViasfZ4qVRRNhvvbMQUQmA==
X-Received: by 2002:a2e:878a:: with SMTP id n10mr24044289lji.229.1571858393968;
        Wed, 23 Oct 2019 12:19:53 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4201:cc87:e4a0:50f7:ca47:8e61])
        by smtp.gmail.com with ESMTPSA id m28sm3215287ljc.96.2019.10.23.12.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 12:19:53 -0700 (PDT)
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when
 idle
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        George Cherian <george.cherian@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        dmaengine <dmaengine@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        giulio.benetti@benettiengineering.com,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
References: <20191023153138.23442-1-tony@atomide.com>
 <6996a5de-215b-f9a2-1aeb-5eeed1b7cf8d@cogentembedded.com>
 <CAHp75VfyTJ+ptA8+AAgRgUNETLu=5EBc=bO7tmNhgxtdQq4EUw@mail.gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <71b9a4ad-4f60-9edd-7dc4-ba4642b7748b@cogentembedded.com>
Date:   Wed, 23 Oct 2019 22:19:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfyTJ+ptA8+AAgRgUNETLu=5EBc=bO7tmNhgxtdQq4EUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello!

On 10/23/2019 09:58 PM, Andy Shevchenko wrote:

>>> +     int error;
>>> +
>>> +     error = pm_runtime_get(cdd->ddev.dev);
>>> +     if (error < 0) {
>>
>>    I'd call that variable 'status', comparison (error < 0) just doesn't look right.
>> If it was *if* (error), it would have been more correct.
> 
> It's error when it's negative. That's how PM runtime is designed.

   Most of the other code too. However, the RPM code tends to return 
positive values if a call is OK, so you have to go greater lengths and
check a result for < 0. Calling the variable 'error' doesn't seem right
in this context...

>>> +             pm_runtime_put_noidle(cdd->ddev.dev);
>>> +
>>> +             return NULL;
>>> +     }

MBR, Sergei
