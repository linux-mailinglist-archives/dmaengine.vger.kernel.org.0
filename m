Return-Path: <dmaengine+bounces-9032-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE4wAf5wnWmAQAQAu9opvQ
	(envelope-from <dmaengine+bounces-9032-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 10:35:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 763D4184B1E
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 10:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81F93183327
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F8369220;
	Tue, 24 Feb 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5PkSxaM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D9304BBC
	for <dmaengine@vger.kernel.org>; Tue, 24 Feb 2026 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925456; cv=none; b=uKH+43KoU09z3uqc7gUBZMv65+podE0VIdnNiGIi11owVWvnQ24REgCbtnb6tNHYkd1K31+uMpKv+Skrn5ePGLSqZeVJRKyDKHs30g8oaMxmeEiT8WVYY9+TT08n3u6SWhqwQq2e1e4I2nTiZ3J4MAWqIAi7UcEPqdH7SOHlSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925456; c=relaxed/simple;
	bh=pP/H7SQ7kDYgmQ+jqMkmQHNlrIiDaSP02Y8vKbyocy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSuxckkRcfTWMr5hc8O88qfxgwVCemGBIf22p2nkQcqK7j+7m4TbqfNPHe+4wvXi+3wUbHTOQsT+BFWnnsc19YWq36Nxh/hPVX1BNG7GnuHAUjqrypaXfnt/QmoKs/AF8W8PV5CCLw1hdYepIYs/ekdVdI5jyd+vnI0WDEy+yEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5PkSxaM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824af5e5c81so4962148b3a.0
        for <dmaengine@vger.kernel.org>; Tue, 24 Feb 2026 01:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771925454; x=1772530254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP/H7SQ7kDYgmQ+jqMkmQHNlrIiDaSP02Y8vKbyocy0=;
        b=L5PkSxaMfyw1c57e8Emp0s5GTJhnUNa8WsKaXN2bcD1W3AAWP6SBZuJdm0IwrVvqqt
         QG1WzGA6zfZwPGqOIz75dxdeh3rjPAzlkypvLepG0oGMJjrBz6Ralxxis41GI1vJQiWE
         ZLcHSFkb15mjtvxsu3pMSzLAnhgEFhqv4ZVxJp4p2z233fszGWOPgJ3cSCbM2hjEq9ko
         7anW1qIILDzpJWGnOZ6VsMHkTeFLgh3BgobqrAxEfoThkyhHuigfc45+20+0NaJpC3cB
         xEKH/Jhz1vN39Vawpi6fZZyrP44eptrA/6pUH2nCVlRNCRAx3qHb2CaYXYGttpKrmUr+
         UzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771925454; x=1772530254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pP/H7SQ7kDYgmQ+jqMkmQHNlrIiDaSP02Y8vKbyocy0=;
        b=PKKFVmAeWlY58MbhqsSdUdq2odOlDnHCpcb8pmO0WFMbJzWF0kJRbuvdXvTS9IMASF
         pMk1IEwuZMJI/tusLX+mC255GWTfZfhRtn5+yEDpTttM/SyTJOb84U+ASO+oMDenTjB6
         NAFh5ulEarIDAyuHqYlCoxsozZ+moB13EPy5ZgsNq7JVIu2WOr5BQZ4gWE7VEIqSKSbC
         HX4ARlqG53KwekieCanoXE+DyKtsbei27pO9tWH9wTR5FGphwpTBewt7V6h82sJTHd/K
         0jmcXQ2uLUC8/XQ9LOpkPt8dThVYYlz7WkWb2hy80QlBwwFfoxj+56UHNETxSwj2fek0
         gqnw==
X-Forwarded-Encrypted: i=1; AJvYcCVSsHhO5iahYtnOxDzPzcXZqDLoLO1LvgvH/ACrsqKG1PoWY0aaeGaUlbsq2JmWdKYGaadrWlbzt0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKxGcDSVirQLfLWkiEPzrmi/UauaqHoEe7DRRtU4NtXr0y7LJ
	dxOOQr8wNkM9LiLXh5WznKJgcC4Nhl2gyTkEFq4ggXFK45HLIK8CvzQTzSARQw==
X-Gm-Gg: ATEYQzyI0Pxl0z20FNCpAztWj1a28Vtf800TzojD8W+j+73kUQyFdi2u5VtpSeQi/Fn
	ePbOFyJjLe35i7JDhuwjjcCHi6UClj2f+GMjsh+5iYDYC0J8TGbcs02cmDqlHGISTVL1lgsCm1Q
	i1V7BO/bg5a1fMkqllqAqH6gBrIfob6SFtcoeq7tgvS2NGWLCa7JVL1Fsj9UHZI3lvAvIh65zfd
	J5K7W8wfBO9NocesBYxRnLeG41Z3ufwPZoSxDJPhSXmOUI4Gs3LyW031iUkfI5lsIn0p7d1GPjQ
	h5ASCUqLKRXRuFxe/ZgHBqmdSX7kmbi0aAF9UEKlBXY4v7W2EbDiu4w1R9a99vD24j3duTQMZh4
	Eu/+v7HDj8yhKF+GRsy+ioLnzvWz9zaANBeuCjZ40QFUsfMNOFtLSCuqW1jMHHbgP1ezvL4iOXT
	G3XTmWtJO5TVefZ0uaW62IaQ==
X-Received: by 2002:a05:6a00:2da5:b0:824:b334:3053 with SMTP id d2e1a72fcca58-826da8f4a85mr9620099b3a.22.1771925454274;
        Tue, 24 Feb 2026 01:30:54 -0800 (PST)
Received: from bsp.. ([2401:4900:1b90:3a2c:517f:a983:9a1b:5289])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd86c5b6sm9780044b3a.32.2026.02.24.01.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:30:53 -0800 (PST)
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
	rahulnavale04@gmail.com
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction reporting via device_caps
Date: Tue, 24 Feb 2026 15:00:39 +0530
Message-ID: <20260224093041.38699-1-rahulnavale04@gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9032-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 763D4184B1E
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

>this is an important bit of information. Could you verify that your
>customized driver uses dmaengine's dma_get_slave_caps() to obtain
>channel capabilities and that the newly introduced
>xilinx_dma_device_caps() is actually called?

Hi Folker,

Thanks for the clarification — I misunderstood about custom drivers.

I have confirmed that we are using the upstream xilinx DMA driver (drivers/dma/xilinx/xilinx_dma.c)
and using AXI DMA for audio. We use separate fixed-direction channels:
MM2S for playback (DMA_MEM_TO_DEV) and S2MM for capture (DMA_DEV_TO_MEM), referenced
via device tree.

Thanks,
Rahul Navale


