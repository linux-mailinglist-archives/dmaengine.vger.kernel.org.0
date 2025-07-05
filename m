Return-Path: <dmaengine+bounces-5744-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E57AAFA13D
	for <lists+dmaengine@lfdr.de>; Sat,  5 Jul 2025 21:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A451BC0C42
	for <lists+dmaengine@lfdr.de>; Sat,  5 Jul 2025 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5041AF4D5;
	Sat,  5 Jul 2025 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFItwM7i"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8E10942;
	Sat,  5 Jul 2025 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751742190; cv=none; b=ssRQqjWt9lQTxj70cyicaML3XtDm8m0BpS9tIW2yQlNOnqNItKRUq4ud6s+MzBmKylFwYN9Jz8FqrYcXxtKF13s1chv+5TdyOypcqQ5k3xlk05regnTR2C6uLGveenCoL+dHMy7pa/EIgJM0Bop+qss+xE1yxRhn0a9y3e4tIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751742190; c=relaxed/simple;
	bh=9HO47YLjgkBIB1JTCg5ZgIjx1CpmGk2qgXFefZv/6P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDbUHELquRzPiFrxSgcqDRPAZvJYHvPnOf+gkfruBm+dkvmCJVd0isuawvFA6BUD36QCFNZHyyxyNtlBP9wxjzpNSZCGpn+f0iEEjQn/d8ul+iaggouMPQscKqvqblZ1lR94r0DPKqeAcOxYaxKh4Qn5eFa4vqlrps4pD+UxyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFItwM7i; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747fba9f962so1439667b3a.0;
        Sat, 05 Jul 2025 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751742188; x=1752346988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11lnZUHK4peQhtJtZlA1DMT7EWqZuUbx7mq3W6Wt0YM=;
        b=cFItwM7iU1GgDoRd6eRZdCt3Qgsp2sfALNFtq4+ctPaKbM3DiQLSg2etmPHZR4w+iC
         AhbKNiY3nv83seDwPzKi4He1wc9yrr4AVWZQEVP6oMlvOQr7Mlr3S4Sf9BQdbo1uOJPS
         UOYkjGCUBoff006EWF+y75HnWMsbPruoLVUX8hvoEU0cmWyrPhbl5YqbW4FYKqoVMwyb
         /TsLuSeE/UVI1284wPW6+VkEhqz6m3ByjhvT6AMyEIkxQ54scZfagET9y51/BkYwnpOH
         xlFKc4N8IX323AQsDavspdCLzn6zpQ+IEXwS7osfWQwKd33mOH6jShJ3O233StAbQiRt
         n/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751742188; x=1752346988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11lnZUHK4peQhtJtZlA1DMT7EWqZuUbx7mq3W6Wt0YM=;
        b=nISYfmLS9x/1YRzx2s8MFjeoSwCLFXDBNQfrHU1/+O5gyr+cu3Ld3ilCfzNIOAkM38
         oWRE3GyN7txH5RXJUEyRkAaphBJ7eX8JPdAdIwbttLpa6trFuukCo1j4DcArv9s+1CwE
         dNVgvKxF08uaV6J6WBoEf1hADYjUPtjTnLFOHzBuzKtPnCXijGsjjjbNnEFn1pqLSQtj
         p6fz4g9EmQJBGGnH+ZqKSkRvKk+18JZiAWmTeDCyYKFd2TBUVb0XEcvidbA8EI42mR9f
         mJIJwPip9yG9DfVcrmYAneo8/E+AZ4v7MYRNwdtBSIfy5W/g3kDPn5LVpTfJHrKgTfIu
         wZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+D2ooj0EZyf/xtoBH/l/15WHUJMJs9hzAqBUSG0y8so0CwY31aoaD2y5ae5TWfK5rUvjxswjmcrKrbv5q@vger.kernel.org, AJvYcCX7tmLz7PIpGM/+RWBhkTlg+LMrcSNbKqiIYtZ11eoB1arF/G/xM1HINkraU5ZS9SU91ttpKQ+NXaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysjVp17gW6Sr1czexgtqY2E7KzL8cdK9J06FBORrSmngV1cLSZ
	xFkQEEGIs/XcUAbeF4o3nHiybCj0ZdhMxsojie07Y+Mj9p2ZvhWWYB/g
X-Gm-Gg: ASbGncsO89+R2oZKd1OsPeYXGjZ1zQjwGrTJRqmN1R26PHweII3kd5AdMAB8xqw+mKE
	Ydq2wYXhxXRVGmQHx4GCIjHahfWXCB8qqnEH66MkqusQUCtqQ0icY/WtxJ5PTb7wH01Yk6Cv2zS
	XQLXQvnSF2NZUtBo+VPHxfaxu5HRXaXVieP64ulbJ/Ljugb7SbI1EDpVvsSRy0QARuaAa5WTt3+
	0DEM+FlhSCuoDy4s7nMZVUfg/TrUDxznopve6ztJ4iP3o2yIx2lhdgWfjPR60dfxF4GGjBJH+Yr
	/dWGdtpwtbtXBf9cJHkEzW/8NHN0Mf1AzPG8FU2xe6OWBhu8Rz35MJUAAxHPh5qwo0gTCV7SfKF
	D30KMnf5Pxg==
X-Google-Smtp-Source: AGHT+IGXOLv5E0kKd2A6cCF8jo4VUPIGL16792gkYrlOQmmoOlQk+s3YJkvOuYIi8k5qz1PWxng+/g==
X-Received: by 2002:a05:6a00:26f8:b0:742:ccf9:317a with SMTP id d2e1a72fcca58-74ce5159818mr7629424b3a.12.1751742188234;
        Sat, 05 Jul 2025 12:03:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cf9e1sm4936081b3a.65.2025.07.05.12.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 12:03:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 5 Jul 2025 12:03:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: vinicius.gomes@intel.com, dave.jiang@intel.com, fenghuay@nvidia.com,
	vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] dmaengine: idxd: fix memory leak in error
 handling path
Message-ID: <13cc0bf5-ecfc-4cda-ac8b-dacd714d5c41@roeck-us.net>
References: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404120217.48772-1-xueshuai@linux.alibaba.com>

Hi,

On Fri, Apr 04, 2025 at 08:02:08PM +0800, Shuai Xue wrote:
> changes since v3:
> - remove a blank line to fix checkpatch warning per Fenghua
> - collect Reviewed-by tags from Fenghua
> 
> 
> changes since v2:
> - add to cc stable per Markus
> - add patch 4 to fix memory leak in idxd_setup_internals per Fenghua
> - collect Reviewed-by tag for patch 2 from Fenghua
> - fix reference cnt in remove() per Fenghua
> 
> changes since v1:
> - add Reviewed-by tag for patch 1-5 from Dave Jiang
> - add fixes tag
> - add patch 6 and 7 to fix memory leak in remove call per Vinicius
> 
> Shuai Xue (9):
>   dmaengine: idxd: fix memory leak in error handling path of
>     idxd_setup_wqs
>   dmaengine: idxd: fix memory leak in error handling path of
>     idxd_setup_engines
>   dmaengine: idxd: fix memory leak in error handling path of
>     idxd_setup_groups
>   dmaengine: idxd: Add missing cleanup for early error out in
>     idxd_setup_internals
>   dmaengine: idxd: Add missing cleanups in cleanup internals
>   dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
>   dmaengine: idxd: fix memory leak in error handling path of
>     idxd_pci_probe
>   dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove
>     call
>   dmaengine: idxd: Refactor remove call with idxd_cleanup() helper
> 
>  drivers/dma/idxd/init.c | 159 ++++++++++++++++++++++++++++------------
>  1 file changed, 113 insertions(+), 46 deletions(-)
> 

This patch series, as applied to 6.6 and 6.12 kernels, results in a variety
of warning backtraces and crashes when unloading idxd the driver, such as

da_free called for id=0 which is not allocated.
refcount_t: underflow; use-after-free.
list_add corruption. next->prev should be prev (ff11d2ed9908ecd0), but was ff11d2ed8a5d0ba0. (next=ff11d2ed8a5d0ba0).

Looking into it, I see that many resources are now released from functions
such as idxd_cleanup() and idxd_free(). At the same time, the calls to
put_device(idxd_confdev(idxd)) trigger calls to idxd_conf_device_release()
which releases the same resources. On top of that,
put_device(idxd_confdev(idxd)) is now called from idxd_remove() _and_ from
idxd_free() [which is called from idxd_remove()], on top of the put_device()
called from device_unregister() itself.

Does this actually work in the upstream kernel ? What prevents duplicate
release of resources from idxd_free(), idxd_cleanup(), and
idxd_conf_device_release() ? And why would idxd_remove() need the extra
put_device() call ?

Sorry if I am missing something, I just try to understand the logic behind
this patch series and why it triggers crashes and warning backtraces in 6.6
and 6.12 kernels.

Thanks,
Guenter

