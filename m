Return-Path: <dmaengine+bounces-9623-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CkhMT2BwmlneQQAu9opvQ
	(envelope-from <dmaengine+bounces-9623-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:19:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E08453080BE
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57E51306643A
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5453F0A9A;
	Tue, 24 Mar 2026 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xvs+ehkT"
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B303EF673;
	Tue, 24 Mar 2026 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353895; cv=none; b=DlLiYQe+CxMFulH7yuxquPh7BNnSJRpZFvmg19JvADo87D02t+oq1Zc5JrDPnB0YTr/o0wdq/7yy6fuIpeyZndxMVVKGP7SirFSwkcMW9HCh1F8hC7+MAPrOPc4HuKVtDZGFo4saRvmH23bVFpTuUYJoYNO1kadzFDP7syJR7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353895; c=relaxed/simple;
	bh=NaxP08zN77vip4UHQcZc9oRFoOqkd9B8OMX9MCY9/aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVBhaqNezjoE84kgqtigD6ozse3sM3vr8RnwChmfiy/cdT80m9X/mAcoZ7Gk9RTmVRSC0/IgYbGMOO+OURxmraHZpoyrz2TBZtMkD9qkbAq9kNuoKPSrSwM4cL/KyDHiH/G2aBmMSVpJVTRI71QjBnQSPPc5aGaWwMHq1L3beqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xvs+ehkT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 905761476;
	Tue, 24 Mar 2026 05:04:45 -0700 (PDT)
Received: from [10.57.76.67] (unknown [10.57.76.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D39A43FAF5;
	Tue, 24 Mar 2026 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774353891; bh=NaxP08zN77vip4UHQcZc9oRFoOqkd9B8OMX9MCY9/aA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xvs+ehkTEbm++1ybxYpV14cv2yuqzKIiK0wyP5KiiCdFXoq7zayhc+Vzlhnj9zGg4
	 hejDcnIrWIJywFqKikarNMB0nNMfiF8fC4OtqxShqaYEv/kqYE0jTpH+Dv0evtFAFT
	 xLZOjTgQZQyNw1UxK6L93VdLCJyoCpx+nDRGlzT4=
Message-ID: <c91176d1-851a-4cf5-b7dc-cde431a8326e@arm.com>
Date: Tue, 24 Mar 2026 12:04:44 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: dma: arm-dma350: document generic and
 combined IRQ topologies
To: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260323114822.1925869-1-jun.guo@cixtech.com>
 <20260323114822.1925869-2-jun.guo@cixtech.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260323114822.1925869-2-jun.guo@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9623-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: E08453080BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-23 11:48 am, Jun Guo wrote:
> Update the DMA-350 DT binding to match the current driver behavior.
> 
> Allow both:
> - "arm,dma-350" as the generic compatible, and
> - "cix,sky1-dma-350", "arm,dma-350" for SoC-specific fallback usage.
> 
> Also document interrupt topology variants supported by hardware
> integration:
> - one combined interrupt for all channels, or
> - one interrupt per channel (up to 8 channels).

To repeat myself for the 3rd time, this is at best unnecessary, and at 
worst arguably wrong. Here's an example of a system which happens to use 
the combined interrupt from another IP block which also offers both options:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/imx8qm.dtsi#n279

Same thing here; each channel is a distinct interrupt source, so it is 
perfectly honest to describe that consistently in DT, regardless of 
whether or not the interrupt signals are still distinct by the time they 
reach the interrupt controller.

Furthermore, in this case the IRQ_COMB_NONSEC interrupt actually has 
additional functionality beyond just being a mux of the individual 
IRQ_CHANNEL interrupts. So although Linux probably won't ever care, if 
it's going to be in the DT binding then it should really be distinct 
from the channel interrupts anyway, since systems could well wire them 
*all* up, and an OS could choose to use the IRQ_CHANNEL outputs directly 
for individual channel completion/error status, while also using the 
IRQ_COMB_NONSEC just for its overall INTR_ALLCH{STOPPED,PAUSED,IDLE} status.

If you only want to make your thing work in Linux, all that is needed is 
a 1-line change in the driver to enable the INTR_ANYCHINTR bit (which as 
I've also said before, we can do unconditionally because we're *not* 
using the other INTR_ALLCH stuff), and to write your DT using the 
existing binding. "One interrupt per channel" already carries no 
expectation that they all have to be *different* interrupts.

Thanks,
Robin.

> Assisted-by: Cursor: GPT-5.3-Codex
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> ---
>   .../devicetree/bindings/dma/arm,dma-350.yaml  | 34 +++++++++++++------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> index 429f682f15d8..47091614d1b4 100644
> --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> @@ -14,7 +14,14 @@ allOf:
>   
>   properties:
>     compatible:
> -    const: arm,dma-350
> +    description:
> +      Use "arm,dma-350" for generic integration. A SoC-specific
> +      compatible may be listed first, followed by "arm,dma-350".
> +    oneOf:
> +      - const: arm,dma-350
> +      - items:
> +          - const: cix,sky1-dma-350
> +          - const: arm,dma-350
>   
>     reg:
>       items:
> @@ -22,15 +29,22 @@ properties:
>   
>     interrupts:
>       minItems: 1
> -    items:
> -      - description: Channel 0 interrupt
> -      - description: Channel 1 interrupt
> -      - description: Channel 2 interrupt
> -      - description: Channel 3 interrupt
> -      - description: Channel 4 interrupt
> -      - description: Channel 5 interrupt
> -      - description: Channel 6 interrupt
> -      - description: Channel 7 interrupt
> +    maxItems: 8
> +    description:
> +      Either one interrupt per channel (8 interrupts), or one
> +      combined interrupt for all channels.
> +    oneOf:
> +      - items:
> +          - description: Channel 0 interrupt
> +          - description: Channel 1 interrupt
> +          - description: Channel 2 interrupt
> +          - description: Channel 3 interrupt
> +          - description: Channel 4 interrupt
> +          - description: Channel 5 interrupt
> +          - description: Channel 6 interrupt
> +          - description: Channel 7 interrupt
> +      - items:
> +          - description: Combined interrupt shared by all channels
>   
>     "#dma-cells":
>       const: 1


