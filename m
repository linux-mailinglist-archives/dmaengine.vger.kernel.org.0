Return-Path: <dmaengine+bounces-9271-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD2lN9hoqWlN6wAAu9opvQ
	(envelope-from <dmaengine+bounces-9271-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 12:28:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 002F1210927
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 12:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCEF63011F24
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA4D378D85;
	Thu,  5 Mar 2026 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiyJYK3h"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5CF223DD6
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710042; cv=none; b=SgOa2k9L0ujAsrK47RXD232LyrLm/Fn6dOTMmDfAXjf2xrYvagpk+n1JMObLOZh7+LnWWr4IbnTcj5LnODqy6BsZzj2g/6jgSyNO2ODNn77ZvC4FTc9toIrmTFC9uju0ITO5W0/EoO6wW7WR6rCXMDI+3o4hcc5g2gvCmFAwgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710042; c=relaxed/simple;
	bh=JWFTp6KkNdewG5OHnw9u+Peu+Q/11m5ftt8/eMWCVSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbHdrtwpFgxqx5jO7Zndyt17KeXQUCovLn0+RNelq9z6iLKXLg2doIycHQ98yAM/27AjBj8OwHosf/ug3AayeJxWjH9CS9Bhdi1owJApvj4956h70agoO1qbTTdVxYrxrPLqqAUmx2Eis8ZIY45e2r+v0U+pkNn83hj6TCQmetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiyJYK3h; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae45a4cc54so30301285ad.0
        for <dmaengine@vger.kernel.org>; Thu, 05 Mar 2026 03:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772710041; x=1773314841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZZVApgq/G+kwjimfOM6gAatNV+GE2CQXWyQH6+SXek=;
        b=kiyJYK3hnVbLQaTENReqND44XlLmOhdtoNAaSPFLKdXZuT9L1+BXFxaRZT+m5QmBkv
         xWETjB7Mm4R4xIeR3zXyU++oayueJypATSgMgIoFJ4BAOpGHf4Jg+ZPQgYvhbjBCUkfg
         JI7HLyWo5wkT6wiUUG1ppazAUUlEDhWffKpd/VaxVUd82EX408vtUas3uMd5B+lLfdUY
         ylpubEkeYaCPvw/NJaeeWw4JH7WPbu9z4h1GJOMkTFUGP+msYbjacGzBJAyha5P00w9J
         FqaF4rwtFqDhX1onllQAjgeSIt6yF4glJy6fK4fO067psfnaaAC8WmsMhOSDOSwMBimj
         ifWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772710041; x=1773314841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xZZVApgq/G+kwjimfOM6gAatNV+GE2CQXWyQH6+SXek=;
        b=pQfEUcYJokoI9VtMoTe2IyQQaFXAlyPGjyCzryPgxuqUvAMGE4iKXCQJ2MMeIrQ7bL
         7n6lj+jE2cKihJtlIBUcCaqxIjljvbR7721U9ow9kwhAHbJoWy2XvMEOu11h/3PVV6Oj
         FnyiligxCS7ctq6rzz/Dy/9AixI6UWHtSZpjFXZUIkXeEjqJOwx/EyTeqOm/34Oapo5k
         TU4HMNNsOFw66uW9Zx4MOqbAX3AcuPOozdPDLtZ4OAOyk0VZyPKizSW3uT7s5vy1rdkg
         fLMy5e/8AfaLApsV2LNsyrgdhgCG7uh1cB1HZMrEA9rQBXDRJF6wa13vpbIHL/bs6k87
         G+1A==
X-Forwarded-Encrypted: i=1; AJvYcCXNkioC8AlXlST6DsOs3ribBy11uXU6hd3aaRjTU1DZM36/uM75qObrWSbWo4OiKIGtv7t1avKoIc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeXwvQkCv0A7Kv885/ADus+7JQq3qQ4aYtI1etGsH/aLIHjMz
	1wW9GFouwppi6iE8hFvgrdSMc4VRRfloivCRQskX9QR5MNiqkQ1hTWO8
X-Gm-Gg: ATEYQzyyKHSrYtQbo+D9Kjz2lxlums6jrKfxl9CrbpI+elVqWYJcFPm4WrR9vbtNfsJ
	LTmYPmQxM4uBaN9XzZ9y9EQ7i2olruu+UUOmrZc4OStCUPUzg4s/GC2Vh1/3o9eXX92IgMixCdi
	NUgpiV+dptTjn+yCqa7C1QmBHDH0pcYSkJXDvsW+/3+aN7OOYt5tgDTPWjtLEpJTtn0ZXuDYg1h
	yvv7tOWEkRzEfYVkx2DiUxAu5z6RCmW/6kYEDH31Ob7djTPx3Bi5YKS+n6LCWKiXZ17Clf16eMg
	7uXxfWLCzr/Aa47xn9cXPAVPdTJoG+Ll4FwNh1Tiz4GUcgUJw0SxIkthINQbFw+9B83KxsuUmwP
	P5ifkj2+YdwW1VfHVOfGh0UDZpifn1AUGY7+Uvyd0BhyMnEvBZvEnSc20zobHMklSxZx4Dz3d8Y
	lZYfQWMnElcPXVjPRK
X-Received: by 2002:a17:902:e88f:b0:2ae:3a77:a1f4 with SMTP id d9443c01a7336-2ae6aa49457mr52815905ad.24.1772710041230;
        Thu, 05 Mar 2026 03:27:21 -0800 (PST)
Received: from bsp.. ([58.84.61.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm144938805ad.23.2026.03.05.03.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:27:20 -0800 (PST)
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
Date: Thu,  5 Mar 2026 16:57:04 +0530
Message-ID: <20260305112705.6862-1-rahulnavale04@gmail.com>
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
X-Rspamd-Queue-Id: 002F1210927
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	TAGGED_FROM(0.00)[bounces-9271-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

>Could you confirm that the DMA IP core in your PL design operates in 
>scatter Gather mode?

Yes, We confirmed that our DMA IP core in the PL design are configured 
for Scatter-Gather mode.

