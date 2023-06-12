Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84272CC1D
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjFLRL5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjFLRL4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 13:11:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DD5E7B
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 10:11:54 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-51f7638a56fso3125211a12.3
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686589914; x=1689181914;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/I8oU5lBx7O0AVCpvbGtKKitom6tdJ7McWrPGypDC4=;
        b=wVF0xEYGM/V+zCU80xvyq4qwV0yj1hOdLFRqOeBG6rNq1mZS9axHGYBLeBI0WMdRIv
         hkzXG+DQqyxUG3ZNJwhk4nvHa7dTDdVmUbtUbv0KonjLnpMhwIR++Zn+JYGYF4qpACy0
         TBguC9jF/7RXSTOZFdVTFwDFoUFeZKO/TxKQvxwyOSfFBR1hlTDCsLQF3gJGrQKh0dM1
         dnbBs1N9sWbWV7gnyAH3EvCgPH/tTgIbVrgHLUeG6DI/qTktPkH3U4iZQSPo6hQIH+Hn
         C7b43aUeXSO/Vmzkm31QiJeIjfT3Lil1qVykh5WcPDzbPCKU8j1R2gFpw17raF0Nay2u
         ptyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589914; x=1689181914;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/I8oU5lBx7O0AVCpvbGtKKitom6tdJ7McWrPGypDC4=;
        b=J16dGgMaAxEbskRG8WTosf+NSmUVVo9/JXOi8IYYMJbLBsFWJ6z/hx2qhxW90tGixC
         aK69ABnpOx95JXkOUMZoDgcqe9pwGte9GLTRtLZYxBAaXXYt2TphlmmbYgsjSBpc24AN
         vOnBaerC8TztiMfJiPohzVLm/6gQ9od0pEa61MaL4hDZ6v8p85R3BPnmsqHTfPg54DZw
         1VaGbHsHCmluFzG0zBV0ytUhtWlSnvGyOeB7LAj6rmmyT6DJFOYzTpuWVsBkrtADQcZf
         J80x7S4dFcvBj806TKZADK6BGZRu58I/6FxK+coqDWaP0peHJ3VUtVymZXttXoTcLre5
         fESg==
X-Gm-Message-State: AC+VfDzHPOqOEYVE7Dpb30uULmmLJeDknWRVgC9VbrJgYNtiXIh0QeCR
        6BZRqlgiBYKdZKqjyhXPRVxQH9uyolQ=
X-Google-Smtp-Source: ACHHUZ5v1c+CqyBwYivhK+DSqau5kQVmVjEZH0nAYmDaNR5inKzg30hD4xw/4ZnGEEzgZLpMXuBMN4uPSsY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8d81:b0:1b3:95a9:3fc3 with SMTP id
 v1-20020a1709028d8100b001b395a93fc3mr1303122plo.10.1686589913639; Mon, 12 Jun
 2023 10:11:53 -0700 (PDT)
Date:   Mon, 12 Jun 2023 10:11:51 -0700
In-Reply-To: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Mime-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093541.598260416@infradead.org>
 <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Message-ID: <ZIdR18xG1jy8WdEp@google.com>
Subject: Re: [PATCH v3 56/57] perf: Simplify perf_pmu_output_stop()
From:   Sean Christopherson <seanjc@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        dennis@kernel.org, tj@kernel.org, cl@linux.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023, Linus Torvalds wrote:
> This patch looks completely broken to me.
>=20
> You now do
>=20
>                 if (err =3D=3D -EAGAIN)
>                         goto restart;
>=20
> *within* the RCU-guarded section, and the "goto restart" will guard it ag=
ain.

What if we require that all guarded sections have explicit scoping?  E.g. d=
rop
the current version of guard() and rename scoped_guard() =3D> guard().  And=
 then
figure out macro magic to guard an entire function?  E.g. something like

  static void perf_pmu_output_stop(struct perf_event *event) fn_guard(rcu)
  {
	...
  }

or just "guard(rcu)" if possible.  IIUC, function scopes like that will be =
possible
once -Wdeclaration-after-statement goes away.

Bugs aside, IMO guards that are buried in the middle of a function and impl=
icitly
scoped to the function are all too easy to overlook.  Requiring explicit sc=
oping
would make bugs like this easier to spot since the goto would jump out of s=
cope
(and I assume prematurely release the resource/lock?).  As a bonus, annotat=
ing
the function itself would also serve as documentation.

The only downside is that the code for function-scoped locks that are acqui=
red
partway through the function would be more verbose and/or cumbersome to wri=
te,
but that can be mitigated to some extent, e.g. by moving the locked portion=
 to a
separate helper.

> On Mon, Jun 12, 2023 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7977,7 +7977,8 @@ static void perf_pmu_output_stop(struct
> >         int err, cpu;
> >
> >  restart:
> > -       rcu_read_lock();
> > +       /* cannot have a label in front of a decl */;
> > +       guard(rcu)();
> >         list_for_each_entry_rcu(iter, &event->rb->event_list, rb_entry)=
 {
> >                 /*
> >                  * For per-CPU events, we need to make sure that neithe=
r they
> > @@ -7993,12 +7994,9 @@ static void perf_pmu_output_stop(struct
> >                         continue;
> >
> >                 err =3D cpu_function_call(cpu, __perf_pmu_output_stop, =
event);
> > -               if (err =3D=3D -EAGAIN) {
> > -                       rcu_read_unlock();
> > +               if (err =3D=3D -EAGAIN)
> >                         goto restart;
> > -               }
> >         }
> > -       rcu_read_unlock();
> >  }
