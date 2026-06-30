Return-Path: <dmaengine+bounces-11897-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pckJLqghRGqLpAoAu9opvQ
	(envelope-from <dmaengine+bounces-11897-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 22:06:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C16E7B97
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 22:05:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=goodmis.org (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11897-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11897-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFBA6302DFA0
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547113E0750;
	Tue, 30 Jun 2026 20:05:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA43E120E;
	Tue, 30 Jun 2026 20:05:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849956; cv=none; b=l5pKg9f3M5sDkuoHTo9wUJICkw5dgvIYjBHP2rvEFap0Tvxg6FQ1jWUn1AOS6xZh4+FI1BlQCroRAaTuBPra4fj6f3RkIGv2IqJISnhxzBEzJKJoGzXkUCT7Su2CrPyFFkMQq7Qfu8JMRfqagtv85IUoeFsunrPM6q6GZfUTE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849956; c=relaxed/simple;
	bh=wXYrBA7wmIUWDjv7Lixw4Gt/wHmHBy2BN8qiBfevZt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJcfxvfOLUx3YoCUM7y6Jec6gBe8L2J0pi8Q/ufwMwKsDAxlEL7ohklz7SojM9oV0FU9va6Y5y90o5UDsi1V6OYGtkmaiLBym5GxWBj5HmD9cyAFNVch75iUafgLNqOXmrAzKYy0FVW1q/UsgvuzVwVs9ws7E8dCPWz++z329Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id E57121C3413;
	Tue, 30 Jun 2026 20:05:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id DE02831;
	Tue, 30 Jun 2026 20:05:44 +0000 (UTC)
Date: Tue, 30 Jun 2026 16:05:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, imx@lists.linux.dev,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH] fsl-edma: tracing: no ptr dereference during log output
Message-ID: <20260630160544.4211ae88@gandalf.local.home>
In-Reply-To: <20260630200022.1826420-1-martin@kaiser.cx>
References: <20260630200022.1826420-1-martin@kaiser.cx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g4df88d511wstq86nawngj5kw7buwgb3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18rnJGZ54CSFm+gk+R9JZcXV5ATx/xQG94=
X-HE-Tag: 1782849944-709085
X-HE-Meta: U2FsdGVkX1/3O4ac0gpDF0BpWm6kNKMSKML84U3v58SolETU9Nt/Ld+9rXAcXH4l/Vb+7aJNwPlECYMSz/1708tmCDYOBKxokGY9RzZAA5ZSaWOOMqesVS8FPtoHydlTyI4VCY+QfGO2Ui0WJMlStse5Jsl2dUOxrERq0jOsnHUB7/jSWt7/TLzNqd2EDR7Rkm7fIAXQPvLxPsG3lHkCVYhrvurwZH69O7Z65FKWVB1A7s8QspHAu5W7SgxyUMZKQG3+otwl26/RZk3s9jNbkqqSsYJzQSN6qpj/vdmNVmVfRpYjU2fcCstS/FiiIhhG/tkq4TjJGQjIiX3FxiZx+d2WbjYD6zRVGtay90Q8GZKuGNf8WdVfgssvTtGOh5Mf67rSkZAEYSkBCKqfYiJbAw==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11897-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin@kaiser.cx,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:mhiramat@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rostedt@goodmis.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kaiser.cx:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA2C16E7B97

On Tue, 30 Jun 2026 22:00:11 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> The fsl edma events store a pointer to a struct fsl_edma_engine in the
> ringbuffer and dereference it when a log entry is printed. At this time,
> the pointer may no longer be valid.

Nice catch.

> 
> Event injection can be used to trigger a crash:
> 
> $ cd /sys/kernel/tracing
> $ echo 'value = 0' > events/fsl_edma/edma_writeb/inject
> $ cat trace
> 
> The log output needs only edma->membase. Add a membase field at the end
> of the event and use the new field for log output. Keep the existing
> fields for backward compatibility.
> 

Cc: stable@vger.kernel.org

> Fixes: 11102d0c343b ("dmaengine: fsl-edma: add trace event support")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

> ---
>  drivers/dma/fsl-edma-trace.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
> index d3541301a247..45d964a3726d 100644
> --- a/drivers/dma/fsl-edma-trace.h
> +++ b/drivers/dma/fsl-edma-trace.h
> @@ -19,14 +19,16 @@ DECLARE_EVENT_CLASS(edma_log_io,
>  		__field(struct fsl_edma_engine *, edma)
>  		__field(void __iomem *, addr)
>  		__field(u32, value)
> +		__field(void __iomem *, membase)
>  	),
>  	TP_fast_assign(
>  		__entry->edma = edma;
>  		__entry->addr = addr;
>  		__entry->value = value;
> +		__entry->membase = edma->membase;
>  	),
>  	TP_printk("offset %08x: value %08x",
> -		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
> +		(u32)(__entry->addr - __entry->membase), __entry->value)

Hmm, I think I should update the TP_printk checks at boot to cover this too.

-- Steve

>  );
>  
>  DEFINE_EVENT(edma_log_io, edma_readl,


