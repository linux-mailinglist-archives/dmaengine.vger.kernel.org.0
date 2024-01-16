Return-Path: <dmaengine+bounces-736-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D557E82F3B7
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jan 2024 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182B2B21997
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jan 2024 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312E1CD1C;
	Tue, 16 Jan 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q6zTZRse"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE11CD14;
	Tue, 16 Jan 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428625; cv=none; b=ZSQF6qTzqD7QMGU1r1c6T2nr65qeogWwbfomUmuYnrH6cpiHfY/RpQodJ1YaNrMUg77X/uTdTlMGdsOdrO7jewMY4+xZPkqBQVVCef7zykkZnsDAGdVMOW2Q5JhSqXGcW9RiDxTsLVkbilFwYmKvTekinhTf6JB7JeupwzB59+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428625; c=relaxed/simple;
	bh=HKMeSq1CvvR0ifd7kUvkbyWIGnf9TiWo23dGO2t6Rfo=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=MPoORMJYH0RGy7gu277Rw3I3FoUXmYn72sooQ+RP3/nfJEIgks3K504M6tb3tOfwq5Uysx9bGLnMqKEec1LYb27kPhDj2v7NxwrH8daMKKWPwuhCW4KM6zyI7s0CwwntM8ii/0J0yJVK/SMfK7ShCPGolc60hfDnuXZzry81h5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Q6zTZRse; arc=none smtp.client-ip=185.125.188.120
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8B76D3F2D0;
	Tue, 16 Jan 2024 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705428614;
	bh=fyzXUOOEL+zRBN6qGMyB6wL+dhZyv/h6QB3vjt39SE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Q6zTZRseRHutC7xlc7sTWoVotqFPaJ+nTKa0Us8pWOCACIE6GJE7Y6tBUIV/9DS9y
	 9g0hYGxsIrnFBl0yPlxAZOYqUJT3TOZ13VwbQWN6AOVtgQf16n+yKToRw5d5bXvToJ
	 uHpf197MOKXmjdaW6KkVn7hiTmZzP0Gloz7iTFTW2jUNpwX06SN228nqF67ejCWgLx
	 Tu90GgBlHEr6VT7Ru50+Ee2e/49lrwglJikniuldFXpucJpLVBm+egxlAQ4zpDZrC7
	 tUc7N9RsSozlIVrfhhOEFynk7oYPZMSfDNu5SvacJ2SyPDBg7d4Y5l2fyMrEppsojo
	 E3m6nIHb5nwag==
Message-ID: <b26f06ee-9617-4ba2-aa4e-b431407acd7a@canonical.com>
Date: Tue, 16 Jan 2024 10:10:03 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/57] apparmor: Free up __cleanup() name
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
 keescook@chromium.org, gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc: masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
 vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
 longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org, tj@kernel.org,
 cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, paulmck@kernel.org, frederic@kernel.org,
 quic_neeraju@quicinc.com, joel@joelfernandes.org, josh@joshtriplett.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, rientjes@google.com,
 vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 llvm@lists.linux.dev, linux-perf-users@vger.kernel.org, rcu@vger.kernel.org,
 linux-security-module@vger.kernel.org, tglx@linutronix.de,
 ravi.bangoria@amd.com, error27@gmail.com, luc.vanoostenryck@gmail.com
References: <20230612090713.652690195@infradead.org>
 <20230612093537.536441207@infradead.org>
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20230612093537.536441207@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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


