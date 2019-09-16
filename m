Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595E3B3BF7
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 15:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfIPN66 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 09:58:58 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33274 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfIPN66 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Sep 2019 09:58:58 -0400
Received: by mail-ua1-f66.google.com with SMTP id u31so2181665uah.0;
        Mon, 16 Sep 2019 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZkupYvtBSCgKvrJHoyKINcu7Om+TqesekV8j3GB0l8=;
        b=abcnjjRp0vfqDss/cKOd135SiL2FsmKpPoVJY3cDGezMtJYB2RDqqK33YBjLeoK15k
         52xq3IKCxncEyF6pFqAjp9j/Uu3gZAaeah9VUzvW5kPRoeqX+XTEL8QZvZOnIseZ/Ngw
         qHCCcVfOKj83hZTbK6Ix/I6MS+PujIU+ATucD0mmoPkRWHs0KDbh395ALd+txHZbtBaT
         gjL3gO/fj5TCK9YoySfJa3EHtyhoXpKOMydiT9aAWJ2THFtA0IgR3HXJOCkuNWOkz+Hx
         CNzThJ/K0TJgQr9EJGz8xViE7j03o65dPMFUY+u/iztYZ3kZKAJIt/pbpm1NtyWQUnhg
         M8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZkupYvtBSCgKvrJHoyKINcu7Om+TqesekV8j3GB0l8=;
        b=gxQfBSIr+j2V5y1+Mok0BM+kpZmpxj8MATkMLzo6mQJgegnGZuSpwGaXoFhZDYDLPT
         2vKdhB45nTtWvtOHEJ/URLmWPEA5lh9iYAe0FDnz9Upi+I1tL5wlshfjTJ0qwH1AxnRR
         9/tySsTG8NWlmF3ACJ75osPGRo8yzmRlaG98flgv3w5ZeAtq7hlwjr1dtOkTd2Ivtoj+
         6RTAbZTHvUHqrlYALxXUn0gDD0SRRlN0960um8XGWoR/LlibLYjvhMuR7SuJSEkt0+N8
         yrtP39M1Z6FKLSfsUnTRb6cBRVmySHodNsLeidUjXVJskTA38WEldkt0gZL4WZN7xLJl
         hGCQ==
X-Gm-Message-State: APjAAAUfdFTpfHmx8ollDmrOLrW1AaIMben2N18TOHkq0RY5O1cCwjVL
        rq1SB4B87YDvOo/gLCtlXjKfYwCIKvyqEybWuqs=
X-Google-Smtp-Source: APXvYqxCMEZl6OxrxpHpVk54lt6TihIEe1Fcqyo/s0j004PQA6BisRf6ikHlA0omRb/c6VbpoOQnGbGIAwgH8aLaW4Q=
X-Received: by 2002:a9f:3110:: with SMTP id m16mr26100819uab.10.1568642336893;
 Mon, 16 Sep 2019 06:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
 <CAOMZO5BKiZGF=iR071DaWLp-_7wTVJKLbOn3ihwPeVVSNF6nCg@mail.gmail.com> <2613a28d-d363-ee4e-679a-e7442e6fde48@emlix.com>
In-Reply-To: <2613a28d-d363-ee4e-679a-e7442e6fde48@emlix.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 16 Sep 2019 11:00:47 -0300
Message-ID: <CAOMZO5BftiJcpefSaM0-DAdhOqrKfv4k5n=y1RhbTpZ=HZDtOQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix UART DMA freezes for iMX6
To:     Philipp Puschmann <philipp.puschmann@emlix.com>
Cc:     Robin Gong <yibin.gong@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Philipp,

On Mon, Sep 16, 2019 at 10:55 AM Philipp Puschmann
<philipp.puschmann@emlix.com> wrote:

> Thanks for the hints. I will apply them if the contentual feedback is positive.
>
> p.s. Did you forget to add Andy? I don't see a Andy in the to- and cc-list.

Andy's e-mail is fugang.duan@nxp.com, which I added on Cc.

I think your patches look good and are in good shape to be resubmitted.

Thanks for fixing these hard to debug issues!
