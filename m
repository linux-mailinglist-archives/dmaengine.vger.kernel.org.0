Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FEC72F47A
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 08:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjFNGOH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 02:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243050AbjFNGOF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 02:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB581BE3;
        Tue, 13 Jun 2023 23:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6421A63DBD;
        Wed, 14 Jun 2023 06:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5D6C433CD;
        Wed, 14 Jun 2023 06:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686723241;
        bh=gKtrtIqzZJoEk6ijfzdhgV+HQxM5jhk7xprFoURO0JM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H2r0vx2LGQQyw19AhfkRLBx0RW0eL1OK9TtVh3CpZGktkKfPcWjNa9Kha87oDBHYJ
         Zhz+1dlpE7DDMG5Rk9DPdEbCXbQjz3bl7RVN4MOS7uVarXb8B1sQySCZ7B2/9YBDYy
         bWwKoJ/OXOR+I+kcLDX8GDODGFXdxmA0nWw5lm6S7BGbqYX1l4Ur5Di8DR63q4QUxL
         3zvODZVMEkRqeYOGt+1x7Tv6mbJ+MxBc/TkMbJXHV/MNAwSBkaKAubU433Bu7zkjA8
         am0zD+rwOSYPg+atIZFBO6SgL9tfErJKNXsPEqxIl79QJAcs2cl00cViWXdLU+xgyu
         ta/KvDCLhzJ3A==
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-786e8de85c1so503991241.1;
        Tue, 13 Jun 2023 23:14:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDykUL3Quwvwl/Ybfn/+B7+W+n6zypZ4D9y3G72B8BL9IApbJvxu
        cY1RulrHMFm91oEx9Y58iH8JMGMQOXXO03nsTmk=
X-Google-Smtp-Source: ACHHUZ4vqXimisQGWZrncZnp4O3Mb6P9lJW4fWcpmyBbfqrFix7TZ+nNTuq2mkhec+rZw/J5LGOYIIEVD09ISg0wZhM=
X-Received: by 2002:a4a:c4c4:0:b0:558:bec2:c854 with SMTP id
 g4-20020a4ac4c4000000b00558bec2c854mr8570147ooq.5.1686723220046; Tue, 13 Jun
 2023 23:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093537.693926033@infradead.org>
In-Reply-To: <20230612093537.693926033@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 14 Jun 2023 15:13:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNARwAaw_22AjsheMtNwpVgF7FtKxh08mkg3cP=bY2016hw@mail.gmail.com>
Message-ID: <CAK7LNARwAaw_22AjsheMtNwpVgF7FtKxh08mkg3cP=bY2016hw@mail.gmail.com>
Subject: Re: [PATCH v3 04/57] kbuild: Drop -Wdeclaration-after-statement
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com, nathan@kernel.org,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 6:39=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> With the advent on scope-based resource management it comes really
> tedious to abide by the contraints of -Wdeclaration-after-statement.

Where is the context of Linus' suggested-by?

I do not know where this came from.
I suddenly got a huge v3 in my mailbox.


I see an equivalent patch submitted last year:
https://lore.kernel.org/lkml/Y1w031iI6Ld29IVT@p183/

Linus rejected it. Did he change his mind?



> It will still be recommeneded to place declarations at the start of a
> scope where possible, but it will no longer be enforced.

If you remove the warning, we will not be able to
detect code that opts out the recommendation
for no good reason.





--=20
Best Regards
Masahiro Yamada
