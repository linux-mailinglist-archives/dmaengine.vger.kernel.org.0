Return-Path: <dmaengine+bounces-9155-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLGhFEY3omnR0wQAu9opvQ
	(envelope-from <dmaengine+bounces-9155-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 28 Feb 2026 01:31:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0C1BF6F6
	for <lists+dmaengine@lfdr.de>; Sat, 28 Feb 2026 01:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 960E3305CA00
	for <lists+dmaengine@lfdr.de>; Sat, 28 Feb 2026 00:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E606F19F137;
	Sat, 28 Feb 2026 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gneO5LyK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FDA1D88A4
	for <dmaengine@vger.kernel.org>; Sat, 28 Feb 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238657; cv=none; b=Q7apKRuNDxO+YWckyOPP4ZbNgIjM5ikL2SjpS9wyvt/tOPCifkCIscYArefzM18WzHlT0XJIQAjec7RK9teAntHnDPl1gFw8BTO7A0VxrwtBsQrcKXekxIXGoAi2wg5u9c/P2Jj91DdZSjyr/q6sP7syHJNP9fz5bp3SA+LEzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238657; c=relaxed/simple;
	bh=L3eoB+ksVS5pNa1XelmjagnFGZNeyPKeouyXTUhkH/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YWS7INcMfooed6YzWUgGnqNvZowOtJVqZ7sAy6Tp1B/GRc2rr2AZAgqS7jvLlTlPkVAbbDd1d4JPF1wpVzxxQ+atdUIfedMlxMef4K8U1lQLwKSfdjg9kwIvpptTEnn8K5IpkVDcaTUbTxTwvG0Utk3b+tSGIP5A9B50o+LYZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gneO5LyK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so2664703b3a.0
        for <dmaengine@vger.kernel.org>; Fri, 27 Feb 2026 16:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772238656; x=1772843456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BdiLRY9wE7GUq9ypbLX8bYFnfbYqhTMNRxTa1cOUbkQ=;
        b=gneO5LyKoezR713HtBd5+6rmqYddCadZE6JmulvmdHqQE5oSG26A8VgzLrR8bis/cn
         zkpBqTGEltH4aColo8/bFhqufAp8E0vwKD7h13t2Dj/X3IIjqBcYzfvtPwbNQepfdOuu
         2ey07gNQ0i5mNIEhFYyHHOGiwbhMQnsVq/oE+TyFIteMu7yi1aqhwSN8UypzciE+Vw6U
         uAqmBttsH0UrpJ4+nCUCaKaFbjeHk2GRMkZ5+ffsAbVfGiRb8bluYDYNRD4+S3lhQ1jc
         uHzj97uxm9z2Zu4HdO46mhW5kSnJwnFU7wOS3KMEpH2W0IiRfTw6omqAbxWiyNT4cAHB
         s0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772238656; x=1772843456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdiLRY9wE7GUq9ypbLX8bYFnfbYqhTMNRxTa1cOUbkQ=;
        b=n/hwBzTluq8S7MO6s9jdL57qOZbEMnar0Fc+EN8UDI5qPV2DTyPq8WPoAx2oX5q8vF
         MeKaNQcFp1q2RsqlFh1F93p9U5h1Y4GbMDH02O2HBfVc30HvcHsdirr6EvUNx6gX66Qw
         G7/p6m5BcXY/l9UmHFCwulAvRSkLlYhye58tk/o0XxVus7exYdXBWuO6/xDxYsFk13Jf
         36NGk+5bVKC+05GMykQwb2p953hUy/tzMoSneb7t7lemiXps5Lbhs40DMrphE2PIQ8E1
         Pt+0CJ9xdjr8NqdWMe4XyGl3KnMDAELMqgVyaJP8muTXH7D5SRDt1roQcYaUr/sP93Ak
         TnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD+iTi5Tv7WElKxLk+NhVJdHlufwMarq6caBGPFN6M1tk0eh5trVPcd11VEkakWhHKraHsznPbJ24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjkkvl+wB4jNLsYkFMPZy4janXXxmyDiB7NiFwRh3zjaBniDFA
	ElWgO7SVJskQjLew7vYIUvJfOMvw52ac7x3MpoQCAVK2s+1M28E8gSChVAg1wg==
X-Gm-Gg: ATEYQzwWT6EAi3/1xXWj3baz+otugrgTLMNbuSmBt5T62J3poRDGfvrdeafQe2pbXiM
	Z9zlObyeXRDI+8rnTFltK9Oc336Q4iqDf4cSX7IoL8PU1CWLf/fe7AXhIQ0FKaJ46wa5Wy1fr9m
	w6CabSkKpnE0Z2esAEor8oysEpxKPMyYFlGT43NnhsGUeA8dEBuk5MisYkEe25PWdcEbwIHWwUb
	3UDqw9+oRGs6PsQfWXTsN3FmK0lEmRHaGUV1n3FIg+/VPydSL8GKG7Fo9mRWWnDJrFc/QH81QQs
	mEPNCpacB2UWuzPr5cN3AD6GQlPc8RNxVGOvQmKh5dX95IDpdXuY99Ow8SHP8O1XqP87EvWWgYK
	0kLGlEHvsc+aAzJoVEsAUwBcJzh7TU/OwOr4N53YYRpuVIZ/zj9rM+TcAP6uXr2jqiPGgLmbCT1
	xsgFBRQ01S4VNBeIj4wX1bP6Ajbp7gCMDHiIUvfZqvEAI=
X-Received: by 2002:a05:6a21:9cca:b0:393:38a3:8975 with SMTP id adf61e73a8af0-395c3b3df82mr4492933637.70.1772238656022;
        Fri, 27 Feb 2026 16:30:56 -0800 (PST)
Received: from [192.168.0.214] ([175.141.94.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ea093sm6156816a12.1.2026.02.27.16.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 16:30:55 -0800 (PST)
Message-ID: <09f17738-623e-4332-abbe-86f96a5143bf@gmail.com>
Date: Sat, 28 Feb 2026 08:30:51 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
To: Vinod Koul <vkoul@kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus.Elfring@web.de
References: <20260202060224.12616-1-karom.9560@gmail.com>
 <177201865172.93331.8302213117386942261.b4-ty@kernel.org>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <177201865172.93331.8302213117386942261.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9155-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,vger.kernel.org,web.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3A0C1BF6F6
X-Rspamd-Action: no action

On 25/2/2026 7:24 pm, Vinod Koul wrote:
> 
> On Mon, 02 Feb 2026 14:02:16 +0800, Khairul Anuar Romli wrote:
>> This series contains a patches that fix minor coding style issues in the
>> Synopsys DesignWare AXI DMA Controller platform driver. This adjustment
>> possibilities were detected with the help of the analysis tool
>> “checkpatch.pl".
>>
>> These changes are purely cosmetic:
>> - Adjust indentation of function arguments and debug messages
>> - Remove an unnecessary `return;` statement
>> - Add a blank line for readability between functions
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/3] dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
>        commit: 6c5883a9ba296d2797437066592d15b2d202de7a
> [2/3] dmaengine: dw-axi-dmac: Add blank line after function
>        commit: a1adb6de361be08352badb45cce3214b8cd6abed
> [3/3] dmaengine: dw-axi-dmac: Remove unnecessary return statement from void function
>        commit: 704eb9b17a6178b01b20e16ff8d36337bd90e429
> 
> Best regards,

Hi Vinod,

Thanks for applying to patch to the next branch. Really appreciate it. 
Sorry for not able to improve it with refine description as I was not 
had a chance to look at the code for last few weeks.

Thank You so much.

Best Regards,
Khairul

