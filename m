Return-Path: <dmaengine+bounces-8898-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKZnIeTzjWlw8wAAu9opvQ
	(envelope-from <dmaengine+bounces-8898-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 16:38:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95F612F08B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5B0B3034783
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFAA260588;
	Thu, 12 Feb 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEPiyaUS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C421E0AD;
	Thu, 12 Feb 2026 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910688; cv=none; b=RU+55Ac6OWb/vN7evlTp9GUS6gYzw2NGoy+P4nikAI+ilWWNXPW32SXRK0QJVUtpHN/sjsIWABQsoXrrg97c7d8S8ZJc8tmhvWnlHHV47GrU58ls7knxnok0Xo91EJq8NSII/DSheWOgF51zqH3jTcQJOOo41nbw8n28X1jfHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910688; c=relaxed/simple;
	bh=LG9GM7G2ZXscPpD/U0S8znrPl9nHZFyRR7FAkT9hQB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzKtgsnoOi+mYlTMS3UpA7xjwF+IvBH8aN48xP4ONKvxq0kqxU1Y821wzRj47zPCkOvOagFqBhnGmR8E9bOg40+BAjoclsrrkuVOUt+EnBo0ZWJaNm85ckciMkV+LBc1wnVRERIWxTVBodjbsJBgXq+KYHhCif4YlTZFrRNfvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEPiyaUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD64C16AAE;
	Thu, 12 Feb 2026 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770910687;
	bh=LG9GM7G2ZXscPpD/U0S8znrPl9nHZFyRR7FAkT9hQB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEPiyaUSOiXPtR+AOPm8352EeMP0JMHMeqzAbtmfLwVsm0hc57c/6VO+b9SZcW3i5
	 AM5VSYEcMDbznVRGZnsUWIg6s4jjaQ+Rinp4BJsU58Tg1YAANs/oXWmMQymW7bsW5Y
	 Utlv/yGJhfd3o07ht/Lmr0RNBePfh9x2gidksptIOBDyzjtLWffXkXsEvu4tAx4EDw
	 aqfxvoIJz7bh0MR/QD+30KVQ2LI49t+sXKrCzBKNh3ByiaLBFLRzthTwQnxapACp9h
	 07Mcb0hnLJwFzPkglUnHzeI74pansj1zT7zV5JcMIChACL1O6qEcfUjQWKSXhjVBvA
	 9jcZvtYQ9lSXw==
Date: Thu, 12 Feb 2026 16:38:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <aY3z2S0_92ZDvNQJ@ryzen>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <aYsjfTtA0EsXwh69@ryzen>
 <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
 <aYtdEnZM5mnmcgtY@ryzen>
 <23p74hldtvi2xn6aza2rc6kh5hidzutu46ugzt6mzliyjzylka@k5gchw3amcig>
 <aYyz5WF_iJuNwA35@ryzen>
 <fblyz2hldxgqo2i7fywpgzuaqxzxsbavme7pfahj3uftgloeqq@pxeddjzm4sdj>
 <aY2q80zeRKSRO21H@fedora>
 <cf4mpl64e5tms5kw7z33f6cwoarmtmkzykoexoozwamtpz3bvo@q52h7ycdy7mb>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4mpl64e5tms5kw7z33f6cwoarmtmkzykoexoozwamtpz3bvo@q52h7ycdy7mb>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8898-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E95F612F08B
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:14:15AM +0900, Koichiro Den wrote:
> 
> Anyway, I think that the MSI-X Table case should be handled in another
> patch series.

Yes, of course.
I just wanted to give some extra context.


Kind regards,
Niklas

