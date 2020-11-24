Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4986D2C2965
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 15:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgKXOXv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 09:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732297AbgKXOXu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Nov 2020 09:23:50 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4287DC0613D6;
        Tue, 24 Nov 2020 06:23:49 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so28777392ejk.2;
        Tue, 24 Nov 2020 06:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NLbmKhCgsd6W4UoEHa+1d6BvChXX8mDmskXgcWEKV0=;
        b=FqLNUUsB5RWkYKlRmrFeIluV/yiheGUu5oOfro2MV7r7pdIp7Gv3BBhlNlrXULGT4P
         NLJaqDRN3o8UOk83GoDFkjvozMmj2kYgP2GEHmJrZ5dnsCr19rkS5bEXLIKLyn78/rRy
         FOK1KN7v1UGwzV8tJY0SDRZrOJ3nPljNFaLibmF4/uHnlXEE5hxXCa5RynmXBAZzNGGj
         LarIGn/yfKpWdqi58R5YeohrpiCz45WanAMFSh3vZj4qp2hODLeuSc93+QfVoHSDWXei
         oA9m3e1c+UdFlHUxAOeZ9MfMFbAcVWwl36X6JyYVvoDI1zkOB4xDdKHKMRzWbE+Fq0A8
         NKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NLbmKhCgsd6W4UoEHa+1d6BvChXX8mDmskXgcWEKV0=;
        b=S+wOPfbSbda+Xktgpoi5jswLfFa6ptv1l9ppibEckdPsgMcmok6AnT6r2UIpZX8hul
         NoCkLVFFKHX9MOxm2zvnk7woF8UIuCCAmhamCiFcmZNsghs2O0IIIDvsG+aVOCTtHw+F
         dEzsHmQV2O72oo2E8L//D5bqxomM+iALep5rggLlJqkw63MhtpwKiRLmJMFldLjWmVhm
         b/v02XWr6oNMmA2BA48ZeqB1Sb5ROBFveIx3CV9K+xfKpwgbVHqlZAqQOyVyS8g5XkYN
         2qIYyuCxfjbOUFMtgmIzz0pgvb4b4RiRFhdw8g38jo9BGO/dkxGw7TPqpTtzxFHIxvca
         4vPA==
X-Gm-Message-State: AOAM533FKV98O77cIkdxiISRAbg3bQrlNyO+5QleeZ7cQQZtv1lVj5Q2
        my4/Tg71wax5VqbK1Mk79IOt5/OtszQZ0dUYXa4=
X-Google-Smtp-Source: ABdhPJzp5LYdqvjZqg29K1AkxD1xP6rqW/nQeEstIRkz4GbMt+5jDkmVFf+/lAK4ue2Kclwd9/VSKM49uB62N4YyiOQ=
X-Received: by 2002:a17:906:5955:: with SMTP id g21mr4567652ejr.271.1606227828014;
 Tue, 24 Nov 2020 06:23:48 -0800 (PST)
MIME-Version: 1.0
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-3-git-send-email-Sanju.Mehta@amd.com> <20201118121623.GR50232@vkoul-mobl>
In-Reply-To: <20201118121623.GR50232@vkoul-mobl>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Tue, 24 Nov 2020 09:23:36 -0500
Message-ID: <CAGF4SLi1qqj6xSBB6=9rS=M_Wvaj9Zec7XzMc7=9EsgPLM21OQ@mail.gmail.com>
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

On Wed, Nov 18, 2020 at 7:20 AM Vinod Koul <vkoul@kernel.org> wrote:

> this should be single line

Vinod, do you see any obvious functional defects still present in the
driver, or can it be finally merged for us to start testing, while
Sanjay is working on improvements and style fixes? I'm sure the driver
has hidden bugs, as any other piece of code on the planet, and Sanjay
will appreciate bug reports from the actual PTDMA users.

Thanks!
-- 
wbr, Vitaly
