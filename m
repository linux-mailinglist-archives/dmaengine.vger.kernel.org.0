Return-Path: <dmaengine+bounces-9002-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOOwGcWxmWnlWAMAu9opvQ
	(envelope-from <dmaengine+bounces-9002-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 21 Feb 2026 14:23:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC916CE5E
	for <lists+dmaengine@lfdr.de>; Sat, 21 Feb 2026 14:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26651301B91B
	for <lists+dmaengine@lfdr.de>; Sat, 21 Feb 2026 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB49E1A9FBA;
	Sat, 21 Feb 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDH1Mv7c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AA1B983F
	for <dmaengine@vger.kernel.org>; Sat, 21 Feb 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771680172; cv=none; b=oeSR+7fwmori9/eg2fg0wvnAoSHYzW+VnyD+ZvtTQd4n27NXwE9ehyytRdARiV1IoWnQR8V0qxRpy9pEh7eIJxYCSVoAnd3uUvHcPRGjt6Xvbhs1xvGFNJZkDexvClZFBh7sOl0j3ORQ3rxJ2vXYejMfTHA2k3PwV0El2rmcbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771680172; c=relaxed/simple;
	bh=u4tkeMBd6TV9g/42hIkxMn2b7DOkutkdqjZPSExMCXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NkKsoZJZxfi5rxJr5LVgz38Vhx94B+uq3bJIkDpGuK8OyK4hbsdfbfm4jw6W93HalyP2KIqJfbwK2+yI3gDCCQySHccLZkTXrb9ziWUHP1DpOEI/Nn3U+PoF/JkXAH9O3JiGwBya9sy/uR20gfVt1OlctkM8zwnmAleAS6uGSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDH1Mv7c; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4359249bbacso2340042f8f.0
        for <dmaengine@vger.kernel.org>; Sat, 21 Feb 2026 05:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771680170; x=1772284970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFVC9nCnhSzeiROPOt4N4y5auQO1Tho98SnCRLzRRZo=;
        b=JDH1Mv7cYJGoIx0hBQT83TQt8MFE+JnHWR4dSeX7QXYI8jHPAokBfJaMIB2SLgvKiz
         wHQpqY86km4W0W7JAln16Z7JcCP57/DCqpqruAS2V3sv1WXgyDUPLqGpHD0s5zCDDIKl
         yVzRi5ll+mdqO4DPV4xeX4OUNQ8cXOUtbJnjIPVJJKehJjT2ZQh/VbmLW6P1r5eeel/K
         4I/si/3UclC/9euA0BNYnd9KsHjWF7SKsDJfNZc6eZFIlXp0chcsHVAVNrtYGpiSpRgH
         0UHixr/xWQjg4Sk/RQ2Cnnz1+6t80q1NaV5LN1HIU5bobYEMK3on1IC7lLh5yCFSJk7z
         qySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771680170; x=1772284970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFVC9nCnhSzeiROPOt4N4y5auQO1Tho98SnCRLzRRZo=;
        b=GpUqU1t4W3cd1EvR+F7uV9yEnwvtVrRa9Ok3sJWvHrdMtvWgyBi5RvtKinfw1tlhqH
         jA0mrHcANiNhxNY/dmqU30ElVrpr0H0EBV1eOghK0hvSdMgraO5ape8NyCjaWy5XvuIM
         ZXq1a6jrDAYUkBnlweUAPJUNRUynVU414nDN+eQxfSN0FUUTNxWSWzpOd3crjDtJAedW
         iS1g7/UWxXFPq5/Kh1cTrYJhDL0Hx9ZL/k8J/aCAFhfcmSL9TUEGNM0b2w32fz6kLLrX
         1S0sFlMDfP5OTiobJ8KOBwfztn7m1ruyz1HQJ/L1IIbv637enNIBDVKOYWCfxasR0CcV
         DqEA==
X-Gm-Message-State: AOJu0YwJCn4UKVnCWfGw3Z9YF33mdQvZF0uXgV7CCQJ0BnpOhODnSfLG
	hujipQhE42HXUdFZYe7u42i3AWHw75l8iwdyvziNXWj5DZTIe+s/dcZ2wXAYLjwc
X-Gm-Gg: AZuq6aL9hct2ihv5+bF6lIIrzlpkwMC0JI2t9Xht9P929G4ZGOZ9qHv7nncJcEgNaVN
	P6vVSXxHycFkbyxOcVsF3TEzhrkg2wpzvHlEogxXzZMc12BB8zB+/D/QC+TdNqljgBvC3bHbQcw
	EaYjTpNyNgmw2XBUcb3fPmmBH0FdTp3GU7krc21583pKQUidZpHmOAYU/idhT/MNdhyfsVQgFwr
	QHSP4WVTR2rvfgYdC762wI2ckWEf6Qk4WjiIobiLvd/Ek9lJL95ew3tuImPMj1n+DPU/uHHx8dj
	GZWtlF7qXYEuhrOFLbyWisBDsM7y3nAzIEt3jhmvBEfcEqTTFQoLMxk3DR/osMc0ZxpvXxHKjII
	06l2vNvwjEyHDSr7z4RlxCFiWMsro596t/B34dSVkbE5oaH4zFYvZ1pU5mTC124+b9b3v0AO52q
	1vZf03lSQSR+f5chWLbKnmwaOIZCQ56aI2qOE7eA==
X-Received: by 2002:a05:6000:2505:b0:435:a135:777d with SMTP id ffacd0b85a97d-4396fda9bafmr5128602f8f.9.1771680169963;
        Sat, 21 Feb 2026 05:22:49 -0800 (PST)
Received: from ideapad ([2a02:8070:a483:bca0:8c22:565c:f0a8:cd41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bfa1bdsm4645071f8f.3.2026.02.21.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 05:22:49 -0800 (PST)
From: Alexander Gordeev <a.gordeev.box@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] dma: DMA slave device bringup tool
Date: Sat, 21 Feb 2026 14:22:46 +0100
Message-ID: <20260221132248.17721-1-a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9002-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[agordeevbox@gmail.com,dmaengine@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3DC916CE5E
X-Rspamd-Action: no action

Hi All,

This is a custom tool that can be used to bring up DMA slave devices.
It consists of a user-level utility and a companion device driver that
communicate via IOCTL.

The tool is likely need some polishing, but I would like first get some
feedback to ensure there is interest.

I also tested it only on x86 and have little idea on how channel names
on other architectures look like. That could especially impact the way
dma_request_channel() treats user-provided target DMA channel names, as
exposed via /sys/class/dma.

Thanks!

Alexander Gordeev (2):
  dmaengine/dma-slave: DMA slave device xfer passthrough driver
  tools/dma-slave: DMA slave device transfer utility

 drivers/dma/Kconfig            |   7 +
 drivers/dma/Makefile           |   1 +
 drivers/dma/dma-slave.c        | 246 +++++++++++++++++++++++++
 include/uapi/linux/dma-slave.h |  30 +++
 tools/Makefile                 |  11 +-
 tools/dma/Makefile             |  20 ++
 tools/dma/dma-slave.c          | 321 +++++++++++++++++++++++++++++++++
 7 files changed, 631 insertions(+), 5 deletions(-)
 create mode 100644 drivers/dma/dma-slave.c
 create mode 100644 include/uapi/linux/dma-slave.h
 create mode 100644 tools/dma/Makefile
 create mode 100644 tools/dma/dma-slave.c

-- 
2.51.0


