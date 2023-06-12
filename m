Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE372C8EA
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 16:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjFLOrA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbjFLOq6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 10:46:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2325CC3
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 07:46:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f61530506aso46056715e9.1
        for <dmaengine@vger.kernel.org>; Mon, 12 Jun 2023 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686581213; x=1689173213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6aoplpG2x3NvMW0KrqThwgqpWyRdB+MusqYxUHLi6I=;
        b=dtMz/QN1CYDOXQu612tba/JwgKtA/+AuFMoJtVfDnmblF2dgFwXikdReeoXW35v1Zd
         +50Q2WOSFuw/fcaN8dbMv35r5SHWWSW4PrQGK+6wxKFEErwFvEVp9V8nCPLxLwesIhQr
         WEdF8glEoUs66sKTgE0D4afL24VuHMWTM9lpMFXE/DRX8IOYigrPJeLBymUn1Hal9dlD
         r2K5G67fgqTNX19dmMcos/Kv7RcWobeswS2CAFr1YsO8TJ6qT6tUcJyGfHKzkwhJHLBK
         vSIP3C7g/VM6N5T8xER37M9c1wJYZprjZ0GX5pUGBX/zTDXLNGqPr2QTGnH0Rh3RjGJB
         tUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686581213; x=1689173213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6aoplpG2x3NvMW0KrqThwgqpWyRdB+MusqYxUHLi6I=;
        b=a/08FyqB0d9cAD/sWDi0E4Icbc9q0WOpbDwl6rMxqCEi0DX/CxqV6ih0w6rE86bUuG
         yivoExE1CF/CD1SxQQ7EM0N4zggXG0SlxkVk9HQaHK5iuKxU5A3sEWCO7m5vF/Sa8zEG
         m7wBS5ptcWkqoQlpx7xzkLF89+kXG1tOOwf0LVZ49E+ZuY1T+fvm+LhVbNHN0b6leiue
         NxuECkdG8YgQtEdFwAT53vuWyjabhF92/mpFzVQUVbM3KpaaqTsBuH8bV9HOzv/xtKRR
         FjTCOB2lIV5oVQ/yt3YnAtYUgm/VTzlPRC7ec8yoxj+E3LuvDRuHlfRJ+RMg5Y0WO2nm
         Mutw==
X-Gm-Message-State: AC+VfDzdKxWvipNdNRIrnLwzkQHJTpQRxb2VsZEo277pZIaFUY7Szg1O
        dnOHgbmJR5zVhJFmSjv8rtP0lg==
X-Google-Smtp-Source: ACHHUZ63nbk/eM9v9k5sduxB02wD7D7/aRDS/9wQD+tlE2DuPOPAwMPZwxopNt+s1fAYfP16HkiUEw==
X-Received: by 2002:a05:600c:2147:b0:3f4:16bc:bd19 with SMTP id v7-20020a05600c214700b003f416bcbd19mr7514861wml.23.1686581213305;
        Mon, 12 Jun 2023 07:46:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003f8140763c7sm6510830wml.30.2023.06.12.07.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:46:51 -0700 (PDT)
Date:   Mon, 12 Jun 2023 17:46:47 +0300
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
Subject: Re: [PATCH v3 26/57] perf: Simplify event_function*()
Message-ID: <1cbdae4a-d6ad-4dd8-aa75-9e226c4416fe@kadam.mountain>
References: <20230612090713.652690195@infradead.org>
 <20230612093539.371360635@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093539.371360635@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 11:07:39AM +0200, Peter Zijlstra wrote:
> @@ -224,17 +243,15 @@ static int event_function(void *info)
>  	int ret = 0;
>  
>  	lockdep_assert_irqs_disabled();
> +	guard(perf_ctx_lock)(cpuctx, task_ctx);
>  
> -	perf_ctx_lock(cpuctx, task_ctx);
>  	/*
>  	 * Since we do the IPI call without holding ctx->lock things can have
>  	 * changed, double check we hit the task we set out to hit.
>  	 */
>  	if (ctx->task) {
> -		if (ctx->task != current) {
> -			ret = -ESRCH;
> -			goto unlock;
> -		}
> +		if (ctx->task != current)
> +			return -ESRCH;
>  
>  		/*
>  		 * We only use event_function_call() on established contexts,
> @@ -254,8 +271,6 @@ static int event_function(void *info)
>  	}
>  
>  	efs->func(event, cpuctx, ctx, efs->data);
> -unlock:
> -	perf_ctx_unlock(cpuctx, task_ctx);
>  
>  	return ret;


We can change this to a return 0; and get rid of the "ret" variable.

regards,
dan carpenter

