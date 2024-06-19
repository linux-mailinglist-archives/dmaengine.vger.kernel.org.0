Return-Path: <dmaengine+bounces-2423-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB7790EA32
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 13:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650AA1F22E9A
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727A13E022;
	Wed, 19 Jun 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hDMCyS9P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59B13D242;
	Wed, 19 Jun 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798250; cv=none; b=WEipVHyt2fI8rkdfHHeJEGveWcj+MWpaSz9dsCf8BzzkLKMtnV5vN7IBB8x7dNO1oyrLf1snAhR2NlchbgpEtn3CB/8TMvFgjWE5/laRayqteBFRzslWy5Zksz7wbsOein/VT+6pvnYHP4n988svsINofljtA5oqWU9K13Prd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798250; c=relaxed/simple;
	bh=XT72b7itPnzm1V+2+Xgf1kA9L0kMIcyaM91Blh2TMYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSnslf6MWdZNmKeiEEqf/sxSm/lkXRdFbmKEndK8Kw9jVHi3y7ReSB3GgeJbQzVhxnb0ftuj3AQ4Ak2r67O5yntLBJQkRmMoZ9b5+2UyRdygG+M7fEydo3ihFGDGLV+lHWy4qc5A+1TUN4j9h4JIdZEb1KyA1VEvnxQV5DuJAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hDMCyS9P; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718798204; x=1719403004; i=markus.elfring@web.de;
	bh=XT72b7itPnzm1V+2+Xgf1kA9L0kMIcyaM91Blh2TMYE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hDMCyS9PZcFIrqVgq01L8paMukJhaLbCZcezdnHssdReyhafT702yO/Y4f9OzL18
	 1kxe/Wt2yCzYwSqIoPRHh0etdDBcuF9HsWSaNKxX59+MMLh05rTDJbaRBnbgdnCjQ
	 uEKugkgEa8nQ59I/3ZnTGJeuKOqhLUOBaptl3c8+lR1C6Yz1zF1YBo2bKBD8x4OJR
	 ob9JN10T2hRaSXpCVc+HMGpFRyR+MPpdilnGvPWTZ8REaSzrJ291VwcG7i7tq/2tX
	 fGG7cFKFD0wFlgr5iPWSuP32+Wwv8WuO4i60LJ0B3mYUupO5LOqW1e+oGroqO193R
	 D7773Gt2hnEg7ad/oA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1smwsM2Wsg-00b84i; Wed, 19
 Jun 2024 13:56:44 +0200
Message-ID: <41fa9904-28a8-46fa-bf2a-014875409b83@web.de>
Date: Wed, 19 Jun 2024 13:56:42 +0200
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
 <cbcfb64a-e5c2-41a7-8847-227d4f6872de@web.de>
 <e948cd137da8e4f97bfbf7ef68a5450476aeee0c.camel@crapouillou.net>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e948cd137da8e4f97bfbf7ef68a5450476aeee0c.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JznLXOOrjHHjdQ/DvgHNKMl+mHWbtfwr9nCttlec4A/5RKvIavt
 4n+CE8KRkg6ci+QqCtvyC6RYUk6aA6oxPkC51HrYbG2i41cMc//MGMP93+LzHxzocW10T6R
 +q1l/LN6bOPS4GMjyPPdFTpiCGel16Vcc7CBoHmM1GJxdWloElqFWhG5diwkrkSKHv8N3zV
 nOLsUHkwsQ9Yvs577/4Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yBz4OltUnbo=;2fpQBJSqjGM3IDnFAq+/OFA4RM2
 J9CSQLZFJGJBDaOD5fJv7Avj6U8Spt/xBDJi83VrQdfXzlW7DSFQeSpYxEqfvw/XAb+1hDiUl
 hlogL2PmlaL67u8rLXsumRtBqAEbw0T2emQg54nyM9GEiGmASg93tktB7toBenwdSHfAaBTbh
 jsFDGrwz5CNCF8WwKm7h/MD63ksX0NABFwTxObOiCv7qjNSukCouQMafmFF902eHiK61mG9dG
 WNGjzNnW/m/DXQEJiUkCKRoAP4Li+d/piFODeFuK2ZlFt1pnmKXmLDGa23AfdHS/NOG8Jf2d+
 IKEE2XgxjYjX5HmMkWRNNMqCR5rxaJE+eLIxmh9a3ENh/zO+70eiGqMf9hPZuSQImkShl5376
 ntEVQbhchDZE1+AHjaAVvDmiRC9a7LecXsbCdPBNWg29fVEt2QtD03Zh/TLgpSDUG8leMxLtC
 0IAl6q+YRkfMRhRn9qVngBVTS6HDqurQlZaEiCmOZU5eIS1Xf5uKeVZ4yQxjqgrwast2yN3zX
 a3Cd4DL1dZSNNmWJFtrInA92d92kERWL9IndYa66N3dtdWVEcBd6WxTDE0RfiP2NKOJKlhMHQ
 IWkdfXR1PZQ8e/pYMNPDBW/QqhvPCVdy/AJhh6cPXzB9pjFS8sBz0iDHYPN9TNMtoFafjmZsC
 hhcugnYorWHfU3fcPmZPpNchV56arlpeEKKTweaS+BqamnBf07A1kvXFmiuO7esD8HVI6urzx
 IOdoOGqe5ao9xlzwisIidNYIA1o7F4692zJsoUIYdgQP+8cd+n/cnrKstOkObFliuzuQ//nrJ
 QyA2XXTSee9Dy1EbWpi9if9GejQRO5Y4RTou9Ysp1wrqd3SfH/pzJD8c8rgCdtSP+7

=E2=80=A6
> https://lore.kernel.org/linux-iio/219abc43b4fdd4a13b307ed2efaa0e6869e68e=
3f.camel@gmail.com/T/#eefd360069c4261aec9621fafde30924706571c94
>
> (and responses below)
>
> It's more nuanced than I remembered.
=E2=80=A6


>> * Will the desire grow for further collateral evolution according to
>> =C2=A0 affected software components?
>
> Not sure what you mean by that.

Advanced programming interfaces were added a while ago.

Example:
https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup.h#=
L8

Corresponding attempts for increasing API usage need to adapt to remaining=
 change reluctance,
don't they?

Regards,
Markus

