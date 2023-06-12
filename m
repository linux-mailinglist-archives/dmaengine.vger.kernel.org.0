Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE372CD6F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 20:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjFLSES (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjFLSER (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 14:04:17 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D6E67;
        Mon, 12 Jun 2023 11:04:15 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f86b426371so1263311cf.2;
        Mon, 12 Jun 2023 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686593055; x=1689185055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APHh3Nys4coEeSeVUj0oYbJvBI1pNrqCMzlNnyXighg=;
        b=RlK7II8xo4KN6uK+P4qhzADQcHADQU0gppNv539F+MhnKzEzKl8kGFT+Ezt4JxpxNz
         7H/6mXli4RYeNG3JvnaHG+6pEY+/L6AhxTll8ico20yxchoZKOUg1s/qwQHyEtGLYNaO
         CNIbdTO9hw6Mw6K0vzpoGDrUVcJOk6ebSmTL3/UxyfZalzNQPwzXkRbh72etZAQhjUmt
         kKoWtLNSO+hisLiT3gnrY0zT1UN0bfHj8ag59Bdg3pzucOp/IyNtNhAlGiE+1zs0pW1P
         SZQh8VyJa716lOLNnSBr5pFjltIYIowqnN2V9u9zM1TffiEnQ85BHYxD+NJBxpC9ikoN
         ev8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593055; x=1689185055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APHh3Nys4coEeSeVUj0oYbJvBI1pNrqCMzlNnyXighg=;
        b=UfTX+TRyDPbCGtFKRB56ZIIoG7hARKg8AaFvzHR7lJ/Y1wrtBfQJnRXU8fs20JuW0G
         iVqoD0f7H4jMWP5SlGo7jVZ0MbsD2VaqKfmlnyCbCK6q1tLNj4/e1SnBuA7IpvDOasvn
         80+aixYy2KwlkF+of1if08GW/ScxVgxKktyRI61c3IwWOtdMqmO/3eaf1/7ZREPtwj6G
         pJ+swxkhOi1edPlorRL5M5XxJUIMWEYJcEbPZDIujgd1LOtcNI1FObFjL29yxRrphpyf
         Acjknf33Ri7GkfgH2eTrCkOQxdkZmQlWDjDM6HkFRRvzgv2wGEeGyJbvOIOIt6kdaoMN
         4E2Q==
X-Gm-Message-State: AC+VfDy0gUAjH1dlou8oiRrgwx7736F5hOXLrApuA3ISjSFptlnNfXCc
        MEH37jB3nTHYNDHBadam9Hb7lDOkn3ueog==
X-Google-Smtp-Source: ACHHUZ7ML49zNQagpfER6wDv/GUGVjh5/MoH60xXGePMiPJtC5YbXkHtPnkF3gTHEwLccMuOTIpyow==
X-Received: by 2002:a05:622a:1aa9:b0:3f6:b1ad:97e with SMTP id s41-20020a05622a1aa900b003f6b1ad097emr13458092qtc.7.1686593055052;
        Mon, 12 Jun 2023 11:04:15 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v6-20020ac87286000000b003f9baa693c7sm3559182qto.10.2023.06.12.11.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:04:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id F0CAF27C005B;
        Mon, 12 Jun 2023 14:04:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 12 Jun 2023 14:04:14 -0400
X-ME-Sender: <xms:G16HZMNVqrczWrJlBmlnmqA_k3VHCkZKlMPdezVbzttdNLWyMeO7AA>
    <xme:G16HZC_STa5f_J1Ybm3vIOtNUX_iLnkPp03GgxwojQJDKxWUBr_Q46NhzKb6vWa5r
    -nornpYBqdvPEKyjA>
X-ME-Received: <xmr:G16HZDQQrZ5x6VPJNoKo17C11asfBTkCA-eOYIgUM-UuAnY6m9Ho6o41wZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:G16HZEsKElmlwO8YuPshs7AS1ebBAVUXDJnxxwDMfVVRxRO3KKyrbw>
    <xmx:G16HZEeIVeVKGtqa1UMPTB_17IzjM2rVfekKaW8Fhyyyk4iJPLKq4A>
    <xmx:G16HZI1sNTLC6pSjNuJVN7hWHveas8tMSgvQ6XiG4SAK3POvuTV5Ng>
    <xmx:HV6HZCDb8rZpMmG2YODQuMZ_Pvj-i2G7rXcV5Kybq1j8UczScNQIKdIYfb0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 14:04:10 -0400 (EDT)
Date:   Mon, 12 Jun 2023 11:02:28 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        mingo@redhat.com, longman@redhat.com, dennis@kernel.org,
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
Subject: Re: [PATCH v3 08/57] sched: Simplify wake_up_if_idle()
Message-ID: <ZIddtMiTj8Kktq1z@boqun-archlinux>
References: <20230612090713.652690195@infradead.org>
 <20230612093537.977924652@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093537.977924652@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 11:07:21AM +0200, Peter Zijlstra wrote:
> Use guards to reduce gotos and simplify control flow.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  |   20 ++++++--------------
>  kernel/sched/sched.h |   15 +++++++++++++++
>  2 files changed, 21 insertions(+), 14 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3872,21 +3872,13 @@ static void __ttwu_queue_wakelist(struct
>  void wake_up_if_idle(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
> -	struct rq_flags rf;
>  
> -	rcu_read_lock();
> -
> -	if (!is_idle_task(rcu_dereference(rq->curr)))
> -		goto out;
> -
> -	rq_lock_irqsave(rq, &rf);
> -	if (is_idle_task(rq->curr))
> -		resched_curr(rq);
> -	/* Else CPU is not idle, do nothing here: */
> -	rq_unlock_irqrestore(rq, &rf);
> -
> -out:
> -	rcu_read_unlock();
> +	guard(rcu)();
> +	if (is_idle_task(rcu_dereference(rq->curr))) {
> +		guard(rq_lock)(rq);

We assume that irq must be disabled when this function called?
Otherwise, I don't understand why this is not

	guard(rq_lock_irqsave)(rq);

?

Regards,
Boqun

> +		if (is_idle_task(rq->curr))
> +			resched_curr(rq);
> +	}
>  }
>  
>  bool cpus_share_cache(int this_cpu, int that_cpu)
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1678,6 +1678,21 @@ rq_unlock(struct rq *rq, struct rq_flags
>  	raw_spin_rq_unlock(rq);
>  }
>  
> +DEFINE_LOCK_GUARD_1(rq_lock, struct rq,
> +		    rq_lock(_T->lock, &_T->rf),
> +		    rq_unlock(_T->lock, &_T->rf),
> +		    struct rq_flags rf)
> +
> +DEFINE_LOCK_GUARD_1(rq_lock_irq, struct rq,
> +		    rq_lock_irq(_T->lock, &_T->rf),
> +		    rq_unlock_irq(_T->lock, &_T->rf),
> +		    struct rq_flags rf)
> +
> +DEFINE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
> +		    rq_lock_irqsave(_T->lock, &_T->rf),
> +		    rq_unlock_irqrestore(_T->lock, &_T->rf),
> +		    struct rq_flags rf)
> +
>  static inline struct rq *
>  this_rq_lock_irq(struct rq_flags *rf)
>  	__acquires(rq->lock)
> 
> 
