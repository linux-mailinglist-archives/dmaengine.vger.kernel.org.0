Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398976560E
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jul 2023 16:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjG0OfO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jul 2023 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjG0OfN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Jul 2023 10:35:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A522D47;
        Thu, 27 Jul 2023 07:35:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31781e15a0cso675789f8f.3;
        Thu, 27 Jul 2023 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690468507; x=1691073307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BWvrBBI0xeShoFk34NbmQuANn71umzLfZCKEpR5Gmg8=;
        b=sOmsxuOEWzRHYy24bTXdFP8ZH6spjFMw8Ab3/zPupI0xiwahJLv+/I+rft3AigBK72
         30+sZv1jP9lQpmT2mat9zJBREOTrBSb9dTbUyi/q1cCprkrPKLkUrDwTOiz0N/KkVASD
         ZiSRRpi2uroa5HiB4t8qLqBDKneQ/HTk+oaXZo+XTR2Cd3tIyEgsdCl9LAE2e3MsHmm9
         7pHN23pBgbnKTwbBANXGCOYwdDePyGf5m+yBU185fd9Koggsx0qN9aNorC78cwkjOpML
         lnoaJFsuYOFxvCRnENFRJPSBcxGDWkUhdiAZnPDrabUtqveFyKeFQipWCuHx6YQITbo3
         8Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690468507; x=1691073307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWvrBBI0xeShoFk34NbmQuANn71umzLfZCKEpR5Gmg8=;
        b=kbk3LAhQdyD8OnHrRPjqHbRBv1dw1di1nGOZlPa8LYZCjxi0c5jHd1C6CcRebcdbq2
         YyLrLMaVp+Vdsq4rZjXFJsAONisqyUm2+kqhfc7ByNiSrBhACGgu4XE2O00nsJxxq9+e
         oUNn5Sd60mgDwJerEX4gIHrBWYk1d3AdbNnJuE8czVyiW6z9NmdyNfMfgaP36xdTfWvc
         jCBjb/53tA8CTyCTukBcyyC8w6arwpqv7LgkL4KdTlYm0FwV8uzQR7i6vVKQQcZe7+hK
         2AoUyrSSraw/KSUnybD5znfO3QD1N5HHqlYunpLjwtlY+ttZUbab22YTwALw2XRzhgMS
         G+4Q==
X-Gm-Message-State: ABy/qLZaFNhlWwku31nU2zwaZw6H6Csrpkb68HlGlWUUeVYp7Df+8eJY
        EIW1ewpv6mSpjh+Y05ku1G/dZpnxPxl8+DU5QiP9oaEfnTKVOTtT
X-Google-Smtp-Source: APBJJlEJnkjeSx+q1sdaO3TLxk0CMnDvOrQQJUSSoYfmLABPx1kZPhDMnuoUpLdnFcrLH+H0a3WJkzsZFbDVhYZqBMo=
X-Received: by 2002:adf:f549:0:b0:317:5849:c2e0 with SMTP id
 j9-20020adff549000000b003175849c2e0mr1930019wrp.9.1690468507116; Thu, 27 Jul
 2023 07:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230726104827.60382-1-dg573847474@gmail.com> <9378e69f-2bd4-9d8d-c736-b8799f6ebecc@deltatee.com>
 <ecf68b20-0a07-18bb-42a8-e622054b01f8@wanadoo.fr> <0e4caa6c-d5bd-61e7-2ef6-300973cd2db6@deltatee.com>
 <CAAo+4rW_rTsY=TpxZwO8yHB5gFkRKyTvy6kQ-eeiY0vg4+fuYg@mail.gmail.com> <46ceea13-c8ba-8d67-604e-b761feabc50c@sw-optimization.com>
In-Reply-To: <46ceea13-c8ba-8d67-604e-b761feabc50c@sw-optimization.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 27 Jul 2023 22:34:55 +0800
Message-ID: <CAAo+4rXJkWsTtsjDCY-b7bfqhMms1HSRQiXVHL2WfXNMLD8uSg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential deadlock on &plxdev->ring_lock
To:     Eric Schwarz <eas@sw-optimization.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        vkoul@kernel.org, Yunbo Yu <yuyunbo519@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Eric,

> W/ special emphasis on commit edf10919e5fc ("dmaengine: altera: fix
> spinlock usage")
> spin_lock_bh was changed to spin_lock_irqsave w/ this patch.

Yeah, that patch is to fix the deadlock between irq and kernel thread
thus use spin_lock_irqsave(), exactly the kind of bug that I am reporting
about. But slight difference is the deadlock on that commit concerns
hardirq and thus fixed by spin_lock_irqsave(), but this one concerns softirq.

> For uniformity reason across drivers and also that not something else
> gets missed please compare your requirements and solution to the
> implementation of the "altera-msgdma" driver (altera-msgdma.c).

Maybe for our case spin_lock_bh() seems to be enough since we are handling
deadlock between tasklet and kernel thread. It's truth that uniformity
is an important concern, also as I glance at other DMA driver, in general
spin_lock_irqsave() is more frequently used than spin_lock_bh(). But this driver
already consistently uses spin_lock_bh() on &plxdev->ring_lock, only change to
spin_lock_irqsave() at this function could instead make the code seems
a bit weird.

Even though my original patch did use spin_lock_irqsave(), now I think at least
for this bug fix just revert back to spin_lock_bh() may be better and
will not complicate
things much.

Thanks,
Chengfeng
