Return-Path: <dmaengine+bounces-8652-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I3ZMHYqgGl73gIAu9opvQ
	(envelope-from <dmaengine+bounces-8652-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 05:39:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD9C8325
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 05:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73BEC3008A7F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 04:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7EE26059D;
	Mon,  2 Feb 2026 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2IoewQ+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02551C84DE
	for <dmaengine@vger.kernel.org>; Mon,  2 Feb 2026 04:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007138; cv=none; b=fTqGjXE3xAMsB0uz3R5HIDoCQbPNIrUS/p7IaLple8CqL0h5kjVnFCR9bew3Y/8OYOgfw5n/0lK0puEWtsH5089HpFu2Y1SumTQ0kCjASyXTbBMpQK7CqB/6UrJjLRIjMPv5YPr7jw1h4H5BHhB/cVxt8+Ag42yF5twX0YNuW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007138; c=relaxed/simple;
	bh=OCMbDjXL4YfVoCyWrfivUETofiuaXlO3s9AHv2rrSZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+gY+rref2wI5rp9I51Zmz9Ys0/o/ksM1J4+3BjPbdJm6A2TRHzJF1If8pAcURadV48fTjm7W92LTASeKX9ZzHspnqg1/6rqDsT1lKxXwCisVYYOpoWteh7zaML/qnAw3XHgQCuQVIe20b3qhaU8rjLc3iDs0+77RMFWpn1CUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2IoewQ+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f39438187so2218789b3a.2
        for <dmaengine@vger.kernel.org>; Sun, 01 Feb 2026 20:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770007137; x=1770611937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAIIQsxRwvFCPwQeevw+IcnM+RUmE4TqaK6v/NU8tzE=;
        b=K2IoewQ+FMfXmQxLJirOjR1jzC9xwQHlY8Oa7sSjDZeS88T/vPFCXEenFeuVkZdfwg
         ko4KVjIcUWd0+0RSAc85mc7HnHr8MrzOkspAof0+oJzhpUb8YTIsG0cCb4ei0YnX1c1D
         onLyywWG/DG5KwV/bOOd92HIbfLGwIT6df2qOQoWkP5ow2mxSbdyfUv1KsPIhbevtrnI
         gq8gQIrhTpEjnw2VCiLPA3ForBy0FBg5p9UAtN3xIstUW3wZwwKmGfWRM80NHI1ISzq9
         Eh5tYdRNcj3BWe5LnHacvUGQm15uZlbTnKoLcsOypkEncxcbKF3KuxtKJ4L+yJRZOYEa
         QENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770007137; x=1770611937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAIIQsxRwvFCPwQeevw+IcnM+RUmE4TqaK6v/NU8tzE=;
        b=k44xPnibUKa8O89xfP/1OgFNKRtUrnjj+ldIbLthwl3cSwFzwMsXdKRsKKDkBRyH7X
         +UW7f8e4YMnTSzVSbkpthAPp/UJIx7c4v3MNjFCBEoDPcOtfNRh43wyMDF805hgVyTfJ
         aKvSIRmcvoQzaBXz45vf4xJYVIDLTHK113GcYnnzKzo3gAPWCeRRfI9MK2/iOhXPNZ3g
         QjlV+mul+z97+e1qWyNDLcwiKBJbszblyRJEO4dcB+MyAMrqyInWrAcRZVoo7jngqCoN
         P0O6JnIG0vkBqO2IIKUDU4OZq+MkzlT+RST+8oL9aJSfyqlq8+t1VEjrkeZ+HPacKc5Y
         a7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVDm8dB89OjXs83ULgIJxfym0/viw12rsF4WFVsg7tJYFiLUMgziRAIT0Ka1koNpjFkj+fF8eGCLYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7dOzqoS1vAsFmveviHwzLW6Y6PWLvuP1UEPITqgB7bnaieEy
	Q4tOSIk9cVoOUFCQ5UieYa8dSEFa8QQSS41mPf+79pLgEkbvVogsoskJ
X-Gm-Gg: AZuq6aL9GwZiy/laDkeL8CtyJKTyUE2OLQ7Hup+vOEVjHd4xIEr9ZQGZ5Jz3jVGdNd+
	Vx3YJKbxJ4CD4sIBXq+4OcK4pc4n9lYS6Z5kTeZok+/DrnzFFcqKWf444LDhAiIAqVqLILHa5Xb
	CVkseFY4qqNEcCSBToqWFNgIs34kNoILyYMEu7mu70vv2rE3p673TTOaMHGkp4M6Ps6Qx7lIGck
	UE8xeKplGU5upzrsQAgmvyofPsCml3D+nJIkUqWiItMrvRHUHQNohByPnghTzStlfria5i1ETct
	Xp9Y2KdPQ/u7TPkMk+WC0zEqXyBw4GIcIF2xwttgG+s8o54UzX7jmSgM5mJPo2+S+HHqI1mDxE2
	Yo17WN9HjZE5eD5HAJeyxaYSwA+GbqwFW+cYPJgmsJm0G1STpF7YVUew5AZYbH9JtwkVKj+zmAo
	bER2Bocd8vl/ef6O3qeP4KWD5IdHo=
X-Received: by 2002:a05:6a00:438e:b0:7f1:7b2a:ab5b with SMTP id d2e1a72fcca58-823ab67150cmr9407790b3a.27.1770007136976;
        Sun, 01 Feb 2026 20:38:56 -0800 (PST)
Received: from [192.168.0.214] ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc1asm14783195b3a.9.2026.02.01.20.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 20:38:56 -0800 (PST)
Message-ID: <461e7520-7d64-421b-96e7-c1b29cc91da1@gmail.com>
Date: Mon, 2 Feb 2026 12:38:52 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260201000500.11882-1-karom.9560@gmail.com>
 <157e96d6-9d99-4ca0-bbfd-626def824c8c@web.de>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <157e96d6-9d99-4ca0-bbfd-626def824c8c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8652-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[web.de,vger.kernel.org,synopsys.com,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 29CD9C8325
X-Rspamd-Action: no action

On 1/2/2026 5:57 pm, Markus Elfring wrote:
>> This series contains a single patch that …
> 
> Please correct such information.
> 
> Regards,
> Markus

Ops, I will correct this.

