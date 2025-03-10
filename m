Return-Path: <dmaengine+bounces-4672-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E594BA5903E
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87C13A380A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B9B2253E1;
	Mon, 10 Mar 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SDJLymip"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640617A2E7;
	Mon, 10 Mar 2025 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600226; cv=none; b=tFoUcVSpl+XULX1ZeU3KC/rxSwY00ho8J9++F83nKecCsibb7WJyYCOvQXDaZs9AtQ6/XCcczKjtczLd6XAscPBdS9ZOrg38q8THU2znzftajagrwf7eSIhANoBd+/XKBe01SWPsDXbo7ieLJcc1DrTfj8t8vyAUeOG2Fo8CIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600226; c=relaxed/simple;
	bh=nwEizwjVfRNkakaeNjz30N3SBQfWGNsbW9XNO8YhWRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gytZvTRpZHXUSs7xQkF7LpELuQUbY0i5iBr6Z02roHs6aG0zFSXEomx7uzSzFCHZ0sGkdGMs1a2mkXDcmxf/QeWQNFltjTWXic8rpzB7LQsv1DIVhhMyrQ60HA2A+nYDD3ebqDJDhTDF+gXfSnxNgwjACKS4HYuLDTRgvkCqjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SDJLymip; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741600208; x=1742205008; i=markus.elfring@web.de;
	bh=nwEizwjVfRNkakaeNjz30N3SBQfWGNsbW9XNO8YhWRQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SDJLymipvxq3ZixoqFKRO0tLFmYWTJG72yXByPoZCjNa3Hl2NeIZtAW+F10jG0Cz
	 5rcrpzd8MkCQBm2V5gIuZZCmRoS1yQpEAK5j+ne0EiTLAqaPdacXlPnykob+AN+wa
	 cIbUeFC5d6uoCyKpYkhdKG2FgainyBhEwtDk3Ywh14ZKkAsCRCW6TekQZkhmWid4j
	 DqaYDLdBgfiJb6p9O5MnB+wLRAZMCXOt0XgxYzO4zBV2nbHtplfsc0S0fH30N/zXs
	 837RGEttUChvC8SXnRoyVlcovhgmErfcfOlcFHztfp6yeYTfqXfCU20jLi/IpzDnh
	 1qbgoY2LdflaBzYaBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.82]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1tV78O3k0J-00i8e6; Mon, 10
 Mar 2025 10:50:07 +0100
Message-ID: <c29fb786-bfcb-4860-b781-606e5a093aaa@web.de>
Date: Mon, 10 Mar 2025 10:50:06 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 1/9] dmaengine: idxd: fix memory leak in error handling path
 of idxd_setup_wqs()
To: Shuai Xue <xueshuai@linux.alibaba.com>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-2-xueshuai@linux.alibaba.com>
 <8545206d-4a7d-4e0f-812b-dadf923b5b5c@web.de>
 <bb29d6d8-6887-4eed-ba24-7392de9c2c29@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bb29d6d8-6887-4eed-ba24-7392de9c2c29@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YHhj8wRJcq7Ik2n7tdrbTrCOakGfW4l7pM033cH/lpnIcTmL/6P
 6DWX/BGjIp/KiXqiPY9kEDpVjR9MnDaGdJ1zUj1waIe9Sr8rbt580/ATgeuQyKYNuTWY013
 b5UgaSjD9sme2nANaws6iFR8mZx0zRWvuYaxFY9rWNFQusrGUFx7rUx9tsN9EXXdzPJBV7I
 gJ8gBa3k1PoDGNmnuuAMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W6NfeSMmN+w=;qxZlsgPyzKSrFV/wthu3AQOwx1l
 VCMLpYzv5nT0zjZpmClTkO1ISvvgpGVtiUZNqo7U1Dz85X+6Jp5p6qkGiCyImlsNQr4kQ1l7t
 q6iorn3b6Fr0gHR4ErFkMu/o2TspKBgcfbUAYnuWeotS57XtmxPV5nJnOQ0lYrFNZYNZpDdCn
 EGm3uNyfmPJJa9U4SBX5xDvehkITSJmJr/lBdZOYlJqBZkfhYSX352vRM1+FnTMZ3Cn7pw2fl
 yF0oBrXE/S8qOFcQttqkWuFpN1UIkxGFSBlA/lw9pFkNUwnKJczydTbw02VAe8dkw2AybK7H8
 v9+yk5ddwl7V3SxbfaW+aBOY4emSpwssGYazVcQeT4TpWjlsltSV2bPisOssKYZjKNh5hg+uX
 Ok9cfc8/16NarI32tTD4I/Aly3PgMo/9Na7++B9NQ82B5tnIkM22mf2V61K0wTo0FjCCgBWJ/
 TeiN0mGhHTzpR5lw/oE06xJ+zS4e9aa/3kut4Xq9z5uWIBmcdP7XvdnYt4cg9j2obnhUXT32J
 lxuJNJlEYeeN9NBuT9jyuFcJXuPQVvzqGxp9TLTOYcwC8QZ5ePjE2g816IPkVvEgCZ5ZNmMpM
 fs2CknL+/Ktgg+alztg6TEvA4/wrs93Dj+OPfPJCjWGk6HCgRVHsF8QhXdnrYh+qFvwsbAvmm
 ZFzpJ/0fc5d24IHT3Ms+fxE+L7IYRG1FGKjBfqwcvpGPeBe49A3Li4HCIj77vAsl8QZ5FkT4C
 6PeN9gKIKHhlP7ffz1GEMs1skWwAdh51hnKFRzaHNjg4JHL1OpqhzO7lVTor+2Fkmr0xxV4xO
 WadwI4TPA5j9bOOU6yFcILo59n8Foy+kntpe8csy9+lkXqmY6mugGmC4OLriBPXwrakc+zdgm
 Owmcg5r8+/Ek3t4nwl4nu7MY0ublE0w810naQ1ltUuW22aikmXpOafY0ytnZ3dWj1Ga3GS9FO
 14fVjXx74GLSuNGqqCh8kXBUDENHGn9adbvBhURosZK5YeM3tRRVHlbUyWhzHlCeTkb0eNHah
 piIJpfHUJRcz5l6bOSmYYEUHdwkDe9v1mk/TzEEL4bw8ku07hhuXhXAntvIhR6T55SaEjf5Zr
 nxz2XqwIAat81Ay/w/t+hbcYdzNfZkhpXHSkejBR8M8XOD76G4xYE++jFbaC8Tgx4KCC1j3tO
 +8sEf5sQS72PLF7n759xAGM2xWTYlHduvm67kmGETgTuOI6HuNF/sJY0PVqxc49M/zwL1h4WC
 pU6F8IfzvbWdMyneKZWuC1R6B0bbAMo0IC+4z5aE8DBKbH2PBeD5kkvszw9upPLFsvejpVVtt
 yc4l66w4UfjsmEi1RMwME6ZJlYGk6K6e6+Pg4eFLINDfoSKhOBWxN45ANyHtYdKIAus/ZLMJ5
 H84It9eJYw3nY0FrnNPUPn0fwySMvSUHgbZ2GGhXH6OfIPlbCQZJ5I5WytownRiHJR0usXUkl
 9+H4thQ==

> I prefer to set error code before jumping to error handling label
> so that we can extend/change the error code in any future path.
I prefer to avoid duplicate source code another bit.

Regards,
Markus

