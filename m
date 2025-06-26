Return-Path: <dmaengine+bounces-5634-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1311AEA382
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 18:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C3B5645A2
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812B287272;
	Thu, 26 Jun 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+kHMsd2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6572ED861
	for <dmaengine@vger.kernel.org>; Thu, 26 Jun 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955391; cv=none; b=IFEv+nlANXHIhQ3i33axzzt8ol42mkbeJ0wy/tB6AfpYpUC/LLb052s9hnAMTMTuZsY5z0jtWulub1UfCqYedeeqLdtr74HrgapFwIFj0azu61+TiOSoXty7ErvEhA5dWob7gIKQ0Q4Jws06jqhY2w7dxOFc6e3q8HPgepj8e3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955391; c=relaxed/simple;
	bh=AgCtIvqoexub9Qv7N/AgH5wxwMGGGs/6YulBNCxbeCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9j0AbAsotVxUF9xn2707J8DPdMmJPYy6AW4arVwVF2SUr9pecdJg7BeQy8avIWhIwumuDFdKEllBPfaxm+e5AHhcvXAz/+eeWBx/nINsG7Db3s+P4BaeaiDDBpiUaaoNpH1GfxqTpQXHQP0tMb62iTY5kAJ0+7GPssUHaPNbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+kHMsd2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32ade3723adso13155041fa.0
        for <dmaengine@vger.kernel.org>; Thu, 26 Jun 2025 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750955388; x=1751560188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhgWMpVftN0BXlOXEuQTKXHJQDcbuJWCCJBvXCzzlws=;
        b=j+kHMsd28pa2eEUT5k7m2NZt/ZYbHThGKY2Gc38l8n/zflNGyorZYxKAY08FzUTPv0
         jS+acmTxaThxS6o1SDFjXyCJw6Bq5AesRY/hGPjzZQFvQMIu6Frw3qbO9EtbYTrWi5YD
         CLL4kBT4xsSGpItx98cFM1E6CAy6JgrS0XY1BOUTleTSU7HUD/svSvg2FLqjK58TXad9
         hIWcAYnsWPpgQ4FGvf8YsnLfpslaj3hqZcgbMuMz+kIbDSCJtKj4c3OIpDKjaL9n7nld
         4i9uImBbIHzgen3TSbbjfJI404hM1o3h6ViVKDHnmAaXBwTprsgueR0806w+AxfCQNWn
         e+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750955388; x=1751560188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhgWMpVftN0BXlOXEuQTKXHJQDcbuJWCCJBvXCzzlws=;
        b=SYQKcFg/MsffIIeNM2c2f25P2jJBbinfmI4WLobbf3h904AfG+XQzYSezeJIFglJq+
         Z1+aHd/TuWmL1BfpR/nZA9b+EQKwTTrQ6lD9YjqasW5fFVnmS2lp6lEMCtx2jCQgiTK7
         AOWE1dl+5bsKv1ut1MJGuvBNFj2abd8jw//9hUTlqH9roQq7iiXGeTOqTrbj67ArhZHu
         EPYSgS4V2REnGGRre6ndWUAEYdXTjqetlrFv9tBBV8eEUyUkaPDrWOcseP/zv4YGgo0x
         HtWCh935C7meYuEF4JNxqfAuvqwNuWLC17q0VFao/z/ypdmX/2h7NuV9I8zYiKXhmoeK
         5Avw==
X-Forwarded-Encrypted: i=1; AJvYcCXNBrPyKXYJau7q3A5MKalxAD5dtE8f3NoaSdixa37zizvxVTpYFsnJxJWRZVvyVG9MTYLZA4poQJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEsrQQy6Vyi0zvTn7XIShcKP3Xzgo5ZBX7IsD0Xbbry4RdMJ8
	g7bfn8E1rQt8r0VnLYyHq19zP5HDN5IxY66wM+qhUtRFbcYyCkonKnyTYmJ1Xw/Fc3NVj01mtZ4
	X4kG8971NJ8GyzEzw3bN5fVd6PFqwgjXqUVkbm5rC
X-Gm-Gg: ASbGncs9PCSwnZjSaVZyvGcvNoQjKEFGrXFFGN95L15TZr63o9vyUzHCcngNzU6hEWv
	CKbnrp3vDlh2QQHP9ijyruL7RGnD0JiQHqtGR3idz0kL6xvmJxcRxeYTncrgRx7JvyWaYTuavSO
	bsvNiUqMTBUpKzDwLp1BUrnz8tp2X8upk1rDcp3raRk/M=
X-Google-Smtp-Source: AGHT+IEEwFR4Q1I48a+7OABIyBDRSlZA5tbdQsFM85tiZhc32of4fKA/nSlskPFcjFXcvfWw+C300VPrlQj8CDH2vFU=
X-Received: by 2002:a05:6512:3d0d:b0:553:2159:8718 with SMTP id
 2adb3069b0e04-5550b9e9f76mr68343e87.40.1750955387360; Thu, 26 Jun 2025
 09:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com> <20250620232031.2705638-4-dmatlack@google.com>
 <fe4b1d31-e910-40a1-ab83-d9fd936d1493@amd.com> <4aef95a0-a0de-4bd5-b4ec-5289f0bc0ab1@amd.com>
In-Reply-To: <4aef95a0-a0de-4bd5-b4ec-5289f0bc0ab1@amd.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 26 Jun 2025 09:29:20 -0700
X-Gm-Features: Ac12FXxh3iVx0ijncX4D0ghMn9yxTN7axomwuLA6jqvWOXSFOfPrvAPiEnHLUx4
Message-ID: <CALzav=fZcLpQ+9J=XOZ-=Cr1UA8qKa5NHXB1dJpqhCp7pee7Ow@mail.gmail.com>
Subject: Re: [PATCH 03/33] vfio: selftests: Introduce vfio_pci_device_test
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 4:44=E2=80=AFAM Sairaj Kodilkar <sarunkod@amd.com> =
wrote:
> On 6/26/2025 4:57 PM, Sairaj Kodilkar wrote:
> > On 6/21/2025 4:50 AM, David Matlack wrote:
> >> +/*
> >> + * Limit the number of MSIs enabled/disabled by the test regardless
> >> of the
> >> + * number of MSIs the device itself supports, e.g. to avoid hitting
> >> IRTE limits.
> >> + */
> >> +#define MAX_TEST_MSI 16U
> >> +
> >
> > Now that AMD IOMMU supports upto 2048 IRTEs per device, I wonder if we
> > can include a test with max MSIs 2048.

That sounds worth doing. I originally added this because I was hitting
IRTE limits on an Intel host and a ~6.6 kernel.

Is there some way the test can detect from userspace that the IOMMU
supports 2048 IRTEs that we could key off to decide what value of
MAX_TEST_MSI to use?

> >> +
> >> +    vfio_pci_dma_map(self->device, iova, size, mem);
> >> +    printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size,
> >> iova);
> >> +    vfio_pci_dma_unmap(self->device, iova, size);
> >
> >
> > I am slightly confused here. Because You are having an assert on munmap
> > and not on any of the vfio_pci_dma_(map/unmap). This test case is not
> > testing VFIO.
>
> I missed to see ioctl_assert. Please ignore this :) Sorry about that.

No worries, it's not very obvious :)

vfio_pci_dma_map() and vfio_pci_dma_unmap() both return void right now
and perform internal asserts since all current users of those
functions want to assert success.

If and when we have a use-case to assert that map or unmap fails
(which I think we'll definitely have) we can add __vfio_pci_dma_map()
and __vfio_pci_dma_unmap() variants that return int instead of void.

