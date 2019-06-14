Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9394645E14
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 15:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfFNN0D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 09:26:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41790 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfFNN0D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jun 2019 09:26:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so2602827otj.8
        for <dmaengine@vger.kernel.org>; Fri, 14 Jun 2019 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0OJmGrN/dUckm8xh8/mUqwvTl2m3MsC/Nix3u2EbOo=;
        b=qnmZOrT55WICaHNRVQwbPhpDLhQ9v0a+iHtcCyaMhVpCyoneH9oAOuBKoqF9Jhg5Y7
         fiMHHhBY5xT45QppZFNTXizLTM28cqcVtay4I/KmcB9PBLkZ+3UISDtysaQpGJAUvD8p
         FaXdCcyrG6eT2aYg9tfbalMYtjbqJO6ymYuutbIQSMpIZKD0DJqly6nfy0IEaOrsFA3s
         NgsQ40wco1ktUihHcmvXrLk3Mo7Stsqtcde9pZsHaqQA6xnQkosZhas2AFvQcbJi1Dv7
         qqxHhuKPtLo4A92pO77eJ27C09s8xT+N2ETINcJ9D2TOdn5BVdmhElSPO+TsokZM19EW
         cUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0OJmGrN/dUckm8xh8/mUqwvTl2m3MsC/Nix3u2EbOo=;
        b=HbgVoM3kV7WDDCIOHAtUCIFpoBONiSfjSvHHH4KA8NqPmV/wVLDBDWYR7BvZjRTERZ
         +iMpvk1ZQd//Bxjospn+jqCYLx29K8uIRXahYlCvttHJn9/7mr3L36wi5mqN7TEhwkep
         v3SUZiJaF9V7Le1tmX4rHuX0Qs1GDK0VZLH0s4WtDa/s+6mUYQVE3UTi8ycBHLe/zffO
         iiXHoaqMnkaUAeIz0rTVLw2EyRas1yJCI4rTKnVa/nVs13bsaPNs/nTu70zdnGK4gZnx
         1Dk0a5UomUWJ6POIgPX6ROG/ZDQ4zRPcPFgsRTN4MPacfMJPnNud6paRQGq9w+CABd8h
         aBIQ==
X-Gm-Message-State: APjAAAWiQC3JnEIkqRHApQ0Y4gygNbfZ3B68nM+mUALALGSF/RuWu3tP
        fRPouFIJ/bNPmLzeRZBD7dmpquW/miNBaKW7otM=
X-Google-Smtp-Source: APXvYqzZ4yTzZxukuh4ByGQZgpQG6EO0dCIycVqbuDQkexw5XYN6RtEOuxvysNlyk3gw1XEj2+hMGs7NwNxta8Ox7+Q=
X-Received: by 2002:a05:6830:16:: with SMTP id c22mr12549596otp.116.1560518762637;
 Fri, 14 Jun 2019 06:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190614083959.37944-1-yibin.gong@nxp.com> <CAOMZO5Do+BsZEX43w283yWed8fQVtTC+zAvoktPLTj4c_f798w@mail.gmail.com>
In-Reply-To: <CAOMZO5Do+BsZEX43w283yWed8fQVtTC+zAvoktPLTj4c_f798w@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 14 Jun 2019 09:25:51 -0400
Message-ID: <CAGngYiUWy5FM-zsT55-yY=kahLObZGYw=zU0F9Tzp9T2S3G6LA@mail.gmail.com>
Subject: Re: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vinod <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, dmaengine@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Michael Olbrich <m.olbrich@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 14, 2019 at 6:49 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> According to the original report from Sven the issue started to happen
> on 5.0, so it would be good to add a Fixes tag and Cc stable so that
> this fix could be backported to 5.0/5.1 stable trees.

Good catch !

However, the issue is highly timing-dependent. It will come and go depending
on the kernel version, devicetree and defconfig. If it works for me on
4.19, that
doesn't mean the bug is gone on 4.19.

Looking at the commit history, I think the commit below possibly introduced the
issue. Until this commit, sdma_run_channel() would wait on the interrupt
before proceeding. It has been there since 4.8:

Fixes: 1d069bfa3c78 ("dmaengine: imx-sdma: ack channel 0 IRQ in the
interrupt handler")

But my knowledge of imx-sdma is non-existent, so I invite the more knowledgeable
people in this thread to take a look at this commit.

[Adding Michael Olbrich to the thread]
