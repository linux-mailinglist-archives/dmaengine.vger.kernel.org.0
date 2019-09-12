Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653A6B121F
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2019 17:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbfILPbQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Sep 2019 11:31:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36229 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733001AbfILPbQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Sep 2019 11:31:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so19750837lff.3;
        Thu, 12 Sep 2019 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLThGLGX2luBPY/V3tzpyvjSzQN5EJNand59KMNVjgc=;
        b=gkG2975pwBiCBXaPE6eTjd/T6v/glmnTKg3B5kK4SOVJDsDgKIGQa1k18m9BcBs9VS
         bAO7rcjTbL5EVUOf1frETZsAHAoEXE7QPTHaIkBFLZn39bQ2PSgPKEGbTIEce8MaImDp
         wPbQIRdRURaivJt2WWrFc/NBYU+wUAcBFczFFGuzXiTVCe7vCvJ9tBxeX7zmaH3BTT3k
         pe+x8odbQtrIXAhdSKSM3t9rP/1oF2vADV4q3300DjrKHBGEAlWD+d24H49Chk7L2xzT
         IxbuEjWlEnx4tcdExp98Wrlhz6qxyS5Brp72oqRne2wOEwkOLOXbxidzW0McZ3W8M7H3
         7H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLThGLGX2luBPY/V3tzpyvjSzQN5EJNand59KMNVjgc=;
        b=KIFi6XjudEB6+RaCJ/QEvQ2sk+sxeZG23M5f11ipKeAMF2CoaBK8vcsDyJqERHO1Ct
         WeETe8llH8zMdptU2H0N7EBpVtoHh7Jbjg54KP/yiqVP1eUlTXeOuv3qLAVIN1J5vbuX
         g7IKGZagW5IBv2BO6dm1a6eQquxhNeesY0vjC/jhvLoBjYTUjO+RfCkSzWP8Xjej3Pfd
         73Y1jLluUWkOnhsMFurUE69n6stebsIbRDO4oOBYrz0gncQybVHWRAmGp+H5I7qsumb2
         PgQWcLdt6qO5UMvjCqV70De+pvfUNm9w4E0OwX5iad3Mw2MRNsWxXt84RxCnoJ2UoNVY
         7qhg==
X-Gm-Message-State: APjAAAWLZ10ZzyCChwA73DAtOTuoNWea8eMYTYXiesAH37bzUnRa4JGL
        VEmHsLMCSIqKTjq7wNyDYSCeJb/SboAItrOoUh4=
X-Google-Smtp-Source: APXvYqwUhkAPW9D2SkLS1McuAXKVB3YjfihtVnFvJQvIuEmwcKR9GEFxQHz+6tPz/KYnEI/dqNUstw+dR+4k3wO1i98=
X-Received: by 2002:a19:2207:: with SMTP id i7mr28348579lfi.185.1568302273356;
 Thu, 12 Sep 2019 08:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 12 Sep 2019 12:31:02 -0300
Message-ID: <CAOMZO5Bxks8709gEA+8OFH2b0LYqJd1EmpSbKEgPJo+64Pf3EA@mail.gmail.com>
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

[Adding Robin and Andy]

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
>
>  drivers/dma/imx-sdma.c   | 32 ++++++++++++++++++++++----------
>  drivers/tty/serial/imx.c |  5 ++---
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> --
> 2.23.0
>
