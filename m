Return-Path: <dmaengine+bounces-2378-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEBA90A62D
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 08:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF84D1F211DB
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 06:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C027E1862BB;
	Mon, 17 Jun 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GCj5plbZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382819BC6;
	Mon, 17 Jun 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607474; cv=none; b=InUUqv6VPwpyd+r9KVmTI8ZCfw7MBbHv4DJAqtgDiOQfrDNq+1MbdrpgDzOezyktoiRyXxVM+wYR1InQgpbkXkOym3o4D1OboNgLDTsBZXgqLYHv9uIrRkBU583wjg8uH2ow2C/9ehXTdULsfxadzIETNNZ/weXt6RZ9GxiWK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607474; c=relaxed/simple;
	bh=cswSiNhzuIX+L0XOTRE4WAI/IsUzciePZm+xz0kFYY4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YeGZGS+vkjPko2CFrut0QqIqRETrO1I2XT6zpCvHz2CqKBx4hfeiJIU2onzN0ppipe5GJ8GE1J5G8j+ty/ANQl+mDh2f4wRLLv4oO0opA5/5fd4KoUwiqxKRyrHfDxcedPBYsfTwMc8IVoPvv01qZXWo9SauzRWSGPkM6d+UWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GCj5plbZ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718607423; x=1719212223; i=markus.elfring@web.de;
	bh=xYrgvg9WCy9r9u5H7qn2mdlOD8NoWnHTZFUH9pAD1xQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GCj5plbZrqt60p1OqOM56a4JCCTVsMe2MCHDuSnFcWd8H3SKEjRtvgUhpHPlFxr0
	 AfNvgrBsAVU5VugDCyQjEqz/GpSYKBrvvNYHzyjM8/XCVMK60t6ckdPrCVZEx4SiP
	 hID6uSohRtcOm6Iq4vpjEAWDBU7x4Jdr+X0AUchPul/0qrQy3o3ow1lhfeewTJHw1
	 rdHz6GzEZexLUUEiQVYIqbaJqH+27pgbYSUCtFdX6jlPtdc2h1sUL1znF+GVfwCa4
	 I8wvZiQLbnL/b3xoFHxRHDuPApPDbYO3891wggaB+v0sy78zV1jbgSSlrTfqgxXHq
	 oVH5Nnt339gSg7nUoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUS0-1sBxPZ0DKk-000iy7; Mon, 17
 Jun 2024 08:57:03 +0200
Message-ID: <6a41fd88-5496-462a-86d2-446c2990fcf7@web.de>
Date: Mon, 17 Jun 2024 08:56:50 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paul Cercueil <paul@crapouillou.net>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
References: <20240605110845.86740-4-paul@crapouillou.net>
Subject: Re: [PATCH v10 3/6] iio: core: Add new DMABUF interface
 infrastructure
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240605110845.86740-4-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mUazHyeVCXYVnz6oK+LWMeQZXEK3hfSQQEB660iCeLwFYnqkjQ+
 Ud585WwQdmOnvKsazfb+JBL625SKwogz20mU04M7cTelcw3J6jvrcay8aCvzIgt5Zo/u0tG
 HA8BNYiVjjRu1Y+4OsPoPx6KQH/SZ/sPPYoYD8KqvEsuerJYNwyB4WIq2T3jsfm4PgHe3GT
 6DwW9Rzy0tHqw4LOWDrPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EpUgWLDuQOE=;TpqYd2BsYAhSrklupWm0bdGxi0w
 k0gP4myeMywXz7z2416cAKfPZc+sozlXCm/dg03s156BdOSpNvAWLhscEVizpeQGJ02tGKcs+
 gPpHtLG9/4DSygIbsZCwwGVPv2tYnhthrp5KD5bNINXFLg8ymCfDhgNDu1QiKmG0LiXN/kYTC
 tyZia5fF2hlrZlk+Mp8kxXJgv9UgtBL/FmNNSPm6N7jOTR4Zcdgt0cJXiJEJ5aNLFfHYF1TED
 sqA3TpJuSMnBqp6+Y27A4GFBqiMckBrfdUi+aB1w9Jo9aVv0/5sHHtuWD7Mufed2c3xZm8bFi
 6P/eXkYxEGfvYjuTun684PUf8EPFV0MxlSafXkax97B0gf7RMsDhoZ/57lr/LEPbYd5/MMGpo
 2FZcmWJJfumMFT/IEiEfiR4teoq7q4oHTPBre96PjFDkipfK0DXEysOlrBb+tFcfYbjIwlF3T
 6Y3XM6LdKz4qEO97XcWy/wPj8GbkMKxKFI1QJs0PRE79Kk587L8rJgWiHZKCZ80uvRyCzXJCI
 /t6zPRNRF6ePoZIKc/44UiTxO/fQ1zMmlaRzVy56MQ8x2G3ANq75aaCd9qVNk4v0wRaTB5Lu0
 uA43DJQ1ptxtQhryfZiI0B3NSnmo4fO95dmi7e1GlRXJk1Udd4JIcfjaeXw6fLTmobKBJAeQe
 s3a1aiZESl6a5AD2Kc1QybZRvr4ec/TYMtpTSxix+F+QAvs4PwefO+Ljy+3Y6lEH5cgLdmGuZ
 6xuPuGo9iZgV77V+kDtZMkQ+soB22ssbAGAuVuIsUgYD7b72EPWZkPvIfjmmh3OCCEewBvW+R
 CzKOponlPubLU84J17FFUB0n3ggAX9n0xY2QTca53XWm4=

=E2=80=A6
> +++ b/drivers/iio/industrialio-buffer.c
=E2=80=A6
>  static int iio_buffer_chrdev_release(struct inode *inode, struct file *=
filep)
>  {
=E2=80=A6
>  	wake_up(&buffer->pollq);
>
> +	mutex_lock(&buffer->dmabufs_mutex);
> +
> +	/* Close all attached DMABUFs */
=E2=80=A6
> +	mutex_unlock(&buffer->dmabufs_mutex);
> +
>  	kfree(ib);
=E2=80=A6

Would you become interested to apply a statement like =E2=80=9Cguard(mutex=
)(&buffer->dmabufs_mutex);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/mutex.h#L1=
96

Regards,
Markus

