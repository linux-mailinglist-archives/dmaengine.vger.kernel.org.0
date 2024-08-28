Return-Path: <dmaengine+bounces-2982-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22B962872
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 15:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E0B23CE5
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0116BE30;
	Wed, 28 Aug 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPDPf+q6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408A18030
	for <dmaengine@vger.kernel.org>; Wed, 28 Aug 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851113; cv=none; b=Oolraa+8eiYgfDxzB/wLEsmBHkGNJQ4yN36KCugH6UKNqPiGvKJ2Wvhfv6JauTfTARl9UGKpasUVjXUx2CypXrV+NVC5pezWYm1GznYZnRWtCzEsykug5mysy2tP015xF4ijgYbS75DSxHn15YCcDQ0slzjs9/Z5ONebQf1Ndwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851113; c=relaxed/simple;
	bh=ByiyEhGFfBO/A74dASFYcM1t1SjIXR8Y+sxOAYtYcso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqCCX1lPX/pvQiM24Ki0dsWxm6gcOFQk9OH1xtYcmRavaAalW6CDTEnM9xm31K6d00MVuJ5wT6mLTDCcUd71I/QA/nxuEXR4iYOu2VASt86oNovjGS7Z05eEkyv93IE6cHX0A4nVLGH8YFa8tjQj/7wHKMS+BqKz38aVWfmBQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPDPf+q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE04FC98ED0;
	Wed, 28 Aug 2024 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724851113;
	bh=ByiyEhGFfBO/A74dASFYcM1t1SjIXR8Y+sxOAYtYcso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPDPf+q6YHl3yfyJOHRq0zYWzmWwe6qgzy46XgS/0x8ce6RN+R8QDwziCFfsBR0K1
	 haSr5O5txr9zTbG4iObicU7X4HJeiB+gws0Uff2xznFu+KxEYA6W6UvMnQxxAUZvo/
	 2Xt7qx2Q4n8811pu8j51X3F6lVpFNOHg39gF4oBPZy5PcSY1KmzlxQD/KuA+i3/r3o
	 buZqO6ADhxDlC4eTa0aNAJjXGW1M26tVPGEOwyHrjX55bQGgq4rd971Aa4W3rWqhpK
	 Wc4CmROA3nY70MK2UoaMepE5toMsAF3dw74HI2eqZiSS2Xkrv6egvFKWQad4D0JIG9
	 Tym6nkgasDEEQ==
Date: Wed, 28 Aug 2024 18:48:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, Raju.Rangoju@amd.com, Frank.li@nxp.com,
	helgaas@kernel.org, pstanner@redhat.com
Subject: Re: [PATCH v5 3/7] dmaengine: ptdma: Move common functions to common
 code
Message-ID: <Zs8jpVrnBuyr/wiQ@vaman>
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
 <20240708144500.1523651-4-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708144500.1523651-4-Basavaraj.Natikar@amd.com>

On 08-07-24, 20:14, Basavaraj Natikar wrote:
> To focus on reusability of ptdma code across modules extract common
> functions into reusable modules.
> 
> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  MAINTAINERS                             | 1 +
>  drivers/dma/amd/ptdma/ptdma-dev.c       | 2 +-
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 3 +--
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 539bf52410de..97d97ddf26f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -952,6 +952,7 @@ M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	drivers/dma/amd/ae4dma/
> +F:	drivers/dma/amd/common/

I think this should be made amd/ to avoid churn when a file is
added/dropped

>  
>  AMD AXI W1 DRIVER
>  M:	Kris Chaplin <kris.chaplin@amd.com>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dev.c b/drivers/dma/amd/ptdma/ptdma-dev.c
> index a2bf13ff18b6..2bdf418fe556 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dev.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dev.c
> @@ -17,7 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  
> -#include "ptdma.h"
> +#include "../common/amd_dma.h"
>  
>  /* Human-readable error strings */
>  static char *pt_error_codes[] = {
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index a2e7c2cec15e..66ea10499643 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -9,8 +9,7 @@
>   * Author: Gary R Hook <gary.hook@amd.com>
>   */
>  
> -#include "ptdma.h"
> -#include "../../dmaengine.h"
> +#include "../common/amd_dma.h"

So the driver was including old headers and now new, but I dont see any
functions being moved? Does each patch compile...?

-- 
~Vinod

