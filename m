Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C678BD27
	for <lists+dmaengine@lfdr.de>; Tue, 29 Aug 2023 05:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjH2DLO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Aug 2023 23:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjH2DKn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Aug 2023 23:10:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9F10A;
        Mon, 28 Aug 2023 20:10:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4018af103bcso24052875e9.1;
        Mon, 28 Aug 2023 20:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693278639; x=1693883439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TgphdfUBF3LdAvxv+4KzRsN29QVS1gJqr6ggp2mmHf4=;
        b=Q2/lWx6eq46sY8mfk0fP8NjCxxHd8VJOUP4eYOOgc7qk5+BzI47mQQb0M26TpxvKNF
         9Z6C4aU/UhLof0kRZkNqk7YaNYm54XCClvil18J3KT4r5jUNxiCMOHFEPV7h/6DDAIEy
         l+feihK6BoLURS7zQnbdPmHJtRNg3ROjEOAQIS4qwBUfiZYPrNUpukITayM8ODkXyEhx
         oxFwKVA7hqwCjLW6K17vaubfr9Gw/2yWvAKu5TvdgiNYXnd0pzUKq08iE8l/z129/cna
         GNcVn4A6ks0tcxf2sSndxldVRNR/WMiHDhz2d2Kh7AEG/C3fjw7PbwmG2G4LEosEPjaG
         C1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693278639; x=1693883439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgphdfUBF3LdAvxv+4KzRsN29QVS1gJqr6ggp2mmHf4=;
        b=NKeUjseT8kvTm7FQ+wHRk9rw3QO5FYNHZrEqJ56uBANvFjqa2h67xpiD+fcwbFFyhD
         b5sO1wxGyjZA2h5pj+gV9/ohc3PJU1l6/6TXIR2bXONuPdxrhYAqL8irfhPD3aoQYHWX
         fpfY6GOUkguEovAh+RrPG5ubuSm1iL2CjkDIqqGWR5hF0lwNnFSKdNC+T8sLweBNubXh
         7mjady4FKquV4P7bfjPjWtgnPfV2SYmYV4HMIN3BXozD9WmCRLH57o+Sn1/nErWdue9Y
         Z2temnfc1GcjYSz39WazHLM3GtmCE/EJjnp+Vt635+EnBQa0xLLpGryZEnZUsqeyUkgO
         OkmA==
X-Gm-Message-State: AOJu0YyDlzcfJ/E1AuhM4wpVlD3/D+qxa1hIYPZKfa3Hvz+HyxiK+J9D
        MDeeroeUA8qywLqJ47WJk8S9t3Y+QX0tcjf69FAd27DIXqvQYA==
X-Google-Smtp-Source: AGHT+IETXAyJHdTg3ZySNUHHNNIlX4RgH0L8934TiJruS7KPhhpbJJTkklsUXsuyxps37GNXfo88flNzpQ4Ucv3Ij/8=
X-Received: by 2002:a7b:c448:0:b0:401:b307:7ba8 with SMTP id
 l8-20020a7bc448000000b00401b3077ba8mr817859wmi.13.1693278638495; Mon, 28 Aug
 2023 20:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230729175952.4068-1-dg573847474@gmail.com> <3545b782-756a-3d2a-d192-8b224a783c13@sw-optimization.com>
In-Reply-To: <3545b782-756a-3d2a-d192-8b224a783c13@sw-optimization.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Tue, 29 Aug 2023 11:10:27 +0800
Message-ID: <CAAo+4rWW67VSpdwo_dstqAb-FiKeoK3YmaNgiX7vXBerqEWBkA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: plx_dma: Fix potential deadlock on &plxdev->ring_lock
To:     Eric Schwarz <eas@sw-optimization.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        christophe.jaillet@wanadoo.fr, vkoul@kernel.org,
        logang@deltatee.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Eric,

Thank you for your interest in it.

For a dynamic detection solution, then the answer is yes.
Lockdep, which should be enabled by CONFIG_DEBUG_SPINLOCK,
has the ability to detect such deadlocks. But the problem is that the detection
requires input and exact thread interleaving to trigger the bug, otherwise
the bugs would be buried and cannot be detected.

For static analysis, I think the answer is no. Smatch, like other
static deadlock detection algorithms in CBMC[1] and Infer[2], should be
designed to reason thread interaction but not interrupts, which requires
new algorithms that I am working on.

Besides, may I ask a question that I have sent some patches[3][4] weeks
ago, but have not yet got a reply. Would reviewers check the patches
later or should I ping them again?

[1] http://www.cprover.org/deadlock-detection/
[2] https://github.com/facebook/infer
[3] https://lore.kernel.org/lkml/20230726062313.77121-1-dg573847474@gmail.com/
[4] https://lore.kernel.org/lkml/20230726051727.64088-1-dg573847474@gmail.com/

Thanks,
Chengfeng
