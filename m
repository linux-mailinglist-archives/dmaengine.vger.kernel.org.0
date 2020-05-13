Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A01D209F
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 23:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgEMVF2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgEMVF1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 May 2020 17:05:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86076C061A0C;
        Wed, 13 May 2020 14:05:27 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x73so753975lfa.2;
        Wed, 13 May 2020 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mkbakP9mk6/OGVAN+zcqRwZ0mw26o2wBBxnAQMPvC8=;
        b=ctjlYoCI2PVddAGODZeP/vCogq7hOe4qIy3ofe+sfcwAMob4gdIAaRmpXt71KXM5s0
         elyxHk041/Ys/mtWBq743Pp3GBEijMkoEW78fXv8PSayqdtHKwTbfq5CiTzj/aX8npHq
         nIpW0oNQefD4dLK5VkjPkyi99u89TAPjjYi2e5x6CIc1InG8WJydkkXHex9K9yLUMplm
         ibmtJybyeiNo8Txyyh7I5F7ya12JGjK0GVwxu7OL7h1aYhPxR3uIyeoZeXqdlRZc7GQI
         3bo80UUTP1mCHiX5NGzgD34STLlRkUqgfksgPKZFqZjDDXbntcwq7+mxNlqXS/yIYQxa
         mq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mkbakP9mk6/OGVAN+zcqRwZ0mw26o2wBBxnAQMPvC8=;
        b=n3Tpa1Q86j8TYV/bW1INe1at+kyzz9pmSgfD1bDimVui/KBKwAYSrXdZBX87ABqmMT
         4s1+0IM7YV3d1cEAKKSGIiNRmUIWuD5wP6i/HJzgM1Sw18eqzW8ENHTbzb6TTTnI7V4K
         HqNth89R04baCISN3oNKsf4WI6GYAJ/i4K3p8Ew4KQD8JpTOigxwVR42DjJ8GfkjhHe3
         YaI+j/tcLmYoduRhJCEaqnANjMq2baOtQyD4K/Etdp78BWSvsFr2e/DVPuS8WR9UejWW
         8nDnOYTXND5HdKVQf3c1vmff6XtE8YBePO1fWdsfRYp7lcRhRsOh1SBTM77zItO0Pdso
         Fi5Q==
X-Gm-Message-State: AOAM531aL3cjAlMiCwmJoA5J58Y0vhnC3gQ3viu9GODSyMtpm3Q0zsxo
        E4BqVcxMOpZqFDWQGv33SMyCOgRFSGEdkpkTISQ=
X-Google-Smtp-Source: ABdhPJylbChycIFwjIQ3xfqgQamy65iiEOk/6igXAS9L36vE1hhqtoddFFY7wG+Xod768Zt281P3JghBCeiQaKBQCYg=
X-Received: by 2002:a19:4b4f:: with SMTP id y76mr62320lfa.7.1589403925952;
 Wed, 13 May 2020 14:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com> <1589218356-17475-14-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1589218356-17475-14-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 May 2020 18:06:40 -0300
Message-ID: <CAOMZO5BB-bnKF6fQtw+1iGmojrmNHVQqeN3Fu8tHa_09ayjCgg@mail.gmail.com>
Subject: Re: [PATCH v7 RESEND 13/13] dmaengine: imx-sdma: add uart rom script
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Vinod <vkoul@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

On Mon, May 11, 2020 at 6:33 AM Robin Gong <yibin.gong@nxp.com> wrote:

> Please get latest sdma firmware from the below and put them into the path
> (/lib/firmware/imx/sdma/):
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> /tree/imx/sdma

"latest sdma firmware" is too vague. Better specify the commit ID of
the firmware where this is valid.
