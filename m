Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8FC20F1EB
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 11:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbgF3JsV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731983AbgF3JsU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Jun 2020 05:48:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD035C061755;
        Tue, 30 Jun 2020 02:48:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so19871159ejc.3;
        Tue, 30 Jun 2020 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNC78CqpkvHbTzJl7ozjMpsWiFnQpCxrCq3wYkDslBw=;
        b=uCygjPNjpm8T1BUAh9Qf/bkYop8p2+DVJTrhrpfftvPO7ZTdWDR+VJqmYiXIDcVDPI
         g1F3HRIhjHisjgQ5nNHAyH2FMmdFUeZn+R6JwVLmtyVyDVx0vt3PJ/aseb//pBN7dgaN
         OXQFcHDqPRtUtMcF/bipam8DQ2+oyU00VpYfQ2kRL5d9O1L99nuAio8o3Xcu7qo50EKi
         oLt0QX8BZeRjVJ+BZI26l7PjrVK6t4GapZmKbQ1/Ip4ITaleMJsp8ScQ07t90n3xNs4H
         CurmJSyHPnZ02iarnM4o/PKfLnjOj22xplaf+7Le9g+Dfb4ohhC0zAx2wcQlPdyhc8mf
         pTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNC78CqpkvHbTzJl7ozjMpsWiFnQpCxrCq3wYkDslBw=;
        b=YL1eORTWJnoipIcwJBJMCqqgdvmI97iP2KbF9wBJ8YTPpDPPc53cbGXLKibnFiPvIG
         K/4fxocL010MbsErfnd1G32BeclwOSHC+6snrKQEykXJ1AQcKYk/DtdXyzb89/KNp3TT
         tmb7C8oarTfPZfaWU9wMZR7P8R7c1wGKzWZqyHFGcs5T/OQaLE19d8r/cOFzvSV3aMAg
         Fz1VFTeQEHQ8yzoxafRitod1vjbC3dTdD0feYhW+tf0N5tmD2V1v3UhC/73QQWoT6jKs
         6G2vRUwOIW3yJKY7ZAe4HrIHSVAErgSxaQr0yI1gdQm3YOielqmcDmJJ03Xi1rB5gAxG
         L75A==
X-Gm-Message-State: AOAM533oMilkg33IfzFmg6yLmg9PM7ij2bnKUJinvS39JdPb8HrPRezx
        o77rva5JEQGyWIurPB1mfMREaEitlYCS1fIbrBM=
X-Google-Smtp-Source: ABdhPJzKAZTTMdJAx/ZL9PlEPB5lTOl0gh4Ih+EoF1G9G8H8LsnK94bLhhiAJUYzQrEmDmfkmvTizUEmtvyArg1PjjA=
X-Received: by 2002:a17:906:4145:: with SMTP id l5mr17255133ejk.334.1593510498539;
 Tue, 30 Jun 2020 02:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com> <20200624061529.GF2324254@vkoul-mobl>
 <CABHD4K-Z7_MkG-j1uAt6XGnz4zWzNYeuEgq=BwE=NXPwY6gb6g@mail.gmail.com> <20200629095207.GG2599@vkoul-mobl>
In-Reply-To: <20200629095207.GG2599@vkoul-mobl>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Tue, 30 Jun 2020 15:17:41 +0530
Message-ID: <CABHD4K9VOWpC7=o2VKrqoxEtMQ2gFv_Qs885dBKL1o+B_fe_3g@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA engine
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Mon, Jun 29, 2020 at 3:22 PM Vinod Koul <vkoul@kernel.org> wrote:

> If you use of_device_get_match_data() you will not fall into this :)

But again, of_device_get_match_data() returns void *, and we need
"uintptr_t" in order to type cast it properly (at-least without
warning).

Also, while looking around found the similar warning for other file
where it uses " of_device_get_match_data()"
drivers/pci/controller/pcie-iproc-platform.c:56:15: warning: cast to
smaller integer type 'enum iproc_pcie_type' from 'const void *'
[-Wvoid-pointer-to-enum-cast]
        pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);

Thanks
-Amit
