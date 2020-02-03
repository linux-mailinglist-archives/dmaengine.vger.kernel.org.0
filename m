Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC22415045B
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 11:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBCKhg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 05:37:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34320 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBCKhf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 05:37:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so5701694plt.1;
        Mon, 03 Feb 2020 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zY3ZjySCMgRqo1DurDULy/mPL5i5TjLVEpmoFrzFls=;
        b=KY9mY/PAd+JI4NB2OCt+ChTAjVMm4azYwodEGZcskbpKNzD4xmncvq+BibFFg+V6io
         UV/SiEZ+thmt8Gud4r2Q5C3YCyB/wjhRPuvvNOC5I1YUQiwH9EoCIyE/AlvCv8MUG7oQ
         Pe/qwBqZtkVwULJrSp5mWZ5cOX3Jkto8/95vZYjcXfaKoHqRcyhpVUT8VZ6XUU72bj7T
         Nkpnv/Q5jDrnK+z63Rg83nh5pt6z52sLReZTfiZhjQhIewBsEy/cOOGwTmlTbnr9HJ3A
         HBUI+93Db5nkkR033fr5EppcVVl4Z2K6PlpB9GurUxm7EllZVu+pkzcrdVDMsdlBNMs5
         wmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zY3ZjySCMgRqo1DurDULy/mPL5i5TjLVEpmoFrzFls=;
        b=EGyulTqxANaK3xa/cOVXqpYi2dE7MN8EZ14i+WGPbQqn9WGnEFBYW3t45o1nchmmQZ
         LUIoLwrh00bLdvjuTERCGE4z714/tXeZxCHtk7yD+sWAbF4prmp0sZIxOEW5MXNG+O5C
         f+nNLYlGLVMmPfHuFizxNadJsP/963lcBXITnjoSHZPahVGs4t3BJxBVDe4mGA48tflo
         JrfpTLuPLFIYHrSlMiLRfN4vG3yQgJx1hmbPpylYCNkVUT/cb1UEIdgkGKwvFrn4gFmS
         7Ebt9S2/nxTeIBi8o6u5DWstD/DHO/cBGXkxt3oSCqLfAU9KCOZ2LPbZFKsHkGDlfpkH
         2Mmw==
X-Gm-Message-State: APjAAAXvQ+vs+9f8gEE+T2jpJAa0u+fRQQks4FycULSpEIJgbmCGqECH
        jT5F3oVopIPk4gxF4oos7JbT23CcSYqNflCCSQ4=
X-Google-Smtp-Source: APXvYqx62M5/se5iwIWB9pEguzBWQOMquBjSvm0EyvQgjYLzX9CeYRP3pZKp481LnhUGHiwWjEe54uiHhSYqtzMv/vw=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr29301013pjq.132.1580726255079;
 Mon, 03 Feb 2020 02:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
In-Reply-To: <20200203101806.2441-1-peter.ujfalusi@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 12:37:27 +0200
Message-ID: <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> dma_request_slave_channel_reason() no longer have user in mainline, it
> can be removed.
>
> Advise users of dma_request_slave_channel() and
> dma_request_slave_channel_compat() to move to dma_request_slave_chan()

How? There are legacy ARM boards you have to care / remove before.
DMAengine subsystem makes a p*s off decisions without taking care of
(I'm talking now about dma release callback, for example) end users.
They will be scary for no reason.

-- 
With Best Regards,
Andy Shevchenko
