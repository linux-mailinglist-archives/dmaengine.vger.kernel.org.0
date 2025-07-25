Return-Path: <dmaengine+bounces-5865-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 145F2B12100
	for <lists+dmaengine@lfdr.de>; Fri, 25 Jul 2025 17:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DA81CC407B
	for <lists+dmaengine@lfdr.de>; Fri, 25 Jul 2025 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2723C505;
	Fri, 25 Jul 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB0dbHCn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C74262BE;
	Fri, 25 Jul 2025 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457738; cv=none; b=MIyFSvIhjOcTDmAyRcYCURPdUQ13HvIe7KjHfG5rEBi2EZeVZx4AK7zYWh7WyL3iSKa82qHZqf+3x660jf9RHrNDUlyClQM9vV9Fpk613rtGBvIvKMKjPSpDDmOrsLtdK4I6Nbzk4BFzeMjyNdozpqAxvkLAzARIFytaDDIoZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457738; c=relaxed/simple;
	bh=/OS1bgYV5IKAPQNdEiTK75hIgWlqClQ/txdikGtyv/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2tBLK0hv4SDsSOo5NeFmfzrDfDBCXXDMI+jTU3RhNmEwHsnV1iB8ymSKZq6pX/XSd8jiuYfsZL0EZmBy35uBxP0MHN3DuGoagWQpQxcc9cJ0a5GBp3vG0WBDCqH51T4nTRUOsUh02vOdKYTxGCgdeaAgOl8/lIDTaL5/XphhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB0dbHCn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so2213948a91.1;
        Fri, 25 Jul 2025 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753457737; x=1754062537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk/4Kezo0VhjUc+1VwBBR6iAeqx6TFxLUBENU2vrQBA=;
        b=QB0dbHCnrA9YuTAYWvBXlAZ4hUFSVq6lyB08vzLvLGyie/OQiDoIIpy6gIQH/S5qf2
         mBmO11DAari+dORa3JoE3R8OpBNT8d92iYZAYPbJkEE6lxmGBM1zjp8rq8FaatXX0TYS
         ThYnzh+/ToFl1+wGQ5kJB74aATMxacK84VP9xBYCWeKHaUykPUWnroali722F4DV3ISR
         ehhl15XYfrGc6vXpvjKCH///yz4LcGQubUojm7zXhNEYU/e2G77UiGM3uJFntI+GVmpK
         C6a1XOgoEHOhAgw1iYuGqHbxYYNyKxbg3JTYUgzfrPKBqDf0/El1HptiD8EkdLWs/Lms
         Tn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753457737; x=1754062537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk/4Kezo0VhjUc+1VwBBR6iAeqx6TFxLUBENU2vrQBA=;
        b=agZgIQR2HDkenjpgrRMfrnNv056wIYq80n5Rfj0bKaxuRqYM+tNlvVi116c/pSUVO2
         NK6sfJhK7KLYhPHTY0C6HJcyFQbCs8ZkwU51ZEmDCmDJgdb3Rbvhu8v6Uo/tbLYjOrYt
         Y47Nb5EKiwzAVaZc3wSnlwV9GfLBh88KgPb2cRgcd35wVD1XlqwzHXokBub85viDAoJ3
         SfRyQA4Ne76a/SenLDkGBgI8/fBb0J2pwp0xVSsGhEtQNdmzgDLvJG503oe2P3ghOdii
         KeufsTWlKDUviEJVxcqWw6LUqfKLpIcsmMTAi5Hx5L4k9zn/GEWZWvPNNQBQ7zerL1Ny
         V+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFj+A1RFsFvZaXffK8O+4kpjWHJtnG0TvRIriyJIhCqsMbQSi4/BcsZHfV9WwppiGEPeyySyLltqFkFDXk@vger.kernel.org, AJvYcCXbs6aCg478NvtAq9OdjKqMzRQi/jlVrT1osmw0iaCGlt6keruqrr7sX9eiUPJcYZJB4U3Y8uIkGIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+5FMDGVGqAx7oBYK2FKIoBthubjv09IGJg1QrmQ9LvOSVL+b
	c6I97dwvFpOkc2nrqDrlzLSKdsUD33fBchhDXrDAYShMhcR8MCktLWNn
X-Gm-Gg: ASbGncvvic+DDIkzgd6URiLGLIkuL1/x0pACDWIBZSCtSrR6fIMtxGUUWg8WTTuigf8
	XvlnE5NMceLP8QRwo6wvHV4Ld0ltcYp3hPlvWxdD1pfYfCLl+np5YYSQNVSuRLpmhvfQLjrxTSA
	bXTaEDPcsxQXMcLD++Qw/njYW2QdsOyv6nV6rlBRHObmQzUXAnYpNV7X8IG4OYJlFLRXJYDVill
	azkHMpfkXuaEFx3mkHox7fiv5S/m/1m7ijKZ4XlGKaWTEqNToYaGMPigF/h79vcG/t7SIEMgKUv
	2ysbyme/5HN4ruqo6qjGbRkMgm4q4OF8D03vQ5vH+0hYUMK9EE4/J4HuBw0j1Vj7MkagMls4XUI
	3PXe3B7Hjp2q9VkB+CzrriQ==
X-Google-Smtp-Source: AGHT+IGA0cG23R/PV0mw3LDx6GRbWc3e50pWW1kDUupFgJn9GdN+u8pGDk/hv6p6XEa1GLMUY2uYUg==
X-Received: by 2002:a17:90b:3d4e:b0:311:ff18:b83e with SMTP id 98e67ed59e1d1-31e77857876mr3896921a91.9.1753457736696;
        Fri, 25 Jul 2025 08:35:36 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6e3b7e0dsm2400980a91.12.2025.07.25.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:35:35 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:35:32 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ste_dma40: simplify d40_handle_interrupt()
Message-ID: <aIOkRHs2bCVk28V0@yury>
References: <20250720022129.437094-1-yury.norov@gmail.com>
 <aIDRpSN0z3Ri1Fkh@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIDRpSN0z3Ri1Fkh@vaman>

On Wed, Jul 23, 2025 at 05:42:21PM +0530, Vinod Koul wrote:
> On 19-07-25, 22:21, Yury Norov wrote:
> > From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> What is the meaning of NVIDIA in your name?

My employer.
 
> Pls add the subsystem name to the patch as well (this and others you
> sent)

OK

