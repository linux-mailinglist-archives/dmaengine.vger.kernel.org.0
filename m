Return-Path: <dmaengine+bounces-5537-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB6AADFB4B
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jun 2025 04:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C065A3A441D
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jun 2025 02:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1222D79F;
	Thu, 19 Jun 2025 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="rDt6uPh7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F171F09BF
	for <dmaengine@vger.kernel.org>; Thu, 19 Jun 2025 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300686; cv=none; b=uLRnAD+n5eZyJYkrCZrdMF50ZC7c/WD7LcMeHFfAaMNxuufUtYsm8Nv+3Ci72UZoKr6ouDdcuQ4j0cksSuqK/zCAgcAU3tzeGRIoBDpQCMdF419zPN+CPuvv3BV1VHJE8ooV/HqUu0q82ItI8zZMsPsj9mkSTJXiyEpbxXUPLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300686; c=relaxed/simple;
	bh=R6t76eWH2HzIq2TB7HLKHxRY/f1IWLs6nx6TUFl7QAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjWTVlie37/ppbBVt3kJH/NWD7G+f0OYJpppedTYZhBGCx++2YDLCXlqz73Nbxja2BI2cJlItApzWpTx1GBRk8pdhRbcBqTrjrmblp0vjYDvF6JDQMzAD3Plf6+MkH/qiCrmYVYKeVAmhK783fhnEyuHJSQxwi5AmbAf7HEjLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=rDt6uPh7; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e3c6b88dbso2520607b3.0
        for <dmaengine@vger.kernel.org>; Wed, 18 Jun 2025 19:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1750300684; x=1750905484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJvyWk8eVLm4Tc980PDphhjuFD7XIh64AkzzgoplEgI=;
        b=rDt6uPh7hjhj1QiLe2docWIq9u9ltGOoLTZgCDpB2/t2jTunoLTIlspQ4Z9YofaJ6f
         ZRySfv5+AUPDIMafIiILhsCGQDFNZC6++EeSCTkvwKvBdr83H1GfO41tHUXCYYXUFDXB
         yxmlA2gbwDOtlrx19Z2vNDfdznH+epTTT7oQwVL5Ezujx5BcC2CzaI/GVOxWtCVkL0eF
         E14A/QWQJQxfqQrXnvbGszEfBibMd7e3X6TpXET8MWct7oCplo3rf48IJEpfeL2W3MXX
         SCJvZcm29xLShaG/kMSlin3xOdzKaD+XMVJEcqRpsoo1mTwM/vGSz5OxQKQGYUk+vwrR
         DXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750300684; x=1750905484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJvyWk8eVLm4Tc980PDphhjuFD7XIh64AkzzgoplEgI=;
        b=SOjAfwWjNKfwJmFepOjHN/AeBe3iqJqrYo9cFmQOgDZ45AhGsqQKYSdEdWAdX1vjAy
         +ds4kvKRxKNtSU9N4JXLfwDArW3ntrAtDQ/w2I+RpufZx/kpSsacdQR/eRdTB4g3fzTb
         E+IMOvEKEqCLnMhGNa3ifndMIqcCLoQl7S9mGpZh8MBrtjxWWJCp1Z2UyYr6DJ5/oDJ+
         HN/1vHkHnbBJoiHki9pUlZp3KVf0GzNeDT0y9aHt2/rgFOCttqdPQMwVRwaJT/LhYO98
         Wmm7Q+UmsXfx4OtZz5H07DAlh9EjwZMVg1743NAVRbU3iNUHhBt2QeHuA3egAnFwZ0YQ
         ePcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUiot4FFBt44gJ6aeL50q9ZKrsJRlVHToF3OLwvsB2w4/dSmeN5xfKHa4jE460C+8thpxV2qaTmo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCS2EA0hfrj2oKB7pZhZQfffsIIBZP+d2MGwb4ZeIrMvxMFGU1
	RZhVTkJYwWderXvudE0w7vmcc47AF6JMjtLi5pd7zJPRl0Pba8a5HvGxUwrKgwQI3r+C6wRVibI
	KhhUuDDXZ+zw/MR6UsZvDltBoizX5JbBd3g0a5VYD8Q==
X-Gm-Gg: ASbGncvegWCcOE90j0uGGvwDu1mEiIgQPWjwx2mGk4+bEoJ1Nv2kAvHu5RpVORuR4rO
	b7EMqJExzYIRHnj8rEkbGeKmcq/jfjRLr5jQZpN98/PwUGdQsqSs52FnayiRLAwVFFvqkBsUZ0J
	7UGQzyNNRarL0fgL4vhMbXK7kZFVix/oofvLdOVLtpUn5vw+ITdz/1
X-Google-Smtp-Source: AGHT+IFLz3Vl5G1STkCpTHnFizE3p8mAf9pvpCYG1N2QfqDuoM9RrsfGR/H2ltgphKQYCTDpc5ZM+HFUSOw07SlczgM=
X-Received: by 2002:a05:690c:8e0d:b0:70e:7503:1181 with SMTP id
 00721157ae682-7117543370amr238070227b3.18.1750300683598; Wed, 18 Jun 2025
 19:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611125723.181711-1-guodong@riscstar.com> <20250611125723.181711-5-guodong@riscstar.com>
 <aFEFBss3RT7NbQkV@vaman>
In-Reply-To: <aFEFBss3RT7NbQkV@vaman>
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 19 Jun 2025 10:37:52 +0800
X-Gm-Features: AX0GCFusS0Wf6JwTzVWm3sY_lYpO92NDTczE7xfKgCKObXd32EKaOhpP7K8QAJc
Message-ID: <CAH1PCMYL57eEVyx7qy3offcsuKsN23qO73H+YTnffZe4kBxzMA@mail.gmail.com>
Subject: Re: [PATCH 4/8] dma: mmp_pdma: Add SpacemiT PDMA support with 64-bit addressing
To: Vinod Koul <vkoul@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com, 
	emil.renner.berthing@canonical.com, inochiama@gmail.com, 
	geert+renesas@glider.be, tglx@linutronix.de, hal.feng@starfivetech.com, 
	joel@jms.id.au, duje.mihanovic@skole.hr, elder@riscstar.com, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:02=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
>
> On 11-06-25, 20:57, Guodong Xu wrote:
> > Extend the MMP PDMA driver to support SpacemiT PDMA controllers with
> > 64-bit physical addressing capabilities, as used in the K1 SoC. This
> > change introduces a flexible architecture that maintains compatibility
> > with existing 32-bit Marvell platforms while adding 64-bit support.
> >
> > Key changes:
> > - Add struct mmp_pdma_config to abstract platform-specific behaviors
> > - Implement 64-bit address support through:
> >   * New high address registers (DDADRH, DSADRH, DTADRH)
> >   * DCSR_LPAEEN bit for Long Physical Address Extension mode
> >   * Helper functions for 32/64-bit address handling
> > - Add "spacemit,pdma-1.0" compatible string with associated config
> > - Extend descriptor structure to support 64-bit addresses
> > - Refactor address handling code to be platform-agnostic
> > - Add proper DMA mask configuration for both 32-bit and 64-bit modes
> >
> > The implementation uses a configuration-based approach to keeps all
> > platform-specific code isolated in config structures. It maintains clea=
n
> > separation between 32-bit and 64-bit code paths, provides consistent
> > API for both addressing modes and preserves backward compatibility.
>
> I would ask for this to be split, first to to driver changes for adding
> new ops and then adding new soc support. This way the two changes are
> independent

Hi, Vinod

Thank you for the feedback. I agree with that.
I'll send v2 with this split approach.

-
Guodong

>
> --
> ~Vinod

