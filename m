Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E8706071
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 08:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjEQGvO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 02:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEQGvN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 02:51:13 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995CD10B
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 23:51:12 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba829e17aacso465726276.0
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684306272; x=1686898272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAcAE0foF+OlxcAvzMr6vtrwUDSx4zpEuTV1wg6EE1E=;
        b=RKh1IZvfBosHjntOoqFwkcSauPnvkET/N3LsQ6D0TngGHnvV9VrdL27Ve28ozuJFe9
         4i69VHCnYQLcPdkWiZ/77RWtYWVPtCwxOrw1jNznAaHJFRQYMSnzv9jcgDTztJYP4J6a
         lqH+M6y4IIofMpWvMt8Ps2RylYanOLhii6GZbzW/VzEtLWxgG5MB+VxGYtZrzfzQREV5
         eitUCvsBClkIXaWkNdhNPRuPEYB3x1WsLDlNodWY+DjXbTFl1npYsbGmQPKKSOtbrvnV
         7p8NWtd0a88sMcddYt97ns0ucYDalMlmS/HKRRquYNtbKF4zXIrXH+mhjooFYxUD83DA
         poVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684306272; x=1686898272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAcAE0foF+OlxcAvzMr6vtrwUDSx4zpEuTV1wg6EE1E=;
        b=Xp9W87xvfRvGMAg5rnLn0XpK691jAAGqbHREaboLDipejLiGXdofqAHFUttbEmFBe1
         daVdRDIRXcBYsObQqUT7wLw0rnR0shmTLq9eHe+vs9Nx+htQpMvRwNQA0oah6lSzQtJH
         Cub8iHsz2XQDzrU7sOB9DbHV0ebxuFCne17TStLRRBW8nvSeTTwyomgLNu0R/ZnWBLOc
         jtnvZyI6O0zwdd3EU3LFlwButNU8nMDHd2ExAmpKN3DVj9Q2D7uHVvmGbTqbthBgBHaB
         TpbNuOjSzbldVpyMxYUny9C/UIN86Fao7mZ6ZsDMMOq9/4YczK2BevAVYSLjgYkIYTZd
         hSzg==
X-Gm-Message-State: AC+VfDz8azW/Z01yqBBZlCRHRWU3zcP3CPxrESWSKI6im7p6OkPknAxL
        5LVC+uKJQ/cCSACJns65eUVZ5yQztf2/NotfKbHIQKx45Hpp8k8h4mE=
X-Google-Smtp-Source: ACHHUZ4W81jbgczZwoYxk58sB5ULi4TKwGwqrc83NndTIoLqMZXyLQrJM26cwM9hQzaabqEVkuaFgcOZs4s8mNpb424=
X-Received: by 2002:a25:3781:0:b0:ba8:206c:6702 with SMTP id
 e123-20020a253781000000b00ba8206c6702mr3365349yba.47.1684306271844; Tue, 16
 May 2023 23:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230517064434.141091-1-vkoul@kernel.org> <20230517064434.141091-2-vkoul@kernel.org>
In-Reply-To: <20230517064434.141091-2-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 May 2023 08:51:00 +0200
Message-ID: <CACRpkdY3P_JAF9=gKfLSFAbC9nSyYquF2GHa2C8tJnK--GwV3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: ste_dma40: fix typo in enum documentation
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 17, 2023 at 8:44=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote=
:

> s/40_command/d40_command to fix the below warning reported:
>
> drivers/dma/ste_dma40.c:151: warning: expecting prototype for enum 40_com=
mand.
> Prototype was for enum d40_command instead
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
