Return-Path: <dmaengine+bounces-9711-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFKkDohsymnG8gUAu9opvQ
	(envelope-from <dmaengine+bounces-9711-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:28:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D335B0A7
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71DCA301B719
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD93C4569;
	Mon, 30 Mar 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtNg/Hm9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62B3C870C
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873280; cv=none; b=CjVY5KKzFno2qSCFQqaTyZ7P4uF5//baWoEL/SBzOmtXEohVrcTb2ewcPglYIauoqNYor37wnnwoWjBaggg1sfWFULpbunRo+EpCdBtjWshrZS7cHJOtdm7zU4r08IhkWAFgviUEnrb/rp4gQA932FJRCB7GL7jC1DCiD8cqO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873280; c=relaxed/simple;
	bh=5AHSDof0KAzWcvvVxhoaZ4n0EvtXVRbSZ6QprnFL0iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PH6ZlwTlAVEJKgeGV819INF8MlZolUJiGNic2Ly013poVaIEpFKNrKLeZxQ2k6IRMYzU0Nw/GzBenHwhss6Py008NP29DWwpGq7TgOFuWZDAqgWQbLu589T+4VwK2chIp9DeVwO7yK2UkZzDLwk3ZVOwXgECb23JMO0glfKGsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtNg/Hm9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b256a4c6b5so3682875ad.0
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774873279; x=1775478079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AHSDof0KAzWcvvVxhoaZ4n0EvtXVRbSZ6QprnFL0iY=;
        b=DtNg/Hm9hlR91GoJQfdv/lDEBU8p3ClhjiASELEa0K7VyLq3c5f46tYfQhwCgxBH83
         rvZf1NhyclPcaKe8loeCkCi1LUtf2ZPp4Lc9bEJisxjAJT6zvoA9/mtjqWFcCvUAAM88
         LKUE54jQMNZIMXtxsdlEuB04oYOV4ggFlqIRXgKG0lcCw14exSh5wxfJKqFd6sZvaCA7
         Mk5ny5SFZsTCLNpHM73WSvihKJY5vu8u8yoQ34CgLM+09EI8Nf+8Ds6t3OfeHI03jVVn
         jtpIDEQkd7RSnw7E4IKUxBjD0SRJg6aic6Hemha85qjhgsu35zu6c51PYfcTuE4yJgru
         +GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873279; x=1775478079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5AHSDof0KAzWcvvVxhoaZ4n0EvtXVRbSZ6QprnFL0iY=;
        b=heOih7cU+gtvznUiZ39mzgRlZCFaRl+q3PTmUXN4L+bost3uz/UMHrKeaPsNTjbGLY
         QQcHs+NunhVsRcLdnAuNhm8MSG13urgI+9lZHR+mXFBWAH4ec2lOnH7n2YT1TTmdkYXQ
         bNyiQWoc4NfHpZJETWv8XVvkfSpwcNOycxiv05nYFyKuatFjbsNqCC6dUuCXos165l78
         dAQG4TkNH7cU4BGZ2cZu/rRJL0vZHTD7BzIcPLLKXJFtcLAIX7uo9NooeHpisjbIjdyu
         BoO5BSXzmf0aefCwDJjP4KAda4B9mD4XLH/EVC2AhhwdHQZjmUottO7ykFKwy3DlAXLC
         1kxg==
X-Forwarded-Encrypted: i=1; AJvYcCUnPsvnVdilO6wk7ON7TqO9e+wPGUg0uEpSANMIRxEOKHPrE6xp0AwGU+MmT/ZWhAoJ+irYOzubzss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8vVpyzAn4efskd3drEx19l+oPYBea4quFf88Xmpe7GYVTmXes
	vGxnFX+1egcpQIhg4wIcDcYclZhCI9q+d1pEj+UDYcRsjOazMX7O0fCFwbmgJWgE
X-Gm-Gg: ATEYQzwQGvA3jyr9UzdbJYhV3QM+UtyWRNPfTqlYbzfKf0QHrPScLMd4f38nYSUYIVk
	7ZZFZGZuY39pPkl41jzCWa2z3L5wzi0cFluR7Hi72UZzDiu6BJBrs7zzQBM3UoXoLtgtfOt/bDq
	4W+gYUYZoW74czsyCNbfMm4QDYn5U82+h0JsicayV2j7kUpfiA9/zULMuEhz4O807DUDinwlAKn
	C4z9mdghQfPC9xv07522X4o/u7mCjcxJ3yQhjETqLoUMgAgxAaleA26WZDHp5va+c/ya0V9cuAE
	vprBcYoqny6PKv6zkpCwci8SWSIy7EQC0xJDxw0IImWp6PRv77s2BPQUhHlzGG9uPgumeVlGwmE
	lzs6jVUQJ791aF4hcEW7Z6D5CE4MvcTEK3qRuTyTzAYxNP2wFQTxxHmyvqiNOZP2eLuqfpba1TV
	vD9UwCn5FjTu6UHGw9bNQUPaEX
X-Received: by 2002:a17:903:138a:b0:2b0:5770:d484 with SMTP id d9443c01a7336-2b0cdd04936mr123264365ad.41.1774873278711;
        Mon, 30 Mar 2026 05:21:18 -0700 (PDT)
Received: from bsp.. ([2401:4900:1ff6:b7f6:a801:e6b7:b7ed:4aea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm96406185ad.48.2026.03.30.05.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:21:17 -0700 (PDT)
From: Rahul Navale <rahulnavale04@gmail.com>
To: marex@nabladev.com
Cc: Rahul Navale <rahul.navale@ifm.com>,
	dmaengine@vger.kernel.org,
	dev@folker-schwesinger.de,
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
	marex@denx.de
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction reporting via device_caps
Date: Mon, 30 Mar 2026 17:51:04 +0530
Message-ID: <20260330122105.3670-1-rahulnavale04@gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,folker-schwesinger.de,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,denx.de];
	TAGGED_FROM(0.00)[bounces-9711-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ifm.com:email]
X-Rspamd-Queue-Id: 977D335B0A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rahul Navale <rahul.navale@ifm.com>

Hello Marek,

>Can you please add [1] to the patch stack and let me know whether that
>improves the behavior ?

I added the patch to the patch stack and retested audio is working now.

Thank you for your support.

