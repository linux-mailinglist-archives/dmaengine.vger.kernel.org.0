Return-Path: <dmaengine+bounces-11404-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jf8eDDxBKWpDTAMAu9opvQ
	(envelope-from <dmaengine+bounces-11404-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 12:49:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9B6686FD
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 12:49:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=snu.ac.kr header.s=google header.b=vKNDZB6u;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11404-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11404-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=snu.ac.kr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA91630590A8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8138F236;
	Wed, 10 Jun 2026 10:49:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE93C109F
	for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 10:49:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088567; cv=none; b=k8y2H92Sjr+n93QEEdEiFQiawiWuZ2JOnYXi8MDpqipvWc6e0gWFKJyT9t0BK+xnqETCNSH3L533QaA06PUTW5nlCuewLkntBmPi+RwxTVdAIcpOYEh88RxSA/yJP2SGtpb8EcaibeNz1cc8W0cUaBfjvajrgdYNxTMEQUaKmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088567; c=relaxed/simple;
	bh=55ZWs1otnAdOWyG8tWxfBfD2DHeqcZnS0TDzmZpqw38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iT6irpSbgEhXT9gtS471Nxh10cXB6RdPOGICInU1Jp7qmCpejA2I43TRdtTgG/pndnkyWZ9jvPzz/nSY9NwK+aRRp59O5z6QwOvpE5GaDXbNTRdMXl5g2yde+neJ4YVlblnl4jpsOf83QdyH/XT2ZoM7HQAJOv2uGqkrv4XXuyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=vKNDZB6u; arc=none smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso4337989a12.3
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1781088563; x=1781693363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuAyiw5DzCytjlGOrX4/Z7niXhij5PrYCenJJFkIUSo=;
        b=vKNDZB6u/K/7RDuESaF+wPthfPysGUkux0E6xzpXY+ky7xUblpLs1StlZ5cFH5dRDr
         JT1SMacWmFwe6YkQT8+RYF1ODjrBVI2VHtOQBSGrCgJndbjDCyK8evPP2FHWEersZCNx
         4gkUUndoGLQNwV79eAgMi9VOYRO9R0Tj/ExzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088563; x=1781693363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuAyiw5DzCytjlGOrX4/Z7niXhij5PrYCenJJFkIUSo=;
        b=ITJdetm39iNdwnmsJ/k59CfGLHiHf6Uf55Vm/Gw4lnulyGFtJoLa+kQ9RhPbzfM/FW
         kDlVsbGjS4WuPLUBGKNzpGOvub3bQv+EbHd4DgQRn4RqoaES5YzuwwvdpYpQac6aqncr
         2gN9SFJMDtL26jjVp8XrWW/oaQAcWxwJ31Xh/GCNcJWFJzGes0ND4Xunx/RMpW7OqRJI
         Z89iOh2k9Fx5BkQkDEUxAMBzFo0CA8mCiSNJAYcwCE5jbmd6thykGPr1MClD5v4erZyo
         IXj3MjvuTKPWYozMiH5haY8Yz1DPBQGK5nCt+GGZywlcyxpCa6uKKOHBywY6eJuuf1Vq
         mNpw==
X-Forwarded-Encrypted: i=1; AFNElJ+eJ61Pf0EI+NBtYlXUyTjELYJ/JXs+mCAhrL4HN9+XN5rFY75DXcAtOKJOoUmdZkpuAsjqt2CQxTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9DajikDwMNKdUq/nf1V+wqcihS5j4PFCovPL5/m+r67YTldz
	DfNEA2fVp/I4vsrYVNnYoZeXLBeQ4iC/e9EFFJjQaWFwR7gDwiCCiGxJsevtGWfcp/A=
X-Gm-Gg: Acq92OEAzk5kty4dycXEtx9xMLnyfad7GbIHhMRyXMVvAgYMlFZMsEfsZhRh5nDC/gU
	679cUiPynv05A2hmbp4NDVt0C4dRV3k7eJGSJUzo76Hsk5148pfVy8nGxUaj4nIdm4nUTP7zK+7
	UjqM6uJUIJ7GLCKHmWeol7bU4s2RrJy35MRB/4U7jcGEIzv6wRUNOJUPVMzE0XtlAzyCBFc6S2h
	fQ/PE6sRz864+dTntqx3Z4TFIi12fM/6iqI5W5kJ8ubDNhYD6HDIwbQ4rPoC5G4/EXJASaYwN6B
	4HQ6lLbmUGBIWYnEFf11mswn69hTsJzqX/bU5qkQtxDVNdBh/qlUEZknn/q1BgVxzXgsxOxQC6Y
	0W7oJCbdoFKjjE+WurvLhegol8FtTc8riKjXGPLr+5bTI6jtwKwkStumeef9tYfYOfpYRmPuR54
	j9RtHYLpvXrhWTohIj9/Eas3BApWd0i607EKhcriTVFA6AntvgvoWWZgR4MPoNgpkiwjE=
X-Received: by 2002:a05:6a21:7009:b0:3b4:8717:1c21 with SMTP id adf61e73a8af0-3b4cd02b770mr31411241637.35.1781088562789;
        Wed, 10 Jun 2026 03:49:22 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0341f6sm21321664a12.7.2026.06.10.03.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:49:22 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>
Subject: dmaengine: k3dma: KASAN null-ptr-deref in k3_dma_int_handler() on early IRQ
Date: Wed, 10 Jun 2026 19:47:12 +0900
Message-Id: <20260610104713.591381-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11404-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[snu.ac.kr,vger.kernel.org,gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[jjy600901@snu.ac.kr,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:jjy600901@snu.ac.kr,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jjy600901@snu.ac.kr,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,snu.ac.kr:dkim,snu.ac.kr:email,snu.ac.kr:mid,snu.ac.kr:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EA9B6686FD

Hi,

k3_dma_probe() in drivers/dma/k3dma.c registers the interrupt handler
with devm_request_irq() before it initializes d->phy. If an interrupt
arrives before d->phy is initialized, k3_dma_int_handler() dereferences
a NULL d->phy, causing a kernel panic.

The probe path, in k3_dma_probe():

    d = devm_kzalloc(&op->dev, sizeof(*d), GFP_KERNEL); /* d->phy == NULL */
    ...
    ret = devm_request_irq(&op->dev, irq,
                           k3_dma_int_handler, 0, DRIVER_NAME, d); /* register handler */
    ...
    d->phy = devm_kcalloc(&op->dev,
                          d->dma_channels, sizeof(struct k3_dma_phy), GFP_KERNEL); /* initialize d->phy */

The interrupt handler, k3_dma_int_handler(), dereferences d->phy without
check:

    p = &d->phy[i];
    c = p->vchan;   /* NULL pointer dereference */

If the device raises an interrupt before d->phy is initialized, the
handler dereferences the NULL d->phy, triggering a KASAN
null-ptr-deref.

Suggested fix: move the d->phy = devm_kcalloc() assignment above
devm_request_irq(), so the d->phy array is valid before the
handler can run.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>

Thanks,
Jaeyoung Chung

