Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9072C542
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjFLM7B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjFLM7A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 08:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027C118;
        Mon, 12 Jun 2023 05:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38909615F9;
        Mon, 12 Jun 2023 12:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5E0C433EF;
        Mon, 12 Jun 2023 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686574738;
        bh=h0kYHlGpKzmyUgUMsdBILkbq2D5vPRBEb+QOfa+0Obw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xoyq3+JCSSepnk4P4cPIXEz5D86lbTa+xSdgzV0PRJyLAFl6Vc6ImdAHH9P3f+q9M
         k2orB793rDEd/KA+p+9gWu+lq6haBao/xSUckcrk5KHzLBDHsXrpx1Vy4A9OqzV+fu
         2QXTw4AiC5eXI94kl416XsQT1Ti7bZ2hhtJVMxOg=
Date:   Mon, 12 Jun 2023 14:58:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
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
Subject: Re: [PATCH v3 46/57] perf: Simplify pmu_dev_alloc()
Message-ID: <2023061226-effective-droplet-1ba3@gregkh>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
 <20230612094400.GG4253@hirez.programming.kicks-ass.net>
 <2023061213-knapsack-moonlike-e595@gregkh>
 <29924c50-cf96-13bb-ef84-4813caa3aef3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29924c50-cf96-13bb-ef84-4813caa3aef3@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 02:29:05PM +0200, Paolo Bonzini wrote:
> On 6/12/23 14:18, Greg KH wrote:
> > Yeah, it's a pain, but you are trying to hand-roll code that is not a
> > "normal" path for a struct device, sorry.
> > 
> > I don't know if you really can encode all of that crazy logic in the
> > cleanup api, UNLESS you can "switch" the cleanup function at a point in
> > time (i.e. after device_add() is successful).  Is that possible?
> 
> What _could_ make sense is that device_add() completely takes ownership of
> the given pointer, and takes care of calling put_device() on failure.

I think we tried that decades ago :)

Problem is that the caller wants to clean stuff up associted with that
struct device-embedded structure _before_ the final put_device() is
called which would usually free the memory of the overall structure.

So device_add() can't call put_device() on the error path within it, you
need the caller to unwind it's local stuff before that happens.

> Then you can have
> 
> 	struct device *dev_struct __free(put_device) =
> 		kzalloc(sizeof(struct device), GFP_KERNEL);
> 
> 	struct device *dev __free(device_del) =
> 		device_add(no_free_ptr(dev_struct));
> 
> 	/* dev_struct is NULL now */
> 
> 	pmu->dev = no_free_ptr(dev);

I don't see how that works properly, what am I missing?

thanks,

greg k-h
