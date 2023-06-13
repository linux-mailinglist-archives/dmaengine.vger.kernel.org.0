Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423F672D995
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 07:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbjFMF4V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Tue, 13 Jun 2023 01:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjFMF4U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 01:56:20 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E9618E;
        Mon, 12 Jun 2023 22:56:19 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4652fcb2ac1so2100964e0c.1;
        Mon, 12 Jun 2023 22:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686635778; x=1689227778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXoP/SfXeEJ/3wkZUjDn660T9VLgrFL+TBUwgZAoObU=;
        b=iqLgDpZLQwdyissvPRLHjcy3JmFLoxoZlVg6GNaG/3XM1VcZQG8XM7fsRYdsJ9qe3x
         h6dYWzAGUqVJpGGxy2rbb5eLFrkr4TdRt68ARWnvpbwNZ88kaoogpzWG5vKw28m5Zc2z
         j2MW6uNU91YIjggpLap+bCd6gZdInnhL5yD2S0cTNsIot0GQxYSRY85L9P723AWjNF2+
         s0LXlBa3Cr+AqwVuue2V1AvKXF5bpxnM06mpVMq6gdjGkddC60p5cwJ7iu5H0eW9F22t
         Uk8B6Ec/O2Psjc9g8xA3kaKFFxdODwQyeZjpjwEIkg/w4uQD4aVcyD34lwhR+l/ZbSB8
         FWLw==
X-Gm-Message-State: AC+VfDyY3m5uxPLsxL/yO1LqtMgVoIFFUql31wF6aalpcZtw0GY5Rk2Z
        nLa94QzqGF2YkvD6BzoWLzCysoxWm1jhdhXimWE=
X-Google-Smtp-Source: ACHHUZ7Cj9u8WTOpvJ3k1N/xhXE9h8rxLIkzVesRwg9r4gsjesfbSe/X67dLrFf1E5Xf3TVgeqrXTm+8Y8tzoGTBqiw=
X-Received: by 2002:a1f:4386:0:b0:45d:5914:80b with SMTP id
 q128-20020a1f4386000000b0045d5914080bmr5911210vka.6.1686635778061; Mon, 12
 Jun 2023 22:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093539.371360635@infradead.org>
In-Reply-To: <20230612093539.371360635@infradead.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 12 Jun 2023 22:56:06 -0700
Message-ID: <CAM9d7cjz4cnEgV_oAnTOqyCWXDeD3ECYQFc=Uksct2-HKuFmiQ@mail.gmail.com>
Subject: Re: [PATCH v3 26/57] perf: Simplify event_function*()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        dennis@kernel.org, tj@kernel.org, cl@linux.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Mon, Jun 12, 2023 at 2:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Use guards to reduce gotos and simplify control flow.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |   39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -214,6 +214,25 @@ struct event_function_struct {
>         void *data;
>  };
>
> +typedef struct {
> +       struct perf_cpu_context *cpuctx;
> +       struct perf_event_context *ctx;
> +} class_perf_ctx_lock_t;
> +
> +static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
> +{
> +       if (_T->cpuctx)
> +               perf_ctx_unlock(_T->cpuctx, _T->ctx);

Shouldn't it be called unconditionally?

Thanks,
Namhyung

> +}
> +
> +static inline class_perf_ctx_lock_t
> +class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
> +                               struct perf_event_context *ctx)
> +{
> +       perf_ctx_lock(cpuctx, ctx);
> +       return (class_perf_ctx_lock_t){ cpuctx, ctx };
> +}
> +
>  static int event_function(void *info)
>  {
>         struct event_function_struct *efs = info;
> @@ -224,17 +243,15 @@ static int event_function(void *info)
>         int ret = 0;
>
>         lockdep_assert_irqs_disabled();
> +       guard(perf_ctx_lock)(cpuctx, task_ctx);
>
> -       perf_ctx_lock(cpuctx, task_ctx);
>         /*
>          * Since we do the IPI call without holding ctx->lock things can have
>          * changed, double check we hit the task we set out to hit.
>          */
>         if (ctx->task) {
> -               if (ctx->task != current) {
> -                       ret = -ESRCH;
> -                       goto unlock;
> -               }
> +               if (ctx->task != current)
> +                       return -ESRCH;
>
>                 /*
>                  * We only use event_function_call() on established contexts,
> @@ -254,8 +271,6 @@ static int event_function(void *info)
>         }
>
>         efs->func(event, cpuctx, ctx, efs->data);
> -unlock:
> -       perf_ctx_unlock(cpuctx, task_ctx);
>
>         return ret;
>  }
> @@ -329,11 +344,11 @@ static void event_function_local(struct
>                 task_ctx = ctx;
>         }
>
> -       perf_ctx_lock(cpuctx, task_ctx);
> +       guard(perf_ctx_lock)(cpuctx, task_ctx);
>
>         task = ctx->task;
>         if (task == TASK_TOMBSTONE)
> -               goto unlock;
> +               return;
>
>         if (task) {
>                 /*
> @@ -343,18 +358,16 @@ static void event_function_local(struct
>                  */
>                 if (ctx->is_active) {
>                         if (WARN_ON_ONCE(task != current))
> -                               goto unlock;
> +                               return;
>
>                         if (WARN_ON_ONCE(cpuctx->task_ctx != ctx))
> -                               goto unlock;
> +                               return;
>                 }
>         } else {
>                 WARN_ON_ONCE(&cpuctx->ctx != ctx);
>         }
>
>         func(event, cpuctx, ctx, data);
> -unlock:
> -       perf_ctx_unlock(cpuctx, task_ctx);
>  }
>
>  #define PERF_FLAG_ALL (PERF_FLAG_FD_NO_GROUP |\
>
>
