Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32F572CEA8
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 20:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjFLSoO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 14:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFLSoN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 14:44:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92519184;
        Mon, 12 Jun 2023 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DfpkQU/ATTdj8SQ8S2sycjFTHz0K1T3h41EdnH1FLuQ=; b=A2P3J1t+kFU71LJhv8EYFdMWC4
        T5bWxDAMk4Zh6Ks3vN3nx/A/JGUVHTwElYJUZNilKGcMUm2/wKmIGvvQhZbLEeJmxCLwQb7JgKEFo
        oe1Te5CWVP6D6Jd3D3BGxKIF5pHAKMWd0vocfR0UMPLHIGk4YW8LfF3onsgabmKUOz7IIXuZ9tVXA
        DraFcLoaxsDxn2EMMxzeSqA3NFNVMbrPlCrT3g+7yCksa52VYLaJ6TQyQGxSTbuYLK18U0h5TAbUp
        8Cc/c/PVbaGDnEQepe44h7OZsm2Tojs6bv9jwHMIpDa8+Cm2MNM3pUHP5H2SkF05k7TkZLbAV9Aoa
        h7Xkpfhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8mWL-008yMw-1F;
        Mon, 12 Jun 2023 18:44:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6BFA30058D;
        Mon, 12 Jun 2023 20:44:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 999F420D70605; Mon, 12 Jun 2023 20:44:03 +0200 (CEST)
Date:   Mon, 12 Jun 2023 20:44:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH v3 33/57] perf: Simplify perf_adjust_freq_unthr_context()
Message-ID: <20230612184403.GE83892@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093539.895253662@infradead.org>
 <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 09:27:09AM -0700, Linus Torvalds wrote:

> The thing does not not go out of scope when the loop *iterates*.
> 
> It only goes out of scope when the loop *ends*.

> Or have I mis-understood something completely?

I tried this before I used it and variables inside a for() loop have a
scope of a single iteration.


$ gcc -O2 -o guard guard.c && ./guard
spin_lock
ponies
__raw_spin_lock_irqsave
can haz
raw_spin_unlock_irqrestore
mutex_lock
mutex_unlock
mutex_lock
mutex_unlock
mutex_lock
mutex_unlock
mutex_lock
mutex_unlock
mutex_lock
mutex_unlock
spin_unlock



---
#include <stdio.h>
#include <stdbool.h>

typedef struct {
} raw_spinlock_t;

typedef struct {
} spinlock_t;

typedef struct {
} mutex_t;

void raw_spin_lock(raw_spinlock_t *)
{
	printf("%s\n", __FUNCTION__);
}

void raw_spin_unlock(raw_spinlock_t *)
{
	printf("%s\n", __FUNCTION__);
}

unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
{
	printf("%s\n", __FUNCTION__);
	return 0;
}
#define raw_spin_lock_irqsave(lock, flags) \
	flags = __raw_spin_lock_irqsave(lock)

void raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
{
	printf("%s\n", __FUNCTION__);
}

void spin_lock(spinlock_t *)
{
	printf("%s\n", __FUNCTION__);
}

void spin_unlock(spinlock_t *)
{
	printf("%s\n", __FUNCTION__);
}


void mutex_lock(mutex_t *)
{
	printf("%s\n", __FUNCTION__);
}

void mutex_unlock(mutex_t *)
{
	printf("%s\n", __FUNCTION__);
}

#define DEFINE_LOCK_GUARD(_type, _Type, _Lock, _Unlock, ...)			\
typedef struct {								\
	_Type *lock;								\
	__VA_ARGS__								\
} lock_guard_##_type##_t;							\
										\
static inline void lock_guard_##_type##_cleanup(void *_g)	\
{										\
	lock_guard_##_type##_t *_G = _g; \
	if (_G->lock) \
	_Unlock;								\
}										\
										\
static inline lock_guard_##_type##_t lock_guard_##_type##_init(_Type *lock)	\
{										\
	lock_guard_##_type##_t _g = { .lock = lock }, *_G = &_g;		\
	_Lock;									\
	return _g;								\
}

DEFINE_LOCK_GUARD(raw,   raw_spinlock_t,
		  raw_spin_lock(_G->lock),
		  raw_spin_unlock(_G->lock)
		  )

DEFINE_LOCK_GUARD(spin,  spinlock_t,
		  spin_lock(_G->lock),
		  spin_unlock(_G->lock)
		  )

DEFINE_LOCK_GUARD(mutex, mutex_t,
		  mutex_lock(_G->lock),
		  mutex_unlock(_G->lock)
		  )

DEFINE_LOCK_GUARD(raw_irqsave, raw_spinlock_t,
		  raw_spin_lock_irqsave(_G->lock, _G->flags),
		  raw_spin_unlock_irqrestore(_G->lock, _G->flags),
		  unsigned long flags;
		 )

#define __cleanup(func) __attribute__((__cleanup__(func)))

#define lock_guard(_type, _name, _ptr) \
	lock_guard_##_type##_t _name __cleanup(lock_guard_##_type##_cleanup) = \
	lock_guard_##_type##_init(_ptr)

#define lock_scope(_type, _ptr) \
	for (struct { lock_guard_##_type##_t guard ; bool done; } _scope __cleanup(lock_guard_##_type##_cleanup) = \
	     { .guard = lock_guard_##_type##_init(_ptr), .done = false }; \
	     !_scope.done; _scope.done = true)

raw_spinlock_t raw_lock;
spinlock_t lock;
mutex_t mutex;

void main(void)
{
	lock_guard(spin, guard, &lock);
	printf("ponies\n");
	lock_scope(raw_irqsave, &raw_lock) {
		printf("can haz\n");
	}

	for (int i=0; i<5; i++) {
		lock_guard(mutex, foo, &mutex);
		continue;
	}
}
