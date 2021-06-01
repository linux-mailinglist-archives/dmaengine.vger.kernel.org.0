Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C121639717A
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jun 2021 12:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFAKb2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Jun 2021 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhFAKb2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Jun 2021 06:31:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CF4C061574
        for <dmaengine@vger.kernel.org>; Tue,  1 Jun 2021 03:29:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h12so6609980plf.11
        for <dmaengine@vger.kernel.org>; Tue, 01 Jun 2021 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPrVrlHdDbvYD9mXPSjbyB5f97+5ybWcxfaPWNDV0Tg=;
        b=OhrfJ/ogm0QOd6B0f6ZV/hf8gXX5ecjM8YN7XoTjD6HoJm0mCPvoe9tV2At0JylZOA
         ZQi5eeBvowL/JsYBgsowMdelxpxNzkLsQqro13dw/TdxeST5gq3XiTWX43i2OTdfmp7d
         LXxSK/5P25mTz5ty2RZ7e/Y1BnOZxheY1NlbCW2Hcki/dZdVVE5mgtKqRzaf2SWWvn44
         dglyLJkZhIO6HBuJAzF1U/fEYv4uSH8RdGchltvET/JoBcJiAgiYwT2dNKMc4eNhzsXW
         1VhVsfqA3DU0eZV3kySpmx53QTwfsg3+QIxhhStVCdXlLpt7mhSJP8i/joTydA8weFPf
         pVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPrVrlHdDbvYD9mXPSjbyB5f97+5ybWcxfaPWNDV0Tg=;
        b=l2f9p+5NcDIWMCxbv87HlpexdTzMR/UCiOIlhXd2+N/sNs6FGmYFKJB9Um5ZkFUPDu
         jm8wy4JDfAdL/Hr3tQgRTi243lYrwAttfgQ+T8K+RQkLUcICt+W2x64GZtgQyh35x9Zw
         UHZnc7bPGQ4LGnjiKH2KvL5VHpDWf8HQ2ViLiw9YrHXXTPVmJrkxYLLxfrGt2C/V5vaA
         8zEWznzJ43yCBbs5h1FvCJZc95+ywG4RQGZz80Of/KFA8vcV3jBsadvDhoQSqiFRITjc
         q5Ex6H9MG9wausAvB/86nvWcVF5ATQhjGnIeKDD2J4A/fPGcsuQg8yDgkqEj0o37Y7EW
         bQ4A==
X-Gm-Message-State: AOAM530KKvAcNkK3X4AKlzt6INUAGiCrC9KcP2lW8CNJzqwnkx29Qps4
        FcxTUA8wZI8DTEIjRHvVTkxajRffVEzRO+S2WbJKPlAv+XU=
X-Google-Smtp-Source: ABdhPJyBf93ANKEEmyTpYQEzkbNT/uodbrjJ/reUzpdTy6iauYSbCqnIirP5JNVWuds2DpARFrsqZKM6LQgxayr+2a0=
X-Received: by 2002:a17:90b:33c3:: with SMTP id lk3mr2272293pjb.33.1622543386011;
 Tue, 01 Jun 2021 03:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
 <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de> <YILKq+jNZZSs37xa@vkoul-mobl.Dlink>
 <bed31611-a084-2a05-f3a3-25585a47be9a@metafoo.de> <YIMB6DpM//wrPC6q@vkoul-mobl.Dlink>
In-Reply-To: <YIMB6DpM//wrPC6q@vkoul-mobl.Dlink>
From:   radhey pandey <radheydmaengine@gmail.com>
Date:   Tue, 1 Jun 2021 15:59:35 +0530
Message-ID: <CAK8fcYC3Hdxas-5qUbXTi=a6VMXavt9O+yWn=1+8fPewehKy2w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Expand Xilinx CDMA functions
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>,
        dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, radheys@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 23, 2021 at 10:51 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 23-04-21, 15:51, Lars-Peter Clausen wrote:
> > On 4/23/21 3:24 PM, Vinod Koul wrote:
> > > On 23-04-21, 11:17, Lars-Peter Clausen wrote:
> > > > It seems to me what we are missing from the DMAengine API is the equivalent
> > > > of device_prep_dma_memcpy() that is able to take SG lists. There is already
> > > > a memset_sg, it should be possible to add something similar for memcpy.
> > > You mean something like dmaengine_prep_dma_sg() which was removed?
> > >
> > Ah, that's why I could have sworn we already had this!
>
> Even at that time we had the premise that we can bring the API back if
> we had users. I think many have asked for it, but I havent seen a patch
> with user yet :)
Right.  Back then we had also discussed bringing the dma_sg API
but the idea was dropped as we didn't had a xilinx/any consumer
client driver for it in the mainline kernel.

I think it's the same state now.
>
> > > static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
> > >                 struct dma_chan *chan,
> > >                 struct scatterlist *dst_sg, unsigned int dst_nents,
> > >                 struct scatterlist *src_sg, unsigned int src_nents,
> > >                 unsigned long flags)
> > >
> > > The problem with this API is that it would work only when src_sg and
> > > dst_sg is of similar nature, if not then how should one go about
> > > copying...should we fill without a care for dst_sg being different than
> > > src_sg as long as total data to be copied has enough space in dst...
> > At least for the CDMA the only requirement is that both buffers have the
> > same total size.
>
> I will merge if with a user but semantics need to be absolutely clear on
> what is allowed and not, do I hear a volunteer ?
> --
> ~Vinod
