Return-Path: <dmaengine+bounces-5231-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA730ABF28E
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 13:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CAB7AF4AD
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 11:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312B0262D29;
	Wed, 21 May 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqw0+kBj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A72609FE;
	Wed, 21 May 2025 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826265; cv=none; b=DOHagfIGT+NSk+YfauabRbuAWfECu+JjIhoRB6voVQpzxjcLRXdrNshM90690U7tBfIontzona9h4PBfK21ukJLoWA86KlJOmHOk98ozOOnNL3+KOy554fR3SfYSmcfINhgFntP2bFgJ1kGz5LhnuLbk+0mOZBqilk7r8Ad2qQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826265; c=relaxed/simple;
	bh=MiwdktZ5f5YKd7FbzlaIFr4jwWcS+0VpO3wKCcsxpBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwoO1cSgRdkNoUHQkSw1R57AAyIJ6YNZAbp9FlC6QvUgcNXCy/AxbJ4mI5LrOh2jPcYl1QduVyiocB7wOv5rwpyIzJ1E8T6Id0KiGVbh3Agj1qCiEGvvIyTGhnLLJLiij5Evp5Vfk9je11MJqFRB6qdJM1i3PT1bb0ZxugCOrz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqw0+kBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA404C4CEE4;
	Wed, 21 May 2025 11:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747826263;
	bh=MiwdktZ5f5YKd7FbzlaIFr4jwWcS+0VpO3wKCcsxpBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rqw0+kBj2NvSeSXwlnQaBbh5i7y8KAMVsD3jVprvgP1l4/OxDWhnjRSD8B+7AQdLn
	 SUGpIwwBQx4LFEeDIK7frGlJu7QFLPK7AaOlaPts5xYzzumLtNOCFo62JI0oRmFcmk
	 a/2qbxvXhvBG8DNn2nUP6aS2hNJ0N/cpEp8NIwVki3IzNGerFC7hRR6hkOvc7HlmXY
	 iV5l4p4ZtkH3w+hC0VJnzDjWDBX2zasfPZg+S8qne3dvGorzm0M+VCS/Mg2r4F5laH
	 4AE7Rk/NlgdRlpzwHX01KlPR0hJ8RKTC+jBiEdQyzYAmIVpwRhWzokQOoQgpWXXb7K
	 X5Xlo+vg1kwsA==
Date: Wed, 21 May 2025 14:17:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: vkoul@kernel.org, chenxiang66@hisilicon.com, m.szyprowski@samsung.com,
	robin.murphy@arm.com, jgg@nvidia.com, alex.williamson@redhat.com,
	joel.granados@kernel.org, iommu@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH 0/6] dma: fake-dma and IOVA tests
Message-ID: <20250521111738.GL7435@unreal>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520223913.3407136-1-mcgrof@kernel.org>

On Tue, May 20, 2025 at 03:39:07PM -0700, Luis Chamberlain wrote:
> We don't seem to have unit tests for the DMA IOVA API, so I figured
> we should add some so to ensure we don't regress moving forward, and it allows
> us to extend these later. Its best to just extend existing tests though. I've
> found two tests so I've extended them as part of this patchset:
> 
>   - drivers/dma/dmatest.c
>   - kernel/dma/map_benchmark.c
> 
> However running the dmatest requires some old x86 emulation or some
> non-upstream qemu patches for intel IOAT a q35 system. This make this
> easier by providing a simple in-kernel fake-dma controller to let you test
> run all dmatests on most systems. The only issue I found with that was not
> being able to get the platform device through an IOMMU for DMA. If folks have
> an idea of how to make it easy for a platform device to get an IOMMU for DMA
> it would make it easier to allow us to leverage the existing dmatest for
> IOVA as well. I only tried briefly with virtio and vfio_iommu_type1, but gave
> up fast. Not sure if its easy to later allow a platform device like this
> one to leverage it to make it easier for testing.

I'm not sure if this is what you meant, but I'm configuring QEMU in nested VM
mode. It gives me emulated hypervisor with working IOMMU path, which I
tested with NVMe and RDMA.

My QEMU command line is:
/usr/bin/qemu-system-x86_64 -append root=/dev/root rw \
	ignore_loglevel rootfstype=9p rootflags="cache=loose,trans=virtio" \
	earlyprintk=serial,ttyS0,115200 console=hvc0 panic_on_warn=1 intel_iommu=on \
	iommu=nopt iommu.forcedac=1 vfio_iommu_type1.allow_unsafe_interrupts=1 \
	systemd.hostname=mtl-leonro-d-vm \
	-chardev stdio,id=stdio,mux=on,signal=off \
	-cpu host \
	-device virtio-rng-pci \
	-device virtio-balloon-pci \
	-device isa-serial,chardev=stdio \
	-device virtio-serial-pci \
	-device virtconsole,chardev=stdio \
	-device virtio-9p-pci,fsdev=host_fs,mount_tag=/dev/root \
	-device virtio-9p-pci,fsdev=host_bind_fs0,mount_tag=bind0 \
	-device virtio-9p-pci,fsdev=host_bind_fs1,mount_tag=bind1 \
	-device virtio-9p-pci,fsdev=host_bind_fs2,mount_tag=bind2 \
	-device intel-iommu,intremap=on \
	-device nvme-subsys,id=bar \
	-device nvme,id=baz,subsys=bar,serial=qux \
	-device nvme-ns,drive=foo,bus=baz,logical_block_size=4096,physical_block_size=4096,ms=16 \
	-drive file=/home/leonro/.cache/mellanox/mkt/nvme-1g.raw,format=raw,if=none,id=foo \
	-enable-kvm \
	-fsdev local,id=host_bind_fs2,security_model=none,path=/home/leonro \
	-fsdev local,id=host_bind_fs0,security_model=none,path=/plugins \
	-fsdev local,id=host_fs,security_model=none,path=/mnt/self \
	-fsdev local,id=host_bind_fs1,security_model=none,path=/logs \
	-fw_cfg etc/sercon-port,string=2 \
	-kernel /home/leonro/src/kernel/arch/x86/boot/bzImage \
	-m 4G \
	-machine q35,kernel-irqchip=split \
	-mon chardev=stdio \
	-net nic,model=virtio,macaddr=52:54:9a:c5:60:66 \
	-net user,hostfwd=tcp:127.0.0.1:54409-:22 \
	-no-reboot \
	-nodefaults \
	-nographic \
	-smp 64 \
	-vga none%     

> 
> The kernel/dma/map_benchmark.c test is extended as well, for that I was
> able to add follow the instructions on the first commit from that test,
> by unbinding a device and attaching it to the map benchmark.
> 
> I tried twiddle a mocked IOMMU with iommufd on a q35 guest, but alas,
> that just didn't work as I'd hope, ie, nothing, and so this is the best
> I have for now to help test IOVA DMA API on a virtualized setup.
> 
> Let me know if others have other recomendations.
> 
> The hope is to get a CI eventually going to ensure these don't regress.
> 
> Luis Chamberlain (6):
>   fake-dma: add fake dma engine driver
>   dmatest: split dmatest_func() into helpers
>   dmatest: move printing to its own routine
>   dmatest: add IOVA tests
>   dma-mapping: benchmark: move validation parameters into a helper
>   dma-mapping: benchmark: add IOVA support
> 
>  drivers/dma/Kconfig                           |  11 +
>  drivers/dma/Makefile                          |   1 +
>  drivers/dma/dmatest.c                         | 795 ++++++++++++------
>  drivers/dma/fake-dma.c                        | 718 ++++++++++++++++
>  include/linux/map_benchmark.h                 |  11 +
>  kernel/dma/Kconfig                            |   4 +-
>  kernel/dma/map_benchmark.c                    | 512 +++++++++--
>  .../testing/selftests/dma/dma_map_benchmark.c | 145 +++-
>  8 files changed, 1864 insertions(+), 333 deletions(-)
>  create mode 100644 drivers/dma/fake-dma.c
> 
> -- 
> 2.47.2
> 
> 

