Return-Path: <dmaengine+bounces-12499-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VY0mGVAtVmoz0wAAu9opvQ
	(envelope-from <dmaengine+bounces-12499-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:36:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F31C97549EB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:36:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GtB2du4z;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12499-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12499-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D652C300A335
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C1E44CF25;
	Tue, 14 Jul 2026 12:36:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918244BC9A;
	Tue, 14 Jul 2026 12:36:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032584; cv=none; b=lWtFf0alaIBBcDdYuda3aiioVtMEH+bDWzcFibqtfbNY4uIGjnt+naL5C8WMD7GSAfyunAvON/xgINpvEdvpxE/C4brZjVtiZDIorzu2L9y2NGdm1FanG13myhsWHlxMEB9kKU3sJ1P1WoFCCOEDvYFIfk5UMEzHYOd5TNKI4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032584; c=relaxed/simple;
	bh=xOMxbou0HtgU77LZY2/yUrdmKJDz90GT+92DNpGQ3uw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BDSAb/9+sN5Ks2rzzkh84Sqw6DMuG8oh3p2mO/mGf0bLZ55yZH5N7ZvWmv4G2mYB7qAjZUBgyLQ/VNaEsryA1qOdm+TPb91CBZN9XZ61n2j0PXGmm8HaHnOtxrmM8jIqpVudBHmtW7Hnb+RlZM3QeJLNafYXZNwzPg/1iw+jKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtB2du4z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBFC1F000E9;
	Tue, 14 Jul 2026 12:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784032578;
	bh=62Ak6hz9EWMUawwBjeZokrMky5PP5s9D1N6X5kDoKJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GtB2du4zHdAofRkgaxtK3OS11QR9YtxEdQSOrLt87xR1WngDqN8k11fkrH8eCSb23
	 ENaTjsBtj4q5M3uXV4L9AwchKqFbC4m7p76437YsE38a8XL0NpAiipiF9VyuLaSSbN
	 LMuTwA/6lpAuwE4GwEskB1JnOTdbTr+VB98Jgxsef+r7kS1KmrETMFtxlSbhPUzNLq
	 DIW2hKOm3PUdBhiJ46SC25M6LOLzqeb2Iv1tKf1pGVhiI2yw0XO2JK8pYY5PpwisGw
	 JXwxiJWKOQgqAUQdikJYo8n+jfa+JLZahJDNHt7wT/rlU5vTOQypuiYaBeK06tJoGI
	 cdsNvoAfY4iaQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Griffin Kroah-Hartman <griffin@kroah.com>, 
 stable <stable@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 imx@lists.linux.dev
In-Reply-To: <2026070605-frying-fling-b9c5@gregkh>
References: <2026070605-frying-fling-b9c5@gregkh>
Subject: Re: [PATCH] dmaengine: fl1-edma: Add error handling for
 devm_kasprintf
Message-Id: <178403257631.822807.3647660559296965382.b4-ty@kernel.org>
Date: Tue, 14 Jul 2026 18:06:16 +0530
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
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12499-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:griffin@kroah.com,m:stable@kernel.org,m:Frank.Li@nxp.com,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F31C97549EB


On Mon, 06 Jul 2026 16:57:06 +0200, Greg Kroah-Hartman wrote:
> Add error handling statement to fls_edma3_irq_init() for the
> devm_kasprintf call.
> 
> 

Applied, thanks!

[1/1] dmaengine: fl1-edma: Add error handling for devm_kasprintf
      commit: bf1af4dfdc017dfe989c0dbcf0e608dc95f1d2cb

Best regards,
-- 
~Vinod



