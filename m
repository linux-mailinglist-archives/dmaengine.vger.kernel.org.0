Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E17E77E738
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345059AbjHPREU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 13:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345086AbjHPRD6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 13:03:58 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA8B2D4C;
        Wed, 16 Aug 2023 10:03:53 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40ddc558306so43491821cf.2;
        Wed, 16 Aug 2023 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692205433; x=1692810233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4TkNANhtHbtqYGfBmLZRBPK0Abo3GHVgirRIa+czo1k=;
        b=rRV/T+dMtQQHYK7+4dMvdIyGM5JmqiOGIOv0+enzJVKawflRyzonH0mmiIXWa5iZR8
         M2QGFZZkBQlxOs9EJgSoXjlH6A5riJMgLeq/B+LZDHqBIjJAjDuXUyb1O7mXnZ9LtgXS
         3kGacy+O1E0j6Xy3T5TDGYr9fNUcygINELD8aQ6oTKOUni5ko7nHYBEan54wvvww55vb
         jyIJOVTD99RcUIabTfItZfRL9MJTp26Cdg3Z+sYvaYrt68KEI5o9H/e5bnnoacxuZdpK
         BG8xm7n6VAjfueLjwH7Lafb48nds+LiTCq2kGSsjdZDQbpBO584XoM9mAPTVe5+Iksio
         RQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205433; x=1692810233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TkNANhtHbtqYGfBmLZRBPK0Abo3GHVgirRIa+czo1k=;
        b=GZ5kQHhwT3Sef+iwKf6PZzBoO4/cwXrHAp7mKcCXeAe0aNXeXArHjbDsNZMavItDkv
         trA1gryj2M1U8wtJVsvchsxv8ZjBLoVOnEFJfHy86LNzj/zgPyroIB2oWgkG8zFrxbsQ
         gQ9DGS5T2GGp9NUOZeR9215uqMTlR4avM6ZbeLm8r0mFa01PGIfMEg3VpKezag9G0EdB
         IkUv3AfHNHIrJtn44G1qU+gdmEGA7ZgorralB0FU7H+z73aSQqUTkAgjAZGaz73DK2BM
         JgLhCoGHn5xHabNHIpBRINlsAGGL3Z9B+7XItsB0BSkcrA7ToM4RMxhLct1nqMoNxTeg
         ogSA==
X-Gm-Message-State: AOJu0Yz4MFythMuZYuoklOIq5hAP8pxHcs+ypmSNoWRaIfJWoh5XJ0De
        t/eSlY2f4CMZBmdbZ0W0yWMVoe1+iIbFOw9TTwJvYxc8/ik=
X-Google-Smtp-Source: AGHT+IEvw1PHGycL/IdaDII+e7bL05PpsHVa3m0MxMUQDow68Fl6GGAwLNX4WwtmMTFtbv6tP72cgzVxBbr4ZAn4lks=
X-Received: by 2002:a05:622a:1807:b0:40f:f82a:f65 with SMTP id
 t7-20020a05622a180700b0040ff82a0f65mr2812306qtc.53.1692205432912; Wed, 16 Aug
 2023 10:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230726062313.77121-1-dg573847474@gmail.com>
In-Reply-To: <20230726062313.77121-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 17 Aug 2023 01:03:40 +0800
Message-ID: <CAAo+4rXBQ=ATGgvafDg3BOpwe1WxXWGs=v2C9ogUSs==cs4D5w@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: pch_dma: Fix potential deadlock on &pd_chan->lock
To:     vkoul@kernel.org, allen.lkml@gmail.com, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi maintainers,

May I ask if anyone would like to review the patch?

Thanks,
Chengfeng
