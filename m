Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5F272BE40
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 12:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbjFLKCl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 06:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbjFLKAt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 06:00:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66472D7E;
        Mon, 12 Jun 2023 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vha0HB5ydDcFbo3VCXSefJuuYWl20O+Nf7SIjJnvNeQ=; b=q1ZhBNP4qtxvbPwK8aS05ujFQK
        xkM1wyeTQ3b2tZfRkV6hzlRZLK2WCGWfzpzCn0wRiyJp3H7Ts9sjYOFCVde3ips/4fuum90PHqinO
        M38u6Ix5kvN1NYw8MkjBKBg2+hDEKrSSqPFddzyiLZmm63pXYCHOQqlkWJ1x67nr63HMjP3xykqRI
        sU7A3JHj+KtHBxXqhTxhw/430RbtLdz8rGeY7oU3d3OTMSkeZtMe9Bh3MiZ2fpE2LmF32kHmPUqp6
        jTsZdSu59Ry/uDg82NmOZMdQc1qk1q20Ovujft5ZSpk/lJMrSV9h/0CWK+4BJj1j+9sOHvchklMjl
        WkMUbwYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e5h-002OiK-EI; Mon, 12 Jun 2023 09:44:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1116830058D;
        Mon, 12 Jun 2023 11:44:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E658121473307; Mon, 12 Jun 2023 11:44:00 +0200 (CEST)
Date:   Mon, 12 Jun 2023 11:44:00 +0200
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
Subject: Re: [PATCH v3 46/57] perf: Simplify pmu_dev_alloc()
Message-ID: <20230612094400.GG4253@hirez.programming.kicks-ass.net>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093540.850386350@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 11:07:59AM +0200, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |   65 ++++++++++++++++++++++++---------------------------
>  1 file changed, 31 insertions(+), 34 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11285,49 +11285,46 @@ static void pmu_dev_release(struct devic
>  
>  static int pmu_dev_alloc(struct pmu *pmu)
>  {
> +	int ret;
>  
> +	struct device *dev __free(put_device) =
> +		kzalloc(sizeof(struct device), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
>  
> +	dev->groups = pmu->attr_groups;
> +	device_initialize(dev);
>  
> +	dev_set_drvdata(dev, pmu);
> +	dev->bus = &pmu_bus;
> +	dev->release = pmu_dev_release;
>  
> +	ret = dev_set_name(dev, "%s", pmu->name);
>  	if (ret)
> +		return ret;
>  
> +	ret = device_add(dev);
>  	if (ret)
> +		return ret;
>  
> +	struct device *del __free(device_del) = dev;

Greg, I'm not much familiar with the whole device model, but it seems
unfortunate to me that one has to call device_del() explicitly if we
already have a put_device() queued.

Is there a saner way to write this?

>  
> +	/* For PMUs with address filters, throw in an extra attribute: */
> +	if (pmu->nr_addr_filters) {
> +		ret = device_create_file(dev, &dev_attr_nr_addr_filters);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (pmu->attr_update) {
> +		ret = sysfs_update_groups(&dev->kobj, pmu->attr_update);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	no_free_ptr(del);
> +	pmu->dev = no_free_ptr(dev);
> +	return 0;
>  }


