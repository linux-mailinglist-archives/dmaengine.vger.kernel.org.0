Return-Path: <dmaengine+bounces-2429-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2405190EE85
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE381F21923
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6D147C89;
	Wed, 19 Jun 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZcRSyda3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214114601E;
	Wed, 19 Jun 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803759; cv=none; b=WhmEN4ljzDxhbLOltjNwGCAr+BUkIwi4Z7tQVwx5Azzj3li57BIzDWJK/HZtlKm86u96uH/IQ2J/cPJlPRxqd8LDbRvEpXUWxw/ivAg6BSonIQKPct7m5lZxEgn7eUS40SdjCjg6MyRm32F3o8iLsPK1nurdPBQrUqrm2g/tvpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803759; c=relaxed/simple;
	bh=dmUopKpgxEYeprNgTnMdC5f05WlDYqe8aQuoCu7zLfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLIQrx3Thd6MAqLCFMkxU4QJy1rwxcO4rT2R8o3AGByeYa4TKNjU3Msk8+oncb1GF7aOxOd/kV6xQDHi+TCQpEsGF6vlMefaBLFc5L+PWaWi36M0DpHLvAvTsnZnzjVrrQZ5k8JglELpG2/vBBc/SlKOES0WB1J1g90O7ySPPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZcRSyda3; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718803725; x=1719408525; i=markus.elfring@web.de;
	bh=Cqv24v/8lPgdG+NBHkh3HOkG7c3WtsIJpUILM4XYcKM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZcRSyda3HljeeSrPJsg9pt/SRxpkFHlcTRi7289KIbREzjXnwYJjEL1b4ikYNyW0
	 cwW2t0z/i+PgBzGJZiJi0DglhseueROUNz0HG4pwc3qldtuJ5jRI7MgUspvcwEA3Q
	 MEaj14Balwr38BcHKbT0+yUpLht6u+kQ+r4IDeFaZXNtOO0AQXYYbfNxM1qdX061D
	 1CZw7uJVV1rqnUvKEzkbkzyPiVj9foILjLYAyrYxm1dD0qgfhIop+nwagQxHXKbps
	 T51aMnsKpdNl7/gt5I2+nGV4TaZbgsg3SrNmjqkGylvMem0EgtWxIruVS6lNFpi8U
	 4NS5T70OYGbFOvl1NQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUl9H-1rtlXw0E0f-00K0rd; Wed, 19
 Jun 2024 15:28:45 +0200
Message-ID: <d8d4cca1-031f-4ea7-89da-573e0863c3ec@web.de>
Date: Wed, 19 Jun 2024 15:28:43 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/7] iio: core: Add new DMABUF interface
 infrastructure
To: Paul Cercueil <paul@crapouillou.net>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
References: <20240618100302.72886-4-paul@crapouillou.net>
 <fc3045c5-d542-4a6c-906d-84f72e776e9c@web.de>
 <8d536bb864c145340a15f496ad3b89e08a847718.camel@crapouillou.net>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8d536bb864c145340a15f496ad3b89e08a847718.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MrJKaxOVCei/mZBzi2PVNabKJ6tVMvGyFZ5xYhMj5+zLLOoWPW9
 RP1yEleiWkMbS2BUGrEkH6qWN74vGTCeozUL9FB2tABigS/1SKC/gRb6PjhqDjkxi8TvibN
 DirViL6WNMQC8mFjztRZzggJYPP4XdQPTe30mSzWbulcYWwh8hlHd6aXs+ESjHDzKU9+Y0k
 FHer/BM6ZfIttjr8bzCaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l/XCafQtm8M=;bwyV0boUcJejmr0awi4VkGYb3GT
 8KvUhYW4dlBpvKPcQb+UN/Q6hCIjR0DKLLpUkvsRqwzuV/on4SZSWw+QLa+duVi1FfiJlqb4C
 4Baj1bsgCB6QeLRkJHaYQPVlgPWz+mC9yWM3C1TR10W3ERu+mGsut1HSrqDA+zVsmR+nMgaWB
 4nmIhoyOe1U2LhuNyCgfpx0Q5q6DF9SPHNghAdilUKEQXIE7kfG3QlBNcBOZNuGo5hxDArrBq
 wRPnl2z2PbR47TkcBmRlcdomU92Z2m26JLjSPGFyUniY2OhmqMwvCbI1e+9GtlIal/IP/HbHV
 LasZf5HRKoj7imJCZzUoiUsVIsA9RE6g2LZE3ouH8fPLRKUYFbW2raRX+HXia/M0HfNJxbyk8
 +wgDRNi1Fx6i2L97JYOtjcRybz8qDuCv7X+im9g5L635DLibimhTJlvF9dfFVF/PTmkPbptkO
 yAwbbKSw9Z/IfYCZ6d7+lh2vLZt5VLbngU1JZJ/Pz+qj6o8xaCthpCzf6FilfNut0xIxKNYY6
 9IqKEL5scAjXRhIDv5ieh2WZNLMFvT5iIi37u3lXrnp1N995MVRm5rBraB4wQU/CqLh7HeOQL
 mQ+HezzE1Qcv6bfS44m7WB7ZkXiefpwrcEpcieQI54mwmNl4+wUlhCWa7+WVnM9AbGUTad4c8
 4Uymo0kUl6sV4dIsl4YxsR1+5XDMEFvyOk4fxvHjKUarsn1dkXHKmqy90J/ujrKCnfI/6DsVk
 WgZBx38VO5Exv1Urg8H4ZBlAYDVCJA1aWy4kKNi2t1+wRAxKNCU3EE//+oEbjR4qmFP3MLGtN
 SoQmH7zNnqvoZRGShO1xA+cixFbbN9Nst1Yo9Qg2EQWSbULpnDszsWJ1lusLMDb2Dz

>> =E2=80=A6
>>> +++ b/drivers/iio/industrialio-buffer.c
>> =E2=80=A6
>>> +static void iio_buffer_dmabuf_release(struct kref *ref)
>>> +{
>> =E2=80=A6
>>> +	dma_resv_lock(dmabuf->resv, NULL);
>>> +	dma_buf_unmap_attachment(attach, priv->sgt, priv->dir);
>>> +	dma_resv_unlock(dmabuf->resv);
>> =E2=80=A6
>>
>> Under which circumstances will another lock guard become applicable?
>> https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup=
.h#L179
>
> As soon as "struct dma_resv" gets a DEFINE_GUARD().

Would any contributor like to add a macro call accordingly?

Regards,
Markus

