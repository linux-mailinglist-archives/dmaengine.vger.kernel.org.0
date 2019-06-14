Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8354545AE4
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 12:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfFNKtR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 06:49:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38197 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFNKtR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jun 2019 06:49:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so1415581lfa.5
        for <dmaengine@vger.kernel.org>; Fri, 14 Jun 2019 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYKF4WL4sBRzlWXeIG5ktJQ3i0pzLiujECWp3FJ+AQ4=;
        b=DD0yPLtXKrYM73ZSPeehCW6jVoHRh1QzwZIQ27nX17YtKSKk8RX6P6k0VvakiJCfE8
         mHLBeHjltJVfZdxF92k8aVQxpx5n2Hxhbdklnz5havaxcL0X4/WJTKJimJZhxYQm75MR
         fv6862r6Eg+Y1gqgttHVlrJjqBvS/ok1MKEn6qkokAc0yPbI5c1pgKMVGvhZ/34lZoc/
         Kin9V4IHliUsOU5IxSnvWZ6nPWf5QVZP30dNq+UMNFbqmfRWJ9eylhQ62ZX6mnJwEwKi
         YKVQE2lyDwZ9jC89Lp3Kxf0hl5cpSY4FL3gBKgaj8Ih+Db6megkF0rDlGN6cPxwo/XJz
         rvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYKF4WL4sBRzlWXeIG5ktJQ3i0pzLiujECWp3FJ+AQ4=;
        b=dtoj39PJHvNX4IGebbUE7yIk3PdP+vpx5/XdLSEbPSTy7PqY5x8L9feAlxuARV/5vE
         gpkvc1sR+Kjc5c1G7r269CiVT6U1vhkx5TYoUP0DMBvAlWZ2bdVbp8sYOGtOMagR2ab5
         TnD0ysZc/Ole6gKcVIT6Xf4GgZqZQ2iNcXIgEqyKTRB70ijSQRfCBBQyMAvjbW1HHW9i
         OUSUb873ODRyh+HTHQPm2RNiHE5pOcrOIVGQ4eplkFdlzv9qX7Zq42Is2oYfayUnZY/C
         vTBDrQ2oL+qm/Gmz3JknpQltZOtnhJCsTctkxwnfydXDDqOHtMMvAkyR7AfxHmTE7Lxx
         TsPw==
X-Gm-Message-State: APjAAAXBG4TdnBNbK6vWAPZq8Uiz8DcZGXTERFt8KAWI3Daif8EWcxrK
        U4WEHro9/oDQEGrkUzqzgKWaCSiXwP3WNAZBvWI=
X-Google-Smtp-Source: APXvYqwTEnpKubkq0ogtf1g0gteep+dXKfW1k1yY0fq2kkXTq6rxA9WEFetnbY/57YRZhyediiOM8kEZcFRSCB/1XF8=
X-Received: by 2002:a05:6512:29a:: with SMTP id j26mr14374337lfp.44.1560509355444;
 Fri, 14 Jun 2019 03:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190614083959.37944-1-yibin.gong@nxp.com>
In-Reply-To: <20190614083959.37944-1-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 14 Jun 2019 07:49:18 -0300
Message-ID: <CAOMZO5Do+BsZEX43w283yWed8fQVtTC+zAvoktPLTj4c_f798w@mail.gmail.com>
Subject: Re: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vinod <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, dmaengine@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

On Fri, Jun 14, 2019 at 5:38 AM <yibin.gong@nxp.com> wrote:
>
> From: Robin Gong <yibin.gong@nxp.com>
>
> It is possible for an irq triggered by channel0 to be received later
> after clks are disabled once firmware loaded during sdma probe. If
> that happens then clearing them by writing to SDMA_H_INTR won't work
> and the system will hang processing infinite interrupts. Actually,
> don't need interrupt triggered on channel0 since it's pollling
> SDMA_H_STATSTOP to know channel0 done rather than interrupt in
> current code, just clear BD_INTR to disable channel0 interrupt to
> avoid the above case.
>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reported-by: Sven Van Asbroeck <thesven73@gmail.com>

According to the original report from Sven the issue started to happen
on 5.0, so it would be good to add a Fixes tag and Cc stable so that
this fix could be backported to 5.0/5.1 stable trees.

Thanks
