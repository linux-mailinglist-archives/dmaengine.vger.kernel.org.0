Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94DC77E75C
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 19:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbjHPROB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345167AbjHPRNs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 13:13:48 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F5898;
        Wed, 16 Aug 2023 10:13:47 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-56d0f4180bbso4950746eaf.1;
        Wed, 16 Aug 2023 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692206027; x=1692810827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tVPX9Qa4Xv1MB/edAOyjTE0H1MKHMiTKe7y4N2vO1R4=;
        b=l7BaRVB2Li7p6CutjFiA5K7oKI5cZJeiG9dnXioxpX6ijutkWmyHenD6xii6D/atuB
         xnR4m1gTx3FrTMRk3P+FhqSwKFH9TTE4FZeT1C/sdTb1INiLcGSR+daWQvVCSYI4l1Am
         b2qwe8PogkSXbpDsrEhG6rkWDwxM+O1GS9IsaXvKaMHalOkKQ0I9s1SP5kGwkA6Lmax1
         6oZX3NnAICyltiLoayzKBlH75zziXkLw82cY0ee2Q9DUejOoNPQZpM9AvxglVsdGYof+
         kcHR2v9fvxUniR3YZKpQ8W8S4Mb8sjJfHu/DjbjphfSErgQmFHY4zYptCHaEIqZDI9tS
         bHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692206027; x=1692810827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVPX9Qa4Xv1MB/edAOyjTE0H1MKHMiTKe7y4N2vO1R4=;
        b=WE2lLO2RUprIIpYyXLs/L01zCP4cM4jFAlYpeaCxT46kf/UdVd0rSe4R4GF+O63HMt
         H28VmqlXvEDBZMcSgrYjviJgSgl/7SEGX4gA3MIsnVqVql33cugd4Ns7wZGFKR4Q0WNR
         ozSfAyZYajZ8kJ87sqi3jF8PTmrfrzQWW3TlsMjaSTAWf0rXG2RizJWosnChOmBVDvln
         Tc5Vq7g+aK0D1t3KPVU7DvXnZ9n6Ekr/BkdsOQP6bvPPYJ2sBvFiAfo5CRSvbI7hZA2G
         I1nJarEqvKlzlUXs8u+lU+JR4xZcG7ldSKxG2ojTJm36eS9fnVPHmllyeOTm8hwd7SIN
         hdcg==
X-Gm-Message-State: AOJu0YyllG7oSEeZx0XgYK0tCkyafTza7g8/wc9CrKHWfvlLBMpQpI4q
        lncdV7YD4W62ZbxlGAM6abAfj14BsGlz/Mni+sDrkcEdOTI=
X-Google-Smtp-Source: AGHT+IGXbdnXyVMyt77d6rfz8tCBtsRlaDJFQsG39SIT4aN2489OiJHDAhWJhJ04YU5adP2Won5oD5Venmj/kqq7Yuc=
X-Received: by 2002:a05:6358:70c:b0:139:d5d5:7a8f with SMTP id
 e12-20020a056358070c00b00139d5d57a8fmr3388507rwj.30.1692206026723; Wed, 16
 Aug 2023 10:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230726051727.64088-1-dg573847474@gmail.com>
In-Reply-To: <20230726051727.64088-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 17 Aug 2023 01:13:34 +0800
Message-ID: <CAAo+4rXRdMQgM-ck+jfTdRQOFafbUx0880G6MQayK5EEwXHLbQ@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: sun6i: Fix potential deadlock on &sdev->lock
To:     vkoul@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, p.zabel@pengutronix.de,
        jaswinder.singh@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear maintainers,

May I ask if someone would like to spend some time reviewing the patch?

Thanks,
Chengfeng
