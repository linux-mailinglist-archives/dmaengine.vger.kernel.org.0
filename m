Return-Path: <dmaengine+bounces-10528-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIaBFdwlDGoIXQUAu9opvQ
	(envelope-from <dmaengine+bounces-10528-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 10:57:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D057AA44
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBB1430FC33F
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 08:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626653EF0D2;
	Tue, 19 May 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKm0WEKT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7F3EF0A5
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180507; cv=none; b=d08zoknHqZBG608ndknaIkDVyaooQ8uG/8c+ZBMcURF7PRsI/JX4tgtHOnSCJGzqnioBPTsHiIrTQ5j0oOJTenUmErcMqkjhR85GngGVhj4q05u1qEWpsHbDvp09ZQvcbsUKmaFBQBwNW4sRKxcKVZAozthiP5gYxpoD1wSpBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180507; c=relaxed/simple;
	bh=Hyx9uiXztVttxLdo9VjcbHUiP6qvqHfhOZr9vbJAYdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYdiB07117eXXgUnJJSmD5pKTM40Y0/A1SnAQ2XfTGClNV3ljbTU3Jjhc619FdU6WGsa70ochfdnljHa5lPeIApCnjKDrt9m6SZFhZJTkqOKGGZxj5aSc8xFGLrIPv1tBMrHtswy3j539NPRYKwNn9q7oKSrnG1cxjmsqwRYEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKm0WEKT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0046078so29359625e9.1
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779180503; x=1779785303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U8k5KUlWmxiDre3dDf6j/8PHyhhwOqohUrC9tjzC3Y=;
        b=eKm0WEKT3mVDrwy7IMshOn0GT2kwmWUNussjaxGEyv482mBKvskG0hs7pJ5k+AfXcN
         l7Rjpy9iZzrpocdayWNqfQdXtH/nwyhXHiZOuGC5I7B98fO16ELapo992aMvVW7NErxJ
         Dom6oCaQBG4n0rJrkSsLMhnHP63zTKUiw5KuKnT6p7IvYNK+2mRBlfzqpifVUT/esNd3
         vlhe3vAPa4t8awQvJiHD5JpieSz9o9c/NHG55x2xnbEgyrkqQ4UwvMthmyx0XIjO0dD8
         Ds9+nZuBWp3o5j4Qfh95443MbvDyxxMyRCOg8xUEL3EtMFxko1g7WSrXeeWqy5p4Vy/L
         m4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180503; x=1779785303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8U8k5KUlWmxiDre3dDf6j/8PHyhhwOqohUrC9tjzC3Y=;
        b=Vuspyx12gtZhFE4S+WSYF/tpPzBipPcwg7f8v8wEcld036j67GC5HE8Kdwy6ar940G
         hAKKymWZk2xCAoqurP7db//W87HMxfeODjWYMb2D9gl11QY5NTuiWVAtvolm0TGKdxiV
         jbixYcG3eoqht739jXxcbgWDPSkcDsa2JlzcSh2zJnCf1msc/8cLwl4rDFtDCQtRaueU
         PkfrxVIb+jv+vendmtOai9KYxZp/7t5+05BlpXUV5yM1TXRfPRTxuA78uvUvVSvdjuhK
         CYLfMb7cXiJR+tg/MVxALSoPOLdq08emMh2gdOR5dFa8D+L4slH/ZafDgGazBflf47mi
         SNAg==
X-Forwarded-Encrypted: i=1; AFNElJ8t1WeUZzem4uqqp1R91I1X1JZMaZ2DhdeTni+Vwl2SjkXC9f3ff2FpYlELEqJ3gz1+b2GWGw03M4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YySti+hb7MUWX7eOYQjnd7xNEiwZD47g4Y9GEVeAZUTiDMDxopg
	JjB/l0PrEbwX89ZX5wioRs7t0kYKg3+lXQ3DcwL94z5sLBd286PEMfyA2WKve0vmVEk=
X-Gm-Gg: Acq92OFOIRgdg5nZ8iSK8e6BBO2I/UlXx0YKIlvyYlDZs5bvniDdvxywG05SUjzfmwa
	md0CQ+PHndot4JpXpc/ii9T2qUz+rJ9L/44AIAYtSZ4X9643cnr7Hb4StU8DrpR5rzjb2ofCiEI
	WK7iSrTi/JyXRdA9qv6Ly84DiKNI8YBKguxBb1TY1SAcIVvRR9COc/3jhw3Pii4xmvFWftAZsdM
	B8canebOF/2fG7wuDsCCa0KrAg+7XymsQ29R+KZ3lXfDmXvIXEm99aD+iSnegk+bd1lQrZiPQ5B
	T0mhUV+PHBv28cRyE7SL0wl22THEda3bvIun4tVb5Fzz7pC1cyjAANIU9nE7g5jZAVLwYO1aN5q
	3fOvCeX4jZW+HOHhoKRPjDa3+0GIYVOWwUdQzKTekYs/l4uuy1KIfZrBfftKIV0WwvyMnW/w5vL
	40SdQ8u0tCVZdCbkwTbbAux5bG0PD1NXbH03xQwucMKULHWlpEcMqQStLDCoG0Kpu9
X-Received: by 2002:a05:600c:3e1b:b0:48a:8905:a500 with SMTP id 5b1f17b1804b1-48fe60da647mr311906705e9.12.1779180502860;
        Tue, 19 May 2026 01:48:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm530004325e9.1.2026.05.19.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:48:22 -0700 (PDT)
Date: Tue, 19 May 2026 09:48:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 workflows@vger.kernel.org, linux-arch@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang
 Mu <dzm91@hust.edu.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh
 Nguyen <dinguyen@kernel.org>, Kees Cook <kees@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod
 Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Dave Penkler
 <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kwilczynski@kernel.org>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260518042833.272221-1-enelsonmoore@gmail.com>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[48];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10528-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,gmail.com,infradead.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url,gnu.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,altera.com:url]
X-Rspamd-Queue-Id: 162D057AA44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 21:28:33 -0700
Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:

> The Nios II architecture is a soft-core architecture developed by
> Altera (since acquired by Intel) and intended to run on their FPGAs.
> 
> Licenses for the architecture have not been available for purchase
> since 2024 [1],

Except I think they got 'beaten up' by some telcos.
The Nios II gets used inside fpga for small cpu doing things that it would
be far to difficult to do in VHDL.
(I believe some mobile base stations fgpa embed a lot of them.)
These will have a small amount of code (maybe 4k - 64k) and a similarly
small amount of data memory along with access to fpga peripheral registers
and (optionally) host memory vie PCIe. No MMU, no cache (or rather the code/data
is in the cache memory but it isn't backed by anything), no branch predictor
(guaranteed cycle times), etc.
Intel suggested that RISCV could be used instead, but it isn't the same beast.
They didn't document the instruction timings nor how to add custom instructions.

The company I used to work for used 4 NIOS II inside an fpga.
The instruction timing for one is pretty critical, it has some code that
has to complete in 122 clocks (worst case).
Our solution was to spend a few man-weeks writing a compatible cpu!
I think it came out with fewer pipeline stalls (in particular it 'lost'
the one for a (predicted) taken branch).
The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
higher 125MHz in just impossible for all sorts of reasons.

OTOH I really wouldn't run Linux on it!

-- David

> and support for it has been removed from GCC 15 [2],
> Buildroot [3], and QEMU [4].
> 
> Given all of these factors, it is time to remove Nios II support from
> the kernel. The maintainer stated in 2024 that they were planning to do
> so soon [5], but this did not come to pass.
> 
> Remove Nios II support from the kernel and move the former maintainer
> to CREDITS. Thank you, Dinh Nguyen, for maintaining Nios II support!
> 
> References:
> [1] https://docs.altera.com/v/u/docs/781327/is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip
> [2] https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=e876acab6cdd84bb2b32c98fc69fb0ba29c81153
> [3] https://github.com/buildroot/buildroot/commit/6775ccc5a199d574ad70b5f79ec58cce97a07c6f
> [4] https://github.com/qemu/qemu/commit/6c3014858c4c0024dd0560f08a6eda0f92f658d6
> [5] https://sourceware.org/pipermail/newlib/2024/021083.html
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>


