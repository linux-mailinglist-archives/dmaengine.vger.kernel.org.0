Return-Path: <dmaengine+bounces-6330-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F2B40259
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3192F3B28C8
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89942D6E4C;
	Tue,  2 Sep 2025 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUpGCqXc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B902DD5F3;
	Tue,  2 Sep 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818785; cv=none; b=YPfD4MxRsgGIZ2h+rS7DV+8s2P80SZTEPm9lXAozAxJXVig4jmkxJoxkxzM/KcC2PDp5DkMHztLl6O4GRE9uGO3AEpVRhc0AfJFEI9jJTEQsGhevaD7arqGNcd60RfAM0uxJt+2Z2MfTS8AVSOf7U7yvBZDvA/zsL8PtDaJ+Q4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818785; c=relaxed/simple;
	bh=9NMZUI5Y7HI3Rw9WBW25pqDwev8NNixgVWRQ/sY2W6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIqQ5U7XYjbpeU07N2XuwWSV+Vp6fdakg4LC1SC9tfA49LpbhmvoY+jzAyWlZ4l/CpAZR6ZYTWLDHTujU1mOcl5/nH/oGYTzMZWIEwwZ21LPBFRcn4cp2v5QHsWqFhPe6K0IPkfIZsQNwGsdHkwQdqQfgqKuNgbSxOiDs7fGElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUpGCqXc; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61bd4ad64c7so1638554eaf.0;
        Tue, 02 Sep 2025 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756818782; x=1757423582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NMZUI5Y7HI3Rw9WBW25pqDwev8NNixgVWRQ/sY2W6s=;
        b=kUpGCqXcB8Pj7a+YHKlHosOpY9crgmyl8MmU8jeYiwr5PNuJuBuAhYI/U0gap2q7Yr
         hFsmHs44PR6qd/z3+3jokZj6yoJN/YZSoGpdbu+RRFGuh1B18qbdgKSRDIoBJSPCVAyq
         9IVAHdPiNOBLzMvmM9urlNB1yuEJvGOgKEUp6zYSMIr6TiHafCwjnEVF37wJ28OqHP/6
         hjZPuXT3Zr3uiXqkDkFyo9TQ1Y0mykcuIZUbud8NZ8WcoeIpQgVqi0YKWZj91r3f9DfT
         FgFGjk+yO69T56qvSPjernpTE/tZwoYb2X+CzJiivwAQNhIrKNGkAzK/Htj02euaogfv
         an2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818782; x=1757423582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NMZUI5Y7HI3Rw9WBW25pqDwev8NNixgVWRQ/sY2W6s=;
        b=VWfzrAwxZ7uXFCc7sfdwjzOkcoM7trmnYpL2WqnD23XMvaN5ER0EzWbf3jExRdEPxY
         qVi0S/sLJnGozeM+Kd8CFhCkfTTxfLLJx7dhMPU3z9sssN8bu1/nFfvEMRkE8SZ1dFYi
         TzxvuxP0uAqkGMSJgMkSP0DC9hcDagoq/enmPpQCqFtce5oZH12688IBN2s2S4hQCy7d
         3uQW5/rIaQ314GP5sLA53YNGj3J44Pr+2I2fNMahSHFKtMUWjmuLRPb+bdueLq8W/sr/
         EHZsaTkqjyYawRGWuaI2nyUcb+qM4o8zFC1CRdQlzO06jvuvsyIg9tpX5isV+34lAc3R
         AXdA==
X-Forwarded-Encrypted: i=1; AJvYcCUYnvGUp+Du+NjUG5ENHMu0zs9qhcb697d1pbDsmdXsqZDuSQCYAUkrA5RFU+oND0+yobziSVUY@vger.kernel.org, AJvYcCVwI0wvoXRDSQ6OxKOATPL1wJuiBxGPE8NKQlv08BB9M9oU/xQ92HZTKfQsYbHYDQvZb5Rgi7/VRNY=@vger.kernel.org, AJvYcCW2fEdSsRy4vHeCTrJTTVPi8kwnNE+ttXO8aMpsvjw2Cu5xf1SjPDTcQkKif0hnIhbSSHiBcvsL9D27vucY@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRuIgvourLJ+/3CCJbM0XIURMpiT+SIVjq/AwMLHJPdCGAILY
	JC55EdUKtTQCYRdICYIIDuKcrdqgdmgcsC/8g6AtrKfLKcYVrX5lWeVA1G4QiGiVen5zE4ScttS
	EFe3kUT0+vD4ygNU7kvqeRuU02GgCU55C0Ctu7BuJiCWX
X-Gm-Gg: ASbGncu+p6GtA0cxF7m7BJv3fUK1vq1KCmumq+6RVrIuFoHYoRdmUoUaWfgYG8aNQn8
	r7K4oQIed/izZZNfYRqVWgBORxFGkEvPQ63RIIAKL4sBZUnft2JdJeTT6vIZM06eKlQC0U14WmS
	QaotDFK5WQM0KZfSNFqmCwrU4Pn2nhOjAdAS/904T6hJ7rhwzrdRkQVSaiz7/jC0N9VKY9kAjiM
	2o+U4SJ+E+4RspsSMCNFyjkKLO//JYwwSWULZL/SJdUXiR18w==
X-Google-Smtp-Source: AGHT+IGVjb+W5RP9joRiPgJI7s3rpEWa84DA86mjTCeX0rni7ytI4P5B9ydSHyX6x6nu/YAiDN0oL7q964gtawLngK4=
X-Received: by 2002:a05:6808:a550:10b0:438:1c5f:dbf4 with SMTP id
 5614622812f47-4381c5fdfe2mr459981b6e.33.1756818782210; Tue, 02 Sep 2025
 06:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902090358.2423285-1-linmq006@gmail.com> <aLa65t3j1tmyEMnp@smile.fi.intel.com>
 <CAH-r-ZHx+vcL3QY0rKP3Lo_qofYLSuxCxqyb=URPSbnStxA5cQ@mail.gmail.com> <aLbOqbuIVWhq4UtL@smile.fi.intel.com>
In-Reply-To: <aLbOqbuIVWhq4UtL@smile.fi.intel.com>
From: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Date: Tue, 2 Sep 2025 21:12:51 +0800
X-Gm-Features: Ac12FXwgV4lKoeFyvanf3o9U8nBbczJMjjagB-fI6_fT7YZnE--LcckfImGs_Oo
Message-ID: <CAH-r-ZHL5vSvieYoRp7n-5k3YfG2PSi1=atHg4+261roGOicpA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route_allocate
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E4=BA=8E2025=E5=B9=B49=
=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=8C 19:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 02, 2025 at 06:18:18PM +0800, =E6=9E=97=E5=A6=99=E5=80=A9 wro=
te:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E4=BA=8E2025=E5=B9=
=B49=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=8C 17:37=E5=86=99=E9=81=93=EF=BC=9A
> > > On Tue, Sep 02, 2025 at 05:03:58PM +0800, Miaoqian Lin wrote:
> > > > The reference taken by of_find_device_by_node()
> > > > must be released when not needed anymore.
> > > > Add missing put_device() call to fix device reference leaks.
> > >
> > > How is this being found? Do you have a stacktrace or kmemleak reports=
?
> >
> > This was found through static code analysis.
> > The of_find_device_by_node() documentation states that it
> > "takes a reference to the embedded struct device which needs to be
> > dropped after use."
> >
> > I cross-referenced other of_find_device_by_node() usage patterns to
> > check the correct usage,
> > then audited this code and found the problem.
>
> You should summarise that in the commit message. But since it's already a=
pplied
> it's for the future and up to Vinos if he wants this to be updated.
>

Thank you. I'll include such info in the commit messages for future patches=
.

> > I don't have a stacktrace or kmemleak reports.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

