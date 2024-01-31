Return-Path: <dmaengine+bounces-916-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6099284390E
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 09:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186AE285777
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2A605BC;
	Wed, 31 Jan 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzStpqi3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00F605AE
	for <dmaengine@vger.kernel.org>; Wed, 31 Jan 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689715; cv=none; b=QQH3w9W9K4kgdEn0Hi1+ZsvIPK90EAjcfIlaGCYAzmRXk7ccyAm4IiRWwjYK180KIwfjZ4kci97cZuArc5zlRmVJlLWCtT8LqIgKxIULjrKCtIKpTURrTC542nkz1nnLIZtKuoHJKSA5NAuEN+2Avn1u6MWQjEpMQqMl2dD3odo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689715; c=relaxed/simple;
	bh=qGVv+F39PRxxlDiWUW3M1R5JPIhQa5pkx63w0Os508c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b1Is8haJjdY71SV+9EAc1KQcpHv+OJmH0rBoRWWLKh8t2yRlmpjCHyxNPIaDg/JGSAf7jYvK4FwtgOHk7yPb5UzsGjTO3yGqybQc0Hc/QPxg7ZwmPNstZ3m8khiE+mtiWueJLnXtCUBQiVlgw2PpSLmC3I4x+kjjEUyjOmPvr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FzStpqi3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so5306377a12.2
        for <dmaengine@vger.kernel.org>; Wed, 31 Jan 2024 00:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689711; x=1707294511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bsiP+g7YPL7qKpsgnhrwUrZD5K9uLsmkQOCYLFKhPv0=;
        b=FzStpqi3T2+KVQJrDZWUv4p3gXT6lWZPYE1bVCTRCIxQ16H9t+wFJZ9sts7kZTyt3L
         eVWk2oGLrXYqKg/rH4g1hSKPMiMtosxLJD347aS556abULYFoOY/pNslhbV+6006XS01
         BrXEzB+UI1NhlMp/EkoUa/cZtHMKrbOCapzUkmvAjoswbemqjfaP2KDRC9IiTjgAiQNp
         jVVrGIa7sQrhajt/db/43PnAneGUfSD+4C4SAWXmww/1/a5ZeHYKKDy8rPqz6pnkZRNF
         rxEiGzUHOWNuvzfr/0/R8l4m7JvrJZ9ih7VngnU2l8bhOPAJzjfeM4TwtjLVqOV7ZueG
         LKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689711; x=1707294511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsiP+g7YPL7qKpsgnhrwUrZD5K9uLsmkQOCYLFKhPv0=;
        b=w/C6ncH4LGZ3Vcag6Qpay+PMS/BuaerrqdiOc9nFgVxooaYseOci7G1d052kwFEbXr
         oBWRtkvSIC6NaDZ/sybavxokRosRXB7GoPSknsX/jR26Cr52Jpto1YoqS9/QMhKxR6g3
         LuTlG4yF2pkTcRi/8Csyy7amRizVzWcZNzQuTKGP27OkpZpEdRzyVA7z+HElCuh174+l
         JlPrDlBvCJwXUYz8srz0GjfmzqmvDmEkzf5Lzl92yvTokgk9ArgeTjNuYij4HAhZje6F
         0qGf/NO+xyqrGqLS25yH9lm5qMet+KQ+jnJFmIkDT9EuLyQ7PT5U/B/qi/j2QH4mONUz
         JurQ==
X-Gm-Message-State: AOJu0YyNoDzdpIIezKxslMKzLAQEMYWHiNSGQrqvcMjbVRW3HLflV0Op
	b0j91ebeso3bNKSUuqJTPdLTFOJpCQgqV1PPl7ZYEKXOB8GPK1f5F3gGTAjputU=
X-Google-Smtp-Source: AGHT+IFS98DzZXzO3rMOFnzVmRvn559XaFKnljkxHG5/iBMRJ+IqOYI2Cn+Qc15WIgVpxvn3ZmrIjw==
X-Received: by 2002:a50:ed84:0:b0:55c:fdd2:f78c with SMTP id h4-20020a50ed84000000b0055cfdd2f78cmr584952edr.9.1706689711624;
        Wed, 31 Jan 2024 00:28:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXE6Eg6Tn6FjRRzEnEMuXMK1GW3ZGmr9YJkOBLNLdebUYKwhHnZ+sS6Lp8vRahihASMrJoKxTbUTd/4RpOkY4SBjnovHdHlsRMDzBSQ2cxFbWfKqx01YcPDlRpaEVI24N36MaGl4OHWKmu7
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id ec37-20020a0564020d6500b0055f8adf1d6esm220073edb.47.2024.01.31.00.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 00:28:31 -0800 (PST)
Message-ID: <acd56301-d7b1-4218-9f89-eccc283a9c7e@linaro.org>
Date: Wed, 31 Jan 2024 08:28:29 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: at_hdmac: add missing kernel-doc style
 description
To: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20240130163216.633034-1-vkoul@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240130163216.633034-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi, Vinod,

On 1/30/24 16:32, Vinod Koul wrote:
> We get following warning with W=1:
> 
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'boundary' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'dst_hole' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'src_hole' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_buffer' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_paddr' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_vaddr' not described in 'at_desc'
> drivers/dma/at_hdmac.c:255: warning: Enum value 'ATC_IS_PAUSED' not described in enum 'atc_status'
> drivers/dma/at_hdmac.c:255: warning: Enum value 'ATC_IS_CYCLIC' not described in enum 'atc_status'
> drivers/dma/at_hdmac.c:287: warning: Function parameter or struct member 'cyclic' not described in 'at_dma_chan'
> drivers/dma/at_hdmac.c:350: warning: Function parameter or struct member 'memset_pool' not described in 'at_dma'
> 
> Fix this by adding the required description and also drop unused struct
> member 'cyclic' in 'at_dma_chan'
> 

Thanks for fixing these! Few nits below that you may consider while
applying.

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/at_hdmac.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 6bad536e0492..57d0697ad194 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -224,6 +224,12 @@ struct atdma_sg {
>   * @total_len: total transaction byte count
>   * @sglen: number of sg entries.
>   * @sg: array of sgs.
> + * @boundary: Interleaved dma boundary
how about: number of transfers to perform before the automatic address
increment operation
> + * @dst_hole: Interleaved dma destination hole
how about: value to add to the destination address when the boundary has
been reached
> + * @src_hole: Interleaved dma source hole

and here the same, but for source
> + * @memset_buffer: buffer for memset
how about: buffer used for the memset operation
> + * @memset_paddr: paddr for buffer for memset

how about: physical address of the buffer used for the memset operation

> + * @memset_vaddr: vaddr for buffer for memset

and here the same but with virtual

>   */
>  struct at_desc {
>  	struct				virt_dma_desc vd;
> @@ -247,6 +253,9 @@ struct at_desc {
>  /**
>   * enum atc_status - information bits stored in channel status flag
>   *
> + * @ATC_IS_PAUSED: If channel is pause

typo, s/pause/paused

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Cheers,
ta
> + * @ATC_IS_CYCLIC: If channel is cyclic
> + *
>   * Manipulated with atomic operations.
>   */
>  enum atc_status {
> @@ -282,7 +291,6 @@ struct at_dma_chan {
>  	u32			save_cfg;
>  	u32			save_dscr;
>  	struct dma_slave_config	dma_sconfig;
> -	bool			cyclic;
>  	struct at_desc		*desc;
>  };
>  
> @@ -333,6 +341,7 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
>   * @save_imr: interrupt mask register that is saved on suspend/resume cycle
>   * @all_chan_mask: all channels availlable in a mask
>   * @lli_pool: hw lli table
> + * @memset_pool: hw memset pool
>   * @chan: channels table to store at_dma_chan structures
>   */
>  struct at_dma {

