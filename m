Return-Path: <dmaengine+bounces-6346-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD251B41D1B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90227B20AC
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC1D2FC008;
	Wed,  3 Sep 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vL75vSz2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433A2FB97A
	for <dmaengine@vger.kernel.org>; Wed,  3 Sep 2025 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898987; cv=none; b=NKJx8Zcrfai7WuFeamkHlnqpAvZJz204RfgPJR/g8rGQ5KvurCL/KJGjuTy5+RuyVJNkM9mkpKRcyt9PLa5syPwdUpHGiefjVGHeDELhxPC2fRpTDFZ6fV2eLKpCVsvLE4l232Tj1u7VW2JMisGHv0YUMO3styCe+NhsAhHeWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898987; c=relaxed/simple;
	bh=rw6wz5NQOjq/EnuLbRuHaXalQE2Zm2+zEhNAEkliz2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtTZcMEOw4nEV6TXxqwOz0kGdUZ+TaDAgqLqyPPyhjj9+T2jBeQj+BDFO3BC2rAKPpl1oemBRwLxAmWQlfCvnCsDdrgmDLT69XknbMIjcPVQ7Zn2XgAMRjWW0uZ+BNM8uhbg31VFEPjTuiTONy1I6QNc+56WvguG+MP36nJdMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vL75vSz2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so2881435e9.0
        for <dmaengine@vger.kernel.org>; Wed, 03 Sep 2025 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756898984; x=1757503784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PN4TTv5XFjvH830QyUEf+r/ZdvnpoSsJPrnKjY9Ngm8=;
        b=vL75vSz2c0myBl1dc5M9huymA4an+KUk9HO5pbkqVVCW28TbH+fY4FGTJRULIfgoL5
         ny/qEHN8ZF93JQATeRhLY1OQGG/vJzAqbS/HV07toSHBfTrgfjW2vPb1j2XTdpT4JBac
         icJnCKOE816f7XpB67LTg118PTM1dXAZnloJ5jY+XTdX4dfOBzZ0WKLz+AnD0HCN8/CQ
         1lHpsoeCKRHPNMFMIUEO5H9JewbtQqn5ZPLfMMlxFdGs1Lsi9AxGLAZ8EObtYJgHGKtV
         Hr+5FHZH0liT4HpPcURBbcRu1uDCBpnymAYJt6ABxAIXnqrymUlUuDJrGxi2PJ2KhjyZ
         gcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898984; x=1757503784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN4TTv5XFjvH830QyUEf+r/ZdvnpoSsJPrnKjY9Ngm8=;
        b=sdaXSokOymzk5R904/VPFi0ys4YZPbmvjXWnWBC3tJhU843HRFbQ7xJc3smqm/D4oe
         gYkZfy9Z4YbWfnebx2+aXhM76iuhKSyd4NEfyY9pNX9PyFOQqGEZ78XxxUpCW298vLJH
         zO4bia8wd6zhN///tmDML8PsAmUCAoI+/o5/yx5mx+J2dkP6DuXd9+WU7JsDGuwejT7O
         R+lTPeMfOw9AVKq9PF6i3zTf7gGcKPGr0e14/is46FSMkCfMqXLpElvRHQljqFFMvbAN
         5K8TIRzlJmaTStaqEzwJULWqVsOEpUP7+VuEhlaIZdW6/AIlqCh8tWsdNB0HFH2vR1SC
         dN7g==
X-Forwarded-Encrypted: i=1; AJvYcCUXz15knNQBPdsN4YkqKUVBjFbjg3hUXpvkKkkmDRbVIH10EQ8NUZA/X5EB2SS5fE7eI36DlG1vyOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMcDwF1RSkunJpqUgj8L7+3LXWwstLMlWqEVu78XNynGkyFe2
	b8kUqQu7hXyk7mp35X8D6CA3+eru76ja4gne7oOAYtkf7LlRFsd/HjGHEONWWlHuJvw=
X-Gm-Gg: ASbGncuY+5ip/Gw7levrYrpy80lMkBstcUlBXljVH+l6b7lU8f4XIw9gQCumHMAHdtC
	/TCIq7reH9qNBF60hMBxkQSZ+Bqwj+oISlGYqrK2Cz8LahOImwhiFzGdvG2KZOGt9btqGf08giV
	EYGigzfcoew1aV7m8rW2a/mdObm5JfGIRlqIrijEQDyRI50LGResJMwaYcZvMC/e7NxCa1Dm3oJ
	BUQtq3PdRsIJ9gsupnW0N7Jrkdvnm004EWTuokWTDLlP7SEGX1aLV4VCPtZsmOZHr/yIdO5+OQy
	pGyxPHPdQiV81Mov5f+qjBeSIoKlHSFUcuh/Pk6JrdWNvBWlYdmvxNiRzNRMa607m+N7Hq6DxzI
	L/1edOgcmvmectOUANojShEByFr4vsk7phOgPGA==
X-Google-Smtp-Source: AGHT+IGznYf+8MTlpk6cstRn1GL4tnhUVJ7amBoJ4nIX9Yue18MyS1rMtXsRUivUxsPxvksXGxAf7w==
X-Received: by 2002:a05:600c:1f08:b0:45b:765a:a8ff with SMTP id 5b1f17b1804b1-45b855333e7mr131969965e9.11.1756898983980;
        Wed, 03 Sep 2025 04:29:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e886619sm233540675e9.15.2025.09.03.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:29:43 -0700 (PDT)
Date: Wed, 3 Sep 2025 14:29:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: clang-built-linux <llvm@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Vinod Koul <vkoul@kernel.org>, Guodong Xu <guodong@riscstar.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250903 x86_64 clang-20 allyesconfig mmp_pdma.c:1188:14:
 error: shift count >= width of type [-Werror,-Wshift-count-overflow]
Message-ID: <aLgmpIlcBxH3klYp@stanley.mountain>
References: <CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com>

This seems like a clang-20 bug.  It's complaining about an impossible shift
in code which it should know is dead.

regards,
dan carpenter

On Wed, Sep 03, 2025 at 03:38:11PM +0530, Naresh Kamboju wrote:
> The following build warnings / errors were noticed on x86_64 allyesconfig
> with clang-20 toolchain running on Linux next-20250903 tag.
> 
> But the gcc-13 builds passed.
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> First seen on next-20250903
> Bad: next-20250903
> Good: next-20250902
> 
> Build regression: next-20250903 x86_64 clang-20 allyesconfig
> mmp_pdma.c:1188:14: error: shift count >= width of type
> [-Werror,-Wshift-count-overflow]
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> x86_64:
>   build:
>     * clang-20-allyesconfig
> 
> Build error:
> drivers/dma/mmp_pdma.c:1188:14: error: shift count >= width of type
> [-Werror,-Wshift-count-overflow]
>  1188 |         .dma_mask = DMA_BIT_MASK(64),   /* force 64-bit DMA
> addr capability */
>       |                     ^~~~~~~~~~~~~~~~
> include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
>    73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>       |                                                      ^ ~~~
> 1 error generated.
> make[5]: *** [scripts/Makefile.build:287: drivers/dma/mmp_pdma.o] Error 1
> 
> 
> ## Source
> * Kernel version: 6.17.0-rc4
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20250903
> * Git commit: 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7
> * Architectures: x86_64
> * Toolchains: clang-20
> * Kconfigs: allyesconfig
> 
> ## Build
> * Build log: https://qa-reports.linaro.org/api/testruns/29752023/log_file/
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250903/build/clang-20-allyesconfig/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32B39xPuITjxcbak13h2MrLZJP4
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32B39xPuITjxcbak13h2MrLZJP4/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/32B39xPuITjxcbak13h2MrLZJP4/config
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

