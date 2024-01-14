Return-Path: <dmaengine+bounces-735-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA882CFE3
	for <lists+dmaengine@lfdr.de>; Sun, 14 Jan 2024 07:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B0282EB8
	for <lists+dmaengine@lfdr.de>; Sun, 14 Jan 2024 06:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB5E1848;
	Sun, 14 Jan 2024 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiyISdCs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0D1845;
	Sun, 14 Jan 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5986f790b64so3432280eaf.3;
        Sat, 13 Jan 2024 22:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705214947; x=1705819747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXgb9X1CWd/PEEQiac+jZy6kkV3an6+pNU+vSf7jMVI=;
        b=LiyISdCs3fD+7m62L5S5+fbs0UPIU25tvZgvcIRFlMQot8KJAeeiCI4vFGwREbT/Ch
         odMftOR4WszV41tu6ULVVg8ZhxvDaBM70j8u+SmafTSfqUoJJ4eza4cTcII1IbdlkVex
         ns+w9wxNij+MMg/82A+zEFS09L6o4hIiFKmb4PRI374DuLlWz55OseUJMYJT9XhcBxvZ
         UM5sCfUMSHcX2m3bBhjbdjAvGmqMjozqo8Y4ZwFzQuBd5Tf+ZJsLTwq9U35IKTKNfaQC
         P2zbEgOA5KEifZz3nmPWFbUH/t06WdXRIsZ7CUvj/ODzsESMaBRsWfRR/77YQ9VkkkG1
         QnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705214947; x=1705819747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXgb9X1CWd/PEEQiac+jZy6kkV3an6+pNU+vSf7jMVI=;
        b=gzqbGqYnG1QkISJD0H0EQf4qPGfO9zYcaVhABCYs87AXj5uVY+9YZS2ZD32mb/EeF9
         yS5lFoUiNoZq/ulvLotdfd4Kjb+NhtkjjWT/Bdj1+VGmYWRMgcicjlrqsU3bv1Jbe+x6
         K+1z1q07PoIx+QLBaMJGIcitWjG+/h79+j+eRWr+kJua+GhIfv7Rmc1HW5qkv1PergTu
         hFkf5roGsFuLFor4k4BG4Q36d2dNoTpi3gtlEO7w3JchVfvrdwuH+ZPB91tUgAzaSxGM
         TYaZJilzbCQZIUcNatfZw/LXdzDjttAEfhfj07s49JwnsjdoN9FcZKFN6J3R+MWP2U/C
         m8HA==
X-Gm-Message-State: AOJu0YxKoAgfmWNnRCJgyFTrKG4dx6Z0FrYMWxvQp/W0p6mg/wrOr3gC
	SdhMJu2DPzs/a2g2XEJ8lZs=
X-Google-Smtp-Source: AGHT+IF+BhC+uyf16yTJ+jUA9mpcMjuWd8QqAGGlDxYx1+oguvtkEI4G6Be+ISFZ+jyWpVAJfh2wPQ==
X-Received: by 2002:a05:6358:9fb0:b0:175:a9ce:e69c with SMTP id fy48-20020a0563589fb000b00175a9cee69cmr16814rwb.44.1705214947397;
        Sat, 13 Jan 2024 22:49:07 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:d314:4131:10f8:370e])
        by smtp.gmail.com with ESMTPSA id sn15-20020a17090b2e8f00b0028bd303dc58sm7292213pjb.11.2024.01.13.22.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 22:49:06 -0800 (PST)
Date: Sat, 13 Jan 2024 22:49:01 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, keescook@chromium.org,
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
	john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
	tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
	luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v3 03/57] locking: Introduce __cleanup() based
 infrastructure
Message-ID: <ZaOD3UWFppRDJ6bs@google.com>
References: <20230612090713.652690195@infradead.org>
 <20230612093537.614161713@infradead.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093537.614161713@infradead.org>

Hi Peter,

On Mon, Jun 12, 2023 at 11:07:16AM +0200, Peter Zijlstra wrote:
>  
> +DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
> +DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))

I got excited with the ability to have mutexes released automatically,
however the code I work with typically uses mutex_lock_interruptible()
and friends, where resource acquisition may fail. Additionally, the
return values are integers and not pointers, which makes them unsuitable
for something like

	struct mutex *guard __free(mutex) = mutex_lock_interruptible(...);

I guess we could make wrappers around mutex_lock...() family to return
either the mutex or ERR_PTR-encoded error, but that feels quite ugly.

Do you have any suggestions here?

Thanks.

-- 
Dmitry

