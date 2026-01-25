Return-Path: <dmaengine+bounces-8479-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCpsD7eUdmnlSQEAu9opvQ
	(envelope-from <dmaengine+bounces-8479-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 23:09:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3052A82A03
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 23:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00A4230011A9
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 22:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F64A30CDAE;
	Sun, 25 Jan 2026 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFEW4CbC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF83090C9
	for <dmaengine@vger.kernel.org>; Sun, 25 Jan 2026 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378990; cv=none; b=YdoW1Xbmgs+mAxcjR+vJG0fFvFXQdz0l+aE1Rq1SbRbAnpNZJ8stQI2iIJ2rxxehGBYQtV5NogOa5SOsXE/hDlZT7QgRVDUtjm38B683t4llRfdijq/tSNYZ1OT3Lfw/7odEt4qypGi1M2dB1pNlHGlZ5tjNJ6vyFQT1sPrXxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378990; c=relaxed/simple;
	bh=ib1Y8g2wZdya4bTkMvZIoIbGtQhaLBKAvejturc9W2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJwCCDteKH1tSdh3+QZfysklDuGzvuvChoSOho3Dx63Q1uwjeqAvUI9Lha2oPN5IxX1ZcANAnesZBfphGXunrFn0MZvnIX5wLAi6cP/dFIMDHxs5r0HCa89VSAhCQOQ8QYx4vN6mPgpGCmxGa3W5r5Bq6Ck5LX27WCWnZmKgI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFEW4CbC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a7aa9efc55so28454345ad.1
        for <dmaengine@vger.kernel.org>; Sun, 25 Jan 2026 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769378988; x=1769983788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ajzev+4lOHi78VETzvSN9ReaUdF3fY7ZzthZv/vLZMo=;
        b=gFEW4CbCC2C+VSOZHmbpksoAG1gCWtYL90AFTCj9mNy85QyrsQEHJxINVcUFINK7MC
         cwKXMDBbKKMl8NpcsO7Uf/3R5aam1LcV2wZ0uFMPCPyh9z8pwAPz/+Tj+mp8AGtKrtJk
         f7S2BU3LC6xaWJb+cbkTI+4GvcNcf/8vESuHPpGgai7bTc97CFV7AArM0x5KzS2R8Sig
         mtOYAYWkb3MXGcUQerqi65my2A8zpzxSBLPIHeX7LckNy2lRMB6vWtZb/ml8gbOixXJU
         TrbdACRdgtDEtNVz/zmikhkJsaRTLJWSUEgCg5WQyzx8ALRyddPHF0Z3jtFkukT+HOjM
         jlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769378988; x=1769983788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ajzev+4lOHi78VETzvSN9ReaUdF3fY7ZzthZv/vLZMo=;
        b=jnzmObeEp8RRdSP0/teuU9hMuCy+uHzWHCiYqB6YkgCrdfnVwYxCUdT4qyWIFHKI13
         vBeIweuWPXguEWp0s8SsAg2tIt9SYia0eamV5dFmBN3E93ODMJU130jVTvgdPl4S+IWB
         pG7pum5/n8oqF88Ze81gCS0pyk0EkjqnCCTvL55axseMtKzB0iIQyjoXt7cKg8bghQLE
         BbQ7fXKugvLOMu00b35an7gl3DvEqHv8SqnlBPG3sNW09dn9gl5m9I55SYdypJUnPpRr
         GmvGYe4pGwm+tJAGyCg6wtGYRFqwhqE6965T7e44av7e5IRs4C74kdy7TVey+8WCIYEN
         e33g==
X-Forwarded-Encrypted: i=1; AJvYcCVqsgKKQHnW2uc9NuqcyzOwqvotrBlHb0slARWel6CSFmrTX+B8yBuEYxhfAg+HQuYXsaQ5OgVAd94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4o0e2gy8AC8/gvDD5qVj1GSBz9CvXMmOMJpD1+X4ZsO9X/ez
	KlAVEigEPRKpTjlTjdDw41e9I2JxZ5jXIiAQbEriFdw8K0j/1gZiM25h
X-Gm-Gg: AZuq6aIxaYE5vCStYBQi/yooDEl6GI1r1qHBU4gs496f/duXuFH/+0GXxV2vu5Tzxf/
	eKTBKJpox8aCQEl8hnwIao2Q6uLggHChAbNK9TGdeKDiDdRIhN9F5YHtT2nIrLWBdUOsRtFvKa2
	rB1SrJqNZWLmfyvoW5viW+DfKSFiGtksoCsZ40nymA+jKQrxj53eIxCD0JMceTcYNBp8bDMAGlO
	zI9dXE1mn+OKSxgxsnENQ1whCV8Mu40ZI3+TdEjJ8wCIR9jGx0KMN7X6Ywf0ETy29gT9HFVZFbF
	OiCPIlyHGxB8F9SGO0MmZw0MrpLt4QA7Jejn/eo8+RgVYCOtudVDyxmSkvztihupLuHCWpuXJEw
	lIVX/45W/iarlUDqoPkSd4I6RBLTzw9BaUhpGZ7ScdSHHf5KJtoJgiIL882y5ak8sxG27d97z5J
	jSOn79SsbC//Dn6G4bZ5P7Oldy1pg7MaE/1uSsow==
X-Received: by 2002:a17:903:46c6:b0:29e:9387:f2b7 with SMTP id d9443c01a7336-2a84523fcaemr25380785ad.11.1769378988537;
        Sun, 25 Jan 2026 14:09:48 -0800 (PST)
Received: from [192.168.0.214] ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fb03b4sm72431855ad.82.2026.01.25.14.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 14:09:48 -0800 (PST)
Message-ID: <d1778b28-9223-4d08-87c6-33c1f625544c@gmail.com>
Date: Mon, 26 Jan 2026 06:09:44 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260125015407.10544-1-karom.9560@gmail.com>
 <3d1c8106-b954-47db-b3b9-a213b7966759@web.de>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <3d1c8106-b954-47db-b3b9-a213b7966759@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8479-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[web.de,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3052A82A03
X-Rspamd-Action: no action

On 25/1/2026 5:40 pm, Markus Elfring wrote:
>> This series contains a single patch that fixes minor coding style
> …
> 
> I find further wording refinements helpful here.
> How do you think about to indicate in a consistent way that mentioned adjustment
> possibilities were detected with the help of the analysis tool “checkpatch.pl”?
> 
> Regards,
> Markus

Sure. I can resend the v5 and indicate the in cover letter that we the 
patch series was detected with the help of checkpatch.pl analysis tool.

Thanks,
Khairul

