Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F917215B59
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgGFP71 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 11:59:27 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34019 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgGFP71 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Jul 2020 11:59:27 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MFsd7-1k8CB82qdD-00HRQF for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2020
 17:59:25 +0200
Received: by mail-qt1-f182.google.com with SMTP id u12so29305137qth.12
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2020 08:59:25 -0700 (PDT)
X-Gm-Message-State: AOAM531nRSJAV+hKcFE3VXoXGsGFgm2yHUE7+aUlRY5AUMhWyBrj/Ivv
        YXbVFKr67oe4o3l4FzfrCvbizTbm08LMLFjCMTc=
X-Google-Smtp-Source: ABdhPJy72KKn9lEHo71+M+KcayPfcOlEiOKfWw2IMDVPgYwy8BUhbaHeQ5yZLOYxgenAlVaWQOhWKmuga8Mn4wVmNxQ=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr50313847qtq.304.1594051164619;
 Mon, 06 Jul 2020 08:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <159404871194.45151.3076873396834992441.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <159404871194.45151.3076873396834992441.stgit@djiang5-desk3.ch.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Jul 2020 17:59:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3uYEQRjQHdZy__rJ5MTmD_CA3EUcbV8sQoLE4sMRp9Rg@mail.gmail.com>
Message-ID: <CAK8P3a3uYEQRjQHdZy__rJ5MTmD_CA3EUcbV8sQoLE4sMRp9Rg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: fix incorrect return value for dma_request_chan()
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:B5QndL8FF2LqctMjqZCtBGh5VqVWEKjXN3dtjYqePwzQTIIJp3k
 GUpdhlv5Wp9kVPsQ6UYTcuEjTvZbW7whspTHm5bpjJXLGBqiGDAGnOD1yWcRYmmnjRY/eUc
 FxBwLZie68vOkc4FMZD7/bnCoZIKNULF5EtrlFvQPEMKgRgvT7RM7MGXwwNWc6PrS0k1OWF
 mtUXjyd0q3t5TGp8hrSUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:griokQB9GvE=:WryOUFWOBU9sYagzv7ICWU
 KP2kBfnbIBqOWrqYebdWIJsmn7AwjbZ7WhhTKOr3c7Nc17pOg0CSAtu5fjIbvVlTZHS9VCtFl
 N3lwHMM7Heq8HWX2bNpejAe5vabrzUV1EXYtMZIhJCer/3ulEuFmMQJsir+hjAWhElcg59tHX
 7z0oyHlLsP++zIGPsyo/XpQF0Me9RcdtEDMP0B2uABOoF5qjrr4JgMTYV0cBQQ/BIkK9bSr5D
 rTmJVGWEARdYfknReS7ZrVNWcQ/h31x7weZnKxEi/Pwlyw2bxj50j/rd5UVUfx7gpkKsQwH4b
 ZsdjxfctiWCVjv+mOU/93z41pHOCEUcjs5+mVuzrVI3GYH1JP/6A26/+IClTPSh2lOopS+mHf
 ERQeI7vfKJfjz+AbMiUppFhQLL13GEWHovFKmqOh8Rv7CrXYxEaUgdWQo7Q/AnAFp8igai0pT
 AqZPZ/IxmrffY6Zt8+enI+W0vwvrjN4pkHNjZn9MYJqBOT0FeRfZNXrDgioYVoSsuHRm7HkWO
 wTvcMB957NGHdY6S0GJvp0GSHr7Tq036EiVyHg7h6iheS+TziCO2bRU7L43o5GXfTWmiT+dhK
 eQ1Cy+fqIBmYJ1eRk6lkgHMB7RbG0WA8cc1SZmQjFRUO0Agspag2E81A50lCnaCw7oDB2Sk76
 gzxiyVNLnu5/NHytfq306DtYA1t15aHlPnLHKtckhsM63aVSV+I9HGtibrd/xxxLzPI8EH8gA
 kdA4c60e8myWw+ZpAHTUz9Jh5Jbg4y6K3X51/4M29N51x/QdhLoxlVvvtlnPpN3sQK8pRAsTI
 LonDaGHmunhEiPWIVhl+B1fvBqatTJOZMhSCZY9KtOkSDJG4N8l6T0XenI6v0KUnhDVdEuBWh
 LeaXZDoV7p/kkxmyjRT8V3oSrXWlKwjxmqIDpxaW8xsAsDRqHCKAKR4ayRUmVpy1sYmoco9Wc
 zCeF4mG4DgIdgoxEnj9GnR2cZGBDhhD3tAZt9fqlg43qcF5gRCf5F
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 6, 2020 at 5:18 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> dma_request_chan() is expected to return ERR_PTR rather than NULL. This
> triggered a crash in pl011_dma_probe() when dma_device_list is empty
> and returning NULL. Fix return of NULL ptr to ERR_PTR(-ENODEV).
>
> Fixes: deb9541f5052 ("dmaengine: check device and channel list for empty")
> Reported-by: Arnd Bergmann <arnd@arndb.de>

It was really
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Though I did the analysis and found what caused the problem.

The fix looks good,

Acked-by: Arnd Bergmann <arnd@arndb.de>
