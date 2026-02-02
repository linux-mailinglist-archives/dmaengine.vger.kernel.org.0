Return-Path: <dmaengine+bounces-8667-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILw/KlSRgGkj/gIAu9opvQ
	(envelope-from <dmaengine+bounces-8667-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 12:58:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FA4CBF67
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 12:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6CF3300AB3A
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290FB36166F;
	Mon,  2 Feb 2026 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcrS9dc7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18862D2488
	for <dmaengine@vger.kernel.org>; Mon,  2 Feb 2026 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033490; cv=none; b=t7PHcw9OBvH3Uy2riFA5/0TlcGBMV/SwbxRJf3p1FXAIQjifgR8Fn22a37WYABUnXJQiIX9PSBSbTbsJuuvpswCf3kiUvMEQCTpf0Kz+6weQ4wuysUxsYFduEDMKXzh8sPglYR9b7XqJfLoGv0G5VsglSWlRu4/8KR3HB7wwtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033490; c=relaxed/simple;
	bh=JZ9jVQNwjMTVEsqDL8DzHSdBk9BpGa9oVMoi5vQiTe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zqjz9mg8vTnXKB+NHesod17FKSZSB0Kknj6QWsuacBkU+e5qED/AVQWdy9M93ZRgltScFXb7AwrjdL9rirZVkigGnHFWol/Qe6NJR2y5TTqMYVLdEFIMMqs24JHsrGpDdr056jiYrzvuslbjvfKBa7ELBTgjPJwv8vBhYtoWwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcrS9dc7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82310b74496so2493167b3a.3
        for <dmaengine@vger.kernel.org>; Mon, 02 Feb 2026 03:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770033488; x=1770638288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpCQ1oPLOJ8/deUs3LXeRGteafYs4lSdfhEPKBMrP8A=;
        b=DcrS9dc7fX6R6VbPskWpz1/jzfc0DTG3CoFuV07M4u3J9IWco6xHn3mECa5zXvJwrc
         bCPxoZOwReTaBg/HBVAp4tkm0kSDvY3f8lvyICQPN6H39KD9meklNCrT/YEyKxfV3ha+
         aAV/jL3hIJKtnGuEBkxKNMC9OKj2l13ygk/6ArGhJiCAPp9/S0QeMqqDJozsvTNNPp2R
         /804W4YYDtTscNamBTiuTR+4m7zFwW4pcI3gUVt0EeH79Ma52FSXq41ueZMp+y+neFES
         eMlWGWedv1MfIzODNldw3T1PAVoFKkZf04t/uN5YxU7nF7V8DVGGDM1MuH6wZBqs11Td
         Mekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770033488; x=1770638288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpCQ1oPLOJ8/deUs3LXeRGteafYs4lSdfhEPKBMrP8A=;
        b=NIebqLflG1X3K7vJz0XXfJBUj1jBOfzUq0emlwX98+IJhKIcubK+AMYY1GewdH4vh1
         reoU/k4ZHVe8j1mWbgoMxIPFx7a5rr7iMyaEOL2pRPXVNuF0Ud+wdJB2dZ7pHKUngC6p
         XH48/scTnfsy1aUbqX6hiC1HljRY3wQwsRXyE0CN7kxs9wvncQnawGvY/o3nZCluumZP
         Kh9UhX2oAS8hkQdCJ6pHPt+gqQO4aIKboR6SDxLHssGGIqI4MLhtjeaRcpBzRg1c7WZJ
         hdljo+KUepw9M7Pi5ClQdXiTt52/iWVNEIr4XENBNyfKi9kf9v8SN6Fu0z4Aah5jwUUn
         hTbA==
X-Forwarded-Encrypted: i=1; AJvYcCWMrZjRg5KMSj/Xm4lCHEZLS7wvWGZTOSfacYA5j6mIedEJXWzeTXk98c3kefAIj8ZF9B4J3hltdvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzQtp+coedZYL3sdZrD85nKqU6uR+D3eVggU+Bqp1/ZaZzaEE
	GUj5kmNrCegJB5QTdraTlZ/4TjiIXDAO+H0qplLMRcYHk91QKu4iohcB
X-Gm-Gg: AZuq6aK62Vo2BoTx1Lpb/aiezb7+5zlwA5oxrXTQBS2ZHJDi/vJE7M8B4i0ykiS85b4
	5tTjjieHq57lP48ze9yKN5RS5s4fZSFgW9EA2rsdqQ0+qdZjw3l9hYEhwto8w376eOrWAfD2bD/
	iHhlmUXBFBpMEpfjcXNizVx0OfZeVOSwak0PZo8wMfa/0tLavdFalgdYigWJEiyTKiTSD689qmz
	BIGAjaw18w8JY8vHYRlKxllEJFej0xphHAQfsDUwHiAX9ToxI3dN+pMPJNttyYAwJDuvC8DhN03
	a/glJykmIMu5y8xW91KwoU0wws0qy7aAIFKDkb8WXOV1bCX7JFkFFxnhjiJRBBk/VwCgjf0rJGA
	7quSov9pXH/aqTjXfxVRsImiCbAx3/Xi+jK6styuQA9H1ipB+okFH3fIivZMw6hxbpxWnFXtRKe
	vw+hmxbJohf2VVuTVvTgwqo2vfCME=
X-Received: by 2002:a05:6a20:a11d:b0:38e:5535:bb4a with SMTP id adf61e73a8af0-392e0012363mr11386494637.11.1770033488191;
        Mon, 02 Feb 2026 03:58:08 -0800 (PST)
Received: from [192.168.0.214] ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc1asm16186434b3a.9.2026.02.02.03.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 03:58:07 -0800 (PST)
Message-ID: <4d6daa93-b4a9-4a96-a9e9-01cc96ec3d0a@gmail.com>
Date: Mon, 2 Feb 2026 19:58:03 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260202060224.12616-1-karom.9560@gmail.com>
 <20260202060224.12616-2-karom.9560@gmail.com>
 <ac172a42-5480-4538-bc59-c17c71eb6b66@web.de>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <ac172a42-5480-4538-bc59-c17c71eb6b66@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8667-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[web.de,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53FA4CBF67
X-Rspamd-Action: no action

On 2/2/2026 2:26 pm, Markus Elfring wrote:
> …> This patch fixes …
> 
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc8#n94
> 
> Did anything hinder you to use imperative mood for improved change descriptions?
> 
> Regards,
> Markus

Sorry, I will use imperative mood as suggested by the submitting patches 
documentation in the next revision on all the patches in the series.

Thanks for pointing this out.

Regards,
Khairul

