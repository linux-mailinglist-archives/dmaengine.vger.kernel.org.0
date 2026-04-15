Return-Path: <dmaengine+bounces-10019-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMZlE+j132kTbAAAu9opvQ
	(envelope-from <dmaengine+bounces-10019-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 22:32:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDB407A78
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 22:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3A5A3086415
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734138AC66;
	Wed, 15 Apr 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhRRQj/3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA6386429;
	Wed, 15 Apr 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285143; cv=none; b=RXkVsnFfqDfxhXP/dhia97T7KqyvPK5JgCiqAfTtQl2nTNdyPmu3vJjC6HXPR/vTT04rjAVi5jDXlakfwX2cdZ1kwR0yU/COz3u21p3TLYyqY+voyKcVntnIVWnemfgQNZW1//76gkuGHPEN4Lc+oRn0ZCpvPDOeXq7k9b3ia5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285143; c=relaxed/simple;
	bh=MHiLBFsHQIV8mvvYE/oH/0iKnPKpnuF1VTyzFvOvIuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDPSFY+i9wbt48DgYkGG/YJqLxelbIJ9R9bKkwKR94G6Vdga6ecuZvz9S3TCt7AlmR1wOiZs+gX+OLyL6ciYak4Lp3C2cOXBKSYwP+WbYGs5RVkaBjWlT44v/NYVTvE4paTKI+RFM9LRxo6WsbFskDE5sbOmA/ohkPjva+d93l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhRRQj/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8C9C19424;
	Wed, 15 Apr 2026 20:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776285142;
	bh=MHiLBFsHQIV8mvvYE/oH/0iKnPKpnuF1VTyzFvOvIuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhRRQj/3LGN04D+e/wBtac8n7L9R1Xjj2Kd6rSPg0QyxTLsMiPFY0Z7fqWCPF+O11
	 WZ2fxxkidoNn6Cav3OwhBToZehNxso0OCa1wr7t89hn2qKffr8ayPtMWW+WrPn7Bnr
	 o+UfmirkStMbU4APNisqYi3Goefn2fihZRfDqeaF7s7B64g5WU151nJoI1DugIHhya
	 Hz2xAJAfLZUagDPo4aGteVkoQs9ox9ryaIk24TjlJ+1DzheggMK+W7H25xOOuqyCW8
	 NQzeVQ8/z+9e/6oO9StLky6jid8aCSs4lqDqgzPycPvWzRy5NyXZzpZXfL2QJO9ONC
	 DOBpLbGmn00KA==
Date: Wed, 15 Apr 2026 15:32:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>, linux-clk@vger.kernel.org,
	John Madieu <john.madieu@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 01/24] dt-bindings: clock: renesas: Add audio clock
 inputs for RZ/V2H family
Message-ID: <177628514044.330919.749712456850235739.robh@kernel.org>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
 <20260402090524.9137-2-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402090524.9137-2-john.madieu.xa@bp.renesas.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[tuxon.dev,kernel.org,perex.cz,pengutronix.de,suse.com,glider.be,bp.renesas.com,vger.kernel.org,renesas.com,baylibre.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10019-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C9CDB407A78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 02 Apr 2026 11:05:00 +0200, John Madieu wrote:
> RZ/V2H, RZ/V2N, and RZ/G3E support external audio clock inputs
> (AUDIO_CLKA, AUDIO_CLKB, AUDIO_CLKC) that can be used by the Audio Clock
> Generator (ADG) to derive internal audio clocks. These clocks are optional
> and their frequencies are set by the board.
> 
> Update the bindings to allow these optional clocks for all RZ/V2H family
> SoCs.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v2: Remove maxItems as it not needed with items lists.
> 
>  .../devicetree/bindings/clock/renesas,rzv2h-cpg.yaml      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


