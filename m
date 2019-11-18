Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDBD100099
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 09:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfKRIlz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Nov 2019 03:41:55 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:41051 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfKRIlz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Nov 2019 03:41:55 -0500
Received: by mail-io1-f52.google.com with SMTP id r144so17753361iod.8
        for <dmaengine@vger.kernel.org>; Mon, 18 Nov 2019 00:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrJHWfr+LGQ/k5dnM0bN+O+tHzuCMT/6DLGYdaMSND8=;
        b=ljRcbmCH1Uu3c493sES9cLZsKkgXIjjNvKesBmkWzvwfN1Stw7BgPrNDdq8AtBS6Au
         cwQ15qTTvEuk1Ajwkf/AuxjesLuaNdUwV00lHUAq1lHtG37/vt9SKG1U89+ZacSYBpsE
         87qnXFSMj9UEUXxwSNnT2asGqWxkc/EO6wV+VNp5cg5Jpx4j/aBIGegKYwPiAUH224vv
         c83dyfdpe+Tia0sJFn6VB1Q7cS0dHHRD4mSzYGVnJmL5c/xt/FpA0xPIRGCN0ihIt2fF
         FM3xilW+n92jSMyQ2qykrhTaLb9DXsNha5t9zRBbvsNdRXNb1udDasKooExWFx7pPwFU
         gQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrJHWfr+LGQ/k5dnM0bN+O+tHzuCMT/6DLGYdaMSND8=;
        b=qK0mYLfw0aoch2hd5AT2VDa9r6lTh8fm3f+uMPvrFllwpeAtoCTtog4TbO697CatYr
         4oZ2o3CpB3+K8Aeds8KsWZ81VBXQgwgruy6/twlRkj8KttgyDF1xi75XwlQSMK5KK5no
         ElnR24dhh5EY2bSxEyDLqwxgnw80Kbx/5t1lHQ/CJnnt5WtmdrJyFLVdbf3NZocKR5uE
         hZLlhMUcudyMt2H3J++GW6fZJs8l688lvvDCafIF4Z7TJ4purYWQY/EuO4zajUVgRoLu
         vt94/MLpfQwe+AUge747f5x2vesNr8MDW2toLqXiPPTObwpnMWiA3Ki4a0omMqatEXNn
         bG1Q==
X-Gm-Message-State: APjAAAXyyhhGSxRoqKUpkp9WfOrZ3dNORzdE9+xEV6lZfsqDs5Jrswdq
        1Nw2z/9fx54r/dqT71oh0drg4+NVAvwcUCcbrmzcaFSr
X-Google-Smtp-Source: APXvYqzp2FZdCeg8vw3Lm3poGe3kOVWCzDxy1qvWc1BZ/R00Fw/AzI5nSWy/iLL4mCDs5++BnjT7eTKVxp11SxDY2C8=
X-Received: by 2002:a02:a08:: with SMTP id 8mr12289083jaw.98.1574066513456;
 Mon, 18 Nov 2019 00:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20191116082253.mdowmeywwtroo6xt@kili.mountain>
 <CAJivOr7ZaZWzw-5QnOkakmBhN3TidzoM_WwDVpPAsaGp5tMw-Q@mail.gmail.com> <20191118063704.GC1776@kadam>
In-Reply-To: <20191118063704.GC1776@kadam>
From:   Green Wan <green.wan@sifive.com>
Date:   Mon, 18 Nov 2019 16:41:43 +0800
Message-ID: <CAJivOr5j8uqDhrhY1CY=3i_Ydn0BPGnymP6Cz4G+Er5=y4u=mA@mail.gmail.com>
Subject: Re: [bug report] dmaengine: sf-pdma: add platform DMA support for
 HiFive Unleashed A00
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dan,

Thanks for the comment. I'd like to do check and fix it. And to be
honest, I don't use smatch tool to do static analysis. Looks
interesting. Let me enable it to see how it helps/works.

Thanks a lot.





On Mon, Nov 18, 2019 at 3:36 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Nov 18, 2019 at 12:25:14PM +0800, Green Wan wrote:
> > Hi Dan,
> >
> > Thanks for reaching out. I do have the same question before. If I
> > remember it correctly, the 'chan' is returned by to_sf_pdma_chan()
> > which contains 'dchan'. 'chan' s unlikely to be NULL since it's
> > container.
>
> to_sf_pdma_chan() is really a no-op when you read it carefully.  "chan"
> and "dchan" are equivalent.  Smatch parses it correctly.
>
> You are obviously correct that people should check the original "dchan"
> instead of the returned "chan", but I feel like some people are clever
> enough to know when container_of() is a no-op and deliberately check the
> returned value...  These are sorts of people you don't want to get into
> a debate with because they're an ultra annoying blend of clever and
> dumb.
>
> My other comment here is that Smatch doesn't warn about inconsistent
> NULL checking when the pointer is provably non-NULL.  In this case, the
> only caller that Smatch doesn't parse correctly is ioat_dma_self_test().
> For all the other callers it knows that "dchan" is non-NULL.  In
> ioat_dma_self_test() the code looks like:
>
>    330          /* Start copy, using first DMA channel */
>    331          dma_chan = container_of(dma->channels.next, struct dma_chan,
>    332                                  device_node);
>
> Smatch says that both "dma->channels.next" and "dma_chan" are complete
> unknowns.
>
> I could probably safely mark dma_chan as a valid pointer in this
> instance which would make the warning disappear...  Maybe I will add a
> check to see if "dma->channels.next" can be controlled by the user.
>
> regards,
> dan carpenter
>
