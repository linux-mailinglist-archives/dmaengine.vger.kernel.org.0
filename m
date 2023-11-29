Return-Path: <dmaengine+bounces-304-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240D07FCEFF
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 07:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13572820E3
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 06:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E1B101C6;
	Wed, 29 Nov 2023 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ENCvaz6v"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BFB19B9
	for <dmaengine@vger.kernel.org>; Tue, 28 Nov 2023 22:20:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ccf44b0423so85157587b3.0
        for <dmaengine@vger.kernel.org>; Tue, 28 Nov 2023 22:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701238837; x=1701843637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+OWUPjfBbVNUCejaH4Zx1SnJx7h3HvWotJzN/ystxs=;
        b=ENCvaz6vmKNnpN8JeDyj6KRrvSaIk2zih68iHw/7QpW8wY5/hVioYV3uQIIMT5hUmT
         dFZLSPLb929WaerrePedmOLu+a5YRG9HiUs2HK73KrAcIOx5fiJjTdBm2K92HGLb4nTC
         jI8IKALxKvLGwZkJwkygbMMn/Cya1eQLuGDMjNMvGiUcow1oFxMh+FapPlxbYIEcG/J+
         FlRCunM1Da2RultEQHFwWJmfWlJrcfTJ7zh1ftWpZ07xG1V1naxHa/13Rwi0g81BUCf2
         3Z9yAKpOCiaxC95RmOWOy8A/sidsNkfeYHXa8S2RgU3j0pouov8h+7QWu/fCirG9c5gI
         M1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701238837; x=1701843637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+OWUPjfBbVNUCejaH4Zx1SnJx7h3HvWotJzN/ystxs=;
        b=S5VGN1MDlyp3vvRabkvMhGStV7BQ9Ovl3c4DLJBCLwhVSjjS44H+oCDQB2xwkZ0RfV
         /dhXE5r+qR31hUeWEMZ1mXeDQMuEQ7TZpAoxFVul27Ib4onYdm95BP/cKO+mHVgvOgzF
         7OXI0wHY/ya1e6I7eXzTl0//KpMDTaK/ljAjpVlcOPM0p+oYTjJiCwRf12fakfCyv3TW
         1VuxtLvB737p9PL2kLjKy1Qb3wRtQjpXxH80gadxfVONBQypkEwBONyUIMTG3Y2IRnxZ
         8X8MiDsSE05bdzo5GUAgfy0jqYYcVtHR7J4ILhW1ZtHWzmv/cRKNJQMIei+z//K2ZPnS
         4pUA==
X-Gm-Message-State: AOJu0YxK2dsLSZabfxoTGxjq2ayR/8+iNRDubz5U/nS6ZVeA+Upilos3
	GfLNN7PrCPH+4gYF0X9jL56ia7ML6yAK
X-Google-Smtp-Source: AGHT+IGl2m8o4vcxyKfaevYjBuf0ZzzfYYiBjYjYyoamKSyXXxyRdZkkwSrexsSNRUrkDVXuH7e+Nb5/Bf9p
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a05:690c:4041:b0:5ce:550:685b with SMTP id
 ga1-20020a05690c404100b005ce0550685bmr480488ywb.5.1701238836860; Tue, 28 Nov
 2023 22:20:36 -0800 (PST)
Date: Wed, 29 Nov 2023 06:20:36 +0000
In-Reply-To: <10-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com> <10-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Message-ID: <20231129062036.urdezihvds2pkuyo@google.com>
Subject: Re: [PATCH 10/10] ACPI: IORT: Allow COMPILE_TEST of IORT
From: Moritz Fischer <moritzf@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich <dakr@redhat.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev, 
	Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Karol Herbst <kherbst@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Laxman Dewangan <ldewangan@nvidia.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, nouveau@lists.freedesktop.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>, 
	Jerry Snitselaar <jsnitsel@redhat.com>, Hector Martin <marcan@marcan.st>, Moritz Fischer <mdf@kernel.org>, 
	patches@lists.linux.dev, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

On Tue, Nov 28, 2023 at 08:48:06PM -0400, Jason Gunthorpe wrote:
> The arm-smmu driver can COMPILE_TEST on x86, so expand this to also
> enable the IORT code so it can be COMPILE_TEST'd too.

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/acpi/Kconfig        | 2 --
>   drivers/acpi/Makefile       | 2 +-
>   drivers/acpi/arm64/Kconfig  | 1 +
>   drivers/acpi/arm64/Makefile | 2 +-
>   drivers/iommu/Kconfig       | 1 +
>   5 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f819e760ff195a..3b7f77b227d13a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -541,9 +541,7 @@ config ACPI_PFRUT
>   	  To compile the drivers as modules, choose M here:
>   	  the modules will be called pfr_update and pfr_telemetry.

> -if ARM64
>   source "drivers/acpi/arm64/Kconfig"
> -endif

>   config ACPI_PPTT
>   	bool
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index eaa09bf52f1760..4e77ae37b80726 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -127,7 +127,7 @@ obj-y				+= pmic/
>   video-objs			+= acpi_video.o video_detect.o
>   obj-y				+= dptf/

> -obj-$(CONFIG_ARM64)		+= arm64/
> +obj-y				+= arm64/

>   obj-$(CONFIG_ACPI_VIOT)		+= viot.o

> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c1e..537d49d8ace69e 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -11,6 +11,7 @@ config ACPI_GTDT

>   config ACPI_AGDI
>   	bool "Arm Generic Diagnostic Dump and Reset Device Interface"
> +	depends on ARM64
>   	depends on ARM_SDE_INTERFACE
>   	help
>   	  Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a9d..71d0e635599390 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>   obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>   obj-$(CONFIG_ARM_AMBA)		+= amba.o
> -obj-y				+= dma.o init.o
> +obj-$(CONFIG_ARM64)		+= dma.o init.o
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 7673bb82945b6c..309378e76a9bc9 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -318,6 +318,7 @@ config ARM_SMMU
>   	select IOMMU_API
>   	select IOMMU_IO_PGTABLE_LPAE
>   	select ARM_DMA_USE_IOMMU if ARM
> +	select ACPI_IORT if ACPI
>   	help
>   	  Support for implementations of the ARM System MMU architecture
>   	  versions 1 and 2.
> --
> 2.42.0


Reviewed-by: Moritz Fischer <moritzf@google.com>

Ok, now the previous patch makes sense :)

Cheers,
Moritz

