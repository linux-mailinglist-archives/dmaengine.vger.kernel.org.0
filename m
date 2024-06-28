Return-Path: <dmaengine+bounces-2584-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E9991BBD9
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FAEB21400
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A06152E00;
	Fri, 28 Jun 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="roGrKEXk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41115099D
	for <dmaengine@vger.kernel.org>; Fri, 28 Jun 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568099; cv=none; b=H8F6fhT6xGcpGk7JZgXXn8u6uUfgWjejWogYq+2Vd3BRbOYisVFbWxl0XcOaFH1buUK+X165gc2NXAQ2JxBqXZFi9Aelk02dvwlUtOXvyW5FG50E7qLDTGBw8CVGnvT3LgTZZBeMviJfe6pJKHDv/1OKqjkwJ4vfa5F9Di+rcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568099; c=relaxed/simple;
	bh=N9ul7sciE4TWD5ZCzRMXkQo/BW8Bk2N6jU2ho5gBxDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWuBtkwMGBTpvslnzUT0jvlIMGYLvizShK5vARVSvOkObrw0Zi3d4Xh1djsIqOaQJmhHI7jvnLz7btJKYgxnKR6bIl/enAMCXAfpwvmYjJuE2n9v3ADkyprB1yUzXOvby4Qb/Q5BHYxVs0is0sEn0z/lweoy50SZnDM+pn6npkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=roGrKEXk; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b501a4344bso1765756d6.3
        for <dmaengine@vger.kernel.org>; Fri, 28 Jun 2024 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719568096; x=1720172896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9ul7sciE4TWD5ZCzRMXkQo/BW8Bk2N6jU2ho5gBxDc=;
        b=roGrKEXkgOuPWGP4cWrlmSIWtFKzZUMt/15MXOuALr8KGNJE1YO3wVAWVZu3iSZxRw
         wuqPWO5hyH+sD8X9dnOugrOuGfQqeIUlQQfSoO53sr7dhsL9gAYvgaTwlDoOjK3TrsKz
         pW3SITw6ZzfyLIxP7VYnRJbGxpaqmUCcOsoZ99tCa5vMBHTz9Nz59b3J5rW4VhXDlv44
         o68Fdybl/gAnIDW9Lj5XGd37qlosTD9ZY/aDs71rZ5XJJnMPYmEQ3lAvzt2p3unTcFGS
         XxEKLSphs55AZl+kAHqoZeAIeXUPrkVBWEHp+p9q/x0ZAXwzmdBSZZvgYXDSSe6soziH
         HhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719568096; x=1720172896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9ul7sciE4TWD5ZCzRMXkQo/BW8Bk2N6jU2ho5gBxDc=;
        b=IXLmdi0KSsdsakaA5XHJrd7/DlACVXzVsmhWYycjROz826VhThgoY1mGbQQhGnCK4K
         XVmOj09PrnAjY9swI3tb+Gklub714VwuTKJLbb+I1m4i+abOQcwIqYHpaKI1j2NPRElv
         E5NTDUChxjOzRk50F7egX+ORft6eW/AqjfcjduW0uLyTOieJ/qwUUnIfvIrmodmrbuSC
         5jk6YV0ncK8XfncR7KNpg7/Tay/y915w5PTMBn9i/L+yaoNg/dnJ1tNLCug1ft5pDjyw
         Q3+M6hPn9EifVWDnr3G7EI2N0WErE9fXPiLudxJFiQn2A/i1SpQGTsREYsqj4Jq0L57x
         Glyg==
X-Forwarded-Encrypted: i=1; AJvYcCXfCn3OnbFuro5ln3qe0A81W+JZ3zbUYek516HhpDQYQh1jOgw8olRvGJtTj/ufCpyyNJLe8KH2PCk1vW9cMOn8bAPrx7v3RKe8
X-Gm-Message-State: AOJu0YyYwEEx1JncYD7YYusEjlp+FLlPyWVNzBwv63cF4mKbVFL7ThqI
	1DPYn7c8Nm3Or8v7c3tyI7mCPalQxiywvosT7q2ISOV+5BIoGjZvkqRw74AhaCUJX61infe8T9u
	u+WQfjOehG5C+UYoyhQiM6IpG0aSBXl4HA7w8kA==
X-Google-Smtp-Source: AGHT+IGKbXGa8tFRoUBtX9jPFSaA/HXwNQUkn5EBHWhOJnFoUnmXEc3piUEvQv5r8Xh65vaIT9hG5Yzp9EElL8Q42qY=
X-Received: by 2002:a05:6214:230d:b0:6b5:468e:d413 with SMTP id
 6a1803df08f44-6b5468ed608mr190751986d6.40.1719568096583; Fri, 28 Jun 2024
 02:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
 <20240620175657.358273-9-piotr.wojtaszczyk@timesys.com> <20240621103019.783271f4@xps-13>
 <CAG+cZ06GSxPsTzRLXSk23qWXMkp-qxYq7Z9av5-2cPHSJmVAHg@mail.gmail.com> <20240624083900.14e38d82@xps-13>
In-Reply-To: <20240624083900.14e38d82@xps-13>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Fri, 28 Jun 2024 11:48:05 +0200
Message-ID: <CAG+cZ06j4XACKtgwkTyjK0jhFTt+-EYTN+qFKO20ow3sjK84BA@mail.gmail.com>
Subject: Re: [Patch v4 08/10] mtd: rawnand: lpx32xx: Request DMA channels
 using DT entries
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "J.M.B. Downing" <jonathan.downing@nautel.com>, Vladimir Zapolskiy <vz@mleia.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:39=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > > I don't see any change regarding the NAND controller node in the devi=
ce
> > > tree, is there any dependency with other patches from the same patchs=
et
> > > or may I apply this directly to nand/next?
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > Yes, this patch depends on "[v4,04/10] ARM: dts: lpc32xx: Add missing
> > dma and i2s properties"
> > which will be splitted into two or more separate patches per request
> > in the comments.
> > I'd like to keep driver changes and corresponding changes in DTS in
> > the same patch
> > but I've made a separate patch for DTS per request from v2 of the patch=
 set.
>
> These changes won't be applied to the same tries so they must be split.
>
> So I will not take this patch for the next merge window and instead
> will take it for the one after, if the DT patches have been applied.
> Please ping me at -rc1 again if the DT patches have gone through.
>
> Thanks,
> Miqu=C3=A8l

Hi Miqu=C3=A8l, please check v5 of the patch, I've added fallback if a DMA =
can't be
requested using DT, this is backward compatible with platform data and no
longer depends on the DT changes.
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20240627150046.2587=
95-11-piotr.wojtaszczyk@timesys.com/

--
Piotr Wojtaszczyk
Timesys

