Return-Path: <dmaengine+bounces-10106-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLeIBcQu62mBJgAAu9opvQ
	(envelope-from <dmaengine+bounces-10106-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:50:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A9345BB59
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4E353016039
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C5342535;
	Fri, 24 Apr 2026 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkhkMU4V"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00C4C6C
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020575; cv=pass; b=KfpmT2ZPL4mAR2k5b24Iw6glln/NHHxB0BShID69mmaayeRyVQ0i8V0RHh7FcMhfWxWVCznH9av1rofCmsevZxhC1z52HLmGiXxyvjXhEZY7C63at6gvCvk4HEW46h1ths4tcFFsOdVBFeVojWLZcFLKHnfKel9rqvY/Xnesk+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020575; c=relaxed/simple;
	bh=IQX9nfgGH7yR68NoOOt1DNKBFT9xxX4yo9KpPorUqBs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L1PfIrkkWOz1BpFfFsKEADqiRasjkTXmyHuSpApRjwRBn/YMFVhoimf17BHjqPVop9GjoONa6zqiMuRNuwCmchlldGe4g/MvtiY78L65xRoIMbsl+Es9Ia0vmoYFNi9FNj2PGsam/CpGc8D45S/QiyjLPBeZfA0Taj03+sFLJUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkhkMU4V; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a74765703so73069347b3.3
        for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 01:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020573; cv=none;
        d=google.com; s=arc-20240605;
        b=V+rBWsNw5ZkBaCIjTB5UM4ICfZCLJo0dc1Rh41aXe5BKXjqS9SpDXB7P+f8uLxWkiO
         cXuhwrf9ZjJM4glcBw1+9RxrmC981HYbiwApztOXCF6cj8kEod5cbBb5nU2CpnaFxobN
         iKGO99nxws8lzp6M7/1OdBeRuv4o6AqHU06JMVZXJpcSgXBdTs0uxqEN4s82TXnuYkTT
         h1m5WPRv1b/6OHUqA73KjJW6D2FpEKmuoG5cjANGYBe0Bw6cXJ7Pf5fcAOvU3c7p+JAo
         PJKkE8Dz3838r7tJQLEY4Pyn82xxOb4fys/4tEWf8a0JasLb3mE3eBH2pRoZ8k1oXZhc
         Buaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=TC5sryHvai/IFNjebXX2bmIEa1ygkcl6y12sT/MqiyU=;
        fh=oyZXABIifGJB6v88oFV2q5y8hXGcYfCGHcQOa5OrARQ=;
        b=h2NsZY3hk5gvXJfOm0cg0EltqrrLnwhjhN9Fz3AI8bqp+1gQ2QolOTZceh0NCI0n4A
         9YwNw7i7YWns8eBBxedhRfRaseiGKNbNN8D1jvAxLtJ4I53qSmcRK5BdpLB1Xh9iIwvv
         ZimYJG40MQd6FAE5s7nxnsJx+3ZCzN6biD3EJSfvMJ++ZH1qg+u/1Ghn9EyJe/q11I6N
         uj8zo8Xb1ZroraR0UiYOVJB2qDmPUDixN0PWlIDuI/nX2hg/f6xx36jX8KFiuLqQRdcA
         SUrOc+bqwUxx+vObYjT2zIHA/gNxiRTx8ddfpcktvKzBpaKMrFAKF9CO68+AgyzZRDDg
         UekQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020573; x=1777625373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TC5sryHvai/IFNjebXX2bmIEa1ygkcl6y12sT/MqiyU=;
        b=YkhkMU4VRlTsv5JD6Jz3U3EjDQuCqNg6b4FOmwp20DwFt789dyWmG+MS/czhd7y/o5
         yHDwq+TNBcMX4Lp7pXfK6nCEFNyB5dqUIo7hT7a6aUAo2HaeT2T1npMo8GvI2zyenh+R
         dwBW8abveK1wz70W4H/zg4to0UxRMaExK4lHup/nnInjiSNrT1y0TZGA7qUqdj1qMSQJ
         HB1W3oOW+3/X8zGUnftR2k9dEGvQ1EaNU8IFRRUIFQrdl3fYfxCFBGe5A629XgDsCRoq
         v2iCueH79vC2ZPSyFmgFpl+eg0ewGzn7F98s8QYe4owu93vY0iOlnKsTRKSj5c9ZFHR/
         SfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020573; x=1777625373;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TC5sryHvai/IFNjebXX2bmIEa1ygkcl6y12sT/MqiyU=;
        b=NI2Jxu/Xpwca+kzFi3iTPJG+OAbvIU32Cnb79z6HY25ZPfkMGGC1T23uoL78kI7dsL
         Jy0X3rLB5pwcIhp2Q9l71XkCTFdulYJ4pNmRBv2D+xLk45Dr8xbvMa5spgofvryMl0XG
         zq+Yesb8UlooBef6jAbMGnt7q5Sd5rIlrXPn3LFq1mCDMlTRCHOxK9g8Lrof/8a2LpQa
         6VzMHZRx5QznDHydNl3pSS9GIG8EvOCjpGLiw9mNJ6oIgdNdKhAoFKT0tNGKGfxBw2l4
         jK0bHCyMmfIEhOEUAPFvSQtDwYGBUOE4cd8Ttv5IttNr+j3RE05zl92atmc/hXEqgYTC
         UVTw==
X-Forwarded-Encrypted: i=1; AFNElJ+4J05x0OVyjsw66hiATSgCKGF4MLuUmOvBJj4em5bYk1Y8N/EOJeNIkM2LQAxhvC5QpF5q5xDadhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTHH/37hQAnUmKh5wQNCL+pT8Z1+aR766BUbFJqjfm5H8Y+8V
	Ue7zFdd1d+hwJWFprLXYpkZNlVFvK2I2M2eVm9WRAaAB79D3onVMtDNhtYHGb87bZEiWOcON0YX
	hKfn48TkBWb4u3T+gK15QTbmyK1XtCshLoSpGfek=
X-Gm-Gg: AeBDiet7fEui9GgilWZruYY1zn6gWHodXLbCm3bLYXtdob7pYMEQ8B2Hf10aOH+9/jv
	gl3xdLkGVHSH8oQ/eoPtzePhotLoSd2shfR9+RuPzvJFpNjJvuL3ORoUwAPcshGBK3AbpqHTaUy
	kBLBuj7+18zBzD5IIEdUVDcAqtUmq/m86vZTilao15jaLL2S5U3wzAyk70CufDLqjWp0DVeLp7/
	dfayvwEn5mO2HduNRUghH9iCLuDe3F+144HeDCZjG0QGTC+lymm6taCdLhOAknrst6qv8yNu70p
	skTUFgxWfv8qLgoeBUmG
X-Received: by 2002:a05:690c:d8b:b0:7b6:f4f:f06a with SMTP id
 00721157ae682-7b9eceb28c8mr332370627b3.6.1777020572775; Fri, 24 Apr 2026
 01:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Fri, 24 Apr 2026 16:49:23 +0800
X-Gm-Features: AQROBzCVA3oYYXxTtDJfcspzfCj9Q7thAzG4DSQEsKbms5pQBTOVnyE5hkMlJ1g
Message-ID: <CAGp+u1bXAX4qJRnLvfaYdfjE7JYzfCw03_4+bumhaQpwNTzvzg@mail.gmail.com>
Subject: [bug report] Potential deadlock bug in 'drivers/dma/mediatek/mtk-hsdma.c',
 between 'mtk_hsdma_irq()' and 'mtk_hsdma_free_active_desc()'
To: sean.wang@mediatek.com
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A7A9345BB59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10106-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Dear Linux kernel maintainers,

My research-based static analyzer found a potential deadlock bug
within the ''drivers/dma/mediatek' subsystem, more specifically, in
''drivers/dma/mediatek/mtk-hsdma.c'.
This deadlock potentially occurs with the involvement of hard irq.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
mtk_hsdma_irq [t1]
       --> mtk_hsdma_free_rooms_in_ring
             --> spin_lock(&hvc->vc.lock); [t2]

T1:
mtk_hsdma_free_active_desc
    --> spin_lock(&hvc->vc.lock); [t0]

T1 can run in the normal process context and does not disable hardware
irqs in acquiring the spin lock. If T0 (i.e., the hard irq context)
occurs after T1 acquires the lock and both happen within the same CPU,
then T0 will not proceed because it cannot hold the spin lock that has
already been possessed by T1, yet T1 cannot proceed because the hard
irq runs disables preempts.

Thank you for your time and consideration.

Best regards,
Ginger

