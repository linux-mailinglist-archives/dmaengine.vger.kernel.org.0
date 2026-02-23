Return-Path: <dmaengine+bounces-9010-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBciOxmbnGmKJgQAu9opvQ
	(envelope-from <dmaengine+bounces-9010-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 19:23:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CAA17B754
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 19:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B5D8300C56D
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA633DEC2;
	Mon, 23 Feb 2026 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNesqarX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DA315D46;
	Mon, 23 Feb 2026 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870859; cv=none; b=FXJKqjKiEBNe1wxHScpsg2oMYhOfbZW2YrCf6HLlPuMb9Ulg6IxcfsTTlQsZMJQ1R9wO27dPZwY6xEtD0bf0ykze1u+kCTH9HxvVEXp9JYxm7KMm57DMOKrrFGkX0Elmjkkx4WoMc6eOu/ozc4t6Omj75Ph4qvgCJZllnF62iNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870859; c=relaxed/simple;
	bh=Km5TB4a+OiHGQXNkXPphl5LAvR+/kNXwduKtPTQar9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH6RJHFaX+g/i/2xyNS5pruCuq8M2BuP+Vp/HX5XfHgp3rq+lxx9d/pyqHT1cjNnCepPDGV4KJGIwnIxEUTYiuoLFDW8MEfYOschHZTt9UURBa4Ok8JczWobHYbkkPTw/JFaQKm4B1jRPw4KinLhxG/2Pfnt9zLHPfX30UA00To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNesqarX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC46C116C6;
	Mon, 23 Feb 2026 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771870858;
	bh=Km5TB4a+OiHGQXNkXPphl5LAvR+/kNXwduKtPTQar9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNesqarXkUAoHz/fCehnWxM+JUI/pBhHUHpA87p8TBEMgubFbu6Be/nCzi/DTwO74
	 rfHjMDEpuuYZoGE1WnvKmGKn9iIy8W8ouDXjuRFhGb9hedZfQwBbVmCbhZsi1gsDC2
	 YHUHTyN2CGqkSdIwNAYyrCpMaCc9qKK+NPNWJQSKIHy2KLK+Sr0Ltw2YT+DaPB2RWR
	 7K5YG1m/qMjCTWJ26MlSGWmEyEAh4ZSUbmmwO+QGeiw1GXvE+lDjB4ThYA02Dr++lb
	 pEkxO9ZqLV5NvVhg7Kg9PiSa//Bv3n7keQxOm18o+uvpyxczWgeIxqIbRj9kH3y4GG
	 ++aidvAEwI/Tg==
Date: Mon, 23 Feb 2026 12:20:57 -0600
From: Rob Herring <robh@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, peter.ujfalusi@gmail.com,
	vkoul@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nm@ti.com, ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	Frank.li@nxp.com, r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v5 12/18] dt-bindings: dma: ti: Add K3 BCDMA V2
Message-ID: <20260223182057.GA4190282-robh@kernel.org>
References: <20260218095243.2832115-1-s-adivi@ti.com>
 <20260218095243.2832115-13-s-adivi@ti.com>
 <20260219-hopeful-intrepid-cuckoo-32967d@quoll>
 <bab85365-063a-4d46-a1bf-48a25228d109@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bab85365-063a-4d46-a1bf-48a25228d109@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	TAGGED_FROM(0.00)[bounces-9010-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: 13CAA17B754
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 05:45:46PM +0530, Sai Sree Kartheek Adivi wrote:
> 
> On 19/02/26 13:13, Krzysztof Kozlowski wrote:
> 
> Hi Krzysztof,
> 
> Thanks for the review.
> > On Wed, Feb 18, 2026 at 03:22:37PM +0530, Sai Sree Kartheek Adivi wrote:
> > > New binding document for
> > Fix wrapping - it's wrapped too early.
> Ack. will fix it in v6.
> > 
> > > Texas Instruments K3 Block Copy DMA (BCDMA) V2.
> > > 
> > > BCDMA V2 is introduced as part of AM62L.
> > > 
> > > Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> > > ---
> > >   .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  | 120 ++++++++++++++++++
> > >   1 file changed, 120 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
> > > new file mode 100644
> > > index 0000000000000..6fa08f22df375
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
> > > @@ -0,0 +1,120 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (C) 2024-25 Texas Instruments Incorporated
> > > +# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/ti/ti,am62l-dmss-bcdma.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Texas Instruments K3 DMSS BCDMA V2
> > > +
> > > +maintainers:
> > > +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
> > > +
> > > +description:
> > > +  The BCDMA V2 is intended to perform similar functions as the TR
> > > +  mode channels of K3 UDMA-P.
> > > +  BCDMA V2 includes block copy channels and Split channels.
> > > +
> > > +  Block copy channels mainly used for memory to memory transfers, but with
> > > +  optional triggers a block copy channel can service peripherals by accessing
> > > +  directly to memory mapped registers or area.
> > > +
> > > +  Split channels can be used to service PSI-L based peripherals.
> > > +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
> > > +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
> > > +  legacy peripheral.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/dma/dma-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ti,am62l-dmss-bcdma
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: BCDMA Control & Status Registers region
> > > +      - description: Block Copy Channel Realtime Registers region
> > > +      - description: Channel Realtime Registers region
> > > +      - description: Ring Realtime Registers region
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: gcfg
> > > +      - const: bchanrt
> > > +      - const: chanrt
> > > +      - const: ringrt
> > > +
> > > +  "#address-cells":
> > > +    const: 0
> > > +
> > > +  "#interrupt-cells":
> > > +    const: 1
> > I don't get why this is nexus but not a interrupt-controller.
> > 
> > Can you point me to DTS with complete picture using this?
> 
> Please refer https://github.com/sskartheekadivi/linux/commit/4a7078a6892bfbc4c620b9668e3421b4c7405ca4
> 
> for the dt nodes of AM62L BCDMA and PKTDMA.
> 
> Refer to the below tree for full set of driver, dt-binding and dts changes
> 
> https://github.com/sskartheekadivi/linux/commits/dma-upstream-v5/

Whether this is an interrupt-map or a chained interrupt controller 
entirely depends on whether the interrupts are transparent to the 
DMA controller (i.e. do they have to be acked?). interrupt-map is 
generally for transparent cases.

If not transparent, then just 'interrupts' and 'interrupt-controller' 
should work for you. You can map 'interrupts' entries to channels like 
many other DMA controllers do that have per channel interrupts.

Rob

