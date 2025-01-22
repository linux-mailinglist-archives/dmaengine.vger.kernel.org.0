Return-Path: <dmaengine+bounces-4173-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19CBA194FB
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2025 16:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF653A3C73
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2025 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D6214205;
	Wed, 22 Jan 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvu5zYb7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD32135B9;
	Wed, 22 Jan 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559237; cv=none; b=AnZNq4jWVcSr8iTBF98JNtQPNUzXFw+3ut5qWJaiu060IWT4ck5UTsHbu9WV6aTBYyoHkJqRB/6V+GTve1cyi30EDRbh/5+PSjej4YIppNIQAGGpe3KSNmhbL19UOyD2YFecTMo1k+x749T0ioduA316iVchIo2IKujQl1wf8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559237; c=relaxed/simple;
	bh=TFe7TLpqiWeZb+aHyLVSjqITj76OAk1X34uRdT9r40U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIWMsBcqGxlEOqmo6NX83xKUSVcwlYQW2Gh/mcqh2QI0/5BC2434b27LZA6Pj8QIpu1RytRwZxkrBxYaBml110+41H+oMClfW145YknCTec/X/KCUqDVo8CTHQV8CosELhqfA953ouXh7ukIayZDxUB7CnR0JCmvCnJ+cT5SofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvu5zYb7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54298ec925bso8465073e87.3;
        Wed, 22 Jan 2025 07:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737559234; x=1738164034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMWsl+1FyaK0pmlH/yptJB2iaflZrW4THtOJkeRTP5Q=;
        b=fvu5zYb7ybcdeO3fmNgG3grHRiCb63nPGsNBcs5RDSZZsEnagPUWWVTXoVLIi/o3mT
         ifC/+RhIx58RRIdaR9fzy+ZDPpU7yP49pUrM1mP6y8KlyPFPwMVjLfgoPt1dst60hLtm
         6DdilvXPHP9/GMhrFk1AwcfZi3H8ZrlDYREY+YDZ+e2xAAVZovHaoh86tR+Phg7lq7HL
         makWCVB2hVpEarhfXZiumIg5RmtTIVuZF9k3XgoepiWmmZhsTgWf2/HR7N9MJZuhO/Kk
         QZSrtKoYAhtCFcTjszgdFDeWcgelx5P3bPkAtB4mfSiRbNKRl61UDQi2o+uTf8mP4pS7
         KPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737559234; x=1738164034;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMWsl+1FyaK0pmlH/yptJB2iaflZrW4THtOJkeRTP5Q=;
        b=X10qT4hBUTJnH9jyWqZDav5vcCNCgy08iR7gxPSdIceKUMAAtZaHyeip1RZPeLlIgd
         vl02timCkAewOa08t+5du4VwjPmEiLp4LI3FTNWsRg79iAUFDgZTbKPQLqm9rLoGwBSE
         /cZGTdaetC1h37h/oSS95SCMZtRegsAXzhtwfdo7LJa0QLUL5BRgU+C+l9peoi14HflB
         FF0zPxeP/nHERTHaETSIHxHj8Ycl+gO9ad8n2/DOvGMQ38Z68Ya1wG9QJBKXs2slCAEW
         KoEVBXHZh0M2vd1CAKYeGUp2wMgAJMbIkC3ptS1EmIbr+pajXTCkj69lt4Gc6MhZ5lTq
         TPXw==
X-Forwarded-Encrypted: i=1; AJvYcCUxSmX93AZ+3VpeNGju/AXtH5Shux0pkupOaJCoi266zli/ElWpz8T5QuWCjPfMsQZneEmxqgQ9@vger.kernel.org, AJvYcCVZSHLF+4uPzzVfxsQxaSoOavR74sfpmMvt2dmAWq0cEO/wKJPyPOBz2qUaazPATV1sIbiJXB0G9mU=@vger.kernel.org, AJvYcCXT/62QunbwOGq89fDZsL4taUgX/7rzS3nURLmUX16xwSEdhylZAj9FUv4r0UFUhFaqcCsjoQg6un6p5y5w@vger.kernel.org
X-Gm-Message-State: AOJu0YyXacToAcA8snOvQd9TXueKzoyQ2Pq5e/v00Q9ugFpFtOahfLGt
	SCkrnejzRKdy5m2TQu/dyT+cqOi6wM1Sa3kKvASaPuOhzRJtFyoN
X-Gm-Gg: ASbGncv5gWtMzq6+1rxX7J4awONlEY/oyWRgZ7ID0E0rcBYAMsU1IUJtNteQ2Trsqqy
	tzFKB2DlulJUcsNKKmc+01t9kBmbOG/H4zeH5FiAI6qcDPUqVXtGgTy6pWvM2MiUS4yKmSv2zS4
	LsVfc8Z0z/IIwHZzjyRgQs9qZOESr2iGtyMlxETug0G5JRcH9amH8KmUHsCroFdK+O3+AvxZPzt
	fdsLJ5v1daXmI0z1sp3Zt/kI75rzx5dJdX0U8YVghvJizofkdknXgCvodY4P/0YdnSbFdqvQdh4
	TUQ8wQMAluKv1pwxpaw56J5bOnAq0r8Z/K5Av7/1eBDTZRRZr2Ayqk0DJmWe3kJGbj/bvXmx5jE
	HCsayR6h/uwXfNJM=
X-Google-Smtp-Source: AGHT+IFXTNmRUQhmv4rjYJyVtcOLCyDN8VePHfe1+bdclTyyKXKUAWPR75wwEtdQp+t0HcM1w9ichQ==
X-Received: by 2002:ac2:4e0e:0:b0:53e:2f9d:6a73 with SMTP id 2adb3069b0e04-5439c1c60e7mr8857787e87.0.1737559233841;
        Wed, 22 Jan 2025 07:20:33 -0800 (PST)
Received: from ?IPV6:2001:999:584:a1be:41d4:8b85:aace:5430? (n5ykva7sx9871hnihio-1.v6.elisa-mobile.fi. [2001:999:584:a1be:41d4:8b85:aace:5430])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af0ebcfsm2255437e87.84.2025.01.22.07.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 07:20:33 -0800 (PST)
Message-ID: <dc9b9b53-dbca-49f5-a7e6-3a6a3112f1bb@gmail.com>
Date: Wed, 22 Jan 2025 17:22:55 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add missing locking
To: Ronald Wahl <rwahl@gmx.de>, linux-kernel@vger.kernel.org
Cc: Ronald Wahl <ronald.wahl@legrand.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, stable@vger.kernel.org
References: <20250120144131.792609-1-rwahl@gmx.de>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20250120144131.792609-1-rwahl@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/01/2025 16:41, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@legrand.com>
> 
> Recent kernels complain about a missing lock in k3-udma.c when the lock
> validator is enabled:
> 
> [    4.128073] WARNING: CPU: 0 PID: 746 at drivers/dma/ti/../virt-dma.h:169 udma_start.isra.0+0x34/0x238
> [    4.137352] CPU: 0 UID: 0 PID: 746 Comm: kworker/0:3 Not tainted 6.12.9-arm64 #28
> [    4.144867] Hardware name: pp-v12 (DT)
> [    4.148648] Workqueue: events udma_check_tx_completion
> [    4.153841] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.160834] pc : udma_start.isra.0+0x34/0x238
> [    4.165227] lr : udma_start.isra.0+0x30/0x238
> [    4.169618] sp : ffffffc083cabcf0
> [    4.172963] x29: ffffffc083cabcf0 x28: 0000000000000000 x27: ffffff800001b005
> [    4.180167] x26: ffffffc0812f0000 x25: 0000000000000000 x24: 0000000000000000
> [    4.187370] x23: 0000000000000001 x22: 00000000e21eabe9 x21: ffffff8000fa0670
> [    4.194571] x20: ffffff8001b6bf00 x19: ffffff8000fa0430 x18: ffffffc083b95030
> [    4.201773] x17: 0000000000000000 x16: 00000000f0000000 x15: 0000000000000048
> [    4.208976] x14: 0000000000000048 x13: 0000000000000000 x12: 0000000000000001
> [    4.216179] x11: ffffffc08151a240 x10: 0000000000003ea1 x9 : ffffffc08046ab68
> [    4.223381] x8 : ffffffc083cabac0 x7 : ffffffc081df3718 x6 : 0000000000029fc8
> [    4.230583] x5 : ffffffc0817ee6d8 x4 : 0000000000000bc0 x3 : 0000000000000000
> [    4.237784] x2 : 0000000000000000 x1 : 00000000001fffff x0 : 0000000000000000
> [    4.244986] Call trace:
> [    4.247463]  udma_start.isra.0+0x34/0x238
> [    4.251509]  udma_check_tx_completion+0xd0/0xdc
> [    4.256076]  process_one_work+0x244/0x3fc
> [    4.260129]  process_scheduled_works+0x6c/0x74
> [    4.264610]  worker_thread+0x150/0x1dc
> [    4.268398]  kthread+0xd8/0xe8
> [    4.271492]  ret_from_fork+0x10/0x20
> [    4.275107] irq event stamp: 220
> [    4.278363] hardirqs last  enabled at (219): [<ffffffc080a27c7c>] _raw_spin_unlock_irq+0x38/0x50
> [    4.287183] hardirqs last disabled at (220): [<ffffffc080a1c154>] el1_dbg+0x24/0x50
> [    4.294879] softirqs last  enabled at (182): [<ffffffc080037e68>] handle_softirqs+0x1c0/0x3cc
> [    4.303437] softirqs last disabled at (177): [<ffffffc080010170>] __do_softirq+0x1c/0x28
> [    4.311559] ---[ end trace 0000000000000000 ]---
> 
> This commit adds the missing locking.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
> ---
>  drivers/dma/ti/k3-udma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index b3f27b3f9209..b9e497e8134b 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -1091,8 +1091,11 @@ static void udma_check_tx_completion(struct work_struct *work)
>  	u32 residue_diff;
>  	ktime_t time_diff;
>  	unsigned long delay;
> +	unsigned long flags;
> 
>  	while (1) {
> +		spin_lock_irqsave(&uc->vc.lock, flags);
> +
>  		if (uc->desc) {
>  			/* Get previous residue and time stamp */
>  			residue_diff = uc->tx_drain.residue;
> @@ -1127,6 +1130,8 @@ static void udma_check_tx_completion(struct work_struct *work)
>  				break;
>  			}
> 
> +			spin_unlock_irqrestore(&uc->vc.lock, flags);
> +
>  			usleep_range(ktime_to_us(delay),
>  				     ktime_to_us(delay) + 10);
>  			continue;
> @@ -1143,6 +1148,8 @@ static void udma_check_tx_completion(struct work_struct *work)
> 
>  		break;
>  	}
> +
> +	spin_unlock_irqrestore(&uc->vc.lock, flags);
>  }
> 
>  static irqreturn_t udma_ring_irq_handler(int irq, void *data)
> --
> 2.48.0
> 

-- 
Péter


