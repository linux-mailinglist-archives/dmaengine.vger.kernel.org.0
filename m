Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A85C72DB81
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 09:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjFMHuk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbjFMHuj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 03:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2556510E9;
        Tue, 13 Jun 2023 00:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9324D61EF0;
        Tue, 13 Jun 2023 07:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E75BC433D2;
        Tue, 13 Jun 2023 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686642631;
        bh=goV8gP/KHbMbiDcM/4DeoeQ71fS5d2keb4GB/l1HI1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjHMiqIgYrYF+L+Wjiij+dvaTaGD/brRW3tDy2aXuD04wH0r41aqKdSqN9sOvWh0x
         xCel0co6I2RgxXNs6fdhwx5nIhmSUNB0GyCSE0HhYV6XJ6/wB0c1ff9QBlPhyR7hpv
         jdIDB9/uE7u61z8T2RC3V6WuiqbKWjqnT8t7+CYg=
Date:   Tue, 13 Jun 2023 09:50:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <2023061333-imposing-shortly-6803@gregkh>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
 <20230612094400.GG4253@hirez.programming.kicks-ass.net>
 <2023061226-grumpily-entire-f06a@gregkh>
 <20230612141322.GA83892@hirez.programming.kicks-ass.net>
 <2023061217-mutable-curry-c2ac@gregkh>
 <20230613073415.GP4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613073415.GP4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 13, 2023 at 09:34:15AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 12, 2023 at 05:44:59PM +0200, Greg KH wrote:
> > To be fair the end-result of misc_init() is much nicer and cleaner and
> > "obviously correct", which is good, even with the crazy proc file mess
> > in it.  So I like the idea overall, need to figure out when to use
> > DEFINE_CLASS() vs. DEFINE_FREE(), that isn't obvious to me.
> 
> CLASS is meant for things that have an obvious contructor as well as a
> destructor, that always go together. Like for example the lock things,
> they always pair a lock and unlock. But also things like:
> fdget()+fdput(), these can also always be paired, and if you want the
> file to escape you simply take yet another reference to prevent the
> fdput() from being the final.

Ok, so then the class_destroy stuff down below here should be
DEFINE_CLASS()?

> > @@ -280,29 +268,24 @@ static char *misc_devnode(const struct device *dev, umode_t *mode)
> >  	return NULL;
> >  }
> >  
> > +DEFINE_FREE(class_destroy, struct class *, if (_T) class_destroy(_T));
> 
> Documentation for class_create() says it will return ERR_PTR(), so then
> this should be something like:
> 
> DEFINE_FRERE(class_destroy, struct class *, if (!IS_ERR_OR_NULL(_T)) class_destroy(_T))

Nit, as class_destroy() handles this type of check within it, it can be
even simpler:
	DEFINE_FREE(class_destroy, struct class *, class_destroy(_T));
or would that be:
	DEFINE_CLASS(class_destroy, struct class *, class_destroy(_T));
?

> > +DEFINE_FREE(remove_proc, struct proc_dir_entry *, if (_T) remove_proc_entry("misc", NULL));
> >  static int __init misc_init(void)
> >  {
> > +	struct proc_dir_entry *ret __free(remove_proc) = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
> > +	struct class *c __free(class_destroy) = class_create("misc");
> >  
> > +	if (IS_ERR(c))
> > +		return PTR_ERR(c);
> >  
> >  	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
> > +		return -EIO;
> >  
> > +	c->devnode = misc_devnode;
> > +
> > +	misc_class = no_free_ptr(c);
> > +	no_free_ptr(ret);
> > +
> > +	return 0;
> >  }
> 
> And yes, this does look nicer.

I have a ton of future patches coming that does a bunch of
class_create/destroy changes that would be made a LOT simpler with this
patchset, and I really don't want to have to hit the same codepaths
twice if at all possible.

So what's the odds this can be reasonable enough to get into 6.5-rc1 so
we can rely on it there?

thanks,

greg k-h
