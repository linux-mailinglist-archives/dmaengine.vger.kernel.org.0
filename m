Return-Path: <dmaengine+bounces-10343-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM+OKfT/AmrTzQEAu9opvQ
	(envelope-from <dmaengine+bounces-10343-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 12:24:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06151E7EF
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 12:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 368B430E372F
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA5395AC5;
	Tue, 12 May 2026 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2JA6iQJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F5395ADA
	for <dmaengine@vger.kernel.org>; Tue, 12 May 2026 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581048; cv=none; b=m2BOUk5028wTkC/2ewDY8N7zr8CSB1766H6ekWwFICG0EjibwaMP6llS42FI9SJv2re4qJYHfayXgb7nl6AgFiSGEGckG5ILKTBLWtWQAS9/6lGxK/et//A/QMC5mWgdoQd1LjFmQui53uC6xQjFSZRyk+lM6Kk7GeZ8mgVIaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581048; c=relaxed/simple;
	bh=GaMF1Yzm0iNBodfrAG5+rKsJ59TZ63qHdoD1FdqOEgU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gRLQA5umvTZ+QIguWSA1YmJ5IGkorPpfPNAJ46LYS/MmHMdV0LtwWfKKBYJkE3PwizzHtoUIu7PY1wvynzpTR4A7e2NqBRs1TipaaslFR+SDUpnN7r0EnfSuru7hGhO9Sdb6avyKCDHyukutDyaev0UW5PXRGhPNjbPp5VSx5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2JA6iQJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so4583741f8f.0
        for <dmaengine@vger.kernel.org>; Tue, 12 May 2026 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581045; x=1779185845; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziL0V3bTIpY6V5vrEqboJ/QjSCNIwPUv5YVqghF5mJE=;
        b=D2JA6iQJxzWYuqxfW1s09wNG05WugOXrWw/jd+a0r0d1VXcqmwQ+VV1BXhyOIDancl
         AmB83gDVGxeZPE3KN9GU+S1Y/aAO6n7R9D2B5nosChBKmXbNrXcO94WusLm33O/nFNPb
         waAaNoO1PZ6yt67yEdxhw41wI4gLMtbtIH7Jph3jhYxpP2XgOWEMKyLnQ732QlzqAK+q
         DKjgwoiWGOw4IAUOzZE2tM9WwzbH9whjmQQ8lZzm430bURtrCExeDW8LhwLz3LHqFjV/
         dI7FCbJzlRCVFLgJs5uAn8zgDx1ONEsfADhpBvWG/j5qrTPKKo7yVEoUou7O7m0RrEt8
         6fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581045; x=1779185845;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziL0V3bTIpY6V5vrEqboJ/QjSCNIwPUv5YVqghF5mJE=;
        b=hI81FkC6JBgqNFUtQukgtW5oj49fkpFipJDE1AWBCESkXPQJHrC32/Y8AHiHSszLMe
         hMxN6FLnu1orysCSUGifkTsiYjGC6tebnaSTwW6jttpBAKTbpWvQlZF6BlVqUHQm4PMb
         TDgrFxgoc7tAoZEahaVgU3bl+qVF8JDj5pBRxX0PmCcVGPhqyipEIkz2UppN2EsfA4uW
         8JcEElYPm2PrHOPgJhrJbGY6/d5fbwYK0NqNN/KKmIBDE1oFdHmY59H3Y5QdWJDBtBs2
         /VWvQj9yHqiiCUwHjNnRgXVnLUqNbutX+g5D3/fOZX8O3O5DI1FeCjr+NzOwQwSzcHwQ
         pJeQ==
X-Gm-Message-State: AOJu0YwGVOco1ewo/57PBsiOjLhspDDODHlzvuOgkL27EEtMGswZFzKO
	HnoeieIOVB4soybG4TQuHq1DRPyOn2oKRPtqGTSY951K/6mWmAmdq/6aRmr33KdHRyk=
X-Gm-Gg: Acq92OF2W293GZltMwCjSmxh/Hs4ZJ0Thn1doYdUHCJul9acdgNh9cjKMuvSF5FaLkW
	8261uEYtePHMO1nl7q1O5efc2niGWCkye9nRbqhmGP3i+3EpUbiYAWQCy07aCTB8atgiQlZ8e/v
	qF3zr4NkJn6CMVz3FJowzaAgJBHxTrA2yrkDnsHLPPSUfop5ZuimPSHTr0RQSp0ee/ADGXNEL42
	Tntf4eO4TYCGv4FYudMvYZ9O+7+rWmQwL5SSucyokm834E1cLciMWnhFw4O+g0PU47lbpv5n7Zh
	Too8/ATktxHmmctWWL4jMOhn0TkfZoqqixWfFDXnEUOecQ7o6IezA/evl1TIORWiFvxoG+27kcV
	OUQsv1rZ5IlP2u18uG5lognsPv+qjzJUHDomlTOLAxQNqkZNCxS/cP8L9P5KBqlF7iI5wHSTzzh
	sHo52Ijpld02labP2KesI33dpnu1gGSw==
X-Received: by 2002:a05:6000:2386:b0:43c:ef4f:79dc with SMTP id ffacd0b85a97d-456969c3922mr19278708f8f.8.1778581045063;
        Tue, 12 May 2026 03:17:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491304505sm31762914f8f.22.2026.05.12.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:17:24 -0700 (PDT)
Date: Tue, 12 May 2026 13:17:21 +0300
From: Dan Carpenter <error27@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [bug report] dmaengine: sun6i: Fix memory leaks
Message-ID: <agL-MYGNzC278bNc@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 2F06151E7EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10343-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Action: no action

Hello Maxime Ripard,

Commit 4fbd804e009a ("dmaengine: sun6i: Fix memory leaks") from Jul
30, 2014 (linux-next), leads to the following Smatch static checker
warning:

drivers/dma/sun6i-dma.c:792 sun6i_dma_prep_slave_sg() error: dereferencing freed memory 'v_lli' (line 793)
drivers/dma/sun6i-dma.c:873 sun6i_dma_prep_dma_cyclic() error: dereferencing freed memory 'v_lli' (line 874)

drivers/dma/sun6i-dma.c
    783         dev_dbg(chan2dev(chan), "First: %pad\n", &txd->p_lli);
    784         for (p_lli = txd->p_lli, v_lli = txd->v_lli; v_lli;
    785              p_lli = v_lli->p_lli_next, v_lli = v_lli->v_lli_next)
    786                 sun6i_dma_dump_lli(vchan, v_lli, p_lli);
    787 
    788         return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
    789 
    790 err_lli_free:
    791         for (p_lli = txd->p_lli, v_lli = txd->v_lli; v_lli;
--> 792              p_lli = v_lli->p_lli_next, v_lli = v_lli->v_lli_next)
                                                        ^^^^^^^^^^^^^^^^^
This dereferences v_lli to get v_lli->v_lli_next.

    793                 dma_pool_free(sdev->pool, v_lli, p_lli);

We can't use v_lli after passing it to dma_pool_free(). The
dma_pool_free() changes the the first 16 bytes of v_lli so kind of works
here if you're not concerned about something else re-using it and
introducing a race.

    794         kfree(txd);
    795         return NULL;
    796 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

