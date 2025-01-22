Return-Path: <dmaengine+bounces-4172-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E164BA194B3
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2025 16:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F3A3A3F71
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2025 15:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F8213E86;
	Wed, 22 Jan 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUkKL1MR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26B2144C0;
	Wed, 22 Jan 2025 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558494; cv=none; b=rxyeVMUnVBJOHFJhk4YeQM3w4lapb0vdXR3cyRrRWZuAbfMWH5XUi3rbMMDKSq6kd4dOi76jFI0z1//RWJqeMp72qIpGUa7H73+FPnh/dWfyKFtz0KsxBABx7E71W4kt0/xcneR71APX8LxFo/Bwv0tTjTUCjtHCSrkG+KF6DTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558494; c=relaxed/simple;
	bh=txrdZbOO3sExJA/wrhn5QYdR2BvOlBo1Fag04N6yJBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnXUXiiBT49gx2zx2qZjbL0Z5/1vZSc+cFCubWdUbpjtaYdvBcH1ycbIDycSTxpwSgSQni8ZMZx/wVf4ZAAbP0yOZ4ZTIBs+LWVT7+xduVCBHTTDIbhLNKoJpulx295Bz9HnFfWJV8n1PhpiiPXH8N4gmZnoXBqvjRwLKUtBI78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUkKL1MR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54026562221so7052717e87.1;
        Wed, 22 Jan 2025 07:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737558491; x=1738163291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umz6FsDsVFwJuh2rg9jtJSv3h52jbplrjXp7FNQjbO4=;
        b=WUkKL1MR28lTryVBaOD6+UFi6XG5pJehI0wM0cKlYu1C/kLu+sxC7T7WVjGBNjPduy
         zSXVp8BVk4VuPMDpwSXv3FEmg3YwSgh70Hp4brqSBDj164S7lmRWGx6xHUQZOBVwZdD1
         90X7HLOIT5Yrgr9/m+ODVESOV0WtPhcL9b2PRQsHLinDNZHbwmz2omvsLkrCOz+Njuuv
         xpc6K8vrhZI2YaBhn+KB454a1+J5AbbOZp8tcgbbRaPSJiCrYKQmViCItfvmUl05onOx
         q68GfKDmSzjaDHA8DgMJc74WQh7Zl+caSR9AQV1UhAGhlSHYki1mn/ECArayAb6TdfBY
         6I+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737558491; x=1738163291;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umz6FsDsVFwJuh2rg9jtJSv3h52jbplrjXp7FNQjbO4=;
        b=OIQL8PGfNkJJmWy5vchm6HSjCX6pWXddjf1BEnEovdyzQNr63gFcp5mk7c+nvpcqmP
         3ZPpWPo2tvrR5kC2c3RipWbN6JiKDL6Y0zdamY6pA3/nYlNQZroMe7gKwy4PKNjJoAw9
         7alATRSNJv8G8DpBMb2TbQ5fc0dddJcuxX6gWTezsRfVb0w6CXsvzVcySzpkZJSf+LH6
         72ojqOOCTY4hhco+6FL2eEroMf6H+R52IDCA24obMmEg3LvmJlhJLwoBeJ6szFdgEk31
         677oOsq+QL49RQ86CGQlM13C+iKQxr4lEKcipaXFnIrlAdhCDRmWJXn11a+jEKHb3inA
         KwcA==
X-Forwarded-Encrypted: i=1; AJvYcCU79xsD7gwYGqoj2fLQTqNzjHnxJd2krwq+h9RPYPM6f6MzBW6iYXHgvPG5aZy2xRWgBrmvkW2X@vger.kernel.org, AJvYcCV0jrTdYGfSbS632FtjsydLKtmlmgv+LUz5tSoPlWqeLBNNNO864EuVWuOrCJUSXSZoLlSlty5ShyGVWyhB@vger.kernel.org, AJvYcCXF+2Yf/zoahYKv0iv9Fj92WAqy7rplOP7xheScW17dTztbDbneF0blj7VZbEpLmSmYJC9AOiaC+rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXpC6VP+9vtxPBunMPEp+aD+k+l62eqzx4FUSHx3bFzeMG354d
	evbpXio/L6JxiK+pKDIUFu/yjZ4VFp8COhN4W4lf7BZKRoyOmqIC
X-Gm-Gg: ASbGncuS5TFYrL/Lj3L/YPYIXVMoJGfeEpVtDVQdwubFT4mtbngM4B+2gLOQwXfVb5T
	yrplHLo9Ujv8SurCHSfQi4+F7xT0iUm2QvGzCvIFLQvO2n5xZh6fy+Klzjrepb9f0YoXYEwWUYe
	xVzfNdaN696N8h1jJ/yNM5Y9syDOa95v1OGSu5rUCnA2pveHvmqh/NdyIziEdVqhLKmxyoD6upb
	0TxVx/JMlLuUfavvtAdoTD+l39+WAcjLqecBrYo66P3yVtXuWbZIuYhUw0Vw/mZwJ034miiwVXJ
	fzbxc75OGitn32BUC946dFPdr6nx1xT9i38f8fuKWMZIuJP9Pio6F+hLETIopse4rlGyzV1+dWg
	GH0t1TLMR80TLE0g=
X-Google-Smtp-Source: AGHT+IE2a0yAIO4BOuV/oNsZg2RXIMgYsnxf4ES5Xw9/S5/1JbkObgMJtKJi8R+5obE5eRRkCTd+ow==
X-Received: by 2002:a05:6512:e83:b0:542:2a81:a759 with SMTP id 2adb3069b0e04-5439c21f23dmr6119766e87.2.1737558490533;
        Wed, 22 Jan 2025 07:08:10 -0800 (PST)
Received: from ?IPV6:2001:999:584:a1be:41d4:8b85:aace:5430? (n5ykva7sx9871hnihio-1.v6.elisa-mobile.fi. [2001:999:584:a1be:41d4:8b85:aace:5430])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af07b5esm2263566e87.45.2025.01.22.07.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 07:08:09 -0800 (PST)
Message-ID: <decd473c-289d-44be-b882-3f2bb15c0d57@gmail.com>
Date: Wed, 22 Jan 2025 17:10:31 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Drop skip_fdq argument from
 k3_udma_glue_reset_rx_chn
To: Roger Quadros <rogerq@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 MD Danish Anwar <danishanwar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: srk@ti.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250116-k3-udma-glue-single-fdq-v1-1-a0de73e36390@kernel.org>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20250116-k3-udma-glue-single-fdq-v1-1-a0de73e36390@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/01/2025 17:00, Roger Quadros wrote:
> The user of k3_udma_glue_reset_rx_chn() e.g. ti_am65_cpsw_nuss can
> run on multiple platforms having different DMA architectures.
> On some platforms there can be one FDQ for all flows in the RX channel
> while for others there is a separate FDQ for each flow in the RX channel.
> 
> So far we have been relying on the skip_fdq argument of
> k3_udma_glue_reset_rx_chn().
> 
> Instead of relying on the user to provide this information, infer it
> based on DMA architecture during k3_udma_glue_request_rx_chn() and save it
> in an internal flag 'single_fdq'. Use that flag at
> k3_udma_glue_reset_rx_chn() to deicide if the FDQ needs
> to be cleared for every flow or just for flow 0.

This should have been the original approach, there are things that
clients must not care.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>


