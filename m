Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A305A72DB08
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 09:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbjFMHe0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 03:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjFMHeY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 03:34:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8D10F7;
        Tue, 13 Jun 2023 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tAKolwLuXUR1D5yD/hL0f+kZnHou+PxeYU9aqGSZlgk=; b=PJ7DjtI5p9Scuhe88BpMQDomP0
        MKCJntJTn1U+Rd2ZhV3FQnt6v8jDArMbzoUNSNBw22KQvf4WZts+aU5TsuEO6LVgTBI9Lt5J5/tRM
        J8ziNRHbscTBejaoYpXuU/l3qPuKSjn5T8wVUN8+JYdj713tuMnbHx+7gbgAdsmA8wZ38wg4ht6m7
        i0+jX0ZKdElRGA4MizB5sMdH1s4BRkSbqJI4EUQFv5UwmALAHg55ZjQOv7/wSBKbBTi1uFQEMjskS
        A/QCcZxrSOjGP5FrTd8O11G3S61ZxvJCh2x57TVAqR8kGkTdhlP7MuYlgXagHdz4r3FYQqRS+YNsG
        xU47uqLA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8yXh-003ev7-B0; Tue, 13 Jun 2023 07:34:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C1E9300322;
        Tue, 13 Jun 2023 09:34:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB9FC262C92A1; Tue, 13 Jun 2023 09:34:15 +0200 (CEST)
Date:   Tue, 13 Jun 2023 09:34:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
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
Subject: Re: [PATCH v3 46/57] perf: Simplify pmu_dev_alloc()
Message-ID: <20230613073415.GP4253@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
 <20230612094400.GG4253@hirez.programming.kicks-ass.net>
 <2023061226-grumpily-entire-f06a@gregkh>
 <20230612141322.GA83892@hirez.programming.kicks-ass.net>
 <2023061217-mutable-curry-c2ac@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061217-mutable-curry-c2ac@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 05:44:59PM +0200, Greg KH wrote:

> Then in the last part of the file, I abuse the DEFINE_FREE() to handle a
> special case of removing a proc file if things go bad (and add a
> DEFINE_FREE() for class_destroy(), which should go into
> include/device/class.h.
> 
> I've only test-built it, but is this the proper use of DEFINE_FREE()?
> There wasn't much documentation :)

Yes, this looks right.

> To be fair the end-result of misc_init() is much nicer and cleaner and
> "obviously correct", which is good, even with the crazy proc file mess
> in it.  So I like the idea overall, need to figure out when to use
> DEFINE_CLASS() vs. DEFINE_FREE(), that isn't obvious to me.

CLASS is meant for things that have an obvious contructor as well as a
destructor, that always go together. Like for example the lock things,
they always pair a lock and unlock. But also things like:
fdget()+fdput(), these can also always be paired, and if you want the
file to escape you simply take yet another reference to prevent the
fdput() from being the final.

> Also, you can't put a DEFINE_FREE() within a function declaration, which
> I guess makes sense, but the build warning is very odd when you attempt
> it, mentioning an "invalid storage class".  Is that supposed to be able
> to work?

No, DEFINE_FREE() and DEFINE_CLASS() end up defining a bunch of inline
functions, which can't be done inside another function.

If only C would have lambda functions ... alas.

> @@ -280,29 +268,24 @@ static char *misc_devnode(const struct device *dev, umode_t *mode)
>  	return NULL;
>  }
>  
> +DEFINE_FREE(class_destroy, struct class *, if (_T) class_destroy(_T));

Documentation for class_create() says it will return ERR_PTR(), so then
this should be something like:

DEFINE_FRERE(class_destroy, struct class *, if (!IS_ERR_OR_NULL(_T)) class_destroy(_T))

> +DEFINE_FREE(remove_proc, struct proc_dir_entry *, if (_T) remove_proc_entry("misc", NULL));
>  static int __init misc_init(void)
>  {
> +	struct proc_dir_entry *ret __free(remove_proc) = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
> +	struct class *c __free(class_destroy) = class_create("misc");
>  
> +	if (IS_ERR(c))
> +		return PTR_ERR(c);
>  
>  	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
> +		return -EIO;
>  
> +	c->devnode = misc_devnode;
> +
> +	misc_class = no_free_ptr(c);
> +	no_free_ptr(ret);
> +
> +	return 0;
>  }

And yes, this does look nicer.
