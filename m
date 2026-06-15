Return-Path: <dmaengine+bounces-11503-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8KLgAcFSL2rd+QQAu9opvQ
	(envelope-from <dmaengine+bounces-11503-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 03:17:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9F5682B79
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 03:17:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fsEMYjGj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11503-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11503-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C890D3011C61
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 01:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31616239E80;
	Mon, 15 Jun 2026 01:15:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22119D074;
	Mon, 15 Jun 2026 01:15:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486120; cv=none; b=mCKstc/3u03mJO2ZNphceqrfgqFDg3TpoZor5m9xMqMzv0lRsmiZZCA3LpefrSxL96O8ckjBWATLXQLh8fFumWy5JetxYjQZ0UzA7GsnD1QMw+hUqa4BnSfIgrwXB/OesraAZ6kt6DPbTRklS1q58W1uRq+/e1SAT1MJwjHu/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486120; c=relaxed/simple;
	bh=+SKzSkSy7soYPj7GRxVW99YY/MGv5sWxmACFX5LVZxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCStiog3wst0Ija9C2Ha+wDCXI8D27aaNc4qyl03xbmoC4OsqbHcEevTsfC2OQ+Bl5sg70aNDynC5mc8giBKE+hGxBBPqmp5WznUl40kTw0bb0++RIXYpzbs9nVe5ofBL2fO6GkNvesjWnziSv9pP+qg/M7bX8SdgATQgHoSVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsEMYjGj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ED21F000E9;
	Mon, 15 Jun 2026 01:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781486118;
	bh=hGK8hBUI3VJwq85vtwBACfkguai9KZPSsva45uV6o8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fsEMYjGjf5tatKUMlRl+xWUzn0TKC1A34OI58zH3ZiUeMP2E8i4XmYEF87azothCT
	 9ek/9edj0jdsw9MFuK0kdpL20DR/mrms3qf470wYg2dgDQMMLKuGiT+wtQC2CJ1Irt
	 96X//sIvLVuP+AkmQ0rprEtDV7ONEE16OC7YKbdfa/4SJQpcPKU3GG6uXYfpjXgY+f
	 I1Dmgx/k3D8GpNaVwMuXYGflsHsWx4bWJeJJncMX1cWGQlBwSC8HCkXKIj+MO+ipx2
	 DDfVNbPIp01h4wy3Ycnx1wRs7HXgWPn6Sr/emkSffsx9YueSBT6T8VPHDqHIq2NVf1
	 RSOoraI21QF8Q==
Date: Mon, 15 Jun 2026 01:15:16 +0000
From: Yixun Lan <dlan@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH v3] riscv: dts: spacemit: Use symbolic PDMA request
 numbers on K1
Message-ID: <20260615011516-GKB1002079@kernel.org>
References: <20260611-b4-k1-pdma-req-macros-v3-1-ae8416052571@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611-b4-k1-pdma-req-macros-v3-1-ae8416052571@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11503-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[dlan@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:docular.xu@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:docularxu@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B9F5682B79

Hi Guodong,
 The patch itself looks good to me, only few minor comments

On 09:17 Thu 11 Jun     , Guodong Xu wrote:
> Add a local DTS header, k1-pdma.h, that gives symbolic names to the K1
> PDMA request numbers. These request numbers are hardware-fixed; their
> allocation can be found in K1 manual.
> 
..
> Replace the hard-coded numbers in the SPI3 "dmas" property with the
> K1_PDMA_SPI3_RX/TX macros.
> 
As it's too obvious that people can tell from the diff, then I feel it's
unnecessary to repeat in commit message..

> Signed-off-by: Guodong Xu <docular.xu@gmail.com>
> ---
> Add a local DTS header naming the K1 PDMA request lines and convert the
> current user (the K1 SPI3 node) to the new K1_PDMA_* macros.
..
> The request
> numbers come from the SpacemiT K1 User Manual [1], Chapter 9.4.3 DMA
> Connectivity & Assignments.
> 
I'd suggest to put above into commit message, as more detailed description.
Here is my attempt to slightly reconstruct the commit message:

The PDMA request numbers (DRQ) are fixed values specific to the SoC from a
hardware perspective. The detailed definition can be found in K1 User Manual,
Chapter 9.4.3 DMA Connectivity & Assignments. Add a DTS header file to define
the symbolic names for the DRQs of non-secure DMA peripherals.

> [1]: https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k1/k1_docs/k1_usermanual/9.Top_System.md
> 
> Changes in v3:
> - Move the request-number macros from include/dt-bindings/dma/ to a local
>   DTS header arch/riscv/boot/dts/spacemit/k1-pdma.h (Conor).
> - Squash the header and its user into a single patch.
> - Link to v2: https://patch.msgid.link/20260609-b4-k1-pdma-req-macros-v2-0-5d5d7b997b54@gmail.com
> 
> Changes in v2:
> - Drop the #dma-cells description change in spacemit,k1-pdma.yaml; the request
>   numbers are hardware-fixed and unused by the driver (Conor)
> - Link to v1: https://patch.msgid.link/20260607-b4-k1-pdma-req-macros-v1-0-5b2a3955007c@gmail.com
> 
> BR,
> Guodong Xu
> ---
>  arch/riscv/boot/dts/spacemit/k1-pdma.h | 56 ++++++++++++++++++++++++++++++++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi   |  4 ++-
>  2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-pdma.h b/arch/riscv/boot/dts/spacemit/k1-pdma.h
> new file mode 100644
> index 0000000000000..65112d5847add
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1-pdma.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * This header provides DMA request number for non-secure peripherals of
> + * SpacemiT K1 PDMA.
slightly less redundant,
  DMA request number (DRQ) defintion for non-secure peripherals

> + *
> + * Copyright (c) 2026 Guodong Xu <docular.xu@gmail.com>
> + */
> +
> +#ifndef _DTS_SPACEMIT_K1_PDMA_H
> +#define _DTS_SPACEMIT_K1_PDMA_H
> +
> +#define K1_PDMA_UART0_TX	3
> +#define K1_PDMA_UART0_RX	4
> +#define K1_PDMA_UART2_TX	5
> +#define K1_PDMA_UART2_RX	6
> +#define K1_PDMA_UART3_TX	7
> +#define K1_PDMA_UART3_RX	8
> +#define K1_PDMA_UART4_TX	9
> +#define K1_PDMA_UART4_RX	10
> +#define K1_PDMA_I2C0_TX		11
> +#define K1_PDMA_I2C0_RX		12
> +#define K1_PDMA_I2C1_TX		13
> +#define K1_PDMA_I2C1_RX		14
> +#define K1_PDMA_I2C2_TX		15
> +#define K1_PDMA_I2C2_RX		16
> +#define K1_PDMA_I2C4_TX		17
> +#define K1_PDMA_I2C4_RX		18
> +#define K1_PDMA_SPI3_TX		19
> +#define K1_PDMA_SPI3_RX		20
> +#define K1_PDMA_I2S0_TX		21
> +#define K1_PDMA_I2S0_RX		22
> +#define K1_PDMA_I2S1_TX		23
> +#define K1_PDMA_I2S1_RX		24
> +#define K1_PDMA_UART5_TX	25
> +#define K1_PDMA_UART5_RX	26
> +#define K1_PDMA_UART6_TX	27
> +#define K1_PDMA_UART6_RX	28
> +#define K1_PDMA_UART7_TX	29
> +#define K1_PDMA_UART7_RX	30
> +#define K1_PDMA_UART8_TX	31
> +#define K1_PDMA_UART8_RX	32
> +#define K1_PDMA_UART9_TX	33
> +#define K1_PDMA_UART9_RX	34
> +#define K1_PDMA_I2C5_TX		35
> +#define K1_PDMA_I2C5_RX		36
> +#define K1_PDMA_I2C6_TX		37
> +#define K1_PDMA_I2C6_RX		38
> +#define K1_PDMA_I2C7_TX		39
> +#define K1_PDMA_I2C7_RX		40
> +#define K1_PDMA_I2C8_TX		41
> +#define K1_PDMA_I2C8_RX		42
> +#define K1_PDMA_CAN0_RX		43
> +#define K1_PDMA_QSPI_RX		44
> +#define K1_PDMA_QSPI_TX		45
> +
> +#endif /* _DTS_SPACEMIT_K1_PDMA_H */
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index 08a0f28d011fe..7d414e15d2cc2 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -6,6 +6,8 @@
>  #include <dt-bindings/clock/spacemit,k1-syscon.h>
>  #include <dt-bindings/phy/phy.h>
>  
> +#include "k1-pdma.h"
> +
>  /dts-v1/;
>  / {
>  	#address-cells = <2>;
> @@ -1094,7 +1096,7 @@ spi3: spi@d401c000 {
>  				clock-names = "core", "bus";
>  				resets = <&syscon_apbc RESET_SSP3>;
>  				interrupts = <55>;
> -				dmas = <&pdma 20>, <&pdma 19>;
> +				dmas = <&pdma K1_PDMA_SPI3_RX>, <&pdma K1_PDMA_SPI3_TX>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> 
> ---
> base-commit: 793cc54475b49b5b558902b5c13e4bfe66530a50
> change-id: 20260607-b4-k1-pdma-req-macros-8d276d0126df
> 
> Best regards,
> --  
> Guodong Xu <docular.xu@gmail.com>
> 

-- 
Yixun Lan (dlan)

