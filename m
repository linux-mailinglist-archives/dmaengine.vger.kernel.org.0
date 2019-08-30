Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7245EA3FCB
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2019 23:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3Vo1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Aug 2019 17:44:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44344 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3Vo1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Aug 2019 17:44:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id 21so877693otj.11
        for <dmaengine@vger.kernel.org>; Fri, 30 Aug 2019 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r1D8IBfKr4KZlJAXW83t95Uh5aoX1KNuipA/xtxjo60=;
        b=Fhn1uylrMdzREK7eYqWED0WvNZ1Ku4t5vt0mZaUQ3C/daCMt/M8NLBe72uqOl+uXnx
         qUEHUORlBMnz5XExb9bZgKcd/bg2lKWnNwECVRTeycXBXoXADxKk4V1hucdSiU7bwL2D
         N7mo33ESuYNMq82D/PEQkuHMONxIYx/1jm/90u3PI9uY8NJbS8rPS76LD5aQuwwdbzqP
         iOu/7NsACp+ncarLbfhPuqhmre837CWIiurHwjB1NjNiwah93VVJt54hx46Sp0O7urgl
         RzniFpYnB85NAbtwK4MuDJsnl4fVxXsXiOAbnsqIu3y02xABqMFfuWVLfhryU6kWt/g8
         0Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r1D8IBfKr4KZlJAXW83t95Uh5aoX1KNuipA/xtxjo60=;
        b=dhE96863siUKQUAJ4u18C8vimvDf0dQUhmtvy3BFi10PC6HXcFHUVDs5oyoc4oalnD
         5JLED2BpKnM/DmV1O0mhc7PsLdxJakRKdLkfnBzvrl4wRYr4fea69hl3jwy0VljMxrxz
         qzHY+0ShgQzCaTCbXmZw0dVrlPEHwimRRqy965yLarSaBR6cNm5gDlvttQYbmzw+Md9+
         ockEsSvYXddUaQV7IK1OhzNEqUQKGwHf2KxQeQMX2essUkcZYtMDVfuGWNO6XYPjdjp1
         YM2bl98kNOcazQcG/rHF9BwgiPpMWjoKQ9U76mUB4Eztg+sTz7ZS8siz/Hf95Jqv1SWO
         7I8w==
X-Gm-Message-State: APjAAAV3+92fKOJG79AG3EChA2rCXjH90jmqYxR+xccYb/uhNi/4gpuu
        C9SnBVPMmBWbbF8LcToyg8NnR+Q3WIjHizFsxEo43w==
X-Google-Smtp-Source: APXvYqyHGGTpqtaUrDEaJb5+VPW23VqDVAKTDUaAj/zAYp3Ck7ETaN61CyWKthYg/A1Mhw3hQ0GKgsSRlNINMeUgHJk=
X-Received: by 2002:a05:6830:14d:: with SMTP id j13mr6038863otp.71.1567201466536;
 Fri, 30 Aug 2019 14:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <138f82a9-08ad-2bb2-cfce-f3124ec502fc@infradead.org>
In-Reply-To: <138f82a9-08ad-2bb2-cfce-f3124ec502fc@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Aug 2019 14:44:15 -0700
Message-ID: <CAPcyv4hvPrkMhSKKWnqTs93=G7712j82jRw43tjoqJoqsZfzDg@mail.gmail.com>
Subject: Re: [PATCH] IOAT: iop-adma.c: fix printk format warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[ add Vinod and dmaengine ]

On Fri, Aug 30, 2019 at 2:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix printk format warning in iop-adma.c (seen on x86_64) by using
> %pad:
>
> ../drivers/dma/iop-adma.c:118:12: warning: format =E2=80=98%x=E2=80=99 ex=
pects argument of type =E2=80=98unsigned int=E2=80=99, but argument 6 has t=
ype =E2=80=98dma_addr_t {aka long long unsigned int}=E2=80=99 [-Wformat=3D]
>
> Fixes: c211092313b9 ("dmaengine: driver for the iop32x, iop33x, and iop13=
xx raid engines")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  drivers/dma/iop-adma.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20190830.orig/drivers/dma/iop-adma.c
> +++ linux-next-20190830/drivers/dma/iop-adma.c
> @@ -116,9 +116,9 @@ static void __iop_adma_slot_cleanup(stru
>         list_for_each_entry_safe(iter, _iter, &iop_chan->chain,
>                                         chain_node) {
>                 pr_debug("\tcookie: %d slot: %d busy: %d "
> -                       "this_desc: %#x next_desc: %#llx ack: %d\n",
> +                       "this_desc: %pad next_desc: %#llx ack: %d\n",
>                         iter->async_tx.cookie, iter->idx, busy,
> -                       iter->async_tx.phys, (u64)iop_desc_get_next_desc(=
iter),
> +                       &iter->async_tx.phys, (u64)iop_desc_get_next_desc=
(iter),
>                         async_tx_test_ack(&iter->async_tx));
>                 prefetch(_iter);
>                 prefetch(&_iter->async_tx);
>
