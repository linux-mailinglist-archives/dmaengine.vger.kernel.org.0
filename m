Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF36256D8E
	for <lists+dmaengine@lfdr.de>; Sun, 30 Aug 2020 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgH3MMC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Aug 2020 08:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgH3MMB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Aug 2020 08:12:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77905C061573;
        Sun, 30 Aug 2020 05:12:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q13so1413346ejo.9;
        Sun, 30 Aug 2020 05:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qshWuo/PMDUT2LJmbVBMnw6b8Zf9zlNuTmEls1ekJ0U=;
        b=UsFqJfCX0P9KcqTkG3XSmY1iuH1x9+PnaSu9U6Nvjs7U+EWRLwOvUb5HJ9uHPkx2uc
         mN5Pt5hsv1IXTgEzHKqU7hXwsatu87CTl/FxsIfWfmRxjxe4KatgxXytg4OC/G36GbUu
         GGSMDgk8/+OHRuAatveS9SjHVLWS1LAa7xwUo0MQN5t6Hc7rmAxtewtb8DkAawb8ek+x
         2T/AvMyCvQ+NF79DFOBVCEkx+JEjTE7DXPZAGR8JS8zHjnUWptodtPW8I9TJIUg050io
         vpbUKkHBs6vTuRA7AxST1ivHK0GscrNxLNNBozlZ+LtOTn1ghlLYLqKerzDBHadHxFyY
         T4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qshWuo/PMDUT2LJmbVBMnw6b8Zf9zlNuTmEls1ekJ0U=;
        b=HaUH4rIDvJe0UBa9manaOgF+eW9KY/FQZJkGK/Y8WmnBmvs8YmQ99abplwm3jgtCP3
         jbcDAxBZEU8RhuAYaIfqJQkWMCILf7WwwAAV+E+p2ni4h8HRuHFZLeCPCYnPyoFu4/u8
         tEv0B3MxyO3yF41aqAGgbTK6P/V+G9vk5S9qKIWfbKcEo5kthQhyMGBng14Iy2IsKMfo
         Ms+n81mPuTe6W5vLpbEPEc/HTDQUoVlKw9gjj9tLGMFIiJASx+IYlJHWgLTHBp5iSfv0
         Glk33H5IJYjfGysV9RXXsjwvJ8rzQNM5tvXkqjWLyLBioZSg9qupBIJIBCteK7TgLxPn
         nk7g==
X-Gm-Message-State: AOAM532KTmxvbk1xebYv7ZVGSVUsDLX7hux5R/G/xuCCbke0o2q7I7Bd
        BUqN9M5SJKqeRFcp3O25Xf1IncgR5bo=
X-Google-Smtp-Source: ABdhPJxOJA5wZn5NrOfMFMOv1nhwV+b9MWXiMCq2DdY4+4H8iKGf7KEA59WSNTM7XyEIxhZtsuU0Qw==
X-Received: by 2002:a17:906:d182:: with SMTP id c2mr7289675ejz.378.1598789517357;
        Sun, 30 Aug 2020 05:11:57 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:64d5:3b87:7078:3025])
        by smtp.gmail.com with ESMTPSA id bn14sm5115767ejb.115.2020.08.30.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 05:11:56 -0700 (PDT)
Date:   Sun, 30 Aug 2020 14:11:54 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Guenter Roeck <linux@roeck-us.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        dma <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
Message-ID: <20200830121154.zo54k5ywpdk2rw4m@ltop.local>
References: <20200829105116.GA246533@roeck-us.net>
 <20200829124538.7475-1-luc.vanoostenryck@gmail.com>
 <CAHk-=whH0ApHy0evN0q6AwQ+-a5RK56oMkYkkCJtTMnaq4FrNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whH0ApHy0evN0q6AwQ+-a5RK56oMkYkkCJtTMnaq4FrNQ@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Aug 29, 2020 at 10:29:55AM -0700, Linus Torvalds wrote:
> On Sat, Aug 29, 2020 at 5:46 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > But the pointer is already 32-bit, so simply cast the pointer to u32.
> 
> Yeah, that code was completely pointless. If the pointer had actually
> been 64-bit, the old code would have warned too.
> 
> The odd thing is that the fsl_iowrite64() functions make sense. It's
> only the fsl_ioread64() functions that seem to be written by somebody
> who is really confused.
> 
> That said, this patch only humors the confusion. The cast to 'u32' is
> completely pointless. In fact, it seems to be actively wrong, because
> it means that the later "fsl_addr + 1" is done entirely incorrectly -
> it now literally adds "1" to an integer value, while the iowrite()
> functions will add one to a "u32 __iomem *" pointer (so will do
> pointer arithmetic, and add 4).
> 
My bad. I had noticed the '+ 1' and so automatically assumed
'OK, pointer arithmetic now' without noticing that the cast was
done only after the addition. Grrr.

FWIW, the version you committed looks much better to me.

-- Luc
