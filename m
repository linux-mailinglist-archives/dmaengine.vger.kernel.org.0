Return-Path: <dmaengine+bounces-1337-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCBC878E63
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 07:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25221F21081
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 06:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9D625742;
	Tue, 12 Mar 2024 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vh3u5K7u"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2020304
	for <dmaengine@vger.kernel.org>; Tue, 12 Mar 2024 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223473; cv=none; b=u/jGw57Ip6IhEu/uznTuEh/DxRz+3xhb1x1Vg3MACDI1+q+hyIEpBJHuGftptFoCRVgOOwqEcCyUBhdz2sl9Au08iCQia+zt6eNLk4xeAckPf7zEdmLSM8C6GDKnCmDYIwTazUaIND/yWcto3HB26o3PqPUV4p8bWoBreO6h/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223473; c=relaxed/simple;
	bh=9jB4t/FMl4MSxLFMoUWxqI02cw1lVYppihYctJKdru8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvpDtxbVovtu+m6peP+YHB1CyAzdLg5hQctKj3HO4J8h1RMYWziewpe/BoXnKIlImDHViTH0oy6rQhyRjHz/wBDNb6ejyVl9d5YGKMqsPA7cTNbFzR5d5DCxbFJOR/Qhy5McM4ZJefx5UQ+PaWSks5itfRg6Lp49tiBj/3FeJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vh3u5K7u; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso3106990a12.0
        for <dmaengine@vger.kernel.org>; Mon, 11 Mar 2024 23:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710223471; x=1710828271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi1j9nXbepLSnAZq2xPJYsLpHSLoOTfVPK3ch6zUNmo=;
        b=vh3u5K7uLi7b0htaFCjydnLKB5SOw+PXWbjDCybcGKpLMeAzm5FkQ9g7Qxt3S5L9Rl
         guH9NyFkVmwuNYSoFxRDispu7irn9Rd6XVmbHOdOOlHGiIUgFv5mXcEB6E9wjk1ZhIOO
         T8XPsDkvGasALQDGUk/l2s0Csc8BpJUZsdTGLIZOBKG549rA3DJxtMxdGNT7TnEHuaEo
         GecEYZYHfkdpUccdL+3u/GO7uaIp5bZx7bZJ957Y7SSnt8xT0NtlwU6Qydh66tzVoew/
         TpnU/Lb+hrrwdgpUdxtHzSzMYlWLR/Ij5RaAMtbDr9M8gnmTpeiIsqI7bZ6P9v04FYuv
         0Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710223471; x=1710828271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi1j9nXbepLSnAZq2xPJYsLpHSLoOTfVPK3ch6zUNmo=;
        b=kyqfRniUUo8ttGwU2ke/zZ1OGOSaI766XiwF7DwnidsitVy6EUHFAaOuwQBspJRDLp
         7DGruMC+Uvm7sTqVCBRL9D3s2xpA/3MaerNg5i20nLJ6RAclJjsBOgNiSrfAVCPWkmu7
         h2FYwb+GdLvgxAI4NU4m7UHhN045VlEGYqBBPHkf9zjhB4SozvU95WcyKvcAGdNkSzWo
         96x4mGnp3/JgZ4Na0QznBMPo0vTsPxWs5kln7hl7ydYeuSqAni0Lgm2chIk04woP50Z0
         FKNPjf/GPUZ97zBgOUePTatj6ibDIhmA5O25Trc80KxwK+Wzftt/d3ixemL0ag/mmYSE
         WcTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTusaFvq0o6bOfSXy8M0IrH9e7P1QSqLYzHb84A9VgRdtYglJvjQ8IFs1KlBlem16d+J3uKoQZsK//CKVNzFO7pahBmqgV5ca9
X-Gm-Message-State: AOJu0YzwSlwWaLuGDPleQbkM16Ool9ZERch6M/LJ8tGfcvNu9BoctiUj
	U9smYK8va5FKBKXB9AW0L0JtwikQOHH4+3IFugekmlSp3miCV+Uu4lDXordXkXNOB5dZEDtd15W
	y
X-Google-Smtp-Source: AGHT+IHXsJZxoKfM1XfX/YP/0RviH05W5+ufj1/onjKWZOloDTG2V7hvnC4M3ITEMpJ9QD+Yu+oTTw==
X-Received: by 2002:a05:6a20:8e14:b0:1a1:3cff:874e with SMTP id y20-20020a056a208e1400b001a13cff874emr7401881pzj.8.1710223470921;
        Mon, 11 Mar 2024 23:04:30 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a150400b00296a7ac8b5fsm9451769pja.6.2024.03.11.23.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 23:04:30 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:34:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width
 schema
Message-ID: <20240312060427.jizd3bvsbh4erfrh@vireshk-i7>
References: <20240311222522.1939951-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311222522.1939951-1-robh@kernel.org>

On 11-03-24, 16:25, Rob Herring wrote:
> 'data-width' and 'data_width' properties are defined as arrays, but the
> schema is defined as a matrix. That works currently since everything gets
> decoded in to matrices, but that is internal to dtschema and could change.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/dma/snps,dma-spear1340.yaml      | 38 +++++++++----------
>  1 file changed, 17 insertions(+), 21 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

