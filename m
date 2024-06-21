Return-Path: <dmaengine+bounces-2489-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A58911CBB
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 09:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FACB21ACD
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EF4161937;
	Fri, 21 Jun 2024 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u27pTbDD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8B42AA9;
	Fri, 21 Jun 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954917; cv=none; b=Gmml4G/y6Y9jsTGrvQEtMp84RvEQ+6XXSCOxgYPSWTlzjZKlViWKuLlUf8hCtyeblsJF+vZJrckQXVYgTkmKbZqjNMVb1VO8uXpu+KX/RY/GPt14GOslSMM+yfITkvzvFbH9ddSvdq8SJx7WcA9wDmMfvcDWL9z9vXTDd+Y3msE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954917; c=relaxed/simple;
	bh=4Cqmd1Zslg6+GqTtuMMGzAPmoWX+sK/ndxWfnjmHO6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph1IZi2XHi9ZDEe+OGNQ29w8PiCXfjb6MMjYpvbYtB4bX1FSurhfMpKQH0K9DrqvRExUL3h+E3ezT0cjA5H2xJ2aHp9AcvjMrz+uT34vHrdiV8LdfwxJFRGi5r0M0//EQKCgnff39zT1d6Muc3796wdGJkIkfuXywcC22awvDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=u27pTbDD; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718954878; x=1719559678; i=markus.elfring@web.de;
	bh=4Cqmd1Zslg6+GqTtuMMGzAPmoWX+sK/ndxWfnjmHO6Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=u27pTbDDtzyAG3eRqbn4MfYCio5UxmRS4aWUXnXp8OTfH3guRHsFQ6Q9+qLjzxtz
	 M02tW3tzCfkxDp0M/6M35CuV71FjVcrKLPp669to2qQts1JRe4ankwxqXI9O1ty94
	 /7BbvpLDi1rMn3SU8rHx7vA0GoJXejIjCPgIMbrgnLqt7VjWSdu6JoJIWVs4pA0Iu
	 X0fuw+1PZhyxspK5NutBXp+K/sJF2YuTD/ed4KqY7vlsBwJoWIrMhBuDjSG1Bb40T
	 mKCx8CNzKo3dkw0ruSn7359Volkl6OizeA5/RNJmvaNFNvKG0Z/2r800+8XhyyQUU
	 P1guWgGc8BZz0Qmx2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJNT-1rtN170nRP-00KxkG; Fri, 21
 Jun 2024 09:27:58 +0200
Message-ID: <ebddd644-b9b1-4a87-a2e7-dcf255f4184d@web.de>
Date: Fri, 21 Jun 2024 09:27:53 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
To: Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>, lkp@intel.com,
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
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZnUnFeum1Z2ahm9M@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:J37COVk2XF7k8nqs/WJ4OC98gPL38IqMj6sP957DZk0HWuiah8F
 2tEs84osaFRb6N6fJcf1SbpSGA2KVPCX3MzmMU42+duV4bIxyA/2szcJY89TZZ1HWSRbqaX
 +QrjOc9FBuANWIRpwoNnoToVCdpRkv7sA6jpWGGRUXueujw1o5Z48O/iVJN1KagPGkFvRyE
 /+wIjw4xjBOXesASfg62A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5tNyWaEuA3A=;j/8jMQV9kiFVidscC+nHbxOQKKx
 dA4551YJWSBmZkuYtYQMZDbeUV6U05hNoK2MuHlZW2y746kCpwv1Zs99zzsdADn3ICAdU8WJ5
 ooLh9ZtCNusXGS8u/iSsHO/zqEzHWI0YlXR1mhfUwAi5JQ+QlWGakhh0PZ+M8EbiXlst3hmc2
 u7gJJ0n9Afqob4U37CkdXMKyqhHWhglsQO1ecrqy2lo5Wm1NAlOxzC+DU+h3Sul0MxD0BTfj2
 K4LuaRpr6RRkUXhSkcc+O/RSKMm1jIiJtE5bRR13l7c+3SNH2qs9JlsrUwJH+L4NAN4kg0g8a
 Kd+MfUSD5UuEgd5a6nihghQxfCotOWV/OEzablJ3WkcuRvlfqAvUDqHgDUOLqfH6Fe8qqLfR3
 g1vaJjDUebAVf0KT7Yfve0lK4DtUXdKCQzY+lXnVLjgdP3Z1exsNGvq6Q2Xdxvh4JgKXt0daj
 31a3L5BBZMqoZu9pzrAhvBuJlLvR96nQQtXAhB0zMmbWY+61OyqI/Ztke6YU8B6eaNmNHC/C0
 lMwEC6nYjLGsrJ7ApR9r2v5+pTJ+rOM+VoczMfxJSNP7eoEvfZdt8zMsFgMuwdX378rJZUhik
 0cq27R7iiu3o+BOCnbxUW/uEGpBnVA1iaKzO03kqPzgdOZF9lfDnEdnt9GU1Xlr/BEpm6zqsa
 5eTLOHWtnT/k2O73NLu/J1dFULXx3ua1LmJxnXa831tc3ry4Ie4ODQvjQhEDCDiK/fokUtPlZ
 JXMJBqVtRLyxYq2zrw28cFlgpdFhty1YbvLrHFXqU21jhCTIQ5gOtR0PGB3SdnIReic/Ylrv9
 WYZpL5W4AiKeLeVoRttIltCOqFONA+ljfoF6ZKkiONhYE=

> Sadly, I am yet to see a constructive approach or even better a helpful
> patch which improve something, rather than vague suggestions on the list

Can you get any more constructive impressions from another data representation?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=Elfring

Are you aware how many change suggestions (also from my selection) are still
in various waiting queues?

Regards,
Markus

