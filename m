Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5172CB5B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjFLQUU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbjFLQUB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 12:20:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FB01985
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 09:19:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b219ed9915so53060171fa.3
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686586798; x=1689178798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/KCMaMkVpL2TvKmUhvddPCRbVA7+Ro9TFJ9/0bVSYQ=;
        b=RpSZTBLrv61ba9flrRa5PadwEnWtCpR5o5AM06/FYCgd+/wgNZu4keVki1w7iZ7U1D
         ULrBTQQmkLGhfZHtLAp1muqdaluKViphQ4XlC4Ee3ijw1EF0M/DjOIsMLqKNA3weSeKQ
         jSqB2TvIVQ8O5V04ZOxLxViEzCSepFoTlGeaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586798; x=1689178798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/KCMaMkVpL2TvKmUhvddPCRbVA7+Ro9TFJ9/0bVSYQ=;
        b=F/OL3/wkpnc1y9WOqP56qS1/G3UOHkpKRQfg5PclhjrpWhPluowAIGPh8A0fsI36t0
         /Ligi+8zzccA+k6uJaTjWKtg9Ls7j+Xpslq8bifgzjnp3hcyqzQS5eHxw3QlXy+KFNzB
         TrRKTBD3ai0Xxwuc6xnbbdiq+LLP9VqAuIPRrJ4wC/0lHZWm+mAmLnRkdtybcmosYnLm
         zHC6Ig94sJhpK/uMTHx6CzvmkwMNydNtIEYGtXWPDOIFYwjEaIA3jUrV6ndMkOTaIrNI
         uLs6pgpfZpWXS53I1eisZcmALtNMFcim638b8/J0dMzdAemaXUf5g/cs/rTdHzLzKhaj
         C+xA==
X-Gm-Message-State: AC+VfDz4uWuczgw3DDpYd2L0uSpwONV3p/ezXkKqPRhaRUWDJBGYn4eq
        LfC1EjF0iks/EVzCb9O/HUbs1e4/jXAXZvr4PPmFjyur
X-Google-Smtp-Source: ACHHUZ7HpRYs9sjdHXevJwBKxtXTbJ2ZGHSoKyIIVVmvMSuUKWPDKDdnqd59a3HM5bF+6a/JFHN18w==
X-Received: by 2002:a2e:81d2:0:b0:2b1:ad15:fe39 with SMTP id s18-20020a2e81d2000000b002b1ad15fe39mr3405138ljg.10.1686586797789;
        Mon, 12 Jun 2023 09:19:57 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id ke3-20020a17090798e300b00977cf84c42dsm5386115ejc.43.2023.06.12.09.19.57
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:19:57 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so32375495e9.2
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 09:19:57 -0700 (PDT)
X-Received: by 2002:aa7:d14e:0:b0:50b:c3f0:fb9d with SMTP id
 r14-20020aa7d14e000000b0050bc3f0fb9dmr5534541edo.41.1686586776585; Mon, 12
 Jun 2023 09:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093541.598260416@infradead.org>
In-Reply-To: <20230612093541.598260416@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:19:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Message-ID: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Subject: Re: [PATCH v3 56/57] perf: Simplify perf_pmu_output_stop()
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch looks completely broken to me.

You now do

                if (err =3D=3D -EAGAIN)
                        goto restart;

*within* the RCU-guarded section, and the "goto restart" will guard it agai=
n.

So no. Sending out a series of 57 patches that can have these kinds of
bugs in it is not ok. By patch 56 (which just happened to come in
fairly early for me), all sane peoples eyes have glazed over and they
don't react to this kind of breakage any more.

                Linus

On Mon, Jun 12, 2023 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7977,7 +7977,8 @@ static void perf_pmu_output_stop(struct
>         int err, cpu;
>
>  restart:
> -       rcu_read_lock();
> +       /* cannot have a label in front of a decl */;
> +       guard(rcu)();
>         list_for_each_entry_rcu(iter, &event->rb->event_list, rb_entry) {
>                 /*
>                  * For per-CPU events, we need to make sure that neither =
they
> @@ -7993,12 +7994,9 @@ static void perf_pmu_output_stop(struct
>                         continue;
>
>                 err =3D cpu_function_call(cpu, __perf_pmu_output_stop, ev=
ent);
> -               if (err =3D=3D -EAGAIN) {
> -                       rcu_read_unlock();
> +               if (err =3D=3D -EAGAIN)
>                         goto restart;
> -               }
>         }
> -       rcu_read_unlock();
>  }
