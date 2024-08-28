Return-Path: <dmaengine+bounces-2984-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A2E962E18
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44041F25278
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 17:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6CA15F3E6;
	Wed, 28 Aug 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV0NQycL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ADC1DFEF;
	Wed, 28 Aug 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864596; cv=none; b=DUdtwUVG5nJF4Tl+ulcM+cl46mQL9sb77j1S05xicumNOMXKC3v/wLMZLM8OkJdHTW6Pxrb8XI0X7iO2yYgmB8kvOCwP2dRmWAQ+p7aUwKgiaDUocpB0XSPTX3gAnIZ50MlMvQeF2zVwJJ8LsBOt8fRMnfAX/zS4hzA9fx6YqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864596; c=relaxed/simple;
	bh=tqN9enw4mI37mUu92x5bRXQQESPC2OBX5/K5AzXMeIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p4MgWS4kDxM0y4J+x1S6x3msFEfFkWp7ozeykBgIrf2R6T8UTa4tMe/P5lcObDBIwhVgfn5GFLTchqQjU2dIw3wk6uQqSLMDYEeppsxRm0aBu3OQIwwuYd0kzR1V7bGGwcpcTfpxocekX6223gRbcDiMHWlfG9u5YbrIrY58bZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV0NQycL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11423C4CEC0;
	Wed, 28 Aug 2024 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724864596;
	bh=tqN9enw4mI37mUu92x5bRXQQESPC2OBX5/K5AzXMeIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PV0NQycLXQrlpKK2HsYRmhOQfVQv/4uQ8Ojy/qsOIeZ2oQ1AzqMkJFX8HgfpovAv/
	 qQWLtB8cN6RDHIQKahNWnQ0exqLX3WQ6/FpsvvbSVod6k5WY1+CcBz2KZjjXbsbSUQ
	 keK/ayaL56qHAykfsb3RW4byzGHdINGvtb1VJSXQrOJTfbYkCwTjwl/A7fWry5rx3L
	 RSfFqYU6ly2iJfodx08UF0ZcHhAaivvc7jbhKSNhRDwGm0hcvYpmvN/aJsTdEqVTF5
	 kbvwCa8toXMGkHEAahkhR/4geXZURYSBrBym5UTwslHOH1qk1M10AkRMrAXloMN6kT
	 J1g+feiNSz+kQ==
Date: Wed, 28 Aug 2024 12:03:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Amit Vadhavana <av2082000@gmail.com>
Cc: linux-doc@vger.kernel.org, ricardo@marliere.net,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	amelie.delaunay@foss.st.com, corbet@lwn.net,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	bhelgaas@google.com, conor.dooley@microchip.com,
	costa.shul@redhat.com, dmaengine@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH V2] Documentation: Fix spelling mistakes
Message-ID: <20240828170313.GA26255@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817072724.6861-1-av2082000@gmail.com>

On Sat, Aug 17, 2024 at 12:57:24PM +0530, Amit Vadhavana wrote:
> Correct spelling mistakes in the documentation to improve readability.
> 
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>

I don't maintain any of these files, but all these fixes look good to
me.  Thanks for doing them!

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V1: https://lore.kernel.org/all/20240810183238.34481-1-av2082000@gmail.com
> V1 -> V2:
> - Write the commit description in imperative mode.
> - Fix grammer mistakes in the sentence.
> ---
>  Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst | 4 ++--
>  Documentation/arch/arm64/cpu-hotplug.rst                 | 2 +-
>  Documentation/arch/powerpc/ultravisor.rst                | 2 +-
>  Documentation/arch/riscv/vector.rst                      | 2 +-
>  Documentation/arch/x86/mds.rst                           | 2 +-
>  Documentation/arch/x86/x86_64/fsgs.rst                   | 4 ++--
>  Documentation/process/backporting.rst                    | 6 +++---
>  7 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst b/Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst
> index 2945e0e33104..301aa30890ae 100644
> --- a/Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst
> +++ b/Documentation/arch/arm/stm32/stm32-dma-mdma-chaining.rst
> @@ -359,7 +359,7 @@ Driver updates for STM32 DMA-MDMA chaining support in foo driver
>      descriptor you want a callback to be called at the end of the transfer
>      (dmaengine_prep_slave_sg()) or the period (dmaengine_prep_dma_cyclic()).
>      Depending on the direction, set the callback on the descriptor that finishes
> -    the overal transfer:
> +    the overall transfer:
>  
>      * DMA_DEV_TO_MEM: set the callback on the "MDMA" descriptor
>      * DMA_MEM_TO_DEV: set the callback on the "DMA" descriptor
> @@ -371,7 +371,7 @@ Driver updates for STM32 DMA-MDMA chaining support in foo driver
>    As STM32 MDMA channel transfer is triggered by STM32 DMA, you must issue
>    STM32 MDMA channel before STM32 DMA channel.
>  
> -  If any, your callback will be called to warn you about the end of the overal
> +  If any, your callback will be called to warn you about the end of the overall
>    transfer or the period completion.
>  
>    Don't forget to terminate both channels. STM32 DMA channel is configured in
> diff --git a/Documentation/arch/arm64/cpu-hotplug.rst b/Documentation/arch/arm64/cpu-hotplug.rst
> index 76ba8d932c72..8fb438bf7781 100644
> --- a/Documentation/arch/arm64/cpu-hotplug.rst
> +++ b/Documentation/arch/arm64/cpu-hotplug.rst
> @@ -26,7 +26,7 @@ There are no systems that support the physical addition (or removal) of CPUs
>  while the system is running, and ACPI is not able to sufficiently describe
>  them.
>  
> -e.g. New CPUs come with new caches, but the platform's cache toplogy is
> +e.g. New CPUs come with new caches, but the platform's cache topology is
>  described in a static table, the PPTT. How caches are shared between CPUs is
>  not discoverable, and must be described by firmware.
>  
> diff --git a/Documentation/arch/powerpc/ultravisor.rst b/Documentation/arch/powerpc/ultravisor.rst
> index ba6b1bf1cc44..6d0407b2f5a1 100644
> --- a/Documentation/arch/powerpc/ultravisor.rst
> +++ b/Documentation/arch/powerpc/ultravisor.rst
> @@ -134,7 +134,7 @@ Hardware
>  
>        * PTCR and partition table entries (partition table is in secure
>          memory). An attempt to write to PTCR will cause a Hypervisor
> -        Emulation Assitance interrupt.
> +        Emulation Assistance interrupt.
>  
>        * LDBAR (LD Base Address Register) and IMC (In-Memory Collection)
>          non-architected registers. An attempt to write to them will cause a
> diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
> index 75dd88a62e1d..3987f5f76a9d 100644
> --- a/Documentation/arch/riscv/vector.rst
> +++ b/Documentation/arch/riscv/vector.rst
> @@ -15,7 +15,7 @@ status for the use of Vector in userspace. The intended usage guideline for
>  these interfaces is to give init systems a way to modify the availability of V
>  for processes running under its domain. Calling these interfaces is not
>  recommended in libraries routines because libraries should not override policies
> -configured from the parant process. Also, users must noted that these interfaces
> +configured from the parent process. Also, users must note that these interfaces
>  are not portable to non-Linux, nor non-RISC-V environments, so it is discourage
>  to use in a portable code. To get the availability of V in an ELF program,
>  please read :c:macro:`COMPAT_HWCAP_ISA_V` bit of :c:macro:`ELF_HWCAP` in the
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
>  
>    =================== ===========================
> @@ -135,7 +135,7 @@ instructions. Clang 5 supports them as well.
>    _writegsbase_u64()  Write the GS base register
>    =================== ===========================
>  
> -To utilize these instrinsics <immintrin.h> must be included in the source
> +To utilize these intrinsics <immintrin.h> must be included in the source
>  code and the compiler option -mfsgsbase has to be added.
>  
>  Compiler support for FS/GS based addressing
> diff --git a/Documentation/process/backporting.rst b/Documentation/process/backporting.rst
> index e1a6ea0a1e8a..a71480fcf3b4 100644
> --- a/Documentation/process/backporting.rst
> +++ b/Documentation/process/backporting.rst
> @@ -73,7 +73,7 @@ Once you have the patch in git, you can go ahead and cherry-pick it into
>  your source tree. Don't forget to cherry-pick with ``-x`` if you want a
>  written record of where the patch came from!
>  
> -Note that if you are submiting a patch for stable, the format is
> +Note that if you are submitting a patch for stable, the format is
>  slightly different; the first line after the subject line needs tobe
>  either::
>  
> @@ -147,7 +147,7 @@ divergence.
>  It's important to always identify the commit or commits that caused the
>  conflict, as otherwise you cannot be confident in the correctness of
>  your resolution. As an added bonus, especially if the patch is in an
> -area you're not that famliar with, the changelogs of these commits will
> +area you're not that familiar with, the changelogs of these commits will
>  often give you the context to understand the code and potential problems
>  or pitfalls with your conflict resolution.
>  
> @@ -197,7 +197,7 @@ git blame
>  Another way to find prerequisite commits (albeit only the most recent
>  one for a given conflict) is to run ``git blame``. In this case, you
>  need to run it against the parent commit of the patch you are
> -cherry-picking and the file where the conflict appared, i.e.::
> +cherry-picking and the file where the conflict appeared, i.e.::
>  
>      git blame <commit>^ -- <path>
>  
> -- 
> 2.25.1
> 

