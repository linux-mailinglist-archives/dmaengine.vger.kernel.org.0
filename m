Return-Path: <dmaengine+bounces-988-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A7984F145
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 09:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF9C1F249CB
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 08:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859A657BD;
	Fri,  9 Feb 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b="Gqbyp6VY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED456B89
	for <dmaengine@vger.kernel.org>; Fri,  9 Feb 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466585; cv=none; b=NkAgToTi60eD6INiRfaCjZMr0bb7kakimBhbR9o7lwmQr1nsEhKoekmKPjyMiKRPdXVIhOjm4CY0/+trKsZQoNSs3P3Rh1e8d7HyJTnsY++/qPjWdOBs6D3zUon8nC8Lkp1dIoPtehbYOMuNrVnipWWUqqhbHknWm6sLRpMwRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466585; c=relaxed/simple;
	bh=zob0PpMY2d8n82gawhjb6dg8g/2o1MFbYDg1mK8goqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTqkXzwPBOkW5ZAA658qFUJLAx6bUFNFSgsiwZCZwYSMsPHHpV4btn8kMje6beXVHPmV28LlE7FhONIWosxIaxP8U3aeGlRisN4mLL9V7F37yzMn6RT5Zaj96zR7TQhsaCZPQrVyVVX6oXcIRqAVEQ6qjJqAslVcSnm52Rukf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com; spf=pass smtp.mailfrom=gigaio.com; dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b=Gqbyp6VY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigaio.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso904387a12.0
        for <dmaengine@vger.kernel.org>; Fri, 09 Feb 2024 00:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20230601.gappssmtp.com; s=20230601; t=1707466581; x=1708071381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3V+wXAqiHixIfTUYs8JQvGWDRc7BZjDQdODziqTfPzU=;
        b=Gqbyp6VYud5V2P/huZ5yO2szfTh0ArwxdbeB+RXrynBw7alK24js4A/HCVvcRi2c1m
         86mkPNJ87CvX6qip4hqAkNjxTdUaKXV+rzl6DSwMUGv33hozE94EsNHRqRsnuL+w169r
         zc2PCfxwtdb+KaPdO4B/yPuZmVUcJKgU1dwf5JUCQc3lkS9MTOb2+BneqxzflPbh/ivJ
         kT2xCpZ90FrmlaLlZDpyVriLdpoctRHdWFPUxAQeJ9mLmybbQHzvWBsjJ1UpVWqF2JcE
         smb+tvvMKRZYXFxKDyMnJC7LJAFd4IF0ArTuz4ZTe1IA7cOl85XhZ5XkYf3GKkt5QQnh
         LnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707466581; x=1708071381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3V+wXAqiHixIfTUYs8JQvGWDRc7BZjDQdODziqTfPzU=;
        b=uf62KdZ+yl9IzaXVKL03dGmt7dDJr/n1LAjYaD2OGTNg83CBfwfhZoeUJG6TIrOwKw
         lt9Vzr3fC/fR18kv7mIpmbqIX2gaMoXimcKwnwtyWE0f7VAgJ3cRIRHOTPCoCQ9qzFrZ
         mCXTkLvtLB9+Mj0tKBU3Q/ydoZZrRHRMUl7IBQx/d6ts3AJ5P5kCmaTOfYP4e4D/CzzG
         jWeVy9H9arkFYiSAmvBkPYgDIvOTY0Wpty2a1FIpzxthDTVi+Ke4GpxWz5vpcukcBCDT
         R2MSzdbv9egnedhDDbBKB4259mFQx7Asitt0b/RPNhjOxDCyK8ImFr84gxtIno7Idr+h
         lfrw==
X-Gm-Message-State: AOJu0YxRO0S6AWLn3xvgx0QYpfWifhl4fdgRRLyRkBKiXLOj/qh4IaWH
	8O0WUatZdtnsfCRNGra3QdRDa4iNszwwON1DNRRF7oKN+tafDHyLDcbqicCyv2I=
X-Google-Smtp-Source: AGHT+IHearlQSuku3V98oBAatvyfhPHa7Mg2JPdbgti28T0EdSt088p3/0FtfyZVGNKLkpnkznn/ew==
X-Received: by 2002:a05:6402:505:b0:560:bea6:50c9 with SMTP id m5-20020a056402050500b00560bea650c9mr708473edv.14.1707466581452;
        Fri, 09 Feb 2024 00:16:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlIEp95Z8028hnT2u5XHfJGZiVluiboUdHlLdVFgBsJGv7XRFHFZ6Z/fmRGenydPvWb231D0sCP9StY0ANED3x9OKNR9sDCX0Mxztle3pz7GGZodJVeP6UJBhsP5cF6snITutqClXJqDuGVbfMkwzJWQtPU70PB8qJUySYKdlJVd4z+YDpSkWXo/pGsUjtFQbN9ar0A8xpZAeBI2D4Lic=
Received: from [10.0.0.11] ([46.151.19.162])
        by smtp.gmail.com with ESMTPSA id et11-20020a056402378b00b0056058f2603asm544323edb.3.2024.02.09.00.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 00:16:21 -0800 (PST)
Message-ID: <8248b074-d323-44a4-bd78-dd66e4beb7b6@gigaio.com>
Date: Fri, 9 Feb 2024 09:16:20 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using PTDMA driver for generic DMA
To: Raju Rangoju <Raju.Rangoju@amd.com>, Sanjay R Mehta
 <sanju.mehta@amd.com>, Gary R Hook <gary.hook@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: dmaengine@vger.kernel.org, Eric Pilmore <epilmore@gigaio.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
References: <1f0cdf3c-be91-427f-86eb-4982de13e446@gigaio.com>
 <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
Content-Language: en-US
From: Tadeusz Struk <tstruk@gigaio.com>
In-Reply-To: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Raju,
On 2/7/24 14:26, Raju Rangoju wrote:
> Hello Tadeusz,
> 
> Sorry for the delay in response.
> 
> The "ERR 39: ODMA0_AXI_DECERR" is a Decode Error relating to destination.

Could you please send a patch that adds short comments explaining these 
error codes similar to this one?

Thanks and regards,
Tadeusz

