Return-Path: <dmaengine+bounces-9803-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MB0Ar30zGl9YQYAu9opvQ
	(envelope-from <dmaengine+bounces-9803-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 12:34:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9114437893D
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECDC030D2314
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5E03CF036;
	Wed,  1 Apr 2026 10:28:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811983C661C
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039333; cv=none; b=edkVDwQUs7HgMCFWJsJRd8qBnTFOowKnKCJt6YJDfVOXQxLZm50qNHZZ5Zw/vBxjq+bGgKtgMnJEdwINyHiGr2dDmK6sf8OikYLa/iX3/t6jtTzlX9BFgVToL20G8tPAiKXnQTxsF4J/qtbILArVmtpMWjSRIMY5K5tGut8bvb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039333; c=relaxed/simple;
	bh=Vb7bYuGoKXTW1truZJGtKM+3dgXaW0t/nLnnQeG4ZeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMWm2pGWDy6EhsXVp79ovsboiNU/ntYhbh9AKWmneNj6xn0TEtJxffroQwXf0jVAwdkO0E6MfiuEGKaDJs/2HTY4wTP8P25yW7LxJmNHifWLA9WPniVZUikgLWutvkshiHoo3SlESCE/2961mEbT4LVox/ynI15TMePDZ8NCNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6055de93fa8so529632137.0
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 03:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775039331; x=1775644131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0mdH0OC8JwB7IJKC2+SnwcdnINdTU07hJwxXP0++6c=;
        b=EU1Mhuog7V/tNRLTXiIX1p7ReRzO67ePyuCuLDwfmu0H7/RbDxoIRaRR2X8wX/PJv2
         3rm174tqEB8zOC9KsOFEJcZmEzIYSDzJHinM8IsGfS7s2vYpXK95USgALJQQoD0ZbgW7
         zzPt/dkGKaDaaLBEjP0VUFcOkFXbtI7Ndx22bhlBFBsW/zI/mr3yvKXoqMUIwJGrUEqQ
         GBFIgR1lGQ/k9K6jrafu4kjVrpgGixngxenVWNYkerwO/YiC3olgXfiWu51nayyCpGll
         4PBXDEJGLIEIZU5HTD2d/paRflNJUTzaDoxNT2110WO243C5IYgeTsWabeO0WNcRKlNM
         WsJg==
X-Forwarded-Encrypted: i=1; AJvYcCWTF39Ad+tUpdqnS8jdRx3ugH9AeNVZ/WyYskkW8WCrb72OEOOKT8/7CA/+UOtjPV/+F6n/1sba2Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDC2ZLFZOg7dEpZyQHRboFZydIWa4hWs0eZlwsA5PE5epSWqja
	3K2KWC2pJpq+0Joj3Sq71r/ZkwPbdouwQ+XL9UdUQoyBgDQkszKn3uC9820d7ROS
X-Gm-Gg: ATEYQzxyle5IpqpLvQvqeZGU8529L7yLPqRHcwZR88VNAWUMZA4QEGp24yr7+MFeXEW
	7SgCYBru56ysGuR5n2uontfqB/7Rx8TXgGYXTJ/nrqYJlGs5iebYWbiade7OyE26baqT7JqvbIK
	PvlV0raowmLXQWkg/6MrkVYG2cCnSZaU4pYB2+LuEh6Kz89c9AXyUQNRwwhdOXSCE6IBVTuN1Sh
	cwAG2fX+LV1RRUDxk2ag8clGfKOa4sEgEdNy2kfeHFR0NqU4pG1gIakMYT5B1nGMlP6E3EHbp/3
	8yG08KPUqYn1vB7SAE7kjSfauIvfBXlM0Q+2rbj/YKbsdmdhsyw6xEIp3Po7QyMGgA0cw/KmMmv
	IpWjBt8ZU/S/pO1092Lw2zqHk9zukAJR/aL83qZmKgZ/xjNVzEDPEZsRTNGsSwntycvLww51owj
	j9iy3gnwhoDryZpClMns7vWELMsCFvm3wMO1cqn4m16/25r1Qw/2i9q/tfu6S+
X-Received: by 2002:a05:6102:c92:b0:605:1994:a8a8 with SMTP id ada2fe7eead31-60567d9df92mr935723137.9.1775039331374;
        Wed, 01 Apr 2026 03:28:51 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-605129b8347sm16059330137.3.2026.04.01.03.28.49
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 03:28:50 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6055a0414d7so496780137.2
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 03:28:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYku9PosTALgodtJFNFwGRsp2V1sEUa/h9H1HhGz5m0HfxrG14aE7SJey3rmfXQsLUxdwMx2v4Ejo=@vger.kernel.org
X-Received: by 2002:a05:6102:f82:b0:5ff:a16b:93fc with SMTP id
 ada2fe7eead31-60567e38c48mr1019620137.15.1775039329568; Wed, 01 Apr 2026
 03:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-fix-atomic-poll-timeout-regression-v2-0-68a265e3770f@bereza.email>
 <20260401-fix-atomic-poll-timeout-regression-v2-1-68a265e3770f@bereza.email>
In-Reply-To: <20260401-fix-atomic-poll-timeout-regression-v2-1-68a265e3770f@bereza.email>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Apr 2026 12:28:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGHzt8nB3EGAToxZibf-O6C5xb9bcWhQQApzL3-6pcCA@mail.gmail.com>
X-Gm-Features: AQROBzBYece91B7HL1BQJzn0XhA1qYXWXsk8dwgJyg4pUS_Jz6xTvdQx5dc1VOc
Message-ID: <CAMuHMdWGHzt8nB3EGAToxZibf-O6C5xb9bcWhQQApzL3-6pcCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout
To: Alex Bereza <alex@bereza.email>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, 
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9803-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,bereza.email:email]
X-Rspamd-Queue-Id: 9114437893D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Alex,

Thanks for your patch!

On Wed, 1 Apr 2026 at 11:58, Alex Bereza <alex@bereza.email> wrote:
> Currently when calling xilinx_dma_poll_timeout with delay_us=0 and a
> condition that is never fulfilled, the CPU busy-waits for prolonged time
> and the timeout triggers only with a massive delay causing a CPU stall.
>
> This happens due to a huge underestimation of wall clock time in
> poll_timeout_us_atomic. Commit 7349a69cf312 ("iopoll: Do not use
> timekeeping in read_poll_timeout_atomic()") changed the behavior to no
> longer use ktime_get at the expense of underestimation of wall clock
> time which appears to be very large for delay_us=0. Instead of timing
> out after approximately XILINX_DMA_LOOP_COUNT microseconds, the timeout
> takes XILINX_DMA_LOOP_COUNT * 1000 * (time that the overhead of the for
> loop in poll_timeout_us_atomic takes) which is in the range of several
> minutes for XILINX_DMA_LOOP_COUNT=1000000. Fix this by using a non-zero
> value for delay_us. Use delay_us=10 to keep the delay in the hot path of
> starting DMA transfers minimal but still avoid CPU stalls in case of
> unexpected hardware failures.
>
> One-off measurement with delay_us=0 causes the cpu to busy wait around 7
> minutes in the timeout case. After applying this patch with delay_us=10
> the measured timeout was 1053428 microseconds which is roughly
> equivalent to the expected 1000000 microseconds specified in
> XILINX_DMA_LOOP_COUNT.
>
> Add a constant XILINX_DMA_POLL_DELAY_US for delay_us value.
>
> Fixes: 9495f2648287 ("dmaengine: xilinx_vdma: Use readl_poll_timeout instead of do while loop's")
> Fixes: 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomic()")
>

Please no blank line between tags.

> Signed-off-by: Alex Bereza <alex@bereza.email>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

