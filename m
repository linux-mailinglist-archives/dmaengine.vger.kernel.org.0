Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2804FFD8A
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 05:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfKREZ1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Nov 2019 23:25:27 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:33520 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKREZ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 17 Nov 2019 23:25:26 -0500
Received: by mail-io1-f47.google.com with SMTP id j13so17215563ioe.0
        for <dmaengine@vger.kernel.org>; Sun, 17 Nov 2019 20:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQsDLcEyXyNZ3OQMifbvVEZ3NplzHaasghhXs/qlxOA=;
        b=VyTNeG8lo24jg9Wage7r0UcYFxal7oXt8nhyx1QeWg+nhuqUukyOoiLjD6LCnY27Ug
         nfjYibgK1fzqsyWEmQnfZc9eDri04IRvzzltEPIowzgp5InMZik2OIYjVvO45jb7MBOL
         mb7uTkKeTLUl0t1VX7cKzNLV4FmcfuOE0zzRmQ0TQpGkYAGEUMZ22HmErPsjXjJ8YGSt
         i1FZSXWoLFAGng6PO2xAwD4FCVgMRVVMVZkbWBlmhmWNaYLtx8RVMW6DRliNQI9KB4M0
         Sqmdw0Lukorrfr0219fhkE4dbPrzj0NTLjTkoa/wrIp4rk1bFL62Ej/UrsEQ/4gXVSKy
         xdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQsDLcEyXyNZ3OQMifbvVEZ3NplzHaasghhXs/qlxOA=;
        b=qTlq/Um5+kXump0XMycqdJGqcRzXrVwd7q0QVVkEToSFB0MqLDqBr1W1AduxNO8FnT
         TkxuNPLGnThvf5HosUhrGoFJIorpy+Ym5txl+8d19dIbkiUVpRQi4PmkXkhg9slQDbwn
         R5vqwzdJreiESvUhi6/Rqg18e4p+55+Yl/ssn+xEhL469KCIDsQvt+EV57gGW4iSUnIz
         lF1eGWdAifTbs/OX0B4DuOo2UjtO8ihlaC7qnNJS8iMeze8u4Ye1uBBmIn6xLKX9Iyjg
         bn0kNReBamayGiKmkTC+g06HsJRUrdXYpzDWB6hCS6pvy/4b9mjHXcgh9H99WYzTDiDS
         rX8g==
X-Gm-Message-State: APjAAAXR3sDRgFWBGVFSOm5ODXRxYWTyF/SWL/QJtAPVVImH3QEWs4mh
        aRifONHhhU5v0ZRro49BfXkXw9EQtFP8L+vo6OJInGBmbGk=
X-Google-Smtp-Source: APXvYqw5gmgLER6VsF6+FJ2484HLAU3eBw/Jt6TkCuVuDd1dnHhyfNtHBjQvrexQEOCjKQO2rkKI6b7Kn/879Rv52u4=
X-Received: by 2002:a02:662b:: with SMTP id k43mr10852054jac.141.1574051124467;
 Sun, 17 Nov 2019 20:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20191116082253.mdowmeywwtroo6xt@kili.mountain>
In-Reply-To: <20191116082253.mdowmeywwtroo6xt@kili.mountain>
From:   Green Wan <green.wan@sifive.com>
Date:   Mon, 18 Nov 2019 12:25:14 +0800
Message-ID: <CAJivOr7ZaZWzw-5QnOkakmBhN3TidzoM_WwDVpPAsaGp5tMw-Q@mail.gmail.com>
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

Thanks for reaching out. I do have the same question before. If I
remember it correctly, the 'chan' is returned by to_sf_pdma_chan()
which contains 'dchan'. 'chan' s unlikely to be NULL since it's
container.

I agreed that the code logic causes confused easily. Now the driver is
in -next branch. I can check with maintainer where/when to fix it.

--
Green


On Sat, Nov 16, 2019 at 4:23 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Green Wan,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 6973886ad58e: "dmaengine: sf-pdma: add platform DMA support
> for HiFive Unleashed A00" from Nov 7, 2019, leads to the following
> Smatch complaint:
>
>     drivers/dma/sf-pdma/sf-pdma.c:103 sf_pdma_prep_dma_memcpy()
>      error: we previously assumed 'chan' could be null (see line 97)
>
> drivers/dma/sf-pdma/sf-pdma.c
>     96
>     97          if (chan && (!len || !dest || !src)) {
>                     ^^^^
> Check for NULL
>
>     98                  dev_err(chan->pdma->dma_dev.dev,
>     99                          "Please check dma len, dest, src!\n");
>    100                  return NULL;
>    101          }
>    102
>    103          desc = sf_pdma_alloc_desc(chan);
>                                           ^^^^
> Unchecked dereference inside the function.
>
>    104          if (!desc)
>    105                  return NULL;
>
> regards,
> dan carpenter
