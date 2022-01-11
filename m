Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812DA48AAB7
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jan 2022 10:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiAKJmz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jan 2022 04:42:55 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:45702 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiAKJmz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jan 2022 04:42:55 -0500
Received: by mail-ua1-f43.google.com with SMTP id x33so27224006uad.12;
        Tue, 11 Jan 2022 01:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYoFhZpMdrKIinjBqjY4BJ47Yl1lAi9aD03OcFH30xQ=;
        b=PFIY7PMVO4AJi9SCwbse3I0zalF/3ypRRIC/qfeeNO6jnDAyfwIeEottysxUoRz3QK
         42rG68XKuBBOZIOyr/TV6a1yHE2owomY3Zw1Yvmi2dQc2yPyQNlbRiMTVmfzLPtLtnhW
         IRqi7w5lm2jA9kD/Q4QmTkAa9eNVud1xRrLNU6ScoAqFEc5wd8sn6AG+yLlCOYZSrJD0
         uzbQVmXN9FZMMDLuWOCtYDht7KzzgWOwZzWKcKaPobashFdXNEldrb4DoHn6bqbP53v6
         9zys1piNFqcGL5Y4BCFIxZI5JyKzwaGeh4MAlnqTXW/eBsCFJYvpAcpjANIa62xbdkQk
         /03Q==
X-Gm-Message-State: AOAM532r9dwlYRLZOs8G2U+753KGaDOKaoCVIqvdIIKLA6Oo0pC7XrON
        6VUPWR8oCfWV8UU0zcRgyEP14LPtVpPGcA==
X-Google-Smtp-Source: ABdhPJxaChTMLOcDhW5LSEx1c4Tv6RLv+1yv/J57++sax1YelxnxpTCGA4SQcLpEjm4Ig6E9bgQMgQ==
X-Received: by 2002:a9f:2acc:: with SMTP id d12mr1551139uaj.109.1641894174183;
        Tue, 11 Jan 2022 01:42:54 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id c15sm5218266uaj.13.2022.01.11.01.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 01:42:53 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id p1so28534018uap.9;
        Tue, 11 Jan 2022 01:42:53 -0800 (PST)
X-Received: by 2002:a05:6102:2329:: with SMTP id b9mr1668803vsa.5.1641894173002;
 Tue, 11 Jan 2022 01:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20220111011239.452837-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220111011239.452837-1-jiasheng@iscas.ac.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jan 2022 10:42:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXr4aeTZmjgznunLtZFQusEW7Rw=q3FjTNa1jcgGwkoDQ@mail.gmail.com>
Message-ID: <CAMuHMdXr4aeTZmjgznunLtZFQusEW7Rw=q3FjTNa1jcgGwkoDQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rcar-dmac: Check for error num after dma_set_max_seg_size
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Vinod <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zou Wei <zou_wei@huawei.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 11, 2022 at 2:12 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
> As the possible failure of the dma_set_max_seg_size(), it should be
> better to check the return value of the dma_set_max_seg_size().
>
> Fixes: 97d49c59e219 ("dmaengine: rcar-dmac: set scatter/gather max segment size")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
