Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7838767C1D
	for <lists+dmaengine@lfdr.de>; Sat, 29 Jul 2023 06:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjG2Ebh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Jul 2023 00:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2Ebg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 29 Jul 2023 00:31:36 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E3113
        for <dmaengine@vger.kernel.org>; Fri, 28 Jul 2023 21:31:36 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d1fd07fc1c1so449125276.1
        for <dmaengine@vger.kernel.org>; Fri, 28 Jul 2023 21:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690605095; x=1691209895;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE5l1VpxCufAhFhvUtJmOdSBkyXi7tvoVHorDEIVEKk=;
        b=ZjG+H5UbP/M8idlRWkp+3znbeWpN7dlMbvIBILIANHyzTjmyUIztITX+cPIWLA+YTj
         DBvkskgVrl2SSvouHsX+i11DJe0lJ8+jubqKfscFlnjmN+i5/3GruKIWRF30IFSB3qyp
         uJklJ6aosoMeBl5NUonhF4Lcrv56pqM2rCMcwNqqSyu4Pi0CCyUfBtnM8sdnWtf3bJEg
         KrSjvvAHrlGPJIIw/WjmNVJS5N7mqzLUZIKWL6ZB3YPBdKtywUJaMtLEwqFCEsyteMCQ
         BIWngJ23WCqqhr7/qE6sCZe/MAuX4UbQL1Y5VmY+7DjHL+eMut/qsVJdOBOnuV//Rnsi
         R9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690605095; x=1691209895;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RE5l1VpxCufAhFhvUtJmOdSBkyXi7tvoVHorDEIVEKk=;
        b=jOUVcHNmrg9bu32lrv0Xw7/oKBtVPUxELestbd2n9pArZDdC0fKfhQABvOgFJT5ycw
         uuOHixqF0FYpewFK8zgNM0PmXOsk13rIVuOsxs5hYnG+n7nBdG1eMCGmcI2tivTBxPZq
         Bje3D0RsL64w62hiP3wyQCbVoVnhixMxY+pgbD7b23WeMObCgstkkVlaP3VVHSaA6a5m
         svEE8AUOdzC4b13qrpA+QSOisEHFP/IWpnjugbszi1XV+JVfkfRX9Y/8W4jRFhFplAzQ
         6/RVIaRskYwVgqpGY0KCmlITnaT31p3rvUUCk62bF7keGLUoEeb1DxMp5gqHc4fzjdt2
         L+fg==
X-Gm-Message-State: ABy/qLaOj4cduL/W58ebWlr3xrgA3uCQC3feqYSWlrM98zXdz3p3CsjB
        6SvpURemI6k07wNFyoReV+0bgq7xPXJ9CghZFd8=
X-Google-Smtp-Source: APBJJlG+XMgQ5ae56l4B0yzXtHY9Ii4DpokIrIA2kLt+KkFyhR+5Mf6Fg1tCy2RxdUNRFYTVD149wOMuedXECtzkj8k=
X-Received: by 2002:a81:6cc8:0:b0:569:c4be:3f6d with SMTP id
 h191-20020a816cc8000000b00569c4be3f6dmr479250ywc.5.1690605095194; Fri, 28 Jul
 2023 21:31:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:6326:b0:31a:14a8:aa9e with HTTP; Fri, 28 Jul 2023
 21:31:34 -0700 (PDT)
Reply-To: bintu37999@gmail.com
From:   Bintu Felicia <yerobarry10@gmail.com>
Date:   Sat, 29 Jul 2023 05:31:34 +0100
Message-ID: <CAD1=OdXjFp2VEDQ4jmypZ+gWBWKLTMNS+TktJNGLqii0RqT4YA@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

How are you today? I hope you are fine. My name is Miss
Bintu Felicia . l am single looking for honest and nice
person whom i can partner with . I don't care about
your color, ethnicity, Status or Sex. Upon your reply to
this mail I will tell you more about myself and send you
more of my picture .I am sending you this beautiful mail,
with a wish for much happiness.

Warm regards,

Felicia Bintu
