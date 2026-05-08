Return-Path: <dmaengine+bounces-10279-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CItLpGR/WnWfgAAu9opvQ
	(envelope-from <dmaengine+bounces-10279-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 08 May 2026 09:32:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 276784F308C
	for <lists+dmaengine@lfdr.de>; Fri, 08 May 2026 09:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCA683089178
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2026 07:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A037B407;
	Fri,  8 May 2026 07:25:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE83603F8;
	Fri,  8 May 2026 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225150; cv=none; b=gGkDLXIyRv9Etyj69sXDmovDoVKdzpu98GDeWXwTQdGRMSM2mKfOtmjYtpMZgM8kG7F0v7R8hwzYNhnjwm0riZSpqUAvZjYz+agsppurHh36YAeakKYZ75nTuinCBy+KoUNvKBve9P/N+5KL3xGn17Gjz1bLDDnzKVrqjLhQuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225150; c=relaxed/simple;
	bh=ul/domrJnnhI0nQKFDCAg1E891Gq3mhOSwdeYaKHxro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eapDU06sQLYstHVnxLKmoA3RQvzhnWDxWZ/danVz6NAH141FqbguRECy1M49MVGKOapSoGlyB7mAV7UEozW7+Kl9ZDWfxNKb0ryNK4vrOGgBM4b+vCOscvPSleLXHHP+ZhMXG/B2Sm3xDeFo1xj8QM1mOx518eS4e2FcQsqrYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.8])
	by gateway (Coremail) with SMTP id _____8Bxzenzj_1ppc4HAA--.23181S3;
	Fri, 08 May 2026 15:25:39 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.8])
	by front1 (Coremail) with SMTP id qMiowJAxVcDwj_1pZ8Z8AA--.46040S2;
	Fri, 08 May 2026 15:25:39 +0800 (CST)
Message-ID: <fd15c3f1-65a8-44e6-bb46-776f54f4a782@loongson.cn>
Date: Fri, 8 May 2026 15:25:35 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma: loongson2-apb-cmc: fix NULL deref in residue
 computation
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@nxp.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhoubb.aaron@gmail.com
References: <20260507023153.400-1-sozdayvek@gmail.com>
 <20260507175052.9711-1-sozdayvek@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20260507175052.9711-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJAxVcDwj_1pZ8Z8AA--.46040S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEBCGn9eyoBiAAAsG
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar18WFW7tr1ktFW8tr18WFX_yoW5JF1DpF
	W3AayruFW5Kr4fZ3ZxAr1FgF1UAFW5tFZrXay7W3sxWr93Ww129r1fKF90qF4UAry5ZFyj
	qFZ2g39rCF1UGacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=
X-Rspamd-Queue-Id: 276784F308C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10279-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.765];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,loongson.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Stepan.

Thanks for your patch.

On 2026/5/8 01:50, Stepan Ionichev wrote:
> loongson2_cmc_dma_desc_residue() takes a "desc" parameter that is the
> descriptor whose residue should be computed. The body uses it
> correctly via "desc->num_sgs" and "desc->sg_req[i].len", but the
> cyclic check incorrectly looks at the channel's stale current
> descriptor instead:
> 
> 	if (lchan->desc->cyclic && next_sg == 0)
> 		return residue;
> 
> This breaks when the function is called from the vdesc fallback path
> of loongson2_cmc_dma_tx_status():
> 
> 	if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie)
> 		state->residue = ...desc_residue(lchan, lchan->desc, ...);
> 	else if (vdesc)
> 		state->residue = ...desc_residue(lchan, to_lmdma_desc(vdesc), 0);
> 
> The else-if branch is taken precisely when "lchan->desc" is NULL or
> points to a different descriptor than the one being queried, so
> dereferencing "lchan->desc->cyclic" inside the helper either NULL-
> derefs or reads the wrong descriptor's flag.
> 
> smatch flags the inconsistency:
> 
>    drivers/dma/loongson/loongson2-apb-cmc-dma.c:516
>    loongson2_cmc_dma_tx_status() error: 'lchan->desc' could be
>    null (see line 512)
> 
> Use the "desc" parameter, matching how the rest of the function
> already accesses fields of the descriptor under inspection.
> 
> Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
LGTM.

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
> v2:
> - Drop "we previously assumed" from the smatch quote (Frank Li).
> - Add Fixes: tag.
> 
>   drivers/dma/loongson/loongson2-apb-cmc-dma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> index 1c9a542ed..3b02bcd75 100644
> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -487,7 +487,7 @@ static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lcha
>   	ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
>   	residue = ndtr << width;
> 
> -	if (lchan->desc->cyclic && next_sg == 0)
> +	if (desc->cyclic && next_sg == 0)
>   		return residue;
> 
>   	for (i = next_sg; i < desc->num_sgs; i++)
> --
> 2.43.0

-- 
Thanks.
Binbin


