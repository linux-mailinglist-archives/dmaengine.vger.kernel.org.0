Return-Path: <dmaengine+bounces-1375-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EF187AA41
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 16:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD369283D64
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAB147A62;
	Wed, 13 Mar 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NBQ0WwKb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E7168BA
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343001; cv=none; b=uZq3i9Zi++PNTpcMd3qj0cqT8F3GeF6BhSwOiFnpnLRmj6VBotIqYwnzNhGV3oPqiRkraJwijXrDht2QiuPZHAmjlP+7K59yMFZFS11swzuD8EYgsr/BdQEubx47Cx79zn7QGUGqTaqCmbq8LFDzVAdZbtmtvOp7HBVuDB0AGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343001; c=relaxed/simple;
	bh=qjrM/hxV7DN0FytBHdDLWTGw6uIVVQc7HD9mEPDm0fM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4JWuJpsGg38NsP4xPNrbSWrABWNgWU676pfJxMu0k0WGVCW+JoKQQgVxWCyYJxA2vmXkNFZaRpC1cAa8h8IloPtBhJCWhHSG5ZpXNfd/yt2ZqQThShqvMxaghN0meNx58c/MuYiBj1V4xkXt/8lwE+l+gpVs2F22ZDV8T6LjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NBQ0WwKb; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513af1a29b1so3377487e87.1
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710342997; x=1710947797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rykq8eCaBPkLJ9gIocamPtpK8SPc8Htjk1jYv44ATH0=;
        b=NBQ0WwKbWBCE5leSuUHIwJb03vnw0yFim4Dkdnhs8ICshyNjjplkHC/IYJaNQxhNQI
         24QNXbHRCWel/EBMXgiHCK0AGu46x/Slsn/dp3RbUNxUZmRnDSvYfrXXsfFn4GFvkcVr
         nyWzpoVS9nkPLdbv7UhTLqaqUBVWGSvc5w6MPHJzFLeLem0vWDklMp8rGZkkb45zkuaO
         nqY97lrqz3xUPmrQqjXGe6FxkjMPsVUMVhHD783YYO8rDvK0nyaZgfzVzo9CfvTOoyRs
         xmMfcToV7SFgyh1KhSv1bBklT/yDmkdh3OLb9S92NGwY7lINtH1qKz/5Wu++ru0VKair
         Az4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342997; x=1710947797;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rykq8eCaBPkLJ9gIocamPtpK8SPc8Htjk1jYv44ATH0=;
        b=eBtnj4UHxxBZV5I1mAw0f3OyoY1V5+ZQL8NTpRTkORZQCAgEE70r3YEiuaoV7W6Lez
         IZ+5Zw2XuLAIw8etVJZFS1kJNhJgFK19b6NoOv5t6LnF81yzyPXHcwprYE6gzOjUIVF8
         4swWroPQ7Jt4wnGMwzL0F9IGYruvdHPzLRwJmO7DXEj8zmfOYSV44p1dhFZDYHrjC6zF
         Uznd5Bxe8Bep1WtPiryhzN4l8bRUB2Lat31gBGyBNF9NbOtK5fZRIWJDDFJH1nbGRyYA
         RaDJ1ENrBNi2M13EFeR+3M1HwWu+q1jex/6A7ysVP2dV8igB681RDSGlBS+pVNSBWqul
         GjBg==
X-Forwarded-Encrypted: i=1; AJvYcCUTmKBdqKSi+Yy96HB+zR3flFlRZrdUKEnI399qHpaioVHBhYeusROU0utsDiei7zUX8FYPGS5SuPvpxnhC89qsJDPfXjdcE3bs
X-Gm-Message-State: AOJu0Yy0H9BjtpFf9BQL9PtKLQQ5yR4opxaZkwgV7qxo8Cx8VAfPga8+
	Zyhd7yBWfT6F3nx/XU+Oa/7JZxcsAEJ65vMFGbhZH2bSoto/pRkSSfz+ZuXfhX0=
X-Google-Smtp-Source: AGHT+IFGRwJvOnRL1ILnNJUxepiuHVuA6un577kLjwGaD9hBY22+JpFvvv3wGZh/8RT3DrosK3jWDQ==
X-Received: by 2002:ac2:410a:0:b0:513:cbf5:f9e0 with SMTP id b10-20020ac2410a000000b00513cbf5f9e0mr618774lfi.5.1710342997062;
        Wed, 13 Mar 2024 08:16:37 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b00a4380e85e5csm4918419ejb.202.2024.03.13.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:16:36 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 13 Mar 2024 16:16:36 +0100
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com
Subject: Re: [PATCH v2 13/15] dt-bindings: dma: Added bcm2711-dma
Message-ID: <ZfHDVCK71tuhcpv-@apocalypse>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com
References: <cover.1710226514.git.andrea.porta@suse.com>
 <346611b3ec6f47cb10e538d6cbe52056f535f965.1710226514.git.andrea.porta@suse.com>
 <cd4fb265-8788-4309-9d9e-9676d76c1fe8@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd4fb265-8788-4309-9d9e-9676d76c1fe8@linaro.org>

On 17:17 Tue 12 Mar     , Krzysztof Kozlowski wrote:
> On 12/03/2024 10:12, Andrea della Porta wrote:
> > Add BCM2711 dma engine compatible.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
> > index c9b9a5490826..4271a6fedf54 100644
> > --- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
> > @@ -20,7 +20,9 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    const: brcm,bcm2835-dma
> > +    enum:
> > +      - brcm,bcm2835-dma
> > +      - brcm,bcm2711-dma
> 
> Please keep the entries alphabetically sorted. Probably same comment
> applies to your driver device ID table.
> 
> With sorting fixed:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

Sure, I'll fix the order in the next version, after collecting guidelines for dma_map_resource()
issue. Please ignore the patchset sent today since it still contains the dt binding in 
the incorrect order: thge patchset has been sent as is just to reach all teh parties since it
was splitted due to a problem with my imap server.
 
> Best regards,
> Krzysztof
> 

