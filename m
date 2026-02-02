Return-Path: <dmaengine+bounces-8653-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMLkIdIugGno3wIAu9opvQ
	(envelope-from <dmaengine+bounces-8653-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 05:57:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE300C83D8
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 05:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430453007F6A
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC4D2C0F84;
	Mon,  2 Feb 2026 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlRIMr53"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4F23536B
	for <dmaengine@vger.kernel.org>; Mon,  2 Feb 2026 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770008268; cv=none; b=qMYBo6Zyxi5AYAK5m5Fu8JdE3ce3YIqaIamhKvmtyZ9/kLmNeiAoT7nv4o47tAeTLlb8qfvtGLE/Ae2YgYUbW4Gc6VQPw8m4p40rZkMQEzzb1NckoyLEa04rDEGH2EiHkM9D3M49U1ZI6Pi5/402dHGqa/bhUuA2PdxtSeg3tRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770008268; c=relaxed/simple;
	bh=EqXZSUiavXe5h+lEigVvoJYUnFKkdKk6ouuCoZeI4As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4BAhhyJTd0jE+9Tb4Kf6CvtmDmLymFI4UFl7/2yvcnNtSojGrYlXEakOByUk+0n2W/Jru3ru9Fe6dyuvXSlX+XALJWNXfuSIndU4S45v8jnbDiYkMYTur5KiOb0tmOKremZvhGcSOlURKl1TUGHK6SW+vEF2bbKwQQKfLHg4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlRIMr53; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a07fac8aa1so29815155ad.1
        for <dmaengine@vger.kernel.org>; Sun, 01 Feb 2026 20:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770008267; x=1770613067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4Tg8YIZ5vgk1JPtFkTc5c+Dlc5nrpswbRPTVC81KsA=;
        b=GlRIMr53CkCwdleHbkv2SplFqU3s8vc1eABMQuoaP+7AdQWww/+uacmyeTnYExBciF
         MpNLiKhUVsNCgOSieMvyBgmLH9QW80jiouUlbrJMV5BXSvRcIczH7o9KvOJY6NBNYnoC
         p1LVW/WPXIoZ55zPSUnGoWfpr495QselOdl99MlkZkVXcR8PNsWFfA0foDlNbYtBm7TY
         CrZps2WCEN+VJ6ZK0YYgUGxlJcgLhAiF+Qn9yha8rv/uRfrTTnufxM1d0StyzKYQBLK1
         mIE5Jad+CokLefQr6aKwo7Fa7Uv7uuBw3BcaCjtf948oROX4hE95lWYsrc5uEi2XXMJ3
         Kj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770008267; x=1770613067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4Tg8YIZ5vgk1JPtFkTc5c+Dlc5nrpswbRPTVC81KsA=;
        b=YFQEJ/ZjzbCNWa0YUIrVW2YN2kOc7gQN8qCPoePpAuZTeHPIbmmVx04uTZkBiWDPXZ
         bXD3/R1ChaWibxJg6SB0UyvYQMXB3pGoH9QDhED6zzE9vZt8yZSKUwbeyap/Y4w8KFds
         dAWkOXc8HxxMOB8DiTXN/Be1ohRGEYNBBqhdNpa8vNEcC+nqMpf482pl3Q035M6NNSKh
         tGQ1T0aQvmkuAsy6n2gCgArFyxUCGiJhJPBMUma/DM5INQC9tGwzS6sNXkBt0Mp2W5Pw
         EqLMau3EjVOgZ3Oeir6NQdeAN8Awp84OuE0+hYlcXRCVg8Y+dCM6cJMugagfmkaZ92ii
         Vq/g==
X-Forwarded-Encrypted: i=1; AJvYcCXRraPSYPxuz9QjdhRs8KRnebnU9WTy7/NFZ8pK1FFkIumSxQMSBNP0r+tQ5AFxprneXl5QVCm2IkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpliVto7ogtpNIWgpV4EF20aS6h3W4gQlvN+WaD/9xFdC9L8Q
	Msun4WHNteqIPOb8SmSDtndrmS+7vK795I8wFuC1MPK7eiamoP4CAs3U
X-Gm-Gg: AZuq6aJBpm7EYjgQ8lK1xqUUA6hylTgIvOdpb+2AgUNCe16auD2s7pwmPWt05PRR+Y5
	WZYA8rvARTe8QkSt2XuR4v39j7tK74v7vYaweWFoq2nTUKle2qI7Jf0zDfJdA4IASOQn5GbEIq7
	e5lr1uFibt/dSKT4aVDPCPf+rnl4UCVoHks7JGrltlKJPfG7kc7+fEqCWJCSTp/d6qv25xob5RD
	N0LFg8m2n/nzRCydDYe+5TsI8HPQeLSeCvjYdYuQ/pCgdH131K5p67B+wGLvEmJQsfoXP79fbYG
	4I86O6ReK7j51omdu1tF+XQRRY91R1ezg/y/XmVEZAb4VCf9jjocCR3LDGzDx9YiSB9E4zKd56I
	ZA+D3zwsN59wtxYSbS+HJH7wrzIfWPvsSnLZq1opSWq8H8oCkA3bIvA9vaHuaNSgLzzH8CebXQr
	24E4B8FyJpOE26a0C+Fh4Zn1fvRbk=
X-Received: by 2002:a17:903:246:b0:2a8:f8c2:bf2c with SMTP id d9443c01a7336-2a8f8c2c08fmr48718755ad.59.1770008266825;
        Sun, 01 Feb 2026 20:57:46 -0800 (PST)
Received: from [192.168.0.214] ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f24ccsm18440864a91.8.2026.02.01.20.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 20:57:46 -0800 (PST)
Message-ID: <38704907-8850-4a49-b674-7e00922a87d9@gmail.com>
Date: Mon, 2 Feb 2026 12:57:41 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] dmaengine: dw-axi-dmac: Remove not useful void
 return function statements
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260201000500.11882-1-karom.9560@gmail.com>
 <20260201000500.11882-4-karom.9560@gmail.com>
 <b3df4910-da8b-4a8d-aff5-00c881de29ed@web.de>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <b3df4910-da8b-4a8d-aff5-00c881de29ed@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8653-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[web.de,vger.kernel.org,synopsys.com,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE300C83D8
X-Rspamd-Action: no action

On 1/2/2026 4:51 pm, Markus Elfring wrote:
> …
>> This fix resolves a coding style issue introduced by
> …
> 
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc7#n94
> 
> 

Will rephrase and use the

Fixes:
Sign-of-by:

>> This unnecessary return were detected with …
> 
>                            was?
> 

Will correct this.

> Regards,
> Markus

Thanks.

Regards,
Khairul

