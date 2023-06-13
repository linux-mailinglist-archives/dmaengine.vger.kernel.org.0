Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68E72E019
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbjFMKuZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjFMKuY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 06:50:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675F2E53;
        Tue, 13 Jun 2023 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t+702YjolGkCyiHa0l6OM91j5GcnA1zXDcpSBa22PVM=; b=cq3oZ+2UUoBW6Ayud8FUtqQcgF
        8Vk9zP7UFBdd1d5LBwQwn2AkLSvaMfko2yWiv9XTV3anXy7DAOSeZQkgyVfeGKfahXGD+fkz+Tt9x
        z2YrKk3GWFF7yvNhzjfGwd7uC2o/8XbL6zOGRyRohwqKELaQOpfHoEiGSrSNfQnPksAkvlXI+zUf2
        dj9Sqph+JWkhUnsUxpvfxI6kDqHqJh5mnoP7BZzMEauf4WABiQTm/JqQV+CwrLy2ZqsJStDi7WZKS
        ntMaSJ9nXSXZMcN0Xi0oz9dUtpl8UdLwensB313mHVTtQ2munRbB6PSLvGJ7IFwV5LUI3Ef3epYcJ
        AVXfP0Aw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q91bK-009L0E-1d;
        Tue, 13 Jun 2023 10:50:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73AFC300322;
        Tue, 13 Jun 2023 12:50:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49B8524556031; Tue, 13 Jun 2023 12:50:13 +0200 (CEST)
Date:   Tue, 13 Jun 2023 12:50:13 +0200
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
Message-ID: <20230613105013.GT4253@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
 <20230612094400.GG4253@hirez.programming.kicks-ass.net>
 <2023061226-grumpily-entire-f06a@gregkh>
 <20230612141322.GA83892@hirez.programming.kicks-ass.net>
 <2023061217-mutable-curry-c2ac@gregkh>
 <20230613073415.GP4253@hirez.programming.kicks-ass.net>
 <2023061333-imposing-shortly-6803@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061333-imposing-shortly-6803@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 13, 2023 at 09:50:28AM +0200, Greg KH wrote:

> > DEFINE_FRERE(class_destroy, struct class *, if (!IS_ERR_OR_NULL(_T)) class_destroy(_T))
> 
> Nit, as class_destroy() handles this type of check within it, it can be
> even simpler:
> 	DEFINE_FREE(class_destroy, struct class *, class_destroy(_T));

Note that that means there will be an unconditional call to
class_destroy() in the success path. As long as that is never a hot-path
this should be fine I suppose, but it is something Linus pointed out
earlier.

> or would that be:
> 	DEFINE_CLASS(class_destroy, struct class *, class_destroy(_T));

Has a slightly different syntax per the comment I did do write :-)

DEFINE_CLASS(class, struct class *,
	     if (!IS_ERR_OR_NULL(_T)) class_destroy(_T),
	     class_create(cname), const char *name)

static int __init misc_init(void)
{
	struct proc_dir_entry *ret __free(remove_proc) =
		proc_create_seq("misc", 0, NULL, &misc_seq_ops);

	CLASS(class, c)("misc");
	if (IS_ERR(c))
		return PTR_ERR(c);

	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
		return -EIO;

	c->devnode = misc_devnode;

	misc_class = no_free_ptr(c);
	no_free_ptr(ret);

	return 0;
}

The no_free_ptr() should work with CLASS(), but I'm not sure that's
recommended, lots of un-explored terretory here :-)

Similarly I suppose you could do something like:

DEFINE_CLASS(proc_dir, struct proc_dir_entry *,
	     proc_remove(_T), proc_create(pname, mode, parent, proc_ops),
	     const char *pname, umode_t mode, struct proc_dir_entry *parent,
	     const struct proc_ops *proc_ops)

EXTEND_CLASS(proc_dir, _seq, proc_create_seq(pname, mode, parent, ops, state_size, data),
	     const char *pname, umode_t mode, struct proc_dir_entry *parent,
	     const struct seq_operations *ops, unsigned int state_size, void *data)

EXTEND_CLASS(proc_dir, _seq_private, .....)

(urgh, C really needs better forwarding support)

Then you could write it something like:

static int __init misc_init(void)
{
	CLASS(proc_dir_seq, ret)("misc", 0, NULL, &misc_seq_ops);

	CLASS(class, c)("misc");
	if (IS_ERR(c))
		return PTR_ERR(c);

	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
		return -EIO;

	c->devnode = misc_devnode;

	misc_class = no_free_ptr(c);
	no_free_ptr(ret);

	return 0;
}

Is what what we want?

(also, perhaps I should prefix the macro arguments with an '_', as is
you can't use 'name' as a constructor argument because the thing would
expand weird)

> I have a ton of future patches coming that does a bunch of
> class_create/destroy changes that would be made a LOT simpler with this
> patchset, and I really don't want to have to hit the same codepaths
> twice if at all possible.
> 
> So what's the odds this can be reasonable enough to get into 6.5-rc1 so
> we can rely on it there?

That's one for Linus I suppose.. the only remaining issue I still have
is the no_free_*() naming. One suggestion that made sense had it called
take_*().

All we really need are the first 4 patches to land; thereafter we can
gradually start converting things.
