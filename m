Return-Path: <dmaengine+bounces-2420-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96690E913
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 13:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D97C285CE3
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 11:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3169136E2C;
	Wed, 19 Jun 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dpUXKt3m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057B82495;
	Wed, 19 Jun 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795655; cv=none; b=KksGcdkjEeJXJQl5DlBRhCK9EjK3ShDdUzFnNz3YObS2mlREXziPjXyZHISoBWRY54JnbN+MqJVtw9TomwmpvXM35Ekdp7epngG2EJp4kuEPGHreRx2Aivmi6xU1GVJgidXJig1rRA2bRcoQbk5KZhvdB8RrQ+sSECD6xbmwWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795655; c=relaxed/simple;
	bh=56hhAah9jpUbobn1aU+LL480WIbGq7jfI2bgypliKSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sk4KMXQi5Lci/jKhsg4Lwe5inkERfh3cf4jy0n93yZ82NxnkhXK8q12mnGpV1oTG+qyBTd2Q7CSv1pN9ETzq7g2wGMzuPAoNLD/4O4QFwEoV4STapgrIhazHt0LP8MwXC+YsMhqZDLPgTYboeC/nGdpJgIM+ywvEsuyjRr2gVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dpUXKt3m; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718795600; x=1719400400; i=markus.elfring@web.de;
	bh=+GJ4EPRJrZyXsSYZfgGXrWRdJ3H2I2n5rKOI7dx6TAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dpUXKt3m/hA4aYeCv+70hUIz5sN9qBv35AKQayaQVp0dVlR20gcMQ4Asdy8srFjX
	 tZAA8VFmwKevYiwHZcJxd76Lxee5sWtyebmLXbssP3nzc1Gl/nzeuEeoUAEN0GxqH
	 v5ENYulzbGS+RLQqTsDnJhQS2p0k3+R18YEV4d8qvZ3yxViLr2XKY7FCmztniepQL
	 ukeDPAmYLQjVfbj9eC1g4ahjlEVFHNKQgwWuQwKLFSZEa45Ou1AtiFY/w+GLZEVDC
	 /UP7AWspXktenjcm5ey07ljE/EUA2XBVhkLSQhAZ5nv4m0W/UemKzNAeUCwDs73PF
	 XPehLlr5RbLxvskbSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBS6v-1sE4ND0du3-001nEm; Wed, 19
 Jun 2024 13:13:20 +0200
Message-ID: <cbcfb64a-e5c2-41a7-8847-227d4f6872de@web.de>
Date: Wed, 19 Jun 2024 13:13:18 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
To: Paul Cercueil <paul@crapouillou.net>, lkp@intel.com,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>
References: <202406191014.9JAzwRV6-lkp@intel.com>
 <a4dd1d73-5af3-4d3d-8c0f-92dc439fa119@web.de>
 <d452ecc4fc703a1f98aa4f243c6ded7fbfe54b0e.camel@crapouillou.net>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d452ecc4fc703a1f98aa4f243c6ded7fbfe54b0e.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j65GkA4z0o/GQa3FM8rLZHwliaL/R5TTgtLqANoQhITNATaLxaf
 icKHg6Fht/lkq7n+TPXoZOxIhb+c8tJhmk0+aZDjyw1w6xHYhXjTs3RguuXnqw71h5/1Vl0
 vKvqSGrdU4k08lV/QmYCBAVblMYdAkuy9Oaxxl6Xwn60M6BE/Ma/3apSX3Znnte0AnVIxtP
 plQIINIyu0g7mIopgizxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:96DLcfU53Gk=;D8DZ3/N2nOT1T52gZi40050LCWn
 mJusw7ZPboE2MZbbxfjUqPtkT82dz+0RhxJqpvuFc7oDZYSuyacnM3g78/k6Qfp4G+TRy6KGL
 ui4zW1sTc1Bl3cz9gATCc/rXNkZZ2SRfdKzr9cfgRuUmNkySUrMkcho67fmnwhQN+b34hjeAk
 LTPGjiOM8kqBjcxaHAaMer5Hvu0215Ge72Lf1gXGkv1QbKNqo381FxK+ZHodTLoBito/ziRrJ
 fd1BlFNr2LDkC8ZNB5bqzFSIkuhbyIw0bDoPZ0z0/85HM4HRvtfFD26BdK2BPli9cpZ8Oj8Lp
 rgjUrRiPMANRCJ2QZ4VSM79pTMEXdJF0py8a0BBxedTI8jAiINzo6ubn6ThHSY4+vt14RNE3D
 QzssM4NRp6vO9bkhsAYiatB16lHYGsEhODrDMlSSEVyEWSCY0Izj3dxHeqNUJfYzKXfLvNSHI
 LoCLuH5rLys8ZgRfMXo32bKLHJ4va7VfEU93ckaoUtK7OlZr3mJ6dt38iIbyRYroLnz3aHl1g
 DBFrM+v8Jb2yMdlMBEm5Co1KlrX4LAScr4VQPgiLct1I+EnLNkV++/UeeEiK57mWjr77oagkP
 mMY7Q/kbidLvM0CO56+RU762ElEGrtfVB9wcXTmTieB5bkrnzGQ1PmBDGp7JbYQZQ3q0kbrjc
 qd8uVdrLbrfU0a14w2YmOgecdSu9KeV2sf3Od2QZYAGN1cpL5erOWdMu7Ot0IKVHoxoYQ7l9i
 JqmZBtBWusQPw7ApI+5taUYK4zERzeENfH0h1v0+2jmqWgtDU1/MFfovcliAB9gTj6BqsC0mL
 GsSmMmO4HxfJcx6gA8iQW5ZAEonXSl9wZ531hLp+QuX6xOinNGR+w36SDsfVqRq2qw

>> Would you dare to transform the remaining goto chain into further appli=
cations
>> of scope-based resource management?
>
> We discussed this after v6 or v7, DRM/DMABUF maintainers were not keen
> on doing that *just yet*.

* Would you like to add any links for corresponding development discussion=
s?

* Will the desire grow for further collateral evolution according to
  affected software components?


Regards,
Markus

