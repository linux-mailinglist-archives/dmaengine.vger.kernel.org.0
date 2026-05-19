Return-Path: <dmaengine+bounces-10560-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGipAz6fDGq8jwUAu9opvQ
	(envelope-from <dmaengine+bounces-10560-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:34:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B90583272
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D21363063C43
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0533FC5BC;
	Tue, 19 May 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP6rKd4Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2229ACDD;
	Tue, 19 May 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211916; cv=none; b=PlpYxKAwAa6l0nARyt4K/pEPeNaElB0190dQR40/pIYP+JIQJLtnmiB2og4SSCAxm2gMscj7GjWPIOdwrUkkKxFoMTj6Om7wqMwsd8DXByXTLiS5o+EcT/MlkoV41F5y3690avAvroVzJTMTQQI9VgTGizFctfMKNbCTUYvefAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211916; c=relaxed/simple;
	bh=C9W48IfWABM4TPfstGWykLqfbgai5EUYokpTl2gZgFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzzDmF1sEmXfrx37rQf9AZOVRaYZcSWQGIFN+DXpONFRrSAdDF8E0bvCow3cbfrrIrSQgLqLW1o4abC09goIUauqfAWgZjB1syu23wQVLprenCZRrxe6VLc4O6E7XfJUwIpj+pHH56bClawvEgIefAEqsaRsd578FaOkYxxegDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP6rKd4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E1AC2BCB3;
	Tue, 19 May 2026 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211915;
	bh=C9W48IfWABM4TPfstGWykLqfbgai5EUYokpTl2gZgFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DP6rKd4QhGaLGaV/UYSKzJS0gXkaWbz/cH9JKLSGYk6hc7fkJl1McxTgmlVrv2tWT
	 gV7cNsyF6ymjx70RlQzBLQB5hFh2dyFF1S6rNaiXsScdyYrxD+0pbeSpbEb1m6j56S
	 kRJn10PFMsAgi/KrF3yu8iTgH63o6/d8RCfAoIfmZ7a5cH9ZT5UvfQECrjVMYHYCMI
	 +YRTmXhWb+jZvlKVDpgoodE42/nerGSBnJDnP5jiEl/4R2EHbRgeMhOIHGlWxFM1nO
	 wDXCNIoBIatYqxHkmIupnrdfnW2aZOGdUwZfIIt49DhhhBViZOe4Xkyl1V/PuhIO6z
	 H6m7aIS5F/aMw==
Date: Tue, 19 May 2026 23:01:51 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Frank Li <Frank.Li@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
	mani@kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Md Sadre Alam <md.alam@oss.qualcomm.com>,
	Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Subject: Re: [PATCH v5] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
Message-ID: <agyeh4PZwG0Mu6Wx@vaman>
References: <20260514-bam-fix-v5-1-58f6edb34969@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-bam-fix-v5-1-58f6edb34969@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10560-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 94B90583272
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 14-05-26, 12:09, Varadarajan Narayanan wrote:
> From: Md Sadre Alam <md.alam@oss.qualcomm.com>
> 
> BAM version 1.6.0 and later changed the behavior of the mask field in
> command elements for read operations. In newer BAM versions, the mask
> field for read commands contains the upper 4 bits of the destination
> address to support 36-bit addressing, while for write commands it
> continues to function as a traditional write mask.

But this changes behaviour for all versions. What happens to folks on older
versions, wont this break for them, if not what am I missing

> 
> This change causes NAND enumeration failures on platforms like IPQ5424
> that use BAM v1.6.0+, because the current code sets mask=0xffffffff
> for all commands. For read commands on newer BAM versions, this results
> in the hardware interpreting the destination address as 0xf_xxxxxxxx
> (invalid high memory) instead of the intended 0x0_xxxxxxxx address.
> 
> Fixed this issue by:
> 1. Updating the bam_cmd_element structure documentation to reflect the
>    dual purpose of the mask field
> 2. Modifying bam_prep_ce_le32() to set appropriate mask values based on
>    command type:
>    - For read commands: mask = 0 (32-bit addressing, upper bits = 0)
>    - For write commands: mask = 0xffffffff (traditional write mask)
> 3. Maintaining backward compatibility with older BAM versions
> 
> This fix enables proper NAND functionality on IPQ5424 and other platforms
> using BAM v1.6.0+ while preserving compatibility with existing systems.
> 
> Fixes: dfebb055f73a2 ("dmaengine: qcom: bam_dma: wrapper functions for command descriptor")
> 

No blanks here

> Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
> Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> Change in [v5]
> 	- Split the driver change into a separate patch
> 	- Update commit log with 'Fixes' tag
> 
> Change in [v4] - https://lore.kernel.org/linux-arm-msm/20260206100202.413834-2-quic_mdalam@quicinc.com/
> 
> * No change
> 
> Change in [v3]
> 
> * Added Tested-by tag
> 
> Change in [v2]
> 
> * No change
> 
> Change in [v1]
> 
> * Updated bam_prep_ce_le32() to set the mask field conditionally based on
>   command type
> 
> * Enhanced kernel-doc comments to clarify mask behavior for BAM v1.6.0+
> ---
>  include/linux/dma/qcom_bam_dma.h | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
> index 68fc0e643b1b..d9d07a9ab313 100644
> --- a/include/linux/dma/qcom_bam_dma.h
> +++ b/include/linux/dma/qcom_bam_dma.h
> @@ -13,9 +13,12 @@
>   * supported by BAM DMA Engine.
>   *
>   * @cmd_and_addr - upper 8 bits command and lower 24 bits register address.
> - * @data - for write command: content to be written into peripheral register.
> - *	   for read command: dest addr to write peripheral register value.
> - * @mask - register mask.
> + * @data - For write command: content to be written into peripheral register.
> + *	   For read command: lower 32 bits of destination address.
> + * @mask - For write command: register write mask.
> + *	   For read command on BAM v1.6.0+: upper 4 bits of destination address.
> + *	   For read command on BAM < v1.6.0: ignored by hardware.
> + *	   Setting to 0 ensures 32-bit addressing compatibility.
>   * @reserved - for future usage.
>   *
>   */
> @@ -42,6 +45,10 @@ enum bam_command_type {
>   * @addr: target address
>   * @cmd: BAM command
>   * @data: actual data for write and dest addr for read in le32
> + *
> + * For BAM v1.6.0+, the mask field behavior depends on command type:
> + * - Write commands: mask = write mask (typically 0xffffffff)
> + * - Read commands: mask = upper 4 bits of destination address (0 for 32-bit)
>   */
>  static inline void
>  bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
> @@ -50,7 +57,11 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
>  	bam_ce->cmd_and_addr =
>  		cpu_to_le32((addr & 0xffffff) | ((cmd & 0xff) << 24));
>  	bam_ce->data = data;
> -	bam_ce->mask = cpu_to_le32(0xffffffff);
> +	if (cmd == BAM_READ_COMMAND)
> +		bam_ce->mask = cpu_to_le32(0x0); /* 32-bit addressing */
> +	else
> +		bam_ce->mask = cpu_to_le32(0xffffffff); /* Write mask */
> +	bam_ce->reserved = 0;
>  }
>  
>  /*
> @@ -60,7 +71,7 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
>   * @bam_ce: BAM command element
>   * @addr: target address
>   * @cmd: BAM command
> - * @data: actual data for write and dest addr for read
> + * @data: actual data for write and destination address for read
>   */
>  static inline void
>  bam_prep_ce(struct bam_cmd_element *bam_ce, u32 addr,
> 
> ---
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> change-id: 20260514-bam-fix-142a0ee8057e
> 
> Best regards,
> -- 
> Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

-- 
~Vinod

