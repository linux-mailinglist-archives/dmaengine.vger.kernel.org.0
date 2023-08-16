Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4277E539
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbjHPPei (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344195AbjHPPeK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 11:34:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEF22684;
        Wed, 16 Aug 2023 08:34:09 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a78604f47fso6014888b6e.1;
        Wed, 16 Aug 2023 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692200048; x=1692804848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4TkNANhtHbtqYGfBmLZRBPK0Abo3GHVgirRIa+czo1k=;
        b=e4rVRp8xgJnyhnds7vKKjUOIGOSKVVGagDHgDR1062mWo3f21GCy0iozZ++Pe+fp4B
         6W0+emTInHrvqIyt3mU4n/I0z2CbTclF2Jff+8N/DbcOAYzSOnsv3lnSI4J6thXcqv9N
         eTvzeH9a9daC1TFcl9po0gwZxyAs730vtOL/0PwzkLDdrA2rlICYmn/LBFW8B2OjxS+O
         ptFoG9jph5zJD9aZgPYjn5cpyb8BnIFS5/tuAxIzLe+4RUTQvDjO6HWLQgj+4BT/rQxa
         MyKBEV9+3ovLxU//ZqiKi+DKZMyag6EpVwvjOVEWXO3qvkw0Nd4RK3WerPlMF+ZJxpX1
         I6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200048; x=1692804848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TkNANhtHbtqYGfBmLZRBPK0Abo3GHVgirRIa+czo1k=;
        b=YYSdf17lmMOIDwDcGG1GJsf/5HoND6E5gwdbcVxumlJB8ib4KAhouwQBHOAGN9AlgO
         1tF0S8N39648IxePGy2OtV1XhjeXYwCpVZsXslf3sv63RutJwn4zUTtC/E77Ca1D8cA5
         kF+8fl4427CieFCj9m+cTmH2vC8Wp1KtRXFiKhvS1fxK4RD9tgQldp5A7RARo5i3WL1X
         YQNfKV9QSWnOMr3m7+dC2kR5RnuPRcGnzO6s8rlV5isXaHkWfcZwhH5PR5gFoZJ51koy
         Y6fJM/eZOwD6YnuXJMVdvS67kUKA21RiyzLTF1tNPViYYbbBYBcX11/Fb8disCTUm5Aj
         ABrQ==
X-Gm-Message-State: AOJu0YwMCy4VOWfEq+u8/vn86cUUS8fLUtnrOnOMsgCDWDuA8sJIYOun
        4MfehZma4zbFvrtRxmg6BGv2r0h9GUKzgZ4uM7s=
X-Google-Smtp-Source: AGHT+IGGHXjBNOJZjKnW619OI9LDGrzkyKqDZosfIWjCj0+HvEAxbfwlb6KrkvOK8+wZ2XAoLSKVzTBXASETjQbT4gg=
X-Received: by 2002:a05:6358:4411:b0:13a:4120:ce2e with SMTP id
 z17-20020a056358441100b0013a4120ce2emr2774580rwc.20.1692200048264; Wed, 16
 Aug 2023 08:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230726090628.1784-1-dg573847474@gmail.com>
In-Reply-To: <20230726090628.1784-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 16 Aug 2023 23:33:56 +0800
Message-ID: <CAAo+4rX7n7bLC6Omsg6Yeo9EfeVibwbDKyc7B30h10PdoyR1dA@mail.gmail.com>
Subject: Re: [PATCH RESEND] dmaengine: milbeaut-hdmac: Fix potential deadlock
 on &mc->vc.lock
To:     vkoul@kernel.org, sugaya.taichi@socionext.com,
        orito.takao@socionext.com, len.baker@gmx.com,
        jaswinder.singh@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Hi maintainers,

May I ask if anyone would like to review the patch?

Thanks,
Chengfeng
