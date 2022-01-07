Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747D9486F33
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jan 2022 01:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiAGA4W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jan 2022 19:56:22 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:48417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiAGA4W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jan 2022 19:56:22 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1q8m-1n7pPg1q5A-002ChG; Fri, 07 Jan 2022 01:56:20 +0100
Received: by mail-wm1-f48.google.com with SMTP id v123so2947397wme.2;
        Thu, 06 Jan 2022 16:56:20 -0800 (PST)
X-Gm-Message-State: AOAM530jfekjigejhTLDOXluhtt0COCPQYc0Mu5p4f5MX/mAAMyVJw4G
        EbAl9VUt9lPA/smHFJbbdnC06udKN5Egu2jactE=
X-Google-Smtp-Source: ABdhPJxjN0PpAY15g3YezZc1097ikKMl8cojBSZBTSHIZod49CbqSEfCpIHQ97t2EibZ/TdiK8l3W1GIDlIfyiK2eos=
X-Received: by 2002:a7b:c448:: with SMTP id l8mr8889792wmi.173.1641516980036;
 Thu, 06 Jan 2022 16:56:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr> <b88f25f3d07be92dd75494dc129a85619afb1366.1641500561.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b88f25f3d07be92dd75494dc129a85619afb1366.1641500561.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Jan 2022 19:56:17 -0500
X-Gmail-Original-Message-ID: <CAK8P3a2J_QZtqq8_y8hwSo4T_Dh_4f_WXy9osomHeBND3-abgA@mail.gmail.com>
Message-ID: <CAK8P3a2J_QZtqq8_y8hwSo4T_Dh_4f_WXy9osomHeBND3-abgA@mail.gmail.com>
Subject: Re: [PATCH 07/16] dmaengine: pch_dma: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NPDhkDyPz7/evS+qLJycWeh+LpmULWxQY7o4Jp3SxxD1PjmJZLY
 6S4QR+5s7Dtm9IZnM0Zd2i5LM17wL0S4VgSYfbW67Bt9JvZjq71G/Cv6W/mHusq6HakCcxj
 8O7QmB6hA5R3qXuO4CzhdbNuQ9u7xqBj1aTgjxzj1bVn9c/oSHiiqXOU/ldhXY1pt5CP1NL
 6moalj1gusVCwxdjgiSjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fiSYhjP+vKg=:xbR1Oo53gAwr8ZBYJ4wl+c
 NmOcrgTn3ywwvGp1R0fuhWyCFlpAgOOnTZ+GUHYtowcsqGBhKa5sMKFH1twNv+ewrQ5+X0CFb
 WBUzqk3gbamXwDkGlrvGfPsaptHIOlMEIwEEYfVnAlENamqBK7AE5Zm/AZhyOTd8y4x2BQSxa
 ZZt3wuCYJb3RAO7piNswIiFnZCMYSm6ry1WwjAUrObLQq/f8KyJncsyS3axB6YgHgQUL+B0cS
 pYSbYBsjbnVv/MoBayanll5urDHKgxbrRSz9acTTZ6SZ0uGEcJhddlYhpFPMatZEdruxCZNUv
 UpdSkn7u7uVuMsFzsi1uXG+qRdzKoxODK2yZLFUJ60cgIuPP3j2CKMitaxR76PlcGFetM31QB
 JmycpSDSoKLPmT0YKW6UbwVl6cOblCdn7X21C3WNaLcHwGqw4bhXbDeCmUj9RhzALTmYb/ayJ
 DBxOA396fK4h2YycYT+bf1orPCyX0GEsTIH2w/6/4sWW7aCdBUsSc8d5O2B0wlxoTA62N2V86
 KzShcmHbB05F6gFxf9xpOgZi6XibdAoqNBXLez3alqfydAeBoKYhSouAAW6HNKTwEHUsmmNdD
 3Wy8PO4E4zt4xGzLeAI4Wcihj+rlOjS2N/2UI2VmJgzxFT90TpyGKg6EAXR0Q3bErFAlQC+2s
 bqwhwMt5QHY5KcIC36kZhIR/M0Y/26YsxgigiRoDK6CP+bTxcQoAUGgxfGXzuXH6NwIhLozzz
 LLm027DEDZjWZpuB17g02D+cA/1y+3uuWuJ85Pz2SAJR7wnHwJAX7fF+4jN83P1IANfEsWpNi
 vSh24IcZvJAl1uxZaFlwxI7WCOp8WsNY/fBtqa3HLtNhi//pbI=
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 6, 2022 at 4:52 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
>
> Some reasons why this API should be removed have been given by Julia
> Lawall in [2].
>
> A coccinelle script has been used to perform the needed transformation.
> It can be found in [3].
>
> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
> [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Vinod, can you apply this one to the dmaengine tree? It has no other
dependencies.
