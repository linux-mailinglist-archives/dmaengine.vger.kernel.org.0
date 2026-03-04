Return-Path: <dmaengine+bounces-9234-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KvcBfPup2mWlwAAu9opvQ
	(envelope-from <dmaengine+bounces-9234-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 09:36:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E491FCB10
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 09:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37A723007B15
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047DA3914FA;
	Wed,  4 Mar 2026 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCf5/Rb3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E894390C9A
	for <dmaengine@vger.kernel.org>; Wed,  4 Mar 2026 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613357; cv=none; b=l4VWdGrOUVTJtt7uGE/cctkCaqsndbC/Jp9jdFZdvbe5UlFMq7AS4hPMS7QjmGSX3PqtNQEsjoclOsPBRNHrU1UVMvfUPyLi6uAK9BDpLjCIjhaTZDvmfmFv4PmHi6pNQDM0WwgWVOgppkGACaEdcAzjch5YlkomfJX1EO7PeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613357; c=relaxed/simple;
	bh=SgvvOrah8fZSj+O/2RkiQnrYYSEZebPTIHGL1SGZKdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEq4n8TtHjoRCfSiZkWXpXDu2RHiPagfWGmnYbB0BN30qdN+eDrPNLZTkoCAfEvXKFltQ7QEoDHa7JxkCB5qFfB5ji5oNImjcakdejupF4QfwWF0VSYqbYUQJ5k8EMpa7k/P1P+r29GjVNY0DdfYTT76pC6Krmhgh7zKuhglVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCf5/Rb3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso20357a12.0
        for <dmaengine@vger.kernel.org>; Wed, 04 Mar 2026 00:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772613356; x=1773218156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F70gqq+I/R3vfvEbag3BV7G6giBsrWU60bsrhlpfOk=;
        b=VCf5/Rb34YnBoCthbQy2mh91H9Sem0SUkyYdhwTun7+yMJyUfut4Y8ZIMSyndW8fCg
         qWhWylqomsOi8l8DttVaTuNwJ8XU/TfXH04UQ62ce35gpBXW0RRJZG2G65L6st4GzQ8+
         WVUz/UEUYrgii+RMAK67Bgzoxx/eqPL5zOwTMMFb8Pk+bMGLWXePEW+dyxVxAzOq/7RW
         +8XSoIVfkVmCBQ7hxpCCOiQmA+xNMMWUqq1ORoisqDR0j5OGkj4IDw5p0NfxfaZaxaYa
         wuv2NpxD8vXpcOTZYn4C2wJM4b5gS4yziLaee21gJFEJAPheTPgGHchslmhUQsKmH6cd
         fB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772613356; x=1773218156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1F70gqq+I/R3vfvEbag3BV7G6giBsrWU60bsrhlpfOk=;
        b=C1OfXGkmvuExhlMINsYGXdzILKGlntGX8NHOLB8KfjVimkwWF3WYTmL5RiCNWdk+Dw
         2IZEIQjRjkA+fbmf3+60JCmkmNXGOTcLnndUJLIHsuzuMi2nhCsU450oCwrZJejISbVG
         XtUg5yHXYDBdjtai67wMrQIGq9BKRCdhd6EryJoKkPVBYOyeogtetZ6HfSzCMwjZp050
         /bTi+hxR+YxZiX6j4GQD/M8YFp26mCZMaEiDb6HaBC1Tw3gBR//+rvYXSXUBM8AJTcck
         WdltyG03XI4uog2YmIOHj/+2ntNKOSISYuBgZUJ3MkxS1XdGkB/WPSFZhGFK/PKXTgre
         Zz5A==
X-Forwarded-Encrypted: i=1; AJvYcCX4l0jDJLf1IsFQcvcWP+A9eAYwwv4mCsdvTP09CdUSXfjDUyaKI0GJsjgHN+buxb42pDw1fGdYn/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfKrwqI2nFi+jqUtj7kpopehqTmQGOQ2xhfXM9yPnIHqDssO2
	iue28pRF6mVig3AvY7UHIYk6jK+R5GotUyEOyyL3tn2U8QDCqZb+cWPhcF5MO3yD
X-Gm-Gg: ATEYQzyTBkbkO2nhxZ9otwqKYtUthVFqLsW/KMERhViGcs4ylTovTl+NebvEFcY1FFF
	hQp0ytIGBH7OSxU8wALPjZf1KtFPx0+b52n7sNR2czwfWb6i9HhBMXiiNRrq65KUAjgivkAarIa
	mFXK9lkDvOZj0GQdQIfFUcCfYu75WWtLOMzTlb7zZyGUOjHQrZyLtd/CnWKvUF6CzmFMH/dYlMC
	plc7VhZ3ACquQmG70dfgkbY1+Y7PI2pNymJqVrffVDEX2gIzWsSvzWW2JUk1tEH8reNLnHLS6dM
	oJ1YRtO+lCBut27p9Fk16fShr6r7mOhnVbCo9V/NOQRmue6wtaN2bpMWW5gAF9JOQbIoT8EXcSb
	xqwWzO2rooumiKVoUgMVxMrNReYG4WumD3kCGv/r1yRdPEDZ66RqFTPkp0jeGqMul7IVOswk7PP
	QjeMIErP4r4aFFjSEzJXeKdpg=
X-Received: by 2002:a17:903:3bc7:b0:2ad:b22f:c697 with SMTP id d9443c01a7336-2ae6aa06ec0mr14432465ad.19.1772613355649;
        Wed, 04 Mar 2026 00:35:55 -0800 (PST)
Received: from bsp.. ([2401:4900:1b90:2d8b:ea7c:4506:5697:f9c8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3e4e34fesm120624245ad.28.2026.03.04.00.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:35:55 -0800 (PST)
From: Rahul Navale <rahulnavale04@gmail.com>
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Rahul Navale <rahul.navale@ifm.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	michal.simek@amd.com,
	suraj.gupta2@amd.com,
	thomas.gessler@brueckmann-gmbh.de,
	radhey.shyam.pandey@amd.com,
	tomi.valkeinen@ideasonboard.com,
	rahulnavale04@gmail.com,
	marex@nabladev.com,
	marex@denx.de
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction reporting via device_caps
Date: Wed,  4 Mar 2026 14:05:41 +0530
Message-ID: <20260304083544.4678-1-rahulnavale04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 46E491FCB10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9234-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rahulnavale04@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,pdm3:email,ifm.com:email]
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

Hi Folker,

Thanks — I followed your suggested debugging steps.

>For the next debugging step I suggest that we focus on (2) but also on
>getting some insight into the callers. Could you please reapply
>7e01511443c3, keep the RFC patch in place and additionally apply the
>below patch? 

>This will exercise your bad case, print the differences for caps, and
>also print the call stacks for all calls to dma_get_slave_caps().

I have applied 7e01511443c3, kept RFC patch(xilinx_dma_device_caps + printk)
and dmaengine.c debug patch applied (dma_slave_caps_printk() + dump_stack())

Observation: Issue still persists. cyclic playback fails after the first buffer period.
logs:
root@pdm3:~# dmesg | grep xilinx_dma_device_caps
[    0.302398] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.302401] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.303124] xilinx_dma_device_caps: caps->directions = 0x00000002
[    0.303128] xilinx_dma_device_caps: caps->directions = 0x00000002
[    7.762354] xilinx_dma_device_caps: caps->directions = 0x00000001
[    7.762358] xilinx_dma_device_caps: caps->directions = 0x00000001
root@pdm3:~# aplay closetoyou.wav 
Playing WAVE 'closetoyou.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
^CAborted by signal Interrupt...
aplay: pcm_write:2178: write error: Interrupted system call
root@pdm3:~# ^C
root@pdm3:~# ^C
root@pdm3:~# dmesg | grep xilinx_dma_device_caps
[    0.302398] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.302401] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.303124] xilinx_dma_device_caps: caps->directions = 0x00000002
[    0.303128] xilinx_dma_device_caps: caps->directions = 0x00000002
[    7.762354] xilinx_dma_device_caps: caps->directions = 0x00000001
[    7.762358] xilinx_dma_device_caps: caps->directions = 0x00000001
[   44.792624] xilinx_dma_device_caps: caps->directions = 0x00000001
[   44.792628] xilinx_dma_device_caps: caps->directions = 0x00000001

<4>[    0.302360] dma_slave_caps:
<4>[    0.302364]   src_addr_widths    = 0x00000000
<4>[    0.302368]   dst_addr_widths    = 0x00000000
<4>[    0.302371]   directions         = 0x00000000
<4>[    0.302374]   min_burst          = 0x00000000
<4>[    0.302377]   max_burst          = 0x00000000
<4>[    0.302380]   max_sg_burst       = 0x00000000
<4>[    0.302383]   cmd_pause          = 0x00
<4>[    0.302386]   cmd_resume         = 0x00
<4>[    0.302388]   cmd_terminate      = 0x00
<4>[    0.302391]   residue_granularity= 0x00000000
<4>[    0.302394]   descriptor_reuse   = 0x00
<4>[    0.302398] xilinx_dma_device_caps: caps->directions = 0x00000001
<4>[    0.302401] xilinx_dma_device_caps: caps->directions = 0x00000001
<4>[    0.302404] dma_slave_caps:
<4>[    0.302406]   src_addr_widths    = 0x00000000
<4>[    0.302409]   dst_addr_widths    = 0x00000000
<4>[    0.302412]   directions         = 0x00000001
<4>[    0.302415]   min_burst          = 0x00000000
<4>[    0.302418]   max_burst          = 0x00000000
<4>[    0.302421]   max_sg_burst       = 0x00000000
<4>[    0.302423]   cmd_pause          = 0x00
<4>[    0.302426]   cmd_resume         = 0x00
<4>[    0.302429]   cmd_terminate      = 0x01
<4>[    0.302431]   residue_granularity= 0x00000001
<4>[    0.302434]   descriptor_reuse   = 0x00
<4>[    0.302437] <stack>
<4>[    0.302442] CPU: 3 UID: 0 PID: 40 Comm: kworker/u20:0 Not tainted 6.12.74-stable-standard-00032-g4c3d957ee56f #1
<4>[    0.302453] Hardware name: pdm3_10_001-2 (DT)
<4>[    0.302459] Workqueue: events_unbound deferred_probe_work_func
<4>[    0.302479] Call trace:
<4>[    0.302482]  dump_backtrace+0xd0/0x108
<4>[    0.302498]  show_stack+0x14/0x1c
<4>[    0.302510]  dump_stack_lvl+0x5c/0x78
<4>[    0.302521]  dump_stack+0x14/0x1c
<4>[    0.302530]  dma_get_slave_caps+0xf8/0x114
<4>[    0.302544]  dmaengine_pcm_new+0x190/0x29c
<4>[    0.302557]  snd_soc_pcm_component_new+0x50/0x88
<4>[    0.302566]  soc_new_pcm+0x520/0x618
<4>[    0.302575]  snd_soc_bind_card+0x6cc/0xa48
<4>[    0.302585]  snd_soc_register_card+0xec/0x100
<4>[    0.302593]  devm_snd_soc_register_card+0x48/0x88
<4>[    0.302603]  simple_probe+0x370/0x380
<4>[    0.302611]  platform_probe+0x64/0xb0
<4>[    0.302623]  really_probe+0x18c/0x32c
<4>[    0.302633]  __driver_probe_device+0x120/0x138
<4>[    0.302643]  driver_probe_device+0x38/0xf0
<4>[    0.302653]  __device_attach_driver+0x100/0x114
<4>[    0.302664]  bus_for_each_drv+0xac/0xd4
<4>[    0.302673]  __device_attach+0xe4/0x164
<4>[    0.302683]  device_initial_probe+0x10/0x18
<4>[    0.302693]  bus_probe_device+0x38/0x9c
<4>[    0.302702]  deferred_probe_work_func+0xc8/0xdc
<4>[    0.302712]  process_scheduled_works+0x18c/0x23c
<4>[    0.302725]  worker_thread+0x140/0x1c0
<4>[    0.302736]  kthread+0xd8/0xe8
<4>[    0.302747]  ret_from_fork+0x10/0x20
<4>[    0.302756] </stack>
<4>[    0.303089] dma_slave_caps:
<4>[    0.303092]   src_addr_widths    = 0x00000000
<4>[    0.303096]   dst_addr_widths    = 0x00000000
<4>[    0.303099]   directions         = 0x00000000
<4>[    0.303102]   min_burst          = 0x00000000
<4>[    0.303105]   max_burst          = 0x00000000
<4>[    0.303107]   max_sg_burst       = 0x00000000
<4>[    0.303110]   cmd_pause          = 0x00
<4>[    0.303113]   cmd_resume         = 0x00
<4>[    0.303116]   cmd_terminate      = 0x00
<4>[    0.303119]   residue_granularity= 0x00000000
<4>[    0.303121]   descriptor_reuse   = 0x00
<4>[    0.303124] xilinx_dma_device_caps: caps->directions = 0x00000002
<4>[    0.303128] xilinx_dma_device_caps: caps->directions = 0x00000002
<4>[    0.303131] dma_slave_caps:
<4>[    0.303133]   src_addr_widths    = 0x00000000
<4>[    0.303135]   dst_addr_widths    = 0x00000000
<4>[    0.303138]   directions         = 0x00000002
<4>[    0.303141]   min_burst          = 0x00000000
<4>[    0.303144]   max_burst          = 0x00000000
<4>[    0.303147]   max_sg_burst       = 0x00000000
<4>[    0.303149]   cmd_pause          = 0x00
<4>[    0.303152]   cmd_resume         = 0x00
<4>[    0.303155]   cmd_terminate      = 0x01
<4>[    0.303158]   residue_granularity= 0x00000001
<4>[    0.303161]   descriptor_reuse   = 0x00
<4>[    0.303163] <stack>
<4>[    0.303176] Hardware name: pdm3_10_001-2 (DT)
.....
.....
.....
<6>[    7.102399] macb ff0c0000.ethernet eth1: Link is Up - 100Mbps/Full - flow control tx
<3>[    7.458535] lima fd4b0000.gpu: resume clk fail -13
<6>[    7.683306] input: PDM3 virtual keyboard as /devices/virtual/input/input3
<4>[    7.762300] dma_slave_caps:
<4>[    7.762316]   src_addr_widths    = 0x00000000
<4>[    7.762322]   dst_addr_widths    = 0x00000000
<4>[    7.762325]   directions         = 0x00000000
<4>[    7.762328]   min_burst          = 0x00000000
<4>[    7.762331]   max_burst          = 0x00000000
<4>[    7.762334]   max_sg_burst       = 0x00000000
<4>[    7.762337]   cmd_pause          = 0x00
<4>[    7.762341]   cmd_resume         = 0x00
<4>[    7.762344]   cmd_terminate      = 0x00
<4>[    7.762347]   residue_granularity= 0x00000000
<4>[    7.762350]   descriptor_reuse   = 0x00
<4>[    7.762354] xilinx_dma_device_caps: caps->directions = 0x00000001
<4>[    7.762358] xilinx_dma_device_caps: caps->directions = 0x00000001
<4>[    7.762361] dma_slave_caps:
<4>[    7.762364]   src_addr_widths    = 0x00000000
<4>[    7.762366]   dst_addr_widths    = 0x00000000
<4>[    7.762370]   directions         = 0x00000001
<4>[    7.762373]   min_burst          = 0x00000000
<4>[    7.762376]   max_burst          = 0x00000000
<4>[    7.762379]   max_sg_burst       = 0x00000000
<4>[    7.762382]   cmd_pause          = 0x00
<4>[    7.762385]   cmd_resume         = 0x00
<4>[    7.762387]   cmd_terminate      = 0x01
<4>[    7.762390]   residue_granularity= 0x00000001
<4>[    7.762394]   descriptor_reuse   = 0x00
<4>[    7.762397] <stack>
<4>[    7.762416] Hardware name: pdm3_10_001-2 (DT)
<4>[    7.762422] Call trace:
<4>[    7.762425]  dump_backtrace+0xd0/0x108
<4>[    7.762447]  show_stack+0x14/0x1c
<4>[    7.762459]  dump_stack_lvl+0x5c/0x78
<4>[    7.762471]  dump_stack+0x14/0x1c
<4>[    7.762480]  dma_get_slave_caps+0xf8/0x114
<4>[    7.762495]  snd_dmaengine_pcm_refine_runtime_hwparams+0x60/0x15c
<4>[    7.762510]  dmaengine_pcm_open+0x180/0x1a8
<4>[    7.762524]  snd_soc_component_open+0x50/0x5c
<4>[    7.762532]  __soc_pcm_open+0x84/0x3a4
<4>[    7.762542]  soc_pcm_open+0x28/0x44
<4>[    7.762550]  snd_pcm_open_substream+0x4ec/0x750
<4>[    7.762560]  snd_pcm_open+0xb8/0x1ec
<4>[    7.762568]  snd_pcm_playback_open+0x48/0x70
<4>[    7.762576]  snd_open+0x150/0x15c
<4>[    7.762587]  chrdev_open+0x170/0x198
<4>[    7.762601]  do_dentry_open+0x2f8/0x3a4
<4>[    7.762613]  vfs_open+0x24/0x44
<4>[    7.762621]  path_openat+0x8cc/0xa04
<4>[    7.762629]  do_filp_open+0x60/0xd0
<4>[    7.762636]  do_sys_openat2+0xa0/0xec
<4>[    7.762644]  do_sys_open+0x44/0x6c
<4>[    7.762652]  __arm64_sys_openat+0x1c/0x24
<4>[    7.762659]  invoke_syscall+0x68/0xf0
<4>[    7.762671]  el0_svc_common.constprop.0+0xb0/0xcc
<4>[    7.762682]  do_el0_svc+0x18/0x20
<4>[    7.762693]  el0_svc+0x18/0x44
<4>[    7.762705]  el0t_64_sync_handler+0x80/0x124
<4>[    7.762717]  el0t_64_sync+0x14c/0x150
<4>[    7.762726] </stack>
.....
.....
.....
<5>[   40.293549] audit: type=1327 audit(1772610878.644:23): proctitle=737368643A20726F6F74205B707269765D
<4>[   44.792575] dma_slave_caps:
<4>[   44.792589]   src_addr_widths    = 0x00000000
<4>[   44.792593]   dst_addr_widths    = 0x00000000
<4>[   44.792596]   directions         = 0x00000000
<4>[   44.792599]   min_burst          = 0x00000000
<4>[   44.792602]   max_burst          = 0x00000000
<4>[   44.792606]   max_sg_burst       = 0x00000000
<4>[   44.792609]   cmd_pause          = 0x00
<4>[   44.792612]   cmd_resume         = 0x00
<4>[   44.792614]   cmd_terminate      = 0x00
<4>[   44.792618]   residue_granularity= 0x00000000
<4>[   44.792621]   descriptor_reuse   = 0x00
<4>[   44.792624] xilinx_dma_device_caps: caps->directions = 0x00000001
<4>[   44.792628] xilinx_dma_device_caps: caps->directions = 0x00000001
<4>[   44.792631] dma_slave_caps:
<4>[   44.792633]   src_addr_widths    = 0x00000000
<4>[   44.792636]   dst_addr_widths    = 0x00000000
<4>[   44.792639]   directions         = 0x00000001
<4>[   44.792642]   min_burst          = 0x00000000
<4>[   44.792645]   max_burst          = 0x00000000
<4>[   44.792648]   max_sg_burst       = 0x00000000
<4>[   44.792651]   cmd_pause          = 0x00
<4>[   44.792654]   cmd_resume         = 0x00
<4>[   44.792656]   cmd_terminate      = 0x01
<4>[   44.792659]   residue_granularity= 0x00000001
<4>[   44.792662]   descriptor_reuse   = 0x00
<4>[   44.792665] <stack>
<4>[   44.792671] CPU: 3 UID: 0 PID: 1225 Comm: aplay Not tainted 6.12.74-stable..
<4>[   44.792684] Hardware name: pdm3_10_001-2 (DT)
<4>[   44.792689] Call trace:
<4>[   44.792692]  dump_backtrace+0xd0/0x108
<4>[   44.792713]  show_stack+0x14/0x1c
<4>[   44.792725]  dump_stack_lvl+0x5c/0x78
<4>[   44.792737]  dump_stack+0x14/0x1c
<4>[   44.792746]  dma_get_slave_caps+0xf8/0x114
<4>[   44.792761]  snd_dmaengine_pcm_refine_runtime_hwparams+0x60/0x15c
<4>[   44.792775]  dmaengine_pcm_open+0x180/0x1a8
<4>[   44.792788]  snd_soc_component_open+0x50/0x5c
<4>[   44.792796]  __soc_pcm_open+0x84/0x3a4
<4>[   44.792805]  soc_pcm_open+0x28/0x44
<4>[   44.792813]  snd_pcm_open_substream+0x4ec/0x750
<4>[   44.792822]  snd_pcm_open+0xb8/0x1ec
<4>[   44.792830]  snd_pcm_playback_open+0x48/0x70
<4>[   44.792838]  snd_open+0x150/0x15c
<4>[   44.792849]  chrdev_open+0x170/0x198
<4>[   44.792863]  do_dentry_open+0x2f8/0x3a4
<4>[   44.792875]  vfs_open+0x24/0x44
<4>[   44.792882]  path_openat+0x8cc/0xa04
<4>[   44.792890]  do_filp_open+0x60/0xd0
<4>[   44.792897]  do_sys_openat2+0xa0/0xec
<4>[   44.792905]  do_sys_open+0x44/0x6c
<4>[   44.792912]  __arm64_sys_openat+0x1c/0x24
<4>[   44.792920]  invoke_syscall+0x68/0xf0
<4>[   44.792931]  el0_svc_common.constprop.0+0xb0/0xcc
<4>[   44.792942]  do_el0_svc+0x18/0x20
<4>[   44.792953]  el0_svc+0x18/0x44
<4>[   44.792964]  el0t_64_sync_handler+0x80/0x124
<4>[   44.792977]  el0t_64_sync+0x14c/0x150
<4>[   44.792985] </stack>


>To quickly test theory (2), you could then comment out the caps->
>assignments in dma_get_slave_caps() and check if this fixes your issue
>or not.

I have applied 7e01511443c3, kept RFC patch(xilinx_dma_device_caps + printk)
and dmaengine.c debug patch applied (dma_slave_caps_printk() + dump_stack())
and comment out the caps->assignments in dma_get_slave_caps() 

Observation:Audio works normally.
logs:
root@pdm3:~# dmesg | grep xilinx_dma_device_caps
[    0.301728] xilinx_dma_device_caps: caps->directions = 0x00000000
[    0.301731] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.302421] xilinx_dma_device_caps: caps->directions = 0x00000000
[    0.302424] xilinx_dma_device_caps: caps->directions = 0x00000002
[    5.882992] xilinx_dma_device_caps: caps->directions = 0x00000000
[    5.882996] xilinx_dma_device_caps: caps->directions = 0x00000001
root@pdm3:~# 
root@pdm3:~# aplay closetoyou.wav 
Playing WAVE 'closetoyou.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
root@pdm3:~# aplay closetoyou.wav 
Playing WAVE 'closetoyou.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
root@pdm3:~# aplay closetoyou.wav 
Playing WAVE 'closetoyou.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
^X^X^CAborted by signal Interrupt...
root@pdm3:~# dmesg | grep xilinx_dma_device_caps
[    0.301728] xilinx_dma_device_caps: caps->directions = 0x00000000
[    0.301731] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.302421] xilinx_dma_device_caps: caps->directions = 0x00000000
[    0.302424] xilinx_dma_device_caps: caps->directions = 0x00000002
[    5.882992] xilinx_dma_device_caps: caps->directions = 0x00000000
[    5.882996] xilinx_dma_device_caps: caps->directions = 0x00000001
[  324.413686] xilinx_dma_device_caps: caps->directions = 0x00000000
[  324.413689] xilinx_dma_device_caps: caps->directions = 0x00000001
[  348.022906] xilinx_dma_device_caps: caps->directions = 0x00000000
[  348.022910] xilinx_dma_device_caps: caps->directions = 0x00000001
[  402.654943] xilinx_dma_device_caps: caps->directions = 0x00000000
[  402.654946] xilinx_dma_device_caps: caps->directions = 0x00000001
[  423.598936] xilinx_dma_device_caps: caps->directions = 0x00000000
[  423.598940] xilinx_dma_device_caps: caps->directions = 0x00000001



