Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227FB72C663
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 15:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjFLNv2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 09:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbjFLNv1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 09:51:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598E310E6
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 06:51:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7f6341bf9so43755775e9.1
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686577884; x=1689169884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZfZnBRmLxwYvjmW1v2T8ybrzxEz4xOvIMacNwWxuQY=;
        b=q8srpqTZqi249xTO00UoduKcB9900iihCnJBYviZpjnNcdxDOGOLcOvGcyeXpFyVod
         oRWQ9jw9+RwSz0a4PaOsX55oAAxEUe5ScpnndPquxYM7ZouNofJi1OGfLB9nsmDnhORg
         Hu0nbFymp+CI9DOUVBw0BgHWrUAjDFXYAInDfjLg6gq6kBCv4TicOOPN2Mti0kpV2ho1
         sYy7doXiFEZVdKy4U8nLe7igR6vQ/Huqu7k1efZN+LrPR0zG/4amnI1omw9ELT/PIIbW
         a7nJnnYhzULtzCIcs6c6YO5dzMMGhVA2KwZ16xR6lIZya74b+SElUKSVv0lqhZPCU+6q
         8Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686577884; x=1689169884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZfZnBRmLxwYvjmW1v2T8ybrzxEz4xOvIMacNwWxuQY=;
        b=diPXZXUS611Nrn0LdEzQnV4JwGpvqotqxxxr3Sc4FzsGhuCJkjjAm2dCzh+9C9vDO1
         rvxTyc6kaxkQ3DxHLbkk4N0kw45U3L0Jckk1dK0FI8OxOMV55KdrXcquNNOFeOw7jiE9
         JsjuEEAUK5awzYp3vn8fS+yUPRyX98xodKoMRMLaOs1Ed5zMs3UJQNxwNwyvgOm7SwXD
         ZrRej1z9vyYGdlk0/1JPHcUik3OJhNHS6I/KNXLu/EEQHortLcgt8fl+OambnMzEhZJV
         0tUp0fW/h/ev2KwJXwRb8o/xe6fz1VYHKvdZr1uxXwAUNeoOm1K1pvF5RoSvFd8aLaPB
         EV2g==
X-Gm-Message-State: AC+VfDyLs2PvsDRp9VQvL4t1gg7fUX8oaH0nbnCwkDUUSWeVkjpJkmZa
        vO/nm4N4H82tSP6HV0j9dSKgrA==
X-Google-Smtp-Source: ACHHUZ6GVEFGGhIbci6My+kOS3R3jCEaFtz2YTtb+Wgw6JjfF+ccwAH2AZFW+ZiFTHh/32+xMVajYQ==
X-Received: by 2002:a05:600c:2299:b0:3f7:e5a0:c5f1 with SMTP id 25-20020a05600c229900b003f7e5a0c5f1mr7101869wmf.32.1686577883770;
        Mon, 12 Jun 2023 06:51:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b003f7ba52eeccsm11531482wmj.7.2023.06.12.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:51:21 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:51:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
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
Subject: Re: [PATCH v3 09/57] sched: Simplify ttwu()
Message-ID: <0012d943-6fd0-4b8d-9ec6-3d02aba75dcc@kadam.mountain>
References: <20230612090713.652690195@infradead.org>
 <20230612093538.076428270@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093538.076428270@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 11:07:22AM +0200, Peter Zijlstra wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3664,16 +3664,15 @@ ttwu_stat(struct task_struct *p, int cpu
>  		__schedstat_inc(p->stats.nr_wakeups_local);
>  	} else {
>  		struct sched_domain *sd;
> +		guard(rcu)();
>  
>  		__schedstat_inc(p->stats.nr_wakeups_remote);
> -		rcu_read_lock();

We can't put the guard(rcu)(); here?  I have unpublished static analysis
which assumes that the first and last statements guarded by a lock are
important.  But if we always put it at the top of the scope then we
lose that information.

>  		for_each_domain(rq->cpu, sd) {
>  			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
>  				__schedstat_inc(sd->ttwu_wake_remote);
>  				break;
>  			}
>  		}
> -		rcu_read_unlock();
>  	}

regards,
dan carpenter

