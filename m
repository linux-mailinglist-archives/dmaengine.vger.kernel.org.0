Return-Path: <dmaengine+bounces-11355-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /W9wJWyBKGpXFgMAu9opvQ
	(envelope-from <dmaengine+bounces-11355-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 23:11:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E751666434F
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 23:11:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jqSyEBOF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11355-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11355-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEBFA305D5EB
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15FD3E3C4C;
	Tue,  9 Jun 2026 21:06:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679E3DCD8F
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 21:06:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039197; cv=none; b=W2Zzp1LUb4c48UBILa+2sJs0KRtLwNIfJSAk9ZdhQzESKvLu0wt1fJLI0/xPwnoEZa+W7lnLevVDTSAW62qYKefN6dw05W6VnE03LqRry/s3IydiLE2axJNXz5VdDXZeqDp2VScq2na5YqHshNbXXWJyLNcRDThU8Ch8SubPMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039197; c=relaxed/simple;
	bh=JnRgX0E23Ha/jYZIEprqGGXXF9FSZBw76QfDOqcYCMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHBVPAAGpqAOLav+vGmZ8FX+VNRIbMGJNjq+/JdzV3gHKDgtKZy729qm6fJl94ukxYrolDflEhNEgm2jsCpnNH9L9ujeJdDaQcOQ2E/J0OeQJpJG1g1FGbZdYTyS0bzD246HSJih2YJVL8TV8rZiTI/xTYGsR1J/yVeXDb6lOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqSyEBOF; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso5321712a91.1
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781039193; x=1781643993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1dX9Gf5auhZd7M2vITh4vuMczhC2UZxTRI4fFpUYnQg=;
        b=jqSyEBOFgvUds8fO6J2Gtp24254NgkmdmECVxkytQh+GQB+HUvSbhV8BtWOzEXqB2u
         bokxh333Q8YBWfdoUAYlgx8b1r16dLtVFihexId3K1jLQKBB+nx6JVQBj/ETaY3cbHAi
         f72Yh0RsjvFnaFndeMhifd92C/BhW2OZ9/FGqYEaZLdWDuYqIb+xUQ8ewsHabPrAjZI0
         b9VofjRhwg6lg47LcvR0Qi7vH3814Jb1UxIEh21iC4aUAI+noE6uQNwfjuNblhBkILxG
         NB8UU0JI9kf57HIllgSQdbV2DtAEoVt8EJTdSOcjtrqqUvQTzgayd8DARzmNHBJW8bdP
         QE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781039193; x=1781643993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dX9Gf5auhZd7M2vITh4vuMczhC2UZxTRI4fFpUYnQg=;
        b=JD+QkPDa7U+xpYp7HT+Vn2wJnJ4x7XCVMpXOciSapq2wh98BCG+hSWB3ij2iVFcFhK
         3JzWTwLMSh5YRQTBR5iyOnI0G1T/ITu6mKU39DvrRS/7vuDnQBXU45cDIRET/lMPWtwR
         LwYXOhIENZ9erKxdL0m0IOQe3TCRg8mMKuQcV2BuzASqeGwUv69tMxu1O3WE7ogp8qhD
         suijWlbS9b3PmjNmMxeB1a+KB7F/mdjb7ywjHQPhGBqUJP/VFIdN0CDtr0icpVyeo3BC
         smj2LD2oZwKlu/vG+VwNAyI9XG+VcqHz3FHjC5K/2gznTRNH03H3gulXYjduVn4WJU2Q
         dNUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1PQN50QpxzoAAkMbCPiMAPa5y3FmottU1IaR/9Lb8jFQjk3CXXZ6XFN3p9va06ODIgT6cZ8WBpO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5HwAlM9zZMWgujFLb+tPiHoEW9b/r4ZAKVfhYyY9z60T5BWmZ
	4xmuSG5VT3xdKEqILUh28cuMbiDU2VNgbwE4dtdI56oRb1gSGJPhsMvpxRNppzaa5rE=
X-Gm-Gg: Acq92OGXSCzyE6nljc6Bw0Whg9MFa2OEtMymiwlYnDk4d1tXEPFWa9cni2YHBv+ocmz
	I4Oet57TreS8MruqK0X860mJ7zeC/2Xo/TRpAWBqDhFn2XMG7spi5yC9DPEOLrpw/rGJJYCKn6h
	1YH3KCg5HTBDek6NFJGxD9kfRriBM0oXRSj3pyDk2DEmpwSywSczJqdsW9SJ6nSp3HMRMxqkylE
	oRLUx0PugLRVak6IDYYc3UoftciqIAKpowhNmMabGcnzJZ4H3hUaK7CwUtci93DnXn++faT8PlE
	IZlXqTDQJGduo57OC4P/q+AyqoNXTqfFoe4IbmIknRJBLAU2a6PvM+s8zfFIKq0y2a99tCCpCsz
	mNGsJUdxzznjFTjVSgAUJ6dMUpUHtI9csNfrl7rJII0bYtk/tQTAFUTSdjFd7LsE723AnfiQDjV
	DGAdYREQ==
X-Received: by 2002:a17:90b:5345:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-370ebff342fmr22737341a91.0.1781039192824;
        Tue, 09 Jun 2026 14:06:32 -0700 (PDT)
Received: from localhost ([2a12:a305:4::3060])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf903fasm20158546a91.2.2026.06.09.14.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:06:32 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:06:24 -0400
From: Guodong Xu <docular.xu@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add SpacemiT K1 PDMA request
 numbers
Message-ID: <6ycdvhpgygnelzp3ot63xtzcnlvac7emngvj7tviiclst4a7km@kjq7oqvecnxx>
References: <20260607-b4-k1-pdma-req-macros-v1-0-5b2a3955007c@gmail.com>
 <20260607-b4-k1-pdma-req-macros-v1-1-5b2a3955007c@gmail.com>
 <20260608-dazzling-hacksaw-dbe84766ec76@spud>
 <qxcpvj3eseclgonwuwx2szn2tj4uxci27mvpqwotj6uaiyj65p@7sx5tyzbfs2g>
 <20260609-freeload-luckiness-7a143eae62f4@spud>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260609-freeload-luckiness-7a143eae62f4@spud>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11355-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dlan@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:krzk@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacemit.com:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kjq7oqvecnxx:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E751666434F

On 2026-06-09 20:54, Conor Dooley wrote:
>On Tue, Jun 09, 2026 at 02:55:59PM -0400, Guodong Xu wrote:
>> Hi, Conor
>>
>> On 2026-06-08 18:33, Conor Dooley wrote:
>> > On Sun, Jun 07, 2026 at 01:41:30PM -0400, Guodong Xu wrote:
>> > > Add a dt-bindings header that gives symbolic names to the SpacemiT K1
>> > > PDMA request lines of the non-secure peripherals. Device trees can use
>> > > these K1_PDMA_* macros instead of magic numbers.
>> > >
>> > > Point the spacemit,k1-pdma binding's #dma-cells description at the new
>> > > header.
>> > >
>> > > Signed-off-by: Guodong Xu <docular.xu@gmail.com>
>> > > ---
>> > >  .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  |  4 +-
>> > >  include/dt-bindings/dma/spacemit,k1-pdma.h         | 56 ++++++++++++++++++++++
>> > >  2 files changed, 59 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
>> > > index ec06235baf5ca..0d4ac9849e27b 100644
>> > > --- a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
>> > > +++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
>> > > @@ -35,7 +35,9 @@ properties:
>> > >    '#dma-cells':
>> > >      const: 1
>> > >      description:
>> > > -      The DMA request number for the peripheral device.
>> > > +      The single cell is the DMA request number for the peripheral device.
>> > > +      See <dt-bindings/dma/spacemit,k1-pdma.h> for the list of valid request
>> > > +      numbers.
>> > >
>> > >  required:
>> > >    - compatible
>> > > diff --git a/include/dt-bindings/dma/spacemit,k1-pdma.h b/include/dt-bindings/dma/spacemit,k1-pdma.h
>> >
>> > Why does this need to be in a binding when there is no use of this in
>> > the driver? May as well be a header, particularly if these are numbers
>>
>> Thanks for the review. You are correct that these are not referenced in the
>> driver. My change to k1-pdma.yaml should be dropped.
>>
>> > with a set meaning that are lifted from the TRM, rather than made up
>> > numbers to make a driver work. The former seems likely, given you're
>> > indexing from 3 not 0.
>>
>> Yes, it is defined in the K1 manual [1], see 9.4.3 DMA Connectivity &
>> Assignments
>>
>> Link: https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k1/k1_docs/k1_usermanual/9.Top_System.md [1]
>>
>> I will fix that in v2.
>
>Just in case I wasn't clear (and I think I wasn't), when I said "may as
>well be a header" I meant a header in arch/riscv/boot/dts/spacemit.

Oh, got it. Makes sense. I will move it to
arch/riscv/boot/dts/spacemit/k1-pdma.h

Note that I already sent v2 before reading this, please disregard v2.

I will send v3.

BR,
Guodong

