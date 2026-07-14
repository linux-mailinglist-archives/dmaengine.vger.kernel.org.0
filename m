Return-Path: <dmaengine+bounces-12458-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NkKPHTrJVWqItAAAu9opvQ
	(envelope-from <dmaengine+bounces-12458-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:29:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E77D0751227
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:29:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=suksangroup.co.th header.s=default header.b=K78tWseG;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12458-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12458-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=inbox.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8003C301E5B7
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 05:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2A0311C35;
	Tue, 14 Jul 2026 05:18:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC531064B
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 05:18:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006299; cv=none; b=cIhReiLfKiAdRD2M8jnszK/pUmpPf+UiyofhRnGuENLDjIRfHNj07ST+LTuagznn6yOmOkhH1RV4ofLVUBWf/J8DDLIBFVfjYW7y8w4/wts6ScnV04fz3ai+ppm9jkmq9eKTCtfpZ6BQHLr5/DWx9iJilfIgvXMW/maNF96acOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006299; c=relaxed/simple;
	bh=lPFUcXwckBOEMZysAAZjsjoknLraR5HazjmrQiw79z0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u93q53BUEiivlr6kcXR7p1cY2L/QIKfibfIty4+KuxMuGeJDbyS7Xon3rginEMzPGW+zHlsioRX3IsNTSwfERPMM9D/19bS724X4lZUKjjfB8iP4A99xabOF4hcGFYivZSKFfQyKibdkFymssZkufPou1+D1EADua6siZQOVeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=K78tWseG; arc=none smtp.client-ip=103.13.31.55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lPFUcXwckBOEMZysAAZjsjoknLraR5HazjmrQiw79z0=; b=K78tWseGtKeKhYD48DDYdJYi6d
	KLH8x5LboEWOSBRHFC4ncr10tgvdOKn8lq7R3ivVxMdlaGH6MWwADJVtTlo+iWobwTQTxQUlQPWxI
	B1ebelurDFXj7bbTFHLxMO4Q/pAmGqrWJlHgTMbc5budjx+N/azx9jJfc7dSComFGFqu6uNp7JJor
	30cPIhALBRJ3PckNwYDTddKfAwcY0NIJdPfh8fMFFZnNYz6+pIQIv5VEleDv1OavEabs3AFFOOIt3
	rr4i87k/iQ/M+6ND1OTAh0T6XxvJElxP8U7BxPnyRfBIYsMe8+KSjsnNt6s6R7t6IxUg/txvsqmG4
	TRyhSGRw==;
Received: from [207.189.26.187] (port=61482)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVX5-0000000Fsnz-2yz6
	for dmaengine@vger.kernel.org;
	Tue, 14 Jul 2026 12:18:14 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: dmaengine@vger.kernel.org
Subject: Dear dmaengine, project info
Date: 14 Jul 2026 00:18:11 -0500
Message-ID: <20260714001810.AB9CE9D31575C7E1@inbox.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.94 / 15.00];
	ABUSE_SURBL(5.00)[lexcapitalgrowth.com:replyto];
	R_DKIM_REJECT(1.00)[suksangroup.co.th:s=default];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[inbox.org : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12458-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[smtp@suksangroup.co.th];
	GREYLIST(0.00)[pass,body];
	HAS_X_SOURCE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_GMSV(0.00)[smtp@suksangroup.co.th];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[info@inbox.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@inbox.org,dmaengine@vger.kernel.org];
	HAS_REPLYTO(0.00)[hanns.schofield@lexcapitalgrowth.com];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	DKIM_TRACE(0.00)[suksangroup.co.th:-];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,inbox.org:from_mime,inbox.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lexcapitalgrowth.com:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E77D0751227


Re:Good day dmaengine,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA



