Return-Path: <dmaengine+bounces-4635-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD9A4C58B
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 16:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D387A53B3
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522AC9461;
	Mon,  3 Mar 2025 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unc.edu.ar header.i=@unc.edu.ar header.b="I9KZ/D+f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7523F36F
	for <dmaengine@vger.kernel.org>; Mon,  3 Mar 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016512; cv=none; b=TnlUQRvSLaQkluOUCBb934PGoQ8GgivWZCNRCmm2DfkfauDX9gZKRNT6dsM3dFYbsHWzGwSCOYNcuRx091THBuFnycURolDh28g4mlUk90utoHmjufF3H0lk2zBqwCJHz1/EFflksoRFlT64WQMjwSgkVuuhzFbqozhweHe5B+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016512; c=relaxed/simple;
	bh=MY/k5fCkaYOc1qtidnLIYzCW3+9oRs75dI0brAe7VPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkmdGsdr/YCZpk/sKiiM/ffHX4HD1o+FfibAnuTwqYUHpuvzQQbIWGkVqJ3ed+/dvafHkDjf35BHKnoap7FRj7DTEU9W+4vaPgrc66HTiK7fn2HRw9IMbuccpjBYcfkARt34WWA64Zqvk/edkXJ4VMLP+nSB+kuLp4kaunHkClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unc.edu.ar; spf=pass smtp.mailfrom=unc.edu.ar; dkim=pass (1024-bit key) header.d=unc.edu.ar header.i=@unc.edu.ar header.b=I9KZ/D+f; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unc.edu.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unc.edu.ar
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso4798337e0c.3
        for <dmaengine@vger.kernel.org>; Mon, 03 Mar 2025 07:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unc.edu.ar; s=google; t=1741016508; x=1741621308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2oixOtzpuHX2nL9tVxRHWo9sHRB/BXY+eYBLBm5VF8=;
        b=I9KZ/D+f0ZQUP+mY2aYAqlcKPQkprWz6q8RdWVGbPdlZG7iW/F+wmyTE7xei8HXzYb
         mvJan2xQd7LtPhRH3q51EIiyaOYiBl6pAwBRgY+105rJ2/HNs8ok+GolR54ipBT6CxKY
         jRK9TAvdbjKIkyBcDu3w+HuX5RoGbXaOz4M+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016508; x=1741621308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2oixOtzpuHX2nL9tVxRHWo9sHRB/BXY+eYBLBm5VF8=;
        b=e2tk9O5jQJX5P69X1fYo1Xq7v0OZKOUoatU2mA21n1QHTUKn1fBFc1hSaOHTJVDnvH
         89ZagAcH2080EHEHicQGBSxpSRAUP3t29ZQ60xbePHzNBibhkoiuOs/q6YuLejmIMTL8
         3WcslQk9H3DBAL7X3HmFaiO66lw8nkKGdGRA+pMV3y2jVeIfVUeOBnPKQFqMqgKBQ31r
         YLXhzUKRislCO6chqWJOkjKKXwn+S8B5D4ycXjNQeuS1fwf2MuWtd7OLzOVfDds6symP
         ySbxnBOOFsAGkge6RibPvhFxV9NZOQZPDiyejinCEOB8Bwh95e1ilM2x1uriRNM7IKIF
         E4uQ==
X-Gm-Message-State: AOJu0YzWE7ywBzvtvi/gGBuAcNr+HLOisVP24SaJMS9hu5Q49F2M/kmY
	lZcZsa7kZTcnJHDPFrVyY3cWwQ63hms2UtdLN+E/6DSjMMJn9Makqbe5twXN5CQj2xkMBQgDVSX
	9AhT4tsOavbcbljtAU6r4LwU1OYFrRs4IeejPCQ==
X-Gm-Gg: ASbGnctqan+79Xe88vU4sX1T442Ll131q55w80iMggu82QGVu7jat87g9EikeSzeoYK
	oAQusJxeXtJbTOngDtQrKoTlhVdVwaaKXhT3i1kp99sOStHw0DP7ywqH2Jy6Nyo1KnhvMzzZYOA
	u2tbog7cyOli0f6v96WgvBDXIszonD2MJu4nrRvgIoKiwgU4THi/pc9vIAfW7R
X-Google-Smtp-Source: AGHT+IGYoEBA4cPoVkoKse6WCAaJT14V8Q9dLT0wleSe37qJ1wIV2jEaNy/f1PHD+4ejqRcQ+Os+eLWnprzgIbmqaXo=
X-Received: by 2002:a05:6122:8891:b0:523:7c70:bc9c with SMTP id
 71dfb90a1353d-5237c70beb6mr2349064e0c.5.1741016508137; Mon, 03 Mar 2025
 07:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRNPix2JH2De8Hjxwi7EiBnyUVkMvKw7KeowV+EGvd_SuxrfA@mail.gmail.com>
 <4e32d831-b4d1-4a5a-905e-05858ce0be2a@intel.com> <CAFRNPiyLijU41EMZ6X0j4ooPP27L3DcRWwJwcJQ_zJHrvbAmpg@mail.gmail.com>
 <1b58f456-8e24-4a3a-b93c-687baed3ce93@intel.com>
In-Reply-To: <1b58f456-8e24-4a3a-b93c-687baed3ce93@intel.com>
From: Carlos Sergio Bederian <carlos.bederian@unc.edu.ar>
Date: Mon, 3 Mar 2025 12:41:37 -0300
X-Gm-Features: AQ5f1JreeIVab53tjWvtxBUi-_c8bl9vCgn3Mdjr12ETPKcrIbOxgZMNy3-AyD4
Message-ID: <CAFRNPiyiQQRaFjkzaXDTOQgxjYWRbkDnRBAwrFAe9cdpeuBSVQ@mail.gmail.com>
Subject: Re: dma_find_channel(DMA_MEMCPY) on ioat
To: Dave Jiang <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 12:25=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 3/1/25 8:17 AM, Carlos Sergio Bederian wrote:
> > On Fri, Feb 28, 2025 at 6:39=E2=80=AFPM Dave Jiang <dave.jiang@intel.co=
m> wrote:
> >>
> >>
> >>
> >> On 2/28/25 2:23 PM, Carlos Sergio Bederian wrote:
> >>> I work at an HPC center and I've been trying to figure out why the
> >>> knem intra-node communication kernel module stopped being able to use
> >>> IOAT to offload memcpy at some point in time, presumably a long time
> >>> ago.
> >>> The knem module uses dma_find_channel(DMA_MEMCPY) to get a dma_chan s=
o
> >>> I wrote a test kernel module that tries to grab a dma_chan using both
> >>> dma_find_channel and dma_request_channel and then submits a memcpy.
> >>> dma_request_channel succeeds in returning a DMA_MEMCPY channel, but
> >>> dma_find_channel never does, regardless of order. This is on a Debian
> >>> 6.12.9 kernel.
> >>> Is there anything I'm missing?
> >>
> >> Does dmatest work for you?
> > Yup, I've just compiled 6.12.17 with dmatest and it ran fine on every c=
hannel
> > listed in /sys/class/dma. No changes wrt dma_find_channel.
>
> If dmatest is working then there does not appear to be any kernel
> regressions AFAICT. You can either try to do a git bisect and figure out
> what changed for you, or you can do some code tracing with
> dma_find_channel() and see why your code is failing to locate a channel.
> You can also compare your code with dmatest and see if there is anything
> you may need to tweak for your code.

AFAICT dmatest only calls dma_request_channel(), it doesn't cover
dma_find_channel().

>
> DJ
>
> >
> >> Also, make sure dmatest isn't loaded when you have your module loaded.
> > dmatest wasn't even built.
> >
> >> Or any other kernel module that uses dma like ntb_transport isn't clai=
ming
> >> the channels.
> > No users AFAICT.
> >
> >>
> >> DJ
> >>>
> >>> static struct dma_chan* dma_req(void) {
> >>>     struct dma_chan* chan =3D NULL;
> >>>     dma_cap_mask_t mask;
> >>>     dma_cap_zero(mask);
> >>>     dma_cap_set(DMA_MEMCPY, mask);
> >>>     chan =3D dma_request_channel(mask, NULL, NULL);
> >>>     if (!chan) {
> >>>         pr_err("dmacopy: dma_request_channel didn't return a channel"=
);
> >>>     } else {
> >>>         pr_info("dmacopy: dma_request_channel succeeded");
> >>>     }
> >>>     return chan;
> >>> }
> >>>
> >>> static struct dma_chan* dma_find(void) {
> >>>     struct dma_chan* chan =3D NULL;
> >>>     dmaengine_get();
> >>>     chan =3D dma_find_channel(DMA_MEMCPY);
> >>>     if (!chan) {
> >>>         pr_err("dmacopy: dma_find_channel didn't return a channel");
> >>>         dmaengine_put();
> >>>     } else {
> >>>         pr_info("dmacopy: dma_find_channel succeeded");
> >>>     }
> >>>     return chan;
> >>> }
> >>>
> >>
>

