Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB73A4345
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFKNui (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFKNuh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 09:50:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA37C061574
        for <dmaengine@vger.kernel.org>; Fri, 11 Jun 2021 06:48:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c11so9755505ljd.6
        for <dmaengine@vger.kernel.org>; Fri, 11 Jun 2021 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWUkVqR3X2YbIzpyhEF0D3maD/VHmsZt5MO9V3blF/o=;
        b=GIiYeuMzUdVhyDzEL+vSTC/6HrTDyU9Q/QF2tZaAAaQ99Wru/o/f/YQWdy0ovcD9pc
         b5nEQqw7CHiMoh/pqnltGMhnERGJtqabE3AvAeXZVLLLjnG2Pdmwdr5tnZSiqt/KkXRY
         /xo7YMsZuZ+Mi6FHgva89IWt5ORcUuQOSo6jzKH+O+6SfMj9PMieNusLUIsV/zyYAS+2
         z1bMfy4aHZpI8AEBinnNV0D9lCu5gZ2vlLoIXtFlBz8lMdhq0WAjpj1YPSn79K2D8KMq
         sP7BEoqgQ1h4FhpbtCn+/ns3nU8SrTz0nKGN1shWIu3539IxEY/oBwWxfYTI2gHLuC7X
         6IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWUkVqR3X2YbIzpyhEF0D3maD/VHmsZt5MO9V3blF/o=;
        b=nwjN6qyRWK9HulrdnBF1MYPLeZuheUwQV+5OAdZfIiIUYzd+oM5T4Ot4zu8HqW93e0
         KoOqBIKLHR6sQyGTV8Thr8Rz1O+jY5koKSr1AKGqBTbNzhV3N+/RyW3OS3VNZUrbYFqD
         KU1aQwvN3OWdDhd6bTWJ4pqsibS515YkNK4VPNgfrIcOHSgMvAQSs0iYIkpt3U0EBay/
         z+kiEDCjlF7I+1sm6CFsZ1mb7UIgBv/s4aScU183PaJ2xlubL1hKud81Bqc+Ppm4Ie2S
         pubYDhyFQ3F48NWSQIaN5L80wbUfM5+D9J6r6wWjunhRM6REhQwK6W/kBb8BrPCRAyx0
         ov0g==
X-Gm-Message-State: AOAM5330MZZXKCV3GVzY11fPkc8ueMP5kwsAYeMLgjnFTLyyh/aK9u/c
        3/kLtGzIehk1sFOw43zLcgnSBMSmIwJN8HqYNE4=
X-Google-Smtp-Source: ABdhPJwG064sfvY/PAsFRg/qxBMFA4j6+e6WeJ0MffVCdmGBXeHjKcgBQVu5DEfKK1KLrDbpqGga3VHjyd0hh8e846U=
X-Received: by 2002:a05:651c:1193:: with SMTP id w19mr3100740ljo.264.1623419301211;
 Fri, 11 Jun 2021 06:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5ATKJAY-35DfxxN2aN+obqj_6iTt10umMO1R6y0=uQD0g@mail.gmail.com>
In-Reply-To: <CAOMZO5ATKJAY-35DfxxN2aN+obqj_6iTt10umMO1R6y0=uQD0g@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 11 Jun 2021 10:48:10 -0300
Message-ID: <CAOMZO5DWG-TOx=zeK5nF9pf+uCc4ffZAjVKqmysk_9ci+4KXYw@mail.gmail.com>
Subject: Re: i.MX8MM SPI DMA not working
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

On Fri, Jun 11, 2021 at 9:44 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Robin,
>
> I am seeing SPI DMA failure on i.MX8MM running kernel 5.13.0-rc5:
>
> [   41.315984] spi_master spi1: I/O Error in DMA RX

I found your latest series at:
https://patches.linaro.org/cover/417924/

I applied it and no longer see the DMA RX error.

Thanks!
