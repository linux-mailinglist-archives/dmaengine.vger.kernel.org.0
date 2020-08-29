Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC4256A2F
	for <lists+dmaengine@lfdr.de>; Sat, 29 Aug 2020 22:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgH2UkN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Aug 2020 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgH2UkM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 29 Aug 2020 16:40:12 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1142C061573;
        Sat, 29 Aug 2020 13:40:11 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k20so2233934otr.1;
        Sat, 29 Aug 2020 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YI2xZQaqJyDx3Q+NpMaGtqi3Z8mFUaFJekoiiTrUTDk=;
        b=AcUJ40v99WKfvdrLSniERzKyUGC9OqdHDFkxKXf82zTcdIUistYefeMt7fQpLBoryw
         Te73toHVs/x/7Ie/KjA5tB2Q0/Oit4NoN3hZX03TcGmTlxn/ZxwPJGfzOXVlHOuHuvJk
         /CQbVEBQ2TYFI89XCVDh1uCd55NiXECzAc0x/Uh3Vu4TaUpK9F7mrOkReWKVZJZ3ASOk
         EPX3bU4MbjFvyr3OVycjdDtBeZbGVmb1w688Gh7kRN1KzHuSXE9tij/qi4RjzhqjZBDu
         vjs9OdDLG6GELfdMRgYxyDMwWXOECBN6jcuELFgdwkDrCMnY1M+Oqg1T3Jf1N8l8RDKb
         y9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YI2xZQaqJyDx3Q+NpMaGtqi3Z8mFUaFJekoiiTrUTDk=;
        b=Qj7mn+d9b+Zl0esUPlWH8RtolX4cvcNF1NG3k/giccVAACwVXHD2iOLyPRScCIZFHr
         kVT2NcAEIBmPdeShBUpPiKezCSfdvrzLT40y74CBha/ccYrdlaVRtsjenIV/jBWJTa56
         rsHpDQaJUNnXk41l4Zf2Itdz/gWhOB2Da1qnd7/5dhLHaE7HKY4OpfDARMkqP3h1fESp
         zd8HQcWONmb5jrBQ7roa1pWcjDX36W0cuZRCtDlNmZjbPPes53vrlZFthW++3uLuxUgT
         9pkhBzmZFa+vcUMrzZVdo/k765qcjOQ2uwuceQH74QJiURsG0MqiGvZQSObW5NFA+xbU
         qCUQ==
X-Gm-Message-State: AOAM531fdlMcmHicUUrsnbY+xTyoqFbW7h28FXR1jGvn2NvhlSvmJyY1
        F/VdYMuJCIVXMHFWWotr/F+2W7Ygl8E=
X-Google-Smtp-Source: ABdhPJxHUuREpee287sjCV5MpqR4VhcrSa5oPS+K8b2fO+ugLWeBh48+RvfRw+zLmMLdzDpoRsyFfg==
X-Received: by 2002:a9d:3de2:: with SMTP id l89mr2764031otc.331.1598733609874;
        Sat, 29 Aug 2020 13:40:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f24sm823821oou.19.2020.08.29.13.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 13:40:09 -0700 (PDT)
Subject: Re: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        dma <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200829105116.GA246533@roeck-us.net>
 <20200829124538.7475-1-luc.vanoostenryck@gmail.com>
 <CAHk-=whH0ApHy0evN0q6AwQ+-a5RK56oMkYkkCJtTMnaq4FrNQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <59cc6c99-9894-08b3-1075-2156e39bfc8e@roeck-us.net>
Date:   Sat, 29 Aug 2020 13:40:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whH0ApHy0evN0q6AwQ+-a5RK56oMkYkkCJtTMnaq4FrNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 8/29/20 10:29 AM, Linus Torvalds wrote:
> On Sat, Aug 29, 2020 at 5:46 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> But the pointer is already 32-bit, so simply cast the pointer to u32.
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

Outch.

> So this code has never ever worked correctly to begin with, but the
> patches to fix the warning miss the point. The problem isn't the
> warning, the problem is that the code is broken and completely wrong
> to begin with.
> 
> And the "lower_32_bits()" thing has always been pure and utter
> confusion and complete garbage.
> 
> I *think* the right patch is the one attached, but since this code is
> clearly utterly broken, I'd want somebody to test it.
> 
> It has probably never ever worked on 32-bit powerpc, or did so purely
> by mistake (perhaps because nobody really cares - the only 64-bit use
> is this:
> 
>     static dma_addr_t get_cdar(struct fsldma_chan *chan)
>     {
>         return FSL_DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
>     }
> 
> and there are two users of that: one which ignores the return value,
> and one that looks like it might end up half-way working even if the
> value read was garbage (it's used only to compare against a "current
> descriptor" value).
> 
> Anyway, the fix is definitely not to just shut up the warning. The
> warning is only a sign of utter confusion in that driver.
> 
> Can somebody with the hardware test this on 32-bit ppc?
> 
> And if not (judging by just how broken those functions are, maybe it
> never did work), can somebody with a ppc32 setup at least compile-test
> this patch and look at whether it makes sense, in ways the old code
> did not.
> 

A bit more careful this time. For the attached patch:

Compile-tested-by: Guenter Roeck <linux@roeck-us.net>

Except for

CHECK: spaces preferred around that '+' (ctx:VxV)
#29: FILE: drivers/dma/fsldma.h:223:
+	u32 val_lo = in_be32((u32 __iomem *)addr+1);

I don't see anything wrong with it either, so

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Since I didn't see the real problem with the original code,
I'd take that with a grain of salt, though.

Guenter
