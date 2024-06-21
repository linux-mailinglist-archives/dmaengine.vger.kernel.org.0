Return-Path: <dmaengine+bounces-2493-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE22911E51
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 10:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F221282F5B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3372016DECA;
	Fri, 21 Jun 2024 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Q7o1YAFJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5A84A3B;
	Fri, 21 Jun 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957478; cv=none; b=E5PZJXymh7b+urVQv3ikkk7ZciP6LWPFy/d5prgcg8Id8JSI5NV8weNmYeh16mNjAcPisqKTmvCEqyR6qny0nEYuN+lenTynO1IvJzn6vAOBOYUHOu+CT8SIdGw5S0i37sWOadXzxzgZSXTWwwpY1KZC+L/+FjLONnIW/sXkuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957478; c=relaxed/simple;
	bh=tw9Hq07gA2b1Rquog4nhGifnXcTRzaS5xtVu7HsdB4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZ3SJyk/jv4lgA7eb3eZo4HAg63SIQn8MlI7z65g5VReWRoeSu70v+XjMkeX/AV1LYv1L+CsaJ9pJkQ+NmyLYgCGFh6DM1xtrkaaanAn60+EnEHorNypFZVufGPLZO/kgjA9ENNL91agVLNND5DkYEptN5rHumOg2A9n7lclq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Q7o1YAFJ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718957433; x=1719562233; i=markus.elfring@web.de;
	bh=tw9Hq07gA2b1Rquog4nhGifnXcTRzaS5xtVu7HsdB4A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q7o1YAFJNcGyxjEQn1AFW1H6JlsKS1YZxYyeUV3di1tL3d1IIQSN7SYr7X5QuVXM
	 1+F5Ezg3aJSRCEFVmtdNwUAXoVADWRKWqqxhy7r8w+RZrb7//u79RYiqzIsfTCNcZ
	 2/mAG8moFCw0BOCafcZOnMuquC/6rGwZUcU37eChyZQMg32Naxp3VEcBEKS7eaLIY
	 wbsFYQf4J93BMFSIcfFfXzn8N9DeDZk4z4kCvByOntN4IQZnY8XiKZCBbl4jZWpLA
	 J1KyHFrkuQWNlFa94f+RoA6dxunh92bO7T5fn2iFF55RLsf5D7xIsSYZE36I7aDNq
	 4LMmTvhdX9qLFA6C+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTLI-1sXxQv0YLo-017BdG; Fri, 21
 Jun 2024 10:10:33 +0200
Message-ID: <302ce128-a0ef-41b4-9808-210a83bc6a48@web.de>
Date: Fri, 21 Jun 2024 10:10:29 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Patch review challenges
To: Lee Jones <lee@kernel.org>, lkp@intel.com, linux-iio@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Sumit Semwal <sumit.semwal@linaro.org>, oe-kbuild-all@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Julia Lawall <julia.lawall@inria.fr>,
 Randy Dunlap <rdunlap@infradead.org>
References: <202406191014.9JAzwRV6-lkp@intel.com>
 <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de> <ZnRUSaHJhz7XLcKa@matsya>
 <20240620170522.GU3029315@google.com> <ZnUnFeum1Z2ahm9M@matsya>
 <ebddd644-b9b1-4a87-a2e7-dcf255f4184d@web.de>
 <20240621075123.GG1318296@google.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240621075123.GG1318296@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nVOg+KeLl2N2fq/s0Ntj00wEVMmsfslYtciYpHyTe1/l2inQk/m
 WhJy/k0th8SnjtkGT3mY/stpMLVVX5brl4hVD6aV6JfozNCx+Edw9BY4QKhB751Buia3WeY
 WnELOdc2qE2T/SLclfYbdLxkWppv47XuhajfIUhpsbTRjFIWSqkorXBLupOF6bLWoZLH/yK
 TEiDwPBXPJjDX82KuPAyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wqB3HsVqvPU=;8MOxyZOZkIMm6tGRBtxnuI4cxWM
 C2MH9F78tjLMgO6do7scFkqbR4KU6Jok6Ci5kNtCab5kNp2GKptQW07ctOCsAUccyCDBXjLeF
 gpDax1qUTepmbIEP4VjLz1LHGgYKvSC/jtZ0DCBKVS5Oexx0QvLjAwde48cXYcTObya/yEEH7
 eAkyrC55rXP5s+IDasphuWOpyT9isIS/Z0LFL4b+iQXpz/xEZjUqraiLqTZ8itaLXufVSt1hz
 V06L8WgXSerY5SZeXVjuNiEJdIIfcbFlFEih0VokjSRU3JjRc5VVfnsiE/H/X34RMwf3uuNvE
 J3BbQN7NnXbNa5TlO4Y1tyl6rCnEqxW5Etu8Cph7dPrQaez2J9m4n6YLZ/UOwk8rHsofdVxj5
 Ln2z9dJs83Qm5Co7um6reNtDHG103cnGOBoFacb+JpXYjxwvSPUg+NbsEFUqcVvMa3H0CMARJ
 sD99oPWaok/1HHSxxivsizHgiAn7wdlwREFe/O1UaLxv6CQnqSSnamsM821PzSgABOX6/5Iwh
 QCou1JsC/dKFXE7pj/BP6Ntf9Idn4u+A5dG9sYHZiZUO3CGGmlUTsy7pOeZqGsmOkRE7NoLaw
 /4nd2tmNSLnP5Cn//Bc26WwTGsVQtOPRzs/j3kfBtApe+yhSsKUvZ6QdJBE7A/N5lxyq7ExTQ
 ycRAjQUyFIwpeXpYbeNoDCLLMjVpPtcg8AZDxIx2FRYdviSUM6Wfzbz7nsIn8DFrKeR++mhBs
 GokAydPsde3/+knQ8w2J8nkUA2b72Hgy4EfUtL8Vs7nncRGMDivv4iwpK4erFGcM0zbhppa9f
 JMmNtgz/O8TPPKhKVXZb4hQWKwWCwg2cylRlwaysmztkg=

> The issue is one of communication and the way reviews are conducted.
>
> Reviewing other people's work is challenging and requires a certain
> skill-set, of which _excellent_ communication skills are non-negotiable.

Patch feedback and change tolerance can vary also according to involved co=
mmunities.


> Why not concentrate on more complex submissions for a while and grow
> your repertoire of common review points,

Further collateral evolution can be considered there depending on
corresponding development resources.


> rather than repeating the same few over and over?

Some factors are probably known also according to corresponding statistics=
.
Several contributors are stumbling on recurring improvement possibilities
in published information.


> Reading other, more experienced maintainer's reviews would also be a goo=
d use
> of your time.

I am trying to influence adjustments in desirable directions for a while.

Regards,
Markus

