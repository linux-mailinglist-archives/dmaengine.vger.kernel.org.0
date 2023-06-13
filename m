Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828C772E02D
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 12:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbjFMKzl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 06:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbjFMKzb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 06:55:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C10E55;
        Tue, 13 Jun 2023 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GMlksJ5muipLr0Ufss/WSswgj2qownE6HhlJFXhcXlg=; b=a9KFFt6X10FXGv2kIkzGTnsIDj
        S2hxVxvC8y8yY6vRCgKbQfTumoiC2Oi7IJwPadzTHPYYf03jUD8rOFcDArJSDmBaTe6ch7rcWPyXk
        AsuHe3FVpF/zX4yh2hTjPst2Z10wtAhlIFHZXwxwG+eOnp7l7eF7LHqUA5i/bqDVB9ymIzf2gcUeI
        kujQ8iw8VK2/CQuvfEZRuamzJFGghTqyOI/u4HLE/P+lv1uloNQuptF94XXv6GyVyvIm+QV/aBRZ/
        LAViy+/LWhi/rAzC8CXHv7awdkWevYiOY17Nv7Zy4O020FOryv2Bfghhni3m1pZ8hc7XXPmwM2VfD
        5Ece5izQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q91gJ-003oTx-3o; Tue, 13 Jun 2023 10:55:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA072300322;
        Tue, 13 Jun 2023 12:55:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D05424556032; Tue, 13 Jun 2023 12:55:22 +0200 (CEST)
Date:   Tue, 13 Jun 2023 12:55:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
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
Subject: Re: [PATCH v3 03/57] locking: Introduce __cleanup() based
 infrastructure
Message-ID: <20230613105522.GU4253@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093537.614161713@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093537.614161713@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 11:07:16AM +0200, Peter Zijlstra wrote:

> --- /dev/null
> +++ b/include/linux/cleanup.h
> @@ -0,0 +1,167 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_GUARDS_H
> +#define __LINUX_GUARDS_H
> +
> +#include <linux/compiler.h>
> +
> +/*
> + * DEFINE_FREE(name, type, free):
> + *	simple helper macro that defines the required wrapper for a __free()
> + *	based cleanup function. @free is an expression using '_T' to access
> + *	the variable.
> + *
> + * __free(name):
> + *	variable attribute to add a scoped based cleanup to the variable.
> + *

	no_free_ptr(var):
	  like a non-atomic xchg(var, NULL), such that the cleanup
	  function will be inhibited -- provided it sanely deals with a
	  NULL value.

> + * return_ptr(p):
> + *	returns p while inhibiting the __free().
> + *
> + * Ex.
> + *
> + * DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
> + *
> + *	struct obj *p = kmalloc(...);

That should obviously have been:

	struct obj *p __free(kfree) = kmalloc(...);

> + *	if (!p)
> + *		return NULL;
> + *
> + *	if (!init_obj(p))
> + *		return NULL;
> + *
> + *	return_ptr(p);
> + */
> +
> +#define DEFINE_FREE(name, type, free) \
> +	static inline void __free_##name(void *p) { type _T = *(type *)p; free; }
> +
> +#define __free(name)	__cleanup(__free_##name)
> +
> +#define no_free_ptr(p) \
> +	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
> +
> +#define return_ptr(p)	return no_free_ptr(p)
