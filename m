Return-Path: <dmaengine+bounces-6316-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDEFB3FA41
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EB616C063
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AB32E1EFD;
	Tue,  2 Sep 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="w30xR8Jn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29CC3D987;
	Tue,  2 Sep 2025 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805086; cv=none; b=V9rrxQZ2ZHaBoOBCTJZQSZ1tM3W9q5GIx2W0ruNiQdTJgZaKdC+4ceiiCkyuAQcNhgojLUHVbxkofe0Qbv4sJpvfswiTZhZEXfPwJCzQM1d8uq5kFxWa2N8iJBUSNaC1MSYxT7wre8/aALYV8E9FcedZLLrlYFx8mx2itddPbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805086; c=relaxed/simple;
	bh=1dbWm18+r0fq9wolRbLel93QkllqI1woe842afazZW0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Nb+DddHl0Rh83UahC5/Fn9fB5O8kJpO6i0/JPL/vn67yPfy56MliZWH+nEnqQ9SxVCvXq4fhbcVsxPyN2hZJcqwasyaxcTWDecCgx5HHgD5LMMqqAJsuqJUPksfs7gieZL/HSC8oUPIFvOl+SIb9A/MTOEZQiJrjLGYMWSVX1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=w30xR8Jn; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756805072; x=1757409872; i=markus.elfring@web.de;
	bh=Jo1K3T9e/LVSIg8mC1objN1DWoFTQaf3xHVgfgLf62k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=w30xR8JndKzDHFdcsTNfEWAhZXLSBJGfZlIu8NJWKqgPSbeZBdlQYKR3L0L4taE9
	 PkN7CzMGsZB/FoklV1zLEj3GFAFrmwkvd1I4XerdsbsI+XHw6vb/b+tbAvdrEHIVS
	 /XhNi0qt4NciRk7ZglDLygV50ICVD8FNaMec11wK0lsVQlPWNWixWceZwQDbjA1Vf
	 4B9IzqXw0d9M/E3beiLkj9OtUzxSD9AC+WGKI99MUrcaM/dJFAFiiEocom8PJyOcs
	 BXi7+SOY81e55YHynNevmYT/rKNWbyRDvBMZKF8gSu33N8pk+RcT4rozupBR6ahQb
	 XsSjvd5QrnWq7C1eFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N45xt-1uT96U3SdN-013cgW; Tue, 02
 Sep 2025 11:24:31 +0200
Message-ID: <8df346cf-bdc6-4701-b4e5-87bc55d30234@web.de>
Date: Tue, 2 Sep 2025 11:24:29 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>, dmaengine@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>
References: <20250902090358.2423285-1-linmq006@gmail.com>
Subject: Re: [PATCH] dmaengine: dw: dmamux: Fix device reference leak in
 rzn1_dmamux_route_allocate
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250902090358.2423285-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:f0dQIVvmsoLhxEWPI8WYTJkefMn2+D9ooaSVjnJmco2KzQV8jqD
 QBmFBsmnFopKpCDNT8B9PIU4E777f+EUVV9XiIwpf9xMd/CKHfnXEvoyBnq2p//OAciVwvX
 yZmIRPEQ8b3LUPEBE7/HS8Qh1xehyUoFMYbFYUrVwEzfcwrYi/9PgnQ/6VlY5q4gsEipg9g
 fN0HT5mNknS4fokFXWRPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WOE/HwBYmbM=;iscepFKLebRk+VkOXqJsrxfpvjm
 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

> The reference taken by of_find_device_by_node()
> must be released when not needed anymore.
> Add missing put_device() call to fix device reference leaks.

1. You may occasionally put more than 60 characters into text lines
   of such a change description.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc4#n638

2. Would you like to increase the application of scope-based resource management?
   https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/device.h#L1180

3. How do you think about to append parentheses to the function name
   in the summary phrase?


Regards,
Markus

