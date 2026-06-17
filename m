Return-Path: <dmaengine+bounces-11581-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eZoqOWWsMmr83QUAu9opvQ
	(envelope-from <dmaengine+bounces-11581-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 16:17:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9069A78B
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 16:17:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codethink.co.uk header.s=imap5-20230908 header.b=NMQaixZF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11581-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11581-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=codethink.co.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5BCC3029C18
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE792BD02A;
	Wed, 17 Jun 2026 14:17:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B952D94AB;
	Wed, 17 Jun 2026 14:17:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705826; cv=none; b=fV6KbprxmRdvgzbbrK06JFmmYcdODTn26+7SDN46veYhy0h8pcujRm3ZAFyl2p3bGLd8YGCXDQg8TWfQblqVfdWt7W0W6lhCBHkFaDR4b/BzKisPQ2MtKBlSUTbTpNHbTy6MHbug9arb1fzvAztCGpAsCFOke7mrUgb7tEGqkTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705826; c=relaxed/simple;
	bh=DjStoZh2m++pd3XFvzAMSxDkCSnNF/78Vubq68dW5EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVSbTCdCzJcwYcrzNGIl3nXj57XCRLQyZYdhJ6/uteQBJNxxugYh1NRUgawiiWo/yaJafDdYU4GvBuox+JSpa++9sXbRlclBtcSfYfW+Z8wpjkTP9sOWLLiT6zEYZU60eOKCskVjmAjRsNslMp77KbXoEkw03XcWZ+16SIH6ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=NMQaixZF; arc=none smtp.client-ip=78.40.148.171
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=DZHyrGKs9JSSI4KSTYREPjDkA6jion5rQBVc5vd2N1A=; b=NMQaixZF2QsxuQWA
	O8lFSt2CRo5+OnT/jnRAXrEdFZSuhNC43Xrg5K96osWMqN+ZGn0S8cxmIGVpQaaCQt45tGvC+nDB1
	bY2dTf/KdU3jhBLzfFkXa0IWzmavTsOwN+TV5YkXIxdD7rzvOtU8OyB2gWK2CGjHbusPuOFRzVpsx
	5keAEbR2EBmlJOBfiXIDfNSYlpAOpYBLKTYhNCr9nopAQngbF55csA0KW6NQfYQXD10zj5DmREdkI
	EMfeE0sDnnbf7hzNM8i/GKfFBBJPwErxOOAYMpMuMaSzDgIoaA6gBkASLjI+tZ9voO0UiEqgszcrw
	IuMvgp6NxQ4RRbceeg==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wZr4e-00DdOk-IR; Wed, 17 Jun 2026 15:17:00 +0100
Message-ID: <d4b84ec3-b91f-4bea-b68d-d0dbda36d29d@codethink.co.uk>
Date: Wed, 17 Jun 2026 15:16:59 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: fix __le32 on set of
 CH_CTL_H_LLI_VALID
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260617084944.705266-1-ben.dooks@codethink.co.uk>
 <ajKrN7UeLxlUKY8V@SMW015318>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <ajKrN7UeLxlUKY8V@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codethink.co.uk,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[codethink.co.uk:s=imap5-20230908];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:Eugeniy.Paltsev@synopsys.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-11581-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ben.dooks@codethink.co.uk,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.dooks@codethink.co.uk,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[codethink.co.uk:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codethink.co.uk:dkim,codethink.co.uk:mid,codethink.co.uk:url,codethink.co.uk:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11F9069A78B

On 17/06/2026 15:12, Frank Li wrote:
> On Wed, Jun 17, 2026 at 09:49:43AM +0100, Ben Dooks wrote:
>>
>> When writing the lli->ctl_hi, this is an __le32 type so the
>> value being orred should be convered to __le32 by cpu_to_le32.
> 
> Not sure if it can pass sparse warning check.

This was fixing a __le32 cast warning from sparse, forgot to put
the actual warning in the commit message :(


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

