Return-Path: <dmaengine+bounces-2488-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81403911C94
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 09:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B0C1C22286
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2024 07:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E128416A957;
	Fri, 21 Jun 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK5N6Zlg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49212D742;
	Fri, 21 Jun 2024 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954076; cv=none; b=nOC/1a3Fp2e+0cbkFJZqNftWDSN52f6ZUwrb4kKFS4Sz6wt2uRCCtMGPRR3OCh/rw/bD+FITESL7My7t+T/MkMWD6fFgBC71jPjx0IGUrP732V84DN+nxjUVXtMqO/knZH7ftGZa9BqCLJe8WnCn0i55l0Gv43YykujxhXSfS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954076; c=relaxed/simple;
	bh=I1d26+FYwmfD9Tc9dF0H8tsiQttz7MrvNQjmOX9mk7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMM0GFO/UdNzOwr5ZMfzZV9DUdI+fEexb+mMdSXHQelcBKsbVv8lYwlUyCcbXCcXxyRpsU8k+wzXmXvdr/0l61jVgJfLIg193Azc8nEt9w4HA+AZ8TejAoMLYdPBSCR0DX7Zu1/IR/0YgtJ9/45mrL585pxBssQu1kkEfWH01Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK5N6Zlg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso1968988a12.0;
        Fri, 21 Jun 2024 00:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718954073; x=1719558873; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I1d26+FYwmfD9Tc9dF0H8tsiQttz7MrvNQjmOX9mk7s=;
        b=OK5N6ZlgNpyFNOORJZRwBMCpsCNLwvI18yVWo52fpDE0suypmbKCTy3ncALVmKk0zw
         RwhysRvZlwmHUP7Jw2HiA/LpVzATOMz+2aAx0s3CmJC49vxRww0H3xlfCOzfX9w3H4lO
         /vR9gCJ2JlAhhJuDWxjJP9X8uPnL/nNe9czTF/UqWdeoXqSEs9KRCvKCokbnLrjIrpYd
         k1uuNjzaw040m5gV5AxSwmKwBFKYf6bM/ysIit95xnydsio4ub3DxrVi6Zjq9EMSjTMq
         LnIFE3DsCJYOGSJAjPQ15zRtz7kgiVOqlRxi+FVMAgJC4BxSOLFO2U4QePftEF1Srlhk
         /bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718954073; x=1719558873;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1d26+FYwmfD9Tc9dF0H8tsiQttz7MrvNQjmOX9mk7s=;
        b=iThCWaHMLvTOoqe1UhJk+gSZf3CytwTdLvGnKSHUeV9S3dHEUoWChew1VJLsl4Z2It
         ZfV/Dz9WkPfV7SxRU68p0JnWU8H4ox4pTMuWLA7t6QXqN2D2QxDB2OV0Merz2ylXMa7F
         XMunmQ5kLJNuWuAehQf5DkurABDdPId0xwkelIykbgu+TEulZZDv+ZsAefdoOmTExhhe
         kiQRtI9RaYDvrpddVFCrSVcfsSB6uHn0LQW5FtxFYe7aoskAwNcTfeW9Of1UBsiFm6e9
         UkBlx5YIV+d7rFKsA94VOHBWnhmMzghBGatTxJf8Kf7GaNf6IkF2tCdXXgPEzrnZywxb
         55Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWHjnbniz7LbmcF9XRO+G4G5bj9g+ucKsw7wf0B2Ouzwo6zAiOrW4jsJk2M8cDNQySCGyNl0EqoniMK3b7XuJ5GLiG7zvM1TUIHIDfGME4GU/WuWLrnXyywOstMykyPUJdVn+0PwNa7SVg3bArW4gNPe1qhKReAVi7Lb9kFsr+D6ujju81zlc05TeaVgS+vyeyWVbhaxgOukZqmcF8aaFW6D3PT3raGyzzfeEGvh+fu3RZc7IM02lvMIkc=
X-Gm-Message-State: AOJu0YwuchHEaJeiGExuTvtgHofCVXTeAecZM58QtgV7eIkeqHw51tvA
	C3imSTGbp9DKMo30qxgIGTBB5++L49Im9L7zGkHbnz1w+wjwl2Hr
X-Google-Smtp-Source: AGHT+IHJQ1yPK263/uUvL42ye22QYzUxYEagwPu/zDgRslXQjOwm4KteKF6Tb6SaGoGeiBRNCTcVaA==
X-Received: by 2002:a50:c050:0:b0:57d:22ef:d055 with SMTP id 4fb4d7f45d1cf-57d22efd0e0mr2481140a12.24.1718954073269;
        Fri, 21 Jun 2024 00:14:33 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d305351dbsm527719a12.77.2024.06.21.00.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 00:14:32 -0700 (PDT)
Message-ID: <b7283f9458047e63e7d8c8b80daf2bd6232403cb.camel@gmail.com>
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com, Paul Cercueil
 <paul@crapouillou.net>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 linux-iio@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 oe-kbuild-all@lists.linux.dev,  LKML <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Julia Lawall
 <julia.lawall@inria.fr>, Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 21 Jun 2024 09:18:23 +0200
In-Reply-To: <ZnUnFeum1Z2ahm9M@matsya>
References: <202406191014.9JAzwRV6-lkp@intel.com>
	 <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de> <ZnRUSaHJhz7XLcKa@matsya>
	 <20240620170522.GU3029315@google.com> <ZnUnFeum1Z2ahm9M@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 12:39 +0530, Vinod Koul wrote:
> On 20-06-24, 18:05, Lee Jones wrote:
> > On Thu, 20 Jun 2024, Vinod Koul wrote:
> >=20
> > > On 20-06-24, 12:45, Markus Elfring wrote:
> > > > =E2=80=A6
> > > > > All errors (new ones prefixed by >>):
> > > > >=20
> > > > > > > drivers/iio/industrialio-buffer.c:1715:3: error: cannot jump =
from
> > > > > > > this goto statement to its label
> > > > > =C2=A0=C2=A0=C2=A0 1715 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_dmabuf_u=
nmap_attachment;
> > > > =E2=80=A6
> > > >=20
> > > > Which software design options would you like to try out next
> > > > so that such a questionable compilation error message will be avoid=
ed
> > > > finally?
> > >=20
> > > The one where all emails from Markus go to dev/null
> >=20
> > Play nice please.
>=20
> Would love to... but Markus has been repeat offender
>=20
> Sadly, I am yet to see a constructive approach or even better a helpful
> patch which improve something, rather than vague suggestions on the list
>=20

Yeah, just look at how many automatic replies he get's from Greg pretty muc=
h
saying to ignore his comments.

- Nuno S=C3=A1

