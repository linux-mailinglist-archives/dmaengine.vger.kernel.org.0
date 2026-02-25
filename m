Return-Path: <dmaengine+bounces-9065-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDs5HXHTnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9065-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:48:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2131F195FD9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6746530515E6
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C332A3D1;
	Wed, 25 Feb 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUyC7rmJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286462DB789
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016248; cv=none; b=L2fEiquXCBZGVwS0VvwqjYJh3d4mSELCcikmUosIPpyd+3OWjT7zKb5Lm4FTTvWovK0vd6545at5jks5ZwBKhXE9ambDYPtScLnD5P5PE5VuZOjRx/cynTsWJBzXTdiEaSg5Jv2ER6vLCFAVE+/33b6gCqutzFR7rfLwSk1oM2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016248; c=relaxed/simple;
	bh=WgAXcvLFOLlS2CrV7fMpnmt29OISe3ahfs2U6BLXuUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj4bm8pW+PH1MC5oOCtHn3oPdOVZnxtokcB0tqKOdSfJ2tUR6XlGiGvlIxjD/X9I25bM7HSOFfkvq1iYGe6eC2B9B09zRP1biEKPg0B49Ren+VfImpjSZp1ZF+NC1k1wGgvqC92nqV5eqyVwVLF8+Zan4hZpgLFjZsHpbRCzots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUyC7rmJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824484dba4dso4917116b3a.0
        for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772016245; x=1772621045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOtyPf4DV0kGbhPpq+32kw+kEiZwwmgV8bS/8w37MW4=;
        b=iUyC7rmJr0h+XUS/rpcVokWVJfwWdRkHKjNR9fZu+2LWE8ETl4la7f86memOBkaYsg
         KViTEflgkz3U2ge0KgFYoVTziKf1AeOstX96BnyEPmuSXxk+/wyEBuRzDGho5+s1g83t
         ZcZRrRfY/BpgPh/05utMqEs2oCXJ9zYm42qf0ucTAe2ciMNya9/Q/jMQD862fCvPT+3A
         eGb63LLo2EytsfIznQWEuhnJ72exEtFig8b8NVH9YijIOlk5ohOG9JaX05LCZqpRm3D6
         YLEtkBzCzSwl0FoNEHryfeAwFHhVlSGUxtDOyZHjciOgcc93OrQTPNx3rRt+nHQ2RAQi
         /4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772016245; x=1772621045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOtyPf4DV0kGbhPpq+32kw+kEiZwwmgV8bS/8w37MW4=;
        b=oGRdHSrjrEKWclQoutj3M785pVwyxLKryyCuHEss3NNR6u6hglbvQ5tMk/3bH1YD4Y
         Bn128eukeVlKM9GcqN0RJx+gJ7cGr4AW5Ib7ugE190Yw6DqI5Z3gxq1Z9Fmgtn5Y1nc6
         euqH0tFUol7amncd9SNgQciBZbouSjaXkFf2n2W2KVtsRrqgSVeoMxlC57SY1daYnpUx
         GJt5uRQOmO/oisM15H7FMXW21hn4V0Qo66hM/NLNHaGFFqgmpWPHuumPEr+RDPLmxJS7
         6tvtEMjzEAodMqUAkWP8W1oKQ/gC0fzAETAhF9am+7isx8D1F7avQgBvdbrdeIuMmgkG
         C3uA==
X-Forwarded-Encrypted: i=1; AJvYcCW/RtN1X90O8hNtsDG1iYFY6yTmjy1/yzUQkThUGsjAcPhSLI802Ddm8/5F1IIGEkmC8aR9RCHLqMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1j7wQS4Lbi4Fo4Ar6/Z/Zc/mzCTFnagWsDLbWkM3bXpBwmpgb
	oKSMM0P9VOTwcgyFpS38oZtBiTvZ7H1iSHmu2hmkYB1B+c+V/pjl4AUi
X-Gm-Gg: ATEYQzzD6yEIGFWpqqSL58DpgqIolm80Tqsij+JOawRo8eO7VyxlfVEVYtNzKhKvdE8
	a4qqqCa052hUiuLg2Xz4ppdZx2gZitOD0jWGbTeM1wq0t11h85xND8dI4UHl5fSf/bFNrtrvDo4
	Up+Q3iGp8CzWIucSQog4MciU+Gprie4OkmLfsB6WIiM1umVFWAHi9dO9UGhod5Bt3pdjh0zEpKX
	hJT5NqATlymnnsmkaa6R1alh0O/1RsaCXWVsAAxbE++qeh2zsUz7yvd3hSLrOXJcd1DPEqkjiPj
	ZX2CqrY9JXyNiINqATa3v/qAfewNFP2DKpAV9xr+KCvItQxwiNtFH3bxvv1T/2hqhphCaMXnWFD
	qC5iT2A/rO3yEwmaD353rl063xf4wcpLwT4gHmQYU/TSIEo5rtuVcY/tkRX6Qu8Ns9bVFjkCkCJ
	ZxrcnCPLtBfQuAme7uefu/pQ==
X-Received: by 2002:a05:6a00:b8c:b0:824:a4c4:3b3a with SMTP id d2e1a72fcca58-826da8bdbcemr14510549b3a.7.1772016245518;
        Wed, 25 Feb 2026 02:44:05 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd86c93fsm13820247b3a.38.2026.02.25.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:44:05 -0800 (PST)
Date: Wed, 25 Feb 2026 18:43:42 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Longbin Li <looong.bin@gmail.com>, 
	Ze Huang <huangze@whut.edu.cn>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B
 compatible
Message-ID: <aZ7SHVTkDeES_r72@inochi.infowork>
References: <20260120013706.436742-1-inochiama@gmail.com>
 <20260120013706.436742-2-inochiama@gmail.com>
 <aZ7PLPFVnWjaBDpa@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ7PLPFVnWjaBDpa@vaman>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9065-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[synopsys.com,kernel.org,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,whut.edu.cn,vger.kernel.org,lists.linux.dev,lists.infradead.org,gentoo.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2131F195FD9
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:00:04PM +0530, Vinod Koul wrote:
> On 20-01-26, 09:37, Inochi Amaoto wrote:
> > The DMA controller on CV1800B needs to use the DMA phandle args
> > as the channel number instead of hardware handshake number, so
> > add a new compatible for the DMA controller on CV1800B.
> 
> Applied this manually, please check if that is okay after push
> 

Hi Vinod,
 
I have send a new version for v7.0-rc1.
https://lore.kernel.org/all/20260225104042.1138901-1-inochiama@gmail.com

Can you try it?

Regards,
Inochi

> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > index a393a33c8908..0b5c8314e25e 100644
> > --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > @@ -20,6 +20,7 @@ properties:
> >      enum:
> >        - snps,axi-dma-1.01a
> >        - intel,kmb-axi-dma
> > +      - sophgo,cv1800b-axi-dma
> >        - starfive,jh7110-axi-dma
> >        - starfive,jh8100-axi-dma
> >  
> > -- 
> > 2.52.0
> 
> -- 
> ~Vinod

