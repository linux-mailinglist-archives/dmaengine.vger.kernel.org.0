Return-Path: <dmaengine+bounces-2414-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36F90E2EE
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 07:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FAE1F2167E
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 05:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4E57C9F;
	Wed, 19 Jun 2024 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+ujiu8f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585871E495;
	Wed, 19 Jun 2024 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776672; cv=none; b=ROFe/KctN1julPNc2C5PcuQaNaYP75ReeN5jCOTHpUQqbvxmwOtH1ItG9ql0hfWREMaeb0DldiEgoOaBrirsYv9Qfafqk0inaepq0GC5r+a3ivBKpQeVY/QL5VZIhp9DZVPhSDc5gudO3pgDcTFc1Ph5c4x+kqoHOVQpJSv6+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776672; c=relaxed/simple;
	bh=scEJE+FtrAipbWWuCOlW7sNdiWYp1YNxGU1Wofz9Sk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZscjgEWsjofrkBsZmnEqG1Dsij2J2fvT6NmGepWp/gaqQ1uiOdGwyDMKQFhETyGGLnL6yiTVcJtxG7AUJS3JpM76u9zRzmibSJdW93ffUyHjCPssYX5iHi2Rk6Or48losKKZL8Aswq1E0k2pFx57ptr3WeGOfLTJ8iJmUXuxNmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+ujiu8f; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so54867485e9.2;
        Tue, 18 Jun 2024 22:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718776669; x=1719381469; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=scEJE+FtrAipbWWuCOlW7sNdiWYp1YNxGU1Wofz9Sk0=;
        b=f+ujiu8fOOKznk2SHWixWkj3ahcz8Dlk/4DLLt0GiIRSHfz41r9i6CZ7OsvxEdvdC5
         /I8iLtiO9efgqrIZTP5IpgPZFl/GijyTHyZFZI0dnJnNx3kYoPk9634NhDjQbibxoWHs
         y1vlisjbffCeir1+gz6tguajuIbgrS09iyeo34dFTDaK+T4YdME3C7wTlkirMCHJHN9b
         gELBOotfoyQp0L3RO50e3Nlc2Hfo+GSRVqbg9fdbly4tgHWeujJedb7t97jGq8qkUq7R
         WRd1QzaMvO2bAAddj6SXldYnmd7B7qIxPt59i+N5ffrRIKydaJk9Wp7xlqfeD/D2LH3c
         hQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718776669; x=1719381469;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scEJE+FtrAipbWWuCOlW7sNdiWYp1YNxGU1Wofz9Sk0=;
        b=F1rQ0ap4fUoXnmU1urJLQWAo4L4E5Pd3PzKSSQMuRwISsGotCTbpgbJP52Hgc2J6Em
         NcHH2ZIQwRNQM3hSaIkNleSuKXAdZ4Q/D5V6dYaSqJC/OjSl7cnC6s7VZdb0AwZ9hAy+
         eoACQJE//D/7BkjMoWv76wXl7b8ELWtJHFgVKxQBM7327VI20nVc7w+i7ZlacojtvMUl
         WSizW5j3wbkEwWZFMPbm9GqfrQqlUXMy0rnxVg/kCKzBlPiOZygngOSfhOeH9ZHQ0dzW
         /x0O8gOY0RdyXIuavrOIZzxoyGrq5yaWA7mQo9HYq0Mv36BI9vosqx1Kh7fQwD5yPgCF
         JIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSl199T5IJTscJhDohdDn1wdhuiDzgB2cUjacLfdObuT0SkHfwInjO9X3eXSvVO1B0+YTDlnukPrxuq4lgSI9DH5OZ+YBoUZ5h0Sct8MiHMUtb07hxncI/+YZpZmHg4rJL+ABo0EbaV39OIAQA0BqhyUc8yjRqE2GU312SqRK0kmqyP/+EL7OeA57KKi+WIOOjgtbbYqAMBgn6P1SA6Bk4x28kKJxRQ75TnSCZUD33JqBABXwPeOfgIWs=
X-Gm-Message-State: AOJu0Yxs45Oz5AaH31dHpBCH/9sYY8XHZp/vBZaaAt/sPrUAg+T4fsfz
	mq8jHssTxUasLfjQBar81T9V2WqlhPRd1bMLnxWhn9J4bRwMrRlyYtLZobpj334IUg==
X-Google-Smtp-Source: AGHT+IGUWmG2ozlLnkr7/lTelYMt1DNSd/pixvzBkdl27mVAYbqX6fLVIuUMu0W+3eqBG/aY2Mqy9w==
X-Received: by 2002:a05:600c:1c98:b0:423:791:f446 with SMTP id 5b1f17b1804b1-4247507a087mr9346335e9.7.1718776668365;
        Tue, 18 Jun 2024 22:57:48 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de68asm254670625e9.29.2024.06.18.22.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:57:48 -0700 (PDT)
Message-ID: <7b20ed6c17fc7e7a023eb2d305ee699a81a2a2ce.camel@gmail.com>
Subject: Re: [PATCH v11 3/7] iio: core: Add new DMABUF interface
 infrastructure
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: kernel test robot <lkp@intel.com>, Paul Cercueil <paul@crapouillou.net>,
  Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Vinod Koul <vkoul@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
Date: Wed, 19 Jun 2024 07:57:47 +0200
In-Reply-To: <202406191014.9JAzwRV6-lkp@intel.com>
References: <20240618100302.72886-4-paul@crapouillou.net>
	 <202406191014.9JAzwRV6-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 11:15 +0800, kernel test robot wrote:
> Hi Paul,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on vkoul-dmaengine/next linus/master v6.10-rc4 nex=
t-
> 20240618]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/dmaengine-Ad=
d-API-function-dmaengine_prep_peripheral_dma_vec/20240618-180602
> base:=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/jic23/i=
io.git=C2=A0togreg
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20240618100302.72886-4-paul%40crapouillou.net
> patch subject: [PATCH v11 3/7] iio: core: Add new DMABUF interface infras=
tructure
> config: x86_64-randconfig-161-20240619
> (https://download.01.org/0day-ci/archive/20240619/202406191014.9JAzwRV6-l=
kp@intel.c
> om/config)
> compiler: clang version 18.1.5
> (https://github.com/llvm/llvm-project=C2=A0617a15a9eac96088ae5e9134248d82=
36e34b91b1)
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20240619/202406191014.9JAzwRV6-l=
kp@intel.c
> om/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202406191014.9JAzwRV6-lkp@intel.c=
om/
>=20
> All errors (new ones prefixed by >>):
>=20
> > > drivers/iio/industrialio-buffer.c:1715:3: error: cannot jump from thi=
s goto
> > > statement to its label
> =C2=A0=C2=A0=C2=A0 1715 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_dmabuf_unmap_atta=
chment;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^
> =C2=A0=C2=A0 drivers/iio/industrialio-buffer.c:1720:2: note: jump bypasse=
s initialization of

I guess the compiler produces code that will run the cleanup function on an
uninitialized variable. I would then go back to plain mutex() instead of mo=
ving
guard() to a place where it does not make sense only to shut up the warning=
s.

- Nuno S=C3=A1



