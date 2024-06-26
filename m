Return-Path: <dmaengine+bounces-2544-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA29185BC
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 17:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1508228A081
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7618C329;
	Wed, 26 Jun 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Cd6szeKZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540418E758;
	Wed, 26 Jun 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415652; cv=none; b=irKBsegh7JKRoTxfb3jkfUA4HRz1OOQ8pB7MhPbODM3XWK5fQkyg1JMhN4pIaKPEvDd9OJRdxtBAjlQUNOnO1YZtik2COZr0T4arI+2usYE7KIBTt4njmz21SExsBRbBAZdy+FOS/MqIYZqg1SS1j6FhGno8t23n/cJ6Jz0kzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415652; c=relaxed/simple;
	bh=WsxxdpCJ7n1faWx8RGOLhkTER8GXTEI/NlAf6ouiQoU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=m6KxjwzV2R/fwHGsENpAjMuP989lc/cRO4W7DKM3S/POicpEQcl9tbVPxITlcl5JcgZK20bWLZWcfoxCn3sixC8JC0UczOkOlj6KuZN4kJtMgeY/FylX1A+pOsjEclrq8IzB1lbABIrjsbqwBetT0Yvyt+RFUJ5JBEdOyqj/N+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Cd6szeKZ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719415624; x=1720020424; i=markus.elfring@web.de;
	bh=WsxxdpCJ7n1faWx8RGOLhkTER8GXTEI/NlAf6ouiQoU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cd6szeKZNucpiCZO+KyMFUBqRXDeiC81GoHZjsQWBx5TnCoGdBxLKmsHNQAPGPNU
	 Q/Nj6XIken4/wGGkgjO0otlD+l9XzklB+t3ujNZknXivG0PzA9nLm4CdTgNR2stCZ
	 kg3YQMZ/JnaBAaDxQMlH6R2IooUZQHLoIE6h+7IkOOaauYXENrWQwz8Bemog2Q/kZ
	 vDsl10Q1CA26DTRHS/Z7KPpvvj7CVyqZlU46WDgQrPS7MJ5+mv0PlciUYWrteyFd1
	 ihFWZ1KhnqFxDwcXAfrNdKyj1uFd+muTjmKdujUdA8v+fnASNdzFvxL6b+2FRYb0t
	 bdqQqX7eLvNxcF+bQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUUAG-1rw7ya0FPM-00KggK; Wed, 26
 Jun 2024 17:27:04 +0200
Message-ID: <60913841-7ed4-4fc3-8ec3-46e3500b290a@web.de>
Date: Wed, 26 Jun 2024 17:26:59 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, dmaengine@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240626082711.2826915-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] dmaengine: hsu: Add check for dma_set_max_seg_size in
 hsu_dma_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240626082711.2826915-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ESGayo9TQ/yY1z3/JmGSjA4Ggnzj7Pb8zj5ghRAQhP1h6AT+mb+
 4NUnrAox4ASYidZ0UmuKiM3cd8VwtUwYhAqGZhbzSfOgLXtuYH9HKIboUxjdd+CMyIDBI1T
 LhY7bC+rKJYnpLYjRrrpYeh5HPGS6KM2Wa6lpOGcpHe6z6zGvNNYyRtlDbh1RgifoHjPdkf
 Stani4OqophkR+C6psvDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4z07E+GbHr4=;EM2F0C17iJdtgPPEaeqvtstul/X
 XdiivHXpxwOaW2YBFsSSdDuV+I65+lKwdkg3TQffDdQruWpv73VdF1BxsAa6wsVd/3Oq+C+xv
 trF0g6TqImPXg0se9yUC0V4QQ6t3UyPkUmLDtQuwtvG7kKixR4v+p/n1ba6KPvx7PkRwWQxgx
 P0EHchQ3opjdRmpb/Dj/7Hi3Cfl6g3Etx1XqNSv00prEfafDkAHMz7We2xWekO/9klXhDgV/W
 /fD6xOHjf0/LSHHVQcZEgQRWkSkuM2UuXttATnPWqwCRdV32MFxpflVPDN6Rfkhz9JrJMe1lt
 tLJwc8GYn55T1xK4wg1qRTNHAJT/cpmCjsR1bLGhy8hj+9cZRP/RIn32SqUrGrZptYNpn1YUO
 h3X8vcf8/2PEW1GBHgXpTDOsQYgRnnNM+gu9TA/ojq/C5qyvCuica5uQMBbfhfCtp10OnzWBU
 RYBLb/VnMgp7UQ8gie8b8XQTUtpemOQuSls1M8eJvaS5NdQii/+fSRn8dEpChKQyq00CgUHK5
 0+GZcGkHW/iZJ5SU3D15n7+BbZEsIRtxclTloNkRnllKZHZ6mez9yefiuVFUu3zbSYV/GvHTU
 xMpiAc4kBsyPICkSD+bEac9yFU0e+e5cLF4kdRV2P+RR0DqDhc1jXBQ3PiQunF6PZ7uQ6RYic
 M8r7RB/GBFKcxj8FEVcTyjJT6zYQqB6CqMvc4Eom7JjLbKbZY5OQhRqVg5ROxUTcRrGJ+JC0n
 jd7bl5oc29QRo3zBpb8Jbq5ZfHW1myuaUNczYSfvQobPfWVnPDZ/xG+GyYq+foozLdSUEeESq
 9NL2UJik/ZNgr1TxJ5RHBeJJXbTv/sxOi8FIA1rCebazs=

> As the possible failure of the dma_set_max_seg_size(), we should better
> check the return value of the dma_set_max_seg_size().

Please avoid the repetition of a function name in such a change description.
Can it be improved with corresponding imperative wordings?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94

Regards,
Markus

