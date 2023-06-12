Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAE772CEF5
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjFLTEk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 15:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjFLTEh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 15:04:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E810DF
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 12:04:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so5811102e87.1
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686596668; x=1689188668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yhv8xsO6/cG6/37ib7eGERu4MLsFMvugXkXspF4Zlg=;
        b=erHF+DhUH9xqr6nZNK93gQH06CAs08NwII0o2YpXygSo+DvkOnjXRDfn90c838Vf++
         I6cowQI23WmEaLMKQPx+By+KSZlU1WLodPGiTuOcWwqQUGrLekcG+GfiEJkgFXvBmHEp
         6FZk0JZqko0TbTOC3No6Nuz7UpXzcAQmI8WXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596668; x=1689188668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yhv8xsO6/cG6/37ib7eGERu4MLsFMvugXkXspF4Zlg=;
        b=kFiIke1OQg25A524rH/Ew8NG2s3nINsKVFr26SpTcqxoJhDO81E/l5U5mjBIJXItXz
         TU1iBvgwYnTX2gagBYEmliIqumvhyNR5vx+lLAa/afWX8IEu6apXZDZOXRohrWhRwJKg
         drK128i38w4PeQ8fJ5CHq8H3yImjxLd5+1LyHdGh9rzakkpVu1qWQPKxiq+KvA6eKgGd
         5uHXNcy8O/V4LpgVwu9GoDIVGGIx2b9DWhFMAF9HKrdQvOSeFkRcTOXccO4mXZWgZnlf
         ACFE4ACsiS94azQXaBW+oR7IyDRCLGJ+kllDYAJ1Xd4NFYZOVGvwwW5OqmMljVn96fAr
         eDdg==
X-Gm-Message-State: AC+VfDyi/EsIIN3wPgpXpfvewBJag5OQx3w2nSQJmT23Urt0cYjAplYd
        MQLC+oX6XjOVZxj7yGgPJ69p75lGA86xrOtkgDX2nhbT
X-Google-Smtp-Source: ACHHUZ7IhuWfrnhl5D1jEfxy+LnVnZ5vtQVNF1tLIISFqR5TvQlZLNk8qghGrjMfDDMdAHwy7YOPzQ==
X-Received: by 2002:a19:4f52:0:b0:4f4:eeb4:ba70 with SMTP id a18-20020a194f52000000b004f4eeb4ba70mr4922889lfk.32.1686596667952;
        Mon, 12 Jun 2023 12:04:27 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q19-20020ac246f3000000b004f60d26e1d2sm1503689lfo.80.2023.06.12.12.04.27
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 12:04:27 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b1a3fa2cd2so55689051fa.1
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 12:04:27 -0700 (PDT)
X-Received: by 2002:aa7:d841:0:b0:516:b182:4e58 with SMTP id
 f1-20020aa7d841000000b00516b1824e58mr5590497eds.32.1686596174182; Mon, 12 Jun
 2023 11:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093539.895253662@infradead.org>
 <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com> <20230612184403.GE83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230612184403.GE83892@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 11:55:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaSkM4fjdP9dcdXQpLLjxW43ykgLA=FgzyHpyHayz8ww@mail.gmail.com>
Message-ID: <CAHk-=wgaSkM4fjdP9dcdXQpLLjxW43ykgLA=FgzyHpyHayz8ww@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 11:44=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> I tried this before I used it and variables inside a for() loop have a
> scope of a single iteration.

Whee. Ok, that surprised me. But I guess that I shouldn't have found
it surprising, since the value doesn't survive from one iteration to
the next.

My mental picture of the scope was just different - and apparently wrong.

But thinking about it, it's not just that the value doesn't survive,
it's also that the "continue" will exit the scope in order to go back
to the "for()" loop.

I guess the "goto repeat" ends up being similar, since - as Ian Lance
Taylor said in one of the earlier discussions - that "__cleanup__"
ends up creating an implicit hidden scope for the variable. So a
'goto' to before the variable was declared implicitly exits the scope.

Ugh. I do really hate how subtle that is, though.

So while it might not be the horrible bug I thought it was, I'd
_really_ like us to not do those things just from a sanity angle.

                 Linus
