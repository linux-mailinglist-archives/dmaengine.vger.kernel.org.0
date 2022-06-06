Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C753EDC4
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jun 2022 20:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiFFSV5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jun 2022 14:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiFFSV4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Jun 2022 14:21:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428DC149D96
        for <dmaengine@vger.kernel.org>; Mon,  6 Jun 2022 11:21:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd25so19958520edb.3
        for <dmaengine@vger.kernel.org>; Mon, 06 Jun 2022 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=yzRfyLB6KFPr25aQi3R1gg75wEKKaYYdiGN/KVcBALg=;
        b=EwelDmK+gElrdYWTp/PoO/n4j5/LPKsMETVx7n5UdzUQsBTi+QU02uUMC/QLYLR7t+
         zIKTAfE5bju0Yrt/biBjc73sv0CCDeWq2uxMKNUsyZl9i7Sh6CVricrDlUoDDGa+I4YI
         NNwiHRhrn6aZc9GcO993LtEiy+19NuUxdWZknAmuBNOSDmVEGZKTWjFmj/myNqUkNMEN
         5kZYmaXVBYVBkirxpAfMRBMUP3YnLdFSaEjBxkr+3fx6+TDfm7QM23gk4qGadmCjay1s
         8ykDp+WUxRlUjo1fYAcOYO6Rpzuu+HWx+l+yGRehknex6gOfiQqDvrUTXXGKgLlSlBvy
         swXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=yzRfyLB6KFPr25aQi3R1gg75wEKKaYYdiGN/KVcBALg=;
        b=D4GSF9Vp8RJ+IZJz0QoYluHpskJOK8sgvlL/RZEGj48gJxexRw+9vIeZqOv+ZjcT0a
         mrQM4zV7SN3KH0z+63tJmpyHsH6CnTS/zrPdnhhJFgxHyaMr5+A9qBZjU37O/WnF5ijL
         RCiOC7riuFQvEzl9XaKTFNniI4KQDGiRlIUNsTjtRIzreVrjqiYmUjTOFma+R9/iiqbZ
         54m3652VFo8nBMHnUUARj83E3LLwY+iUBHXmOGPAKNlOHfcffKCPhGikeAktRWfwDNB0
         Je/vYmNMSAyVlwBMnVrLz0nn8giOA65sB2bHVXuhSKh7f0AmyeBu2ZGn8aiHMptc96Sm
         NMxw==
X-Gm-Message-State: AOAM531blv9ljqvmw6EDggB+UC81mh98dpYKRLHIPQLDyy8iI3zgoEhy
        nqW7Owa+pc10v54gpttrP6PG9uAuqJhmgshkF2Y=
X-Google-Smtp-Source: ABdhPJwVv0fSSFJhsdgwxZmLpgjLGjxBdiPe3Ets4bqD4/Dw0TV6eGPpCScInN5OtIl77huugzCrAud8Tp78MeIlMTw=
X-Received: by 2002:aa7:c306:0:b0:42d:d4cc:c606 with SMTP id
 l6-20020aa7c306000000b0042dd4ccc606mr28727856edq.341.1654539713611; Mon, 06
 Jun 2022 11:21:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:440d:0:0:0:0 with HTTP; Mon, 6 Jun 2022 11:21:52
 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <tracywilliamusa@gmail.com>
Date:   Mon, 6 Jun 2022 11:21:52 -0700
Message-ID: <CAKU4NYntb3abGWL9DbiYCDrXUgBQuremN7=oKYexc=x_sR2_XQ@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 

Hello Dear,
how are you today
My name is Dr Ava Smith,Am English and French
I will share pictures and more details about me as soon as i hear from you
Thanks
Ava
