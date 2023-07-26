Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA71763468
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 12:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjGZK7K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjGZK7F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 06:59:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45675212D;
        Wed, 26 Jul 2023 03:59:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31768ce2e81so2077080f8f.1;
        Wed, 26 Jul 2023 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690369142; x=1690973942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+nKQ3sirP3HDfMdOhfcrJ3FXH/RL38AgDUVvGDTOt4=;
        b=M7VA46+nGi21oCzVEYji66II0o3eN2zeqAMEdq/AfgudqPphOeAi18h8PoAdofQlRY
         Z2m6jG4PxKMJEEwpB/Ph7yPwFscmkqJcFt5Otm/6VJbjIbjlNGOwYRMoQlufpDLjij2w
         bMiDsbDh68EccUMmaYp6EUGj5l7Y601KKSI0lpwxogu0NGxoKa3ak1o+cv0RLlOcTRWW
         7FXt9ADVN+7OhVsmoRFFbNN1legBOtRaYPQ4baC4WoTJJj9Px2lW26InLosSGmm62F+t
         0mps4n6853tZ54r1mrItLEs4hndELqKCxzUL6WWkwGRmtZkevB+pt/e0DuMSk6FXkY6w
         KXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690369142; x=1690973942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+nKQ3sirP3HDfMdOhfcrJ3FXH/RL38AgDUVvGDTOt4=;
        b=HEHeMiB5TdTEsHKEh8DiiRzDC8bEdNO7Uywv/+trh0Jb/0cr9uVjVSQC+Xkzn+4Eyn
         /fo88Ln36ic4ushJeQKGv/SlR0g1GbYUialeIRqAqXMw6zeaTudpUpPe49lWn1SD1p49
         hYlKilkCmcaVNlO+FQp6ceqEveh+n+AZmilZYRwzC4bvBDSfauMPbXBWg5K8oJGfEPQz
         clHYlTFXTe6Lxxvp9QFxGLZ1Te+IaaO8ca7mtOq5gTZmn6T0SOUQlzXhJgfZMYoG1rZa
         FWKji7mIwPGkDNjw0NHT1qLgGooW/IAOU5LDklQCVof6PFHyGb0a3jvJEAuZZD7BJzCV
         OiTQ==
X-Gm-Message-State: ABy/qLalXTeMB3QmzA0mzBhBdmPmNdNCfZusC0Mg1mCDek0zdpeVY0MP
        2Mi06oyzgMcXiWCbEl6R+rxRgrCxBv5sYEFpzWmGG6wC2gicsQ==
X-Google-Smtp-Source: APBJJlGHt3PHSFAkS/QojrLgrSkfDRMoxrFjYxhdrv3UE2/+E6kZ0JHy69jUBnSMOjrKGDuVznxb2E8Flymgo2Izh1Y=
X-Received: by 2002:adf:dc8c:0:b0:313:ee73:cc9a with SMTP id
 r12-20020adfdc8c000000b00313ee73cc9amr1164733wrj.70.1690369141464; Wed, 26
 Jul 2023 03:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230726104827.60382-1-dg573847474@gmail.com>
In-Reply-To: <20230726104827.60382-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 26 Jul 2023 18:58:50 +0800
Message-ID: <CAAo+4rXG8ZLxD1+g_319XJf0e_p2jZZ1COzUCjo00HLfbv0C8g@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential deadlock on &plxdev->ring_lock
To:     logang@deltatee.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes: 1d05a0bdb420 ("dmaengine: plx_dma: Move spin_lock_bh() to spin_lock() ")
