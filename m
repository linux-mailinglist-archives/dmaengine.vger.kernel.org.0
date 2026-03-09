Return-Path: <dmaengine+bounces-9337-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFoEFgV7rmnoFAIAu9opvQ
	(envelope-from <dmaengine+bounces-9337-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:47:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB104234F9A
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 08:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 793DD302F7EA
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F436AB4D;
	Mon,  9 Mar 2026 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkTEjJKA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44417369972;
	Mon,  9 Mar 2026 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042398; cv=none; b=nzf6A+f6PMaIngXGHrs18c384Yht3ovfgDtTvPUuoLXDpqVRUV222X6j/2ozH8J1ckqCczn8CAaxQe2iaoLVvlJMcidAzXzehvbvC8vx1/yE+DAi7fThVnrsX/pvtrfCVfsAMW3tvAqAqEcDON4fIKJ4ByNG/NhjYZVlD1JiwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042398; c=relaxed/simple;
	bh=Gfx1MfwYlx4ZzaXBRuAqVGdBe4bxMTLre/Ew0pibi84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nu+1XDZx6bkV5I20Y8EFDr61nBcnAAqIv1RQWid7paYWJj0o64SvBGsYgPECty2LEsp9nKIwNWpWltq5pCjunYJ7UUkP4s6wBTrG2uVMmxs8sbCiItVbPng+BlAddsFX+uPPpguwt1wh3G2/EiiBrIfkv0SNvg/WQzgdMpr2ZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkTEjJKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CD2C19423;
	Mon,  9 Mar 2026 07:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773042398;
	bh=Gfx1MfwYlx4ZzaXBRuAqVGdBe4bxMTLre/Ew0pibi84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DkTEjJKAavMRay8R1aJnwWeqdJFNfAh2qGuJQl5czfHOzlSPxWeV85z5kaXLdoKJp
	 2Fc26FPve+8P081CGqh/rrRCv8BHWzh9gDBSi5r765UCz6LRH9tI6vahNDm9kbcc88
	 lPW3m/IiWX2/V+TtmXHYiNm5tVvwfzh/UZdbu1v0ON6p8f1UIf49EFfusHauwmXPtH
	 p7yRy6YNMTevittOjlsBYo8jnjl9KokRyL+vdvhPbf+bBh7aNsY+A5hyw13qGSWYk2
	 KOwA295Qp8efUKXCTuwj7ATyCTS56nBbRpNBuOgG+OCfEUfJ6ovWUklcPE54Sd5C63
	 Wqgy5ydUlSL/Q==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org
In-Reply-To: <20260301011213.3063688-1-rdunlap@infradead.org>
References: <20260301011213.3063688-1-rdunlap@infradead.org>
Subject: Re: [PATCH] dmaengine: ti-cppi5: fix all kernel-doc warnings
Message-Id: <177304239656.87946.18319548971940689143.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 08:46:36 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: EB104234F9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9337-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action


On Sat, 28 Feb 2026 17:12:13 -0800, Randy Dunlap wrote:
> Add missing struct member, function parameter, and enum value descriptions.
> Add missing function Returns: sections.
> Use correct function name in kernel-doc to avoid mismatched prototypes.
> 
> These repair all kernel-doc warnings in ti-cppi5.h:
> 
> Warning: include/linux/dma/ti-cppi5.h:27 struct member 'pkt_info1' not
>  described in 'cppi5_desc_hdr_t'
> Warning: include/linux/dma/ti-cppi5.h:27 struct member 'pkt_info2' not
>  described in 'cppi5_desc_hdr_t'
> Warning: include/linux/dma/ti-cppi5.h:50 struct member 'epib' not
>  described in 'cppi5_host_desc_t'
> Warning: include/linux/dma/ti-cppi5.h:142 struct member 'epib' not
>  described in 'cppi5_monolithic_desc_t'
> Warning: include/linux/dma/ti-cppi5.h:413 function parameter 'pkt_len'
>  not described in 'cppi5_hdesc_set_pktlen'
> Warning: include/linux/dma/ti-cppi5.h:436 function parameter 'ps_flags'
>  not described in 'cppi5_hdesc_set_psflags'
> Warning: include/linux/dma/ti-cppi5.h:509 function parameter 'hbuf_desc'
>  not described in 'cppi5_hdesc_link_hbdesc'
> Warning: include/linux/dma/ti-cppi5.h:839 struct member 'dicnt3' not
>  described in 'cppi5_tr_type15_t'
> Warning: include/linux/dma/ti-cppi5.h:970 function parameter 'desc_hdr'
>  not described in 'cppi5_trdesc_init'
> Warning: include/linux/dma/ti-cppi5.h:184 No description found for
>  return value of 'cppi5_desc_is_tdcm'
> Warning: include/linux/dma/ti-cppi5.h:198 No description found for
>  return value of 'cppi5_desc_get_type'
> Warning: include/linux/dma/ti-cppi5.h:210 No description found for
>  return value of 'cppi5_desc_get_errflags'
> Warning: include/linux/dma/ti-cppi5.h:448 expecting prototype for
>  cppi5_hdesc_get_errflags(). Prototype was for cppi5_hdesc_get_pkttype()
>  instead
> Warning: include/linux/dma/ti-cppi5.h:460 expecting prototype for
>  cppi5_hdesc_get_errflags(). Prototype was for cppi5_hdesc_set_pkttype()
>  instead
> Warning: include/linux/dma/ti-cppi5.h:1053 expecting prototype for
>  cppi5_tr_cflag_set(). Prototype was for cppi5_tr_csf_set() instead
> Warning: include/linux/dma/ti-cppi5.h:651 Enum value 'CPPI5_TR_TYPE_MAX'
>  not described in enum 'cppi5_tr_types'
> Warning: include/linux/dma/ti-cppi5.h:676 Enum value
>  'CPPI5_TR_EVENT_SIZE_MAX' not described in enum 'cppi5_tr_event_size'
> Warning: include/linux/dma/ti-cppi5.h:693 Enum value 'CPPI5_TR_TRIGGER_MAX'
>  not described in enum 'cppi5_tr_trigger'
> Warning: include/linux/dma/ti-cppi5.h:714 Enum value
>  'CPPI5_TR_TRIGGER_TYPE_MAX' not described in enum 'cppi5_tr_trigger_type'
> Warning: include/linux/dma/ti-cppi5.h:890 Enum value
>  'CPPI5_TR_RESPONSE_STATUS_MAX' not described in enum
>  'cppi5_tr_resp_status_type'
> Warning: include/linux/dma/ti-cppi5.h:906 Enum value
>  'CPPI5_TR_RESPONSE_STATUS_SUBMISSION_MAX' not described in enum
>  'cppi5_tr_resp_status_submission'
> Warning: include/linux/dma/ti-cppi5.h:934 Enum value
>  'CPPI5_TR_RESPONSE_STATUS_UNSUPPORTED_MAX' not described in enum
>  'cppi5_tr_resp_status_unsupported'
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti-cppi5: fix all kernel-doc warnings
      commit: 70fbea9f1a44d80a4c573c225f119022d6e21360

Best regards,
-- 
~Vinod



