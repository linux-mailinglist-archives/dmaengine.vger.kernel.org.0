Return-Path: <dmaengine+bounces-6229-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B40B389E9
	for <lists+dmaengine@lfdr.de>; Wed, 27 Aug 2025 20:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D2F57B603D
	for <lists+dmaengine@lfdr.de>; Wed, 27 Aug 2025 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A611DFE0B;
	Wed, 27 Aug 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTW2AhUM"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DE2DEA7D
	for <dmaengine@vger.kernel.org>; Wed, 27 Aug 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320943; cv=none; b=SnVb6c/xmSr90v9mJdlv9qp0NWO/Cp8n0z9Hw+ONAHmsuMSvCDKv3Sh14NlTG5pZ4AmaceHAnnanrA9MwQYNsdmGzZnaiMYg8pzA2+cHj32zkt+lbWbjrRvDcTMdYbIDNoowWDk8/p7c5FI3+vRw0naVbH6+50VCK+bCV8OJLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320943; c=relaxed/simple;
	bh=tQA9/Ach0BZRCqEuu6uOpIqPBwzD/W6GlLUH0sTqYxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5iu177biax69mvKBe3ocNcSbzRdTshz/1vsGBkgvYmIobsDJn1Yan1kBcPNCcsuS4Y5fmP8x8Z3wWeUwoJ7Od78LCcJYMiJ9PIPaUqoW1vRo714yjIiecIMvj1BVYj2MZVMOl1MxdERYVLmsVcbmAXdtPaiHfedlKNeDP7ZhVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTW2AhUM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756320941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HjWNr8OnKkSSzWz+TsTIEe/Fd8VZeWw89vd0AMdn6Q=;
	b=VTW2AhUMPdbdNVBd5JPTu3Lnz/2reVgOr8EER8ZTWMRI5IceMdCKZzdnuWluqom7sdntUl
	0O9DisR7U2tHP5kewYv8jv3nRU6tEQjUtC/NZkcjJ4HG2E4gThTz1n4VWammywp1zkW0kX
	RK2NVsNu8pZJD/CE+4Ffr2VA2d94GHw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-3pFbGqzJPFuFZCoQGX2AVA-1; Wed, 27 Aug 2025 14:55:40 -0400
X-MC-Unique: 3pFbGqzJPFuFZCoQGX2AVA-1
X-Mimecast-MFC-AGG-ID: 3pFbGqzJPFuFZCoQGX2AVA_1756320938
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f08c081ba7so414765ab.0
        for <dmaengine@vger.kernel.org>; Wed, 27 Aug 2025 11:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756320938; x=1756925738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HjWNr8OnKkSSzWz+TsTIEe/Fd8VZeWw89vd0AMdn6Q=;
        b=kT9PDaXhaOh9m5CyM3cYNnCozytoTpx/o+Ls/Jqnv9T9J2UqL1/Ql4qEBmYwFUf43v
         GDfLi2quyGylP9kHBSkwx212rcQpPbEjlXHmsN8okkcVQZyEgwerK2QoJFv84oIucDGt
         CIhKH15GAKLlWrLQN/DsIJNFkZ505KErLQT4MwZQuSMwOJ/1AraUzn3mGm4KLNNVbQ19
         KKMhkpTwKulTdUz2e2Qyi5lh7Qp8IqlzCb82hgglov4tIeCjImRxLrLVlVzobQSjTqg7
         O3+hGqiAcUEjAqowGQz9g7tIO5T/+r0sd0ENGszCcyzC/rQfobI2OKsu4b4MSyF3BqWl
         jINA==
X-Forwarded-Encrypted: i=1; AJvYcCWg+3mcNoIE+BAnkJQiN4e7DdWO0ky08L9xdOE620GOrifduiUvu8f18/rmVO5Wo/AjP0518/Msock=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjyfvRbo5iSS3uZGfXvXmXQ7oIz/rE7aeflXW70YkUgJMRvM9
	9Zn0hItey6+zBv1FSMzb5+d7Vkdv72AYZTIelNOqbCcnV6Xb88GscSj7iDH2mgx4CKD+NJ1tfjk
	HYUvI6TaTVsX1mnGIvc3+NI+zvP8B5zXm7Jyq6s42ZS1/kma3OyWZqyuIsPJPjQ==
X-Gm-Gg: ASbGnctNmq0qRfORARAL2FY0djHo3xktIdroYJmbgjYss69UR8ZFiZrnL9M+ahUyshc
	gDHF2FYq08rD2DLcRFtVUZ7gHpPqEmaU0YWNFkk4NOXjR2Cuni2LZhbbV+X7I923QryjvL6xb2F
	UPCOxmfGPToxENLplAS5Zwtrl+RaOvsKzreViPzS7fH4KBpyLhVPWS963Z05ZOh/JYzw7unikcd
	tr4ZzcXY4WtZM3nmmtR3KIG7uMY30/RuxX9vx52RAaKIt/DHZRanMtpbHfqeMBTW9c0BgWyZMkI
	mEjKh4yuDdEU0S3Aj+A4mCRCmZKpPjtXZuPUIOiK8xA=
X-Received: by 2002:a05:6602:1649:b0:87c:ad2:cf44 with SMTP id ca18e2360f4ac-886bcfc9cfemr1107603839f.0.1756320938327;
        Wed, 27 Aug 2025 11:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGetQJuhhaIdZfy3mNvP8MjC+gfptY8oPY0KXYHB4yZ91tShcG4h8WoDVsCHp6QjTOyzjdXsg==
X-Received: by 2002:a05:6602:1649:b0:87c:ad2:cf44 with SMTP id ca18e2360f4ac-886bcfc9cfemr1107601439f.0.1756320937888;
        Wed, 27 Aug 2025 11:55:37 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8ef4c42sm874836039f.4.2025.08.27.11.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:55:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:55:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Matlack <dmatlack@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Dan
 Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 dmaengine@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, Joel Granados
 <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma
 <vipinsh@google.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH v2 00/30] vfio: Introduce selftests for VFIO
Message-ID: <20250827125533.2fdffc7c.alex.williamson@redhat.com>
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 21:24:47 +0000
David Matlack <dmatlack@google.com> wrote:

> This series introduces VFIO selftests, located in
> tools/testing/selftests/vfio/.
> 
> VFIO selftests aim to enable kernel developers to write and run tests
> that take the form of userspace programs that interact with VFIO and
> IOMMUFD uAPIs. VFIO selftests can be used to write functional tests for
> new features, regression tests for bugs, and performance tests for
> optimizations.
> 
> These tests are designed to interact with real PCI devices, i.e. they do
> not rely on mocking out or faking any behavior in the kernel. This
> allows the tests to exercise not only VFIO but also IOMMUFD, the IOMMU
> driver, interrupt remapping, IRQ handling, etc.
> 
> For more background on the motivation and design of this series, please
> see the RFC:
> 
>   https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.com/
> 
> This series can also be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/vfio/selftests/v2

Applied to vfio next branch for v6.18.  I've got a system with
compatible ioatdma hardware, so I'll start incorporating this into my
regular testing and hopefully convert some unit tests as well.  Thanks,

Alex


