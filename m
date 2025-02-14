Return-Path: <dmaengine+bounces-4466-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC5A3595B
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 09:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6385718911C5
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD17422836B;
	Fri, 14 Feb 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnrSKhOp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65287227E81;
	Fri, 14 Feb 2025 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523036; cv=none; b=ghdE4MBrZK/ui9dQGi5p0jpGttghNGic08OwKS7biaE3NQ+ZvrpDzGChVtOvtBCv0jwkTbt8+wNGDM6ytgT6IiV62Zpl8bkjaotTbkEqdyFboq89ta13lVN5ZbqLJa6cOZw36ZOL41lVzIFn7yRX+mLwOzfoojbmgsaB0x5X2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523036; c=relaxed/simple;
	bh=FIiFh48SRloeLYrhX70YWBVGVz+5pKIaMXokOTKVowQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKvWFJRdUfB9sREXAQr1WCdKaX/oiaIDtpkVhWwKxHTve8afqtSJ0L2d6ySzYcdEL49cUbA/zkvEOXGenVRawx6pMXRQ5uGwxkOgK2fu56LvmFwVdqe0keKOVMm6f20O4dHRgid0N6f/Jf0o/gh/ulRqJA3a8V3SlnotSf9EyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnrSKhOp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa8ada664fso2888584a91.3;
        Fri, 14 Feb 2025 00:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739523034; x=1740127834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIiFh48SRloeLYrhX70YWBVGVz+5pKIaMXokOTKVowQ=;
        b=GnrSKhOpXRnW9oVGxdNH5K+4oCCfFuoa8ckZzl2dk3rtgPg6q0DDrVMc3PuHN8Ar9n
         IVCtz6J8MY9xkm+lTD2d9HmbN3+c48Dnl2qGGvAj9wxjbFeeN2Vus8P4+YRt/bNCmMtN
         2EiOGrxZlXYT5DHQOoA9h//FJUbdVtCe0F4+zje3KPNdnibSHg7Kic0LvjJe+yriyTsb
         LVOMce3FRv1iL6gUf2rz1r3AdLj0tf0IltbeS+M0+tE8kXGT6Z09HyiG8naJ5zzlqKHT
         sCFRkQy02DO6uqefyFo63eZct+kV/okWjo5hLSSxkASuhVSg5HvkOYbXlrop5/k247rE
         B9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523034; x=1740127834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIiFh48SRloeLYrhX70YWBVGVz+5pKIaMXokOTKVowQ=;
        b=AjvBR6L0Yu1wRFAAflzbwgUoMxAmCx/54HU1UmJkQOUsc+TBqjhhtWsoB5/xuKzYWC
         He68lkUehgYli7IwC1tiJm/zq3pHY4SZRWJ3+fWQh5rKHAtR2n68LTzT60jrUtBXC4F6
         2N8qqoJ6pbs9i7HDEe11cAZitX4468Irrhtks1QN4kYNNP+woAb81J1jdjREwovG+jH+
         m7XdDa1r3sT6zx1Im1ygyoC6TNgvppg7V45yJ3ozKbWDetzjtg0dMlVH5Cq9xmh4iPNE
         J4hdDGWt0n9oaqIEYb9jJyRQLD98E1svzGniBjBIQrDt2xEzO37GrBVwnsNctph0+V84
         ejng==
X-Forwarded-Encrypted: i=1; AJvYcCWA3IhpFPpcQhl0UgcOET9TkSG2yhxk7nMl5EtzOuHKekCD01H8gpcLZCbX3x6tjXXcQ/CBBOR0mH8=@vger.kernel.org, AJvYcCWXoWnIBqgRxgsvxTv/zCS9gcLDKwqVsrMQ/hdzVvvyNF9OpnP+TdIUgMTtDDPSNREqyJDkfCc/QS/CRdpX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrwnb6U+UMQIG+0mrcHdcbNppIdTSSaHYTxTbjF6cQBCrbxBll
	LzVtE+DyHihPF/BIlls5H0vE4fDnZ4UvfVq1kQyBtLVBqam/tyzIZA56iskLWAW/wq8je8Z8Ud5
	rlcQJseWU1hynE0tRcKFgjQQvBoY=
X-Gm-Gg: ASbGncseFM0hsHmSNUDvN236q7gzybvRKvhzgWs1SJxq5cgyH68KzsgqAmjYfOQEHyS
	HySpDkhW/xo/522WwmG8lKThw1f80fWSgAN7AkswMm3wr4S4VvG/StDCc1VzCJSJi20XbPg==
X-Google-Smtp-Source: AGHT+IHiUFULatLaYVTG50OelwewoeambCvXM1mTQ31PiJAH6oiIxTBI5F18bPDN/bN5hq3LikyhjtSIbsUPOxZ5ITU=
X-Received: by 2002:a17:90b:518d:b0:2f4:43ce:dcea with SMTP id
 98e67ed59e1d1-2fbf5c580c0mr16296822a91.25.1739523034540; Fri, 14 Feb 2025
 00:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206084817.3799312-1-peng.fan@oss.nxp.com> <20250214040457.GC20275@localhost.localdomain>
In-Reply-To: <20250214040457.GC20275@localhost.localdomain>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 14 Feb 2025 10:52:08 +0200
X-Gm-Features: AWEUYZmgsC6Etzl4Yr65LGIQ5Av4XAoNXRv7HFJ-K1y_EhMdzGRHl7TymfpRoOo
Message-ID: <CAEnQRZD25RrtAzAy4B9WX3+1iUuLdt1cgZ36kCTr4poawP1htA@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>, 
	"open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 4:58=E2=80=AFAM Peng Fan <peng.fan@oss.nxp.com> wro=
te:
>
> Hi Vinod,
>
> Any comments?

Hi Peng,

Do not send empty pings.

Just resend the patches marking them as [RESEND PATCH...

Daniel.

