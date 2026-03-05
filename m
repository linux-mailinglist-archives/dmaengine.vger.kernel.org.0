Return-Path: <dmaengine+bounces-9267-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCIoNnQvqWmo2wAAu9opvQ
	(envelope-from <dmaengine+bounces-9267-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 08:23:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E692D20C95A
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 08:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 619513030DF2
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9231AA87;
	Thu,  5 Mar 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDvfh47a"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C0267B07
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772695401; cv=none; b=Zg0DwXld4G2KlDKyoJN6jO63HBTOW2qtSh9wdH50Sk7AeLwd1ajBAvyclBKe25IgGA9rSUGa+nNf7EyR8mfVjBH95KvHIGhcBXhNx51iIwXEAqFLfBacPePpsemigBipfL1Y5OQxv1EbrfC9CqRxgubrYMrcgNx2PKgGc6DDcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772695401; c=relaxed/simple;
	bh=6QRBCl2tteJGmdmnt2bNC8dLOjtHIF5RyZv+KlN+vIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htwh2h0NKN8UkMX3cCrIrRpIbz+zsW6UPHq//GleuTZHMoCQhvRQ8d9nQudj4H1Uof7dbyI6qEi34BPgLPelvgBr9ujrwubuhAhKKhufOq96pJPLj9Ar/oZbXbvVIUdUjhBtOoR7YBs2LuavsZtG9ambCTC/b42EJYqq3ftHHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDvfh47a; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82985f42664so271601b3a.0
        for <dmaengine@vger.kernel.org>; Wed, 04 Mar 2026 23:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772695400; x=1773300200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QRBCl2tteJGmdmnt2bNC8dLOjtHIF5RyZv+KlN+vIE=;
        b=FDvfh47aJhsEGiIcD5lKoeSXzUuR2aD8X8W6/Tcs6pzjmDVRXDs7Mn5AYIi0obDlOf
         EFcjLZiRm+Q3hQNlSpnBeXYlol3+EnpEqBE+OpALZSnXtR8jIMHU55pTDkONEEw1XLYn
         uAjFtz25V1uFQHB46Jl6iszQtAr5DKlgKdDEmwu5jYqNbYHk860FXntKnEcNFUiU2076
         cJqv00xycwfMTr0qNwrBuz+lDixpUK1VKb9HMQua3zvVjogBDUo9asjQ3WAn63azav3Y
         ze00cV4CSB2mrsTJ86oIPGK5VmB0o71X8qU+QgfowZ70fC/N7ehN/D0OYx2zfLwNvxz2
         N5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772695400; x=1773300200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QRBCl2tteJGmdmnt2bNC8dLOjtHIF5RyZv+KlN+vIE=;
        b=aSw7aRrNC9ILqmjRVgKZTrvcFyBbdBSF/Xi2iLawsj8F4cCkz+wR0ZzS4g0P7UjvTf
         l4SfE0u+s32TN7slq/pdmDko7XRbzFMljxoCXXl2JrOslXpJa+NxYQeen+MRggyR+unx
         jtj9ajwUIn3migUB2E9kLGsK66W2wn6xWwenavv/57adpQp/6VS5B6BkV+p63yo1WVfS
         v//VUaUnTg38f25rNc7Vef6Dq1xsUhshNr3trt5Cj5eHniJYl7RQqfw9fCqhqOl94Gec
         hHimws8kwXr/9VqctckHIcOFHMEh6wL2w7Pzaqo1fUzPfdheLVofggcKs5W9YE+bGos4
         yNow==
X-Forwarded-Encrypted: i=1; AJvYcCWjjEmj8ZlSQdno/w3Y6A/Irmk3WJqpOhjUYV3FZ7W5qKsxae4L2u6N4RkL0Xkw1RLlUdJt0H4zcYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4s11VbJLe5549CW9LaLQctsQM+1xqqtKsiau2WNfsSgab9vhm
	gJsmSY7cs1pZPL8+op2wRaRHv+8OV4f41ZRL6UNM9WVCJu1QuCZn80Tu
X-Gm-Gg: ATEYQzwt2Oxs8Q/o91KRYbH1KUE+mx9/3GvKNFLPQawZ4LLMLP/aamo9ylBqtHtb7WO
	KzG9ztJ7hmmOlFw6nvCinb0zPMVnqMDqUEFARUThKvT4bOZJO7GrbaRI4HybWFpZsPkzJT3z8wM
	0eH83rokjKnjgwA0wTOcoEU49tQ3Fcd7BwurCtTzZY20t4RGRsnlEvd2XunfnMdra17u8nVvH9t
	wjvlHs5QdZeqIpe5A3pqQqwKQRQ9DP8pMOZ7+dkKKAzR76cGAFVgHDR60UY2bVlMqSF9Bv037yj
	mmuiLsRpEC/5MuY6GSf4gz5q8v2y83/ayIBw1NLTaINk9nCYdSg8gUc8cQXywmCOtVba9w8VzTY
	9qCErvSxEtc3WbQ4Q12ehJwO5wwc4+6IiCUcQR+C+6xZ1Sv8LbmiDHh9wtQuPlzZVwjKwe099Qv
	hFdRyl/RQXCj+QasMC
X-Received: by 2002:a05:6a20:d489:b0:387:5daf:b312 with SMTP id adf61e73a8af0-3982e19ed5dmr4615807637.35.1772695399827;
        Wed, 04 Mar 2026 23:23:19 -0800 (PST)
Received: from bsp.. ([58.84.61.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738b11a5fesm1355658a12.29.2026.03.04.23.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 23:23:19 -0800 (PST)
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
Date: Thu,  5 Mar 2026 12:53:09 +0530
Message-ID: <20260305072310.5525-1-rahulnavale04@gmail.com>
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
X-Rspamd-Queue-Id: E692D20C95A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	TAGGED_FROM(0.00)[bounces-9267-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Rahul Navale <rahul.navale@ifm.com>

Hi Folker,

>Could you test if this fixes your issue (and of course re-activate all the
<caps->assignments in dma_get_slave_caps(), keep the debug stuff for now)?

I applied the residue_granularity/has_sg gating patch you provided. I kept:
7e01511443c3 applied + RFC patch(xilinx_dma_device_caps + printk) +
dmaengine.c debug patch applied (dma_slave_caps_printk() + dump_stack()) +
all caps assignment in dma_get_slave_caps() enabled again.

The audio issue is not fixed. Playback still fails after the first buffer period.


