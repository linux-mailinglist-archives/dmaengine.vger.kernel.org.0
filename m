Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28D4FA744
	for <lists+dmaengine@lfdr.de>; Sat,  9 Apr 2022 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiDILZb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Apr 2022 07:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiDILZa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 9 Apr 2022 07:25:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98F2F7EA9
        for <dmaengine@vger.kernel.org>; Sat,  9 Apr 2022 04:23:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b43so14418585ljr.10
        for <dmaengine@vger.kernel.org>; Sat, 09 Apr 2022 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=QKlhPH8vm2qVRwVcOPcInB4rMwXCJ9AjGgiybq60bDEVRM7asAeaPCykwoJUMueLhX
         XlPbOdcO7T+RT3RE2nNvIAadVnqQOQu76WZJnfJ2NW71f8GcMWWOACWs8QLxkmPvXx4J
         1EZK5vaexQATXik5i0p/ggtjYnFLgozog2gnAUdy/8I3TX9Yggrt4NvPmD8EehBtyHc5
         SLCFNJ76/VSmZ/8u/BHG30FZR6GrU0LEsU+dvy/9PfwwYCl0N8/ZjmVgb6DuPcbh2/X+
         wTUkuZD5/ewP9tzDRT7nPMFS+4S7SIQdggd+zlDVRG1LvVQVP8NpTH0Hzsxbp7JUeykE
         J6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=RBkORfC3JDONlocrUxn4M+rYMjzxd41ok4cQ/cZqarMwgPLHFAkSWTM0A5tBHRoMka
         6WppJi4o15HVkofBGKYODkF6YuSOwCMjzV+d7T8Mth+5rc+CC1ASM7ZxYRbbdd4uND+6
         O5hS1IHPsSycHhqnITqcoz6dzQ3i9tPQVNkSP0/lgE/94VQG+PjmEj9LZlKd5pXTPtMx
         yFIgJXxbjmoTsqguli9tYyiEfhfg7q0xZ7tRHaO7ordNmxXnZ3EnQpJHvj8mcWb2GcWT
         nHbWkWeTzxhLdz09Xv3E069w2wKTWqWd1sK9SlgYh7LJ5pPYYhwRxwBQklyHWQ2eSE3F
         rAMg==
X-Gm-Message-State: AOAM530ROEHgGRCdqUy9LpDMJnngbmVDc6JwWwOxyo//G+gUurKcGYz+
        QWSE0GKlRiZNvTbimlBagMj/s4zlH1ncFRJb0KE=
X-Google-Smtp-Source: ABdhPJxYi6unnf4pw4+f4xr/TtRbwGpRfeM3grI99HlBDSQW32BbuRjnZz3oWNnUEk3ZZdCyh87xCpx4xpmi2G6A17o=
X-Received: by 2002:a2e:a545:0:b0:24b:5148:98fc with SMTP id
 e5-20020a2ea545000000b0024b514898fcmr3947681ljn.231.1649503401103; Sat, 09
 Apr 2022 04:23:21 -0700 (PDT)
MIME-Version: 1.0
Sender: khwajasalman7@gmail.com
Received: by 2002:ab3:6741:0:0:0:0:0 with HTTP; Sat, 9 Apr 2022 04:23:20 -0700 (PDT)
From:   Miss Qing Yu <qing9560yu@gmail.com>
Date:   Sat, 9 Apr 2022 11:23:20 +0000
X-Google-Sender-Auth: UYW-Qq_DN8OXqntg_mz8aZfsZJE
Message-ID: <CAKO8o9MG=XZfhycq=QT882719Fs+zpsk+_bjjJN0jsZZxo9U4A@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it with the critical condition am in because all
vaccines has been given to me but to no avian, am a China woman but I
base here in France because am married here and I have no child for my
late husband and now am a widow. My reason of communicating you is
that i have $9.2million USD which was deposited in BNP Paribas Bank
here in France by my late husband which am the next of kin to and I
want you to stand as the replacement beneficiary beneficiary.

Can you handle the process?

Mrs Yu. Ging Yunnan.
