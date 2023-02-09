Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5085D68FDA3
	for <lists+dmaengine@lfdr.de>; Thu,  9 Feb 2023 04:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjBIDBN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Feb 2023 22:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjBIC7L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Feb 2023 21:59:11 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A01A4AF
        for <dmaengine@vger.kernel.org>; Wed,  8 Feb 2023 18:56:37 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id z138-20020a4a4990000000b005175b8ae66cso95891ooa.6
        for <dmaengine@vger.kernel.org>; Wed, 08 Feb 2023 18:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeuDR87mT5oZz0xYPlgMzWTRgnSVFdT+RIi9fTOHK48=;
        b=cpXzCzr+cz0YwMg8OioZbOdFT6x6Xm6HxQuCqdoPsmS9hedulw1eO6Kk/3hEebcpma
         XmVmNXfmMApG2N79Si3uHiYwQf3pkrY8yoF8TXhNqwM63RW+rXEAr2c9GvCwLnpdMizZ
         /i8XL5yNmB4lLP5zpVm7le3plURiLI5xI0pF39yvS1te1cCGkPno0+9YUYvh8/jIQets
         PkfeCX7kq7oaaZINx71/ntTci+5+uSn1VJ3kfEYljJIBKf1cp8PDE/LSANc9+WdWamP2
         UdiemMHM1/q9NSBnjYTg3Wlj/GIvYnBRMQxV2QKkM2GCOhCzUuRGyTbkMr557hPEVKAp
         8+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeuDR87mT5oZz0xYPlgMzWTRgnSVFdT+RIi9fTOHK48=;
        b=QDtnwEXrDNUL8nfMqixUZddTyVGmMx5DDVRUB8S68XO6DuoG3mlCFFBBBuw8oWEzjK
         2ah33WIUm8isQuLHugmHvUQajd4osxNh5Ygh2soyPOchiu+AytbxIeoS9v9+RgfPyL0O
         iLCOOywadku17EeZ3/AJL4rwODj+HsbVTJtPfMMWLWTnLLIWND2QYWwm9kiIPCiwa+9R
         5zKD60vuk2Hf4SvLZZRXRQ+Tw4bushbtrajKU2L6qb7qBlOyhneewGuL2p1KbHbYY6G0
         55QW+635kI9dXi1Z4UFY7cVDberF8h1AY7uVcDWV/TGUItVzj0MDMWp66UrXj/5Gc1kc
         YwyA==
X-Gm-Message-State: AO0yUKVF6XVZqJGauBgTdHjSQaCyXfYoSmV2bEDKeTy3YqGzFEz6q7XO
        R4Yy+yN4OvkkExgKh/YXjEQ0HQ==
X-Google-Smtp-Source: AK7set/z8RwoK5zLi99e0gYyO0saoOIvr4Qi+M0w1VEg8sxij2tCPL/DbU7DENRObgoCAx8yBLGhmQ==
X-Received: by 2002:a4a:9b8e:0:b0:51a:48f4:75de with SMTP id x14-20020a4a9b8e000000b0051a48f475demr241022ooj.0.1675911397288;
        Wed, 08 Feb 2023 18:56:37 -0800 (PST)
Received: from [192.168.86.224] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id bm9-20020a056820188900b004f8cf5f45e9sm133765oob.22.2023.02.08.18.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 18:56:37 -0800 (PST)
Message-ID: <1c6e7a19-a650-1852-6f74-ca5547db44c4@landley.net>
Date:   Wed, 8 Feb 2023 21:09:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: remove arch/sh
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sh@vger.kernel.org
References: <20230113062339.1909087-1-hch@lst.de>
 <11e2e0a8-eabe-2d8c-d612-9cdd4bcc3648@physik.fu-berlin.de>
 <20230116071306.GA15848@lst.de>
 <40dc1bc1-d9cd-d9be-188e-5167ebae235c@physik.fu-berlin.de>
 <20230203071423.GA24833@lst.de>
 <60ed320c8f5286e8dbbf71be29b760339fd25069.camel@physik.fu-berlin.de>
 <0e26bf17-864e-eb22-0d07-5b91af4fde92@infradead.org>
 <f6317e9073362b13b10df57de23e63945becea32.camel@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <f6317e9073362b13b10df57de23e63945becea32.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2/8/23 06:13, John Paul Adrian Glaubitz wrote:
> Hi Randy!
> 
> On Tue, 2023-02-07 at 17:31 -0800, Randy Dunlap wrote:
>> 
>> On 2/7/23 01:06, John Paul Adrian Glaubitz wrote:
>> > Hello Christoph!
>> > 
>> > On Fri, 2023-02-03 at 08:14 +0100, Christoph Hellwig wrote:
>> > > On Mon, Jan 16, 2023 at 09:52:10AM +0100, John Paul Adrian Glaubitz wrote:
>> > > > We have had a discussion between multiple people invested in the SuperH port and
>> > > > I have decided to volunteer as a co-maintainer of the port to support Rich Felker
>> > > > when he isn't available.
>> > > 
>> > > So, this still isn't reflected in MAINTAINERS in linux-next.  When
>> > > do you plan to take over?  What platforms will remain supported and
>> > > what can we start dropping due to being unused and unmaintained?
>> > 
>> > I'm getting everything ready now with Geert's help and I have a probably dumb
>> > question regarding the MAINTAINERS file change: Shall I just add myself as an
>> > additional maintainer first or shall I also drop Yoshinori Sato?
>> > 
>> > Also, is it desirable to add a "T:" entry for the kernel tree?
>> 
>> Yes, definitely.
> 
> Geert has suggested to wait with adding a tree source to the entry until I get my
> own kernel.org account. I have enough GPG signatures from multiple kernel developers
> on my GPG key, so I think it shouldn't be too difficult to qualify for an account.

So you're not planning to use https://lk.j-core.org/J-Core-Developers/sh-linux
but push to kernel.org and ask Linus to pull from there?

> Adrian

Rob
