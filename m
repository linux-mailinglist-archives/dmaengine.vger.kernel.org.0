Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83971641512
	for <lists+dmaengine@lfdr.de>; Sat,  3 Dec 2022 09:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLCIvS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Dec 2022 03:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLCIvQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Dec 2022 03:51:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9261171
        for <dmaengine@vger.kernel.org>; Sat,  3 Dec 2022 00:51:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d20so9393152edn.0
        for <dmaengine@vger.kernel.org>; Sat, 03 Dec 2022 00:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QCMhhxU4amEzwkVwX+/r39AbLLYM/d4xsWWqYzE6Rs=;
        b=kCgBHAA4Sjnod+WqTT+ykF8imSO3ZuSWnQsfKW/ZNeCMbRJF2BVLszhbQK5GIuCiyN
         tUaNV6mmYzKQwlAJQ+dRVdtisoVNr022GGzrsKwnxloCeuJ0sLTzSgJuxNVCcpbzB2Xg
         QbYEJPqJaFLYrfGD6hyYqFGTeJ4NdAez5QiDtw+nDwskBMIW8bFyZeKegmQ2AW1lWKjB
         ijJHXzs9rRAOdxo8nyZ9lXs8cmjPkCw46Xp9fgsZJGL59PH6StLbDOhgwJAAZ/PlGecu
         FKlSR/xPg9LOP+dLsclHnM5xRvEwk648LJH+qGqPxacDnbMZNgOb+QHWMhbABF7xnbwT
         oZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QCMhhxU4amEzwkVwX+/r39AbLLYM/d4xsWWqYzE6Rs=;
        b=mCYMhIUCxQSmhi0w5skH5it9zRDGmiTLaUoajcTpmRWGL+gQE6wmr/QGxHzSZ1/oTM
         JxrTrMNlSWl99UGCyeSBxBdEGw247XZvWK7wGwek/PEc90XUrloJXaUsctmfiOg26Mhp
         1Ippqe+bkK5jNjG8Dkc9hasL+QeAZIH2zUawe+6xTyuUib8qCnWACm4YaOlFVZQEjx3b
         EGZ7nzI0G0DQ4WWO6Ojcc7gmId+JlXXuZTcjPGrjtaMi7XCftPfh1RHWahiN1Yv8u6mW
         vBF7npcLMVfPTk4YDNjPh4vC4a9j3ZujoMqbuNwcHZIaW+aJiOaJFrWIFZ2g5ACRXamr
         XBJw==
X-Gm-Message-State: ANoB5pklX+8yjaF/yfsid1SjE9yXfxqz2iUrI7X2Fdem2m4WDUK/9lxu
        TJ7Ut96tbRbL72B58qoyFucPvK8vQe2xx4yblZ8D2nT5nuR7BA==
X-Google-Smtp-Source: AA0mqf4b1D9pDov3HASgGD8tF4eBcfVvAdI/oPPUSv6VwqgBHxrp5MmfnojQd4lgRgKBPD5DfeKKWdGrKq4fpSenPL8=
X-Received: by 2002:a05:6402:1f89:b0:458:caec:8f1e with SMTP id
 c9-20020a0564021f8900b00458caec8f1emr65996219edc.280.1670057474196; Sat, 03
 Dec 2022 00:51:14 -0800 (PST)
MIME-Version: 1.0
References: <CAOQPn8tHAx1zsgUO7UAuKf1DJYt+fdT6OPAHoxO+HgEPvT5SPg@mail.gmail.com>
In-Reply-To: <CAOQPn8tHAx1zsgUO7UAuKf1DJYt+fdT6OPAHoxO+HgEPvT5SPg@mail.gmail.com>
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Sat, 3 Dec 2022 00:51:02 -0800
Message-ID: <CAOQPn8v=PWvRWntknEK9pYu3jLgDePWfsjVByYSjUe_tYCpdPA@mail.gmail.com>
Subject: Re: poor ptdma performance
To:     dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 2, 2022 at 1:57 PM Eric Pilmore <epilmore@gigaio.com> wrote:
>
> Was curious if anybody has any expected performance numbers for the
> AMD DMA engine "ptdma"?
>
> I'm doing some testing utilizing the "ntb_netdev" module for TCP/IP
> communication between servers via NTB (Non-Transparent Bridge) using
> "iperf". I find that on Intel based boxes, utilizing IOAT DMA, I can
> get approximately 19-20 Gb/s for a simple untuned single iperf
> instance. However, when running on AMD based boxes (Milan CPUs), and
> running the latest ptdma driver from the Linux tree, I can only
> achieve about 2-3 Gb/s. I'm thinking there must be some driver knob
> that I need to tweek or something.
>
> Any help is greatly appreciated.
>
> Thanks,
> Eric


You can disregard this question. The issue turned out to be a bug in
the ntb_netdev module. The module was calling dev_kfree_skb() in an
inappropriate place (interrupt context). Once that was fixed (changed
to dev_kfree_skb_irq()), some assert WARNINGS (that I had previously
missed) went away and the performance is as expected.

Eric
