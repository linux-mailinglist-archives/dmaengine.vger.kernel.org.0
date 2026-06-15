Return-Path: <dmaengine+bounces-11511-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xTJVBDGbL2qNDAUAu9opvQ
	(envelope-from <dmaengine+bounces-11511-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 08:26:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5845B683C75
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 08:26:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hIW4Af6C;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11511-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11511-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AE4E300331D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 06:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE2F3B0AE6;
	Mon, 15 Jun 2026 06:22:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647D3AFAEB
	for <dmaengine@vger.kernel.org>; Mon, 15 Jun 2026 06:22:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504528; cv=none; b=AnMMZQWYYlskHLZOiAMiW9vXNV/H6Inif+6CXB+yy0B/VqYWl7oZRE0acIvEwNXUaaC4/2AAVX5iOjVcwfGtGg7dotAZkuPZdty+N8k7hz4w/udTc4v8IDp/URsM2ynsKsk2B89OT+L8EHeHeCsJ/z36J3UiALERbQ1ull1T5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504528; c=relaxed/simple;
	bh=T+vBjoPDcEAhxZPAFsgE0xD3RbCax6rZpasCcXRqCJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PJ1R9Dr0V06yO6aOeKXmrjc4Y1RMO/j08RHCWfMIWjcbsdclDZiJw3nwA+HHc+5mEcr3o310JxqBpWGTSxEbK8HqV5MOmjsTCr7uRrkdv3m6JF4OAsh155Gkn84hzDPX3YxsusmzqYJFsiv1/7WkHmMHbZmfVH8eDcNJePceCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIW4Af6C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC721F000E9;
	Mon, 15 Jun 2026 06:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781504527;
	bh=RATJlK9yutOq4jjOrjOp9/oikwD6rLWAamaMrejt+Ls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hIW4Af6CvIPH/muTt/gasi0dYTGDD51HD2nz5QXdyAKemJf3b1j/ip03e4ZDo7fog
	 4UWfCbtY+VdSMGk3LQzAJj1yIVa9Sf6dxLmyXwrgOkuxZIRBd5S/3CKVhJsKRQXq2O
	 gH5EZXqZzmTp4PGPvj3XW1MSseWVIWRkxW1BpGbY4cdl9H5nDorI+z8OKvf+nNpw5r
	 uwf231dBtVcUQcxRWxO+A8guzTtK5cyUO7mjVcyDZzuI2eo91oObwELCvei/OAqcUH
	 Cy15jmpn2gobsmg+LjdYPCRu2Gm0E4GgI9Z/duOFHSTpoLHBf6bWPNSLjwY5cXRa6H
	 OWjSXhHyh5uvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] dmaengine: qcom: bam_dma: Fix command element mask
 field for BAM v1.6.0+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Varadarajan Narayanan" <varadarajan.narayanan@oss.qualcomm.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260615060908.1263171-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260615060908.1263171-1-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:22:06 +0000
Message-Id: <20260615062206.EDC721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11511-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:varadarajan.narayanan@oss.qualcomm.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5845B683C75

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The QPIC NAND driver explicitly restricts the coherent DMA mas=
k to 32 bits but fails to restrict the streaming DMA mask, allowing streami=
ng mappings to return addresses >4GB which are then silently truncated to 3=
2 bits, causing DMA memory corruption.
--

commit d15e0af034d65bcfce2ab8e3f8608f0913f11a7c
Author: Md Sadre Alam <md.alam@oss.qualcomm.com>

dmaengine: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+

This commit updates the BAM DMA driver to correctly handle the command
element mask field for BAM v1.6.0 and later. For read commands, the mask is
now set to 0 to support 32-bit addressing, while write commands retain the
0xffffffff mask.

> diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_ba=
m_dma.h
> index 68fc0e643b1b9..d9d07a9ab3132 100644
> --- a/include/linux/dma/qcom_bam_dma.h
> +++ b/include/linux/dma/qcom_bam_dma.h
[ ... ]
> @@ -50,7 +57,11 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 a=
ddr,
>  	bam_ce->cmd_and_addr =3D
>  		cpu_to_le32((addr & 0xffffff) | ((cmd & 0xff) << 24));
>  	bam_ce->data =3D data;
> -	bam_ce->mask =3D cpu_to_le32(0xffffffff);
> +	if (cmd =3D=3D BAM_READ_COMMAND)
> +		bam_ce->mask =3D cpu_to_le32(0x0); /* 32-bit addressing */

[Severity: Critical]
This is a pre-existing issue, but does hardcoding the upper address bits
to zero here cement a silent truncation bug caused by the QPIC NAND driver?

In drivers/mtd/nand/qpic_common.c:qcom_nandc_alloc(), the driver sets the
coherent DMA mask to 32 bits, but does not restrict the streaming DMA mask:

	ret =3D dma_set_coherent_mask(nandc->dev, DMA_BIT_MASK(32));
	if (ret) {
		dev_err(nandc->dev, "failed to set DMA mask\n");
		return ret;
	}

On modern 64-bit systems, dma_map_single() can map streaming buffers to
physical addresses above 4GB. When qcom_prep_bam_dma_desc_cmd() prepares the
BAM descriptor:

	if (read)
		bam_prep_ce(&bam_ce_buffer[i],
			    offset, BAM_READ_COMMAND,
			    reg_buf_dma_addr(nandc, (__le32 *)vaddr + i));

The potentially >4GB physical address is passed as the 'data' argument to
bam_prep_ce(). However, 'data' is strongly typed as u32, silently dropping
the upper 32 bits in C:

static inline void
bam_prep_ce(struct bam_cmd_element *bam_ce, u32 addr,
	    enum bam_command_type cmd, u32 data)

With this patch explicitly hardcoding bam_ce->mask to 0 (upper 4 bits), the
BAM hardware will unconditionally execute the DMA write at the incorrect,
truncated 32-bit physical address. Could this lead to silent memory
corruption instead of raising a fault when a buffer resides above 4GB?

Should the QPIC NAND driver be updated to use dma_set_mask_and_coherent()
to properly restrict both masks and ensure the use of DMA bounce buffers?

> +	else
> +		bam_ce->mask =3D cpu_to_le32(0xffffffff); /* Write mask */
> +	bam_ce->reserved =3D 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615060908.1263=
171-1-varadarajan.narayanan@oss.qualcomm.com?part=3D1

