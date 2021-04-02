Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97D73529D6
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 12:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhDBKiG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBKiG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Apr 2021 06:38:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD22C0613E6
        for <dmaengine@vger.kernel.org>; Fri,  2 Apr 2021 03:38:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l4so6853106ejc.10
        for <dmaengine@vger.kernel.org>; Fri, 02 Apr 2021 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=11hNsw7uwcB/8j17vAN4whmiXKI6zAFpb2ipMEO95Q0=;
        b=sFB3goQFKFqbnIH/VXuu7sBK/ZR48MX0y2iujyjZFLn932eYgbUDyxYKiInT/oUAyK
         aO45b5nMPqaGNbehxtPep4Bf+e0S4h5bUwvCdVH7ubgxC6w0m5GhcoL4A4anMoP1htUH
         F+60Ej+qgu/zH1eXdMq1+hEaZ5olBerkfah70yFMmHJCGxEQxQGQ+jgerdQ4g7LCdVj+
         JfCyAi0YT5mY+koilsTnBZaXwkG056hpsdwCGRtti/sOfJuXhs5AG5nr8+4BAxMp/jnw
         UhetMnRnjK4ys08u/qRiuABmqtwliG9qLLaAFHw/vSckgohdodCwM/1NoTPzv5oSu0IM
         PKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=11hNsw7uwcB/8j17vAN4whmiXKI6zAFpb2ipMEO95Q0=;
        b=ZAF6vLP2JmWFoMvGNI//tVtKXdfU2jCKS8YvlYCNYFTYvDD1BuE8RRg7/N7Vu+t5db
         AMA1d5Pm3Jpqd5u5+cKfwhI8vLoOXcCB3Z7xtj8in/BW5zOhvNIlHYV00KhJTxsTtJLj
         fW1SBUKjeNeRx4o+cQdqDgtMWCdlEj1BvYOENWl0R/9AC1skosEw18uH5oTti8XbuLTl
         6gMDjvyCe55qgbEG35AJcpiNsRv/HI4wcK0lNzysILU70sfP034So8l6l6Fua4f3bset
         3IwTpUbdkAnj8upAaMW45aU99ulQpfX2hhrL1YfF3ZvXfRfOTFPOJVSwAiQFCmhRqKaI
         nEHg==
X-Gm-Message-State: AOAM53123PFAJUbPZrl7OOS+32CaXQ/PLb/K01n75rZ4M8XOws1F7kXh
        gJYsNAxgsel1du5s6GsIfxqyrd0+7Ory7Cx4+Cdt8IrxiSe6Wg==
X-Google-Smtp-Source: ABdhPJywMKxWKaE+5IjeCHUuGziiZ7ZBD5ID9QTpKgjUbRs9f9aoDhS5JuG6T15vF7TmPefKJFUty4PSzfisBUMfO0A=
X-Received: by 2002:a17:906:e48:: with SMTP id q8mr13632012eji.84.1617359883204;
 Fri, 02 Apr 2021 03:38:03 -0700 (PDT)
MIME-Version: 1.0
From:   Shivank Garg <shivankgarg98@gmail.com>
Date:   Fri, 2 Apr 2021 16:07:47 +0530
Message-ID: <CAOVCmzERZYznODQnVQaoxV-y5b6byYy9b4araY=kWghyat71dg@mail.gmail.com>
Subject: Doubts regarding DMAEngine
To:     dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Everyone,

I'm a kernel newbie and M.Tech student at IIT Kanpur, India. I'm
researching DMA and DMAEngine for my thesis. I want to thank the
community for the dmatest.c program, It has helped me very much to get
an idea about using DMA api and writing a custom kernel module with
it. I'm stuck with the following doubts:
1. How to find which DMAEngine controller my Linux system is using. I
read about I/OAT by intel and I guess this is the one my system is
using, But I can't get it from my hardware or Linux kernel. I also
want to know about my DMAEngine Controller specifications, like number
of channels, bandwidth, latency etc.
2. Is DMA channel a software abstraction? How is it actually related
to DMA hardware? Are multiple DMA channels multiplexed to some single
entity. Also, if it's software abstraction, why can I only request a
maximum of 16 DMA channels on my machine?
Earlier I thought using multiple DMA channels would be like using a
multi-lane highway which would be very fast, but My experiments on
using multiple DMA channels simultaneously actually worsen the
performance (compared with single DMA channel)
3. I read Efficient Asynchronous Memory Copy Operations on Multi-Core
Systems and I/OAT by K. Vaidyanathan, which helped me a lot. But still
some of my above questions remain uncleared.

Also, a general doubt, to what extent the DMAEngine controller is
utilized? I mean I observed the DMA is used for high-speed network
packet copying in servers, and various applications ( like memory
devices, video devices) propose to use the DMAEngine, Do we have
enough DMA resources to fulfill everyone's needs?

It would be very helpful to me if you can answer some (if not all) questions.

Thank You,
Best Regards,
Shivank Garg
Final year (BT+MT) student,
IIT Kanpur
