Return-Path: <dmaengine+bounces-9546-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAU5ABU1vGl3uwIAu9opvQ
	(envelope-from <dmaengine+bounces-9546-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 18:40:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2EE2D023C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 18:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43E5930A3063
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F76391E5A;
	Thu, 19 Mar 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNDQyT9c"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3360391E4E;
	Thu, 19 Mar 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941879; cv=none; b=QpxnrkjG68V9hd+c8Dapt0w8kUWyGiBGx6267T1f1zrKkjrLVvjG1Ber7u6fhNi0V2e5HyH53BgojGjsi9ktylWD1nO9X7z7S/PCF8hehwpVgyr8zkLOQrTqlTJ6qbAllazUgss/cjMxBZbwfElCF+MfIAqiA+e2Wh3A9vn4FhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941879; c=relaxed/simple;
	bh=UUWot43aWRLnUev4xtyp/4LzVdlfOnkeR4C3S3s58IM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Zsp8DWNwBxE4+ZZMUGyHhdV1JH5nMN6iWmlfxohKpYTLWBNRTHMVrB5HPm1lbcXSBLQSL09QFmkiNv855pTLgWuET8tdspGjtg2c/EvDVJzyP70VpjdiVQwjqO9MwXfjgVudrfYPnApjXvY6NGY5daLd8ZkZnu3pjJUcb458Igk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNDQyT9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C09C19424;
	Thu, 19 Mar 2026 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941878;
	bh=UUWot43aWRLnUev4xtyp/4LzVdlfOnkeR4C3S3s58IM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mNDQyT9c4y48XRSi2QtA8QkcDHLa/S0NIYX6zK0UwpVWo+0DHSaQ74dQcyVCymhse
	 5pxHmBIUukDCcFoOV+WvddBeXJrd6h848hjdccL3q8Cv8xQce9Uh1lxE8ntTGvcvwR
	 SoDDOPme0vBsxWCfXeI7Q04KBPoku6bQsiR2zESJyf1F0EZJXjTK2UwHFv6B8YpEy3
	 ZtulK7yBoEQrTEMf0DkEvVI3MThkLBsXOUGVGEPEgE26dWfNao+DsuPLMQqqy/k7zZ
	 emoYCU+Z8Fidcr+jCDFp26Q1ybW/GE3GIpgijGc3Xp9j+unAMAxO2AggEs+WRzGXIO
	 usXN0SUjLkmcw==
Date: Thu, 19 Mar 2026 12:37:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-sound@vger.kernel.org, Frank Li <Frank.Li@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 John Madieu <john.madieu@gmail.com>, linux-renesas-soc@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-clk@vger.kernel.org
To: John Madieu <john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260319155334.51278-2-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
 <20260319155334.51278-2-john.madieu.xa@bp.renesas.com>
Message-Id: <177394187724.2938936.10407132258338013690.robh@kernel.org>
Subject: Re: [PATCH 01/22] dt-bindings: clock: renesas: Add audio clock
 inputs for RZ/V2H family
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,gmail.com,perex.cz,renesas.com,bp.renesas.com,glider.be,pengutronix.de,tuxon.dev,vger.kernel.org,baylibre.com];
	TAGGED_FROM(0.00)[bounces-9546-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E2EE2D023C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 19 Mar 2026 16:53:13 +0100, John Madieu wrote:
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
>  .../devicetree/bindings/clock/renesas,rzv2h-cpg.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml: properties:clocks: {'minItems': 3, 'maxItems': 6, 'items': [{'description': 'AUDIO_EXTAL clock input'}, {'description': 'RTXIN clock input'}, {'description': 'QEXTAL clock input'}, {'description': 'AUDIO_CLKA clock input'}, {'description': 'AUDIO_CLKB clock input'}, {'description': 'AUDIO_CLKC clock input'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml: properties:clock-names: {'minItems': 3, 'maxItems': 6, 'items': [{'const': 'audio_extal'}, {'const': 'rtxin'}, {'const': 'qextal'}, {'const': 'audio_clka'}, {'const': 'audio_clkb'}, {'const': 'audio_clkc'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260319155334.51278-2-john.madieu.xa@bp.renesas.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


