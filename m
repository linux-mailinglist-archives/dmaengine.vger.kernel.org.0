Return-Path: <dmaengine+bounces-2838-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A9C94DE88
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 22:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DABA2818B6
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1413D50C;
	Sat, 10 Aug 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTSNY6a3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B313BC25;
	Sat, 10 Aug 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723321368; cv=none; b=Uj66+XES7lzE5/xGcR3Qd/kvhi1ORwotKi+ytaOjgChBPCJA05mByoQCotRcFU0Y4PuR7JmWSHxB/AVginC3dYluStGLQyI6uLKtLLb7QQg8kQU2p7Z7sb4ZiNxXJ5g9lazlmuBHwPgG/lgLfD8bwm6Cj+PCheutori/nZ7b3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723321368; c=relaxed/simple;
	bh=/j89L6KYe6L4J70i8v/7BBv1Mtrp3axIEBNw1CLOiag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0tBAgrDGp17gRXZ74IS/vIVagO9MCUwIw4XlaNfD2EOOpqoL3qfrNGRfn54Xy6K1KLJinoNG9+sdkE1MFmBFkFtEybU9Llm4EGGQ72jGBgczFeIGMP+Fs1cILc/Si9OerkSE21/dNqO/hdNIY6i3lOJw9yl73TrxEq0Q16lo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTSNY6a3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280ac10b7cso527625e9.3;
        Sat, 10 Aug 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723321365; x=1723926165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WJSTsrRx4oJOBIrrFDvG+VDw/7Lzat/H74w3iZbcYY=;
        b=DTSNY6a3qDBA86MtP03hdx3GhVw4jDVQEpDu114UyTlD12rsWKxTuMr/Rf4Gi4AVi4
         /wIY2PDF/69UzNkBhGKk471klmSWK1sVpvQbGvEU9ZNgnWVkaEd95dWoKIq8G+0SbNOC
         InJAUttT0C4aMD/BsoMfTj3K+oaXmVyKF6Fpefc00ZJg0GzpL/1gQ+N/oFRNhwdOw60X
         MvOB2phzC4B7JDy2fDCjlHGuQ09Km1X/RDTsuqtSF/UtDyYdqRn3vPRlRzZwek8lKKvg
         459MmaqL73X6p4P85BTDFC1fyocpcemLs9ZFlxj1D0xGuKLibgTMKeq2UWWMCCmhVIjF
         z6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723321365; x=1723926165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WJSTsrRx4oJOBIrrFDvG+VDw/7Lzat/H74w3iZbcYY=;
        b=mLXBDjv5A+k478UWIxJ5cs1W2+vgHGphkKpMLBn+aTBD3BqQR50DUUYIWP9pqFYseG
         msIn9+0yP6Q2h+3MjxvyIBXV+10EF6VIlryow/xsoC2Y+wIA+vOHz0J47wX0UqcHJwZd
         aGcTBxb+IADjmssVQXcp70Pm7OsJptuveGUhhJwB6cWJnmbQ1XouNNBjz6iGgKUR1hJO
         CIEvA651lNMpQz5NlEjfXc89g46Uj/fGW6pU+KDuVoGC1UhWXGlxP9tOzHfHaCbJK6Cv
         d/N0EbmLal34GmtnL0NWpK2bXk2Bv9ozLwm4YFVW1Jc6VgULQLWV4S4MuEJwcn6hqm4t
         aBUA==
X-Forwarded-Encrypted: i=1; AJvYcCUeUMWGP76OeoI2oXHEkyQ5Ym1n8f8Vv2eCluVO+8jOG+k7t7ua9s8FPy+Ywp8vo/ljdxXLqxyrsJM=@vger.kernel.org, AJvYcCWh4SvuIC5atIhjKMeokGgRlpwnE4PAeqz2MkXHsi01QkdHVYIZkXUvFmaoaC6MvkpRlMIoUDPJWDkQ@vger.kernel.org, AJvYcCWxALeKK2l7eDeiMMcUm0ZvEmFzlmCZvx87eO8D9H8zHtENPpPIUiTFDrxYjZ4xRREataK0xB3jD9Vh@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgKpQ6HKTQbmgOFd/iWODmuRDAVWzJ/Jo3OuxL9Bi6sF9fClO
	pb+upyQ8Ohzl0UaiVwJR9cCpkotBSY21l+0PfqY6CNQglinRHP9E
X-Google-Smtp-Source: AGHT+IEFvhofB7r3PhdUBPxijlHgCD185WeOwLiwycpKBfUT6KYKDMx2W/FJx+S6yBZiVtGR8cfehQ==
X-Received: by 2002:a05:600c:3ca4:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-429c3a22819mr23707355e9.1.1723321364976;
        Sat, 10 Aug 2024 13:22:44 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:5ef1:c6e:2781:5ec2? ([2a01:4b00:d20e:7300:5ef1:c6e:2781:5ec2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd33ffsm3198299f8f.99.2024.08.10.13.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 13:22:44 -0700 (PDT)
Message-ID: <13beb34b-3ff7-4b88-876f-0a7f65254970@gmail.com>
Date: Sat, 10 Aug 2024 21:22:43 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Fix spelling mistakes
To: Amit Vadhavana <av2082000@gmail.com>, linux-doc@vger.kernel.org,
 ricardo@marliere.net
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 amelie.delaunay@foss.st.com, corbet@lwn.net, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 naveen@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, conor.dooley@microchip.com, costa.shul@redhat.com,
 dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, workflows@vger.kernel.org
References: <20240810183238.34481-1-av2082000@gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240810183238.34481-1-av2082000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/24 19:32, Amit Vadhavana wrote:
> Corrected spelling mistakes in the documentation to improve readability.
> 

Hi Amit,

Since this patch contains changes for multiple files from different 
subsystems, it should be divided into file-specific changes (so you have 
one patch per updated file).

-- 
Kind regards,
Ivan Orlov

