Return-Path: <dmaengine+bounces-6001-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C3BB22B60
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 17:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088AA18863E0
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FF627CCEE;
	Tue, 12 Aug 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhsHpA4a"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03029994A
	for <dmaengine@vger.kernel.org>; Tue, 12 Aug 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011094; cv=none; b=birP8ls1fQthXHrLW00Ev8n8GPthbsFn1sYV8Xr8GnAMbx8HQyh384XjhwhU4sS25Tr+5IonKXg/+M/SPJZY6QhaQfhGToUhKSLXYy0rWmq2BTBx5MhCH+fqIy8LyiFbJQt0SrgareEMmPRB0hIGfJcs1zc6dbp13HdFp2X+lcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011094; c=relaxed/simple;
	bh=SsmXH682vJv5gUZsxuvwMPOFJB1jk6im16tEQgXtQj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paSZWO763fWwQUnhUf3mN+D7s1dHWmFnIfSz5okmU9DDe+Ynje/mkQqFG7gPCHo3t5d10VSQXKPmY+5Qon+5iDzSZ3zn/tBoAIhWUMRmzyLEWxXKZVFhwpxhMs/fMsVr6YsNmL/R2lrg7eqep8Xi8hNjMNLtWT7k4Il8ROy8IH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhsHpA4a; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23ffa7b3b30so52218795ad.1
        for <dmaengine@vger.kernel.org>; Tue, 12 Aug 2025 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755011092; x=1755615892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CbZDGjL00dkzJzg2EeaN2XrMVYfOXDa2o/eEp40/hY=;
        b=hhsHpA4arn1oJzCuubxFtQFJbJa59JtQSVb3FB6lieJhsCeXozqpJrhhcDge9F6vVr
         Pk7Oyd6YG7ARaJO6jPKVLfwZarvXFZxaYuUp5CAxt2TI5pp47F1l28XAKisADIZT2pvm
         e172COXDz43By1Fug6h7dg1W0uUaC9odz2XravHkv6FIaQlzUgOdYH/XdUdXDA3DnP+t
         6alrgsvSGk98+MfRIeSZVS0xnLIL1SupivWxCy2xJTOq5npVSOz/GOTANQt98ADd7dS4
         0eDJf80Ko33ixz9qo/VQiLHlLI20acB3Ov8I1dAmzw4YlEsXx15OCk9AXuiOZFYrt+4w
         txoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755011092; x=1755615892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CbZDGjL00dkzJzg2EeaN2XrMVYfOXDa2o/eEp40/hY=;
        b=RM5fnvgfB0h5BpUetr7hwy41ptRBvKoKMSGRa+TfTdAhO0tB/qU7aSzFAR4hEHuq2L
         jvg5zyey6hxmLllPXJlWGl1tetH4w+dgGrMTkeVK6iNut+BINxU0xbh6RDVxVEmBknoO
         3R97My3OxcrK9q9kruXyOLMt9ZojDutv3R6/ur7xIGsVBAkqs5Gkter979Qjq3rbIkss
         vlkd017uUBrM9C8QgbTWrf8sxDrJ8K6jyH46wrvJJYh4i5l5nP9XCfyZdgG6DoJloROZ
         XPVWdzQsQNHNdAfhJnPl68JGy2PB9zF0NmnG4hnJ2hL5vAAH7abruk70WOiTS9xSUnAR
         KYLg==
X-Forwarded-Encrypted: i=1; AJvYcCW/1HC1+R1kbvL6CaUAVV78G8FpAK5a5V9V0NROlVTrPWpcUXC6352IYdp0Am+2N+DHTTXgmbe5TS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgjUygBLFVQmsE4LGcDefvI/rlGD8H9ksJLqkUy8CoiH5ZxQu
	uz5VN9Nw+T4iqGwN9LQZk/chdQ/fg5FhT88x5TaRID1k1QS0EZe3/5EOnS1Cs4vw2g==
X-Gm-Gg: ASbGncsCnW9pQGVeCcc+8eGT354UCR1mXcklUZZwURQ6uHvM1qhXit9UYp8t5r4aIJ9
	hgXXWDwgVEHEBkGITq5KZeSzVYFb/RZtW9Z7k6sdOsEYMOw5J751mtWh0mrtA+AGmV3HO/Q6Tyq
	CDyGJbX7qbqONTiEXWhDe4fLJGnYnCV7jho9gM/mCS6KKfnKfbwxrq3PzB3Cg2Qq7mXH3vGeBJT
	k7pYTu15fc149eqvtdmE9N1NVa3S6lc4Nssi3okHJd5Aqu+G53k7VhQ1HhsEZCM88hfwT8MjFjg
	EE989dn2JiEQfWfNY36hK1Pu+RJTv2z2pv1t5uUjJV37gawg2E3JZhUHeqeKfa1mMtZjsYsEoeo
	FwzytGplAoKUJhlzlCfQrYbeaNNqtMr2zNKwpIi+ekb7Mz5otetoOX7h0Ii4L9sFsM/AE
X-Google-Smtp-Source: AGHT+IGXZwUL5NaeT1agFRHYcvQaoEN8NWmu+JbPXmhoGdaiKVFexo3ojjAG56PQqfSTBJj8vwtFkg==
X-Received: by 2002:a17:903:19c7:b0:240:a222:230c with SMTP id d9443c01a7336-2430bfdac43mr828025ad.12.1755011091106;
        Tue, 12 Aug 2025 08:04:51 -0700 (PDT)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aac2e0sm300710985ad.171.2025.08.12.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 08:04:49 -0700 (PDT)
Date: Tue, 12 Aug 2025 15:04:45 +0000
From: David Matlack <dmatlack@google.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Pratik R. Sampat" <prsampat@amd.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH 00/33] vfio: Introduce selftests for VFIO
Message-ID: <aJtYDWm3kT_Nz6Fd@google.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
 <77qzhwwieggkmyguxm6v7dhpro2ez3nch6qelc2dd5lbdgp6hz@dnbfliagwpnv>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77qzhwwieggkmyguxm6v7dhpro2ez3nch6qelc2dd5lbdgp6hz@dnbfliagwpnv>

On 2025-08-05 05:08 PM, Joel Granados wrote:
> On Fri, Jun 20, 2025 at 11:19:58PM +0000, David Matlack wrote:
> > This series introduces VFIO selftests, located in
> > tools/testing/selftests/vfio/.
> Sorry for coming late to the party. Only recently got some cycles to go
> through this. This seems very similar to what we are trying to do with
> iommutests [3].
> 
> > 
> > VFIO selftests aim to enable kernel developers to write and run tests
> > that take the form of userspace programs that interact with VFIO and
> > IOMMUFD uAPIs. VFIO selftests can be used to write functional tests for
> > new features, regression tests for bugs, and performance tests for
> > optimizations.
> Have you considered implementing something outside the kernel sources?
> Something similar to fstests [1] or blktests [2]?
> 
> I ask because I have always seen it as a suit that tests (regression and
> performance) the Linux kernel as well as the hardware. By hardware I
> mean IOMMU devices, peripherals as well as their QEMU implementations.
> Since the scope is quite big, seemed (to me) like a good idea to keep it
> out of the kernel sources.
> 
> Can you speak to the pros/cons of having it in selftests? (sorry if this
> was already answered)

I talked about this a bit in the RFC cover letter, but did not copy it
over to the v1 cover letter. Relevant excerpts below:

 : We chose selftests to host these tests primarily to enable integration
 : with the existing KVM selftests. As explained in the next section,
 : enabling KVM developers to test the interaction between VFIO and KVM is
 : one of the motivators of this series.
 :
 : [...]
 :
 :  - It enables testing the interaction between VFIO and KVM. There are
 :    some paths in KVM that are only exercised through VFIO, such as IRQ
 :    bypass. VFIO selftests provides a helper library to enable KVM
 :    developers to write KVM selftests to test those interactions [3].
 :
 : [...]
 :
 : To support testing the interactions between VFIO and KVM, the VFIO
 : selftests support sharing its library with the KVM selftest. The patches
 : at the end of this series demonstrate how that works.
 :
 : Essentially, we allow the KVM selftests to build their own copy of
 : tools/testing/selftests/vfio/lib/ and link it into KVM selftests
 : binaries. This requires minimal changes to the KVM selftests Makefile.
 :
 : [3] https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com/

If we had these tests out of tree, then I dn't see a clear path to being
able to test the interaction between VFIO and KVM.

I am also probably biased/influenced coming from KVM development, where
we use KVM selftests. I have found it very valuable as a developer to be
able to send code changes along with the tests for those changes in a
single series, without having to work across multiple repositories. And
I am very used to that workflow.

Lastly, since the goal of my series is only to enable testing the kernel
(VFIO, IOMMUFD, KVM, IOMMU drivers, etc.), co-locating with the kernel
makes sense. I was not looking test hardware or emulators for
correctness.

I do see that there is a lot of overlap between testing the kernel and
testing hardware/emulators, and that there's likely code we can share.
But I also want to be practical and make sure we solve the problem of
testing the kernel.

> 
> > 
> > These tests are designed to interact with real PCI devices, i.e. they do
> > not rely on mocking out or faking any behavior in the kernel. This
> > allows the tests to exercise not only VFIO but also IOMMUFD, the IOMMU
> > driver, interrupt remapping, IRQ handling, etc.
> And depending on how you execute them, you might also be exercising the
> QEMU emulation paths. You could even test different HW firmwares if you
> wanted to :)

That's true, but not a problem I'm looking to solve (testing hardware or
testing QEMU). My only goal is testing the kernel.

> 
> > 
> > For more background on the motivation and design of this series, please
> > see the RFC:
> > 
> >   https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.com/
> > 
> > This series can also be found on GitHub:
> > 
> >   https://github.com/dmatlack/linux/tree/vfio/selftests/v1
> > 
> ...
> > Instructions
> > -----------------------------------------------------------------------
> > 
> > Running VFIO selftests requires at a PCI device bound to vfio-pci for
> > the tests to use. The address of this device is passed to the test as
> > a segment:bus:device.function string, which must match the path to
> > the device in /sys/bus/pci/devices/ (e.g. 0000:00:04.0).
> Would you be able to autodetect the devices that are vfio-testable?
> I saw this question in the thread, but did not see the answer (sorry
> if I missed it).

Eventually I think that could be possible. But for now it is up to the
user to deide which devices to use.

> 
> > 
> > Once you have chosen a device, there is a helper script provided to
> > unbind the device from its current driver, bind it to vfio-pci, export
> > the environment variable $VFIO_SELFTESTS_BDF, and launch a shell:
> If I'm reading the series correctly there is a fair amount of helper
> code needed: device (un)binding, checking capabilities, setting up
> DMAable memory.... Have you considered a library like libvfn [4] (is
> there any other?) to take care of all this?

I didn't consider using an external library since it seemed like there
would be several downsides, and the amount of helper code here was quite
small IMO:

 .../selftests/vfio/lib/include/vfio_util.h    | 295 +++++++++
 .../selftests/vfio/lib/vfio_pci_device.c      | 594 ++++++++++++++++++
 .../selftests/vfio/lib/vfio_pci_driver.c      | 126 ++++
 tools/testing/selftests/vfio/run.sh           | 109 ++++

My concerns with using an external helper library are:

 - It will make writing tests more difficult because it will require
   making changes both to the external library and to selftests. This
   means dealing with 2 different repositories, 2 different code review
   processes, 2 different maintaineres, etc. Not to mention needing to
   first change the library before writing the test.

   The harder it is to write tests, the less tests will be written IMO.

 - It will make maintaining VFIO selftests more difficult as we have to
   maintain compatability with the library and deal with breaking
   changes (or never make breaking changes to the library, which makes
   it harder to maintain and extend).

   Contrast this to having the helper code co-located with the tests we
   can make whatever changes we want as needed and keep things as simple
   as possible.

It can be good to avoid duplicate code across projects, but in this case
it doesn't seem like it enhances our ability to test the kernel or
solves any specific problem.

One place where libvfn could make sense is if someone wants to support
running VFIO selftests that require a driver with NVMe devices.
Implementing that driver with the help of libvfn may be simpler than
implementing one from scratch. But I think we should cross that bridge
when we get there and compare the 2 approaches. The VFIO selftests
driver API is pretty simple so implementing an NVMe driver in VFIO
selftests might still be the simpler option.

> 
> One of the good things about having all this in a library is that it can
> be used in other contexts besides testing.

True but if it comes at the cost of making VFIO tests harder to write and
maintain, I don't think it's necessarily a good idea.

> 
> > 
> >   $ tools/testing/selftests/vfio/run.sh -d 0000:00:04.0 -s
> > 
> > The -d option tells the script which device to use and the -s option
> > tells the script to launch a shell.
> > 
> > Additionally, the VFIO selftest vfio_dma_mapping_test has test cases
> > that rely on HugeTLB pages being available, otherwise they are skipped.
> > To enable those tests make sure at least 1 2MB and 1 1GB HugeTLB pages
> > are available.
> > 
> >   $ echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> >   $ echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> Should this be automatic? You can just modify nr_hugepages everytime you
> execute a test that requires it.

Yeah I think we could probably do this automatically. As you can
probably tell, I left most of the environment setup to the user for now
but a lot of this can be automated in the seltests themselves.

> 
> > 
> > To run all VFIO selftests using make:
> > 
> >   $ make -C tools/testing/selftests/vfio run_tests
> This ties back to having the test suit outside the Linux Kernel sources.
> I might not always want/have a Linux Kernel selftests. Like if I would
> want to test the Intel/AMD IOMMU implementation in QEMU.

Agreed, but the goal of this series is not to test the correctness of
QEMU or hardware. It's to enable testing the kernel code.

If you want to test the correctness of QEMU, testing from the
VFIO/userspace level might not be the right approach anyway. You
probably want to be able to interact directly with the IOMMU registers,
interrupt handlers, etc. e.g. Something like intel-iommu.c in
kvm-unit-tests[*], combined with higher-level application testing.

VFIO selftests would be kind of a weird middle-ground where you can't
actually control the interactions with the hardware/QEMU, (since the
test is running in userspace and going through the kernel), and at the
same time it's not a realistic application.

[*] https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/master/x86/intel-iommu.c

> 
> > 
> > To run individual tests:
> > 
> >   $ tools/testing/selftests/vfio/vfio_dma_mapping_test
> >   $ tools/testing/selftests/vfio/vfio_dma_mapping_test -v iommufd_anonymous_hugetlb_2mb
> >   $ tools/testing/selftests/vfio/vfio_dma_mapping_test -r vfio_dma_mapping_test.iommufd_anonymous_hugetlb_2mb.dma_map_unmap
> > 
> > The environment variable $VFIO_SELFTESTS_BDF can be overridden for a
> > specific test by passing in the BDF on the command line as the last
> > positional argument.
> > 
> >   $ tools/testing/selftests/vfio/vfio_dma_mapping_test 0000:00:04.0
> >   $ tools/testing/selftests/vfio/vfio_dma_mapping_test -v iommufd_anonymous_hugetlb_2mb 0000:00:04.0
> >   $ tools/testing/selftests/vfio/vfio_dma_mapping_test -r vfio_dma_mapping_test.iommufd_anonymous_hugetlb_2mb.dma_map_unmap 0000:00:04.0
> > 
> > When you are done, free the HugeTLB pages and exit the shell started by
> > run.sh. Exiting the shell will cause the device to be unbound from
> > vfio-pci and bound back to its original driver.
> > 
> >   $ echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> >   $ echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> >   $ exit
> As before: Can this be done automatically?

Yeah, most likely this can be done automatically.

> 
> > 
> > It's also possible to use run.sh to run just a single test hermetically,
> > rather than dropping into a shell:
> > 
> >   $ tools/testing/selftests/vfio/run.sh -d 0000:00:04.0 -- tools/testing/selftests/vfio/vfio_dma_mapping_test -v iommufd_anonymous
> > 
> > Tests
> > -----------------------------------------------------------------------
> > 
> > There are 5 tests in this series, mostly to demonstrate as a
> > proof-of-concept:
> > 
> >  - tools/testing/selftests/vfio/vfio_pci_device_test.c
> >  - tools/testing/selftests/vfio/vfio_pci_driver_test.c
> >  - tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
> >  - tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> >  - tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
> > 
> > Future Areas of Development
> > -----------------------------------------------------------------------
> > 
> > Library:
> > 
> >  - Driver support for devices that can be used on AMD, ARM, and other
> >    platforms (e.g. mlx5).
> >  - Driver support for a device available in QEMU VMs (e.g.
> >    pcie-ats-testdev [1])
> >  - Support for tests that use multiple devices.
> >  - Support for IOMMU groups with multiple devices.
> >  - Support for multiple devices sharing the same container/iommufd.
> >  - Sharing TEST_ASSERT() macros and other common code between KVM
> >    and VFIO selftests.
> Same as before: How about a lib?

That is how I plan to approach it. Just like
tools/testing/selftests/vfio/lib can be shared with KVM selftests, we
can create a selftests library for this common stuff and share it
between VFIO and KVM.

But if you are referring to an external library that is outside of the
kernel tree, see my comments above.

> 
> > 
> > Tests:
> > 
> >  - DMA mapping performance tests for BARs/HugeTLB/etc.
> >  - Porting tests from
> >    https://github.com/awilliam/tests/commits/for-clg/ to selftests.
> >  - Live Update selftests.
> >  - Porting Sean's KVM selftest for posted interrupts to use the VFIO
> >    selftests library [2]
> > 
> ...
> > 
> > base-commit: e271ed52b344ac02d4581286961d0c40acc54c03
> > prerequisite-patch-id: c1decca4653262d3d2451e6fd4422ebff9c0b589
> > -- 
> > 2.50.0.rc2.701.gf1e915cc24-goog
> > 
> 
> Best

Thanks for taking a look!

> 
> [1] https://github.com/kdave/xfstests
> [2] https://github.com/linux-blktests/blktests
> [3] https://github.com/SamsungDS/iommutests
> [4] https://github.com/SamsungDS/libvfn
> 
> -- 
> 
> Joel Granados



