Return-Path: <dmaengine+bounces-4625-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB9A4AC86
	for <lists+dmaengine@lfdr.de>; Sat,  1 Mar 2025 16:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FEE3AEFC4
	for <lists+dmaengine@lfdr.de>; Sat,  1 Mar 2025 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CDE1DE891;
	Sat,  1 Mar 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unc.edu.ar header.i=@unc.edu.ar header.b="eEH6homi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9A33E1
	for <dmaengine@vger.kernel.org>; Sat,  1 Mar 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740842269; cv=none; b=iD6k2mUbr68dlNerKr5iFNWhAOU5CrfkqBeBvlfSwV2eQqyskHI2FOdeTs62Opnapa0CFHaVL+d2dMGzUtqAswkuvkiGWCG4eAww9WgvUv+rRb5N35aJNcme/CuPOKZ1RiaOZ+WGBdMmF71XB5sNGBlIibN4liYbk1Tcr0GC/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740842269; c=relaxed/simple;
	bh=Nph8Zj9apfwfpWBmJb9IRriZnUNdJnrjtc1bVNjt6CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuvbSqdbQqUEFXk/JzonDb3jTVJ3UCM+0l/Y4ldPyDqrCzu7uea1iWw1HgGn9KFi/GdtHR3JRxVqDhXPIEIGD10S6PR9NzMYQXe9iA9uQciWbcXnPINdJVh7JxhrtKaX/ikfBtZT5YVfbebd1ypm8sz20ANipkvCe072zTEe1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unc.edu.ar; spf=pass smtp.mailfrom=unc.edu.ar; dkim=pass (1024-bit key) header.d=unc.edu.ar header.i=@unc.edu.ar header.b=eEH6homi; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unc.edu.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unc.edu.ar
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-866de72bb82so1314484241.1
        for <dmaengine@vger.kernel.org>; Sat, 01 Mar 2025 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unc.edu.ar; s=google; t=1740842265; x=1741447065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZwdCKGZVQlaVnra2iaZO23ZlGGrSbXOrnZznLlqeng=;
        b=eEH6homiMaysulERAqUfnC+DoLD8+wGc4f3oDRh9qxjJ+UjpCnBSrpZrV3ohI5vdU/
         adQXxPzRzyPSp+ZpunIilCSRV74Mw6B9rinAXQuDWF2VPaOoX60Vry5BI0uVXW5zEliL
         hDeIsgsclewsWVz0pIRg3X3CXVaAEY/Uoqkxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740842265; x=1741447065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZwdCKGZVQlaVnra2iaZO23ZlGGrSbXOrnZznLlqeng=;
        b=oipRfeMr2nKJ3zuPw49KffgLLIhABVbDxHfUcAdOpkged6Z487v6EG9OskKgYU2Y8f
         QMtqe7qyMirjFZCay/867sgCLvmU7C4IKdxdgxHPC3dHQo5rttubepO2D7Eo3lnseJ20
         YXDVtlT1iSsnEvuLH40/Kd789ps5AhyFABiyK1oTQKEcqhHgwLpMTSCsXZofX7p0fRjW
         95r4oSKWxPX4WisbT+2ny7HcDOIpFqaWh14iiZ/Sc1CyD9uavMYO/oHGFhZ8HZGtQjxh
         SZBHASLbV3vWcR2EGdsjWEqkjBIH7GE5qULWGoYdUZUv/oHo0rzNG5E9Tpnv1Yiq1KmH
         dD1A==
X-Gm-Message-State: AOJu0YzNIEH6isEHBX6p9m0PpEM48TK5EzxG3v7wi3XeBUCIt8lb3hH8
	1g07iSaSbNRXeJeMf6UOKCE9uzcLHqDCpPE8xseWrVm3p9aJmZnn0DunJj1uWUAON2a2NP1aw/1
	rxFb/ZKUcd6jbw0TkEn4NWe2HcKcIzs+oHB/8vseObhjuEwFD
X-Gm-Gg: ASbGnctpnVhmSy8lPmZB066EEznzfFhClaNyMAl2BgLjegGJg32GZYVLb1qDyvFWZf5
	sdTAuazgZ1GT0Ka4CauszOvy08vro6Tz/QX6qieoZOY1ZADFzfNdZs6VeTVc8dNCCLpEuQd7qhA
	/JN0KHA1C/nTKaXq7qtJgZ21udb0nBHrXi+gRu7FUaBnuoEzfpCl32jRQDz1iJ
X-Google-Smtp-Source: AGHT+IECzTGU/eoPIYlTs0EKWuGet3rK2G13Z5VYyw+U6RxRazJM4u0Wu5xptKs4ucvFaAG1R6EE2R/UUNv392i8iyI=
X-Received: by 2002:a05:6122:88a:b0:520:6773:e5bf with SMTP id
 71dfb90a1353d-5235b415010mr4517772e0c.1.1740842265573; Sat, 01 Mar 2025
 07:17:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRNPix2JH2De8Hjxwi7EiBnyUVkMvKw7KeowV+EGvd_SuxrfA@mail.gmail.com>
 <4e32d831-b4d1-4a5a-905e-05858ce0be2a@intel.com>
In-Reply-To: <4e32d831-b4d1-4a5a-905e-05858ce0be2a@intel.com>
From: Carlos Sergio Bederian <carlos.bederian@unc.edu.ar>
Date: Sat, 1 Mar 2025 12:17:34 -0300
X-Gm-Features: AQ5f1JrWk0Inw5_F9xvNx7WV8malJz6_X3THonBWdOxNfXy_U4NTzVYd_5EcO7M
Message-ID: <CAFRNPiyLijU41EMZ6X0j4ooPP27L3DcRWwJwcJQ_zJHrvbAmpg@mail.gmail.com>
Subject: Re: dma_find_channel(DMA_MEMCPY) on ioat
To: Dave Jiang <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 6:39=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 2/28/25 2:23 PM, Carlos Sergio Bederian wrote:
> > I work at an HPC center and I've been trying to figure out why the
> > knem intra-node communication kernel module stopped being able to use
> > IOAT to offload memcpy at some point in time, presumably a long time
> > ago.
> > The knem module uses dma_find_channel(DMA_MEMCPY) to get a dma_chan so
> > I wrote a test kernel module that tries to grab a dma_chan using both
> > dma_find_channel and dma_request_channel and then submits a memcpy.
> > dma_request_channel succeeds in returning a DMA_MEMCPY channel, but
> > dma_find_channel never does, regardless of order. This is on a Debian
> > 6.12.9 kernel.
> > Is there anything I'm missing?
>
> Does dmatest work for you?
Yup, I've just compiled 6.12.17 with dmatest and it ran fine on every chann=
el
listed in /sys/class/dma. No changes wrt dma_find_channel.

> Also, make sure dmatest isn't loaded when you have your module loaded.
dmatest wasn't even built.

> Or any other kernel module that uses dma like ntb_transport isn't claimin=
g
> the channels.
No users AFAICT.

>
> DJ
> >
> > static struct dma_chan* dma_req(void) {
> >     struct dma_chan* chan =3D NULL;
> >     dma_cap_mask_t mask;
> >     dma_cap_zero(mask);
> >     dma_cap_set(DMA_MEMCPY, mask);
> >     chan =3D dma_request_channel(mask, NULL, NULL);
> >     if (!chan) {
> >         pr_err("dmacopy: dma_request_channel didn't return a channel");
> >     } else {
> >         pr_info("dmacopy: dma_request_channel succeeded");
> >     }
> >     return chan;
> > }
> >
> > static struct dma_chan* dma_find(void) {
> >     struct dma_chan* chan =3D NULL;
> >     dmaengine_get();
> >     chan =3D dma_find_channel(DMA_MEMCPY);
> >     if (!chan) {
> >         pr_err("dmacopy: dma_find_channel didn't return a channel");
> >         dmaengine_put();
> >     } else {
> >         pr_info("dmacopy: dma_find_channel succeeded");
> >     }
> >     return chan;
> > }
> >
>

