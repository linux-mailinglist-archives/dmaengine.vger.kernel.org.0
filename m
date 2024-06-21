Return-Path: <dmaengine+bounces-2490-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96010911CF8
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 09:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A891C21EC3
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFB316C6B6;
	Fri, 21 Jun 2024 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fnTQCzNf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090E16C69B;
	Fri, 21 Jun 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955453; cv=none; b=McKbmEPPGVMzcCOFjoNP++is3XoyNMa98+S2J8Dx769dTilajbP3KTOzL6PyTdnqFY3om7Q3MyiRerQExqgCsPlQ7UQiQ4tah7yZB27AEbb7RjjkjGMAgLPTbtE6mSXBQ+bgHLr87OYx1dSVLd3cz1Ckp+FTvm9fcCitaajfrlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955453; c=relaxed/simple;
	bh=0VIfHxW0+liwplhCqw+Yef8Z9T89WBewbGYmD95IuEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blq/WaOvqnuCzzpus1q2Fw0MKBOFIE9qTnSndKxmsU89O9GRJN49sJjoS6kR+0ty2WDIDcecmcv1DRDjW6USWHSIhRjOGmylGEiSfvzAyNEu4kaPvocNT+1JMt6unK8kl10jTvcI49E5B/4O/FOUgsdO4pei/vW3YmdsqTQ0I/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fnTQCzNf; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718955413; x=1719560213; i=markus.elfring@web.de;
	bh=0VIfHxW0+liwplhCqw+Yef8Z9T89WBewbGYmD95IuEA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fnTQCzNfN4syCaJ7IOp6CJ2NlYXkBkYgxVqF+3tO+5iHHKvRJOMyDYBhf6qI0v3k
	 Eu0lY3/cj6KFd46Vq3xTBzQVq+EAj+4+CgMLczqkZLHBB/Vf+gR78Ol3yUgXqKWSE
	 MY3kpN4FFWk5k3js0VtySFrqaD2X+pohcqGGxFzxowNP7rW8bB9/yxVABXzDGBfA+
	 9+PCDOBbwU3cIDYobGs3M38kz6QBPkD5LtwPJFjgmVatwHpHZOmHDBgACrWUeUvNr
	 FPoZQrIh/2aTHChxPTeSSEFGFNL3KMNeYLbKPV0w1CySxh0pgHXXSbXRLOelRpXIv
	 rpltTyrATTwWaE7xtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1s6nBb1npW-0085aA; Fri, 21
 Jun 2024 09:36:53 +0200
Message-ID: <41f6ef6f-91c1-4b85-b049-efd25e403b73@web.de>
Date: Fri, 21 Jun 2024 09:36:50 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>, lkp@intel.com,
 linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Cc: Paul Cercueil <paul@crapouillou.net>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, oe-kbuild-all@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Julia Lawall <julia.lawall@inria.fr>,
 Randy Dunlap <rdunlap@infradead.org>
References: <202406191014.9JAzwRV6-lkp@intel.com>
 <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de> <ZnRUSaHJhz7XLcKa@matsya>
 <20240620170522.GU3029315@google.com> <ZnUnFeum1Z2ahm9M@matsya>
 <b7283f9458047e63e7d8c8b80daf2bd6232403cb.camel@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b7283f9458047e63e7d8c8b80daf2bd6232403cb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:y18xF/BSqPqf/Tvd80huZy/wZJ1h5Bc08s683x3NvrVq90rJY2g
 25FNVxt5WmLgQyxXayqeKD/5LGzA/+8QcKwodwT4SOZUxob0FicEpj32OD5nnQATMlHF7FZ
 COw3DPoewg004G3y9I3vMoWlbfjf7WjlmxyTCmHTQm/8yD/YrFh2anIMla8LWrYKtUCfEJp
 ICM1Mgm/f0NtpI8PJ0CLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q5fLA1zrxUw=;NcAHeCyo5KoUp+4fE1PnEQWXWpX
 2kfcz3PSiFtu6vhNZ2OBrBO/YlSU3NOLKykDf+vQ4Zqj1gWZbMn61Pmyvo4PFtlNZ1mV0eBX9
 aQxRuVeWOBx7bN1xtNagodWVyhK6IjiRJ8vp3JiK3tyOFYdCTClAsrOYG62zUHrzuA92PGGUJ
 ocLt7G8Na2nyOCEMC6evezplg1YSmPGqYDCeh+Vgn2g+ozqOhT+A/lokF4T5DVIes+FazphRY
 6l/7KpWeuN9dkgOcAORi6nWQzYF6+AnnHyE8PG3vplXyYVO1WtZzemF1m+3NZUEMN8zj7j+Aa
 fk54ic78Uq/CQvYs93ecIXTabrevSYrfXNdD1+gABU+hoxpMSaGX2ZqO71aB3NRIc4wEdHqHq
 9Jrth9NBLxmKQcjWOkL3QqaROfeTSgJR4yypWq5gpJHbLCXO19avPKx6RyyVYZzgzcUKsfc4m
 9SvNo6L7ZiJgSKiEOLmaoGI0j2wnUaggx5ldIZOHv4OZvPrkFkHZ8fCp35FRSsHhrKuD0zStQ
 86LcIVn6t50aT7XzB0+xcyN2CGt32ogN/P3P70XReydn2dAEDEA3uI0MSssFQDmQV0XlWIpB+
 yAZ+//jQP+TBDlxM9RUVNNDlyQgC5E+7Ze+SjOuea7dxfQaqJYfadzTI2IdNbuWZRDf0H40bM
 yd3QWHHDfz+hxkpc5QbxW9ditnRXeKzdmwFk+ozM+/ljhAjcj+uFFeGABHRrWp4/PG1coH/kv
 Cm50FC29cFGcDUdZnfYMqG2/PgjRYHlk5ocV7FuOf2Z/ndla6Z0K811VQCeIMzYPhd7uWdd3P
 2mXNlFkGiNy4pvukMscNkEuZKnLa2Rvn6navq7svFGnP4=

> Yeah, just look at how many automatic replies he get's from Greg pretty much
> saying to ignore his comments.

Does your feedback just indicate recurring communication difficulties?

Regards,
Markus

