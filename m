Return-Path: <dmaengine+bounces-3791-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06D59D8A50
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7016B2B934
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3F81AF0DC;
	Mon, 25 Nov 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFQxbsXK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB362AD25;
	Mon, 25 Nov 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551837; cv=none; b=ApGQNP/BimZphBzHOaOssM7ZXl0ZgT30a7ZUB91s5hF5MRu0C8XwBCvTi50c26RMb43S7XhfvLpNOhaU0cIK7s2uRntM7WydOkS9NoKOn4ue6s5DWjskrNnX4AA7g+eRMiRMrXk9trgTVB/aOQ/tUT+8D4NzJ9SLoY2fKm8n6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551837; c=relaxed/simple;
	bh=GUQfgpAXeziJyVc0BBmJJPh2ZiKlviBhiYwLQbTcq+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgLAxvcgXwlEXNxRU5pc3SsY1TL5JLw7+ud9Y5gpuO2XHBxRgvw3mwQUSNNQPhqZlAdIHZ57XT6NUa87iaEScI5n6U6VLXpsRECUeMn6t9E3UZvIKk801+jSL2pw+AGvdyUpq+ySnkkFjF/xEn5h7Z2D22d/pS2huavEQCsEdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFQxbsXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0D3C4CECE;
	Mon, 25 Nov 2024 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732551837;
	bh=GUQfgpAXeziJyVc0BBmJJPh2ZiKlviBhiYwLQbTcq+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFQxbsXK+pkR/3qzEDnhH+sb2bm6VvVLfwQLY6MKqvMdf9teT/gJO2HWZ63kqMCqn
	 LI4fRbSMs3L2NeBL39LQY0krgJ0FnYhxoIfrt6XkRbN09xwZee83uuBubh6m723ydT
	 d6zK9fU5AGoFTjU8/p/PSIrtltHq8pRMigDYs9W+r8OEqt95ClQXAQXsytZhsgOfO5
	 dgJW3hUDM54pRR8wLhmohZriXcxhEudHE3MOY5fiuNlqYWIbHPxttNGkPVqYkmwHas
	 i03WRf0QaghK50JTcvt/Iv82YYcm7M6+vtJ2hZ1h9nsej+BGEihxcHV5k9yS3RzfoC
	 oIN/+FSOIaBzw==
Date: Mon, 25 Nov 2024 09:23:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>, dmaengine@vger.kernel.org,
	lkft-triage@lists.linaro.org, peter.ujfalusi@gmail.com,
	Vinod Koul <vkoul@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, kees@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: korg-clang-19-lkftconfig-hardening: TI x15 board - PC is at
 edma_probe (drivers/dma/ti/edma.c
Message-ID: <20241125162354.GD2067874@thelio-3990X>
References: <CA+G9fYuaWJYQcxQ=3UqQbbuD_YNdOS_KB46N=mh47rxE049f-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuaWJYQcxQ=3UqQbbuD_YNdOS_KB46N=mh47rxE049f-Q@mail.gmail.com>

Hi Naresh,

+ Kees and linux-hardening, since this is a hardening configuration.

On Mon, Nov 25, 2024 at 07:34:22PM +0530, Naresh Kamboju wrote:
> The arm TI x15 board boot has failed with the Linux next, mainline
> and the Linux stable. Please find boot log and build links.
> 
> The boot failed with clang tool chain and PASS with gcc-13.
> 
> Device: TI x15 device
> Boot pass: gcc-13

Are the UBSAN options getting enabled with GCC as well? I am somewhat
surprised that they are not agreeing here, unless this is a __counted_by
related issue? Does this not happen with GCC 14 as well? It would be
nice if we could get a copy of GCC 15 with __counted_by into TuxMake for
validation of __counted_by between the two compilers easily. I did not
see any obvious instances of __counted_by in edma_probe() but
admittedly, I did not look too hard.

> Boot failed: clang-19
> Configs: korg-clang-19-lkftconfig-hardening
> Boot pass: qemu-armv7 (Additional info)
> 
> This is always reproducible.
> 
> x15 beagleboard:
>   boot:
>     * clang-nightly-lkftconfig-hardening
>     * korg-clang-19-lkftconfig-hardening
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Log details:
> ------------
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.12.0 (tuxmake@tuxmake) (ClangBuiltLinux
> clang version 19.1.4 (https://github.com/llvm/llvm-project.git
> aadaa00de76ed0c4987b97450dd638f63a385bed), ClangBuiltLinux LLD 19.1.4
> (https://github.com/llvm/llvm-project.git
> aadaa00de76ed0c4987b97450dd638f63a385bed)) #1 SMP @1732428891
> [    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=30c5387d
> <>
> [    3.543395] pcieport 0000:00:00.0: PME: Signaling with IRQ 136
> [    3.556976] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM

Can you turn off UBSAN_TRAP and see if that gives us any indication as
to where exactly UBSAN_BOUNDS is triggering here? It is not entirely
clear because we do not seem to have a line number in edma.c from
decoding the stacktrace.

> [    3.563720] Modules linked in:
> [    3.566802] CPU: 1 UID: 0 PID: 41 Comm: kworker/u10:2 Not tainted 6.12.0 #1
> [    3.573822] Hardware name: Generic DRA74X (Flattened Device Tree)
> [    3.579956] Workqueue: events_unbound deferred_probe_work_func
> [    3.585815] PC is at edma_probe (drivers/dma/ti/edma.c:0)
> [    3.590026] LR is at devm_kmalloc (drivers/base/devres.c:839)
> [    3.594329] pc : lr : psr: 60000013
> [    3.600616] sp : f00f5938  ip : 00070007  fp : efcd8728
> [    3.605865] r10: c3cd2c10  r9 : c3c17a40  r8 : c3cd2c00
> [    3.611145] r7 : 00000002  r6 : 00000000  r5 : 00000003  r4 : 00000001
> [    3.617706] r3 : 00000001  r2 : 00000002  r1 : 00000002  r0 : c3ba8340
> [    3.624267] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [    3.631439] Control: 30c5387d  Table: 80203000  DAC: 55555555
> [    3.637207] Register r0 information: slab kmalloc-rnd-01-128 start
> c3ba8300 pointer offset 64 size 128
> [    3.646575] Register r1 information: non-paged memory
> [    3.651672] Register r2 information: non-paged memory
> [    3.656768] Register r3 information: non-paged memory
> [    3.661834] Register r4 information: non-paged memory
> [    3.666931] Register r5 information: non-paged memory
> [    3.671997] Register r6 information: NULL pointer
> [    3.676727] Register r7 information: non-paged memory
> [    3.681823] Register r8 information: slab kmalloc-rnd-06-1k start
> c3cd2c00 pointer offset 0 size 1024
> [    3.691101] Register r9 information: slab kmalloc-rnd-14-512 start
> c3c17a00 pointer offset 64 size 512
> [    3.700469] Register r10 information: slab kmalloc-rnd-06-1k start
> c3cd2c00 pointer offset 16 size 1024
> [    3.709960] Register r11 information: non-slab/vmalloc memory
> [    3.715728] Register r12 information: non-paged memory
> [    3.720886] Process kworker/u10:2 (pid: 41, stack limit = 0x0678741b)
> [    3.727386] Stack: (0xf00f5938 to 0xf00f6000)
> [    3.731750] 5920:
>     00000001 c132a2a0
> [    3.739990] 5940: c3cd2c10 c23d2304 c23d2304 efcd8728 00000001
> c3d10fc0 c290fabc 00000000
> [    3.748199] 5960: 00000001 00000000 c24d4c98 c1326cd4 c1d88d7d
> c1d251f2 efcd8728 3f45655f
> [    3.756408] 5980: c24d4c98 fc8f9ed5 f00f5a98 c1327924 ffffffff
> c06fa4e0 00000000 00000000
> [    3.764648] 59a0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 42aa2a98
> [    3.772857] 59c0: 42aa2a98 c3cd2c10 c23d2304 c23d2304 3f45655f
> c24d4c98 fc8f9ed5 f00f5a98
> [    3.781097] 59e0: 00000001 c0ddeafc c3cd2c10 c23d2304 00000000
> c0ddb238 c3cd2c10 c23d2304
> [    3.789306] 5a00: c24d4ca0 000000ab 00000001 c0dda2bc 60000013
> efcd8728 c3cd2c10 c3cd2c10
> [    3.797515] 5a20: c24d4ca0 000000ab c24d4c98 fc8f9ed5 00000001
> c0ddaf48 c3cd2c10 c23d2304
> [    3.805755] 5a40: f00f5a98 00000000 c28e1b00 c0ddae00 c0ddaccc
> c0ddaccc 00000000 f00f5a68
> [    3.813964] 5a60: 00000001 c0dd733c c28e1b6c c2e39038 c28e1b00
> 42aa2a98 c3cd2c10 c3cd2c54
> [    3.822204] 5a80: 00000000 00000001 00000000 c28e1b00 00000000
> c0dda0d4 c3cd2c10 00000001
> [    3.830413] 5aa0: 00000100 42aa2a98 c3cd2c10 c24d4c8c c28e1b00
> c1a466d0 c3cd2c10 c0dd75a8
> [    3.838653] 5ac0: c3cd2c10 c3cd3410 00000000 c3cd3410 c3cd2c10
> efcd878c 00000001 c0dd2cbc
> [    3.846862] 5ae0: 42aa2a98 00000000 00000000 00000000 c3cd2c00
> efcd8728 c3cd2c10 efcd878c
> [    3.855072] 5b00: 00000000 c13298d8 efcd8728 c3cd3410 c221d2a0
> 00000000 00000000 efcd878c
> [    3.863311] 5b20: c1843838 c1329b70 c2c10c10 c3cd3410 00000000
> 00000000 00000000 00000000
> [    3.871520] 5b40: 00000000 00000000 00000000 00000000 00000000
> 00000000 42aa2a98 efcd8728
> [    3.879760] 5b60: c221d2a0 c1843838 efcd842c 00000000 c3cd3410
> 00000001 c24c3718 c1329dec
> [    3.887969] 5b80: 00000001 c1cfa6f6 c3d11f40 efcd8590 f00f5be0
> 00000001 00000000 c1cfa6f6
> [    3.896179] 5ba0: c1dffe3e c0a2de8c 00000000 00000000 c1d88d7d
> c3cd3410 c221d50c efcd842c
> [    3.904418] 5bc0: 00000000 00000000 43300000 00000000 00100000
> 00000000 00000200 00000000
> [    3.912628] 5be0: 00000002 c1b14540 ff9e82f0 ff9e82f0 00000001
> 00000001 00000001 00000000
> [    3.920867] 5c00: 42aa2a98 c3cd3410 c230f244 c230f244 3f45655f
> c24d4c98 fc8f9ed5 f00f5cd8
> [    3.929077] 5c20: 00000001 c0ddeafc c3cd3410 c230f244 00000000
> c0ddb238 c3cd3410 c230f244
> [    3.937316] 5c40: c24d4ca0 000000ab 00000001 c0dda2bc 60000013
> ffffffff c3cd3410 c3cd3410
> [    3.945526] 5c60: c24d4ca0 000000ab c24d4c98 fc8f9ed5 00000001
> c0ddaf48 c3cd3410 c230f244
> [    3.953735] 5c80: f00f5cd8 00000000 c28e1b00 c0ddae00 c0ddaccc
> c0ddaccc 00000000 f00f5ca8
> [    3.961975] 5ca0: 00000001 c0dd733c c28e1b6c c3873938 c28e1b00
> 42aa2a98 c3cd3410 c3cd3454
> [    3.970184] 5cc0: 00000000 00000001 00000000 c28e1b00 c221d50c
> c0dda0d4 c3cd3410 00000001
> [    3.978424] 5ce0: 00000100 42aa2a98 c3cd3410 c24d4c8c c28e1b00
> c1a466d0 c3cd3410 c0dd75a8
> [    3.986633] 5d00: c3cd3410 c2c10c10 00000000 c2c10c10 c3cd3410
> efcd8490 00000001 c0dd2cbc
> [    3.994842] 5d20: 42aa2a98 00000000 00000000 00000000 c3cd3400
> efcd842c c3cd3410 efcd8490
> [    4.003082] 5d40: c221d50c c13298d8 efcd842c c2c10c10 c221d2a0
> c221d50c 00000000 efcd8490
> [    4.011291] 5d60: 00000000 c1329b70 00000000 c2c10c10 43300000
> 00000000 43300003 00000000
> [    4.019500] 5d80: ff9e8254 00000200 00000000 00000000 00000000
> 00000000 42aa2a98 efcd842c
> [    4.027740] 5da0: c221d2a0 00000000 efc76d7c 00000000 c2c10c10
> 00000001 c291ab0d c1329dec
> [    4.035949] 5dc0: 00000001 f00f5eb8 c2c10c10 efc76d7c c3a37d40
> c2c10c00 c230f168 c221d2a0
> [    4.044189] 5de0: f00f5eb8 c0a2d154 c2c10c10 c230f168 c230f168
> 3f45655f c24d4c98 fc8f9ed5
> [    4.052398] 5e00: c291ab0d c0ddeafc c2c10c10 c230f168 00000000
> c0ddb238 c2c10c10 c230f168
> [    4.060607] 5e20: c24d4ca0 00000001 c291ab0d c0dda2bc 60000013
> efc76d7c c2c10c10 c2c10c10
> [    4.068847] 5e40: c24d4ca0 00000001 c24d4c98 fc8f9ed5 c291ab0d
> c0ddaf48 c2c10c10 c230f168
> [    4.077056] 5e60: f00f5eb8 00000000 c28e1b00 c0ddae00 c0ddaccc
> c0ddaccc 00000000 f00f5e88
> [    4.085296] 5e80: c291ab0d c0dd733c c28e1b6c c38733b8 c28e1b00
> 42aa2a98 c2c10c10 c2c10c54
> [    4.093505] 5ea0: 00000000 00000001 00000000 c28e1b00 c291ab00
> c0dda0d4 c2c10c10 00000001
> [    4.101745] 5ec0: c291ab0d 42aa2a98 c2c10c10 c24d4c8c c28e1b00
> c1a466d0 00000000 c0dd75a8
> [    4.109954] 5ee0: c23fe4dc c2c10c10 c29106d4 c23fe4f8 00000000
> 00000004 c291ab0d c0ddaa60
> [    4.118164] 5f00: c29c0f80 c23fe500 c282e400 c291ab80 0000000a
> c04783d4 f00f5f70 c1805e20
> [    4.126403] 5f20: 00000000 00000002 42aa2a98 c29e1bc0 c29c0f98
> c29c0fd0 c29c0fac c282e400
> [    4.134613] 5f40: c29c0f80 c29c0fac c29e1bc0 c282e420 c246b274
> 00000402 00000000 c047a89c
> [    4.142852] 5f60: c29c4300 c047a5ec c29c0f80 00000040 c29e22a4
> c29c4314 c29c4300 c047a5ec
> [    4.151062] 5f80: c29c0f80 c29e1bc0 00000000 c04810d4 c29c1b40
> c0480f9c 00000000 00000000
> [    4.159271] 5fa0: 00000000 00000000 00000000 c040029c 00000000
> 00000000 00000000 00000000
> [    4.167510] 5fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    4.175720] 5fe0: 00000000 00000000 00000000 00000000 00000013
> 00000000 00000000 00000000
> [    4.183959] Call trace:
> [    4.183959] edma_probe from platform_probe (drivers/base/platform.c:1404)
> [    4.191589] platform_probe from really_probe (drivers/base/dd.c:581
> drivers/base/dd.c:658)
> [    4.197021] really_probe from __driver_probe_device (drivers/base/dd.c:800)
> [    4.202972] __driver_probe_device from driver_probe_device
> (drivers/base/dd.c:830)
> [    4.209564] driver_probe_device from __device_attach_driver
> (drivers/base/dd.c:959)
> [    4.216308] __device_attach_driver from bus_for_each_drv
> (drivers/base/bus.c:459)
> [    4.222778] bus_for_each_drv from __device_attach (drivers/base/dd.c:1030)
> [    4.228576] __device_attach from bus_probe_device (drivers/base/bus.c:536)
> [    4.234344] bus_probe_device from device_add (drivers/base/core.c:3679)
> [    4.239807] device_add from of_platform_device_create_pdata
> (drivers/of/platform.c:186)
> [    4.246368] of_platform_device_create_pdata from
> of_platform_bus_create (drivers/of/platform.c:381)
> [    4.254150] of_platform_bus_create from of_platform_populate
> (drivers/of/platform.c:469)
> [    4.260833] of_platform_populate from sysc_probe (drivers/bus/ti-sysc.c:3269)
> [    4.266601] sysc_probe from platform_probe (drivers/base/platform.c:1404)
> [    4.271697] platform_probe from really_probe (drivers/base/dd.c:581
> drivers/base/dd.c:658)
> [    4.277130] really_probe from __driver_probe_device (drivers/base/dd.c:800)
> [    4.283081] __driver_probe_device from driver_probe_device
> (drivers/base/dd.c:830)
> [    4.289672] driver_probe_device from __device_attach_driver
> (drivers/base/dd.c:959)
> [    4.296417] __device_attach_driver from bus_for_each_drv
> (drivers/base/bus.c:459)
> [    4.302886] bus_for_each_drv from __device_attach (drivers/base/dd.c:1030)
> [    4.308685] __device_attach from bus_probe_device (drivers/base/bus.c:536)
> [    4.314453] bus_probe_device from device_add (drivers/base/core.c:3679)
> [    4.319915] device_add from of_platform_device_create_pdata
> (drivers/of/platform.c:186)
> [    4.326477] of_platform_device_create_pdata from
> of_platform_bus_create (drivers/of/platform.c:381)
> [    4.334259] of_platform_bus_create from of_platform_populate
> (drivers/of/platform.c:469)
> [    4.340911] of_platform_populate from simple_pm_bus_probe
> (drivers/bus/simple-pm-bus.c:0)
> [    4.347320] simple_pm_bus_probe from platform_probe
> (drivers/base/platform.c:1404)
> [    4.353179] platform_probe from really_probe (drivers/base/dd.c:581
> drivers/base/dd.c:658)
> [    4.358612] really_probe from __driver_probe_device (drivers/base/dd.c:800)
> [    4.364593] __driver_probe_device from driver_probe_device
> (drivers/base/dd.c:830)
> [    4.371154] driver_probe_device from __device_attach_driver
> (drivers/base/dd.c:959)
> [    4.377899] __device_attach_driver from bus_for_each_drv
> (drivers/base/bus.c:459)
> [    4.384399] bus_for_each_drv from __device_attach (drivers/base/dd.c:1030)
> [    4.390167] __device_attach from bus_probe_device (drivers/base/bus.c:536)
> [    4.395965] bus_probe_device from deferred_probe_work_func
> (drivers/base/dd.c:124)
> [    4.402435] deferred_probe_work_func from process_scheduled_works
> (include/linux/atomic/atomic-arch-fallback.h:457
> include/linux/jump_label.h:261 include/trace/events/workqueue.h:110
> kernel/workqueue.c:3234 kernel/workqueue.c:3310)
> [    4.409729] process_scheduled_works from worker_thread
> (include/linux/list.h:373 kernel/workqueue.c:946
> kernel/workqueue.c:3392)
> [    4.416015] worker_thread from kthread (kernel/kthread.c:391)
> [    4.420928] kthread from ret_from_fork (arch/arm/kernel/entry-common.S:138)
> [    4.425659] Exception stack(0xf00f5fb0 to 0xf00f5ff8)
> [    4.430755] 5fa0:                                     00000000
> 00000000 00000000 00000000
> [    4.438964] 5fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    4.447204] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [ 4.453857] Code: e3a03001 13540001 e5c03002 1a000006 (e7ffdefe)
> All code
> ========
> 
> Code starting with the faulting instruction
> ===========================================
> [    4.459960] ---[ end trace 0000000000000000 ]---
> [    4.464630] note: kworker/u10:2[41] exited with irqs disabled
> 
> Links:
> - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.12-9073-g9f16d5e6f220/testrun/26029148/suite/boot/test/korg-clang-19-lkftconfig-hardening/details/
> - https://lkft.validation.linaro.org/scheduler/job/8004562#L2109
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2pHgoZfhSxCBwwjm4YIlCiyWlfE
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2pHgnVqB6fC9d8asA1VUZJ0NRxT/
> 
> Build image:
> -----------
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2pHgnVqB6fC9d8asA1VUZJ0NRxT/
> 
> metadata:
> ----
> Linux version: 6.12.0
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pHgnVqB6fC9d8asA1VUZJ0NRxT/config
> build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pHgnVqB6fC9d8asA1VUZJ0NRxT/
> toolchain: clang-19 and clang-nightly
> config:  korg-clang-19-lkftconfig-hardening
> arch: TI x15
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

