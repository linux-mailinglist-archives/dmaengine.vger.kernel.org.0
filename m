Return-Path: <dmaengine+bounces-10224-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIt8EhNG+mmOLwMAu9opvQ
	(envelope-from <dmaengine+bounces-10224-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 21:33:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EC4D3245
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 21:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D1923037DF2
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 19:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355EE3D7D9B;
	Tue,  5 May 2026 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O03hXGwu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12527271441;
	Tue,  5 May 2026 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009612; cv=none; b=FW67op5qxgJkW4spk08tSrGpVAFcueEZs7/qzFhyFVzGqSMdK2sCyViWPgc3cCqe5eibCM5bHgMFYdxeE37u4WFZ7PIJgshQhrTUAMUYBTyxq3Cgm84vSSTgJx9CZxidkrMPxB/SP1hYpVTIkAy5nhILBhDGE7TbyYPQBOxMIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009612; c=relaxed/simple;
	bh=f7ktUdcZvJc27f8PTHxlczZmATUtC+QYHKgPu9Q4XdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mMy3KhVYEGzkbNEKNEEaSJru3sNRvR44slWqsRLMA0sOuWrwrBYFQwzztH2FAu0D4AejlhwNS2QZSQqDZSV0UNjQIFgjC6JD5FKdLUU9RaZlcsGkMaS0Yjqu+T3N+1XC7BEtUo7D8fNG3E1AI9/ECyX+c1NNagc/KquT/5FN4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O03hXGwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2202DC2BCB4;
	Tue,  5 May 2026 19:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778009611;
	bh=f7ktUdcZvJc27f8PTHxlczZmATUtC+QYHKgPu9Q4XdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=O03hXGwuP6s7cljp4ececAc3RBgZkK0x3Fytpj8e5KnKhBLhsBfGDXms7YFU62yVa
	 eEicIpkoQBauimSlvLGsLtqBtU3nC0mo7cBNL/uNfv899uHueaHzI5Sbt3u1vzLiko
	 XzPuaG581n1WHt9MbeT61x4Wj+CD+q2YWL8M8oxlRpRYaZXGgZiStqwTkM+K/HLG2v
	 i7as8XvW+eVdzHgylEI5SRMt5Gg36RShifHbXWl+2wS7ix5ibZUPtAWWKWSrwr3y8o
	 pH5I80e3ooAgIu3yNU7OrgwntDpyL8TpXBsTsf+ZNWV6CcUo7TeIvFSsMdNywOeTIe
	 0WuvppwcxI/Sg==
From: Thomas Gleixner <tglx@kernel.org>
To: Rahul Sharma <r-sharma3@ti.com>, peter.ujfalusi@gmail.com,
 vkoul@kernel.org, Frank.Li@kernel.org, nm@ti.com, kristo@kernel.org,
 ssantosh@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip: ti-sci-inta: add runtime PM and system
 sleep support
In-Reply-To: <20260429174904.4049243-3-r-sharma3@ti.com>
References: <20260429174904.4049243-1-r-sharma3@ti.com>
 <20260429174904.4049243-3-r-sharma3@ti.com>
Date: Tue, 05 May 2026 21:33:28 +0200
Message-ID: <87h5oly7lj.ffs@tglx>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 913EC4D3245
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10224-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[ti.com,gmail.com,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29 2026 at 23:19, Rahul Sharma wrote:

Please use the proper subsystem prefix as documented:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> Register runtime PM callbacks and enable runtime PM via
> devm_pm_runtime_enable() in probe.
>
> runtime_suspend is a no-op; IRQ routing context is preserved by TI SCI

s/IRQ/Interrupt/

A change log is written in prose and not an aggregation of random
acronyms. This is not twatter.

> firmware across power-gate cycles.
>
> runtime_resume restores VINT_ENABLE_SET for each active event bit,
> skipping IRQs with irqd_irq_masked set to avoid re-enabling
> intentionally disabled interrupts.
>
> System sleep reuses these callbacks via pm_runtime_force_suspend/resume
> as late/early sleep ops. This ensures MMIO writes in runtime_resume
> happen after genpd restores the power domain (dpm_resume_noirq),
> avoiding writes to a powered-off device.

TBH, I fails to decode the above word salad. Please check the above
linked documentation for hints how to structure change logs.

 
> +static int ti_sci_inta_runtime_suspend(struct device *dev)
> +{
> +	return 0;

This clearly lacks a comment why this function is empty, while the
counterpart is not.

> +}
> +
> +static int ti_sci_inta_runtime_resume(struct device *dev)
> +{
> +	struct ti_sci_inta_irq_domain *inta = dev_get_drvdata(dev);
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +	int bit;
> +
> +	mutex_lock(&inta->vint_mutex);

  guard(mutex)(....);

> +	list_for_each_entry(vint_desc, &inta->vint_list, list) {
> +		for_each_set_bit(bit, vint_desc->event_map, MAX_EVENTS_PER_VINT) {
> +			unsigned int virq;
> +			struct irq_data *data;

See 'Variable declarations' in the linked document

> +			virq = irq_find_mapping(vint_desc->domain,
> +						vint_desc->events[bit].hwirq);

No line break required. You have 100 characters.

> +			if (!virq)
> +				continue;
> +			data = irq_get_irq_data(virq);
> +			if (!data || irqd_irq_masked(data))
> +				continue;


This is a blatant abuse of the interrupt internals.

Why can't you keep track of the current state in

    vint_desc->events[bit].XXXXX

and be done with it?

> +			writeq_relaxed(BIT(bit), inta->base +
> +				       vint_desc->vint_id * 0x1000 +
> +				       VINT_ENABLE_SET_OFFSET);

Ditto.

> +		}
> +	}
> +	mutex_unlock(&inta->vint_mutex);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ti_sci_inta_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				     pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(ti_sci_inta_runtime_suspend,
> +			   ti_sci_inta_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id ti_sci_inta_irq_domain_of_match[] = {
>  	{ .compatible = "ti,sci-inta", },
>  	{ /* sentinel */ },
> @@ -736,6 +784,7 @@ static struct platform_driver ti_sci_inta_irq_domain_driver = {
>  	.driver = {
>  		.name = "ti-sci-inta",
>  		.of_match_table = ti_sci_inta_irq_domain_of_match,
> +		.pm = pm_ptr(&ti_sci_inta_pm_ops),

See 'Struct declarations and initializers' ....

Thanks,

        tglx

