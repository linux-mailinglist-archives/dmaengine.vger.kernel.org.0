Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8217483E9
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2019 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfFQN14 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jun 2019 09:27:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38241 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFQN1z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jun 2019 09:27:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id d17so9263306oth.5
        for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2019 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJsPsjYAC+D3Ahla1gO6b++R1ySTexA3DFmiKdVNKWo=;
        b=MXkyJQB9PxauZ8mD4qfnd9cMinYSX8UgPaJCqpc2N6NWAP8Do6zPFB0IrVa9ktAWIt
         aouaZblOwdUXxA3WA+jdAygJITWcfOAl98fr/H4EDsSZVD/ROYlXL+cWBa9mKzk4vHci
         NKcp7yaAptskxYFgzG59xEIBPx95gfoDuMpqNfLSYJp2jQydPMrrR6H/tsNRBR3muEl5
         iXWL5M5mwD6Rasyt+fAqcbY/Rpm84bJgDFT+ouTQVvwPCALeItlRvcf9MJ1NYAwL+VeR
         CCoUD2skfkr3YCSTpRB14BPWTTGRtD6fgC3f+/onHzdO37eawrr8zaYsbJRF46MZCO6q
         ktYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJsPsjYAC+D3Ahla1gO6b++R1ySTexA3DFmiKdVNKWo=;
        b=HGzc+GwOg3UUlgo+FXTXPYRGi9WvoYmuMiWLTvPaEDxPVSg0q2DxL9Bm7wwyKq64mG
         I5Y+kow2l8EfPHTgSgAn8VR5FoeSQLevHjHSMFrneOEfFpUyddIAFyVM9XmUKOj52C2g
         U3LBrV85WseLhMX02/lz9l6XEuBHiRPlJZntGbPJSPb9lNYWOcr8ZKwn2qByPo941BkO
         yacpqZbzB76Sr2JJN0BcV2GJf5zGfrb+IQMYhwGA/NWc5pG1RNTwQT8m2oxXnm5M8CEx
         viDXP++GYEelknxyL5Y1tmNPBmX2zdu8wPHM6cc8mDNe2N7v2nrko6pikJHnxEDiXBWg
         8AWg==
X-Gm-Message-State: APjAAAWRhdf/v0TmOrHN+YoExXh55BfWEOnB5jhlzy+4JMuZ9o4rwHw9
        aTHnaEMEF+TYh1lZad2KP2cPhil1ti12z+wiIQw=
X-Google-Smtp-Source: APXvYqyhiqkq9CGaDNxwiD6SQeF+F81INxi2lxJi8huCiuSNrRrpuYkOSzLBr6YGnAzUR8mMAtP8t+7zjxH9w00HMOQ=
X-Received: by 2002:a9d:7650:: with SMTP id o16mr38379346otl.0.1560778073731;
 Mon, 17 Jun 2019 06:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190614083959.37944-1-yibin.gong@nxp.com> <CAOMZO5Do+BsZEX43w283yWed8fQVtTC+zAvoktPLTj4c_f798w@mail.gmail.com>
 <CAGngYiUWy5FM-zsT55-yY=kahLObZGYw=zU0F9Tzp9T2S3G6LA@mail.gmail.com> <1560765934.30149.26.camel@nxp.com>
In-Reply-To: <1560765934.30149.26.camel@nxp.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 17 Jun 2019 09:27:42 -0400
Message-ID: <CAGngYiU_kxRXbk1vSzV+hBZ=SQdxe2h7TXj3dbK6Q=YyXcDr0g@mail.gmail.com>
Subject: Re: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "m.olbrich@pengutronix.de" <m.olbrich@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Robin,

On Sun, Jun 16, 2019 at 10:02 PM Robin Gong <yibin.gong@nxp.com> wrote:
>
> The default imx defconfig and dts should be ok, because firmware load
> is delayed after rootfs mounted where firmware located in and before
> that, some driver which use sdma such as spi/uart/audio may have
> already enable sdma clock which means channel0 interrupt could be
> cleared immediately without interrupt storm. That's why I can't
> reproduce your issue at first, but catch it once I sync with your
> directly firmware load defconfig. So seems not very must to CC stable
> tree?

As far as I know, the bug/crash does not happen if you're loading the
sdma firmware from a filesystem. So the vast majority of users would
never see the crash.

I agree that this is not a high-priority bugfix. But it's worthwhile for the
stable trees to have it.

> Yes, but Michael's patch is the right direction, at least it fix RT
> case and meaningless channel0 interrupt storm coming before clearing
> channel0 interrupt status in sdma_run_channel0(). Now, this patch could
> fix its minor side-effect.

I'm not suggesting that we should revert or change Michael's patch. Just
that it would be good for the v2 patch to contain:

Fixes: 1d069bfa3c78 ("dmaengine: imx-sdma: ack channel 0 IRQ in the
interrupt handler")

This should allow stable maintainers to pull in your patch if and only if
their release already contains 1d069bfa3c78.
