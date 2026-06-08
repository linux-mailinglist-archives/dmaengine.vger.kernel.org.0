Return-Path: <dmaengine+bounces-11315-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p0KWOhizJmqAbQIAu9opvQ
	(envelope-from <dmaengine+bounces-11315-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:18:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 892AF656105
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:18:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RDsAh1RQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11315-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11315-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAB5E306097F
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8A377016;
	Mon,  8 Jun 2026 12:13:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7937B022;
	Mon,  8 Jun 2026 12:13:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920794; cv=none; b=nasMKDGobHE/PdDoXuvzDDRhNZg0M/ZefJQYACbuaXxP55wqBJI7nN7lzUZ5RDtGhDIL/HleZKMN6eT6Suz/XwFlNqBZfQdJkrQqW/qVnnECDBdjio6GDGWBrVBzBBt8oqrWv/qrugSukt3jxuHvgJGNTUEXSEi8GXpNCfSxhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920794; c=relaxed/simple;
	bh=b6mMV8Tn/OgFfeHKJy2Ivpa8WxUyu0R+c4Hzn9y6I9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TuZcmbwrG3N2thDciZ3PUuh5008K72RbDZ5gP3HB3VH+4DYyOEhXUMpaNijc5G4yp178r/2HsFbzaZFIka0G5FHvnq4njBe3KysGJ3iH3j7MVkX6kpCQKnBL3etraulvf3/7wtuCS7NIkGtkpgnlZ39K4fQzL7JDocFpZU6YtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDsAh1RQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A926F1F00893;
	Mon,  8 Jun 2026 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920792;
	bh=QvA/My2GisPFG79WgI6LJ2+9HPkay/hTnBLM2CFhnlM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RDsAh1RQJH6f4RlIWeDD1460/9vwoyFYEFDVESZ+V2UlQdGV++XD/M1dETR+v9nJA
	 D6GteQcKo1gTTJDtpKYhEPMzqOkAxjRqAhT+lk1q7G0TIUrxePhSQW1WyvFjACSwMC
	 vJwQgJgzUnfHnmTDjl22eK19k2xK27jF516GNKNwG02mC1b/fMJXAXkpiD+qlXnKlb
	 MEekG+dNjP5hUomKfYGaXtyBeM7R5Xg2nbbNNGsLdZD7UDh36DEM5ag1+0dfx0+NOI
	 iXtKrSoOO3zQvFjEvy/VjEOzb9yCf87Yp8Uy+zxVCRKEEFPLGFg2V4h+OZVU2/3lEW
	 6mEkqN1C6zWgA==
From: Vinod Koul <vkoul@kernel.org>
To: mani@kernel.org, Frank.Li@kernel.org, 
 Devendra K Verma <devverma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 michal.simek@amd.com, devendra.verma@amd.com
In-Reply-To: <20260526053111.3244488-1-devverma@amd.com>
References: <20260526053111.3244488-1-devverma@amd.com>
Subject: Re: [PATCH v2] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
Message-Id: <178092079029.96550.4461285386289829094.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:43:10 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11315-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:Frank.Li@kernel.org,m:devverma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 892AF656105


On Tue, 26 May 2026 11:01:10 +0530, Devendra K Verma wrote:
> Function dw_edma_add_irq_mask() sets the mask of the
> interrupts alloted to read / write channels in a variable.
> The mask set for read / write channels is niether used nor
> this function is called else where, making it redundant.
> The redundant function can be removed safely as it is
> not affecting anything.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
      commit: 57e766bd3ddb2495d80952ad4fc723fb538e1d43

Best regards,
-- 
~Vinod



