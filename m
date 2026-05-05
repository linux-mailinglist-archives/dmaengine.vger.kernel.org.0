Return-Path: <dmaengine+bounces-10214-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFZZIbRK+WnC7gIAu9opvQ
	(envelope-from <dmaengine+bounces-10214-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 03:41:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8666A4C5CE5
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 03:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E45B300AD7E
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28E35A938;
	Tue,  5 May 2026 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6k0X5Ro"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65C2C3757
	for <dmaengine@vger.kernel.org>; Tue,  5 May 2026 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777945260; cv=pass; b=j1AVgGiHA7BQaUBmoPHrODRT8oYDzS4KMP2TVQY0K3L4tTEMwn86b49Nh0wvSXGKK9zedmB5klqiHS34WBbldLIxB+B/uOU8CtNqwPjvClhc3Gozy7RUjkJVXk8D0cixGh2w0BFsZKW0mauULgI1at9aVkIx6xF6mLWwS+noagc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777945260; c=relaxed/simple;
	bh=k7jEuVeEjsC14XNNgNKzD1VE9dKeTyLCGLtXuqee9nY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InfHT+9PpfoTavHjrgAMQEFRNWkwjm23eu9359Ly3i/UUKCVqXY8ga3j2IUhVIO/l4vB5SaJcCo52VkdcuBatQp7Ph3luE40w5WGVEm/TUAnjC9aImDyXn6df2tuqnDy6EOPq6H8bv8JC/LXtrrlV7gvxmsyrK+yKp5nF16JTOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6k0X5Ro; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bb962ce4dcfso714838766b.1
        for <dmaengine@vger.kernel.org>; Mon, 04 May 2026 18:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777945256; cv=none;
        d=google.com; s=arc-20240605;
        b=JtwpjxQ75iuJIW1CEaM9SqyS2hzNhWN4Abm9QR4E1NVrCt/juDzuXrk+ZW57rDVQ46
         a0csJhVapwu7twUaC2q2y5jwK7Cxdh/XUhTkI+oqmclafTRQ0KXecYVO64jNPyazoGcX
         vqT7uxnGRr0aI3rD7Eu3q3e1zoSYZ4CTtQtYYH6Lkvh2gHlu55TpHH9nlNvlREJAikcY
         oqjUQek7GZ2sBGZlz97NJ0xL66+o8IGLRqV7AnqofibFQ91pN5o1keqciyryDxRZNXb8
         26zss5/UMJCtNGqhnjDuF6EXtIc5EQMfXOZ1DIYmODR2CAaBRZIzloiST/VUNvGB+md8
         AT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=k7jEuVeEjsC14XNNgNKzD1VE9dKeTyLCGLtXuqee9nY=;
        fh=HW8WLqds0OaO30Y6EFof5obTe2EXZpd92a1E6lI1vk4=;
        b=AJNT0COAlypWC1/BGgA5NQy0Zg/vVkBVGDdcOFTlRXcuP92BggG58BZe3miD6OgRO/
         wDMc1isDVosnOv+xhM/IYv2Tndhb7GHq4JXShjgWmeHWaV4/+wyjPV60evlVeYV4BSKl
         OdAI+1jyilzTUb+EHOa1dvf6oPqxHYUyFMXYpJDPekwtJeWPfsOSanXGhc8ZHeOdYDqN
         yQuBmOzY3Aa+0I9zUzk6RCxFHCLT8mdizRpscmpO0VJv11HLsLBPTwrUem99AX/pq5Hp
         smvv8Nn/9BVliD16TUWbd2nNIoDIOwRWSOU60715jBWlD/hw5PEOCrqX0zID+B+9DIJE
         KuPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777945256; x=1778550056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k7jEuVeEjsC14XNNgNKzD1VE9dKeTyLCGLtXuqee9nY=;
        b=p6k0X5Ro/zd7uDbhBp75LGFQJZ0wKoOZjXLUEvvM5DAA2CT80+dPr5rTJQXJlgtiAc
         jkBHiUUrPc2dQTT59cd7I3Jr75xzk/tG5UH3lFgVIGxyelocPXCM2RYywFOb86z0y//1
         BWll29cDtRltWOS3F5AlAjCjcL2qiHXmUDj0JeMoBjk/CoakyitmT/CbkPXrKkrh1Wm1
         4G+Nmju3UxDmrljFxxg1xt2jC6VWSH4hFPIB34Cc4PYCFsKDjI+CWKI3Txg40/uI7RUr
         Y34ht/gsBeJgMr9aM89uZIExFOPRkzBLVmMkoAkatAY6bx+TmS5Bq1g29XtEXG+HOgF4
         xATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777945256; x=1778550056;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7jEuVeEjsC14XNNgNKzD1VE9dKeTyLCGLtXuqee9nY=;
        b=syOKuBbcFoXsiVm7Q+A/FMu63GOzMx4Lpe27CUDrW72Gh1FfC/wqpZsEMbI/ycgBry
         3O8bYpvOs50vkNq1CZfVme3S1ecx6eNSP37jO/3bVgwXowGPQtEKWEHHYfMPnBUz9kYT
         Kfap86iI7vu1h/mav6urXwebgti2qlzMJsLuuNDNKutVYU3UpWlczwP4LG/O7TgtkhKk
         P+mPMl6n8luCA2nzGbSD1tw7Em5TRL6rLCpkdjDvrBUYUwsg0xdaeaDriNKU14OHse9N
         L7LybqlRN43Bsr1Hosm2FEU7d3sGHl0XfDx2HNKLH+avrsN40onNetaeFi5z/nPkTtG4
         bUpw==
X-Forwarded-Encrypted: i=1; AFNElJ/EPJMV3SbTIRZDzWOn/n7/lAcKUdyh3zOrYHZViBg1QqZqxY3i6cIKgHQW1Wkv9dsbcMTo8/0IUew=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpzy53/fjBYEFkh+VcYBbqJI8w28pZO+K2PPZxdZJMbMBQ2YgU
	3udUlU8Ys9HKZ+wng23hN0o0NaSKwFG0zAvSPLFc2J8yay+9fQlZIeM+lsPTE0VtL/I5+UzM3nL
	fXAZTzHcz0rFjsb01SLYHgr9jWp5k1nk=
X-Gm-Gg: AeBDievQk+cUZ2mNGbKmqmfpXvNsguSeRgAhhFDgS9Bke0xoeXqTNDStKYVBAN37Pws
	eNG2dx89yr51CHD+pyPsodaBfAtjwkjnfxXf+M5ORbRBEW3tEj2Xc9JvNy8vpOrZGyJ26jPlxAx
	J32VO7++5+ubeuaHLOkytuIZTDAnN8fOC4l0+Y76tVVG5qKiANNR2YnIpdfXcbQb5G3jWgjaLeo
	IQ90vCQfgZsv29+9L0dixrMM5B6Z2YH08z6ZTsVhvVLP4qKwpHIzSK/02zQcSGsfGhom21QNgu7
	kK1uPKOfD5dbxODe
X-Received: by 2002:a17:906:f5a1:b0:bab:e742:aba with SMTP id
 a640c23a62f3a-bc41000f595mr47512266b.42.1777945256413; Mon, 04 May 2026
 18:40:56 -0700 (PDT)
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:40:55 -0700
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:40:55 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260415205452.67155-1-dbgh9129@gmail.com>
References: <20260415205452.67155-1-dbgh9129@gmail.com>
From: dbgh9129@gmail.com
Date: Mon, 4 May 2026 18:40:55 -0700
X-Gm-Features: AVHnY4IBxTPYPpgrFSt3VWGxnuWIhjwUWD0X-N8qG0NsUk6giOcbzNjE8K9vqeI
Message-ID: <CACrCO_VAhYGjjqRE4TyTq9hdha5ou682ELxmDirptW5Cx7w0aQ@mail.gmail.com>
Subject: [PATCH v1] dmaengine: idxd: fix double free of wq, engine, and group structs
To: vinicius.gomes@intel.com, vkoul@kernel.org
Cc: dave.jiang@intel.com, Frank.Li@kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dbgh9129@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8666A4C5CE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10214-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

Dear Vinicius and Vinod,

I am sending a gentle ping on this patch. Please let me know if you
have any feedback or if any changes are required.

Best regards,
Yuho Choi

