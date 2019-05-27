Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA98C2AECB
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfE0Ghs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 02:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfE0Ghr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 02:37:47 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963BF2054F;
        Mon, 27 May 2019 06:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558939067;
        bh=vSkuMvDZ9at/jvwOITlbbQ9pxi1fXGxHg1mthaRPd2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vufg792BmlI/dKIsWs6oPvtFicINx+ovWBeABt5drkBPxejWOaaVOf7d7X1dDEHrl
         yjVP+e0NcpuMUZUF0JOuQ7lm7a9guHmdjaPzErM86zC6cChxUeksJ0NUniCgL4EjP1
         Kp+JgJLmshxSfJQKDVhXHAaz2kTdb+kZw6EANuZ4=
Date:   Mon, 27 May 2019 12:07:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3][V2] include: fpga: adi-axi-common.h: add common regs
 & defs header
Message-ID: <20190527063743.GD15118@vkoul-mobl>
References: <20190521141425.26176-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521141425.26176-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-05-19, 17:14, Alexandru Ardelean wrote:
> The AXI HDL cores provided for Analog Devices reference designs all share
> some common base registers (e.g. version register at address 0x00).
> 
> To reduce duplication for this, a common header is added to define these
> registers as well as bitfields & macros to work with these registers.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  include/linux/fpga/adi-axi-common.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 include/linux/fpga/adi-axi-common.h
> 
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> new file mode 100644
> index 000000000000..7966c89561b1
> --- /dev/null
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0

For headers this is not the style to be used.
See Documentation/process/license-rules.rst

      C source: // SPDX-License-Identifier: <SPDX License Expression>
      C header: /* SPDX-License-Identifier: <SPDX License Expression> */

> +/*
> + * Analog Devices AXI common registers & definitions
> + *
> + * Copyright 2019 Analog Devices Inc.
> + *
> + * https://wiki.analog.com/resources/fpga/docs/axi_ip
> + * https://wiki.analog.com/resources/fpga/docs/hdl/regmap
> + */
> +
> +#ifndef ADI_AXI_COMMON_H_
> +#define ADI_AXI_COMMON_H_
> +
> +#define	ADI_AXI_REG_VERSION			0x0000
> +
> +#define ADI_AXI_PCORE_VER(major, minor, patch)	\
> +	(((major) << 16) | ((minor) << 8) | (patch))
> +
> +#endif /* ADI_AXI_COMMON_H_ */
> -- 
> 2.17.1

-- 
~Vinod
