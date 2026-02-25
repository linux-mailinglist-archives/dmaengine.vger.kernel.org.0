Return-Path: <dmaengine+bounces-9076-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIsdO8LcnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9076-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:28:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52959196780
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC18B3053666
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333AA393DCD;
	Wed, 25 Feb 2026 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHYtBxfc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01F2D877D;
	Wed, 25 Feb 2026 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018649; cv=none; b=NaanRjulOq9DY2zpp0WY7WgZZWkurzpJMxycxlcVrII+/Ar0w9niIxk3+zArcFFFYUYRsru5YSk8hbqSkpH+7gfg1u7wHSOCFOjmDSR+GEa1odrET6Kan2qpopEhF0s4cyohlyGoYogG0btYKTgfj/OPfSbfyeDfGzELGNbZPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018649; c=relaxed/simple;
	bh=83nPCdbWqaF9WpFrOPmSzxEWhHCp8sgCyS1cq+2cTF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gekuCSpdHW68iqqJz4orvKy5YW3wfvJzXBb/OFO5n+y2/IIKtBOMxOHZjAxh0hhl1NVKuJHkngB1WhSi5iZLDD7ucKWc4Ky2CiVnCiUFBkTCmlsIMBtgmJSKD8Nmr4zVCZDEqa369qN1pmhIC7vMkFnzJQUD7XQLVVJaOTr6u6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHYtBxfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30415C116D0;
	Wed, 25 Feb 2026 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018648;
	bh=83nPCdbWqaF9WpFrOPmSzxEWhHCp8sgCyS1cq+2cTF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uHYtBxfcZmQo9Meu26j2W+u5i4XpsVkP1nTSSj+JI6Li/b42oVVyHnsPYxbCUN6a2
	 cg2ol2qa7tdUxBeWBO4YoGIFrYGy+YT6Oi4Ejgi1OhMhbKPv5As7fR7KVEy3CEOQMW
	 Zah/xRWR/pmw3DgUQdelJzsfer9vr5O6X9iyOW7k2Tz4u0zElwZOs14g3gaRhHrGHo
	 F42Skzctc0Ta8UFUbq2vYjjsMe+c9Zt+oT1M3c3m8O/3nRnh3Ft6r1XQo/2S504GvO
	 JiTxdZ5fb0kTUAozBDzlwZLyD2CxTm1ZPoaKT8KZjZww5Bzj6i7VnwXUa8F2hp29Lp
	 Ib8lenOq6cqWw==
From: Vinod Koul <vkoul@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260203103031.247435-1-biju.das.jz@bp.renesas.com>
References: <20260203103031.247435-1-biju.das.jz@bp.renesas.com>
Subject: Re: (subset) [PATCH v3 00/10] Add support for Renesas RZ/G3L SoC
 and SMARC-EVK platform
Message-Id: <177201864381.93331.5903665743776251595.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 16:54:03 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9076-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,baylibre.com,glider.be,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52959196780
X-Rspamd-Action: no action


On Tue, 03 Feb 2026 10:30:08 +0000, Biju wrote:
> This patch series adds initial support for the Renesas RZ/G3L SoC and
> RZ/G3L SMARC EVK platform. The RZ/G3L device is a general-purpose
> microprocessor with a quad-core CA-55, single core CM-33, Mali-G31
> 3-D Graphics and other peripherals.
> 
> Support for the below list of blocks is added in the SoC DTSI (r9a08g046.dtsi):
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
        commit: e45cf0c7d9b960f1aae4ee56c3c3d46549ccde86

Best regards,
-- 
~Vinod



