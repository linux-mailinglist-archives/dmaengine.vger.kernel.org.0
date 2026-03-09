Return-Path: <dmaengine+bounces-9329-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEE8L6d2rmk2FAIAu9opvQ
	(envelope-from <dmaengine+bounces-9329-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:28:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB76234C83
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2870300B3DA
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7A364949;
	Mon,  9 Mar 2026 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghf8dkXF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD735DA41
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041316; cv=none; b=WMpKom9gVrmKYp5mwDwvc9U+JialFr5A7soEZZ+/jCTFX4krrorTPDF8oahHmMRrxzZWUHAuvTDTWlO3JuUTgo8heYJ08lntIyCYdbW4yKRAbswIMsAd2GRBH3rZJw9g3B/V2IsHzRpKaTZeedqG+GYXByaROpU6j5PWeUpqY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041316; c=relaxed/simple;
	bh=zqHyu5BLlJlfFxRJmPin56hK+Kz0AKd9xxcDTSySmbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hza3N6Zt0JJgJeKsFHr9esOCMjWmxNA3vyCJOf6rE6+ZIeEjspvPCSsOYZX/wkz/b6vV7LQSfR+VTmWnhbji5boO8ToY9HYF/kfZD3skJsg6WW7HLE632TiaM/0DXSLIQVQ7uEMtmsjh247hQ0ZiTULFsKDyQAPOE/fFF/tzVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghf8dkXF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae5636ab04so79558455ad.3
        for <dmaengine@vger.kernel.org>; Mon, 09 Mar 2026 00:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773041315; x=1773646115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqsxFLuyxJhQEEmd0utJQ36IBqsBbSUDIMj7Ym8aJFg=;
        b=ghf8dkXFTsZl4ju8/9zObFBJZ6Qti9ZTZ5SMRLT2OB1QZeNwL1n9lgwyqM6qb/pRQn
         L7VkP5Hk3Nfc969txBJfX4oHaDSOYmz4NsTkQcFw6NqDH2NEnK+EhxYUtx+XjG/2ToXb
         nRrhemX5mjlq/YL3YnMHPtBXW3QCfLSAat5l4f0uku17lZ0ckBRcfDw16aPpe0ii4e0U
         sSwW3ccd8VMzZYhVf74w+UQLDJA31AlaNQn3SUiV7F4WPE6R3fDaO/4oTdWJdomYmNPH
         vZDSXKtq+vPcrP9RHoapy3YnX6j59JXWAYge1SB5QCrw+lOVz299mlUh3s9a/STGwA7M
         vC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041315; x=1773646115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xqsxFLuyxJhQEEmd0utJQ36IBqsBbSUDIMj7Ym8aJFg=;
        b=vktce0HDGvs3kpM8/iWBsFBN298Wyoj+ZDA1moL2n4iKyBVl7ZuXDJIMdx7WnY4tJZ
         dFEfasGJ4U0+Ko7rBrOqsHOXaQlruxo6NiY2a2nLIGTwYEXU7mC3080aaVvAq2BY9q5e
         1uB51M0sLxcxzn4AIBoo/2SdHAHW0AdZYTgTJSqRCuH3hblulmOD2tT7EQQcxkAcHd+3
         UZXH799BYBHh9nUmt4xBnKAs/GJfCcic/f+tv2mswod8FjnYRe+FUsY3wtczQcNb9o59
         TGs+0avQ+GokWf7CTSoP0zCkNXnT1YNF+TKPmnlhJWJ1yyrC67VsZjMJfhm9yIIgXfvR
         8/fw==
X-Forwarded-Encrypted: i=1; AJvYcCXXUD/VgJVkqk0cI4HAKvliE+BC2yYu0e+FUI339WlBmgnX1fSBWa3ULZtY/upaSygM/ZiCxzGu4zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXArToUHze+sRKbF0MDOS1H/e6MGMilMTkDnOXguKR3JDHppik
	xtc2rtXsGddNquU69/MDUkfDHkdGNM71pnIUl0XecjikJ2InvkaAeM7b
X-Gm-Gg: ATEYQzxplhKk6MzAir30uUMRl2x+kOMxe9BwxfW7r0d9YbRZeaA3M+5L3tdR1hQ1J5S
	UvB7HYSk+S4HcbnUHYiBTgZi5/eFMEfzPOZ91h6GLzAW0aTIqNhjDHW1E4DsfKYeeBYUVzegK6k
	N3YNQoogKcVXEk5xk/pa/32ds8l8A0GBX9altcjFubA13lM7U+wRAqiCDp2dFvVZRLAxT46dqW2
	UCjC8ArHjWl95kxWs9ub4GjHmEb4wBgD0fARK/VxwpHkQFyIPegwKP0ppRGTo8X3703/eZU/FoT
	djKabM9Bb27OpA1esqyY/UA6DyEd+N9tRjnZbepJ10ZPutGapFq/7iHYSy7Q15othbXSXj949VA
	6VpVDQfO6VeTRlfNXvaJDmK2c2TxZA03Mio4gsHPwnu4TcfsU3efSv6Fv8Z2gvSTItNGZQJyXla
	OTODwIIJizO76Orl3U8CtninrR
X-Received: by 2002:a17:903:32c9:b0:2ad:d5ea:4c89 with SMTP id d9443c01a7336-2ae823a296emr99041725ad.22.1773041314889;
        Mon, 09 Mar 2026 00:28:34 -0700 (PDT)
Received: from bsp.. ([2401:4900:190e:b060:a09b:ad6e:b90e:b5ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e575f3sm138471255ad.8.2026.03.09.00.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 00:28:34 -0700 (PDT)
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
Date: Mon,  9 Mar 2026 12:58:21 +0530
Message-ID: <20260309072822.5016-1-rahulnavale04@gmail.com>
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
X-Rspamd-Queue-Id: 3BB76234C83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	TAGGED_FROM(0.00)[bounces-9329-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rahulnavale04@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ifm.com:email]
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

>Please undo the latest Xilinx DMA patch I sent.
>To get some more data, could you apply the following patch (keep RFC
>patch and debug stuff) and rerun with 7e01511443c3 a) applied and b)
>reverted and post logs for both cases:

I have applied provided patch (with kept RFC patch and debug stuff) and with
7e01511443c3 applied. logs:

root@pdm3:~# dmesg | grep xilinx_dma_device_caps                                                                                                                                         
[    0.285057] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.285060] xilinx_dma_device_caps: caps->directions = 0x00000001
[    0.285759] xilinx_dma_device_caps: caps->directions = 0x00000002
[    0.285763] xilinx_dma_device_caps: caps->directions = 0x00000002
[    7.535143] xilinx_dma_device_caps: caps->directions = 0x00000001
[    7.535147] xilinx_dma_device_caps: caps->directions = 0x00000001
root@pdm3:~# dmesg | grep ptr_res
root@pdm3:~# aplay closetoyou.wav 
Playing WAVE 'closetoyou.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
^CAborted by signal Interrupt...
aplay: pcm_write:2178: write error: Interrupted system call
root@pdm3:~# 
root@pdm3:~# dmesg | grep ptr_res
[  198.997591] ptr_res: ptr = 0x00000000
[  199.002885] ptr_res: ptr = 0x00000000
[  199.002900] ptr_res: ptr = 0x00000000
[  199.002925] ptr_res: ptr = 0x00000000
[  199.002946] ptr_res: ptr = 0x00000000
[  199.117775] ptr_res: ptr = 0x00000000
[  199.117818] ptr_res: ptr = 0x00000000
[  199.117839] ptr_res: ptr = 0x00000000
[  199.242766] ptr_res: ptr = 0x00000000
[  199.242800] ptr_res: ptr = 0x00000000
[  199.242820] ptr_res: ptr = 0x00000000


Also I have applied provided patch (with kept RFC patch and debug stuff) and with
7e01511443c3 reverted. logs:

root@pdm3:~# dmesg | grep xilinx_dma_device_caps
root@pdm3:~# dmesg | grep ptr_res
root@pdm3:~# aplay closetoyou.wav 
Playing WAVE 'closetoyou.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
^CAborted by signal Interrupt...
aplay: pcm_write:2178: write error: Interrupted system call
root@pdm3:~# 
root@pdm3:~# dmesg | grep ptr_res
[   60.480754] ptr_res_no: ptr = 0x00000000
[   60.486058] ptr_res_no: ptr = 0x00000000
[   60.486070] ptr_res_no: ptr = 0x00000000
[   60.486094] ptr_res_no: ptr = 0x00000000
[   60.486113] ptr_res_no: ptr = 0x00000000
[   60.600877] ptr_res_no: ptr = 0x00001770
[   60.600920] ptr_res_no: ptr = 0x00001770
[   60.600939] ptr_res_no: ptr = 0x00001770
[   60.600948] ptr_res_no: ptr = 0x00001770
[   60.600968] ptr_res_no: ptr = 0x00001770
[   60.602739] ptr_res_no: ptr = 0x00001770
[   60.602750] ptr_res_no: ptr = 0x00001770
[   60.725869] ptr_res_no: ptr = 0x00002ee0
[   60.725904] ptr_res_no: ptr = 0x00002ee0
[   60.725921] ptr_res_no: ptr = 0x00002ee0
[   60.725931] ptr_res_no: ptr = 0x00002ee0
[   60.725949] ptr_res_no: ptr = 0x00002ee0
[   60.727667] ptr_res_no: ptr = 0x00002ee0
[   60.727677] ptr_res_no: ptr = 0x00002ee0
[   60.850877] ptr_res_no: ptr = 0x00000000
[   60.850939] ptr_res_no: ptr = 0x00000000
[   60.850960] ptr_res_no: ptr = 0x00000000
[   60.850969] ptr_res_no: ptr = 0x00000000
[   60.851000] ptr_res_no: ptr = 0x00000000
[   60.852750] ptr_res_no: ptr = 0x00000000
[   60.852760] ptr_res_no: ptr = 0x00000000
[   60.975869] ptr_res_no: ptr = 0x00001770
[   60.975905] ptr_res_no: ptr = 0x00001770
[   60.975923] ptr_res_no: ptr = 0x00001770
...
...



