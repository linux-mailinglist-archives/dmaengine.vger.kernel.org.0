Return-Path: <dmaengine+bounces-9474-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJIfN4c7uWkowQEAu9opvQ
	(envelope-from <dmaengine+bounces-9474-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:31:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D15A2A8CF1
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E823073F82
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FF93AA50B;
	Tue, 17 Mar 2026 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJRlVCsi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67413AA4F9;
	Tue, 17 Mar 2026 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746904; cv=none; b=U99ThD96OBcHmRmhfGBmFFQBRQlycIhJ4XzhfqnVTAOtev8yhOX17/cuyGpMqdTlg3oQwEy5jvRVDoQ81qiWlLkdJNH8qqIdVftCvLg6JdJ9JZyNYGO07a51bjXkdzyuEOlfAf9WSMApO9FzaKyF1oftH54u5omd1QA4YZzZGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746904; c=relaxed/simple;
	bh=YqlcyP6XaHygCUwzNcKw4WggOtzIPiRNIr6hRx+J0kQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jeK5zV4xV+iUd003QNtjIetS5dF+vHWcmmuSxf+RmFc5n4CbLp/IyEkpGje7uI5xWZVU9t0IdMuBrSaGZmSKmSPejH7Neu01LdG/qt6HLYvWnvIAQgvhIGa7rceqaGvlA6zz1XGk6v81UPhqn8K6Xw2ZyP89R0OOLGekb1iW3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJRlVCsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABC8C2BCAF;
	Tue, 17 Mar 2026 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773746904;
	bh=YqlcyP6XaHygCUwzNcKw4WggOtzIPiRNIr6hRx+J0kQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KJRlVCsiO18F/aqyzdp1F9k7SJCrZEqnRuwHR6Bp7SMjekKXlkFrNdoysaIBm3D+a
	 s/rzLZL0QQGNaCQujuGv9Ih30FihMTBYpOAWPSP8733MneA+IxX86XANZh7xWDAHuK
	 ujlpD5FThRuPi7ucLa2k16TKtMyuVLCjzUDQc57gID3KM3gd24Q1odH1UF0Ra+iSUm
	 Hp/ZMKRgujlBR2V7ld6OE6kjKqoNIBwoHz3XdBDqx9RrWeUJXR/qJVXC5P7efk2pcP
	 Ko+NmbyT0FFL7sF1cJ4S7ohIjxRDKa/E87X1jdEGqzfSv4KIaejc9Fce8YgM+zF3Yf
	 V4q9eOHiuV8zQ==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Frank Li <Frank.Li@kernel.org>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260306145819.897047-1-biju.das.jz@bp.renesas.com>
References: <20260306145819.897047-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Add conditional schema for
 RZ/G3L
Message-Id: <177374690074.337210.17964670092640773506.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 16:58:20 +0530
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9474-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D15A2A8CF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 06 Mar 2026 14:58:17 +0000, Biju wrote:
> The RZ/G3L DMA controller is compatible with RZ/G2L, sharing the same
> IP. However, the conditional schema logic that enforces RZ/G2L-specific
> binding constraints was not extended to cover the RZ/G3L compatible
> string, leaving its bindings without proper validation.
> 
> Add the RZ/G3L compatible string to the existing RZ/G2L conditional
> schema so that the same property constraints are applied to both SoCs.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: rz-dmac: Add conditional schema for RZ/G3L
      commit: dece5b9185ba4c3941f5fffb432f7584138833aa

Best regards,
-- 
~Vinod



