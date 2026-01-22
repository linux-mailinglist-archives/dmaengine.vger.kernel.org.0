Return-Path: <dmaengine+bounces-8455-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKfgAGsdcmmPdQAAu9opvQ
	(envelope-from <dmaengine+bounces-8455-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 13:51:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5666E0C
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 13:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90E088C8A81
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B942848D;
	Thu, 22 Jan 2026 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT+LmAMy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84038B99F
	for <dmaengine@vger.kernel.org>; Thu, 22 Jan 2026 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084388; cv=none; b=iVxIag/HaJwa+Pu19//1uMYE9iB0FZWxV8aqZD/BR7fDLdK5/uy1dL3kUgXrrhXTK3d1/HonHdqat8e2SqISuNUAtNXxwaPrxQli6gnOM8W+ZeP78+nHwdue8zqO4qKI+fEPiMFtOOYPXlxSKKU7vmuj6/xx6AnqBWHQu8FxKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084388; c=relaxed/simple;
	bh=RidYlJB2FsT+VKWDkbvDWui0s22uPVERGv/y9QIutIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tspZrXodt6k2WvWlncbXICXWxmmg0E8qvFR+YO5qFzGLZZ1X+97HO7gV4HGcKfq6yvoL0m5klSxw/lh24BHQ0uaYo/TFWpvbytR6MD3M0GSxZXHlZoeQvZZaz1ku9ptnoWZYP+hgMXYIcEUTNCNa9hqQV+tikx9B/+Xx8dZ/V0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT+LmAMy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81f4e36512aso986210b3a.3
        for <dmaengine@vger.kernel.org>; Thu, 22 Jan 2026 04:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769084386; x=1769689186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hXTRMyaoGEWJ0Gnbu4zHDgW1XdgqZbaUXEKPK62rYk=;
        b=IT+LmAMya8kehPA6KdQTCMDLpGHsNPctAvASDWkBc8wDunpMqYgmk248qeA5R3h1gN
         pKmOSVxVMw82eELwPa6TyMCotk/Anyt2t/bNhEGD8GZjm4zPFIyHX9MR/z/6ulXKyhU+
         EG1EjLQYMpEbMOikUV7kWL1v2XROMAM+9h+04FsUgAF/l0TlciA4rxX3S0PiBb8Ge3j6
         3WNnIupglKDtND1l+oIOJpqMc9VWsMOHfp3gQWQaIX9mw8KDjyMvNEQmeakWc5e7miqK
         fZpMni2O2TqR1qjvylPjZQHy4R/4QHjY8MA9UWCFZBzzwBon6IIexHYm3YiAVeJDNWBf
         K8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769084386; x=1769689186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hXTRMyaoGEWJ0Gnbu4zHDgW1XdgqZbaUXEKPK62rYk=;
        b=ScpgMv5I3EyUGsxvjTRWw8T1NL80uES7zQZ3n+hjp2tUccPTPW8b6GnvhJ9R3WcJcf
         3a3fHAy8CLoVvIjg033WQUw2mnI3Tb3OQbXMf534osI3TKKSGyNIk9KoJU1huXunatpz
         DFmx4MoRvqpasfeZW+MrQBzBr/gIgY0cRvlNA5eDfchEZpc48NAc7lAK8QJEEFoPIURy
         oDIpyWZF1T+5YPN5IsSPoXZYICQFN6XqcoMWFqA9tALZkMfHFHagvSZTdUzWKcoHkbn5
         x6riFLnLys2hNjppZAmeXVo0zp1pUOtGWbaD6O0A7dfnnnN/Wo7NqfkYrE/k/eOwwgj5
         9Tlw==
X-Forwarded-Encrypted: i=1; AJvYcCVy96c2oYXExYTvHmZ47U+wVJFutflMJfUtCrMf0QjvdW+Nbpk3FUKUiz4836tNNq3LtKlcSd5XxXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LMfpaU67/Z5dNJ5qLLgvuP2sWxDPUE79Jmw3nhTBYZbB35ue
	l4DtQxUs01RaVaLuiRtwUTkRjfTInG29zbQufX3iufVGiEFY/T6cv8pZ
X-Gm-Gg: AZuq6aLxCtO+5Q0ycLZE/CnIki6tc/fOKbZWcAyUxhEmtAy7/qR/uZiSMpyY7GewjTd
	BSxyy2lTv6tLJ5ojXzR8dk6LwZoH/BdTy3vxhsGFgExo5c0wMuM+3fiDMAOh5cVq0DHi77AMrYQ
	zuS2Pm8rcNYQgNuC6The0t3Ox3HtFTe6jvT6wiL6UgEoEaqC0ol+LIiB7NOgmBmxLpDBERZuUqC
	rmBdxqlyB6XLNudU11PyD9BFNsjsyiRWFeqtLnVYZAXXUKgrBs4QrrhvXdOTp/S1S5cMY7SFaRa
	WAKgOOQVjxMh5HhK/OoxUYLpcsnPJO7vs1TcTg9k/sEK1G7A+PbJBaHQJkR/ofzU1bZYZqG5wKF
	u3/RpoAGfdiarsDDhRKlw5S8TaxK/3nx/b1aFabmTl9IYuUSjQgMKWHYRh2V0jh++tKkcC776Mk
	qAww5e8X3WhdDe++b63XOdlxvFV3k=
X-Received: by 2002:a05:6a00:1704:b0:81f:852b:a91c with SMTP id d2e1a72fcca58-81fa1887b26mr17594467b3a.64.1769084386417;
        Thu, 22 Jan 2026 04:19:46 -0800 (PST)
Received: from [192.168.0.214] ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8218690eb05sm2441786b3a.44.2026.01.22.04.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 04:19:45 -0800 (PST)
Message-ID: <9a8b3186-a338-4698-bc3e-56b7fb8ad7f5@gmail.com>
Date: Thu, 22 Jan 2026 20:19:43 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: dw-axi-dmac: fix alignment, blank line and
 non-useful return warning
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260117233930.9665-1-karom.9560@gmail.com>
 <294276a3-a633-48c1-86cc-4c15ce43d96c@web.de>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <294276a3-a633-48c1-86cc-4c15ce43d96c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8455-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[web.de,vger.kernel.org,synopsys.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 72A5666E0C
X-Rspamd-Action: no action

On 18/1/2026 8:00 pm, Markus Elfring wrote:
>> Fix the scripts/checkpatch.pl warning in
> …
>> ---
>> Changes in v2:
> …
>> 	- refactor the commit title
> …
> 
> I would prefer a stricter separation of proposed adjustments.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n81
> 
> Would another small patch series be a bit safer here?
> 
> Regards,
> Markus

I'll separate them into separate patches in the revision.
	- alignment
	- blank line
	- non-useful return.

As this patch fix  coding style, this should be considered minor changes 
and shall not be part of "fixes".

Thanks.

Regards,
Khairul

