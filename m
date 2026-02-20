Return-Path: <dmaengine+bounces-8988-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB8JD3uxmGnsKwMAu9opvQ
	(envelope-from <dmaengine+bounces-8988-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:09:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AB016A454
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99B413005318
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FB366567;
	Fri, 20 Feb 2026 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="BbGAeXhv"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D8366552;
	Fri, 20 Feb 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614581; cv=none; b=b/QfnUGicxYJpx7s6M7N+2OP6JaNQ1OyPpMWR8/F7yfwxkQQvwUFoTxeyMGWJoICvR0t0eCBv78qYRmGAFjWUHYq1EHFhCL0ZlsQ94k3xFS9VVNNnk6F5PZY30e5Qzwp7aT2ekDSBcrGJ/dIpr50E35GB/sqepTOdbDgZiW53jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614581; c=relaxed/simple;
	bh=S5HjiWG5cz9UpFjoGigb7CyZFQukFWNkONY43+FvEaw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=B/R1XJkKT+L1tamoQYWDUQFPxz5KNsTrBRigVZARhkaCpDefal+pmvJ/a42Qec1K8DvPT3jjdrU4s7+Bdb2dHtW7uN1qnco20qPJsYwNaB9Kv2l8VB19UmbakjViqj269+QlYMj5POVNl89FBd/xmGdm9wnjuNetwr+Q36yLOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=BbGAeXhv; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=S5HjiWG5cz9UpFjoGigb7CyZFQukFWNkONY43+FvEaw=; b=BbGAeXhvvDj1DfPtGRObKME4yA
	//ZMGb2KoNsg8i3XGXNBtWVhqSFiPdFyUH9NyPT0O+lGdgQqUNODdtG+Vsgvw3vbR2jZpf9tWjpzg
	sKgbSBNAC/0MRPiCfhXOtbz9sa+f/LJpCQtW+TjYFcqvfY9t4kKtRfUAsLNpRz7VJ6P4urA1bh95D
	xCQLu/0zvVwMWiUa7TXDCdSKY2AvP+69qv2BsOpUHC8gqPos8/lLx69LO0aqcaJfAeIRuquzfrIry
	ub3sGqScap55ekn6Y0oeaGd41tFKk8D7XZpNVBnJR3fsg2TwoocaFOIFy0oHhxDi9EBQdA5qUcn3C
	y6ME9qWw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vtVsT-000NQc-23;
	Fri, 20 Feb 2026 20:09:25 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vtVsS-0000HK-2r;
	Fri, 20 Feb 2026 20:09:25 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 19:09:13 +0000
Message-Id: <DGK0Y27COUI1.34WLTZKYFC99V@folker-schwesinger.de>
Cc: "Rahul Navale" <rahul.navale@ifm.com>, <dmaengine@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
 <suraj.gupta2@amd.com>, <thomas.gessler@brueckmann-gmbh.de>,
 <radhey.shyam.pandey@amd.com>, <tomi.valkeinen@ideasonboard.com>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Rahul Navale" <rahulnavale04@gmail.com>
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260220132845.7118-1-rahulnavale04@gmail.com>
In-Reply-To: <20260220132845.7118-1-rahulnavale04@gmail.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27918/Fri Feb 20 08:24:36 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8988-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68AB016A454
X-Rspamd-Action: no action

Hi Rahul,

On Fri Feb 20, 2026 at 2:28 PM CET, Rahul Navale wrote:
> From: Rahul Navale <rahul.navale@ifm.com>
>
> Our setup uses a custom FPGA design with a custom XSA file for the PL.
> The multimedia drivers (audio/video) are also customized for our platform=
.
>

this is an important bit of information. Could you verify that your
customized driver uses dmaengine's dma_get_slave_caps() to obtain
channel capabilities and that the newly introduced
xilinx_dma_device_caps() is actually called?

