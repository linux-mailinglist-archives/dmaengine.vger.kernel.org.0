Return-Path: <dmaengine+bounces-8472-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ4NHhO8dGkA9QAAu9opvQ
	(envelope-from <dmaengine+bounces-8472-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 13:33:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F39137D9A3
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 13:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B991300AB30
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6B72E06EF;
	Sat, 24 Jan 2026 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEQvjcQU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F56F24290D
	for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769257976; cv=none; b=S9DjchYIiXqcZwrMJrOBN6R738WZBxAs/APsJmXB4BOaXqcOlEzDP6T5K06t6Igg/AxpdY9pYKekGcrjvL2BdkH1yrP2Hn2VwWSn06qCMmz6KTHjBxtBstget4CMq03gGDxitUC3CFUIyzMN+yXsbeLtz0fTe4gCr5it8RnW4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769257976; c=relaxed/simple;
	bh=dUPIwyOqxuK1yrZkgv4BBe8ApBymrsYUiKAH74OF6Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3iMCPAJvsWssSbeMsHqw6GbbGON3YVjtcpf6ZWUVuMrm5KYwz96kYkaxl9TGoysx1b+dg5CqDT7gEBwpYIHhAwm0N0ojCZkjnWWOGdn7zBALHuZuFJcgNLt4sM1pOSR8pLwziP7mHMOl70DCtbi0NPOdBY/VUFBDtnfQlvC5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEQvjcQU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c551edc745eso1258296a12.2
        for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769257975; x=1769862775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+RqKv3M6dgzKjFURwFBDLsfb1FhMPInjJFw5C9fIWQ=;
        b=eEQvjcQUVF4XKGmas3+wuNMoAtuUxXLo7Br9AbA/qlyfoXzUvzFlTCXl1UxVj0vhzK
         UmS0IgmmYepNk7MJVxaBzgr+ICNv/v/pcYYSE0K1sZLFcvtDoKYPdGg1DNcldQhJ5eu3
         IrHC/V4xSe9mLNYn7mEsCY6B957heL0jIcMSYELPohuAfStae5M7LGpLLTWqHpdVrxIv
         3/+KytWqWReqhPHdEQPCsdZ7syQuXRRuGHigNuHYLRJydJ6cid7g9CteMXwkafjOSVvW
         DC9Vc/hMY86/E05GkUK2/Zk3EP5TkXOLME/J0/AKPgEoOUJM0nbCUZdXJVCGD28hy1Wj
         bpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769257975; x=1769862775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+RqKv3M6dgzKjFURwFBDLsfb1FhMPInjJFw5C9fIWQ=;
        b=ioDs6kofDVs68QkXJ2dVK9NlCEd0LNsqkhDjHS/QT0FCAXsA7ctQYbvujUW59KEMh4
         wnfmFD8O/nsLappRLPJ1Fu8+jcAN6EdqOUlANGxjqqAa83Z1f0qtsddu3hW71X0fAPFB
         fjKs6xz5IluZa9eoLwlfQzxDbHRhL+zsB9qLaUNWcQLI5vM2Oi90ruV42poeDE2azq8b
         6M+IXlSuZfZYn0XOvEUWDveejvYqFTFa39hPlaCXPCMyyGQJFO+tU2j9Mza101+Vt5io
         aQWMpHzr+Hk4RbJXl5CXeh2HTSEA1yeY4R7JpN7zr80wsOe0HqqWWUnG4pwZvH2Iw3qo
         BPNw==
X-Forwarded-Encrypted: i=1; AJvYcCXfhjmiBCYCwHRid/DxOkHb/4CR3XRinmaYUcSNg5tCMwRXTnk6JRk4RbcETX9fYBSSrtElVmTJt1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8MWDj7xuNQchNH14Cs/StPHgdX18PRfjcQb8M5nvZgNRumNY
	qbv3wUrg0DPLfI2dpCSkJfk+N+Jx8Seh0FBGRHKsEWeNqnLjhjlKFvid
X-Gm-Gg: AZuq6aIblOYac5cFtYxZWnBN7O4x21yBSnPu28ksITzyU9u0lIEBLi8gAemKlYKEiOE
	AN3tOJzdSqXEQZ96qerp7rx385uQ+YTwXwptJdPuKG54Kg8IEd8PG/mJObf1oAACUjzipczsa/1
	lg6mJFulWNXxeZ3bLMpwwqkSiwVrFxc3nJW8oflFWrZOaHnJPULUGQbrMojq/L2AswMBXW5z0iQ
	WntHnPKXW3kcXkrX6BZtCciqBCWOM6My9t7PzWzNeq47s1loOKBOuKPaOHdk91tmMymP7+3Dw4p
	GA2edhkMUVRMk4Yl2jrGmZKGNFB5I3SM25e+D3TnZf6E1kFwC1/4O/kiXIrxMTdYyVQBDjrFWif
	RUn2T+3drQ9KlyLh++/RCBJJw5XKVAhyCfWeLPVWRi0g7BtuL4231xgtKr5TuPSixhs29otv32C
	aRwCdsswTW+6pT82jZi0CRZUwx/EQ=
X-Received: by 2002:a05:6a20:2585:b0:32d:a91a:7713 with SMTP id adf61e73a8af0-38e6f79ce6dmr6530657637.40.1769257974639;
        Sat, 24 Jan 2026 04:32:54 -0800 (PST)
Received: from [192.168.0.214] ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a43fc46sm4563794a12.36.2026.01.24.04.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 04:32:54 -0800 (PST)
Message-ID: <8da8dc4a-1e5c-402d-8631-7acd61d21a65@gmail.com>
Date: Sat, 24 Jan 2026 20:32:49 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>
References: <20260124024539.21110-2-karom.9560@gmail.com>
 <40ad7d60-f3c3-459a-a8c0-5c65476c3cca@web.de>
Content-Language: en-US
From: Khairul Anuar Romli <karom.9560@gmail.com>
In-Reply-To: <40ad7d60-f3c3-459a-a8c0-5c65476c3cca@web.de>
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
	TAGGED_FROM(0.00)[bounces-8472-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[web.de,vger.kernel.org];
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
X-Rspamd-Queue-Id: F39137D9A3
X-Rspamd-Action: no action

On 24/1/2026 5:05 pm, Markus Elfring wrote:
>> Check warning is throws when run scripts/checkpatch.pl --strict:
>> drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:345
> 
> Please improve such a change description another bit.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc6#n45
> 
> You might not need to mention all affected source code positions here.
> 


I will improve the change description and omit mentioning all the 
affected source code in the next revision.

> 
> …
>> ---
>> Changes in v3:
>> 	- Split the patch into smaller patches according type
>> 	  of warning.
> …
> 
> * I find this hint relevant also for a better commit message.
> 
> * You do not need to repeat patch version descriptions here
>    after you provided them in the cover letter already.
> 
Noted. Will keep to the cover letter and avoid repeating the same 
description in every single patch.

> 
> Regards,
> Markus


