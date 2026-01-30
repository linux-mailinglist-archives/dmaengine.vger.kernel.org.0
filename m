Return-Path: <dmaengine+bounces-8614-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BF0cLbKnfGnuOAIAu9opvQ
	(envelope-from <dmaengine+bounces-8614-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 13:44:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6CABA9C5
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 13:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A6403010513
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F161537BE70;
	Fri, 30 Jan 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJQqTcQD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD330F95F;
	Fri, 30 Jan 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777069; cv=none; b=ghTPMPoXffzToDvmcEtwaoB5qofMcRasWaW7TNM0GhFG/7L8iZEVM9AtKH8dIzQWS7xAWg6OLmEW/APv/exny5uhXLmjf++eB7mbLtz4QCuvGWyWyjy2OSVECSWc5HDGQII/LPOYfivoG2UO+MzmcgXlHNsY+5TfuhqvF6FuoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777069; c=relaxed/simple;
	bh=orp++8gz1k1HbaQq7SXgFqxVbkLzY6LuZrbAVZfoJXc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=D2Txgf83Ab15QgUTq8xnpKBRuTLdPhOz93f6q7jZPJCrwe2z1zOguvle+UJX9NJjz8zRYQONL4GyQf69Ljs6/dzrz1v1Ig6m5K/N8n6YOzZp4X1+DldtTPnOdS+XgWUo8brzKlBNgXrZ+Tll43xcLMvC8jtaOcZVHv7XYhkl194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJQqTcQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5723EC4CEF7;
	Fri, 30 Jan 2026 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769777069;
	bh=orp++8gz1k1HbaQq7SXgFqxVbkLzY6LuZrbAVZfoJXc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=VJQqTcQDAwaTQRQ3hVsyhvY0veUJOLZP+XrsxLSb3SClCpFNchadGAP53XD2IutHd
	 duYx7qFjnTHB6ll3IcVpB//Hgx0jjAPM1moUwd9p+7WtHc9dnPpwJplfMbRzgguVKd
	 sKBFE2k9RIGWzMHcKlvN+6vm/zbxxcR73hSDSY3CyR4MAxXtIxDJU8sPvWve/oWPbW
	 5wxY9ORN1Txa7ahrTAIATGxl39BMxQl0pc30Dgm0i5oOP4LNsBhVvNYkpdJDnKlPfz
	 Bzq6kVa7KD8rxx+N48hrVvWJabRPv1YsmgsJANKpDshIDt7Lc/6i5jFwDP9nXk0ZJ1
	 RgkQoV3+o+Iqg==
Date: Fri, 30 Jan 2026 06:44:28 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: peter.ujfalusi@gmail.com, nm@ti.com, 
 linux-arm-kernel@lists.infradead.org, r-sharma3@ti.com, 
 gehariprasath@ti.com, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 vigneshr@ti.com, krzk+dt@kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, vkoul@kernel.org, ssantosh@kernel.org
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <20260130110159.359501-14-s-adivi@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-14-s-adivi@ti.com>
Message-Id: <176977706843.3699469.624952435786400951.robh@kernel.org>
Subject: Re: [PATCH v4 13/19] dt-bindings: dma: ti: Add K3 PKTDMA V2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8614-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ti.com,lists.infradead.org,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.42.185.128:email]
X-Rspamd-Queue-Id: 0E6CABA9C5
X-Rspamd-Action: no action


On Fri, 30 Jan 2026 16:31:53 +0530, Sai Sree Kartheek Adivi wrote:
> New binding document for
> Texas Instruments K3 Packet DMA (PKTDMA) V2.
> 
> PKTDMA V2 is introduced as part of AM62L.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  .../bindings/dma/ti/ti,k3-pktdma-v2.yaml      | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,k3-pktdma-v2.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ti/ti,k3-pktdma-v2.example.dtb: serial@2800000 (ti,am64-uart): 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260130110159.359501-14-s-adivi@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


