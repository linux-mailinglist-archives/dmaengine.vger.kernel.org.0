Return-Path: <dmaengine+bounces-9127-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKd+A8P3n2nkfAQAu9opvQ
	(envelope-from <dmaengine+bounces-9127-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 08:35:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F41A1E4E
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 08:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE9E301E3C3
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 07:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467F038BF8F;
	Thu, 26 Feb 2026 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir9n3OMG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AE38F229
	for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091325; cv=none; b=GmqN/eYs0kv0ZVcHC+WhBBA1RIOm0ItceCh0tyK5tO/o4EbeSVBQuHFLwX9JxLzGBL9Nv3+9LvPSyXdcJZED6p0+oR9Z3GsuvJkW0djTO87wMTPflS30yIHDsVORzUkCSOQNJKSbuUmGsMgpgpBTXmGcBUxI8v/nZHSeQU9IOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091325; c=relaxed/simple;
	bh=GRpChhkibPnE81Vs5tSKu9WYmNq2s8Hfhl8XfvSpVDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/Sd57kM5K2VtLgmYnPRtjUrCWqE1o/Jh/nAn3FhDcekQTUg6FAzGBs0TiLlUFDDEU9japKgAo426sTKWSFATpShwgsTCMJ1qkeanxxWmDlJUIfwd07La2s4umUPI6soT5bppigg9sl/qZGWD5PK2Antsb3qWt/zhyTRqe9fDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir9n3OMG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358ed67cd4bso195014a91.0
        for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 23:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772091323; x=1772696123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjwWk+G+/TUPJF2k6R6TFJ4vHNubRr+a3SM993Y7NM0=;
        b=ir9n3OMGi0UzxXWk0xUWcBH79lIolB/zhsMTzRO0BKt4vs+mgY1+dLJv1V9hsZRK4Y
         dwsKKUzadAzbK75kUFuVLFbK01i2thEein6A7TiL40SZyChyKit1xgZvPOpVuGGa9Eti
         bjd3AwflJLpzn6puh6q2mphLRVyUi0wGe5Ei44ULyVX8nfSr2TJb8y4zP5ncADPf9Kbx
         15TjLSZpRqH64WB/FR3OnTElE4eLUf5gBfzMV6VvCW/EpV585vsf6FrRIqY89YmgBlSX
         SIEz3AiVPueOj/MjssHPcz3oAFd/7xDROy9zJoVtK1tJWp4y/a0HaEMy0mbxOwrZpnzY
         TZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772091323; x=1772696123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjwWk+G+/TUPJF2k6R6TFJ4vHNubRr+a3SM993Y7NM0=;
        b=XC1Do+CQAPc7eQsGeKYkK0i/3PqqIsMXg8XXst6RfxQ63VKf34kH94kK4aIx0AfNIs
         xbm1ivjWKhTj3cN/AhCqWZTh270Jvxt1B9PCKuTHI0/Ru4e+93ssATVfgehPg+UbYUys
         Gi3G39lXTMnoHmCTq4Du8l3Mz49SJGKk8FkXWg4G8v7jNP664kkXRCfDDrImnMZxgmYF
         iC6ciW6PZVW/84HQVBamfY4WHtb8d92aazvrG0F29c+UNMv11tu9P0XtAm0cphECQlz7
         fAXqOh6ljDKuJeOR7OJ5/HdGvD3HFjgqKp0vp5kanIH87u8D0X3L2FXukYWSj9Sbs9x+
         7Nuw==
X-Forwarded-Encrypted: i=1; AJvYcCUUP/eIS/wSBVSkBPC6kbCwY/F0b0cvy6Xoadv81ZeYEsyInVP5und9mYXzybU8IMktLPf8g22zjN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfgj+DRiNji4zP5OCun3AfL++UtNB6Sv1D56Dt2R0cYqoCdT2
	suk1sMc5zhKsA5QJgD/48T5AwopaRu8+S9ze3HXR/8AsC9yUC2bGzSO6
X-Gm-Gg: ATEYQzw5/E5fXvYsrf7TOiVvsGUHAr6NsD8wRUy/VWB7q+G9M8i8CRInX0TVgqbylu8
	3++Vw6qskfdCbiYTpIDcUZV8+nxJq/FrXt0PysLZ87ZYqUPfsxBOfzmqjrItGlv82yd0FhoSEJw
	5SEhSdnAbjgpPMAexMgCCBSTP+YE16O9GXRxyjlYhSXz/TCd2hu0cSWdZSDklFjVuGfZ2xi9JFB
	CZ5R6W2miouiXKYpi5KNw6DQkNP7d1p6AawnUBooLqAkCyprvSBUxq071ggaekk6wF6nreVRdxo
	pDsXjjQKBJT4+ysofyuXinF/vYDSRFPdqCs0CnuZuwI3JO/UXoflVDt5HTGfgNND/IJSUPCzeE7
	Wnf/fs2R3u/pf9JnB1sKFHZSpF0U/H73ghxJmhFzEid9s0F0bp3+R1DkO6b9taDPC2VNHFkDWum
	2cYbPfx8fYMVh3SWSLYEk/Ne7g
X-Received: by 2002:a17:90b:1f8d:b0:352:d933:5574 with SMTP id 98e67ed59e1d1-359388660e4mr1649107a91.9.1772091323293;
        Wed, 25 Feb 2026 23:35:23 -0800 (PST)
Received: from bsp.. ([2401:4900:52be:501d:b08a:5e82:d282:1ddb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359130712bcsm2030763a91.7.2026.02.25.23.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:35:22 -0800 (PST)
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
Date: Thu, 26 Feb 2026 13:05:10 +0530
Message-ID: <20260226073512.4595-1-rahulnavale04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	TAGGED_FROM(0.00)[bounces-9127-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rahulnavale04@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pdm3:email,ifm.com:email]
X-Rspamd-Queue-Id: 628F41A1E4E
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

>in the RFC patch, rebuild and exercise your use case. Then please do
>dmesg|grep xilinx_dma_device_caps

Hi Folker,

Thanks for the suggestion.
I applied your RFC patch and added printk() in xilinx_dma_device_caps()
around the assignment of caps->directions.

After rebuilding and booting, I exercised the audio playback use case
and collected the requested logs. The callback is reached and prints
appear both during early boot and during playback. Issue still persists.
cyclic playback fails after the first buffer period.

Output of `dmesg | grep xilinx_dma_device_caps`:
root@pdm3:~# aplay closetoyou.wav
Playing WAVE 'closetoyou.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
^CAborted by signal Interrupt...
aplay: pcm_write:2178: write error: Interrupted system call
root@pdm3:~# aplay closetoyou.wav root@pdm3:~# dmesg | grep xilinx_dma_device_caps
[    0.318827] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.318832] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.319170] xilinx_dma_device_caps: caps->directions = 0x00000002
[    0.319175] xilinx_dma_device_caps: caps->directions = 0x00000002
[    6.375745] xilinx_dma_device_caps: caps->directions = 0x00000001
[    6.375762] xilinx_dma_device_caps: caps->directions = 0x00000001
[  133.401497] xilinx_dma_device_caps: caps->directions = 0x00000001
[  133.401513] xilinx_dma_device_caps: caps->directions = 0x00000001
root@pdm3:~#
root@pdm3:~# aplay closetoyou.wav
Playing WAVE 'closetoyou.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo

aplay: pcm_write:2178: write error: Interrupted system call
root@pdm3:~# aplay closetoyou.wav root@pdm3:~# dmesg | grep xilinx_dma_device_caps
[    0.318827] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.318832] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.319170] xilinx_dma_device_caps: caps->directions = 0x00000002
[    0.319175] xilinx_dma_device_caps: caps->directions = 0x00000002
[    6.375745] xilinx_dma_device_caps: caps->directions = 0x00000001
[    6.375762] xilinx_dma_device_caps: caps->directions = 0x00000001
[  133.401497] xilinx_dma_device_caps: caps->directions = 0x00000001
[  133.401513] xilinx_dma_device_caps: caps->directions = 0x00000001
[  167.802636] xilinx_dma_device_caps: caps->directions = 0x00000001
[  167.802651] xilinx_dma_device_caps: caps->directions = 0x00000001


