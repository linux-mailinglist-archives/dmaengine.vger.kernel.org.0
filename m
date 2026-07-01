Return-Path: <dmaengine+bounces-11910-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qeRfKWaqRGqmygoAu9opvQ
	(envelope-from <dmaengine+bounces-11910-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 07:49:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE5D6E9ED3
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 07:49:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OuamfCY4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11910-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11910-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1519B303AA89
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 05:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157938F95A;
	Wed,  1 Jul 2026 05:47:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCD376481
	for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2026 05:47:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884866; cv=none; b=Gyb17BfIVVFZ4oRFUzsnhl/vWxyG4bLjlbuZWj3UTwfBlktFxhXlPF2z5wNY72Hi8/NlQkW9I7ZGK2FHHzf/xKDcd8pMG0oTkI1NTue+aXo+9c+mgsuVs8aGU+Efk79ZKhQKIEZzI1dFoKCbvVmPvQb0xd8ymqd/VLbp3v287Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884866; c=relaxed/simple;
	bh=7C10BvrXP330gVepTXYy6sfoFfKbPAmHgg+xOWMPMtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN5/w5ZQF2p/V2vQW0yq2Ru2C7DpV7tXA+oQrZCxS2EuBDrYEWg+D+RTn7e+98E/7Ij+k21Rx43jF3WjcpOfGwXhEV+ctSI53LuN6ebocfG624iQp3a7yaNcsdKeBmeruGYbyol4vsn8Vqo4JnrI0CEFEMQ8NtO3GVTi8rq4afI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuamfCY4; arc=none smtp.client-ip=74.125.224.42
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664eb8cb631so188995d50.3
        for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 22:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782884864; x=1783489664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2dYl0OUyzZ06MfTi9YwzB+RT+fpto3AMtLt5rd0qn0=;
        b=OuamfCY4k72H1mE1nACydZMPqN55KO/q8WL85gQLOx03Nsvlav2rXGy5PMoPNkZu4f
         aPIBTXWa/1lF/2QbPDGR6bysAk1Xr2RbvugtqbNBUJaGwymyluTpHiNVOFC4URgA3Tn1
         KEN6C9DyczEbm9MZcMLROlTPbPYKl55YkymHsvrEoDjnytMOLyaCtXz0xpuZvi3EsgP8
         xYKmjX+9reEa3ZSjEaW82sOT/0cvya1ZjFda8cFQ/LyjCeocO363jSz3kIp3GZz3RJZp
         XHeawHTGoW6vx7Coc2lWdzstNeRL3MIvM7ZOaRfnSbiAsQZZgGsM7DFhKEZVs+j3aNNw
         FHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782884864; x=1783489664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2dYl0OUyzZ06MfTi9YwzB+RT+fpto3AMtLt5rd0qn0=;
        b=SmNWZSh86sD+UNNqBSBepAIbGOINckTN1EfFr4i/CXpXOOb0D+5tJIZOkFgXH+qLb1
         EF1VLYVM32JMuypuKp1o+UiSvS+t15jscXOU5p3ANZXgVgtQY8cfOUolJmq2aqGE2xyM
         r7869+uE7UjjODK6oMX3jUADRPC9fFmh2Oum/DN+kjquwBv99z1cKWfSAO22SzCM1pnI
         c7gdACT8hOnVUM4aiveOb2Ua5BZxKENSsQl2pMp5hCTW1m/FHuh+jq6xzSuBLBUx9h7K
         Hmx8LDXiMRqTYJQFYSrI3PTAntdLGMdGLHBN1Xansh0AFz3OuIt2Xg081KAw/aSBfLbQ
         CTrQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmadKtrMqp0VpVtudsFlnOzNcGzSYVOMFrYGtnOTYNp7C4WDRvBbzNOM9Uf9X7b2C91ltI84LY0Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3HNso8QsBq+q38NUKxAZzUuhrRxgPLt5LCtWw1nyLL4U9697
	ZI1y0ReG5ADMTq2jbgGoLS9ya+I06NA4nyk4aIVmkOC7jjLxvWIMvyLZ
X-Gm-Gg: AfdE7ck+RxHG5iI8PogEzlfOfgbo9MyUsfc31tkBeiH78y/C1+Kx8hnaVmiALESgbs1
	hX7BXb4Vni/9yJ65GnozsebNfZl0eYCLOwiDdWVsTQzSzf7yVwDRFG+r16MmxceQbUfoEIXZPOn
	WJD1tHAvNt2KJ97pgnF9PBycz0t8bpJ8X6Gv/P6oeMHvF7vT6LJCnc8Aw4nzM+ztEOt5qHRujjW
	qJYBxOPin/JU958Kg5wTjb/cWnPncTPbIiZL0T26klx6+ifj6kvsHjvXpObceziKUv8+AR92xTJ
	95PNfurMpDe1QDyk3Gk2eJSg3vb13bH0jZ5QlBULw1zsv5PpBGOgcrZJG+ho9pueOy7ZKMy8vQR
	V4im3NTb91k6qMTDVUDlZL4GnevNZkuuZl76rXbTwMhUHJ0rdPrDqkf9buNcHLQHAPibShdVI47
	Rz6d2A61hXA+P7LmhlUQVuevb1NHR4EWVBarg6N0es4nH/TYUCMsZiSeBeQ8WD
X-Received: by 2002:a05:690e:bcd:b0:664:d899:e3a9 with SMTP id 956f58d0204a3-665219a787dmr223821d50.20.1782884864130;
        Tue, 30 Jun 2026 22:47:44 -0700 (PDT)
Received: from AMD.home.local (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6650163752bsm1836441d50.16.2026.06.30.22.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 22:47:43 -0700 (PDT)
From: Enzo Adriano <enzo.adriano.code@gmail.com>
To: Yuanshen Cao <alex.caoys@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>
Cc: conor+dt@kernel.org,
	mripard@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	samuel@sholland.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	Frank.Li@kernel.org,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/5] dmaengine: sun6i-dma: Refactor to support A733 interrupt and register handling
Date: Wed,  1 Jul 2026 01:47:01 -0400
Message-ID: <20260701054701.3961908-1-enzo.adriano.code@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <akQuefaUpt6OPNSo@b82beb281c41>
References: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com> <20260622-sun60i-a733-dma-v3-1-f697ef296cbc@gmail.com> <20260629003505.18f0053d@ryzen.lan> <akQuefaUpt6OPNSo@b82beb281c41>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11910-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:andre.przywara@arm.com,m:conor+dt@kernel.org,m:mripard@kernel.org,m:krzk+dt@kernel.org,m:robh@kernel.org,m:samuel@sholland.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Frank.Li@nxp.com,m:alexcaoys@gmail.com,m:conor@kernel.org,m:krzk@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,arm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enzoadrianocode@gmail.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,sholland.org,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,nxp.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enzoadrianocode@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DE5D6E9ED3

Hi Yuanshen, Andre,

I applied the v3 series locally on top of dc59e4fea9d8. The
series applied cleanly, the focused DMA binding check passed, and
a focused drivers/dma/sun6i-dma.o build passed. I have not done a
hardware DMA runtime test, so this is only static review plus
build/schema validation.

On the IRQ accessor shape, I think Andre's data-driven direction is
a good fit for the enable/status register differences. The
A733-specific values look like data: enable offset 0x134, status
offset 0x138, stride 0x40. A small helper using cfg offsets/stride
would keep the call sites readable without needing per-compatible
read/write accessors. I would keep dump_com_regs separate unless
there is a clean table-driven way to express the genuinely different
dump layout.

While comparing this with the public Sun60iw2 BSP, I think the same
respin should also fix the interrupt channel decode path that Sashiko
pointed out. The series encodes the interrupt register as:

  irq_reg = pchan->idx / sdev->cfg->num_channels_per_reg;
  irq_offset = pchan->idx % sdev->cfg->num_channels_per_reg;

but the interrupt handler still decodes with:

  pchan = sdev->pchans + j;

For A733, num_channels_per_reg is 1, so j is always 0 and each IRQ
status register would map back to pchans[0]. The public Sun60iw2 BSP
uses the inverse mapping:

  pchan = sdev->pchans + (i * sdev->cfg->channum_per_reg + j);

That matches the encode path and looks like the shape needed here as
well. The register-loop bounds probably want the same treatment:
derive the number of IRQ status registers from the real channel count,
not from an implicitly exact division.

