Return-Path: <dmaengine+bounces-9462-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH1VAtUpuWkAtAEAu9opvQ
	(envelope-from <dmaengine+bounces-9462-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:15:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 552CD2A7AC2
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C65C300A122
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CD53A2576;
	Tue, 17 Mar 2026 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUvrlQuf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA123A2558
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742178; cv=none; b=MsHTFGRBqk7AM/42dp8pUyRIV+g0xjsWqmJrHpCKebGO6l8QJ9y1vMvfidHepe81MesM8JpfXdJZHhk7eSph+E3oAY3BZFB1aZ5zv2O1M/UVzqioeWO4wGyZlcVhgG35ZfkPraJCxeoEA9n51DZezm/VbK8coXjVBkKeyonF+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742178; c=relaxed/simple;
	bh=LIhGFyCIOjg4LNq1e6/71f3wJJmnujhv+BuOhuk1byQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaDViScXJYfyc03YbdALthtUTA5HlYM1C+61qhGAnjthqFRqqFg33Xko9wk64V1NhwIsPErWsXRa2H9e46iXUThMqoPQ8WOaKZXaK+ftaGWjdAbufrlgpRa2oXLdSaimY8b5lTbfWrShNIG/kH2dp2JlMqi5swXogXsgPq231yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUvrlQuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A77C4CEF7;
	Tue, 17 Mar 2026 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773742177;
	bh=LIhGFyCIOjg4LNq1e6/71f3wJJmnujhv+BuOhuk1byQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUvrlQufWtjTwbgPVQuB8DYiWnkvzuxgtJHwfBdCrEsdtqhXOIltmAsdYlvYFreKo
	 xkCAO5p4mopPb7MhfJ1PH3HcCtJhMm80HCEF8/XztWKIl20VBFLcjPPpPHr/SsXpA9
	 JxjSQX63XsuOR/MHvAlV80cgYwVBSlETyn6uK1GkdBBat2zsT/JC3lr9KTwuZ0ECpj
	 yq9FyFfUNpegbCskLrOaUxShLaClSltP1Bs3324c4GY+CO7ld1F8KqZGUPFO953PN9
	 PAJ8KQWScYnDyi6lHf5ycmIN6jjxp9YXLXk49mkzrO/14OgskB2WzPs83ET6eaGjyt
	 qGAfenmLcT2MQ==
Date: Tue, 17 Mar 2026 15:39:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: dmaengine@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 0/5] dmaengine: dma-axi-dmac: Add cyclic transfer
 support and graceful termination
Message-ID: <abkoXXbaxaiqbBuX@vaman>
References: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
 <177304239096.87946.15531982345548560058.b4-ty@kernel.org>
 <c4e7e6f071ce0e7dfdd624b3b31077e2b0f4e454.camel@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4e7e6f071ce0e7dfdd624b3b31077e2b0f4e454.camel@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9462-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 552CD2A7AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 09-03-26, 13:30, Nuno Sá wrote:
> On Mon, 2026-03-09 at 08:46 +0100, Vinod Koul wrote:
> Thanks for applying the patches. Since I have you here and if you have 5 min I would like to
> ask you for some clarifications. It seems there's a bit of a confusion regarding src_addr_widths
> and dst_addr_widths. For instance the docs say the following:
> 
> " bit mask of src addr widths the channel supports.
> Width is specified in bytes, e.g. for a channel supporting
> a width of 4 the mask should have BIT(4) set."
> 
> And I suspect that BIT(4) is leading into some confusion. Like, if I have a width of 4, then my
> mask should look like 0x04 and not 0x20, right? Like the code in [1] looks suspicious to me... And
> it seems that pattern is followed in a lot of other places. If I look at [2], then it looks more
> with what I would expect.
> 
> Like, if the correct way is 1), then it means that 64bytes is not really possible right now given
> that BIT(64) is UB and that looks a bit limitating and odd to me. That and given that the AXI_DMAC
> might also suffer from a, possible bug, made me want to clarify this.

If you look at the field it documents "@src_addr_width: this is the width in bytes of the source (RX)
 * register where DMA data shall be read. If the source is memory this
 * may be ignored depending on architecture. Legal values: 1, 2, 3, 4,
 * 8, 16, 32, 64, 128."

We cant have bitmask as 64bit wont work! So I guess lets fix it

-- 
~Vinod

