Return-Path: <dmaengine+bounces-8638-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNw5FzGUfml6awIAu9opvQ
	(envelope-from <dmaengine+bounces-8638-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 00:45:53 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB293C4666
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 00:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3718A300F9F3
	for <lists+dmaengine@lfdr.de>; Sat, 31 Jan 2026 23:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875DA3793B7;
	Sat, 31 Jan 2026 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwNT5w5P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B436606F
	for <dmaengine@vger.kernel.org>; Sat, 31 Jan 2026 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769903150; cv=none; b=IMgITj1q1ZMQ8r7PPNpxyUoBDOyGlpntR0orGLw6ZZcf8yks7bh9/iygV2blI26TkDM1XVdxXjuv/LYZL0Pzu4yp1/QFyu/NvNyWNCM7gZAuPijsQceoU4Px5fL48gvdSXvubxJT2iIyhlp1bfmnTD0ia+DgOBnfIFT528rMHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769903150; c=relaxed/simple;
	bh=qUSf9IUvM3UWnjG2he8D9NxofEc2DeZj8uFahKBUGcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cG+ep5PJW2XSN7slbm0hEFY+y2g0a5cVJ4MXdUgvsk2LkJJU/TfAB1B80Ox6VXxiz9P440HBWKh8TZx0SrAZlJpsC2rW2Zjh2oebJ2/YUy+0PyC92Ownv4vATrpS9qFPpF4DXjur/oSD1TNRiFYFnlJXhkieKT6TLsQnxpgqiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwNT5w5P; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a8ff2ca490so1530905ad.2
        for <dmaengine@vger.kernel.org>; Sat, 31 Jan 2026 15:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769903149; x=1770507949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AebPf6wzOUYbhJVXcB2xVvZD1Ipk4JRrvUBmn/9b2L0=;
        b=SwNT5w5PDIb3lH7EGqnVEYAEMRT9cCR4u+bBfxrIwUtGccEy8Bs+mnAZHdJHVJBzqx
         jkYUOkIKtNbUHavXp/A814uwNlG4GH43IjNrBYiaPd3y4BqT/4RlKLG4tZLW11t0a31D
         ST3CTMbYQ7S4CC8JnkTohIcfbIIxDImDRlVIG/7XK/Kv0Fl9vpnfi2gKSUWYcQV04mwc
         76msB2ulek3V/+12OK+vDHGWQWtOK4rDRuxAj15jX4totiAZ3vhXjPe4V5wuAWqARPmt
         SjA29RQxtWNGZuGxtKnEZ2ufyeeeDlucXVUGCts5BOzvpnbmBMYu22ARoEK/NHHaYynj
         NJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769903149; x=1770507949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AebPf6wzOUYbhJVXcB2xVvZD1Ipk4JRrvUBmn/9b2L0=;
        b=Dj6KgFKW06H21C/j60YE/dSNK4JI9IYMcujPiS+72vOuDejByEUQNkI8wZi6xQmNYy
         dTA7tsP523z+9PXaJjbGoVcWuFiRjYpFDyPAirwRDPWeUWtyNcfW1nXSnY8G1ovb2iS1
         a/e6oYl9PJEqE8lIF328uYp0glmB5DpsBc7d+sypreLIMhB4AgZAKHNaZQ05Wg9ONC6x
         4ZsQvBm+qeHWmVk7Jy7Oxe9caoO+8bIlQgE+g4L4lCHTM2gzkWQg3wZhqSip2+hoXby8
         bdmanGEUJLE9cLat5LrEZEZRLwJnpc5ohvZMtSn4IV7qOrAVFcmE0NhXHHMPFA0s5eLc
         yrPA==
X-Forwarded-Encrypted: i=1; AJvYcCXORWHn9XIIIhB9AQSIoyC0wrzR519PNog4MMiSTJOMwwf0f3/rNKdH5jou2qGQzuCnky9HMjsP20g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9PMjvJRk35yTqGoJaWpCmF1pT6oEDoUqEr7e1TPq36mvrxxT
	QygE9QgmTWBv1J3ew0kJLxRJOHQ8QTz8OTrwOqe1tmHAr8gmmn5AGHSr
X-Gm-Gg: AZuq6aI0noCcDTBtURLIQltET9/SN7uojXFmMglYmYBrQY2ETgIFFl7cmtCQG/y3dVY
	03P7/VAec/mcyxYY7T5YzcprBLIyGMChKDxkBgDbY2JdzLeUoD0DIZqmex5SYzt2Gj2YjA+Q2VT
	/ZhB7vYZq0Ek08Vh1dPEWEod3GYxBxg17a2nONq9r+M3E/B64C1WFTIbveefW0iW15pOWZTGveU
	D/X0WXY4zgPYiGZet6uIlPvmUYPLDM+oQgdVz/RlFR8/9JnBYnWx4SKh8QkUdCKrJT8+Tt5YNLx
	fhQpemoZt2oz5ZrCGu++eXvbZIdLtASr1jOdMQtiao57xVLa5Y///mJfKI2gVvGL7DC4C2flO9v
	W5pCrbJrSM/pSXVSzi4jFeWzqZMPe7fsnmxwhIL3o2R102MzUZKbTpVQyR664SsXjn0PXENSL1t
	KpgfQmnoEy9PJBFsh/nfVbnikA3ByR2UegBGLjcQ==
X-Received: by 2002:a17:903:1ac8:b0:2a0:d728:2e79 with SMTP id d9443c01a7336-2a8d7ed9bcbmr74402635ad.16.1769903148639;
        Sat, 31 Jan 2026 15:45:48 -0800 (PST)
Received: from [192.168.0.214] ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414fc4sm110818935ad.32.2026.01.31.15.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 15:45:48 -0800 (PST)
Message-ID: <4ae74b54-971a-4e92-8155-ef3fb00ccbda@gmail.com>
Date: Sun, 1 Feb 2026 07:45:45 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260126103652.5033-1-karom.9560@gmail.com>
 <20260126103652.5033-2-karom.9560@gmail.com>
 <425fd53d-9b97-4d4d-ba21-ef35d821c89b@web.de>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <425fd53d-9b97-4d4d-ba21-ef35d821c89b@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8638-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: AB293C4666
X-Rspamd-Action: no action

On 26/1/2026 7:12 pm, Markus Elfring wrote:
>> Correct alignment issue so that continuation lines properly match the
>> position of the opening parenthesis.
> 
> Line break?

Sure.
> 
> 
>>                                       This alignment issue were detected
> 
>                                         This issue was?
> 
Will put it in the next version

> 
>> with the help of the checkpatch.pl analysis tool with --strict --file
>> option.
> 
> Would it be nicer to put such information into another paragraph?
> 
Yeah, I will do this.

> 
>> - 'commit 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")'
>> - 'commit e32634f466a9 ("dma: dw-axi-dmac: support per channel
>>     interrupt")'
> 
> Is there a need to reformat such details a bit more?
> 
We are going back in the circle. I already put the details in the form 
of line and code but you mentioned I shall not list all the effected 
line before.

> 
> How do you think about to refine the summary phrase another bit?

I'll refine it.

> 
> Regards,
> Markus


Thanks.

Regards,
Khairul

