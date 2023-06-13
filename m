Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3B72DCBF
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 10:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbjFMIjR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbjFMIjG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 04:39:06 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A482FF1;
        Tue, 13 Jun 2023 01:39:03 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2F2DA3F2A3;
        Tue, 13 Jun 2023 08:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686645520;
        bh=wkJrNjdFfolCoIC9MEjZjIPiwFCl2xf4UGf4VNAWiMI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=LVLJUlToyVjIZMeYTDHbVcedRUNFjvJM1V+s+13q6UgbQn0ASwvp0X4yc7bGkfHtw
         VhjqVjTOR9is3Ge0hzhB4Zg7Gdt/Ji2LB4CHd2TmO8A+20qjPGQ1SsqW2dpw77Oog6
         i1VUCugdQ3+3WpD1GKO1V0IqzAoLoosOlosE+w8UO0fWfPLtb8Y1deCbbgbLbJqktw
         0VhCYzdECJJAm9CmWrs/VncJuzS/7DZg7NHI4jNg3y0/a3HPCVSnTZY3oTb8Igo5rw
         c4AhpeqpDwxRf2Bcv84SyRnSXSaVYwXc7dBF90QmO7l1VZTUcPBRFU3V55OC8KCJo1
         C+U+iiL51Pcig==
Message-ID: <4ec84aaa-b1f4-4cd1-bafc-2873dee1bdb8@canonical.com>
Date:   Tue, 13 Jun 2023 01:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 02/57] apparmor: Free up __cleanup() name
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
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
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, llvm@lists.linux.dev,
        linux-perf-users@vger.kernel.org, rcu@vger.kernel.org,
        linux-security-module@vger.kernel.org, tglx@linutronix.de,
        ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
References: <20230612090713.652690195@infradead.org>
 <20230612093537.536441207@infradead.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230612093537.536441207@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 6/12/23 02:07, Peter Zijlstra wrote:
> In order to use __cleanup for __attribute__((__cleanup__(func))) the
> name must not be used for anything else. Avoid the conflict.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/include/lib.h |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/security/apparmor/include/lib.h
> +++ b/security/apparmor/include/lib.h
> @@ -232,7 +232,7 @@ void aa_policy_destroy(struct aa_policy
>    */
>   #define fn_label_build(L, P, GFP, FN)					\
>   ({									\
> -	__label__ __cleanup, __done;					\
> +	__label__ __do_cleanup, __done;					\
>   	struct aa_label *__new_;					\
>   									\
>   	if ((L)->size > 1) {						\
> @@ -250,7 +250,7 @@ void aa_policy_destroy(struct aa_policy
>   			__new_ = (FN);					\
>   			AA_BUG(!__new_);				\
>   			if (IS_ERR(__new_))				\
> -				goto __cleanup;				\
> +				goto __do_cleanup;			\
>   			__lvec[__j++] = __new_;				\
>   		}							\
>   		for (__j = __count = 0; __j < (L)->size; __j++)		\
> @@ -272,7 +272,7 @@ void aa_policy_destroy(struct aa_policy
>   			vec_cleanup(profile, __pvec, __count);		\
>   		} else							\
>   			__new_ = NULL;					\
> -__cleanup:								\
> +__do_cleanup:								\
>   		vec_cleanup(label, __lvec, (L)->size);			\
>   	} else {							\
>   		(P) = labels_profile(L);				\
> 
> 

