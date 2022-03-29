Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2C4EA4A7
	for <lists+dmaengine@lfdr.de>; Tue, 29 Mar 2022 03:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiC2Bh7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 21:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiC2Bhq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 21:37:46 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1751B1AD1EE;
        Mon, 28 Mar 2022 18:36:02 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2e612af95e3so168108347b3.9;
        Mon, 28 Mar 2022 18:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j37M+3SnCtzKCPAGBbMVoXAMH6upORtmVyfM4Y9Ajqw=;
        b=LdpfSVSStPvoqgkN42VPQ/Prmd3SQcVf09RDFyX0Ofr7N6uTn4TAvi/GglNoh55J4c
         kizpyEYOB+BT1g+Cj54nrVBnfPxJ8c00/I+qrQxIVQAEONk+AanrINYwU8RaMOzsudvd
         ZK5lIO7YEtDC2B9mNvHFTcNgWOaDEyy/mOdYSKuE07fibuIctiCdaxfMbsouquyokygb
         b+7N6UhZg5/4uKL64LRGAeXxvdeGFMlx795vocVKVpxB0MdWowEs9HsE8jk4u37RvtPx
         QM2yAPFuF0XNV9CIJ7LGsbHe3elDRFbDEgsarsjNZDq7xBFadgNGi164PDtXBcLK5XEz
         5Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j37M+3SnCtzKCPAGBbMVoXAMH6upORtmVyfM4Y9Ajqw=;
        b=Cwcknbu6IwQ+LUVaZFvnpsXLWlxg4MCiUNHcYyaWcbG1Y2C99ze5G43R96YG5IEwZx
         lUlaOUMX3PLBjEaL4XbOdQR1GznESpuvEXrUREkYeAE4YJ5XsQRNNcqiuU6tMOex7Azo
         CVautfNxioaigoNTto7R8vGqKgb3P4ZhROzyhVKGSw4SjQL5z1SIZYuDVwcFp+2kOn29
         l2yWbJ2oUuFmkqkUtCQ7qvPXRLgGUIJVDVqugWwOCo7+JFz7q2i1HqULb3aVT3BF54ww
         rSJEaY2/69ks3+EVn7vb5IN1IK5rNhviwg+qfSDbdQIH+ByTU0p6xn4GtnohJJbbl7uN
         xuAg==
X-Gm-Message-State: AOAM533iWktyFBHUE6eVTlkO5H7/1F4KN73MuIweA9fMHEi7cUvSoB2G
        7YQcGe8kf0OaVyAbYn8F4shCgW17OgD6Rc3rcfs=
X-Google-Smtp-Source: ABdhPJzyJyT8X5V51e1K7fepR+2L9t0VvsuCkYfjExKl36NXoz3ygCpGWYsGmK5WiEfbRk5sPEfWgqLr3sSg5hGWAP0=
X-Received: by 2002:a81:8343:0:b0:2e5:b43c:86eb with SMTP id
 t64-20020a818343000000b002e5b43c86ebmr28290460ywf.153.1648517761368; Mon, 28
 Mar 2022 18:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648461096.git.zong.li@sifive.com> <f08a95b6582a51712c5b2c3cb859136d07bfa8b9.1648461096.git.zong.li@sifive.com>
In-Reply-To: <f08a95b6582a51712c5b2c3cb859136d07bfa8b9.1648461096.git.zong.li@sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 29 Mar 2022 09:35:49 +0800
Message-ID: <CAEUhbmU9ZYniNNv-WYmeTfxh5MXN1NB_fL32FiOxPpx3d2e1_A@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] dmaengine: sf-pdma: Get number of channel by
 device tree
To:     Zong Li <zong.li@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        krzysztof.kozlowski@canonical.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 28, 2022 at 7:38 PM Zong Li <zong.li@sifive.com> wrote:
>
> It currently assumes that there are always four channels, it would
> cause the error if there is actually less than four channels. Change
> that by getting number of channel from device tree.
>
> For backwards-compatibility, it uses the default value (i.e. 4) when
> there is no 'dma-channels' information in dts.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 24 ++++++++++++++++--------
>  drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
>  2 files changed, 18 insertions(+), 14 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
