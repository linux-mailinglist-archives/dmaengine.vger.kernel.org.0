Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543883DFFDF
	for <lists+dmaengine@lfdr.de>; Wed,  4 Aug 2021 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbhHDLEv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Aug 2021 07:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbhHDLEn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Aug 2021 07:04:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33065C0617BD;
        Wed,  4 Aug 2021 04:04:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e21so2603459pla.5;
        Wed, 04 Aug 2021 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inkeY5rU4/+Q4LR6WqOjrQeJsl4lXkkYc2LzRn8YYLY=;
        b=QdQ1Oh/iyEEq9guF68+rypwfovCfElJpmE9lLsqCz6CzGSVbG1q6Fr8x8J0O9QzUdV
         4fMSdlupA/cPVoAm8z7w7WRbuXZ69kzX54eS0RJ6jxdBuDCq6X8uKFS3Ol0FWtslwGRi
         9sbjlwmHVjauP4zU1FoYWM6Ah8JQG4g55pJebiJTqUOGDruUU34vwHtr5MwAWgt37BrL
         77bywSZK2aGH31tSWiNFwNFzV4FSJ7BX1362xcOwA8vK6tpc52tFqixRDKq+Y+LQcaA3
         ToOPi49VO5fxG5SStSuU2qnMRgEIYalNZCs8d2PsPNvjgNt8+As6GSLIlf01oaS7z6pv
         MgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inkeY5rU4/+Q4LR6WqOjrQeJsl4lXkkYc2LzRn8YYLY=;
        b=XW3K/xCnJmCfCuyQBMKirfdYuDo/1m3zLYl5sTSGLhfM0Ezaig9tlqGpKt3hnO2Bvs
         QL1u24eg1Me8qaaQ6Aiv2kQF7LOgmDecX5AmMsna9ujr+xkVUMtfS5i/K+2SplOyUb8C
         mQ2b995Wnm+p8hMX6Z5DKVaLKNeCPOgp5xgdunnY53h2HadidjvISKJxABF1J9ELa01c
         H4p9dDxi38lhz/FTEdHDGHm4aTp4YsL9f5ttYwNeoFvWBQcg7/fWsKXcTaPU3cwQvRkk
         1dZgZBv05HJ+c9K+RP3x8PIpsyQi/yvqd9YwCfrpsO5X3tUXL7NNKq6eJ4uTOX0aimsT
         CMvQ==
X-Gm-Message-State: AOAM531HNMtBorgIA1uqWXCru3TuXBsjodSYgXOIKAOg3zUbG3KehXE+
        suMmIHK3JMtR784tBoDAD86OozFHwAZnRTbQ41E=
X-Google-Smtp-Source: ABdhPJwISl+fy1cfwg159lQAIvgqOxwvoZeLrk1h8HnsvtOdT3kk/UfB1N+5L2D9bomjFAeRPRMCKF+D+ZJAF07riNc=
X-Received: by 2002:a17:903:2444:b029:12c:8eba:fd6a with SMTP id
 l4-20020a1709032444b029012c8ebafd6amr6764331pls.0.1628075068735; Wed, 04 Aug
 2021 04:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com> <20210804094607.ac3zxomlmu3ifpqr@mobilestation>
In-Reply-To: <20210804094607.ac3zxomlmu3ifpqr@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Aug 2021 14:03:49 +0300
Message-ID: <CAHp75VfBtdKLDGvPVNQRs5acXVRTC2Ufk0aqJ4=X_0_w8yhMnw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dmaengine: dw: Remove error message from DT
 parsing code
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 4, 2021 at 1:50 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Mon, Aug 02, 2021 at 09:43:53PM +0300, Andy Shevchenko wrote:
> > Users are a bit frightened of the harmless message that tells that
> > DT is missed on ACPI-based platforms. Remove it for good, it will
> > simplify the future conversion to fwnode and device property APIs.
>
> Thanks for the cleanup patchset. No comments from me, just the tags
> for the whole series:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> [Tested on Baikal-T1 DW DMAC with 8 channels, 12 requests, 2 masters,
> no multi-block support and uneven max burst length setup]

Thank you, appreciate it!

-- 
With Best Regards,
Andy Shevchenko
