Return-Path: <dmaengine+bounces-4996-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE4A98A97
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B013BAFB2
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B17A86344;
	Wed, 23 Apr 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSROSO6W"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33E35957;
	Wed, 23 Apr 2025 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414007; cv=none; b=PQ899X4Udp618JQFv5eDPNh97L07g/1WuPmu97kt+wkr8PBnbIxGVTw/VF28QlNQN0ACqwBkJJOnHVsGdXM5uNbHeUCuWIMyP3n6uhggDO69u8BsJv7h4exPTVUVi4I1+/yulANKRWw5vIzzRLcYpGcjjH2pdEnRchygVkixCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414007; c=relaxed/simple;
	bh=34VPvCiXiWeAT1uuiNzCekuKDNm2kl4hepgAiEd/YJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj+5yiJeA+yQMOwLxYnDVzmm9qcloFmh67rtGu4zDOFDKscghof+Thg5kFkh016/4AVffpId1YY6k6mUJhnwejnLrofTGSQ7Wn9OIOUiOOlqlK+7sh7ahW6hPPK3uHHdle7nmmTfM+H6mPtShLxA5ajdXn40mBo/LRyYtXQu3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSROSO6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360CDC4CEE2;
	Wed, 23 Apr 2025 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414006;
	bh=34VPvCiXiWeAT1uuiNzCekuKDNm2kl4hepgAiEd/YJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSROSO6WePDeZWNxvPyrx5qh80KicMYJb8Jn34Y/ckeuqfR3thGsI4m9mfVgR85r1
	 aeDU37jrwRoBqNSDgRFdHQj68XxyiYzMOb7w+aSE5tCMxXf8llaruBkPDh1MZDmZ8D
	 noIAj7QDIDBCU9vRjJlbpnS4/euv+AZBWw4J6sXRMhi3kWZKnvM/qzXCWSgaLmygMn
	 j6MdCD0AUvi/2yLUZ1OgTDlC3EwGXpW6hZ16kVulC5lkjbQ+YNYytKprZ1RtP7uMYQ
	 tQPvrOZDT5+wRdOl1AX1C2Rt2vPXZgYKncWgR83vLBaRDIMCO6+24jsN6C6BSX9/4T
	 5Yb2j+rndTwrA==
Date: Wed, 23 Apr 2025 18:43:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Message-ID: <aAjnc+AxmAn9fxSs@vaman>
References: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
 <20250422173937.3722875-6-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422173937.3722875-6-fabrizio.castro.jz@renesas.com>

On 22-04-25, 18:39, Fabrizio Castro wrote:
> The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
> similar to the version found on the Renesas RZ/G2L family of
> SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ No
> * It is connected to the Interrupt Control Unit (ICU)
> * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
> 
> Add specific support for the Renesas RZ/V2H(P) family of SoC by
> tackling the aforementioned differences.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v5->v6:
> * Collected tags.
> v4->v5:
> * Reused RZ/G2L cell specification (with REQ No in place of MID/RID).
> * Dropped ACK No.
> * Removed mid_rid/req_no/ack_no union and reused mid_rid for REQ No.
> * Other small improvements.
> v3->v4:
> * Fixed an issue with mid_rid/req_no/ack_no initialization
> v2->v3:
> * Dropped change to Kconfig.
> * Replaced rz_dmac_type with has_icu flag.
> * Put req_no and ack_no in an anonymous struct, nested under an
>   anonymous union with mid_rid.
> * Dropped data field of_rz_dmac_match[], and added logic to determine
>   value of has_icu flag from DT parsing.
> v1->v2:
> * Switched to new macros for minimum values.
> ---
>  drivers/dma/sh/rz-dmac.c | 81 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d7a4ce28040b..1f687b08d6b8 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -14,6 +14,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> +#include <linux/irqchip/irq-renesas-rzv2h.h>

This does not exist for me or in the patches that was sent to me. I have
dropped this series due to build failure after picking up dmaengine
patches

drivers/dma/sh/rz-dmac.c:17:10: fatal error: linux/irqchip/irq-renesas-rzv2h.h: No such file or directory

-- 
~Vinod

