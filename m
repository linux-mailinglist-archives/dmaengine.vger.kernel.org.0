Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6DD5EB30A
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 23:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiIZVVg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiIZVVe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 17:21:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885572ECB
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 14:21:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q9so7670676pgq.8
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date;
        bh=BLiXT9e+VR3LiHB90CPkTU3h/SZjwM3pjBzHenM7MCU=;
        b=UfVu2i/J+fNOk8okkcbwTzspMPIt9OuB3YdGtKxrCgEjOAgFJklkXceqPa4xC9/RQG
         gz3bTTay8Hf0HLvZpPg6qY1l2uDeOUPT04+9zUK6R9i7IIXAy/tyZQ485IvF4qtkG+lH
         IczabqsA3YOWLmqrZE/1FrrZODJ+Ov+wS/TDO1sLY9eIYQVSZNJucW9koKSInbKyZFP/
         l5fejRvFpmejKizyCoPgxU9+iKg2gH4ADQ+QjgcEg0zMrKD8RnRioFhqrD7YMj8ZrErB
         /MrCWjOoSck4duu419o3oN+5l9KGEkKB86xA3nTF8fzjy5NGX1nqAzih14MtIb9X0f81
         BrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BLiXT9e+VR3LiHB90CPkTU3h/SZjwM3pjBzHenM7MCU=;
        b=5TTK3t+ExQ6RnFSWPcXuRWUJMn/3Cu0KcxnSicj0xHobUJL3oJu9SRyFI0Ag3k1YWJ
         WdEv7gUgoLRtrqqhxZxS2qgME7AGH/L4bvGYKO1NWRbkFaMsLPpcR1An1H5QklRKVwGH
         2fEzjPgipQxwsT2Mu58XBakKAbvrxHZorcsy3Erx1T4nHhl8jsbtyzbWo+1AxF4QdBlH
         zRudjyxIN6k08wNdirKWHwgX7h5Emr66vlfri9WutZP8MtCNRkk/t6il7p4ppWq7HWi/
         SLb2UlJkUu0WT6MDiPhFkTBIZV0+5nv97gQcFQXfc6uG7zchS/wOUf49IA90UnaBvbNe
         Zi9g==
X-Gm-Message-State: ACrzQf244ePx830+i9hpzqZuYYABqHX3sylRRLRG3qlslp5QamdRPBhP
        TnXRnDfS8rfnRnWmu8F6PmIg3A==
X-Google-Smtp-Source: AMsMyM4EKROnJt2dlHLXeul9Q7tdMVk4pgHf+2koE7cTh85ugWyGNTLQ153bxuxO+UBEJsRoGCbs3w==
X-Received: by 2002:a62:17d1:0:b0:54d:87d5:249e with SMTP id 200-20020a6217d1000000b0054d87d5249emr25769255pfx.14.1664227293302;
        Mon, 26 Sep 2022 14:21:33 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027e4900b00177e263303dsm11727371pln.183.2022.09.26.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:21:32 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     =?utf-8?Q?P=C3=A9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH 0/3] dma/ti: enable udma and psil to be built as modules
In-Reply-To: <cf3194ec-0952-fa7a-cc05-6a60e7e66cf0@gmail.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <cf3194ec-0952-fa7a-cc05-6a60e7e66cf0@gmail.com>
Date:   Mon, 26 Sep 2022 14:21:31 -0700
Message-ID: <7h7d1pg7c4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi P=C3=A9ter,

P=C3=A9ter Ujfalusi <peter.ujfalusi@gmail.com> writes:

> On 9/26/22 21:18, Kevin Hilman wrote:
>> Enable the UDMA driver & glue and PSIL maps to be built & loaded as modu=
les.
>>=20
>> The defauilt Kconfig settings are not changed, so default upstream is
>> still to be built in.  This series just enables the option to build as
>> modules.
>
> I can finally drop the half backed stuff I roll on top of -next ;)
>
> Do you plan to convert the ringacc also? It is straight forward, like:
> https://github.com/omap-audio/linux-audio/commit/01f9290c1c61e8bbc0fbdd87=
7382672883ba7e73

Yes, my colleague Nicolas (cc'd) was planning ringacc shortly, but we
didn't realize you had already don it.  Your version looks fine to me.
Any reason not to submit yours?

Kevin
