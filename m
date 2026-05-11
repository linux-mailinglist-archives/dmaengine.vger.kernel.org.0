Return-Path: <dmaengine+bounces-10334-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULFQCJRSAmpfrQEAu9opvQ
	(envelope-from <dmaengine+bounces-10334-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 00:05:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E074516950
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 00:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC6CF30031E6
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02A247CC96;
	Mon, 11 May 2026 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXmNjSjl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8923B27D0
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537103; cv=none; b=Z4kj4QxsB6s0DAUd76ubp4/XXJRR+D75hxudJ8zaU93Yl9gAd9K11gVitAy0fUP/zMWbH3IUrAjOQNbkrcvebl9OEUZmlTwodO731yJ6EV8kUYnKuWM2shju9m06sIx9nd6ulmB2t+IG84pdFHsqKz/URABr5Ke5qZAaGBzZoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537103; c=relaxed/simple;
	bh=CIAqLMPPvoM4e+OnpQX7C3aTrPFyWScfWmBqyOx9pzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJhXM4PnkxObXLRZcHOdV0ABSIZ3PytM1vsSmoCiA17ifisTbh7IRD0sWlYfEk/GAfKPSebbwDzE6RunKd2LvTfuVvtiDBHVp6aogM6J2+uSk4xQjGjgbfzaPvbjYjSHS76kWtX3QaHy++FJeCpTMnhyd2R64Ctso62wiaDjL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXmNjSjl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3660b84347dso2983526a91.1
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778537102; x=1779141902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwJIirVuKqVtnnrvOqanwGLH5bXkSp5/1F2o6q3Zsnw=;
        b=kXmNjSjlWLrmBtWjmPmvzoihmIJqJgSMX78uD22/VL3H3nbSsPoQoF/FbKTnUgbA9+
         juJoj4FEnivEpFw1ICDqYUf9AfqVbsCB+UOPpidNmeTdaVw2UJmoisjiMY0xrM8F3D0O
         EzyIdzrdSZY6i1eZYkh8ge/gEwSBFdXedu0VluuKPuEtPY/RGv+QpRrmKGov6VBXE1to
         ST++dFmlM5JIvZEcSy3aC8XUxmUC0qx2f0QdudhDRWJ8BnltWGuGjfAoS8QN0Vkc/Www
         tdvck8BLlZSJsQ8Z2wTxt+xfA7vwyD0b1I5G5xevswuP77QCmIyYrAkAtCIcZOZlyItv
         lDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778537102; x=1779141902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwJIirVuKqVtnnrvOqanwGLH5bXkSp5/1F2o6q3Zsnw=;
        b=GRSIY+4q2576poHQqP08OEMivU0p02tk/m0gPKfH5JbzNNAlwT9r26gCHIVZeZIBrU
         SctCkecbRpdpxMgBeYGxchiotopoPVgYiB+aiKb+XdpIR6pJ8XvMa+2JL7+Add7QfJRK
         d4ECYJszDyoCdMkkSJfLlimRKY2wid+amsMGRDN5VeDYR3LoCkkMlkm4YRdu6SQmdO3D
         m/L6WNNV6YtAqpfB/bTlCH0f5xXts4Jj2B5J13wBnO1IfJFU69tg9dA+w9eND3iT5b6P
         ZHhY0zSEAOcEPfNDQHWeMIaRdPkJtxIme/6KX+ilRYwy2JLYx4MPNmvwCa1iTHE5XV29
         AR+A==
X-Forwarded-Encrypted: i=1; AFNElJ/FewlJ37J9stnXP5oLyd1L0pXCySm553Ic/xwaSkQygEl7FX+vMfRZ4pCFWaKzSfJueKDXi5HpVHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/5qBGiioKj8V/HqsOpgERHTEh2lWBMwV55SmdOzbIrzgnq1b
	x1s62xQDF8UBuBa4RNrjuLADHy5LKjyI9u55jXv2lzEG8weT+Ps6kHBx
X-Gm-Gg: Acq92OHX2IGKrCWBPdhH0/N7sSsqCGqC8p8VozZMONi8tz/ZjeAWSmLu8dU9E5/J/cb
	Anacofzi7KHv5SgoPOqqPJU4ByxGbMnTK098IzRHMFleG5owN6as4UgpIeLCBGVwyuQ+brhQEVc
	ORhgySsPjJcKH1tsaf28DDKxc8WUIczxrB229DNU/BsIXo3o/QO173qKblnU9rbg68oy+kruN9v
	TH0KdhGyz/r2UvKek5bz11Micf7mxFmKFgBcfwGRs4s2v191yZ1065Wg1+uIesfr+MHZ37t8fhS
	rC0DNr5Q+UUz0wl35pRfkGmjFq5DOjbTSLmzCL0bJ35m82wUFtaZqWbiVP7hLO4ktRa4fapmRFH
	HUD8jWsZz3qeUQnDuCBEVziZEO9Xly2WaE0tI/5ExjOy9z1Q9+OmeKRlERlrazKsUZAnx6JiMZd
	RSBmflJ/3RHLShkNehhsI1mp0=
X-Received: by 2002:a17:90b:3d8a:b0:364:a173:2d61 with SMTP id 98e67ed59e1d1-368b2511be6mr449645a91.11.1778537101695;
        Mon, 11 May 2026 15:05:01 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771c6ddsm9907259a12.23.2026.05.11.15.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:05:01 -0700 (PDT)
Date: Tue, 12 May 2026 06:04:36 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Longbin Li <looong.bin@gmail.com>, Yixun Lan <dlan@kernel.org>, 
	"Anton D. Stavinskii" <stavinsky@gmail.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add fallback
 compatible for CV1800B
Message-ID: <agJSPkA88GcTYS86@inochi.infowork>
References: <20260511063818.463877-1-inochiama@gmail.com>
 <20260511063818.463877-2-inochiama@gmail.com>
 <20260511-crave-sworn-3b43371ce11a@spud>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-crave-sworn-3b43371ce11a@spud>
X-Rspamd-Queue-Id: 8E074516950
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10334-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[synopsys.com,kernel.org,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gentoo.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,inochi.infowork:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 05:01:01PM +0100, Conor Dooley wrote:
> On Mon, May 11, 2026 at 02:38:16PM +0800, Inochi Amaoto wrote:
> > The previous version of the binding change only add compatible
> > string without adding the fallback compatible, this breaks
> > backward compatibility. Add the needed fallback compatible to
> > fix this.
> 
> I don't understand how adding a specific comaptible affected backwards
> compatibility. Did the dts originally use the snps compatible before the
> device specific one was added?
> 

Yes, the device is already in DTS, and since I find an quirk for
it. A new compatible with fallback is necessary.

Regards,
Inochi

> > 
> > Fixes: be3e2a0419c6 ("dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > index 804514732dbe..0a30a455b0ee 100644
> > --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > @@ -21,11 +21,12 @@ properties:
> >        - enum:
> >            - snps,axi-dma-1.01a
> >            - intel,kmb-axi-dma
> > -          - sophgo,cv1800b-axi-dma
> >            - starfive,jh7110-axi-dma
> >            - starfive,jh8100-axi-dma
> >        - items:
> > -          - const: altr,agilex5-axi-dma
> > +          - enum:
> > +              - altr,agilex5-axi-dma
> > +              - sophgo,cv1800b-axi-dma
> >            - const: snps,axi-dma-1.01a
> >  
> >    reg:
> > -- 
> > 2.54.0
> > 



