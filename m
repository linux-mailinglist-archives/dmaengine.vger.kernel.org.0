Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5574F5AE
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGKQjS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGKQjR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:39:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316BDCA
        for <dmaengine@vger.kernel.org>; Tue, 11 Jul 2023 09:39:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so97730131fa.1
        for <dmaengine@vger.kernel.org>; Tue, 11 Jul 2023 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689093554; x=1691685554;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VWtpptzPuOCoLkyZBw7yYHV5FeI36rJVjotbONsdA94=;
        b=Milc2sLIU3Gwl9sjZQmIMUcBzAd67LNFyavyBwPt/u8IewwbPBYEiKyZMyilqwG9Ht
         fepKOR/k7oC5/iWB8e4+u3kzjFAHQjauoC4P0kJU7pXFEZ8WAukNr/OF2PsX/23DVcjZ
         V6sRTZAEqHvJG8r7FBJH3FoIVceu1+EFcNt3rl5RpUQluIefLqobaT3t14uB81F99sXn
         yk0F+zlDCq20aNR62/o2b8rquLVWYB5E0PGtXY0nrB0/z8ApM3GXZE9tEZhs/Lb0LgnV
         bITJqZVyJHugGScWZJJhuFv/WFbfhk95G9/0romR1DkgoFUuPjJNeR/++LtrFt83/z2d
         O3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689093554; x=1691685554;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWtpptzPuOCoLkyZBw7yYHV5FeI36rJVjotbONsdA94=;
        b=IkJtSuglqryh+EK+WVBPQG/YYGCBtntHiZXtp8RoZkIRWlqvmksojvKacFtm6Zob7Y
         p0qaCGl2iE2RfhMEYtUUGg3dFS6QyBO9f7RlYHkmfcjTvrTIGbuWwNmzPqXQG0UmYcDe
         ldO987bThRLMku8pC+xPoP7dS1l1QN218CVEOvJiH4Rkucm+OOIT0luzKd4RLHRt35iL
         3cAeIB/2hiWPk+pB7sjKKAYAqwzxVSIHHa87G5W19Q0TRPmYVM1A5g2loHVTHU79xQAq
         slXhxqv5Xx8cSUg9DaumGHz0jE2wxG06v7F0jhFwHQxFFkR+8BYA5HNzTi4TyPEsXyrM
         Rdaw==
X-Gm-Message-State: ABy/qLZCzJbH+TQNCkchB2pKqchXPW90Udh9jKOYcOdEa1qkvvUuTL9G
        Vgig/CbFsSWmAyX8RZIlnOFYWiVkgtUyU526Oa4=
X-Google-Smtp-Source: APBJJlHuofD1gzmYppSjytYRNsnLXIY0cQLNvkvaxjCmyy0YtyeQQ+JtMFcRkwa80QF5abDtyl2fm0FWTutARjVPht4=
X-Received: by 2002:a2e:894d:0:b0:2b6:9ebc:daed with SMTP id
 b13-20020a2e894d000000b002b69ebcdaedmr14924690ljk.35.1689093554213; Tue, 11
 Jul 2023 09:39:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:1c16:b0:986:7a95:9cc0 with HTTP; Tue, 11 Jul 2023
 09:39:13 -0700 (PDT)
Reply-To: mrsvl06@gmail.com
From:   Veronica Lee <nd4846496@gmail.com>
Date:   Tue, 11 Jul 2023 18:39:13 +0200
Message-ID: <CAPadVRzPVKx4=gCO6FKXzLv-GDmHggpJfzssLGj5fBmvt7mFFg@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

16nXnNeV150g15nXp9eZ16jXqteZINep157Xl9eUINec15TXkteZ16Ig15DXnNeZ15og16nXldeR
INeZ16kg15zXmSDXnteZ15nXnCDXkdei15HXqCDXnNec15Ag16rXkteV15HXlCDXkNeg15kg157X
lteb15nXqA0K15zXkteR15kg15fXldeW15Qg16nXkNeg15kg16jXldem15Qg15zXqdeq16Mg15DX
ldeq15og15fXlteV16gg15DXnNeZ15kg15zXpNeo15jXmdedINeg15XXodek15nXnSDXkNeg15kg
157Xl9eb15QNCteQ16DXkA0K
