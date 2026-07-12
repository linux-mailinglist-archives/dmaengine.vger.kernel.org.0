Return-Path: <dmaengine+bounces-12352-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RQtSDhCOU2pabwMAu9opvQ
	(envelope-from <dmaengine+bounces-12352-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 14:52:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 882D1744BCD
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 14:52:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dbC5zTHC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12352-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12352-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B391300C271
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81BC3AA4EA;
	Sun, 12 Jul 2026 12:52:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889A39A7F6;
	Sun, 12 Jul 2026 12:52:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860744; cv=none; b=bSk4BJfVC47jvtIwg7Lc7x5g1PplZX+tiHOz3ioge4B+Bqq5vPrWXu/C+VqxmGViJ9Utz9Q9WxE+7cIjKgLXtcWw7ife1+3nnni65lg6Qk74T+doN0/yue2IUvALxdbxDsJfai5dLIQxCo2PLZuGLKUYi4hldwTX9i3N7oBP1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860744; c=relaxed/simple;
	bh=xisxfaBt1u7iox72cMaqtVJkaUzFtDxm6UUbK1ACwNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGt0TN3HKsAnOWAw2asMpvmsAiCjspv5JjhzRdfOOaTIydtPgcw1xkcvu+Sy4pEHdxTRrdvMwuZ/0U4+c09UbabIMZOzlBIEXXMs3c9mbOZa0LhRP1tWdoBj66tEQNVtCALvjWWkuwAVBKZp5cn7/qPW5s/EPmHphu78KNMHjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbC5zTHC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBA11F000E9;
	Sun, 12 Jul 2026 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783860743;
	bh=xICf8+vyvbxBOhI5Ir1TGTPJUjt3DQaTmbP/c0rGoyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dbC5zTHC2VqTYubjAq+YlCRr9leVBnsoeNcxDN2JXjrIuATajyDd7vVEhKxJYVOND
	 YJElOusBu5Wqr8s5QI5G6RhcaJ9ONQABZDLY7OnCElshXcDTpyofA/p3LXL6VLiglj
	 cYv1Yio4ZzrfxbXkwn99IDVHG8KubvuhMMZAQ0l/DBDprddpBTKDFB29s8EBSlGlhz
	 AZ1Kv0HZytaNTWVR0D9aCPRv7aXmyrrPK0GWrud9mR8AMgjMUDwFXWS8hMAyEHw78f
	 /5zbmahHH6ZKWsqgiyHyCU4rFJO3A0bUhc+eHqip5rJs0mgwh1p3JyeMBO9lzLn40f
	 LlYOQ0cxavatg==
Date: Sun, 12 Jul 2026 14:52:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
	simona.toaca@nxp.com
Subject: Re: [PATCH v2] dt-bindings: dma: ti,dma-crossbar: Convert to DT
 schema
Message-ID: <20260712-dainty-condor-of-luxury-bacfa4@quoll>
References: <20260708-ti-dma-crossbar-v2-1-2ac0d6efde36@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708-ti-dma-crossbar-v2-1-2ac0d6efde36@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:j.bhargav.u@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vigneshr@ti.com,m:peter.ujfalusi@gmail.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:goledhruva@gmail.com,m:m-chawdhry@ti.com,m:daniel.baluta@gmail.com,m:simona.toaca@nxp.com,m:jbhargavu@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:peterujfalusi@gmail.com,m:danielbaluta@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12352-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,ti.com,gmail.com,vger.kernel.org,nxp.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 882D1744BCD

On Wed, Jul 08, 2026 at 10:02:18PM +0530, Bhargav Joshi wrote:
> +properties:
> +  compatible:
> +    enum:
> +      - ti,dra7-dma-crossbar
> +      - ti,am335x-edma-crossbar
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    minimum: 1
> +    maximum: 3

That's rather:
  enum: [1, 3]

right?

> +
> +  dma-requests:
> +    minimum: 1
> +    maximum: 256
> +
> +  dma-masters:
> +    maxItems: 1
> +
> +  ti,dma-safe-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Safe routing value for unused request lines
> +
> +  ti,reserved-dma-request-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      DMA request ranges which should not be used when mapping xbar input to
> +      DMA request, they are either allocated to be used by for example the DSP
> +      or they are used as memcpy channels in eDMA.
> +    items:
> +      items:
> +        - description: starting DMA request line number
> +        - description: number of consecutive lines to reserve
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#dma-cells"
> +  - dma-requests
> +  - dma-masters
> +
> +allOf:
> +  - $ref: dma-router.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,am335x-edma-crossbar
> +    then:
> +      properties:
> +        "#dma-cells":
> +          const: 3

else:
  properties:
    dma-cels:
      const: 1

      Best regards,
      Krzysztof


