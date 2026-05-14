Return-Path: <dmaengine+bounces-10470-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLHiGeOTBWoxYwIAu9opvQ
	(envelope-from <dmaengine+bounces-10470-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 11:20:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7FE53FB41
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 11:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1134C300FB1A
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64039A070;
	Thu, 14 May 2026 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn061cs5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1139A045;
	Thu, 14 May 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750428; cv=none; b=BYQ287wl9x5GNUWipwJLGpilNDCZeptjgvEBC2Jyk3xYVqqfRjw4+T5XVanftVWXsJnHCdAjQUJLe5+WG4TBVspYcl5QasLh4H3BDWvzfWfzIDRhPtXsEwqYkTzfTgyyDnU3cSTRNBBIwZ4LvfCo/VPqgeY2QYQo3M0N+F9ewvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750428; c=relaxed/simple;
	bh=CZ72JD/PnldUNEeBiLGzOfw+sXSrrbDJdQIbsn+9ICE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYEQelCSE7T0rfAzbdYXJ5miPVVAtXYXd9goqSxvd55dIRbB3rjbXefDLK4tQaIo9r87FFsUb6oAKHdfxu6qG2X2RzhxUmGQsvMBptIOGfGPuK3g2oBAoxIDzdx3JnRYi0P+4R79Kd3i+WDnvYT6XFwUjZwltz6FaX7f1Wv6j/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn061cs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0EEC2BCB3;
	Thu, 14 May 2026 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778750427;
	bh=CZ72JD/PnldUNEeBiLGzOfw+sXSrrbDJdQIbsn+9ICE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jn061cs5zh+OX9wjaAg4gmOYTrxa80VX1fN4qMNOcwaONSf6dbdKIsA35Lkzelzbe
	 teYN0yPBVsSZCnfq1FBN/W34uOT8xowJR+98eEJCqqstYZcAxMIM42AEUJ09rWjL4o
	 SZnCHjk5QRT6CNE61gn9rmtXjR3pw+1u3ewxFZeSaf4zhPAzyoKju0lUzwYjAHbcP5
	 myc4aTBU21Ol2I5f01b+VU5l3/0CkCWrJjMi7Gkk+XzURoCLbx+YMJgJDm+xDQ8sEc
	 CjmUU7g79+ijAu6hy/YZCS0C97s6eCO7I4iPKsgLYTDqvxjv5RqCIDVFEa4xzYLFDF
	 qMgxb6uhVDxJw==
Message-ID: <2a253460-bd6f-44d9-86ab-9f52b8545413@kernel.org>
Date: Thu, 14 May 2026 12:20:21 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/17] dmaengine: sh: rz-dmac: Add runtime PM support
To: Frank Li <Frank.li@nxp.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, fabrizio.castro.jz@renesas.com,
 kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-14-claudiu.beznea.uj@bp.renesas.com>
 <agOjwF12NI_jkOzR@lizhi-Precision-Tower-5810>
 <94430a9b-b5ae-475d-b001-e1a4ff35db8c@kernel.org>
 <agTXV0NCP7PNk570@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <agTXV0NCP7PNk570@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5E7FE53FB41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bp.renesas.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10470-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi, Frank,

On 5/13/26 22:56, Frank Li wrote:
> On Wed, May 13, 2026 at 04:39:12PM +0300, Claudiu Beznea wrote:
>> Hi, Frank,
>>
>> On 5/13/26 01:03, Frank Li wrote:
>>> On Tue, May 12, 2026 at 03:12:14PM +0300, Claudiu Beznea wrote:
>>>> Protect the driver exposed APIs with runtime PM suspend/resume calls
>>>> before accessing HW registers. As the current driver leaves runtime PM
>>>> enabled in probe, the purpose of the changes in this patch is to avoid
>>>> accessing HW registers after a failed system suspend leaves the runtime
>>>> PM state of the device improperly reinitialized.
>>>>
>>>> In that case, the driver remains bound to the device, the APIs are still
>>>> exposed, and any access to HW registers without runtime resuming the
>>>> device may lead to synchronous aborts.
>>>>
>>>> This patch prepares the driver for suspend-to-RAM support.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>
>>>> Changes in v5:
>>>> - none, this patch is new
>>>>
>>>>    drivers/dma/sh/rz-dmac.c | 48 ++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 48 insertions(+)
>>>>
>>>> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
>>>> index d6ad070be705..df91657fd5e3 100644
>>>> --- a/drivers/dma/sh/rz-dmac.c
>>>> +++ b/drivers/dma/sh/rz-dmac.c
>>>> @@ -488,7 +488,15 @@ static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
>>>>
>>>>    static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
>>>>    {
>>>> +	struct dma_chan *ch = &chan->vc.chan;
>>>> +	struct rz_dmac *dmac = to_rz_dmac(ch->device);
>>>>    	struct virt_dma_desc *vd;
>>>> +	int ret;
>>>> +
>>>> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
>>>> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
>>>> +	if (ret)
>>>> +		return;
>>>
>>> According vnod comment *_prep() call may be called in atomic context
>>> (complete callback). but runtime_pm may sleep.
>>
>> That's why the pm_runtime_irq_safe() was called in probe, to allow it being
>> called in atomic context.
>>
>> The series was tested with CONFIG_LOCKDEP=y and CONFIG_DEBUG_ATOMIC_SLEEP=y
>> no issue was identified.
> 
> I am not sure how magic it makes pm_runtime_get_sync() work under atomic
> context, suppose runtime callback involve clk_(un)prep() and power domain,
> if you call pm_runtime_irq_safe() in probe, it may makes all parent resource
> on when probe. At least it should defer to alloc chan.

The rz-dmac driver is used on platforms using drivers/clk/renesas/rzg2l-cpg.c 
and drivers/clk/renesas/rzv2h-cpg.c clock drivers.

All the platforms that supports the rz-dmac driver register always-on clock 
power domains through the above mentioned clock drivers, see [1], [2].

The genpd registered by those drivers are passing GENPD_FLAG_PM_CLK flag to the 
pm_genpd_init(). In that case the start/stop APIs of the genpd are 
pm_clk_suspend/pm_clk_resume [3].

The clocks to the rz-dmac driver are module clocks, so they are handled by [4] 
or [5] which both have the enable and disable APIs implemented, thus the 
prepare/unprepare is not going to be called through the 
pm_clk_suspend()/pm_clk_resume() functions.

Also, there is no sleep in the enable/disable APIs of those clocks.

Since the registered clock power domain is always on and the rz-dmac is marked 
as IRQ safe the genpd_lock()/genpd_unlock() (and 
genpd_power_off()/genpd_power_on()) will not be called for rz-dmac driver. 
Anyhow, the rzg2l-cpg.c and rzv2h-cpg.c are not implementing any power on/off 
APIs (they are always on power domains).

The irq_safe_dev_in_sleep_domain() calls in 
genpd_runtime_suspend()/genpd_runtime_resume() is anyway blocking any access to 
the genpd_lock()/genpd_unlock() (which may call mutex operations thought he 
genpd_mtx_ops APIs) for the rz-dmac (due to the pm_domain_irq_safe() call in 
probe) .

Also, on pm_runtime_* APIs, documentation it is mentioned (e.g. [6]):

* This routine may be called in atomic context if the RPM_ASYNC flag is set, 

* or if pm_runtime_irq_safe() has been called.

Due to all these, I consider we are safe with this approach.

Thank you,
Claudiu

[1] 
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/clk/renesas/rzg2l-cpg.c#L2013
[2] 
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/clk/renesas/rzv2h-cpg.c#L1549
[3] https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/pmdomain/core.c#L2439
[4] 
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/clk/renesas/rzg2l-cpg.c#L1560
[5] 
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/clk/renesas/rzv2h-cpg.c#L1243

[6] 
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/base/power/runtime.c#L1147


