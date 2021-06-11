Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961883A423D
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFKMsY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 08:48:24 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:47054 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFKMsY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 08:48:24 -0400
Received: by mail-lf1-f54.google.com with SMTP id m21so8333753lfg.13
        for <dmaengine@vger.kernel.org>; Fri, 11 Jun 2021 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WjfQm30qNPu6jibHyPNCd4wfrut8QTwcDHXaQoyqAVQ=;
        b=ZlzSz06RaJdUTy0ConWKnH9IwJN8O6XTfIG5ngf5WYGm7vS+iEl79ifPmVOHabylRp
         txUUpdpKiLT+gKglLxqiR+v3jbKSGNZXANOgVQQZ0FJj0Q7HFCO0DDlTp67rmccs4bMC
         1wUMgvOdwd3bLOxT3QvCjEgA2Np2VImK+QfesJiycH3u4WDxLvRciKX/PPnb/zARtetR
         j/H/0ns9efT4Jm9wCsCfTqd7hSaXFKiIB49md7zs1ygcwNgC3ZNE5gnCkztvC34+w0Ih
         6hnUepVn6i1Wwn9ixMH9WGmjJ2Q8m5qyXSTvsTAGesoLvd4daYULVPgm+bwaqO+BO0e8
         QyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WjfQm30qNPu6jibHyPNCd4wfrut8QTwcDHXaQoyqAVQ=;
        b=FTwd2IuZynVfRoh+gEmmchqAVavQtFZKIN6b/WcZ3KBWtClETYTC4x6BjGvVskFeel
         zVEbP5Rny3MWv0TwEd/vqSI0AkROjbAe9YVW6I+kVc7LppdFl/6wVgPux/tRwGadEnmC
         AaFyRh/uAiHUh3SEXY1xs6YBZJ5ZzmESFwTb8EYh0Guz0/v3Wlr9epoI3JudzkguP43x
         PDxMG/Z6bsWOTgpR/eSOeyHEAtjTudNX75rfn/FzRa4DdseQLzgf8VlbM1jT210/jy4+
         B9ahD9agJDl8PSZ8Pz2074AjgOKlE4dvclUGmnDIdRDAt+qmy7k2T7OOm/uMuetPn3nV
         8DvA==
X-Gm-Message-State: AOAM532ZU8LKaHe6lP2Y6vXTkUMHnuhy0fDqNmZVmpMljiG29MUoZzTx
        BFnHB8NLxG/MQ/rlQPFtfQQ1NXJe1d5emrCLnV4=
X-Google-Smtp-Source: ABdhPJxqCo+tnzJRSIy+s4ea/SSrsNzU4+mgNpD7oNB1j93DqixTlDKTTWaYiPoSxOZX0PpWvxdl7LhX9ggRds/poGM=
X-Received: by 2002:a05:6512:33c2:: with SMTP id d2mr2463193lfg.443.1623415510095;
 Fri, 11 Jun 2021 05:45:10 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 11 Jun 2021 09:44:58 -0300
Message-ID: <CAOMZO5ATKJAY-35DfxxN2aN+obqj_6iTt10umMO1R6y0=uQD0g@mail.gmail.com>
Subject: i.MX8MM SPI DMA not working
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

I am seeing SPI DMA failure on i.MX8MM running kernel 5.13.0-rc5:

[   41.315984] spi_master spi1: I/O Error in DMA RX
[   41.320660] mcp251xfd spi1.0: SPI transfer failed: -110
[   41.325947] spi_master spi1: failed to transfer one message from queue
[   41.332532] mcp251xfd spi1.0 can0: IRQ handler
mcp251xfd_handle_rxif() returned -110.
[   41.340432] mcp251xfd spi1.0 can0: IRQ handler returned -110
(intf=0x3f1a0012).
[   41.347990] spi_master spi2: I/O Error in DMA RX

There is an old series from you that aimed to fix i.MX8MM SPI DMA:
https://patchwork.kernel.org/project/spi-devel-general/patch/1593523876-22387-6-git-send-email-yibin.gong@nxp.com/

Do you have an updated tree with these patches applied so I can test
them with a recent kernel?

Besides the imx-sdma and imx-spi fixes, do we need an updated
sdma-imx7d.bin for SPI DMA to work on i.MX8MM?  I am using the one
from the linux-firmware tree:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/imx/sdma/sdma-imx7d.bin

Would it work if a use the ROM firmware or would you recommend using
the external firmware?

Please advise.

Thanks,

Fabio Estevam
