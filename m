Return-Path: <dmaengine+bounces-9580-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AqDJaWnwGm6JgQAu9opvQ
	(envelope-from <dmaengine+bounces-9580-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 03:38:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C052EBF3E
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 03:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6776300789F
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51A18FC97;
	Mon, 23 Mar 2026 02:38:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6504E2475CF
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233507; cv=none; b=CVExoiRvyVInQ+BagSkhmmVKx9Ob5dm/PqgsPXJrMO+gmLaq3gLoi4J/PT1kN8M3CHEmShidA081l1LiNF488NdtwmQMbnOulcTZP/b9e/r40QBeYvIE7Bv9/FMJlVPtgk9CEh8fhbHcIFFK5r+LE0Z9WhX+aTC1fzatA+9/+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233507; c=relaxed/simple;
	bh=Nb+IwTau3pZ7TWcjertz8eNdXOJpt/pHHwYckR90KHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1F3knjlyJPuMTu9i5ZOeXsL6u/Gg9uqU+aLktlKA6OxnKX86mwk9i/Yz9qu/YTQ7OAeI4DGF6qWvzXmTw1N73qJBLL2m019iwt4VS+sjugjzNpYSZWE2QjuAdhkVQ+/LfMi1TCpjMnps62LAZcf2fo9AllTVSIgpkAivcJRzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.17])
	by gateway (Coremail) with SMTP id _____8AxScKTp8BpvaUdAA--.20294S3;
	Mon, 23 Mar 2026 10:38:12 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.17])
	by front1 (Coremail) with SMTP id qMiowJBxZcCSp8Bp4gtbAA--.28549S2;
	Mon, 23 Mar 2026 10:38:11 +0800 (CST)
Message-ID: <30f009ed-30bd-40e3-81fa-17e6fb61aee5@loongson.cn>
Date: Mon, 23 Mar 2026 10:38:10 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: loongson: loongson2-apb: fix broken bus width
 validation in ls2x_dmac_detect_burst()
To: David Carlier <devnexen@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org
References: <20260318164803.14351-1-devnexen@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20260318164803.14351-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJBxZcCSp8Bp4gtbAA--.28549S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEPCGm-hMQIDgAAsX
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4fArWUtw4xGFykXw48Xwc_yoW8ZrykpF
	43Way7ArWUtFy3Z3Z5Jry8XF15Cr1fGrZrWay5Kw1kZFW5Zw1I9r1rKF4jqr1UC3sYgFWS
	va4kWrW5CF1UKFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9580-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:email,loongson.cn:mid]
X-Rspamd-Queue-Id: 00C052EBF3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David:

On 2026/3/19 00:48, David Carlier wrote:
> The bus width validation check in ls2x_dmac_detect_burst() compares raw
> enum dma_slave_buswidth values (e.g. 4, 8) directly against
> LDMA_SLAVE_BUSWIDTHS, which is a BIT()-encoded bitmask
> (BIT(4) | BIT(8) = 0x110). Since 4 & 0x110 == 0 and 8 & 0x110 == 0,
> the condition is always false for valid bus widths, making the
> validation dead code.
>
> Additionally, the logic was inverted: it rejected configurations where
> both widths matched valid values, rather than rejecting when neither
> width is supported.
>
> Fix by wrapping the enum values with BIT() before masking (matching the
> pattern used in sun6i-dma.c) and inverting the logic to reject when
> neither width is supported by the hardware.
>
> Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller")
> Signed-off-by: David Carlier <devnexen@gmail.com>

That was indeed my oversight. Thanks a lot!

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>

> ---
>   drivers/dma/loongson/loongson2-apb-dma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
> index aceb069e71fc..102c01f993ef 100644
> --- a/drivers/dma/loongson/loongson2-apb-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> @@ -220,8 +220,8 @@ static size_t ls2x_dmac_detect_burst(struct ls2x_dma_chan *lchan)
>   	u32 maxburst, buswidth;
>   
>   	/* Reject definitely invalid configurations */
> -	if ((lchan->sconfig.src_addr_width & LDMA_SLAVE_BUSWIDTHS) &&
> -	    (lchan->sconfig.dst_addr_width & LDMA_SLAVE_BUSWIDTHS))
> +	if (!(BIT(lchan->sconfig.src_addr_width) & LDMA_SLAVE_BUSWIDTHS) &&
> +	    !(BIT(lchan->sconfig.dst_addr_width) & LDMA_SLAVE_BUSWIDTHS))
>   		return 0;
>   
>   	if (lchan->sconfig.direction == DMA_MEM_TO_DEV) {
Thanks.
Binbin


