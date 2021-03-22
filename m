Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A046034531F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCVXjL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 19:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCVXi6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Mar 2021 19:38:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468CC061574
        for <dmaengine@vger.kernel.org>; Mon, 22 Mar 2021 16:38:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h13so21409466eds.5
        for <dmaengine@vger.kernel.org>; Mon, 22 Mar 2021 16:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfwnF58LuBF+vh3O8zN1tvLi5DT492lbdFnVEhBkIQ0=;
        b=oBYqisc8VDddG5fqLseYvUT+28Eio2DmHoj79odFFKU0NZMEcAJYxCPtMu2n3hcnlc
         ZTNNhjBGJHn7S6AR3d8p+gVct9wxbCxKi1qnSlh0lK9BonONoLy83zs+u4IgGmxd85kg
         t+iqhw6U8aql27nVKtOUQtmmzGfzlafPKPnsBM7e1lg/KfWqOWau2kNvR0WENAuxxFg3
         Y9My++B1s9BfYr2ohrFKmTeX8rhp9ZBQl8cdlfKfoPDhHdoxw3BRGEGzzvoAQ1OFqU7i
         fHfGEmh2xj3AqqNOp6slOhszXXmXM4zMjvfHbamPkB40GVU/UkjgDwrvFZPOHqw/gsd2
         H6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfwnF58LuBF+vh3O8zN1tvLi5DT492lbdFnVEhBkIQ0=;
        b=rstBlcQ64tmwqgaIVvBluDBzsVsrUCm+EGxwlIgp+gYlZ0tUn/pN8puB9epugq8KqL
         V07JzgaZOIYPUAc4rLexge25U4I8Bpz/eD+PWtPq3vYj0j9QQ4npw8Sc+1omx21mhcT1
         zqRN8Sax2kvMrR3ieTgyRcGs6MQKqVqVO4a4zHm8bcR1iCsprpNKtTbjF+iJxBJSbTel
         zraqVwfOsdvrnfrgv7zFKyxCYob8sqP818W9pfIE0yTjXPQiRCQMlSlgfLeRJdCc+p8D
         zJvlLrXU7A8mz3J3cy5dCHWgMO2NX1BqLhTPB3heGyPXaKUrAfhcBcIinXxvQggBzK9y
         cXjw==
X-Gm-Message-State: AOAM5311VQXX6cWw/AVIQaG69q24U550W33MFZxwCTgnBe0WepWYCWh8
        kGyUStF2mS+0+uNq5zsZzmzd7D0DwxXM6cRFULFPYg==
X-Google-Smtp-Source: ABdhPJyDYQfk8Hqj4kkHNMWmn5ZGc7dJF77cZOU3RSOWG0//qjSQqhq8FQHwgdgDnSMmdX77iyDa2JOkBUbXm69EiH0=
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr1961444edv.300.1616456337251;
 Mon, 22 Mar 2021 16:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <161645592123.2002542.5490784749723732920.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161645592123.2002542.5490784749723732920.stgit@djiang5-desk3.ch.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Mar 2021 16:38:48 -0700
Message-ID: <CAPcyv4j8h3Ec-NX+tfaK+evzG8NQq-meVX8VwELQpDyTsTgZHg@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] dmaengine: idxd: fix cdev setup and free device
 lifetime issues
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 22, 2021 at 4:32 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> The char device setup and cleanup has device lifetime issues regarding when
> parts are initialized and cleaned up. The initialization of struct device is
> done incorrectly. device_initialize() needs to be called on the 'struct
> device' and then additional changes can be added. The ->release() function
> needs to be setup via device_type before dev_set_name() to allow proper
> cleanup. The change re-parents the cdev under the wq->conf_dev to get
> natural reference inheritance. No known dependency on the old device path exists.
>
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
[..]
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 03079ff54889..8a08988ea9d1 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1174,8 +1174,14 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
>                                   struct device_attribute *attr, char *buf)
>  {
>         struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
> +       int minor = -1;
>
> -       return sprintf(buf, "%d\n", wq->idxd_cdev.minor);
> +       mutex_lock(&wq->wq_lock);
> +       if (wq->idxd_cdev)
> +               minor = wq->idxd_cdev->minor;
> +       mutex_unlock(&wq->wq_lock);
> +
> +       return sprintf(buf, "%d\n", minor);

As I mentioned, let's not emit a negative value here. ...not that
userspace should be using this awkward recreation of the existing core
'dev' attribute anyway.

if (minor == -1)
    return -ENXIO;
return sprintf(buf, "%d\n", minor);
