Return-Path: <dmaengine+bounces-4776-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BA1A6EC55
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 10:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73C616CD27
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 09:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2E253B5D;
	Tue, 25 Mar 2025 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="I1MlzG8X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4D1FC111;
	Tue, 25 Mar 2025 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893970; cv=none; b=qyyb3UEhU+r3H9oqgpugWXzermpEw8q3Mr5pKn/rIi6uSjeBpVCBbh+n3zVDr09JTY95FEuwly4YIT0AkfTva5kvzpMTkL7qhqCXKvAXn86zfqUmrEAKdZ76J71qr2K/+E++ebVSeB2xN0omcBmkTBAwE6G1VSsR4qgOmluXYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893970; c=relaxed/simple;
	bh=7735V3C3ILJk25/lRz1qPycq191SaOU7EuCWXdBwUY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqznjXzkbu62rQyGOQXXXqYf9D+4pS2MUsyoHNT0pmSS3UAbtwFeyBAXZowTXnsn3jdMiybBjdS/eAoCmoNjvHd8oFqW0pQ6sKrjSmKiVS/2tXge99HPndEH5M3E/wDVkVCdrNbxxeCxwQz3sEMBPs6EZ4+yfo7hu3VAzRqDNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=I1MlzG8X; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742893954; x=1743498754; i=markus.elfring@web.de;
	bh=7735V3C3ILJk25/lRz1qPycq191SaOU7EuCWXdBwUY8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I1MlzG8Xh+HByYF3nbgXmtn9lDpdE6p1UYYc0DT1eHcHx6HxnPyM+M2wWc8HKbyM
	 jycicOwkyYfXhAhB/f4bZRqNsFpFqJVCbGYj0Cs7ey7ZmyUesr/xM6L4LuRlk8xmB
	 i5TwwfiPwDnucf3UU4c0O9qLc7YpWrlos9dHrQYunAeeWPFIyMOfSP/ycjUsPrZAo
	 bJNEWqrUSDrHoBLY5C1zI8aaxDABcK6XLS7MJtvBr6HClr2LjV9p7wxB5qBqH/uRh
	 9csXnnNwqHQ1ONcd4mgfXUVdi4Pozdwh7i8bqiM1GTw2vRR7AilxZpru7bPMkA0J+
	 KvbVo1yQcX0vOYK5zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvsln-1t76P739uh-00uWjp; Tue, 25
 Mar 2025 10:12:34 +0100
Message-ID: <26e36378-d393-4fe1-938a-be8c3db94ede@web.de>
Date: Tue, 25 Mar 2025 10:12:33 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6] dma-engine: sun4i: Simplify error handling in probe()
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250324172026.370253-2-csokas.bence@prolan.hu>
 <92772f63-52c9-4979-9b60-37c8320ca009@web.de>
 <7064597b-caf7-42e2-b083-b3531e874200@prolan.hu>
 <7332ccd2-ebe6-4b9d-a2ae-8f33641e7bd4@web.de>
 <7afcbbee-6261-4b2f-be14-a3076746d53c@prolan.hu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7afcbbee-6261-4b2f-be14-a3076746d53c@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8IPLs4JjgoAwnZBVuo4oHJ/Ciu1YA+xoS2w/ZcwW/pYUMnMiIbY
 IwDmkMzC6yXPtMraEcf+SSLLUr9KOd205vJ7xm69+ApFyfidn9izbw6lVauJobrMWeP4GLW
 cY/2KiFKLi3I0dgOMnqkjFBhO6g6KmcgL31nr2aXE+OJ3K/bPYseWklQzUK3pkhmdAU/Jvd
 7KO+Dr9FCpC2cDQiL7mzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ddw/l2RqzMY=;OKc9+i6eEjX7bsAuzX3wQky2u9s
 S1dm/3/p506efJEfN07cglPPulQ9g4K9CH/WH6pQT2uXEOQRvGnINz1mC1InRyhxUrZR0BJiT
 gihrvCkKXMj7DgJNvvzFhwVKK3MgvfdZkYL6QVgs9O2asOGqqGZh7tC/OrwrjWswc9cmI61B0
 eOxh5ISyuq++7S5P9ulDrjzyJJdvFmz6owlQF6BAnsvvypHFJ1xUbC0Dd91xOzv5cqgnTtQyt
 fZxHM3KQskbLyequGolU+/TspYgZAGReeMPev8ARFbxLVOXNHLPe+Gy/YR4bBmdsOKAjrj3/W
 Tlp0f/LtDlKF0nUHerPGzy/tNcjTPbCj4yZIisg5MmQTm4ZBXFuXicL6cLXqufaRBysxYVbqg
 R2Cn0oaDmolNjcb1jgLQSVEXChuKx3iwTlfOorgVQThAEp7FQ8cvw/Sw0+bcEvPEHtK6lWujt
 QnWNtL0rtnK4Tzih59WfZiYX4B+aldX3cl2wCnFLXFNyOlauNkr6gZ0SqfGkSH3JITiJiC+Ln
 jp3z471tMdksUcZ5z2h8Gy2dYB5RvIF+ZdBmkKthES4xZk8PGrup2Nex6F5ZmeJWzVT0BEjt+
 ZMN3jYzhqnu7Ppafcnhd5Px6QBtWkK8I+Mmf72Kv2Fy+ZmmAejfzhZNyPVsKHFTX9eH2tdYah
 5anCluA8MrQuDji0d3gL4QBQPIwzF8SHG9AfRrnz6r+fOamS7pOp/VeWlE9n5OADxACSU2U8r
 65WX8uUiv+SSbuH00hYZ/wj4Yxe9DzgTMTlzLWnnup0JgVNGQ/EpBocteIghAD0E4qwaIUNds
 H5WJjPmJZWV+YAgRTjx/qfkgaWWXRztnJZ1YrWt+eHZTxCtPAIENTDu66GfwVc7NrnPSpv3qK
 i2CJYBtdxNWxseJmWBr+uwLwDrrRcOkEwDlrslnR1kJfv292LGcyhDQ6bkRpFt4I1aKA0T0ys
 GfFYPHBGqC++TUdYSjA3hboAFtP/z/7qssZ3HywRJSXvsFi5TLHxI3IRRABLKaMYLmPpWPGBS
 4ntvD5t0WQ3t13MdrH5xjTiylcqK6c1z1feSQWAKyiKTOJ7ogLIh2E324NCvjZ+XmywbFaxWz
 TGS12PU76KjIR2jHZ0KO8c9Rx02aMU4rz4BH9XaghiC4spr25WFU4rwXt5Ekml3HBkfHjTJ1d
 Nsa38Mo5/LhXXx45zbh0IzNjm0xftu+1U9KDbmNCFbIolp8T89z5INSiE5hVIamuMIwxTP4HB
 EjP7qcDc396N6YVkUDLfGI10zpbFWLrsTAxIvMjIU+FUgNsLinkwsKlXbcz7H82sI1pVKdDHl
 FR8izw8ldMq5Awa6ZlX2UEHaegkR457PhqJWAi537TdnPZxSvPi/H+nSSnS2lzuxwBEGdxe9S
 Um2QbpnfLWvMyl0v0TbkPbYCMDfY73Ot5gvcSzrUDKBIKgIYcgoh6fhdJ+gOZV1ts7f/bAU40
 6GpOBK1faEdJV2iPE8XtNBa9IzZ6taZyG9aCjZEo0itp167Kl

>> Implementation details are probably worth for another look.
>
> What don't you like in the implementation? Let's discuss that then.

I dare to point concerns out also for the development process.


>> Please distinguish better between information from the =E2=80=9Cchangel=
og=E2=80=9D
>> and items in a message subject.
>
> What do you mean? The email body will be the commit message.
See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14#n623

Regards,
Markus

