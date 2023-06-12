Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7872BD28
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFLJzW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjFLJyT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 05:54:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C79749FA;
        Mon, 12 Jun 2023 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iuKjwptMM283OkeCg3rHRYfDPMncNnTiTfZUlZvzjjw=; b=eQ6OsD4kYVKLafcm5zMaXykUrJ
        t3Yx8a+byrZdB944/0aNdLOqAmoLeWSa1sowLg19pvZhRfEGH12EfjQizZN73l+Q2lmgWVTy/jEN2
        66w/tSoR035EtMK1QJrtp16Z85OKpvfSl1I8OLy7JSDS0vEBXw8vGKRffU4u96Gz85h50NrSym32v
        8aadmJp7+8xctTmftjzi5KRquTBd3yr6fYIYX7v7Rb7TZGAQFPvFwW5JY6GaXXShnDrDMfhQWRx/H
        Hx6pFtrNHcKkz/xQw6bxea1nVgSbzWPnczzWWwxrD46aGrv+zXbaZt8xVprl8zZZmhqQuJnaVP8+3
        u9+4lFQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8e0f-008kOo-0K;
        Mon, 12 Jun 2023 09:38:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FC1C302E28;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0C29230A58077; Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Message-ID: <20230612093537.693926033@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
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
Subject: [PATCH v3 04/57] kbuild: Drop -Wdeclaration-after-statement
References: <20230612090713.652690195@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the advent on scope-based resource management it comes really
tedious to abide by the contraints of -Wdeclaration-after-statement.

It will still be recommeneded to place declarations at the start of a
scope where possible, but it will no longer be enforced.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Makefile                          |    6 +-----
 arch/arm64/kernel/vdso32/Makefile |    2 --
 2 files changed, 1 insertion(+), 7 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -447,8 +447,7 @@ HOSTRUSTC = rustc
 HOSTPKG_CONFIG	= pkg-config
 
 KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
-			 -O2 -fomit-frame-pointer -std=gnu11 \
-			 -Wdeclaration-after-statement
+			 -O2 -fomit-frame-pointer -std=gnu11
 KBUILD_USERCFLAGS  := $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
 KBUILD_USERLDFLAGS := $(USERLDFLAGS)
 
@@ -1012,9 +1011,6 @@ endif
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc
 
-# warn about C99 declaration after statement
-KBUILD_CFLAGS += -Wdeclaration-after-statement
-
 # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
 KBUILD_CFLAGS += -Wvla
 
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -65,11 +65,9 @@ VDSO_CFLAGS += -Wall -Wundef -Wstrict-pr
                -fno-strict-aliasing -fno-common \
                -Werror-implicit-function-declaration \
                -Wno-format-security \
-               -Wdeclaration-after-statement \
                -std=gnu11
 VDSO_CFLAGS  += -O2
 # Some useful compiler-dependent flags from top-level Makefile
-VDSO_CFLAGS += $(call cc32-option,-Wdeclaration-after-statement,)
 VDSO_CFLAGS += $(call cc32-option,-Wno-pointer-sign)
 VDSO_CFLAGS += -fno-strict-overflow
 VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)


