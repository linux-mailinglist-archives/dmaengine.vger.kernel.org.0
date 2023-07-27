Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79F764732
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jul 2023 08:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjG0GtI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jul 2023 02:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjG0GtG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Jul 2023 02:49:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B313F2135;
        Wed, 26 Jul 2023 23:49:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso6763345e9.0;
        Wed, 26 Jul 2023 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690440544; x=1691045344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gDMd41Dppy+GW2j8IJmSNZoys4XWs/tk9fmwJOFxXQs=;
        b=LdStxRx/rojbIZQRcjcThPxHjmWKNHrQFYcqIdh3l82MQKBUNEsffywr9YTYxmyp9e
         kYS5a/DArAjxMCa3FlTtM8RPBv35zGgkXGML9mtrw8/9leBsv33hMUtxnaUFpS159WS9
         nN8HNkogZzBbnuMR3Vrwef7juov9MGdJDFAmjb526IB8G9CZTY0MZtGeTeHVyG7M2v7R
         Pn5yoXD45gVNuFp9QwldfO6EBsovXOhZYi/Kght3/hxG3SbthcFiAs3YG7yut5qSNYNB
         z6Jnl+Cd020mshqXEBgvqRcNsaOwkwkVcKYrmo/95ZbgdqOYe86QMuK6AqQP3Vrn8xCb
         uh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440544; x=1691045344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDMd41Dppy+GW2j8IJmSNZoys4XWs/tk9fmwJOFxXQs=;
        b=S3oQwY9HVqXDU5wHrHiEosFKsRKCpfSRRpGNV02CesWO4UcyhWlSJe57oIKLOteC3y
         cPq0o0yDt6gk1JlKPXMUEbzui+K/DZksrRqeGfv54ZnFQjQUYLBHLo1OP4xowK8knuIZ
         w7RtqwWsWIXLsdOwgYOnFgI166Utj32ipoxcYrHjsUgX4Ur274I8y3xsHxgH6Wlgkvcc
         K1V8w9O5NaKv+vsHfFaKLeBaQAWMy44GZQ/9F6wPlDqH6fW9a0KHy39ZqNDNF9KiTr7C
         ChwPXmIU3W0/u/zS/2wDh0bI9ddzLyeRExQvZ1sJhFkFWVtgrm27GlfqZR1xV05cgIVn
         ww/w==
X-Gm-Message-State: ABy/qLYVNpCXJsmmIxleDmAXhJgrbTHN81NzK+zhrtYqqNJkQ382qtat
        fMeJuZjBC3Mu6w6v+xk0aY/0fR0iAIVCeIK9+arfGkVDbXceMA==
X-Google-Smtp-Source: APBJJlG25X8pnjYi7qqiFRC4nW/hoSqQSdCdlpKDEHDn/T+7LPhMRhg0OaHByoBteJUUyiW0jaq0x10npwqM97iWLgc=
X-Received: by 2002:a7b:c38e:0:b0:3fd:3006:410a with SMTP id
 s14-20020a7bc38e000000b003fd3006410amr954081wmj.25.1690440544113; Wed, 26 Jul
 2023 23:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230726104827.60382-1-dg573847474@gmail.com> <9378e69f-2bd4-9d8d-c736-b8799f6ebecc@deltatee.com>
 <ecf68b20-0a07-18bb-42a8-e622054b01f8@wanadoo.fr> <0e4caa6c-d5bd-61e7-2ef6-300973cd2db6@deltatee.com>
In-Reply-To: <0e4caa6c-d5bd-61e7-2ef6-300973cd2db6@deltatee.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 27 Jul 2023 14:48:52 +0800
Message-ID: <CAAo+4rW_rTsY=TpxZwO8yHB5gFkRKyTvy6kQ-eeiY0vg4+fuYg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential deadlock on &plxdev->ring_lock
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        vkoul@kernel.org, Yunbo Yu <yuyunbo519@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Logan and Christophe,

Thanks much for the reply and reminder, and yes, spin_lock_bh() should
be better.

When I wrote the patch I thought the spin_lock_bh() cannot be nested,
and afraid that if some outside callers called .dma_tx_status() callback
with softirq already disable, then spin_unlock_bh() would unintentionally
re-enable softirq(). spin_lock_irqsave() is always safer in general thus I
used it.

But I just check the document [1] about these API and found that _bh()
can be nested. Then use spin_lock_bh() should be better due to
performance concern.


> So perhaps we should just revert 1d05a0bdb420?
Then for this one I think revert 1d05a0bdb420 should be enough. May I
ask to revert that patch, should I do anything further? (like sending
a new patch).

> as explained in another reply [1], would spin_lock_bh() be enough in
> such a case?
For the another one [2], I would send a v2 patch to change to spin_lock_bh()

[1] http://books.gigatux.nl/mirror/kerneldevelopment/0672327201/ch07lev1sec6.html
[2] https://lore.kernel.org/all/5125e39b-0faf-63fc-0c51-982b2a567e21@wanadoo.fr/

Thanks again,
Chengfeng
