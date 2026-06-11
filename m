Return-Path: <dmaengine+bounces-11474-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ABivFckjK2q83AMAu9opvQ
	(envelope-from <dmaengine+bounces-11474-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:08:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E26746755EE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:08:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=D5pm0Q+e;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11474-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11474-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065C0307D8D4
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428FA378D63;
	Thu, 11 Jun 2026 21:07:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D428C869
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:07:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212062; cv=none; b=JOM0CXnSrYS6cVryzZL0NCaMd3hfynRgkLtNUujvsd5CoX3VRbwC8loGl4+iPS4cKvup9tzUIZ+rYU7bhuiooIH+tS/bV9GKcMNnHRliMLtBwx9Ous0fzTD3z4olKte1OsaAsGrEaH7l7x6Kwtb1VcMP5t50wdeOXRHcCkP8G2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212062; c=relaxed/simple;
	bh=xEmlqIvkpWaJH2Yr7Zn4ewhDt1+aeFJXo3sELThlaLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=amk9gNEQXZ5oyp0EO3J+IqDWfrO8vdUguel09UZ/M3oNJu07k7T8u0qWVxYiujf7mDipKRBUWUN4F4AgLC8mpPCWclIi1FUdDGg9FK50CAs2aTzfgYT7oZozC2ABbuz1YtT9PW7QP80RZaKU94y30Yj7v9ueTn4/3c686dcSUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5pm0Q+e; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0b944f6edso2854785ad.2
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781212060; x=1781816860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7mgDvvq5LoW6Tm3JoYXyqxno0YSWh+OWyr58sNFFS8=;
        b=D5pm0Q+enswJJmzp/eG/L9szcku4IRc0rOhm+9oiCs1sMKGUQo7xxDNImu9OTbZGuH
         K4GGXZuBSr/CYqlC2pkzbfkU9mj+EJN7LrYN7jeogq5KvmOGHx1lt5Mmwg+86Pg2pFDs
         YeJbhKJ11pzKQRFfAZr+kpCoSIOUsj6Q8d/0UFmzu2Q/LPBnkag64hTmRK62V/JWx0yd
         v4G+ZbTDHq0pZR7MGZASgq/Yfz5qJv5MnNFr2dqyriPs9n8268zxQi8IVQ9qCgsRO3rN
         OIe1GXnlSK97pTuopHqQMCtTtzDGAEQXsrgYYnkILMGBIqBR7SAfc8VlU7IkAExIPZjV
         AtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212060; x=1781816860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7mgDvvq5LoW6Tm3JoYXyqxno0YSWh+OWyr58sNFFS8=;
        b=g45vVtYO9kncFwnYC25bQuP1Ylkse8tqCRBSARq/fzQpD+b2UmTo7KoRnDNieI8DII
         /m53zeb60EqOI0Vj6AtndiFfvy6oNXn2Y+9zIsLCnLJt9jMARRWvXsBBOClC1Nss+Cqf
         wfJz35dMRhl4H+6M+ZyNFdvdf0g2ADMVZ6d5UWRzumPm6MUzb1okPnK3JTT9R+k1c4oo
         aD36ZoCnSd7PshVitYO09OG/pFwncnqcv+K5sW0rRh41RhUbjiwgCvMiOiMU6cr4ePzk
         umulsD+qzexrofdHWzl55sFjDpMC2qRlQ/48ddFVgZilHdyNrGyx8JgjJhyxXftgLEqH
         iGmA==
X-Gm-Message-State: AOJu0Yy9b+LMfl8Es/y5phWFc7Lp3AMpuotGM9EcipVWQ6EmIUchk3MQ
	1cfiZgcc0P14zlEjCMFNFZBqJKsrs8wd0VX0CYKHp7i+yFKt2cv4dwYyfHRD8A==
X-Gm-Gg: Acq92OG+pGuIVBgAH5F1rYq7O2cxeewtyU9yjlhdcm4b5gULWi+M52UScJeUWlRF2ZK
	NTXVseKypHtrDp6rAeqld99XxEKY7nwQEd6mPt96kXDmUHpM7SOyza0eXIKpckQ52l7RcU0NbN7
	s/O7rlHmnb4WRKVUzr1bWj50WLGeND3X4KG0k+z/lJjUHSiPQdKn4LcpIo5g5g5sk7uDxTnkPVd
	ybRA8OKDJi+oNBVo9KPdeuDfT63UuHQzLKdLNS6hsTnaMet4jhwCK6JaCuAVS7QWcjJVahK0l1c
	Sl8e2y0Lh3T4sTtvBj1akIu/5ZGvBBy6P9rA6nHXk5f5zkdjrwgmXKB/ti1lyWBACsApulCv7wZ
	VbnALoMmq/h5UYEudWDsi7FnpnSFPw+E3ieKzIAxT3NFMkJU2N+Fwrt3wfpQselb0iwCz4zCo0P
	x4q/wueFksv2ztg+NBhqqJ0LCY+zFEUvL8+tLzZkLynAPWo2O3oCSUwPwgQdtvI9Y+lUCwF5KoU
	cYbq+opSap2hC5LbXkp4X2d1lJUxUapE38=
X-Received: by 2002:a17:903:458f:b0:2c2:25d8:d5a3 with SMTP id d9443c01a7336-2c40ff3e6e1mr1415825ad.3.1781212059750;
        Thu, 11 Jun 2026 14:07:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6d3a:64fc:4ee8:9cc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c411d79289sm389995ad.14.2026.06.11.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:07:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 0/9] dma: mv_xor: convert to devm resource management
Date: Thu, 11 Jun 2026 14:07:12 -0700
Message-ID: <20260611210721.81979-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11474-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thomas.petazzoni@free-electrons.com,m:gregory.clement@bootlin.com,m:mw@semihalf.com,m:robh@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E26746755EE

Convert the mv_xor driver to use managed device resources (devm)
to simplify error handling and removal paths.

Patch 5 replaces the open-coded clock acquire/enable/disable/put
with devm_clk_get_optional_enabled, eliminating manual clock
cleanup in the probe error path.

Patch 6 adds the missing platform remove callback so that
channels, DMA devices, and IRQs are properly cleaned up on
driver unbind.

Patch 7 converts DMA pool allocation and IRQ requests to their
devm counterparts, allowing removal of the err_free_irq and
err_free_dma error labels.

v2: add more sashiko fixes.

Rosen Penev (9):
  dmaengine: mv_xor: initialize chan state before requesting IRQ
  dmaengine: mv_xor: fix use-after-free in probe error path
  dmaengine: mv_xor: bound maximum channels for Armada 37xx
  dmaengine: mv_xor: abort channel before freeing resources on timeout
  dmaengine: mv_xor: use devm_clk_get_optional_enabled
  dmaengine: mv_xor: switch to of_irq_get()
  dmaengine: mv_xor: use devm for dma pool and irq
  dmaengine: mv_xor: allocate dummy buffers with dmam_alloc_coherent
  dmaengine: mv_xor: add missing platform remove function

 drivers/dma/mv_xor.c | 161 +++++++++++++++++++++----------------------
 drivers/dma/mv_xor.h |   4 +-
 2 files changed, 81 insertions(+), 84 deletions(-)

--
2.54.0


