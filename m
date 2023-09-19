Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74E7A6548
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjISNfq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Tue, 19 Sep 2023 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjISNfq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 09:35:46 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF434129
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:35:40 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59e8d963adbso26146277b3.0
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695130539; x=1695735339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FL+6XDk/K3/toybLVPYvfChP74few4x7kDlWn5zuyo=;
        b=AK89qRi52rLAlrPAcywVMbHq1GQl9xxjGojSt3zKVT1NKusUTTXyFRh6PHsI782xdN
         p61WjSlDuBlqED3R1NosDc0GZaum6KcyUF+QD/hZTr6V+JYaL2K8axDT+fJrcLUG8Vzq
         kRmI46n674M7zs4IsoAjr1CdbLPSm0AQo0r0LSzW1i7Sj3In8toPw4WSWVULsj3x8u8e
         uwMI0/fljHFY06isubds5TTeSVKSObx7eXPuCY9Gu3jWngRUclMemw5rtnTF4yDhrsS5
         0s1ccuV51C3O06dRAAiN9JLsYtAPvZPIlMYIy38NUyZB16nGUL4kwt7WJzwighb/ti+G
         2Nhw==
X-Gm-Message-State: AOJu0YwJtnkzPGcxGbqKc7f+rSSIMUY+FU8UucXV/AjJDRmIXWpbYr8t
        ea6lZSrYkqQ5INsc88PzXn+9ISkJB+L2XA==
X-Google-Smtp-Source: AGHT+IHaeDvWcTsCcfjN5aRKqhmlRzwVb7Pw8FSXLbgJllQFYiwK+gG6u8kseaXAmbee0d9Wg+vgQA==
X-Received: by 2002:a0d:e941:0:b0:598:7836:aac1 with SMTP id s62-20020a0de941000000b005987836aac1mr12525833ywe.49.1695130539601;
        Tue, 19 Sep 2023 06:35:39 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id eg5-20020a05690c290500b0059c8387f673sm2221996ywb.51.2023.09.19.06.35.38
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 06:35:39 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d81f079fe73so3381919276.3
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 06:35:38 -0700 (PDT)
X-Received: by 2002:a25:ca14:0:b0:d11:2a52:3f35 with SMTP id
 a20-20020a25ca14000000b00d112a523f35mr11586146ybg.20.1695130538540; Tue, 19
 Sep 2023 06:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de> <20230919133207.1400430-41-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230919133207.1400430-41-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 15:35:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVd3aVd7WQGd62uE28KK5KDBSv4J_QvhT1HdJQvSAK97A@mail.gmail.com>
Message-ID: <CAMuHMdVd3aVd7WQGd62uE28KK5KDBSv4J_QvhT1HdJQvSAK97A@mail.gmail.com>
Subject: Re: [PATCH 40/59] dma: sh: rz-dmac: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 19, 2023 at 3:32 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
