Return-Path: <dmaengine+bounces-2881-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3541A955340
	for <lists+dmaengine@lfdr.de>; Sat, 17 Aug 2024 00:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C3C28359F
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 22:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB4714533C;
	Fri, 16 Aug 2024 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="G5jYwPPe"
X-Original-To: dmaengine@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D91448E0;
	Fri, 16 Aug 2024 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846881; cv=none; b=oE43X/3o4WYaFUPgTNdvhe4BtC0zb4jMXv/e4tnElCflrShj0kHksmHfnOsgrmQ5e/k2FBp4Nu1OLd4CcTrd3uHKAczap94/KRIZB+/UXOFR4e2cHAKdsJBCT96jP8sjL+yZF5TWJQvxJHT7CswCpat1pnzpb8LJ5On5NPl+f2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846881; c=relaxed/simple;
	bh=dwQBZTO//U58E3kwzyvZ1HNQknjkE/A/sZ1qbVlA38c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGFL6B5tULmeaT5HPEjRTKca6e4RejZeug7v3P6sUMKSipD7PXmWvWzSFyaC2gRjnk/9M0fvr3xfF43OLfx0qQEaOhDRI1qWTuafNDVZhfmbkDSKvX/f4Jf+5lK1xy8T2saD/t3t6I+LJindZxcsJt2chIy77EnbyedOO5cfU4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=G5jYwPPe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 03142418AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723846872; bh=DDlzN91pqXetBWEzbxhP44nWK82/0rSseDZiI/Y4Umc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G5jYwPPeNcNFIy3YNcuiJ4LAI0kkXtuup5gU3UeKBjoTDqzOcvYZr6a1FwxSwa3CQ
	 4ZD4O2m3jKu1hmB9ZAUe3RUNAI7JiuczHk7KoxgLrpG1E6+sdiYYQwx/AweUhCAM4l
	 BWRd/+eh+8XR60LcHuSDyYbSJNCo7e359kfLkGsCMDOyHQYsyrWZsL0I3I4UNOZ9en
	 NwGhKdHedKCwPuztjKUhSnk8YqNOD7KkujA0hRhv5mJ7C2OiO36I7mignBfWY3Dl+I
	 CtKwZEp4OMfEotN/irzGcvmRZcPVuKpgKtT6rnX4GVAwmEzHi2Jz5gIWEiPJTa21Q1
	 f1hCwg9+4X7xg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 03142418AB;
	Fri, 16 Aug 2024 22:21:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Amit Vadhavana <av2082000@gmail.com>, linux-doc@vger.kernel.org,
 ricardo@marliere.net
Cc: av2082000@gmail.com, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, amelie.delaunay@foss.st.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, conor.dooley@microchip.com, costa.shul@redhat.com,
 dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix spelling mistakes
In-Reply-To: <20240810183238.34481-1-av2082000@gmail.com>
References: <20240810183238.34481-1-av2082000@gmail.com>
Date: Fri, 16 Aug 2024 16:21:11 -0600
Message-ID: <87y14whzxk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Now that I have looked at these, I have a couple of comments...

Amit Vadhavana <av2082000@gmail.com> writes:

> Corrected spelling mistakes in the documentation to improve readability.

Normal form for a changelog is to use the imperative mode; some
maintainers are insistent about that.  So "Correct spelling ... "

> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> ---
>  Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst | 4 ++--
>  Documentation/arch/arm64/cpu-hotplug.rst                 | 2 +-
>  Documentation/arch/powerpc/ultravisor.rst                | 2 +-
>  Documentation/arch/riscv/vector.rst                      | 2 +-
>  Documentation/arch/sparc/oradax/oracle-dax.rst           | 2 +-
>  Documentation/arch/x86/mds.rst                           | 2 +-
>  Documentation/arch/x86/x86_64/fsgs.rst                   | 4 ++--
>  Documentation/process/backporting.rst                    | 6 +++---
>  8 files changed, 12 insertions(+), 12 deletions(-)

[...]

> diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
> index 75dd88a62e1d..e4a28def318a 100644
> --- a/Documentation/arch/riscv/vector.rst
> +++ b/Documentation/arch/riscv/vector.rst
> @@ -15,7 +15,7 @@ status for the use of Vector in userspace. The intended usage guideline for
>  these interfaces is to give init systems a way to modify the availability of V
>  for processes running under its domain. Calling these interfaces is not
>  recommended in libraries routines because libraries should not override policies
> -configured from the parant process. Also, users must noted that these interfaces
> +configured from the parent process. Also, users must noted that these interfaces

As long as you are fixing this line, s/noted/note/

>  are not portable to non-Linux, nor non-RISC-V environments, so it is discourage
>  to use in a portable code. To get the availability of V in an ELF program,
>  please read :c:macro:`COMPAT_HWCAP_ISA_V` bit of :c:macro:`ELF_HWCAP` in the
> diff --git a/Documentation/arch/sparc/oradax/oracle-dax.rst b/Documentation/arch/sparc/oradax/oracle-dax.rst
> index d1e14d572918..54ccb35ed51d 100644
> --- a/Documentation/arch/sparc/oradax/oracle-dax.rst
> +++ b/Documentation/arch/sparc/oradax/oracle-dax.rst
> @@ -197,7 +197,7 @@ Memory Constraints
>  ==================
>  
>  The DAX hardware operates only on physical addresses. Therefore, it is
> -not aware of virtual memory mappings and the discontiguities that may
> +not aware of virtual memory mappings and the discontinuities that may

Whether "discontiguities" is recognized by a spelling checker or not, I
expect that is the word that was intended by the author of this
document.  I would not change it.

>  exist in the physical memory that a virtual buffer maps to. There is
>  no I/O TLB or any scatter/gather mechanism. All buffers, whether input
>  or output, must reside in a physically contiguous region of memory.
> diff --git a/Documentation/arch/x86/mds.rst b/Documentation/arch/x86/mds.rst
> index c58c72362911..5a2e6c0ef04a 100644
> --- a/Documentation/arch/x86/mds.rst
> +++ b/Documentation/arch/x86/mds.rst
> @@ -162,7 +162,7 @@ Mitigation points
>     3. It would take a large number of these precisely-timed NMIs to mount
>        an actual attack.  There's presumably not enough bandwidth.
>     4. The NMI in question occurs after a VERW, i.e. when user state is
> -      restored and most interesting data is already scrubbed. Whats left
> +      restored and most interesting data is already scrubbed. What's left
>        is only the data that NMI touches, and that may or may not be of
>        any interest.
>  
> diff --git a/Documentation/arch/x86/x86_64/fsgs.rst b/Documentation/arch/x86/x86_64/fsgs.rst
> index 50960e09e1f6..d07e445dac5c 100644
> --- a/Documentation/arch/x86/x86_64/fsgs.rst
> +++ b/Documentation/arch/x86/x86_64/fsgs.rst
> @@ -125,7 +125,7 @@ FSGSBASE instructions enablement
>  FSGSBASE instructions compiler support
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> -GCC version 4.6.4 and newer provide instrinsics for the FSGSBASE
> +GCC version 4.6.4 and newer provide intrinsics for the FSGSBASE
>  instructions. Clang 5 supports them as well.

Note that current kernels require rather newer versions of both
compilers than this, so this information does not need to be here at
all.  If you do not want to edit at that level, though, the change is an
improvement.

Thanks,

jon

