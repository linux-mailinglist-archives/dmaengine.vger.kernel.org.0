Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001991ED847
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2020 00:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgFCWBc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Wed, 3 Jun 2020 18:01:32 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:38458 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCWBc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 18:01:32 -0400
Received: by mail-oo1-f68.google.com with SMTP id i9so847674ool.5;
        Wed, 03 Jun 2020 15:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+06hodQysHDpNsjgZkygN56Nz2rPEoF5BWYIAZ/Qdgo=;
        b=bI1qjDPGiH/5WhnPDc93mMDeP0Fbt7CeBw42HnrQ6+aiU+ZpqPAYjoHS4pO8EwNwEG
         Hb9TUtLc4z1wXSTHVeEIsk/qfqLN6V47iCS1sr+5q7aMnSeVLxar3DjcrnCJo8RTu7fh
         8myoCwR/9L/WJovp4k4YbyLFBw04Jf8ibmYzVyXYo+V7leeS9NLRcHkx4ibt3gEMbHOx
         2t15KjOEna098fBwbtLKrKZDK56JdXzTTPpbWsyJThSapyE/Qy6QvYYnDX2rwySfIhng
         Sj0vk56UNuvXWCfLmrPwCi9kex+QmXexLW3DdrsQZfKqRB5CaaEynW7LGfu4ouEKNgEU
         o1mg==
X-Gm-Message-State: AOAM530mPTDqC9wJTz5wjmL71KcUeWNoq4PbCxUQW9mWQxbPfBpLQGem
        5MbpnBLt6esOVDG52Cgu4nKqyL8zpqNzO+OI6Pw=
X-Google-Smtp-Source: ABdhPJw2dvLU83LDOWGT3Ey3MICfHVX0fif6rBgcuJmgPR+tbro9yGk/hxuKrku9g4yCfFqkljto2jY7BsgBPmTl34k=
X-Received: by 2002:a4a:db4b:: with SMTP id 11mr1580565oot.11.1591221690958;
 Wed, 03 Jun 2020 15:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <873bfb31-52d8-7c9b-5480-4a94dc945307@web.de>
In-Reply-To: <873bfb31-52d8-7c9b-5480-4a94dc945307@web.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Jun 2020 00:01:19 +0200
Message-ID: <CAMuHMdU3wMT_pnh4NE9W9Su6qip_oObgd6OiRCwfuvouqjXKHA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: stm32-mdma: call pm_runtime_put if
 pm_runtime_get_sync fails
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Markus,

Thanks for your comment!

On Wed, Jun 3, 2020 at 8:53 PM Markus Elfring <Markus.Elfring@web.de> wrote:
> > Calling pm_runtime_get_sync increments the counter even in case of
> > failure, causing incorrect ref count. Call pm_runtime_put if
> > pm_runtime_get_sync fails.
>
> Is it appropriate to copy a sentence from the change description
> into the patch subject?
>
> How do you think about a wording variant like the following?
>
>    The PM runtime reference counter is generally incremented by a call of
>    the function “pm_runtime_get_sync”.
>    Thus call the function “pm_runtime_put” also in two error cases
>    to keep the reference counting consistent.

IMHO the important part is "even in case of failure", which you dropped.
Missing that point was the root cause of the issue being fixed.
Hence I prefer the original description, FWIW.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
