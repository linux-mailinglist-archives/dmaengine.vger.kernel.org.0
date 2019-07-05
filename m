Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97D46065C
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfGENKz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 09:10:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46378 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfGENKz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Jul 2019 09:10:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so9217278ljg.13;
        Fri, 05 Jul 2019 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEyJOO8kYpWKc8QSO4ONNsoAI/4yuJeK2ThjsKjv10k=;
        b=DRDlErc+0kXzUdgaWp/ZaB5wi4aw2JvkIenojy2RYxniLxqdRdE7OhHk0OKezKjMk7
         mIzCmiFXicrLQFXrtAAX6Unu/lcDVUEBUYzcgoeRMca058CIp+veHiSR+0gEpAbVKtdA
         pbiHoscgX80CZp1rxPQNTLcgrMO+R9VxPtTu41FBuWk+MaLsV1cBZ5xS2tJookUbOABF
         VXJN6mCyQCDTPR37XXptcuKGQs7k5BORHje6PuZLnEzbIrVo+JciviDWdwF2vPVwqHNo
         Qr5FiOL24R528bv7CD14UXtyeraMCivrT2FwgeBjOZ9PFta4+ELpHCfCfl8l6i+vP6oa
         f9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEyJOO8kYpWKc8QSO4ONNsoAI/4yuJeK2ThjsKjv10k=;
        b=Yk9F1BJiEZ5DXaCNboeHtXhPuH/LRTsKlqcPVcakW6CKCjtJu020XshfWsw8NUEQIh
         ZDrKxpWX+ZA1i7agnwb7HEJMIxXSIowK/KLzdKhRvSDOanA5dhOWlNy/eKhxtjF9BfLt
         kCTwCWW4bajXV4TmlN9E/Fh97dl0AyzQDHXT8Uqbwayod6jTVZY7+7w/kWqqji32WJJa
         mlQRTKncti21e2AIsBu/I+r37iNHcDfKLghY1g55gMXCqofyzAcGZg9w4nPtnxTt262E
         sTpNMuYgomGr8Y5qwgniCZdBcG5G2yKrBEoTLB8SzZ7I4JtzcoE/1+QEfbgNx90IBiOi
         JYIw==
X-Gm-Message-State: APjAAAVvIbxEvAwU3ieOc7lFbdKZ+jFqy1KYXJ7BXHXHeH4/ZrP54CF6
        zBBD4uvvJ19o4ZvbTRdSvYs7Cc8vWYvuxM7ds1DRCAW9MFE=
X-Google-Smtp-Source: APXvYqwWNOMyja5vtXudK/+kFDlFUKXSubGT1Aa9J+3NDl4NBx2ur1SfoYASTVZgHZ/Y44Dtc7FNDsRtfKOClAQi8e0=
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr2152456ljb.211.1562332253406;
 Fri, 05 Jul 2019 06:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
 <20190624140731.24080-1-TheSven73@gmail.com> <20190705124646.GD2911@vkoul-mobl>
 <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com>
In-Reply-To: <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Jul 2019 10:10:44 -0300
Message-ID: <CAOMZO5AeA2PryHHNqxfhTYjJd-QZrm++ctjuuiTzpGC4UuxZ3A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error path
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 5, 2019 at 10:09 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> You are of course right, I was looking at the wrong if.
>
> Apologies for the confusion, I did try to look at what you
> changed, but your git repo listed in MAINTAINERS appears
> unresponsive for me?

Works fine here:
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git/commit/?h=fixes&id=2b8066c3deb9140fdf258417a51479b2aeaa7622
