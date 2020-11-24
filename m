Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238DD2C2EC2
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 18:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403843AbgKXRhO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 12:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403840AbgKXRhO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Nov 2020 12:37:14 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD35C0613D6;
        Tue, 24 Nov 2020 09:37:14 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id m16so21790687edr.3;
        Tue, 24 Nov 2020 09:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hry/OBR2/hK4u0SfunHDX/gcj9N95Fp8cXcywNOglMY=;
        b=VaySMti4KbVGeydmgmZ/XKz8gGuNaxeHEhuAopXBW0koyGPIztQawVLxbY4w2IcEg8
         zcUmn/ulzlUlnxduhlesA1NpoTbZuMSvYCYul/a2vOHFso3Acg8f18IF9fHumDnKW/Xm
         ARHE2DH39+S2kd+A9hpmnAQuzP8bmLnqhdpq6lwmgbvMCWseZIC0YhL5Yhc9HjgEG4vB
         gjaqofr3Pyz84QyHFYNyrL+ySPDUDRlOrbvZKL6p8COE8NHbYMvC3ULUUVkNv0+YX3y1
         WZBkBEXrj+J4U4VlCQRNseeMxzN65qAKa/epUJV4lYI6mlRFLQt1qtYka8QEVntEiMLq
         4e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hry/OBR2/hK4u0SfunHDX/gcj9N95Fp8cXcywNOglMY=;
        b=IvT3fc7b8RKgAoOVjwjoTiRTSnxXYR2P5OU1CM9fIET6EizcKEkpedZUGp8BHniC+y
         H16kadYqwStq2I1ZSp1xa27gtBrIGkmhuabGP5TWMiEkwMrhJqh7G/suJV+U9DNUEU4p
         bCbxe8NpGcxT9XSen8jGHqkeG7CLeFCzZVzUJ4/46jkzRdEb7X+MXjspso9r1VsCWqI4
         u9JQDobpMR9cA8XByMkm1xUtUDy1Ipo6uZSmTSfVbpj9kyAFgS7SUzf1qzVan2X3FqQm
         8iQj5tl2KNiJMrUSp2vYagi4ZYCwHUqh7dCT/r+wR5CMdS+/ZZ4/XLfNfA+hYVHTn1dF
         BIEg==
X-Gm-Message-State: AOAM532P3CoVUAgI7WZkPNYjYuSq/vMYaMZhTHGRUtaahG94/nZqcRie
        Lz1ge/Koa8SGhz4Xs5/1JES0RXZsOUVpsuqWS50=
X-Google-Smtp-Source: ABdhPJxj1gRJSd4rteeYBc8GdCGX2hG/xL1PbiT+qdRQbLGYlSIs77NjcwqnvPzcIWB8RQyC2/r4wZK7gjKbYPznS1c=
X-Received: by 2002:a50:9f6c:: with SMTP id b99mr5214327edf.90.1606239432975;
 Tue, 24 Nov 2020 09:37:12 -0800 (PST)
MIME-Version: 1.0
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-3-git-send-email-Sanju.Mehta@amd.com> <20201118121623.GR50232@vkoul-mobl>
 <CAGF4SLi1qqj6xSBB6=9rS=M_Wvaj9Zec7XzMc7=9EsgPLM21OQ@mail.gmail.com> <20201124171813.GS8403@vkoul-mobl>
In-Reply-To: <20201124171813.GS8403@vkoul-mobl>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Tue, 24 Nov 2020 12:37:01 -0500
Message-ID: <CAGF4SLiL8+=atY6A8M7tZUPOEeZfL61b0AucjeNoFfp8yGFfsQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 24, 2020 at 12:18 PM Vinod Koul <vkoul@kernel.org> wrote:

> IIRC there were few issues that I would like to get fixed before we can
> apply.. I hope authors can reply to the comments received and we can
> discuss on this.

Sounds like a plan, thanks!

-- 
wbr, Vitaly
