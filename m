Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0009272CB7D
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjFLQ14 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjFLQ1v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 12:27:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD70E53
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 09:27:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98220bb31c6so142634566b.3
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587268; x=1689179268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ64AB6vFE2gCnLICKj93uVfxKBboA+BfLd8wCYY+0E=;
        b=GGYYVsoEcCvOtMCbQCEGpMUTlLitinee+4cI9TY/ECPn0E8/1r157Y1iWtRQZ5Cxac
         YySzailK3aA1bQM+Cjs0E12G9OqfTX3Z3pQzA5iBMVhUQanNMp1U2QAnfBSSY2BGgPBq
         0Sf9MB5K4qnDVr0F92Hc/BAulYDYNJRzwbr0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587268; x=1689179268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQ64AB6vFE2gCnLICKj93uVfxKBboA+BfLd8wCYY+0E=;
        b=BMCoi+yj/FXP04kWSYK8LSujzTZF9CPHrjpGg+Y+RQu1gsgYxVPpqxnVEnyK4v5CcH
         RVhDDFHtIKMKs5gHCCU1gS+SQGwK6uD4IDjqY7CZUn9hNo9P9dG3EAsteCZ/W6TZLWBa
         +zSt2cCtMn2VPBkm7ZViwmMr4/pHbtUdeyWC8LideMkxLikYN36m1IgE4mEBNarKAznq
         f/uXwy6kFm/RpWOkpjPQh2Oy93+H2xnAOL06Y0r6VT2f5HTa/VmTOaCai6j77trRgqqb
         3Nh78i+JKRsYcAexqSCqBzcrfMYfBzkupD0m8j4UNUXGsx/4vF3y8x1z9FJWNgzn2mIs
         hVaA==
X-Gm-Message-State: AC+VfDyrXs7Mwdxbh3+UDHt1rjudSiAe6nHv/Ato2gvN9ISZ+s6dhgSr
        qW21TD64QLfyHdWrHmsiA3QWX8FEmyrCw4+ZeG3zyJyo
X-Google-Smtp-Source: ACHHUZ62vL+kbfWZYZKb07GniEHtpciT47nAmfFmeSE9pP6vqGlfj+9EBJC/zMJxBWQWDxsmD4oMyg==
X-Received: by 2002:a17:907:d1b:b0:953:8249:1834 with SMTP id gn27-20020a1709070d1b00b0095382491834mr12455257ejc.16.1686587268693;
        Mon, 12 Jun 2023 09:27:48 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906b19800b009821ad6ad8fsm1391816ejy.71.2023.06.12.09.27.47
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:27:48 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-30e53cacc10so2888385f8f.0
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 09:27:47 -0700 (PDT)
X-Received: by 2002:a05:6402:6d3:b0:514:93b2:f3b1 with SMTP id
 n19-20020a05640206d300b0051493b2f3b1mr5343956edy.40.1686587246075; Mon, 12
 Jun 2023 09:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093539.895253662@infradead.org>
In-Reply-To: <20230612093539.895253662@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:27:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
Message-ID: <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
Subject: Re: [PATCH v3 33/57] perf: Simplify perf_adjust_freq_unthr_context()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This seems to have the same pattern that I *think* it's entirely
broken, ie you are doing that

                guard(perf_pmu_disable)(event->pmu);

inside a loop, and then you are randomly just removing the

               perf_pmu_enable(event->pmu);

at the end of the loop, or when you do a "continue"./

That's not right.

The thing does not not go out of scope when the loop *iterates*.

It only goes out of scope when the loop *ends*.

Big difference as far as cleanup goes.

So you have not "simplified" the unlocking code, you've broken it. Now
it no longer locks and unlocks for each iteration, it tries to re-lock
every time.

Or have I mis-understood something completely?

               Linus
