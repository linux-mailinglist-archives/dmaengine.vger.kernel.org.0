Return-Path: <dmaengine+bounces-1065-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3D85FA25
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 14:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C862628A0E5
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9381332B1;
	Thu, 22 Feb 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUx3003C"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25567132C23;
	Thu, 22 Feb 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609570; cv=none; b=Zu85QIXQW3Le3cFxPxLBzLdygAeLl3x8cavKmVNaIkFq0/XYn/bTNh9s4OsfkGb9K29QqrZhFMty0o2ggnGIw0u7UR3X2Lnd8nDUqKIoJKdfpOg8TFUfLCkzWALsuyBIB3h0GWm5eXqMw3hsgKtOa2wcMoBZv3x3PevmvoFCHeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609570; c=relaxed/simple;
	bh=Us47+ijyom5i1wqBLUBBCfgKRKudvHeAYAOiNM2YUIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebyUqH6Jucr7sDuPFP/IGqVC+8kE+Cl/HqRgYNvQpnUqD+wrkLXyGPbv3yfOmS7ecOjAnbfuIjW2ZdgHZmRyUdF56O3PnsWydV54J2Llm9dQts8G91B8E5DQq0nKmFtDV1gu0L4h+m8DOdMRddK0/UPtza20+YFyFtHxlQ+e0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUx3003C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31280C433F1;
	Thu, 22 Feb 2024 13:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708609569;
	bh=Us47+ijyom5i1wqBLUBBCfgKRKudvHeAYAOiNM2YUIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUx3003Cp7ldWfBXBLSIiIxRYMFl3qcgIR9G3hXiJfOchm+QuA3wnfW2C4Wmecz3s
	 RNrhzyISNpbBtSEZio7yOat0n1KaGFdwZasmRG/rCdot+YfGE7o2zsvukwJ0zDhQpy
	 6k6wNWggvD/OTUsZkESxPNfyekrvsjyOw+iWy7PKaojLXpjQCR+P2eAoOHaFqvIOO7
	 bQrrtgEeY80H9lF8LLLSgCKOC8ROM2vtoC/RC7kiZrdvoIVuALccEPYPGg7JhIffsx
	 tfdWItd/tZXtuW0i2OJlA7RoR3wa+kkC2hnvm64G7L5ewQPoV0ZyeJ1OwS24oa6y8M
	 PMXwAmeln2/xA==
Date: Thu, 22 Feb 2024 19:16:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: change in AMD ptdma maintainer
Message-ID: <ZddQHZIo8fLCoqec@matsya>
References: <20240222083004.1907070-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222083004.1907070-1-Basavaraj.Natikar@amd.com>

On 22-02-24, 14:00, Basavaraj Natikar wrote:
> As 'Sanjay R Mehta' stepped down from the role of ptdma maintainer, I
> request to be added as the new maintainer of AMD PTDMA.

Should you not CC Sanjay?

> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2c6187a3ac8..becd09410b8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1034,7 +1034,7 @@ F:	include/linux/amd-pstate.h
>  F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>  
>  AMD PTDMA DRIVER
> -M:	Sanjay R Mehta <sanju.mehta@amd.com>
> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	drivers/dma/ptdma/
> -- 
> 2.25.1

-- 
~Vinod

