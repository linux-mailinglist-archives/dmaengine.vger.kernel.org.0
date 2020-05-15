Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178431D4751
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgEOHrD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726718AbgEOHrC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 May 2020 03:47:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674D3C061A0C
        for <dmaengine@vger.kernel.org>; Fri, 15 May 2020 00:47:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h21so1459876ejq.5
        for <dmaengine@vger.kernel.org>; Fri, 15 May 2020 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lxGFQ07X6Q8DMktNn+V6OUFm3XKfN9+/9X+gPiac5E=;
        b=XO7hisfHsS4YVUivvf2oEeQ9nIqK7UArYsQyGR3gq7VYo7NFdIjB+jJOxoTvWul5JN
         zctEbgWOxP2RZYYWH5YGpNhD/m5MjRuI7yD+9yD0fKV2hrOtf+FsyfepUtbaEzYA5e8r
         Ksrl0ALiP5Qds+sU4O7Gu6IV4uS6k9+cvdHfp0ky2UFwjnL/jx7DTnEsZeXndeEQwyOt
         f3xh9zwYs+G6Ttwxc9EGMCEorKAo7hPm1H73ZWwftASdAUk5dIYXxn+KyLuWNmMhaPPL
         DP2/wnV7PGOLtoNBSdBbmxqpjjrvEL2/XmwEtcVWcIg4T5XWIHIQL2RiCwMJ0/TEmNUp
         JA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lxGFQ07X6Q8DMktNn+V6OUFm3XKfN9+/9X+gPiac5E=;
        b=WvfmLWt8edFS32u1ZjhKRRoarfoZK5fTIFrUZcwx9cvh3m5U4r1eF5rW2FR3GEty7N
         uOu03hJnqfDtiGXTFzrqVIFGAmokObAjPZmnDJyCHK/EZs91gfqs49amuJWt/daF7p+r
         +S/E9UGdW+Jum9SnPW4OGIVTqBVDZsx6Z9sLtdDFs0umpUkH7MEU6Rda0hv5MniSioSV
         HQptJvoUOcUsGoSsCHk8aD9jBGt0QXKaIoUNldY13O1FtzYVokVMZ8ZlZ7uo5yBnfSD/
         5w2TkrazuduCNOpmzUOoekbUhMQWyeXDpx9DiE+JgPtsQnRBSie92JPBRVcg6moNRzMB
         qejw==
X-Gm-Message-State: AOAM5335X401dfYEJr1eCMhliK13mM604pdUolC1ajGlPNy3KjgoRIQr
        uZ+2AND0lSrI6FnNxGjGwoFbHRb9bMJbxpx6gIE=
X-Google-Smtp-Source: ABdhPJwlZAX4LwThW+b3j9NzVp/2b7ebUkgMHWawmR/nqaObhB1maBHD24f2YC5LN00lGpjpRF/cJgmt6va+CCTNNIM=
X-Received: by 2002:a17:906:9518:: with SMTP id u24mr1645422ejx.137.1589528821013;
 Fri, 15 May 2020 00:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <1589472657-3930-1-git-send-email-amittomer25@gmail.com>
 <1589472657-3930-2-git-send-email-amittomer25@gmail.com> <20200514182750.GJ14092@vkoul-mobl>
 <CABHD4K8F_sk3Xsevu4pMtR1jEanh5-dSATLYySPKW-nDY9fAvA@mail.gmail.com> <20200515065827.GL333670@vkoul-mobl>
In-Reply-To: <20200515065827.GL333670@vkoul-mobl>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Fri, 15 May 2020 13:16:24 +0530
Message-ID: <CABHD4K92yySOJs9heBienGBieu6N+ALj7NKcAPvThQGXMWfOdA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] dmaengine: Actions: get rid of bit fields from dma descriptor
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi

> > > So i see patch 1/9 and 2/9 in my inbox... where are the rest ? No cover
> > > to detail out what the rest contains, who should merge them etc etc!
>
> and what is the answer for this..?

I do have a cover letter for this series , But CCed only to Actions
Semi SoC maintainers
and mailing list.

Also, As I said going forward I would Cc every stake holder at least
for cover letter.

Thanks
-Amit
