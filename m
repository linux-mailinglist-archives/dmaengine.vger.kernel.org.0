Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366A0B145D
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2019 20:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfILSXr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Sep 2019 14:23:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38294 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfILSXr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Sep 2019 14:23:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so24211339ljn.5;
        Thu, 12 Sep 2019 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzpHMPyEAs7qHXeC8+PI+k8EjPmSxRwc5lCuYXRCv54=;
        b=UZ3qHTaVrczrYkLqCzFJel3IMA/0c7kf0uAfHAAJOzbYtfQv5ist1ZHOa4QlmfW8Y8
         1AccvRFP+4hzmqF/mVoOwGA4l8o5DpECcGgLYz2jE77VlFvAgE+zB30oFDvBEvN4+qN7
         b2KB42vYdwZpch/CRMGMfR6lyFLUvffEYJGADc/Aaexis9rTRYC+WyV2vz2TYvVvKYIN
         /Hj7Z7dhOQ9iBUcmPP31o62k891bi3/x4FEzaOJz5n6DkNAttTbJv+jeqdrBpWk4Jcvj
         /DcBW3x7lGouxlUi484qAfkGHAmC3hpvwfD4UqKFSlkAZsAwUOfj9fqzmF3WTw8wZ4Om
         a/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzpHMPyEAs7qHXeC8+PI+k8EjPmSxRwc5lCuYXRCv54=;
        b=JRwC4ULFD3YzgYjRc3mRYRMNbFOqT7+3F540P6kPU5dpz8MMLd/7w/94jp9LDz+TxB
         E9JrUmThS+A6ZMY9PVJMhouhT2K9kr3KBinkb8GHvdfAlRY9prpboY6WhCy//8eWd1l2
         ypMdG9+bOfai4BLA2iPn6jVvgVgYRPMr33FssriSpL1cm7jTKvvySGwLcWV7gZKvsKr4
         xZuO9VC5k6KdcsQtuGth0vKeSpC71xQ7sYKBffqTryNpWmYUATkTSW+SiOBfifHdM9MC
         rKQOnOO5gaz+sJmRzJrbPmgnaU9jTzfo4hP3csfbTFz6+klFcuBBECS5xRJ0MLp0BX2E
         63UA==
X-Gm-Message-State: APjAAAU5dWgKpoYtku40273+jElO3UxLKqFD8HRgh5V24tn8K/45fIeb
        kW1gXO53K+ljtC97gN9AtHu1Swx1/C1Vqs7x0PE=
X-Google-Smtp-Source: APXvYqyg3z0rmVB8MqaYGii3kSi/ffw+EZze6khxHsFFAgdyRAoLKz5Agii/j7bEpQw09ybFOM96bJvWRrgLf56KWoY=
X-Received: by 2002:a2e:3e0d:: with SMTP id l13mr27406384lja.10.1568312624761;
 Thu, 12 Sep 2019 11:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 12 Sep 2019 15:23:34 -0300
Message-ID: <CAOMZO5BKiZGF=iR071DaWLp-_7wTVJKLbOn3ihwPeVVSNF6nCg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix UART DMA freezes for iMX6
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
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

Thanks for submitting these fixes.

On Wed, Sep 11, 2019 at 11:50 AM Philipp Puschmann
<philipp.puschmann@emlix.com> wrote:
>
> For some years and since many kernel versions there are reports that
> RX UART DMA channel stops working at one point. So far the usual workaround was
> to disable RX DMA. This patches try to fix the underlying problem.
>
> When a running sdma script does not find any usable destination buffer to put
> its data into it just leads to stopping the channel being scheduled again. As
> solution we we manually retrigger the sdma script for this channel and by this
> dissolve the freeze.
>
> While this seems to work fine so far a further patch in this series increases
> the number of RX DMA periods for UART to reduce use cases running into such
> a situation.
>
> This patch series was tested with the current kernel and backported to
> kernel 4.15 with a special use case using a WL1837MOD via UART and provoking
> the hanging of UART RX DMA within seconds after starting a test application.
> It resulted in well known
>   "Bluetooth: hci0: command 0x0408 tx timeout"
> errors and complete stop of UART data reception. Our Bluetooth traffic consists
> of many independent small packets, mostly only a few bytes, causing high usage
> of periods.
>
>
> Philipp Puschmann (4):
>   dmaengine: imx-sdma: fix buffer ownership
>   dmaengine: imx-sdma: fix dma freezes
>   serial: imx: adapt rx buffer and dma periods
>   dmaengine: imx-sdma: drop redundant variable

I have some suggestions:

1. Please split this in two series: one for dmaengine and other one for serial

2. Please add Fixes tag when appropriate, so that the fixes can be
backported to stable kernels.

3. Please Cc Robin and Andy

Thanks
