Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63074C126
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jul 2023 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjGIFsD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Jul 2023 01:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjGIFsC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Jul 2023 01:48:02 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0084DE4A
        for <dmaengine@vger.kernel.org>; Sat,  8 Jul 2023 22:48:01 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c2cf29195f8so4247159276.1
        for <dmaengine@vger.kernel.org>; Sat, 08 Jul 2023 22:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688881681; x=1691473681;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=eBFdfiIMlzwz5EwN/2u7FBVisOxlCGzXrKBBvjB2ra/lNJDBim/dXUySsYl04DT4/f
         2KEMiBqZVVPHgiFFkhqj6VtEh891UvpY1yp5IzzCzadrcMT0UNNjPcRrPF+7Le0PNlEB
         lJqjkhGQWhcPQD6kXQJaE2li0czlF402k+3bjIlM7NgnwhCwVvl1MjXgxcObT2lzHA6R
         g20UJr5vjgBebIbRzmsCtXKp37Y27TLBgcBXvPbRbndsqa37Ht05FdiQZOebba4+0tCS
         fB9lagkOkAsrUlkMOV7zdDn4XlNNPp6oduiX7bTRccnWtgjVRpGTLxGXTvxe5mS6Q0cm
         +PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688881681; x=1691473681;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=Uqp5pw+VRaLunvidRKuChAV6MA9FHauaY528vEAgpouM1Wvs1dL92/EHsCMYVkY6rS
         /vgNCLVHUBet4XcJjAFTVwfUh7sBcmGUOZF3nV3FdaJixhra89JsJ65hwy0RGL+Ubjgd
         kR1WNNU68Eq4LVphqxaoo3ZYeZuX5h/246wNT/5+tPpEoOTVXjzqZQZgaURvZojSJeVQ
         0qKbv8i7K7T7alBv1jqCdRUz9e4gYqkTzr/OUQ2RPRpPRsKn1xqL+4+lYzxIecKln4QW
         cu6ak1b2CAtC+OXX2bHPWYlTucZGtJtq7xao4VD/cYmNBtX9MCRAUUtfhJpoIKRNR9A1
         hAQQ==
X-Gm-Message-State: ABy/qLaTkvvXAIjOICzlNBY29VU9RgHvF6XxFZIhOQYrk9WUMDsdivVJ
        hEcDv/HqW/FUqmhEj71y3n4/SetWIZK1rP4lLDo=
X-Google-Smtp-Source: APBJJlGA+YxzEW4yzNIwLWjjXfFnDe7ryJ81lTeKDUYhULXOajJemBjc5d+ESe8bPATzpMmee9DNCm7GKJZpLj9pkD8=
X-Received: by 2002:a0d:e207:0:b0:579:9cae:e0ee with SMTP id
 l7-20020a0de207000000b005799caee0eemr9755960ywe.20.1688881681135; Sat, 08 Jul
 2023 22:48:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:5bd6:b0:4d3:cfef:10c with HTTP; Sat, 8 Jul 2023
 22:48:00 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <coulinina15@gmail.com>
Date:   Sun, 9 Jul 2023 05:48:00 +0000
Message-ID: <CANZxeNPJ0XJzoa3KLTfcqEoT2Ceud7g+8p3gX5Kw6t4hhNAg6A@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear,

Please grant me the permission to share important discussion with you.
I am looking forward to hearing from you at your earliest convenience.

Best Regards.

Mrs. Nina Coulibaly
