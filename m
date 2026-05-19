Return-Path: <dmaengine+bounces-10565-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BiKAxWhDGq8jwUAu9opvQ
	(envelope-from <dmaengine+bounces-10565-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:42:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B58058340E
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 19:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C3BF302AE0E
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6CF34389E;
	Tue, 19 May 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V61Eqpl5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB16343894;
	Tue, 19 May 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212457; cv=none; b=iLNxsj96bQaa9FEzSlSArE8qeaIfLH4H3CxeSNW9fngoJAMEh3VbeEm/mQtXLYB8F5DGTh+212nr9UILw/xdAwTNO6tXh/XX1zf3aI3YNtM3V1b8dP176Nro3Rhw+gbwOw1bcwUuNO4TPv2ASuVzRV8930+61J0b3Xy2+e6Stj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212457; c=relaxed/simple;
	bh=/+2OhO49oO91nzKhtp7u9BtU8+5Z6Mb5Yhp+eJ5MVqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pA3Dm2lPqgj2UeYA01BWEOXqDNiY0T4e5oHb9lyJHPnwlhbZunldd4dNfBC3h1r4CTPqeuwRngq30Yuz7Q1bL1eAbhBwVM3f5OmoPIpL+6N7mFW2yofEoT5BSQo+m2CQvlBNjrAyIkR6gMgoB0wsO3MUCu8gDE1h9v4FIWyXhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V61Eqpl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05B0C2BCC9;
	Tue, 19 May 2026 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779212457;
	bh=/+2OhO49oO91nzKhtp7u9BtU8+5Z6Mb5Yhp+eJ5MVqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V61Eqpl5k+hlaKj5rpEulF3bu6tfXsEBFKIOHbEHYol/gfrrYdlFK/Bsn+AEu2w5L
	 QOus7K9KBFMMXYrN6TmG2AndOOIooYyhUtLwE6cG9yUR75bKpKPk6YdZM7jTYJD5PF
	 qP3y+gG4slwxBB1sMxa5oe6ZFaNyLk++h0zdbGwt1292whk+Bl0OcfDUvsclv4W9Og
	 ldJM1nVusgMjFDpsDFD1nSbxx8TOb/a9nNScYAr+XAi+7BoUcLD2D3D/MdCODoCD0P
	 FLsVz9xlH9x3UQQPaJD+RsB4WmWQWh2dXFH4kjgG7uJ03LvkXOz9cI3FFD3UqNrd+q
	 9SAACESEIHpDA==
From: Vinod Koul <vkoul@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>, 
 Longfang Liu <liulongfang@huawei.com>, Frank Li <Frank.Li@kernel.org>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260514060525.9253-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260514060525.9253-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2] dmaengine: Move MODULE_DEVICE_TABLE next to the
 table itself
Message-Id: <177921245437.339411.17021175669623816769.b4-ty@kernel.org>
Date: Tue, 19 May 2026 23:10:54 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10565-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B58058340E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 14 May 2026 08:05:26 +0200, Krzysztof Kozlowski wrote:
> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
> 
> Most of the drivers already have this correctly placed, so adjust
> the missing ones.  No functional impact.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: Move MODULE_DEVICE_TABLE next to the table itself
      commit: 362ee0c0dc522bcf585bde59ceba2038ec583b7d

Best regards,
-- 
~Vinod



