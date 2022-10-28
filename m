Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36513611120
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJ1MVd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiJ1MVW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 08:21:22 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D17B287;
        Fri, 28 Oct 2022 05:21:21 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id x15so3934407qvp.1;
        Fri, 28 Oct 2022 05:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNWNDj2XHz/Hz59MrchMAuMDI5o9KuQ1jezmkkViv5E=;
        b=DtRR1ITK+YfqY/64F5TIgDq1Y9iidQDMrzpnmojoWe38ACBeCI1BpjwljiOLX0ctdx
         MdyXQURs+rHR6wZ0YW7VHFGhsFIwnvQ6uo6UIPkOmcoixTib1CQY0t6lSpa0IjcJkJ4R
         vwcvWNjrEC+2wyluVFEBH8ca/oqzmz8nuSWzjOk2gIBZBJHqBh+Lt2TRX9CZ7v+Ln7xT
         grWAn8jljZEoiu0MVsyKeL2mz2ed3HZGSrc6bXsk7J1kQXfghWwFeT822SegDmclG6gz
         hnB88+kFpMqOhAGFM5kfTEuwfnvAnxHLujbegokeaauV0lHeuGB21sK0efRanRBv6JYe
         m7BQ==
X-Gm-Message-State: ACrzQf0oI1tF3rXqx2OWSJXhKOQWDVI3J0/B9TphkSvbX6FqQUUI8mkZ
        vyEQXR2XCWMCXASIDswVJ0wlNJysvIJUsA==
X-Google-Smtp-Source: AMsMyM6sEvtYx6kMVsprKkWz+xBUqUMqm9i/43kvKYPUu+pH/13m82jBOonRtAx1AxLECL2Ni/EKgQ==
X-Received: by 2002:ad4:5be6:0:b0:4b3:ff39:7ad4 with SMTP id k6-20020ad45be6000000b004b3ff397ad4mr45325558qvc.126.1666959680451;
        Fri, 28 Oct 2022 05:21:20 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id h17-20020a05620a245100b006ecdfcf9d81sm2848791qkn.84.2022.10.28.05.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 05:21:20 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id f205so5947966yba.2;
        Fri, 28 Oct 2022 05:21:19 -0700 (PDT)
X-Received: by 2002:a25:d24a:0:b0:6ca:4a7a:75cd with SMTP id
 j71-20020a25d24a000000b006ca4a7a75cdmr39355446ybg.89.1666959679596; Fri, 28
 Oct 2022 05:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221028115336.1052782-1-steve@sk2.org>
In-Reply-To: <20221028115336.1052782-1-steve@sk2.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Oct 2022 14:21:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXw0fG+gb0b8T6EvWcJRouTsO-LedpJcV+4-h7DTRqsTA@mail.gmail.com>
Message-ID: <CAMuHMdXw0fG+gb0b8T6EvWcJRouTsO-LedpJcV+4-h7DTRqsTA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: Remove unused shdma-arm.h
To:     steve@sk2.org
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Oct 28, 2022 at 1:54 PM Stephen Kitt <steve@sk2.org> wrote:
> shdma-arm.h was introduced with commit 1e69653d40f1 ("DMA: shdma: add
> r8a73a4 DMAC data to the device ID table"), and its sole user was
> removed with commit a19788612f51 ("dmaengine: sh: Remove R-Mobile APE6
> support"). The latter mentions r8a73a4.dtsi but shdma support was
> removed from that with commit cfda82037780 ("ARM: dts: r8a73a4: Remove
> non-functional DMA support"), so it seems this is safe to remove.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
