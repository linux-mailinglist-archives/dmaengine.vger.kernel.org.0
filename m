Return-Path: <dmaengine+bounces-4501-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21CAA37330
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 10:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5671188D425
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A77189B8D;
	Sun, 16 Feb 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JqnYIwrs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A4188CB1;
	Sun, 16 Feb 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739698457; cv=none; b=Q7AiObX+0UxyKywsok9ObwIcTBQLN2O8FyFKuazMWYsMCro5hLYDfHAm317iRcwlBZz5Lwk+BcpzG6fvGcnMnnf9YEL+x7o0txSUpUi+NA6ijbJC1KMcLE8ZHNmA6qJG5U/K6McUPO1HQNJd3/JSdq/1x0Pc7YE+PNE2eu1ma+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739698457; c=relaxed/simple;
	bh=JjasO57TmkHAF2+pt5YiZGmKt0D66MJKTHWtDtgXpOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlR/lleU9NsJGigG6FVpW50I6d+D8XesoOMtSHMljHbmA9IwkXqbXIDHa899OVO0voXcgAZOSH+9LPafENN0yT6EbtHzTHAa1KBOrBFBpOBcEo2vhazztC+/uLhSlKhQAzb2po0cbv2WlX1umQiBnWXO3GeJ/WpVpwpnIOPI6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JqnYIwrs; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739698447; x=1740303247; i=markus.elfring@web.de;
	bh=JjasO57TmkHAF2+pt5YiZGmKt0D66MJKTHWtDtgXpOM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JqnYIwrsfRLzj2ihBi9fLcTozo5SvmI6ArZf1IAtxmJLLpIATdmzFK80R+WsgUOz
	 NItk9NG+hRgUQLEkEcHpqVyBrQjvTfBzxlay94u3hRfld5RmfaUP8JVBegSwilNrz
	 WEfKmqEaYjm+c5OV6uTw/nftV+oJoXywakEpJOzXhsrNJNcTQoFdT8Wi2rjOrO3Zf
	 Be2EKsI088mIFMvUofp0luNG5z7s8+LBa7GA8PDQkenfMAcz2BMgg5So+djfeDvR3
	 XAoYHwnKBo4Wn8yZEs7jY3YYMHDIk1TP4wPhxcD5O72K2uDN5w6yACVgIJRq16ClX
	 GHpL856YKf2XTRLaDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.29]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJTC-1tUgqa3rbO-011102; Sun, 16
 Feb 2025 10:34:06 +0100
Message-ID: <825ed0c6-e804-4e07-9881-78de319aadf2@web.de>
Date: Sun, 16 Feb 2025 10:34:05 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/7] dmaengine: idxd: fix memory leak in error handling path
 of idxd_setup_wqs()
To: Shuai Xue <xueshuai@linux.alibaba.com>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
 <98327a4d-7684-4908-9d67-5dfcaa229ae1@web.de>
 <4128c7ad-a191-4c37-a6ba-47b06324a8b5@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4128c7ad-a191-4c37-a6ba-47b06324a8b5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jBPEHK56v1GiAi8FaQGVMj0HYTAfCUJmy3VnNlUwHt6570thwgX
 RpDz72g7Z9InZYkjX8+XvQo6sXsSdlLqqXS80pH9L6JB2BM6AjbpHmcXvy2fh/6RtqRxLV3
 Vhc9Go5Vtc2E+OWSZhnNijCBADD6e4eRVMq/2e8YSoDcsrBb567IjdIDXDUAnvHBwrvOEoy
 vuOjvQoHLtNjDXB9W6XKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3Ynx3OFfHcA=;I7SjZe99VdczEddmEAI4P4AjLRp
 2MlD2Gdy0uAYlatzINNQy+ySW801Qjcsm7AK0kmGGeF8By+kAg4ccSMwsb4JCI3eEh+ceaYnF
 056RBhuZPlbVuNhMIsgXK9OuDwqkVqIz77nGuQssLt/gpRCGmEYXMQS0R/ZPxpcibnQyzXhT5
 ykevBKGp57euwmAynF/k7/AyQJA/ZQvelegTtr2uDCQLAojrZjFKym/xTUsKsHpuMEiHampem
 BukDMA8IZDFP1gt1puM3w9ya4lSk+8u1X2qIwq6LLDaYkGu/NQBHrSVCUxFum9o7WJ5UYxENE
 0it/bQARCQ7ja2mLa3tVnT9w6aA6T8kpIntgXUZ0vpm4WA0xAmmBX2HLIqfMDu/SA9599lozz
 ao0mgn5fSCLDygJZQm5WS2J7eHYjv0pe54EMVif5uzO1i2x+xODFQKdWBTuq2HNcAirrGAJin
 EUIZZ+jq1Jmi83pQ6uZT9hlMVqvWP6ICiCT61mmTb3w4ULpTAAGUh70q19bCouCf4C8IhiC/a
 oJDrvHKhjtxocpg81ZSQ8T4ed7GhQ+Bnw0VCw2JZOs61ZtUU3OBYIhzn6nfR/+FbFu4+tk2XW
 H2s2x4GhAM9CL56U6XNuj49lwjqybsoSzODAbpJUgAYSyKIEPA0xlBYJstKtAvZvaDB0a+DKe
 /2qjufOcM82wSNUfotJTfUn7UECYV1ImCKKljc+9H8QZA3FARWSesDiHDSCyUZ71G5/mcyEsw
 CuuIPr2fYAr6HJuqakX2cq4fFuCIsUUdWfPqk8wGu7HmTyjg9aqtmfEdeidcBwgpIhCvmiwYv
 3fiR5MLiM67PkzN7Wm3os/ydFnoRln2j4q105rjSfmq/Y6xVWMhzU8yEGdVNWSoj6OD7W9QMN
 LD0E1ZGVZY7smxxS54Lj11As11kygFY11SL1jQoxp/OAywAQTAj98yzuNhLuVU/qU4Ii/CUqA
 u/v1zCeIHnx+c+VMHq3nZk5pkowCWU7XpIS7aL1OoFkqhPmaqe8h2/4aQMlPn5Mp3TLK/Nmn3
 1HidzAjpCRe67nnRgJ3AYsG5HrRfY+2oM2TXuVZsTQ0i8AZGBR+EgrimWLHZorUBMwA+MlnGi
 2IF69qfRRQ7Ppi5pE6OVVzHx7ZPgwtWp4mgN/q8lGOC5oZAJOsetEpNe4N85m+gsTf3IjfMvK
 XnhmolF7GJIk1s9uen0/QI3Zq3orTCkD3xCdJBspN7UAXWs4jzmfwVtEcQXTrN6EN6Imr/o6g
 YLoLAkslBbtAd2mcg0ReJnHzNn+u1OgXOIzWLkzonpkqvbcxMZJ6ohnM/vAqs8LF1aHh8wsGY
 FgMu84/xA9ctCTaPS1L5Bp+fc9ZDM/PT3uu3Vcsxj/egCeHk2juo9n52hpymEEBio7iRFJm4V
 ofPTmlYy92mGxxOTolRXUuWS8G6/dNRFrI5k+7Fti52NUy3Buqyl6H9RIEFz0JmYBg0JfzLVv
 qZcK69tQBU1sWzKx3QaQpRCLNv2E=

>> Will a =E2=80=9Cstable tag=E2=80=9D become relevant also for this patch=
 series?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/stable-kernel-rules.rst?h=3Dv6.14-rc2#n3
>
> I don't know if this is a real serious issue for stable kernel.
How many resource leaks would you like to avoid with your contributions?

Regards,
Markus

