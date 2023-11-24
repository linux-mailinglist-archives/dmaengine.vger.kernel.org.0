Return-Path: <dmaengine+bounces-224-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707F27F7530
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03FB1C20D06
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260D228DCC;
	Fri, 24 Nov 2023 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiA2pP3B"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAB16432;
	Fri, 24 Nov 2023 13:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41961C433CB;
	Fri, 24 Nov 2023 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832772;
	bh=fhbMJZ27leVTHlU/rvmhc8ewmJZU6ueXtCcpXIxIDJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YiA2pP3B5rujWI+yGBH96W8o/HpPx5+0teQ+jH6BZaYT7MtEqCfQfVV7HiZ2xdhC+
	 ZksjogMFANkMhvmdDIxzRicACG85HmNqUSAgoINfB36f6ePjldvS3N/LDJR+cT48xQ
	 LekK6XF1APfKrbLEaJBCNgeQgBXKcYDgk4Zl+TXUNUzqD0hgbEejXH3PW/LSGfDYij
	 we+rpSkzSiNoU3wnl9alGNJHz1wsL2L7U3LeLCnf9LtH4orQjGTZdXWa0r3z9gRpPI
	 tpV1UwU9vWW9shfpkPFKYbEyeaqEYYJvv9hecXh++3rU/OmFcJbgFtqS1ezGgMpB/P
	 aez8elYq9JxiQ==
From: Vinod Koul <vkoul@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pierre Yves MORDRET <pierre-yves.mordret@st.com>, 
 M'boumba Cedric Madianga <cedric.madianga@gmail.com>, 
 Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, dmaengine@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231106134832.1470305-1-amelie.delaunay@foss.st.com>
References: <20231106134832.1470305-1-amelie.delaunay@foss.st.com>
Subject: Re: [PATCH v2] dmaengine: stm32-dma: avoid bitfield overflow
 assertion
Message-Id: <170083276888.771401.2511759200122212610.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:02:48 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 06 Nov 2023 14:48:32 +0100, Amelie Delaunay wrote:
> stm32_dma_get_burst() returns a negative error for invalid input, which
> gets turned into a large u32 value in stm32_dma_prep_dma_memcpy() that
> in turn triggers an assertion because it does not fit into a two-bit field:
> drivers/dma/stm32-dma.c: In function 'stm32_dma_prep_dma_memcpy':
> include/linux/compiler_types.h:354:38: error: call to '__compiletime_assert_282' declared with attribute error: FIELD_PREP: value too large for the field
>      _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                          ^
>    include/linux/compiler_types.h:335:4: note: in definition of macro '__compiletime_assert'
>        prefix ## suffix();    \
>        ^~~~~~
>    include/linux/compiler_types.h:354:2: note: in expansion of macro '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
>       ^~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:114:3: note: in expansion of macro '__BF_FIELD_CHECK'
>       __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>       ^~~~~~~~~~~~~~~~
>    drivers/dma/stm32-dma.c:1237:4: note: in expansion of macro 'FIELD_PREP'
>        FIELD_PREP(STM32_DMA_SCR_PBURST_MASK, dma_burst) |
>        ^~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] dmaengine: stm32-dma: avoid bitfield overflow assertion
      commit: 54bed6bafa0f38daf9697af50e3aff5ff1354fe1

Best regards,
-- 
~Vinod



